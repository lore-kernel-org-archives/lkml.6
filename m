Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752923AbeBFJz6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:55:58 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:27950 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752678AbeBFJx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:53:26 -0500
X-UUID: 230c5455847341a687e34d13c47706fd-20180206
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        RogerCC Lin <rogercc.lin@mediatek.com>,
        Guochun Mao <guochun.mao@mediatek.com>
Subject: [PATCH v2 09/16] arm64: dts: mt7622: add flash related device nodes
Date: Tue, 6 Feb 2018 17:52:58 +0800
Message-ID: <c2e9935388a785f70ad1e0dbc2fe1525bd921ef4.1517910489.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1517910489.git.sean.wang@mediatek.com>
References: <cover.1517910489.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

add nodes for NOR flash, parallel Nand flash with error correction code
support.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: RogerCC Lin <rogercc.lin@mediatek.com>
Cc: Guochun Mao <guochun.mao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 21 +++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 34 ++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 2a2247b..59a9c36 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -235,6 +235,10 @@
 	};
 };
 
+&bch {
+	status = "disabled";
+};
+
 &btif {
 	status = "okay";
 };
@@ -257,6 +261,23 @@
 	status = "okay";
 };
 
+&nandc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&parallel_nand_pins>;
+	status = "disabled";
+};
+
+&nor_flash {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_nor_pins>;
+	status = "disabled";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+	};
+};
+
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm7_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 2330ddc..9e11baf 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -395,6 +395,40 @@
 		status = "disabled";
 	};
 
+	nandc: nfi@1100d000 {
+		compatible = "mediatek,mt7622-nfc";
+		reg = <0 0x1100D000 0 0x1000>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_NFI_PD>,
+			 <&pericfg CLK_PERI_SNFI_PD>;
+		clock-names = "nfi_clk", "pad_clk";
+		ecc-engine = <&bch>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	bch: ecc@1100e000 {
+		compatible = "mediatek,mt7622-ecc";
+		reg = <0 0x1100e000 0 0x1000>;
+		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_NFIECC_PD>;
+		clock-names = "nfiecc_clk";
+		status = "disabled";
+	};
+
+	nor_flash: spi@11014000 {
+		compatible = "mediatek,mt7622-nor",
+			     "mediatek,mt8173-nor";
+		reg = <0 0x11014000 0 0xe0>;
+		clocks = <&pericfg CLK_PERI_FLASH_PD>,
+			 <&topckgen CLK_TOP_FLASH_SEL>;
+		clock-names = "spi", "sf";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	spi1: spi@11016000 {
 		compatible = "mediatek,mt7622-spi";
 		reg = <0 0x11016000 0 0x100>;
-- 
2.7.4
