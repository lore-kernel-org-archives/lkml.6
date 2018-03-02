Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947686AbeCBTV6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:21:58 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35960 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428577AbeCBTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:21:47 -0500
X-Google-Smtp-Source: AG47ELusRDiAnYgkGrIQnC4quBAKCvSc7B7XMhP6AKCGiEcL+Ca1taNyX00oXwHHRaWX+WPLYoWGVA==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/5]  arm: zynq: Add support for Xilinx zc770 xm013 dc4 board
Date: Fri,  2 Mar 2018 20:21:37 +0100
Message-Id: <4e4589659d3d8f77cc8917dfa7bfe201d1d631ab.1520018484.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520018484.git.michal.simek@xilinx.com>
References: <cover.1520018484.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1520018484.git.michal.simek@xilinx.com>
References: <cover.1520018484.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zc770 is based board which is extended by FMC/DC cards for SoC
validation. FMCs/DCs are supposed to cover all SoC configurations.
FMC/DC contains can, ethernet, i2c, qspi, spi and uart.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3: None
Changes in v2:
- use eeprom as node name instead of at25
- Record compatible string to xilinx.txt

 Documentation/devicetree/bindings/arm/xilinx.txt |  1 +
 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/zynq-zc770-xm013.dts           | 78 ++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm013.dts

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 745c898f2f7f..63705a451251 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -15,6 +15,7 @@ Additional compatible strings:
   "xlnx,zynq-zc770-xm010"
   "xlnx,zynq-zc770-xm011"
   "xlnx,zynq-zc770-xm012"
+  "xlnx,zynq-zc770-xm013"
 
 ---------------------------------------------------------------
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2c74b935ad1c..d5de3748a80a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1070,6 +1070,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-zc770-xm010.dtb \
 	zynq-zc770-xm011.dtb \
 	zynq-zc770-xm012.dtb \
+	zynq-zc770-xm013.dtb \
 	zynq-zed.dtb \
 	zynq-zybo.dtb
 dtb-$(CONFIG_MACH_ARMADA_370) += \
diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts/zynq-zc770-xm013.dts
new file mode 100644
index 000000000000..8bb66859d774
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-zc770-xm013.dts
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx ZC770 XM013 board DTS
+ *
+ * Copyright (C) 2013 Xilinx, Inc.
+ */
+/dts-v1/;
+#include "zynq-7000.dtsi"
+
+/ {
+	compatible = "xlnx,zynq-zc770-xm013", "xlnx,zynq-7000";
+	model = "Xilinx Zynq";
+
+	aliases {
+		ethernet0 = &gem1;
+		i2c0 = &i2c1;
+		serial0 = &uart0;
+		spi1 = &spi0;
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
+};
+
+&can1 {
+	status = "okay";
+};
+
+&gem1 {
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
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	si570: clock-generator@55 {
+		#clock-cells = <0>;
+		compatible = "silabs,si570";
+		temperature-stability = <50>;
+		reg = <0x55>;
+		factory-fout = <156250000>;
+		clock-frequency = <148500000>;
+	};
+};
+
+&spi0 {
+	status = "okay";
+	num-cs = <4>;
+	is-decoded-cs = <0>;
+	eeprom: eeprom@0 {
+		at25,byte-len = <8192>;
+		at25,addr-mode = <2>;
+		at25,page-size = <32>;
+
+		compatible = "atmel,at25";
+		reg = <2>;
+		spi-max-frequency = <1000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
1.9.1
