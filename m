Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeDYVQY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:16:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50012 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751410AbeDYVQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:16:20 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] mips: mscc: build FIT image for Ocelot
Date: Wed, 25 Apr 2018 23:16:06 +0200
Message-Id: <20180425211607.2645-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ocelot now has a u-boot port, allow building FIT images instead of relying
on the legacy detection and builtin DTB.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/Makefile            |  2 +-
 arch/mips/generic/Kconfig                   | 12 +++++++++--
 arch/mips/generic/Platform                  |  1 +
 arch/mips/generic/board-ocelot_pcb123.its.S | 23 +++++++++++++++++++++
 4 files changed, 35 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/generic/board-ocelot_pcb123.its.S

diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
index c51164537c02..8982b19504a3 100644
--- a/arch/mips/boot/dts/mscc/Makefile
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -1,3 +1,3 @@
-dtb-$(CONFIG_LEGACY_BOARD_OCELOT)	+= ocelot_pcb123.dtb
+dtb-$(CONFIG_MSCC_OCELOT)	+= ocelot_pcb123.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index ba9b2c8cce68..6564f18b2012 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -35,13 +35,13 @@ config LEGACY_BOARD_OCELOT
 	depends on LEGACY_BOARD_SEAD3=n
 	select LEGACY_BOARDS
 	select MSCC_OCELOT
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
 
 config MSCC_OCELOT
 	bool
 	select GPIOLIB
 	select MSCC_OCELOT_IRQ
-	select SYS_HAS_EARLY_PRINTK
-	select USE_GENERIC_EARLY_PRINTK_8250
 
 comment "FIT/UHI Boards"
 
@@ -65,6 +65,14 @@ config FIT_IMAGE_FDT_XILFPGA
 	  Enable this to include the FDT for the MIPSfpga platform
 	  from Imagination Technologies in the FIT kernel image.
 
+config FIT_IMAGE_FDT_OCELOT_PCB123
+	bool "Include FDT for Microsemi Ocelot PCB123"
+	select MSCC_OCELOT
+	help
+	  Enable this to include the FDT for the Ocelot PCB123 platform
+	  from Microsemi in the FIT kernel image.
+	  This require u-boot on the platform.
+
 config VIRT_BOARD_RANCHU
 	bool "Support Ranchu platform for Android emulator"
 	help
diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
index 0dd0d5d460a5..879cb80396c8 100644
--- a/arch/mips/generic/Platform
+++ b/arch/mips/generic/Platform
@@ -16,4 +16,5 @@ all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz.itb
 its-y					:= vmlinux.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= board-boston.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= board-ni169445.its.S
+its-$(CONFIG_FIT_IMAGE_FDT_OCELOT_PCB123) += board-ocelot_pcb123.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= board-xilfpga.its.S
diff --git a/arch/mips/generic/board-ocelot_pcb123.its.S b/arch/mips/generic/board-ocelot_pcb123.its.S
new file mode 100644
index 000000000000..f6f54ff6d64c
--- /dev/null
+++ b/arch/mips/generic/board-ocelot_pcb123.its.S
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/ {
+	images {
+		fdt@ocelot_pcb123 {
+			description = "MSCC Ocelot PCB123 Device Tree";
+			data = /incbin/("boot/dts/mscc/ocelot_pcb123.dtb");
+			type = "flat_dt";
+			arch = "mips";
+			compression = "none";
+			hash@0 {
+				algo = "sha1";
+			};
+		};
+	};
+
+	configurations {
+		conf@ocelot_pcb123 {
+			description = "Ocelot Linux kernel";
+			kernel = "kernel@0";
+			fdt = "fdt@ocelot_pcb123";
+		};
+	};
+};
-- 
2.17.0
