Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeDKIzx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:55:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51194 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752372AbeDKIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:54:17 -0400
X-UUID: 9518211cae4f47aab3db4eeeba161274-20180411
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 11/12] arm: dts: mt7623: add MT7623A reference boards
Date: Wed, 11 Apr 2018 16:54:04 +0800
Message-ID: <68c37aafb9d49eaa26453f06ab02731b97e5792d.1523434758.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add MT7623A reference board with eMMC and NAND, respectively.

The both boards compared against MT7623N BPI-R2, we could see there are
UART[0-1] and USB2 being removed, I2C2 and SPI1 being added, I2C1, UART2
owning distinct pin usage and an extra WM8960 codec chip plugged into the
I2C1 offering the functionality of audio player and recorder through
SoC audio front-end engine (AFE).

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Suggested-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/Makefile             |   2 +
 arch/arm/boot/dts/mt7623.dtsi          |  32 ++++
 arch/arm/boot/dts/mt7623a-rfb-emmc.dts | 291 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt7623a-rfb-nand.dts | 337 +++++++++++++++++++++++++++++++++
 4 files changed, 662 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb-emmc.dts
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb-nand.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e24249..bc33a3c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1150,6 +1150,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6580-evbp1.dtb \
 	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
+	mt7623a-rfb-emmc.dtb \
+	mt7623a-rfb-nand.dtb \
 	mt7623n-rfb-nand.dtb \
 	mt7623n-bananapi-bpi-r2.dtb \
 	mt8127-moose.dtb \
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 01893858..f84c37b 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -960,6 +960,22 @@
 		};
 	};
 
+	i2c1_pins_b: i2c1-alt {
+		pin-i2c1 {
+			pinmux = <MT7623_PIN_242_URTS2_FUNC_SCL1>,
+				 <MT7623_PIN_243_UCTS2_FUNC_SDA1>;
+			bias-disable;
+		};
+	};
+
+	i2c2_pins_b: i2c2-alt {
+		pin-i2c2 {
+			pinmux = <MT7623_PIN_122_GPIO122_FUNC_SDA2>,
+				 <MT7623_PIN_123_HTPLG_FUNC_SCL2>;
+			bias-disable;
+		};
+	};
+
 	i2s0_pins_a: i2s0-default {
 		pin-i2s0 {
 			pinmux = <MT7623_PIN_49_I2S0_DATA_FUNC_I2S0_DATA>,
@@ -1160,6 +1176,15 @@
 		};
 	};
 
+	spi1_pins_a: spi1-default {
+		pins-spi {
+			pinmux = <MT7623_PIN_7_SPI1_CSN_FUNC_SPI1_CS>,
+				<MT7623_PIN_199_SPI1_CK_FUNC_SPI1_CK>,
+				<MT7623_PIN_8_SPI1_MI_FUNC_SPI1_MI>,
+				<MT7623_PIN_9_SPI1_MO_FUNC_SPI1_MO>;
+		};
+	};
+
 	uart0_pins_a: uart0-default {
 		pins-dat {
 			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
@@ -1180,4 +1205,11 @@
 				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
 		};
 	};
+
+	uart2_pins_b: uart2-alt {
+		pins-dat {
+			pinmux = <MT7623_PIN_200_URXD2_FUNC_URXD2>,
+				 <MT7623_PIN_201_UTXD2_FUNC_UTXD2>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
new file mode 100644
index 0000000..13c8693
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2018 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include "mt7623a.dtsi"
+#include "mt6323.dtsi"
+
+/ {
+	model = "MediaTek MT7623A with eMMC reference board";
+	compatible = "mediatek,mt7623a-rfb-emmc", "mediatek,mt7623";
+
+	aliases {
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	cpus {
+		cpu@0 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu@1 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu@2 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu@3 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+	};
+
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
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x20000000>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
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
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "mediatek,mt2701-wm8960-machine";
+		mediatek,platform = <&afe>;
+		audio-routing =
+			"Headphone", "HP_L",
+			"Headphone", "HP_R",
+			"LINPUT1", "AMIC",
+			"RINPUT1", "AMIC";
+		mediatek,audio-codec = <&wm8960>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_pins_a>;
+	};
+};
+
+&btif {
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
+	mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch@0 {
+			compatible = "mediatek,mt7530";
+			reg = <0>;
+			mediatek,mcm;
+			resets = <&ethsys MT2701_ETHSYS_MCM_RST>;
+			reset-names = "mcm";
+			core-supply = <&mt6323_vpa_reg>;
+			io-supply = <&mt6323_vemc3v3_reg>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					label = "lan0";
+				};
+
+				port@1 {
+					reg = <1>;
+					label = "lan1";
+				};
+
+				port@2 {
+					reg = <2>;
+					label = "lan2";
+				};
+
+				port@3 {
+					reg = <3>;
+					label = "lan3";
+				};
+
+				port@4 {
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
+	};
+};
+
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
+
+	wm8960: wm8960@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_b>;
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	status = "okay";
+	bus-width = <8>;
+	max-frequency = <50000000>;
+	cap-mmc-highspeed;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	non-removable;
+};
+
+&mmc1 {
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
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_default>;
+	status = "okay";
+
+	pcie@0,0 {
+		status = "okay";
+	};
+
+	pcie@1,0 {
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
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins_a>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins_b>;
+	status = "okay";
+};
+
+&usb1 {
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/mt7623a-rfb-nand.dts b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
new file mode 100644
index 0000000..88d8f0b
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2018 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include "mt7623a.dtsi"
+#include "mt6323.dtsi"
+
+/ {
+	model = "MediaTek MT7623A with NAND reference board";
+	compatible = "mediatek,mt7623a-rfb-nand", "mediatek,mt7623";
+
+	aliases {
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	cpus {
+		cpu@0 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu@1 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu@2 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+
+		cpu@3 {
+			proc-supply = <&mt6323_vproc_reg>;
+		};
+	};
+
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
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x20000000>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
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
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "mediatek,mt2701-wm8960-machine";
+		mediatek,platform = <&afe>;
+		audio-routing =
+			"Headphone", "HP_L",
+			"Headphone", "HP_R",
+			"LINPUT1", "AMIC",
+			"RINPUT1", "AMIC";
+		mediatek,audio-codec = <&wm8960>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_pins_a>;
+	};
+};
+
+&bch {
+	status = "okay";
+};
+
+&btif {
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
+	mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch@0 {
+			compatible = "mediatek,mt7530";
+			reg = <0>;
+			mediatek,mcm;
+			resets = <&ethsys MT2701_ETHSYS_MCM_RST>;
+			reset-names = "mcm";
+			core-supply = <&mt6323_vpa_reg>;
+			io-supply = <&mt6323_vemc3v3_reg>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					label = "lan0";
+				};
+
+				port@1 {
+					reg = <1>;
+					label = "lan1";
+				};
+
+				port@2 {
+					reg = <2>;
+					label = "lan2";
+				};
+
+				port@3 {
+					reg = <3>;
+					label = "lan3";
+				};
+
+				port@4 {
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
+	};
+};
+
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
+
+	wm8960: wm8960@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_b>;
+	status = "okay";
+};
+
+&mmc1 {
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
+	status = "okay";
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
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_default>;
+	status = "okay";
+
+	pcie@0,0 {
+		status = "okay";
+	};
+
+	pcie@1,0 {
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
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins_a>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins_b>;
+	status = "okay";
+};
+
+&usb1 {
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
-- 
2.7.4
