Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeFEGFk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:05:40 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:15642 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbeFEGFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:05:36 -0400
From: Nishanth Menon <nm@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>, <nm@ti.com>
Subject: [RFC PATCH 6/6] arm64: dts: ti: Add support for AM654 EVM base board
Date: Tue, 5 Jun 2018 01:05:10 -0500
Message-ID: <20180605060510.32473-2-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605060510.32473-1-nm@ti.com>
References: <=<20180605060125.9518-1-nm@ti.com>
 <20180605060510.32473-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EValuation Module(EVM) platform for AM654 consists of a
common Base board + one or more of daughter cards, which include:
a) "Personality Modules", which can be specific to a profile, such as
 ICSSG enabled or Multi-media (including audio).
b) SERDES modules, which may be 2 lane PCIe or two port PCIe + USB2
c) Camera daughter card
d) various display panels

Among other options. There are two basic configurations defined which
include an "EVM" configuration and "IDK" (Industrial development kit)
which differ in the specific combination of daughter cards that are
used.

To simplify support, we choose to support just the base board as the
core device tree file and all daughter cards would be expected to be
device tree overlays.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 MAINTAINERS                                    |  1 +
 arch/arm64/boot/dts/Makefile                   |  1 +
 arch/arm64/boot/dts/ti/Makefile                |  9 ++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 40 ++++++++++++++++++++++++++
 4 files changed, 51 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/Makefile
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f5c4eddec7a..4491a0f0625f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2092,6 +2092,7 @@ M:	Nishanth Menon <nm@ti.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/arm/ti/k3.txt
+F:	arch/arm64/boot/dts/ti/Makefile
 F:	arch/arm64/boot/dts/ti/k3-*
 
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 3543bc324553..4690364d584b 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -23,5 +23,6 @@ subdir-y += rockchip
 subdir-y += socionext
 subdir-y += sprd
 subdir-y += synaptics
+subdir-y += ti
 subdir-y += xilinx
 subdir-y += zte
diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
new file mode 100644
index 000000000000..63e619d0b5b8
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Make file to build device tree binaries for boards based on
+# Texas Instruments Inc processors
+#
+# Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+#
+
+dtb-$(CONFIG_ARCH_K3_AM6_SOC) += k3-am654-base-board.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
new file mode 100644
index 000000000000..d227d792de60
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include "k3-am654.dtsi"
+
+/ {
+	compatible =  "ti,am654-evm", "ti,am654";
+	model = "Texas Instruments AM654 Base Board";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+		bootargs = "earlycon=ns16550a,mmio32,0x02800000";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 4G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		secure_ddr: secure_ddr@9e800000 {
+			reg = <0 0x9e800000 0 0x01800000>; /* for OP-TEE */
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+};
+
+&main_uart0 {
+	status = "okay";
+};
-- 
2.15.1
