Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeBWKRz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:17:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43407 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751638AbeBWKQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:58 -0500
X-UUID: 4ada9ed274874eb2b7231a046f16d488-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 14/19] arm: dts: mt7623: extend common file to unify all boards with MT7623 SoCs
Date: Fri, 23 Feb 2018 18:16:34 +0800
Message-ID: <0be1076cce06fcd61a9b6723144bdf66444ef11d.1519378872.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

In fact, bananapi-r2 board is derived and customized from the official
MT7623N reference board with eMMC.

In order to introduce more boards such as official MT7623A reference
boards to current devicetree without copy-n-pasting the almost same
content of nodes into every new file, it's better to reuse those nodes
by consolidating them into common files mt7623n-rfb.dtsi from
mt7623n-bananapi-bpi-r2.dts and allow existing or new .dts files to refer
to them.

After grouping those common nodes into mt7623n-rfb.dtsi, it becomes more
simple to know what differences are between each board from terminal .dts
such that bananapi-r2 uses eMMC as the primary storage, has the dedicated
GPIO LEDs, and I2C1 working through pin 57 and 58 as the pin-usage,
enables the second USB slot and owns its definition for each switch port
against the existing mt7623n-rfb-nand.dts.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 467 +--------------------
 arch/arm/boot/dts/mt7623n-rfb-nand.dts        |  91 +---
 arch/arm/boot/dts/mt7623n-rfb.dtsi            | 570 +++++++++++++++++++++++++-
 3 files changed, 575 insertions(+), 553 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 767b225..373a0dd 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -5,83 +5,14 @@
  */
 
 /dts-v1/;
-#include <dt-bindings/input/input.h>
-#include "mt7623.dtsi"
-#include "mt6323.dtsi"
+#include "mt7623n-rfb.dtsi"
 
 / {
 	model = "Bananapi BPI-R2";
 	compatible = "bananapi,bpi-r2", "mediatek,mt7623";
 
-	aliases {
-		serial2 = &uart2;
-	};
-
 	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-
-	cpus {
-		cpu@0 {
-			proc-supply = <&mt6323_vproc_reg>;
-		};
-
-		cpu@1 {
-			proc-supply = <&mt6323_vproc_reg>;
-		};
-
-		cpu@2 {
-			proc-supply = <&mt6323_vproc_reg>;
-		};
-
-		cpu@3 {
-			proc-supply = <&mt6323_vproc_reg>;
-		};
-	};
-
-	reg_1p8v: regulator-1p8v {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	reg_3p3v: regulator-3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	reg_5v: regulator-5v {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-5V";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&key_pins_a>;
-
-		factory {
-			label = "factory";
-			linux,code = <BTN_0>;
-			gpios = <&pio 256 GPIO_ACTIVE_LOW>;
-		};
-
-		wps {
-			label = "wps";
-			linux,code = <KEY_WPS_BUTTON>;
-			gpios = <&pio 257 GPIO_ACTIVE_HIGH>;
-		};
+		bootargs = "console=ttyS2,115200n8 earlyprintk";
 	};
 
 	leds {
@@ -107,215 +38,38 @@
 			default-state = "off";
 		};
 	};
-
-	memory@80000000 {
-		reg = <0 0x80000000 0 0x40000000>;
-	};
-};
-
-&btif {
-	status = "okay";
-};
-
-&cir {
-	pinctrl-names = "default";
-	pinctrl-0 = <&cir_pins_a>;
-	status = "okay";
-};
-
-&crypto {
-	status = "okay";
-};
-
-&eth {
-	status = "okay";
-
-	gmac0: mac@0 {
-		compatible = "mediatek,eth-mac";
-		reg = <0>;
-		phy-mode = "trgmii";
-
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-			pause;
-		};
-	};
-
-	mdio: mdio-bus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		switch@0 {
-			compatible = "mediatek,mt7530";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-			reset-gpios = <&pio 33 0>;
-			core-supply = <&mt6323_vpa_reg>;
-			io-supply = <&mt6323_vemc3v3_reg>;
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					label = "wan";
-				};
-
-				port@1 {
-					reg = <1>;
-					label = "lan0";
-				};
-
-				port@2 {
-					reg = <2>;
-					label = "lan1";
-				};
-
-				port@3 {
-					reg = <3>;
-					label = "lan2";
-				};
-
-				port@4 {
-					reg = <4>;
-					label = "lan3";
-				};
-
-				port@6 {
-					reg = <6>;
-					label = "cpu";
-					ethernet = <&gmac0>;
-					phy-mode = "trgmii";
-
-					fixed-link {
-						speed = <1000>;
-						full-duplex;
-					};
-				};
-			};
-		};
-	};
-};
-
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
-	status = "okay";
 };
 
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins_a>;
-	status = "okay";
 };
 
 &mmc0 {
-	pinctrl-names = "default", "state_uhs";
-	pinctrl-0 = <&mmc0_pins_default>;
-	pinctrl-1 = <&mmc0_pins_uhs>;
 	status = "okay";
-	bus-width = <8>;
-	max-frequency = <50000000>;
-	cap-mmc-highspeed;
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_1p8v>;
-	non-removable;
 };
 
-&mmc1 {
-	pinctrl-names = "default", "state_uhs";
-	pinctrl-0 = <&mmc1_pins_default>;
-	pinctrl-1 = <&mmc1_pins_uhs>;
-	status = "okay";
-	bus-width = <4>;
-	max-frequency = <50000000>;
-	cap-sd-highspeed;
-	cd-gpios = <&pio 261 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_3p3v>;
+&mt7530p0 {
+	label = "wan";
 };
 
-&pcie {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_default>;
-	status = "okay";
-
-	pcie@0,0 {
-		status = "okay";
-	};
+&mt7530p1 {
+	label = "lan0";
+};
 
-	pcie@1,0 {
-		status = "okay";
-	};
+&mt7530p2 {
+	label = "lan1";
 };
 
-&pcie0_phy {
-	status = "okay";
+&mt7530p3 {
+	label = "lan2";
 };
 
-&pcie1_phy {
-	status = "okay";
+&mt7530p4 {
+	label = "lan3";
 };
 
 &pio {
-	cir_pins_a:cir-default {
-		pins-cir {
-			pinmux = <MT7623_PIN_46_IR_FUNC_IR>;
-			bias-disable;
-		};
-	};
-
-	i2c0_pins_a: i2c0-default {
-		pins-i2c0 {
-			pinmux = <MT7623_PIN_75_SDA0_FUNC_SDA0>,
-				 <MT7623_PIN_76_SCL0_FUNC_SCL0>;
-			bias-disable;
-		};
-	};
-
-	i2c1_pins_a: i2c1-default {
-		pin-i2c1 {
-			pinmux = <MT7623_PIN_57_SDA1_FUNC_SDA1>,
-				 <MT7623_PIN_58_SCL1_FUNC_SCL1>;
-			bias-disable;
-		};
-	};
-
-	i2s0_pins_a: i2s0-default {
-		pin-i2s0 {
-			pinmux = <MT7623_PIN_49_I2S0_DATA_FUNC_I2S0_DATA>,
-				 <MT7623_PIN_72_I2S0_DATA_IN_FUNC_I2S0_DATA_IN>,
-				 <MT7623_PIN_73_I2S0_LRCK_FUNC_I2S0_LRCK>,
-				 <MT7623_PIN_74_I2S0_BCK_FUNC_I2S0_BCK>,
-				 <MT7623_PIN_126_I2S0_MCLK_FUNC_I2S0_MCLK>;
-			drive-strength = <MTK_DRIVE_12mA>;
-			bias-pull-down;
-		};
-	};
-
-	i2s1_pins_b: i2s1-default {
-		pin-i2s1 {
-			pinmux = <MT7623_PIN_33_I2S1_DATA_FUNC_I2S1_DATA>,
-				 <MT7623_PIN_34_I2S1_DATA_IN_FUNC_I2S1_DATA_IN>,
-				 <MT7623_PIN_35_I2S1_BCK_FUNC_I2S1_BCK>,
-				 <MT7623_PIN_36_I2S1_LRCK_FUNC_I2S1_LRCK>,
-				 <MT7623_PIN_37_I2S1_MCLK_FUNC_I2S1_MCLK>;
-			drive-strength = <MTK_DRIVE_12mA>;
-			bias-pull-down;
-		};
-	};
-
-	key_pins_a: keys-alt {
-		pins-keys {
-			pinmux = <MT7623_PIN_256_GPIO256_FUNC_GPIO256>,
-				 <MT7623_PIN_257_GPIO257_FUNC_GPIO257> ;
-			input-enable;
-		};
-	};
-
 	led_pins_a: leds-alt {
 		pins-leds {
 			pinmux = <MT7623_PIN_239_EXT_SDIO0_FUNC_GPIO239>,
@@ -323,207 +77,12 @@
 				 <MT7623_PIN_241_EXT_SCK_FUNC_GPIO241>;
 		};
 	};
-
-	mmc0_pins_default: mmc0default {
-		pins-cmd-dat {
-			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
-				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
-				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
-				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
-				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
-				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
-				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
-				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
-				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
-			input-enable;
-			bias-pull-up;
-		};
-
-		pins-clk {
-			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
-			bias-pull-down;
-		};
-
-		pins-rst {
-			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
-			bias-pull-up;
-		};
-	};
-
-	mmc0_pins_uhs: mmc0 {
-		pins-cmd-dat {
-			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
-				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
-				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
-				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
-				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
-				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
-				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
-				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
-				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_2mA>;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
-		};
-
-		pins-clk {
-			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
-			drive-strength = <MTK_DRIVE_2mA>;
-			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
-		};
-
-		pins-rst {
-			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
-			bias-pull-up;
-		};
-	};
-
-	mmc1_pins_default: mmc1default {
-		pins-cmd-dat {
-			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
-				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
-				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
-				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
-				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_4mA>;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
-		};
-
-		pins-clk {
-			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
-			bias-pull-down;
-			drive-strength = <MTK_DRIVE_4mA>;
-		};
-
-		pins-wp {
-			pinmux = <MT7623_PIN_29_EINT7_FUNC_MSDC1_WP>;
-			input-enable;
-			bias-pull-up;
-		};
-
-		pins-insert {
-			pinmux = <MT7623_PIN_261_MSDC1_INS_FUNC_GPIO261>;
-			bias-pull-up;
-		};
-	};
-
-	mmc1_pins_uhs: mmc1 {
-		pins-cmd-dat {
-			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
-				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
-				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
-				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
-				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_4mA>;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
-		};
-
-		pins-clk {
-			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
-			drive-strength = <MTK_DRIVE_4mA>;
-			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
-		};
-	};
-
-	pcie_default: pcie-pin-default {
-		pins-cmd-dat {
-			pinmux = <MT7623_PIN_208_AUD_EXT_CK1_FUNC_PCIE0_PERST_N>,
-				 <MT7623_PIN_209_AUD_EXT_CK2_FUNC_PCIE1_PERST_N>;
-			bias-disable;
-		};
-	};
-
-	pwm_pins_a: pwm-default {
-		pins-pwm {
-			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
-				 <MT7623_PIN_204_PWM1_FUNC_PWM1>,
-				 <MT7623_PIN_205_PWM2_FUNC_PWM2>,
-				 <MT7623_PIN_206_PWM3_FUNC_PWM3>,
-				 <MT7623_PIN_207_PWM4_FUNC_PWM4>;
-		};
-	};
-
-	spi0_pins_a: spi0-default {
-		pins-spi {
-			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
-				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
-				<MT7623_PIN_55_SPI0_MI_FUNC_SPI0_MI>,
-				<MT7623_PIN_56_SPI0_MO_FUNC_SPI0_MO>;
-			bias-disable;
-		};
-	};
-
-	uart0_pins_a: uart0-default {
-		pins-dat {
-			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
-				 <MT7623_PIN_80_UTXD0_FUNC_UTXD0>;
-		};
-	};
-
-	uart1_pins_a: uart1-default {
-		pins-dat {
-			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
-				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
-		};
-	};
-
-	uart2_pins_a: uart2-default {
-		pins-dat {
-			pinmux = <MT7623_PIN_14_GPIO14_FUNC_URXD2>,
-				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
-		};
-	};
-};
-
-&pwm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm_pins_a>;
-	status = "okay";
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins_a>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pins_a>;
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_a>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins_a>;
-	status = "okay";
-};
-
-&usb1 {
-	vusb33-supply = <&reg_3p3v>;
-	vbus-supply = <&reg_5v>;
-	status = "okay";
 };
 
 &usb2 {
-	vusb33-supply = <&reg_3p3v>;
-	vbus-supply = <&reg_5v>;
-	status = "okay";
-};
-
-&u3phy1 {
 	status = "okay";
 };
 
 &u3phy2 {
 	status = "okay";
 };
-
diff --git a/arch/arm/boot/dts/mt7623n-rfb-nand.dts b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
index f729c71..05f1171 100644
--- a/arch/arm/boot/dts/mt7623n-rfb-nand.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
@@ -1,6 +1,7 @@
 /*
- * Copyright (c) 2017 MediaTek Inc.
+ * Copyright (c) 2017-2018 MediaTek Inc.
  * Author: John Crispin <john@phrozen.org>
+ *	   Sean Wang <sean.wang@mediatek.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -16,8 +17,12 @@
 #include "mt7623n-rfb.dtsi"
 
 / {
-	model = "MediaTek MT7623N NAND reference board";
+	model = "MediaTek MT7623N with NAND reference board";
 	compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
+
+	chosen {
+		bootargs = "console=ttyS2,115200n8 earlyprintk";
+	};
 };
 
 &bch {
@@ -26,86 +31,4 @@
 
 &nandc {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&nand_pins_default>;
-
-	nand@0 {
-		reg = <0>;
-		spare_per_sector = <64>;
-		nand-ecc-mode = "hw";
-		nand-ecc-strength = <12>;
-		nand-ecc-step-size = <1024>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "preloader";
-				reg = <0x0 0x40000>;
-			};
-
-			partition@40000 {
-				label = "uboot";
-				reg = <0x40000 0x80000>;
-			};
-
-			partition@c0000 {
-				label = "uboot-env";
-				reg = <0xC0000 0x40000>;
-			};
-
-			partition@140000 {
-				label = "bootimg";
-				reg = <0x140000 0x2000000>;
-			};
-
-			partition@2140000 {
-				label = "recovery";
-				reg = <0x2140000 0x2000000>;
-			};
-
-			partition@4140000 {
-				label = "rootfs";
-				reg = <0x4140000 0x1000000>;
-			};
-
-			partition@5140000 {
-				label = "usrdata";
-				reg = <0x5140000 0x1000000>;
-			};
-		};
-	};
-};
-
-&pio {
-	nand_pins_default: nanddefault {
-		pins-ale {
-			pinmux = <MT7623_PIN_116_MSDC0_CMD_FUNC_NALE>;
-			drive-strength = <MTK_DRIVE_8mA>;
-			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
-		};
-
-		pins-dat {
-			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_NLD7>,
-				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_NLD6>,
-				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_NLD4>,
-				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_NLD3>,
-				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_NLD0>,
-				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_NLD1>,
-				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_NLD5>,
-				 <MT7623_PIN_115_MSDC0_RSTB_FUNC_NLD8>,
-				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_NLD2>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_8mA>;
-			bias-pull-up;
-		};
-
-		pins-we {
-			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_NWEB>;
-			drive-strength = <MTK_DRIVE_8mA>;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
index 128586d..b9e3b3d 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2017 MediaTek Inc.
+ * Copyright (c) 2017-2018 MediaTek Inc.
  * Author: John Crispin <john@phrozen.org>
  *	   Sean Wang <sean.wang@mediatek.com>
  *
@@ -14,6 +14,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include "mt7623.dtsi"
 #include "mt6323.dtsi"
 
@@ -29,64 +30,603 @@
 	};
 
 	cpus {
-		cpu0 {
+		cpu@0 {
 			proc-supply = <&mt6323_vproc_reg>;
 		};
 
-		cpu1 {
+		cpu@1 {
 			proc-supply = <&mt6323_vproc_reg>;
 		};
 
-		cpu2 {
+		cpu@2 {
 			proc-supply = <&mt6323_vproc_reg>;
 		};
 
-		cpu3 {
+		cpu@3 {
 			proc-supply = <&mt6323_vproc_reg>;
 		};
 	};
 
-	memory@80000000 {
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_pins_a>;
+
+		factory {
+			label = "factory";
+			linux,code = <BTN_0>;
+			gpios = <&pio 256 GPIO_ACTIVE_LOW>;
+		};
+
+		wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&pio 257 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 
-	usb_p1_vbus: regulator-5v {
+	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
-		regulator-name = "usb_vbus";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5V";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		gpio = <&pio 135 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&bch {
+	status = "disabled";
+};
+
+&btif {
+	status = "okay";
+};
+
+&cir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cir_pins_a>;
+	status = "okay";
+};
+
+&crypto {
+	status = "okay";
+};
+
+&eth {
+	status = "okay";
+
+	gmac0: mac@0 {
+		compatible = "mediatek,eth-mac";
+		reg = <0>;
+		phy-mode = "trgmii";
+
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+			pause;
+		};
+	};
+
+	mdio: mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mt7530: switch@0 {
+			compatible = "mediatek,mt7530";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			reset-gpios = <&pio 33 0>;
+			core-supply = <&mt6323_vpa_reg>;
+			io-supply = <&mt6323_vemc3v3_reg>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mt7530p0: port@0 {
+					reg = <0>;
+					label = "lan0";
+				};
+
+				mt7530p1: port@1 {
+					reg = <1>;
+					label = "lan1";
+				};
+
+				mt7530p2: port@2 {
+					reg = <2>;
+					label = "lan2";
+				};
+
+				mt7530p3: port@3 {
+					reg = <3>;
+					label = "lan3";
+				};
+
+				mt7530p4: port@4 {
+					reg = <4>;
+					label = "wan";
+				};
+
+				port@6 {
+					reg = <6>;
+					label = "cpu";
+					ethernet = <&gmac0>;
+					phy-mode = "trgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+			};
+		};
 	};
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_b>;
+	status = "okay";
+};
+
 &mmc0 {
-	vmmc-supply = <&mt6323_vemc3v3_reg>;
-	vqmmc-supply = <&mt6323_vio18_reg>;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	status = "disabled";
+	bus-width = <8>;
+	max-frequency = <50000000>;
+	cap-mmc-highspeed;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	non-removable;
 };
 
 &mmc1 {
-	vmmc-supply = <&mt6323_vmch_reg>;
-	vqmmc-supply = <&mt6323_vmc_reg>;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	cap-sd-highspeed;
+	cd-gpios = <&pio 261 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+};
+
+&nandc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_pins_default>;
+	status = "disabled";
+
+	nand@0 {
+		reg = <0>;
+		spare_per_sector = <64>;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <12>;
+		nand-ecc-step-size = <1024>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "preloader";
+				reg = <0x0 0x40000>;
+			};
+
+			partition@40000 {
+				label = "uboot";
+				reg = <0x40000 0x80000>;
+			};
+
+			partition@c0000 {
+				label = "uboot-env";
+				reg = <0xC0000 0x40000>;
+			};
+
+			partition@140000 {
+				label = "bootimg";
+				reg = <0x140000 0x2000000>;
+			};
+
+			partition@2140000 {
+				label = "recovery";
+				reg = <0x2140000 0x2000000>;
+			};
+
+			partition@4140000 {
+				label = "rootfs";
+				reg = <0x4140000 0x1000000>;
+			};
+
+			partition@5140000 {
+				label = "usrdata";
+				reg = <0x5140000 0x1000000>;
+			};
+		};
+	};
+};
+
+&nor_flash {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nor_pins_a>;
+	status = "disabled";
+	max-frequency = <50000000>;
+	non-removable;
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_default>;
+	status = "okay";
+
+	pcie0: pcie@0,0 {
+		status = "okay";
+	};
+
+	pcie1: pcie@1,0 {
+		status = "okay";
+	};
+};
+
+&pcie0_phy {
+	status = "okay";
+};
+
+&pcie1_phy {
+	status = "okay";
+};
+
+&pio {
+	cir_pins_a:cir-default {
+		pins-cir {
+			pinmux = <MT7623_PIN_46_IR_FUNC_IR>;
+			bias-disable;
+		};
+	};
+
+	i2c0_pins_a: i2c0-default {
+		pins-i2c0 {
+			pinmux = <MT7623_PIN_75_SDA0_FUNC_SDA0>,
+				 <MT7623_PIN_76_SCL0_FUNC_SCL0>;
+			bias-disable;
+		};
+	};
+
+	i2c1_pins_a: i2c1-default {
+		pin-i2c1 {
+			pinmux = <MT7623_PIN_57_SDA1_FUNC_SDA1>,
+				 <MT7623_PIN_58_SCL1_FUNC_SCL1>;
+			bias-disable;
+		};
+	};
+
+	i2c1_pins_b: i2c1-alt {
+		pin-i2c1 {
+			pinmux = <MT7623_PIN_242_URTS2_FUNC_SCL1>,
+				 <MT7623_PIN_243_UCTS2_FUNC_SDA1>;
+			bias-disable;
+		};
+	};
+
+	i2c2_pins_a: i2c2-default {
+		pin-i2c2 {
+			pinmux = <MT7623_PIN_77_SDA2_FUNC_SDA2>,
+				 <MT7623_PIN_78_SCL2_FUNC_SCL2>;
+			bias-disable;
+		};
+	};
+
+	i2s0_pins_a: i2s0-default {
+		pin-i2s0 {
+			pinmux = <MT7623_PIN_49_I2S0_DATA_FUNC_I2S0_DATA>,
+				 <MT7623_PIN_72_I2S0_DATA_IN_FUNC_I2S0_DATA_IN>,
+				 <MT7623_PIN_73_I2S0_LRCK_FUNC_I2S0_LRCK>,
+				 <MT7623_PIN_74_I2S0_BCK_FUNC_I2S0_BCK>,
+				 <MT7623_PIN_126_I2S0_MCLK_FUNC_I2S0_MCLK>;
+			drive-strength = <MTK_DRIVE_12mA>;
+			bias-pull-down;
+		};
+	};
+
+	i2s1_pins_b: i2s1-default {
+		pin-i2s1 {
+			pinmux = <MT7623_PIN_33_I2S1_DATA_FUNC_I2S1_DATA>,
+				 <MT7623_PIN_34_I2S1_DATA_IN_FUNC_I2S1_DATA_IN>,
+				 <MT7623_PIN_35_I2S1_BCK_FUNC_I2S1_BCK>,
+				 <MT7623_PIN_36_I2S1_LRCK_FUNC_I2S1_LRCK>,
+				 <MT7623_PIN_37_I2S1_MCLK_FUNC_I2S1_MCLK>;
+			drive-strength = <MTK_DRIVE_12mA>;
+			bias-pull-down;
+		};
+	};
+
+	key_pins_a: keys-alt {
+		pins-keys {
+			pinmux = <MT7623_PIN_256_GPIO256_FUNC_GPIO256>,
+				 <MT7623_PIN_257_GPIO257_FUNC_GPIO257> ;
+			input-enable;
+		};
+	};
+
+	mmc0_pins_default: mmc0-default {
+		pins-cmd-dat {
+			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
+				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
+				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
+				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
+				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
+				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
+				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
+				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
+				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-clk {
+			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
+			bias-pull-down;
+		};
+
+		pins-rst {
+			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs {
+		pins-cmd-dat {
+			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
+				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
+				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
+				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_MSDC0_DAT4>,
+				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_MSDC0_DAT3>,
+				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_MSDC0_DAT2>,
+				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_MSDC0_DAT1>,
+				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DAT0>,
+				 <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_2mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-rst {
+			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_default: mmc1-default {
+		pins-cmd-dat {
+			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
+				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
+				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
+				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
+				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-clk {
+			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
+			bias-pull-down;
+			drive-strength = <MTK_DRIVE_4mA>;
+		};
+
+		pins-wp {
+			pinmux = <MT7623_PIN_29_EINT7_FUNC_MSDC1_WP>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-insert {
+			pinmux = <MT7623_PIN_261_MSDC1_INS_FUNC_GPIO261>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1-uhs {
+		pins-cmd-dat {
+			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
+				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
+				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
+				 <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DAT3>,
+				 <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-clk {
+			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
+	nand_pins_default: nand-default {
+		pins-ale {
+			pinmux = <MT7623_PIN_116_MSDC0_CMD_FUNC_NALE>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-dat {
+			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_NLD7>,
+				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_NLD6>,
+				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_NLD4>,
+				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_NLD3>,
+				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_NLD0>,
+				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_NLD1>,
+				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_NLD5>,
+				 <MT7623_PIN_115_MSDC0_RSTB_FUNC_NLD8>,
+				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_NLD2>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+
+		pins-we {
+			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_NWEB>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+
+	nor_pins_a: nor-default {
+		pins1 {
+			pinmux = <MT7623_PIN_240_EXT_XCS_FUNC_EXT_XCS>,
+				 <MT7623_PIN_236_EXT_SDIO3_FUNC_EXT_SDIO3>,
+				 <MT7623_PIN_239_EXT_SDIO0_FUNC_EXT_SDIO0>,
+				 <MT7623_PIN_241_EXT_SCK_FUNC_EXT_SCK>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up;
+		};
+
+		pins2 {
+			pinmux = <MT7623_PIN_238_EXT_SDIO1_FUNC_EXT_SDIO1>,
+				 <MT7623_PIN_237_EXT_SDIO2_FUNC_EXT_SDIO2>;
+			drive-strength = <MTK_DRIVE_4mA>;
+			bias-pull-up;
+		};
+	};
+
+	pcie_default: pcie-pin-default {
+		pins-cmd-dat {
+			pinmux = <MT7623_PIN_208_AUD_EXT_CK1_FUNC_PCIE0_PERST_N>,
+				 <MT7623_PIN_209_AUD_EXT_CK2_FUNC_PCIE1_PERST_N>;
+			bias-disable;
+		};
+	};
+
+	pwm_pins_a: pwm-default {
+		pins-pwm {
+			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
+				 <MT7623_PIN_204_PWM1_FUNC_PWM1>,
+				 <MT7623_PIN_205_PWM2_FUNC_PWM2>,
+				 <MT7623_PIN_206_PWM3_FUNC_PWM3>,
+				 <MT7623_PIN_207_PWM4_FUNC_PWM4>;
+		};
+	};
+
+	spi0_pins_a: spi0-default {
+		pins-spi {
+			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
+				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
+				<MT7623_PIN_55_SPI0_MI_FUNC_SPI0_MI>,
+				<MT7623_PIN_56_SPI0_MO_FUNC_SPI0_MO>;
+			bias-disable;
+		};
+	};
+
+	uart0_pins_a: uart0-default {
+		pins-dat {
+			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
+				 <MT7623_PIN_80_UTXD0_FUNC_UTXD0>;
+		};
+	};
+
+	uart1_pins_a: uart1-default {
+		pins-dat {
+			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
+				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
+		};
+	};
+
+	uart2_pins_a: uart2-default {
+		pins-dat {
+			pinmux = <MT7623_PIN_14_GPIO14_FUNC_URXD2>,
+				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
+		};
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_pins_a>;
+	status = "okay";
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_a>;
+	status = "okay";
 };
 
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
 	status = "okay";
 };
 
 &uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_a>;
 	status = "okay";
 };
 
 &uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins_a>;
 	status = "okay";
 };
 
 &usb1 {
-	vbus-supply = <&usb_p1_vbus>;
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
 	status = "okay";
 };
 
+&usb2 {
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
+	status = "disabled";
+};
+
 &u3phy1 {
 	status = "okay";
 };
-- 
2.7.4
