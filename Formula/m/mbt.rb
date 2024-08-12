class Mbt < Formula
  desc "Multi-Target Application (MTA) build tool for Cloud Applications"
  homepage "https://sap.github.io/cloud-mta-build-tool"
  url "https://github.com/SAP/cloud-mta-build-tool/archive/refs/tags/v1.2.31.tar.gz"
  sha256 "b4d7d8a226728cd73d34b5f3255cbe6b745ad920daaff3f5c0265bcb688e7818"
  license "Apache-2.0"
  head "https://github.com/SAP/cloud-mta-build-tool.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9efd96867d4596f525959e82728ca19f4a09ad202c9ee6127afd18c76e2cb8f6"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "13a98e49a80e2c914262196af0123c6b1d8a4d083720afb3b108c125884615c8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "843c51d425869363dde25c7b3700759b18ca66a0b06ab5e801b04154bdd7a531"
    sha256 cellar: :any_skip_relocation, sonoma:         "cb3d94d357f002c9a18bbe130d1f641493901fd003a3cf7a15e22a91c9f9d023"
    sha256 cellar: :any_skip_relocation, ventura:        "5c21d937f15ebf6fbedeb801a87be9327a91c809730697a0af0d0578027739d8"
    sha256 cellar: :any_skip_relocation, monterey:       "803fea406f72a6cb9666da920dccf04496f5a876548097bfb3e02e4b6041ff83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8777ce261e736fa09272a4a371e6888fbf717e9371082ec5f06808384448d01d"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[ -s -w -X main.Version=#{version}
                  -X main.BuildDate=#{time.iso8601} ]
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    assert_match(/generating the "Makefile_\d+.mta" file/, shell_output("#{bin}/mbt build", 1))
    assert_match("Cloud MTA Build Tool", shell_output("#{bin}/mbt --version"))
  end
end
