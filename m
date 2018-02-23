Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbeBWPAc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:00:32 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38717 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbeBWPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:00:29 -0500
X-Google-Smtp-Source: AH8x227GEO9UY2StDbxk6r7Tnq7/7p+emIdmVyekXKqkWePL7KNlKST1apV25UpWmYohXkRIv1Rp8A==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robherring2@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/5] arm: zynq: Add support for Xilinx zc770 xm010 dc1 board
Date: Fri, 23 Feb 2018 16:00:20 +0100
Message-Id: <f049c5121edab27227337ccd607db4f38f8d76f3.1519398009.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1519398009.git.michal.simek@xilinx.com>
References: <cover.1519398009.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1519398009.git.michal.simek@xilinx.com>
References: <cover.1519398009.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zc770 is based board which is extended by FMC/DC cards for SoC
validation. FMCs/DCs are supposed to cover all SoC configurations.
FMC/DC contains ethernet port, can, i2c, sd, qspi, spi, uart and usb.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Record compatible string to xilinx.txt

 Documentation/devicetree/bindings/arm/xilinx.txt |  3 +
 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/zynq-zc770-xm010.dts           | 92 ++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm010.dts

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 425c74fcc560..019e69037d42 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -11,6 +11,9 @@ Additional compatible strings:
 - Xilinx internal board cc108
   "xlnx,zynq-cc108"
 
+- Xilinx internal board zc770 with different FMC cards
+  "xlnx,zynq-zc770-xm010"
+
 ---------------------------------------------------------------
 
 Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c6810e84d4d7..be9ffae2a1ec 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1067,6 +1067,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-parallella.dtb \
 	zynq-zc702.dtb \
 	zynq-zc706.dtb \
+	zynq-zc770-xm010.dtb \
 	zynq-zed.dtb \
 	zynq-zybo.dtb
 dtb-$(CONFIG_MACH_ARMADA_370) += \
diff --git a/arch/arm/boot/dts/zynq-zc770-xm010.dts b/arch/arm/boot/dts/zynq-zc770-xm010.dts
new file mode 100644
index 000000000000..b1cfb4ede434
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-zc770-xm010.dts
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx ZC770 XM010 board DTS
+ *
+ * Copyright (C) 2013-2018 Xilinx, Inc.
+ */
+/dts-v1/;
+#include "zynq-7000.dtsi"
+
+/ {
+	compatible = "xlnx,zynq-zc770-xm010", "xlnx,zynq-7000";
+	model = "Xilinx Zynq";
+
+	aliases {
+		ethernet0 = &gem0;
+		i2c0 = &i2c0;
+		serial0 = &uart1;
+		spi1 = &spi1;
+	};
+
+	chosen {
+		bootargs = "";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
+	};
+
+	usb_phy0: phy0 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
+};
+
+&can0 {
+	status = "okay";
+};
+
+&gem0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy>;
+
+	ethernet_phy: ethernet-phy@7 {
+		reg = <7>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+	};
+
+};
+
+&sdhci0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+	num-cs = <4>;
+	is-decoded-cs = <0>;
+	flash@0 {
+		compatible = "sst25wf080", "jedec,spi-nor";
+		reg = <1>;
+		spi-max-frequency = <1000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@test {
+			label = "spi-flash";
+			reg = <0x0 0x100000>;
+		};
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+	usb-phy = <&usb_phy0>;
+};
-- 
1.9.1
