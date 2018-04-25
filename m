Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeDYVQZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:16:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50019 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751973AbeDYVQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:16:20 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] mips: generic: allow not building DTB in
Date: Wed, 25 Apr 2018 23:16:07 +0200
Message-Id: <20180425211607.2645-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425211607.2645-1-alexandre.belloni@bootlin.com>
References: <20180425211607.2645-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow not building any DTB in the generic kernel so it gets smaller. This
is necessary for ocelot because it can be built as a legacy platform that
needs a built-in DTB and it can also handle a separate DTB once it is
updated with a more modern bootloader. In the latter case, it is preferable
to not include any DTB in the kernel image so it is smaller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/Kconfig                | 1 -
 arch/mips/Makefile               | 2 +-
 arch/mips/boot/dts/mscc/Makefile | 2 +-
 arch/mips/generic/Kconfig        | 1 +
 arch/mips/generic/vmlinux.its.S  | 2 ++
 5 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 225c95da23ce..61057761d096 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -81,7 +81,6 @@ choice
 config MIPS_GENERIC
 	bool "Generic board-agnostic MIPS kernel"
 	select BOOT_RAW
-	select BUILTIN_DTB
 	select CEVT_R4K
 	select CLKSRC_MIPS_GIC
 	select COMMON_CLK
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 5e9fce076ab6..3d3554c13710 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -404,7 +404,7 @@ endif
 CLEAN_FILES += vmlinux.32 vmlinux.64
 
 # device-trees
-core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
+core-y += arch/mips/boot/dts/
 
 %.dtb %.dtb.S %.dtb.o: | scripts
 	$(Q)$(MAKE) $(build)=arch/mips/boot/dts arch/mips/boot/dts/$@
diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
index 8982b19504a3..437ec65ec14a 100644
--- a/arch/mips/boot/dts/mscc/Makefile
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -1,3 +1,3 @@
 dtb-$(CONFIG_MSCC_OCELOT)	+= ocelot_pcb123.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-($CONFIG_BUILTIN_DTB)	+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index 6564f18b2012..012f283f99c4 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -3,6 +3,7 @@ if MIPS_GENERIC
 
 config LEGACY_BOARDS
 	bool
+	select BUILTIN_DTB
 	help
 	  Select this from your board if the board must use a legacy, non-UHI,
 	  boot protocol. This will cause the kernel to scan through the list of
diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
index 1a08438fd893..9c954f2ae561 100644
--- a/arch/mips/generic/vmlinux.its.S
+++ b/arch/mips/generic/vmlinux.its.S
@@ -21,6 +21,7 @@
 		};
 	};
 
+#if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	configurations {
 		default = "conf@default";
 
@@ -29,4 +30,5 @@
 			kernel = "kernel@0";
 		};
 	};
+#endif
 };
-- 
2.17.0
