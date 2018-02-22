Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932901AbeBVOXl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:23:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35262 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932638AbeBVOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:23:36 -0500
X-Google-Smtp-Source: AH8x225Oom/hZGynOveeycjO+qDwdtptBSNKTyyqxseyyZB3mMjf6mmYonK+DODcaz5NbgfcEGo1uA==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Subject: [PATCH] microblaze: Setup dependencies for ASM optimized lib functions
Date: Thu, 22 Feb 2018 15:23:28 +0100
Message-Id: <3f534814deabb151fa99938b39962afc6be69b2c.1519309405.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch:
"microblaze: Setup proper dependency for optimized lib functions"
(sha1: 7b6ce52be3f86520524711a6f33f3866f9339694)
didn't setup all dependencies properly.
Optimized lib functions in C are also present for little endian
and optimized library functions in assembler are implemented only for
big endian version.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/Kconfig.platform | 2 +-
 arch/microblaze/lib/fastcopy.S   | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/microblaze/Kconfig.platform b/arch/microblaze/Kconfig.platform
index 6996f397c16c..f7f1739c11b9 100644
--- a/arch/microblaze/Kconfig.platform
+++ b/arch/microblaze/Kconfig.platform
@@ -8,7 +8,6 @@ menu "Platform options"
 
 config OPT_LIB_FUNCTION
 	bool "Optimalized lib function"
-	depends on CPU_LITTLE_ENDIAN
 	default y
 	help
 	  Allows turn on optimalized library function (memcpy and memmove).
@@ -21,6 +20,7 @@ config OPT_LIB_FUNCTION
 config OPT_LIB_ASM
 	bool "Optimalized lib function ASM"
 	depends on OPT_LIB_FUNCTION && (XILINX_MICROBLAZE0_USE_BARREL = 1)
+	depends on CPU_BIG_ENDIAN
 	default n
 	help
 	  Allows turn on optimalized library function (memcpy and memmove).
diff --git a/arch/microblaze/lib/fastcopy.S b/arch/microblaze/lib/fastcopy.S
index 62021d7e249e..fdc48bb065d8 100644
--- a/arch/microblaze/lib/fastcopy.S
+++ b/arch/microblaze/lib/fastcopy.S
@@ -29,10 +29,6 @@
  *	between mem locations with size of xfer spec'd in bytes
  */
 
-#ifdef __MICROBLAZEEL__
-#error Microblaze LE not support ASM optimized lib func. Disable OPT_LIB_ASM.
-#endif
-
 #include <linux/linkage.h>
 	.text
 	.globl	memcpy
-- 
1.9.1
