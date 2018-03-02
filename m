Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428785AbeCBTEz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:04:55 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37727 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428639AbeCBTEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:04:46 -0500
X-Google-Smtp-Source: AG47ELse/CZf2LTcnD3eacuwuZIdRlNkb/6VRtLPQX6uuLFM1Y4vCC5vRfkBNDbyrIL/XehGGxDIJQ==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/8] arm64: zynqmp: Add support for Xilinx zcu104-revA
Date: Fri,  2 Mar 2018 20:04:30 +0100
Message-Id: <409e614b762bd6da24bc26364fcf28c805986eaf.1520017397.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx zcu104 is another customer board. It is sort of zcu102 clone
with some differences.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- Use i2c-mux instead of i2cswitch - was done with zcu106
- Remove gpio and usb aliases

Changes in v2:
- Remove i2c mw u-boot commands
- Record compatible string to xilinx.txt

 Documentation/devicetree/bindings/arm/xilinx.txt  |   3 +
 arch/arm64/boot/dts/xilinx/Makefile               |   1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 195 ++++++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 2b922ec3c82a..a9ce08a68711 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -26,3 +26,6 @@ Additional compatible strings:
   "xlnx,zynqmp-zcu102-revA", "xlnx,zynqmp-zcu102"
   "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102"
   "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102"
+
+- Xilinx evaluation board zcu104
+  "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104"
diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index 24e3ce801304..1c039e59c7c3 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
new file mode 100644
index 000000000000..d4ad19a38c93
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP ZCU104
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
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "ZynqMP ZCU104 RevA";
+	compatible = "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104", "xlnx,zynqmp";
+
+	aliases {
+		ethernet0 = &gem3;
+		i2c0 = &i2c1;
+		mmc0 = &sdhci1;
+		rtc0 = &rtc;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &dcc;
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
+};
+
+&can1 {
+	status = "okay";
+};
+
+&dcc {
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
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	/* Another connection to this bus via PL i2c via PCA9306 - u45 */
+	i2c-mux@74 { /* u34 */
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
+			eeprom@54 { /* u23 */
+				compatible = "atmel,24c08";
+				reg = <0x54>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			clock_8t49n287: clock-generator@6c { /* 8T49N287 - u182 */
+				reg = <0x6c>;
+			};
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			irps5401_43: irps54012@43 { /* IRPS5401 - u175 */
+				reg = <0x43>;
+			};
+			irps5401_4d: irps54012@4d { /* IRPS5401 - u180 */
+				reg = <0x4d>;
+			};
+		};
+
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			tca6416_u97: gpio@21 {
+				compatible = "ti,tca6416";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				/*
+				 * IRQ not connected
+				 * Lines:
+				 * 0 - IRPS5401_ALERT_B
+				 * 1 - HDMI_8T49N241_INT_ALM
+				 * 2 - MAX6643_OT_B
+				 * 3 - MAX6643_FANFAIL_B
+				 * 5 - IIC_MUX_RESET_B
+				 * 6 - GEM3_EXP_RESET_B
+				 * 7 - FMC_LPC_PRSNT_M2C_B
+				 * 4, 10 - 17 - not connected
+				 */
+			};
+		};
+
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+
+		/* 3, 6 not connected */
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
+	disable-wp;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+/* ULPI SMSC USB3320 */
+&usb0 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
1.9.1
