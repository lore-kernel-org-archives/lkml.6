Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeBQTzi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:55:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:14702 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751318AbeBQTzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:55:10 -0500
X-UUID: 81ea3f9a049a4296bbbe0c7030aa0412-20180218
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Jimin Wang <jimin.wang@mediatek.com>
Subject: [PATCH v3 15/15] arm64: dts: mt7622: add mmc related device nodes
Date: Sun, 18 Feb 2018 03:54:50 +0800
Message-ID: <b03773a952b3212a510d4466e0a39dbe2554788b.1518895232.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

add mmc device nodes and proper setup for used pins

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Jimin Wang <jimin.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 106 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     |  20 +++++
 2 files changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index cc89e2e..45d8655 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
 
 #include "mt7622.dtsi"
 #include "mt6380.dtsi"
@@ -53,6 +54,14 @@
 		reg = <0 0x40000000 0 0x3F000000>;
 	};
 
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
@@ -89,6 +98,23 @@
 			function = "emmc", "emmc_rst";
 			groups = "emmc";
 		};
+
+		/* "NDL0","NDL1","NDL2","NDL3","NDL4","NDL5","NDL6","NDL7",
+		 * "NRB","NCLE" pins are used as DAT0,DAT1,DAT2,DAT3,DAT4,
+		 * DAT5,DAT6,DAT7,CMD,CLK for eMMC respectively
+		 */
+		conf-cmd-dat {
+			pins = "NDL0", "NDL1", "NDL2",
+			       "NDL3", "NDL4", "NDL5",
+			       "NDL6", "NDL7", "NRB";
+			input-enable;
+			bias-pull-up;
+		};
+
+		conf-clk {
+			pins = "NCLE";
+			bias-pull-down;
+		};
 	};
 
 	emmc_pins_uhs: emmc-pins-uhs {
@@ -96,6 +122,21 @@
 			function = "emmc";
 			groups = "emmc";
 		};
+
+		conf-cmd-dat {
+			pins = "NDL0", "NDL1", "NDL2",
+			       "NDL3", "NDL4", "NDL5",
+			       "NDL6", "NDL7", "NRB";
+			input-enable;
+			drive-strength = <4>;
+			bias-pull-up;
+		};
+
+		conf-clk {
+			pins = "NCLE";
+			drive-strength = <4>;
+			bias-pull-down;
+		};
 	};
 
 	eth_pins: eth-pins {
@@ -194,6 +235,27 @@
 			function = "sd";
 			groups = "sd_0";
 		};
+
+		/* "I2S2_OUT, "I2S4_IN"", "I2S3_IN", "I2S2_IN",
+		 *  "I2S4_OUT", "I2S3_OUT" are used as DAT0, DAT1,
+		 *  DAT2, DAT3, CMD, CLK for SD respectively.
+		 */
+		conf-cmd-data {
+			pins = "I2S2_OUT", "I2S4_IN", "I2S3_IN",
+			       "I2S2_IN","I2S4_OUT";
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+		conf-clk {
+			pins = "I2S3_OUT";
+			drive-strength = <12>;
+			bias-pull-down;
+		};
+		conf-cd {
+			pins = "TXD3";
+			bias-pull-up;
+		};
 	};
 
 	sd0_pins_uhs: sd0-pins-uhs {
@@ -201,6 +263,18 @@
 			function = "sd";
 			groups = "sd_0";
 		};
+
+		conf-cmd-data {
+			pins = "I2S2_OUT", "I2S4_IN", "I2S3_IN",
+			       "I2S2_IN","I2S4_OUT";
+			input-enable;
+			bias-pull-up;
+		};
+
+		conf-clk {
+			pins = "I2S3_OUT";
+			bias-pull-down;
+		};
 	};
 
 	/* Serial NAND is shared pin with SPI-NOR */
@@ -311,6 +385,38 @@
 	status = "okay";
 };
 
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&emmc_pins_default>;
+	pinctrl-1 = <&emmc_pins_uhs>;
+	status = "okay";
+	bus-width = <8>;
+	max-frequency = <50000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	assigned-clocks = <&topckgen CLK_TOP_MSDC30_0_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
+	non-removable;
+};
+
+&mmc1 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&sd0_pins_default>;
+	pinctrl-1 = <&sd0_pins_uhs>;
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	cap-sd-highspeed;
+	r_smpl = <1>;
+	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
+};
+
 &nandc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&parallel_nand_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index ffb934b..0f1ebddd 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -527,6 +527,26 @@
 		status = "disabled";
 	};
 
+	mmc0: mmc@11230000 {
+		compatible = "mediatek,mt7622-mmc";
+		reg = <0 0x11230000 0 0x1000>;
+		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_MSDC30_0_PD>,
+			 <&topckgen CLK_TOP_MSDC50_0_SEL>;
+		clock-names = "source", "hclk";
+		status = "disabled";
+	};
+
+	mmc1: mmc@11240000 {
+		compatible = "mediatek,mt7622-mmc";
+		reg = <0 0x11240000 0 0x1000>;
+		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_MSDC30_1_PD>,
+			 <&topckgen CLK_TOP_AXI_SEL>;
+		clock-names = "source", "hclk";
+		status = "disabled";
+	};
+
 	ssusbsys: ssusbsys@1a000000 {
 		compatible = "mediatek,mt7622-ssusbsys",
 			     "syscon";
-- 
2.7.4
