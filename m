Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947642AbeCBTFm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:05:42 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35987 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428665AbeCBTEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:04:50 -0500
X-Google-Smtp-Source: AG47ELtgPj17kLdlD6hprSaJYJA3dQiA2wIEnxEAIz2BqVQTjZtnV/JpNn9kXk1wa4q1r59OPjWfiw==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/8] arm64: zynqmp: Add support for Xilinx zcu111-revA
Date: Fri,  2 Mar 2018 20:04:32 +0100
Message-Id: <440b5135244db893167fbb26da6499acf9551bf9.1520017397.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx zcu111 is a customer board. It is reusing some parts from zcu102.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3:
- Remove usb and gpio aliases

Changes in v2:
- Remove i2c mw u-boot commands
- Use i2c-mux instead of i2cswitch
- Use clock generator without numbers.
- Record compatible string to xilinx.txt

 Documentation/devicetree/bindings/arm/xilinx.txt  |   3 +
 arch/arm64/boot/dts/xilinx/Makefile               |   1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 444 ++++++++++++++++++++++
 3 files changed, 448 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 8503fabf90ee..c2bc75774010 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -32,3 +32,6 @@ Additional compatible strings:
 
 - Xilinx evaluation board zcu106
   "xlnx,zynqmp-zcu106-revA", "xlnx,zynqmp-zcu106"
+
+- Xilinx evaluation board zcu111
+  "xlnx,zynqmp-zcu111-revA", "xlnx,zynqmp-zcu111"
diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index 922c5da39600..d15c9dc1d8f2 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
new file mode 100644
index 000000000000..9a9dd6a0142b
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP ZCU111
+ *
+ * (C) Copyright 2017 - 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "ZynqMP ZCU111 RevA";
+	compatible = "xlnx,zynqmp-zcu111-revA", "xlnx,zynqmp-zcu111", "xlnx,zynqmp";
+
+	aliases {
+		ethernet0 = &gem3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		mmc0 = &sdhci1;
+		rtc0 = &rtc;
+		serial0 = &uart0;
+		serial1 = &dcc;
+	};
+
+	chosen {
+		bootargs = "earlycon";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
+		/* Another 4GB connected to PL */
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+		sw19 {
+			label = "sw19";
+			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_DOWN>;
+			gpio-key,wakeup;
+			autorepeat;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		heartbeat_led {
+			label = "heartbeat";
+			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&dcc {
+	status = "okay";
+};
+
+&fpd_dma_chan1 {
+	status = "okay";
+};
+
+&fpd_dma_chan2 {
+	status = "okay";
+};
+
+&fpd_dma_chan3 {
+	status = "okay";
+};
+
+&fpd_dma_chan4 {
+	status = "okay";
+};
+
+&fpd_dma_chan5 {
+	status = "okay";
+};
+
+&fpd_dma_chan6 {
+	status = "okay";
+};
+
+&fpd_dma_chan7 {
+	status = "okay";
+};
+
+&fpd_dma_chan8 {
+	status = "okay";
+};
+
+&gem3 {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	phy0: phy@c {
+		reg = <0xc>;
+		ti,rx-internal-delay = <0x8>;
+		ti,tx-internal-delay = <0xa>;
+		ti,fifo-depth = <0x1>;
+	};
+};
+
+&gpio {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tca6416_u22: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller; /* interrupt not connected */
+		#gpio-cells = <2>;
+		/*
+		 * IRQ not connected
+		 * Lines:
+		 * 0 - MAX6643_OT_B
+		 * 1 - MAX6643_FANFAIL_B
+		 * 2 - MIO26_PMU_INPUT_LS
+		 * 4 - SFP_SI5382_INT_ALM
+		 * 5 - IIC_MUX_RESET_B
+		 * 6 - GEM3_EXP_RESET_B
+		 * 10 - FMCP_HSPC_PRSNT_M2C_B
+		 * 11 - CLK_SPI_MUX_SEL0
+		 * 12 - CLK_SPI_MUX_SEL1
+		 * 16 - IRPS5401_ALERT_B
+		 * 17 - INA226_PMBUS_ALERT
+		 * 3, 7, 13-15 - not connected
+		 */
+	};
+
+	i2c-mux@75 { /* u23 */
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/* PS_PMBUS */
+			/* PMBUS_ALERT done via pca9544 */
+			ina226@40 { /* u67 */
+				compatible = "ti,ina226";
+				reg = <0x40>;
+				shunt-resistor = <2000>;
+			};
+			ina226@41 { /* u59 */
+				compatible = "ti,ina226";
+				reg = <0x41>;
+				shunt-resistor = <5000>;
+			};
+			ina226@42 { /* u61 */
+				compatible = "ti,ina226";
+				reg = <0x42>;
+				shunt-resistor = <5000>;
+			};
+			ina226@43 { /* u60 */
+				compatible = "ti,ina226";
+				reg = <0x43>;
+				shunt-resistor = <5000>;
+			};
+			ina226@45 { /* u64 */
+				compatible = "ti,ina226";
+				reg = <0x45>;
+				shunt-resistor = <5000>;
+			};
+			ina226@46 { /* u69 */
+				compatible = "ti,ina226";
+				reg = <0x46>;
+				shunt-resistor = <2000>;
+			};
+			ina226@47 { /* u66 */
+				compatible = "ti,ina226";
+				reg = <0x47>;
+				shunt-resistor = <5000>;
+			};
+			ina226@48 { /* u65 */
+				compatible = "ti,ina226";
+				reg = <0x48>;
+				shunt-resistor = <5000>;
+			};
+			ina226@49 { /* u63 */
+				compatible = "ti,ina226";
+				reg = <0x49>;
+				shunt-resistor = <5000>;
+			};
+			ina226@4a { /* u3 */
+				compatible = "ti,ina226";
+				reg = <0x4a>;
+				shunt-resistor = <5000>;
+			};
+			ina226@4b { /* u71 */
+				compatible = "ti,ina226";
+				reg = <0x4b>;
+				shunt-resistor = <5000>;
+			};
+			ina226@4c { /* u77 */
+				compatible = "ti,ina226";
+				reg = <0x4c>;
+				shunt-resistor = <5000>;
+			};
+			ina226@4d { /* u73 */
+				compatible = "ti,ina226";
+				reg = <0x4d>;
+				shunt-resistor = <5000>;
+			};
+			ina226@4e { /* u79 */
+				compatible = "ti,ina226";
+				reg = <0x4e>;
+				shunt-resistor = <5000>;
+			};
+		};
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* NC */
+		};
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			irps5401_43: irps54012@43 { /* IRPS5401 - u53 check these */
+				reg = <0x43>;
+			};
+			irps5401_44: irps54012@44 { /* IRPS5401 - u55 */
+				reg = <0x44>;
+			};
+			irps5401_45: irps54012@45 { /* IRPS5401 - u57 */
+				reg = <0x45>;
+			};
+			/* u68 IR38064 +0 */
+			/* u70 IR38060 +1 */
+			/* u74 IR38060 +2 */
+			/* u75 IR38060 +6 */
+			/* J19 header too */
+
+		};
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			/* SYSMON */
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	i2c-mux@74 { /* u26 */
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/*
+			 * IIC_EEPROM 1kB memory which uses 256B blocks
+			 * where every block has different address.
+			 *    0 - 256B address 0x54
+			 * 256B - 512B address 0x55
+			 * 512B - 768B address 0x56
+			 * 768B - 1024B address 0x57
+			 */
+			eeprom: eeprom@54 { /* u88 */
+				compatible = "atmel,24c08";
+				reg = <0x54>;
+			};
+		};
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			si5341: clock-generator@36 { /* SI5341 - u46 */
+				reg = <0x36>;
+			};
+
+		};
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			si570_1: clock-generator@5d { /* USER SI570 - u47 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x5d>;
+				temperature-stability = <50>;
+				factory-fout = <300000000>;
+				clock-frequency = <300000000>;
+			};
+		};
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			si570_2: clock-generator@5d { /* USER MGT SI570 - u49 */
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				reg = <0x5d>;
+				temperature-stability = <50>;
+				factory-fout = <156250000>;
+				clock-frequency = <148500000>;
+			};
+		};
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			si5328: clock-generator@69 { /* SI5328 - u48 */
+				reg = <0x69>;
+			};
+		};
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+				sc18is603@2f { /* sc18is602 - u93 */
+					compatible = "nxp,sc18is603";
+					reg = <0x2f>;
+					/* 4 gpios for CS not handled by driver */
+					/*
+					 * USB2ANY cable or
+					 * LMK04208 - u90 or
+					 * LMX2594 - u102 or
+					 * LMX2594 - u103 or
+					 * LMX2594 - u104
+					 */
+				};
+		};
+		i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			/* FMC connector */
+		};
+		/* 7 NC */
+	};
+
+	i2c-mux@75 {
+		compatible = "nxp,pca9548"; /* u27 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			/* FMCP_HSPC_IIC */
+		};
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			/* NC */
+		};
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			/* SYSMON */
+		};
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			/* DDR4 SODIMM */
+		};
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			/* SFP3 */
+		};
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			/* SFP2 */
+		};
+		i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			/* SFP1 */
+		};
+		i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			/* SFP0 */
+		};
+	};
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+	/* SATA OOB timing settings */
+	ceva,p0-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
+	ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
+	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	ceva,p1-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
+	ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
+	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+};
+
+/* SD1 with level shifter */
+&sdhci1 {
+	status = "okay";
+	no-1-8-v;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+/* ULPI SMSC USB3320 */
+&usb0 {
+	status = "okay";
+};
-- 
1.9.1
