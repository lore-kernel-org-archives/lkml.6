Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947614AbeCBTFI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:05:08 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35995 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428740AbeCBTEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:04:53 -0500
X-Google-Smtp-Source: AG47ELvA3U0a+pIuYs28Pm0IdZWUkKKKsczRlBHCrNCjVARxrYBoOQpwYoXjvOWXc1YGazUgXJieKQ==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 8/8] arm64: zynqmp: Add support for Xilinx zc1751
Date: Fri,  2 Mar 2018 20:04:34 +0100
Message-Id: <9f84bb43ee3e57b1635250a59e7b588831374649.1520017397.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx zc1751 boards is used for silicon validation. Board can be
extended with 5 FMCs/DCs cards to connect various IPs. Describe all
these combinations.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- Remove aliases for can, usb, gpio
- dc2 fix spi_flashes and partitions

Changes in v2:
- Record compatible string to xilinx.txt

 Documentation/devicetree/bindings/arm/xilinx.txt   |   3 +
 arch/arm64/boot/dts/xilinx/Makefile                |   5 +
 .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    | 131 +++++++++++++++
 .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 168 +++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    | 150 +++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    | 178 +++++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    | 125 +++++++++++++++
 7 files changed, 760 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index aceccf2bf43b..0cf6fb61631d 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -28,6 +28,9 @@ Additional compatible strings:
 - Xilinx internal board zc1275
   "xlnx,zynqmp-zc1275-revA", "xlnx,zynqmp-zc1275"
 
+- Xilinx internal board zc1751
+  "xlnx,zynqmp-zc1751"
+
 - Xilinx 96boards compatible board zcu100
   "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100"
 
diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index bdda451afaad..c2a0c00272e2 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -3,6 +3,11 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1232-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1254-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1275-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1751-xm015-dc1.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1751-xm016-dc2.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1751-xm017-dc3.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1751-xm018-dc4.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1751-xm019-dc5.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
new file mode 100644
index 000000000000..9a3e39d1294f
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP zc1751-xm015-dc1
+ *
+ * (C) Copyright 2015 - 2018, Xilinx, Inc.
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
+	model = "ZynqMP zc1751-xm015-dc1 RevA";
+	compatible = "xlnx,zynqmp-zc1751", "xlnx,zynqmp";
+
+	aliases {
+		ethernet0 = &gem3;
+		i2c0 = &i2c1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		rtc0 = &rtc;
+		serial0 = &uart0;
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
+	};
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
+	phy0: phy@0 {
+		reg = <0>;
+	};
+};
+
+&gpio {
+	status = "okay";
+};
+
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom: eeprom@55 {
+		compatible = "atmel,24c64"; /* 24AA64 */
+		reg = <0x55>;
+	};
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+	/* SATA phy OOB timing settings */
+	ceva,p0-cominit-params = /bits/ 8 <0x1B 0x4D 0x18 0x28>;
+	ceva,p0-comwake-params = /bits/ 8 <0x06 0x19 0x08 0x0E>;
+	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	ceva,p1-cominit-params = /bits/ 8 <0x1B 0x4D 0x18 0x28>;
+	ceva,p1-comwake-params = /bits/ 8 <0x06 0x19 0x08 0x0E>;
+	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+};
+
+/* eMMC */
+&sdhci0 {
+	status = "okay";
+	bus-width = <8>;
+};
+
+/* SD1 with level shifter */
+&sdhci1 {
+	status = "okay";
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
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
new file mode 100644
index 000000000000..11cc67184fa9
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP zc1751-xm016-dc2
+ *
+ * (C) Copyright 2015 - 2018, Xilinx, Inc.
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
+	model = "ZynqMP zc1751-xm016-dc2 RevA";
+	compatible = "xlnx,zynqmp-zc1751", "xlnx,zynqmp";
+
+	aliases {
+		can0 = &can0;
+		can1 = &can1;
+		ethernet0 = &gem2;
+		i2c0 = &i2c0;
+		rtc0 = &rtc;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		spi0 = &spi0;
+		spi1 = &spi1;
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
+	};
+};
+
+&can0 {
+	status = "okay";
+};
+
+&can1 {
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
+&gem2 {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	phy0: phy@5 {
+		reg = <5>;
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
+	tca6416_u26: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		/* IRQ not connected */
+	};
+
+	rtc@68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
+
+&rtc {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+	num-cs = <1>;
+
+	spi0_flash0: flash0@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "sst,sst25wf080", "jedec,spi-nor";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+
+		partition@0 {
+			label = "data";
+			reg = <0x0 0x100000>;
+		};
+	};
+};
+
+&spi1 {
+	status = "okay";
+	num-cs = <1>;
+
+	spi1_flash0: flash0@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "atmel,at45db041e", "atmel,at45", "atmel,dataflash";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+
+		partition@0 {
+			label = "data";
+			reg = <0x0 0x84000>;
+		};
+	};
+};
+
+/* ULPI SMSC USB3320 */
+&usb1 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
new file mode 100644
index 000000000000..7a49deeae647
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP zc1751-xm017-dc3
+ *
+ * (C) Copyright 2016 - 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk.dtsi"
+
+/ {
+	model = "ZynqMP zc1751-xm017-dc3 RevA";
+	compatible = "xlnx,zynqmp-zc1751", "xlnx,zynqmp";
+
+	aliases {
+		ethernet0 = &gem0;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		mmc0 = &sdhci1;
+		rtc0 = &rtc;
+		serial0 = &uart0;
+		serial1 = &uart1;
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
+	};
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
+&gem0 {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	phy0: phy@0 { /* VSC8211 */
+		reg = <0>;
+	};
+};
+
+&gpio {
+	status = "okay";
+};
+
+/* just eeprom here */
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tca6416_u26: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		/* IRQ not connected */
+	};
+
+	rtc@68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
+
+/* eeprom24c02 and SE98A temp chip pca9306 */
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+	/* SATA phy OOB timing settings */
+	ceva,p0-cominit-params = /bits/ 8 <0x1B 0x4D 0x18 0x28>;
+	ceva,p0-comwake-params = /bits/ 8 <0x06 0x19 0x08 0x0E>;
+	ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+	ceva,p1-cominit-params = /bits/ 8 <0x1B 0x4D 0x18 0x28>;
+	ceva,p1-comwake-params = /bits/ 8 <0x06 0x19 0x08 0x0E>;
+	ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
+	ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
+};
+
+&sdhci1 { /* emmc with some settings */
+	status = "okay";
+};
+
+/* main */
+&uart0 {
+	status = "okay";
+};
+
+/* DB9 */
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+/* ULPI SMSC USB3320 */
+&usb1 {
+	status = "okay";
+	dr_mode = "host";
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
new file mode 100644
index 000000000000..54c7b4f1d1e4
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP zc1751-xm018-dc4
+ *
+ * (C) Copyright 2015 - 2018, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk.dtsi"
+
+/ {
+	model = "ZynqMP zc1751-xm018-dc4";
+	compatible = "xlnx,zynqmp-zc1751", "xlnx,zynqmp";
+
+	aliases {
+		ethernet0 = &gem0;
+		ethernet1 = &gem1;
+		ethernet2 = &gem2;
+		ethernet3 = &gem3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		rtc0 = &rtc;
+		serial0 = &uart0;
+		serial1 = &uart1;
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
+	};
+};
+
+&can0 {
+	status = "okay";
+};
+
+&can1 {
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
+&lpd_dma_chan1 {
+	status = "okay";
+};
+
+&lpd_dma_chan2 {
+	status = "okay";
+};
+
+&lpd_dma_chan3 {
+	status = "okay";
+};
+
+&lpd_dma_chan4 {
+	status = "okay";
+};
+
+&lpd_dma_chan5 {
+	status = "okay";
+};
+
+&lpd_dma_chan6 {
+	status = "okay";
+};
+
+&lpd_dma_chan7 {
+	status = "okay";
+};
+
+&lpd_dma_chan8 {
+	status = "okay";
+};
+
+&gem0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy0>;
+	ethernet_phy0: ethernet-phy@0 { /* Marvell 88e1512 */
+		reg = <0>;
+	};
+	ethernet_phy7: ethernet-phy@7 { /* Vitesse VSC8211 */
+		reg = <7>;
+	};
+	ethernet_phy3: ethernet-phy@3 { /* Realtek RTL8211DN */
+		reg = <3>;
+	};
+	ethernet_phy8: ethernet-phy@8 { /* Vitesse VSC8211 */
+		reg = <8>;
+	};
+};
+
+&gem1 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy7>;
+};
+
+&gem2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy3>;
+};
+
+&gem3 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy8>;
+};
+
+&gpio {
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
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
+&watchdog0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
new file mode 100644
index 000000000000..b8b5ff13818d
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dts file for Xilinx ZynqMP zc1751-xm019-dc5
+ *
+ * (C) Copyright 2015 - 2018, Xilinx, Inc.
+ *
+ * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
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
+	model = "ZynqMP zc1751-xm019-dc5 RevA";
+	compatible = "xlnx,zynqmp-zc1751", "xlnx,zynqmp";
+
+	aliases {
+		ethernet0 = &gem1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		mmc0 = &sdhci0;
+		serial0 = &uart0;
+		serial1 = &uart1;
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
+	};
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
+&gem1 {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	phy0: phy@0 {
+		reg = <0>;
+	};
+};
+
+&gpio {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&sdhci0 {
+	status = "okay";
+	no-1-8-v;
+};
+
+&ttc0 {
+	status = "okay";
+};
+
+&ttc1 {
+	status = "okay";
+};
+
+&ttc2 {
+	status = "okay";
+};
+
+&ttc3 {
+	status = "okay";
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
+&watchdog0 {
+	status = "okay";
+};
-- 
1.9.1
