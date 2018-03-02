Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428806AbeCBTGO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:06:14 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50399 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428127AbeCBTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:04:44 -0500
X-Google-Smtp-Source: AG47ELv6zL9th+RvuXvoI2dvS50eW9XTXso3/f3Hq+PSEsD54NEXQsG86AZgOsdiH8JmIRpfoMgzlA==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/8] arm64: zynqmp: Add support for Xilinx zcu100-revC
Date: Fri,  2 Mar 2018 20:04:28 +0100
Message-Id: <b0e9070d625d8ede2725d997458b97e9a37acfd4.1520017397.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board has 2GB of memory, i2c, sd, wifi sdio, spis, uarts, display
port and usbs.
Board is using fixed clocks because clock driver hasn't been merged yet.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3:
- Remove usb and gpio aliases

Changes in v2:
- Use i2c-mux instead of i2cswitch
- Remove i2c mw u-boot commands
- Use 96boards labels for i2cs and spis
- Fix pmic and wifi node
- Record compatible string to xilinx.txt
- Remove Nathalie's email (she left Xilinx already)

 Documentation/devicetree/bindings/arm/xilinx.txt  |   6 +
 arch/arm64/boot/dts/xilinx/Makefile               |   1 +
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi        | 213 ++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 289 ++++++++++++++++++++++
 4 files changed, 509 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 549e70a022cb..29039b645807 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -15,3 +15,9 @@ shall have the following properties.
 
 Required root node properties:
     - compatible = "xlnx,zynqmp";
+
+
+Additional compatible strings:
+
+- Xilinx 96boards compatible board zcu100
+  "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100"
diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index eba179b23b17..7266a6a9c0cd 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
new file mode 100644
index 000000000000..9c09baca7dd7
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Clock specification for Xilinx ZynqMP
+ *
+ * (C) Copyright 2015 - 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+/ {
+	clk100: clk100 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	clk125: clk125 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	clk200: clk200 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+	};
+
+	clk250: clk250 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <250000000>;
+	};
+
+	clk300: clk300 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <300000000>;
+	};
+
+	clk600: clk600 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <600000000>;
+	};
+
+	dp_aclk: clock0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-accuracy = <100>;
+	};
+
+	dp_aud_clk: clock1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+		clock-accuracy = <100>;
+	};
+
+	dpdma_clk: dpdma_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0x0>;
+		clock-frequency = <533000000>;
+	};
+
+	drm_clock: drm_clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0x0>;
+		clock-frequency = <262750000>;
+		clock-accuracy = <0x64>;
+	};
+};
+
+&can0 {
+	clocks = <&clk100 &clk100>;
+};
+
+&can1 {
+	clocks = <&clk100 &clk100>;
+};
+
+&fpd_dma_chan1 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan2 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan3 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan4 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan5 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan6 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan7 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&fpd_dma_chan8 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&lpd_dma_chan1 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&lpd_dma_chan2 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&lpd_dma_chan3 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&lpd_dma_chan4 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&lpd_dma_chan5 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&lpd_dma_chan6 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&lpd_dma_chan7 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&lpd_dma_chan8 {
+	clocks = <&clk600>, <&clk100>;
+};
+
+&gem0 {
+	clocks = <&clk125>, <&clk125>, <&clk125>;
+};
+
+&gem1 {
+	clocks = <&clk125>, <&clk125>, <&clk125>;
+};
+
+&gem2 {
+	clocks = <&clk125>, <&clk125>, <&clk125>;
+};
+
+&gem3 {
+	clocks = <&clk125>, <&clk125>, <&clk125>;
+};
+
+&gpio {
+	clocks = <&clk100>;
+};
+
+&i2c0 {
+	clocks = <&clk100>;
+};
+
+&i2c1 {
+	clocks = <&clk100>;
+};
+
+&sata {
+	clocks = <&clk250>;
+};
+
+&sdhci0 {
+	clocks = <&clk200 &clk200>;
+};
+
+&sdhci1 {
+	clocks = <&clk200 &clk200>;
+};
+
+&spi0 {
+	clocks = <&clk200 &clk200>;
+};
+
+&spi1 {
+	clocks = <&clk200 &clk200>;
+};
+
+&uart0 {
+	clocks = <&clk100 &clk100>;
+};
+
+&uart1 {
+	clocks = <&clk100 &clk100>;
+};
+
+&usb0 {
+	clocks = <&clk250>, <&clk250>;
+};
+
+&usb1 {
+	clocks = <&clk250>, <&clk250>;
+};
+
+&watchdog0 {
+	clocks = <&clk250>;
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
new file mode 100644
index 000000000000..3e862a9faf26
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP ZCU100 revC
+ *
+ * (C) Copyright 2016 - 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ * Nathalie Chan King Choy
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "ZynqMP ZCU100 RevC";
+	compatible = "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100", "xlnx,zynqmp";
+
+	aliases {
+		i2c0 = &i2c1;
+		rtc0 = &rtc;
+		serial0 = &uart1;
+		serial1 = &uart0;
+		serial2 = &dcc;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+		sw4 {
+			label = "sw4";
+			gpios = <&gpio 23 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			gpio-key,wakeup;
+			autorepeat;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		ds2 {
+			label = "ds2";
+			gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		ds3 {
+			label = "ds3";
+			gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx"; /* WLAN tx */
+			default-state = "off";
+		};
+
+		ds4 {
+			label = "ds4";
+			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0rx"; /* WLAN rx */
+			default-state = "off";
+		};
+
+		ds5 {
+			label = "ds5";
+			gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+		};
+
+		vbus_det { /* U5 USB5744 VBUS detection via MIO25 */
+			label = "vbus_det";
+			gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		bt_power {
+			label = "bt_power";
+			gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	wmmcsdio_fixed: fixedregulator-mmcsdio {
+		compatible = "regulator-fixed";
+		regulator-name = "wmmcsdio_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	sdio_pwrseq: sdio_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
+	};
+};
+
+&dcc {
+	status = "okay";
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names = "UART1_TX", "UART1_RX", "UART0_RX", "UART0_TX", "I2C1_SCL",
+			  "I2C1_SDA", "SPI1_SCLK", "WLAN_EN", "BT_EN", "SPI1_CS",
+			  "SPI1_MISO", "SPI1_MOSI", "I2C_MUX_RESET", "SD0_DAT0", "SD0_DAT1",
+			  "SD0_DAT2", "SD0_DAT3", "PS_LED3", "PS_LED2", "PS_LED1",
+			  "PS_LED0", "SD0_CMD", "SD0_CLK", "GPIO_PB", "SD0_DETECT",
+			  "VBUS_DET", "POWER_INT", "DP_AUX", "DP_HPD", "DP_OE",
+			  "DP_AUX_IN", "INA226_ALERT", "PS_FP_PWR_EN", "PL_PWR_EN", "POWER_KILL",
+			  "", "GPIO-A", "GPIO-B", "SPI0_SCLK", "GPIO-C",
+			  "GPIO-D", "SPI0_CS", "SPI0_MISO", "SPI_MOSI", "GPIO-E",
+			  "GPIO-F", "SD1_D0", "SD1_D1", "SD1_D2", "SD1_D3",
+			  "SD1_CMD", "SD1_CLK", "USB0_CLK", "USB0_DIR", "USB0_DATA2",
+			  "USB0_NXT", "USB0_DATA0", "USB0_DATA1", "USB0_STP", "USB0_DATA3",
+			  "USB0_DATA4", "USB0_DATA5", "USB0_DATA6", "USB0_DATA7", "USB1_CLK",
+			  "USB1_DIR", "USB1_DATA2", "USB1_NXT", "USB1_DATA0", "USB1_DATA1",
+			  "USB1_STP", "USB1_DATA3", "USB1_DATA4", "USB1_DATA5", "USB1_DATA6",
+			  "USB_DATA7", "WLAN_IRQ", "PMIC_IRQ", /* MIO end and EMIO start */
+			  "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "", "", "",
+			  "", "", "", "";
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+	i2c-mux@75 { /* u11 */
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+		i2csw_0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			label = "LS-I2C0";
+		};
+		i2csw_1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			label = "LS-I2C1";
+		};
+		i2csw_2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			label = "HS-I2C2";
+		};
+		i2csw_3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			label = "HS-I2C3";
+		};
+		i2csw_4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+
+			pmic: pmic@5e { /* Custom TI PMIC u33 */
+				compatible = "ti,tps65086";
+				reg = <0x5e>;
+				interrupt-parent = <&gpio>;
+				interrupts = <77 GPIO_ACTIVE_LOW>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+		};
+		i2csw_5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			/* PS_PMBUS */
+			ina226@40 { /* u35 */
+				compatible = "ti,ina226";
+				reg = <0x40>;
+				shunt-resistor = <10000>;
+				/* MIO31 is alert which should be routed to PMUFW */
+			};
+		};
+		i2csw_6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			/*
+			 * Not Connected
+			 */
+		};
+		i2csw_7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			/*
+			 * usb5744 (DNP) - U5
+			 * 100kHz - this is default freq for us
+			 */
+		};
+	};
+};
+
+&rtc {
+	status = "okay";
+};
+
+/* SD0 only supports 3.3V, no level shifter */
+&sdhci0 {
+	status = "okay";
+	no-1-8-v;
+	broken-cd; /* CD has to be enabled by default */
+	disable-wp;
+};
+
+&sdhci1 {
+	status = "okay";
+	bus-width = <0x4>;
+	non-removable;
+	disable-wp;
+	cap-power-off-card;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	vqmmc-supply = <&wmmcsdio_fixed>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wifi@2 {
+		compatible = "ti,wl1831";
+		reg = <2>;
+		interrupt-parent = <&gpio>;
+		interrupts = <76 IRQ_TYPE_EDGE_RISING>; /* MIO76 WLAN_IRQ 1V8 */
+	};
+};
+
+&spi0 { /* Low Speed connector */
+	status = "okay";
+	label = "LS-SPI0";
+};
+
+&spi1 { /* High Speed connector */
+	status = "okay";
+	label = "HS-SPI1";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+
+};
+
+/* ULPI SMSC USB3320 */
+&usb0 {
+	status = "okay";
+};
+
+/* ULPI SMSC USB3320 */
+&usb1 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
1.9.1
