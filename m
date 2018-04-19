Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeDSNUE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:20:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42814 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeDSNUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:20:02 -0400
X-Google-Smtp-Source: AIpwx4+g9fXsBxpdliMuBKjeYtmoCTs3C8iy2XGtmhKJX5savqqkKgXQtqhjVK1FYYmPY4wU9iRngQ==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net
Subject: [PATCH 1/9] nds32: lib: To use generic lib instead of libgcc to prevent the symbol undefined issue.
Date: Thu, 19 Apr 2018 21:18:07 +0800
Message-Id: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use the generic lib to fix these error because the symbol of
libgcc in toolchain is not exported.

ERROR: "__ucmpdi2" [fs/xfs/xfs.ko] undefined!
ERROR: "__ashrdi3" [fs/xfs/xfs.ko] undefined!
ERROR: "__lshrdi3" [fs/xfs/xfs.ko] undefined!
ERROR: "__ashldi3" [fs/ntfs/ntfs.ko] undefined!
...

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/Kconfig  | 6 ++++++
 arch/nds32/Makefile | 3 ---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 249f38d3388f..98e05f997f91 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -9,6 +9,12 @@ config NDS32
 	select CLKSRC_MMIO
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select GENERIC_ASHLDI3
+	select GENERIC_ASHRDI3
+	select GENERIC_LSHRDI3
+	select GENERIC_CMPDI2
+	select GENERIC_MULDI3
+	select GENERIC_UCMPDI2
 	select GENERIC_ATOMIC64
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index 91f933d5a962..20edf34e70ce 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -23,9 +23,6 @@ export	TEXTADDR
 # If we have a machine-specific directory, then include it in the build.
 core-y				+= arch/nds32/kernel/ arch/nds32/mm/
 libs-y				+= arch/nds32/lib/
-LIBGCC_PATH     		:= \
-  $(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
-libs-y				+= $(LIBGCC_PATH)
 
 ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
 BUILTIN_DTB := y
-- 
1.9.5
