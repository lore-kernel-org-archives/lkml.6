Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755131AbeDTNdG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:33:06 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45121 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754762AbeDTNdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:33:02 -0400
X-Google-Smtp-Source: AIpwx48w6Do4Epv+gmDgDzFTiuU6wg/8sLPMvCvxQh77k+xQw2kJxXg7smoP7zRQ00Ri45mffOiD/A==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net, hch@infradead.org,
        vincentc@andestech.com, nickhu@andestech.com
Subject: [PATCH v2 1/9] nds32: lib: To use generic lib instead of libgcc to prevent the symbol undefined issue.
Date: Fri, 20 Apr 2018 21:31:07 +0800
Message-Id: <2bfdc9653521e88140a366af3b6f91394c1adfef.1524229038.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
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
