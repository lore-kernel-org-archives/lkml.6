Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeA3Mjt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:39:49 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:35075 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752005AbeA3Mjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:39:42 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH 2/4] arm64: dts: rockchip: add RK3368-uQ7 (Lion) SoM
Date: Tue, 30 Jan 2018 13:39:29 +0100
Message-Id: <20180130123931.50781-3-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180130123931.50781-1-klaus.goger@theobroma-systems.com>
References: <20180130123931.50781-1-klaus.goger@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3368-uQ7 SoM is a uQseven-compatible (40mm x 70mm, MXM-230
connector) system-on-module from Theobroma Systems, featuring the
Rockchip RK3368.

It provides the following feature set:
 * up to 4GB DDR3
 * on-module SPI-NOR flash
 * on-module eMMC (with 8-bit 1.8V interface)
 * SD card (on a baseboad) via edge connector
 * Gigabit Ethernet with on-module Micrel KSZ9031 GbE PHY
 * HDMI/eDP/MIPI-DSI/LVDS
 * MIPI-CSI
 * USB
   - 1x USB 2.0 dual-role
   - 1x USB 2.0 host
 * on-module STM32 Cortex-M0 companion controller, implementing:
   - low-power RTC functionality (ISL1208 emulation)
   - fan controller (AMC6821 emulation)
   - USB<->CAN bridge controller

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
---

 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi | 317 ++++++++++++++++++++++++++
 1 file changed, 317 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
new file mode 100644
index 000000000000..72be1ae0854f
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Theobroma Systems Design und Consulting GmbH
+ */
+
+/dts-v1/;
+#include "rk3368.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	ext_gmac: gmac-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "ext_gmac";
+		#clock-cells = <0>;
+	};
+
+	i2cmux1 {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mux-gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
+		i2c-parent = <&i2c1>;
+
+		/* Q7_GPO_I2C */
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* Q7_SMB */
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2cmux2 {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mux-gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_HIGH>;
+		i2c-parent = <&i2c2>;
+
+		/* Q7_LVDS_BLC_I2C */
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+				fan: fan@18 {
+					compatible = "ti,amc6821";
+					reg = <0x18>;
+					cooling-min-state = <0>;
+					cooling-max-state = <9>;
+					#cooling-cells = <2>;
+				};
+
+				rtc_twi: rtc@6f {
+					compatible = "isil,isl1208";
+					reg = <0x6f>;
+				};
+		};
+
+		/* Q7_GP2_I2C */
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_module>;
+
+		module_led1 {
+			label = "module_led1";
+			gpios = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			panic-indicator;
+		};
+
+		module_led2 {
+			label = "module_led2";
+			gpios = <&gpio3 RK_PA3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	vcc_sys: vcc-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&emmc {
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	clock-frequency = <150000000>;
+	disable-wp;
+	non-removable;
+	vmmc-supply = <&vcc33_io>;
+	vqmmc-supply = <&vcc18_io>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_bus8>;
+	status = "okay";
+};
+
+&gmac {
+	phy-supply = <&vcc33_io>;
+	phy-mode = "rgmii";
+	clock_in_out = "input";
+	assigned-clocks = <&cru SCLK_MAC>;
+	assigned-clock-parents = <&ext_gmac>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	snps,reset-gpio = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 50000>;
+	tx_delay = <0x10>;
+	rx_delay = <0x10>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	rk808: pmic@1b {
+		compatible = "rockchip,rk808";
+		reg = <0x1b>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>, <&pmic_sleep>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
+		rockchip,system-power-controller;
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+		vcc7-supply = <&vcc_sys>;
+		vcc8-supply = <&vcc_sys>;
+		vcc9-supply = <&vcc_sys>;
+		vcc10-supply = <&vcc_sys>;
+		vcc11-supply = <&vcc_sys>;
+		vcc12-supply = <&vcc_sys>;
+		clock-output-names = "xin32k", "rk808-clkout2";
+		#clock-cells = <1>;
+
+		regulators {
+			vdd_cpu: DCDC_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-name = "vdd_cpu";
+			};
+
+			vdd_log: DCDC_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-name = "vdd_log";
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc_ddr";
+			};
+
+			vcc33_io: DCDC_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc33_io";
+			};
+
+			vcc33_video: LDO_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc33_video";
+			};
+
+			vdd10_pll: LDO_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vdd10_pll";
+			};
+
+			vcc18_io: LDO_REG4 {
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc18_io";
+			};
+
+			vdd10_video: LDO_REG6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vdd10_video";
+			};
+
+			vcc18_video: LDO_REG8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc18_video";
+			};
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_b2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu_b3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&pinctrl {
+	leds {
+		led_pins_module: led-module-gpio {
+			rockchip,pins =
+				<RK_GPIO2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>,
+				<RK_GPIO3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <RK_GPIO0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pmic_sleep: pmic-sleep {
+			rockchip,pins = <RK_GPIO0 RK_PA0 RK_FUNC_2 &pcfg_pull_none>;
+		};
+	};
+};
+
+&spi1 {
+	status = "okay";
+
+	norflash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
-- 
2.11.0
