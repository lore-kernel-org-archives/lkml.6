Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeD3HWq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:22:46 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35205 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbeD3HWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:22:35 -0400
X-Google-Smtp-Source: AB8JxZorqpRLkAS14YfljBgXqcOoDJvAlVIZ3Tg+UXX8reX2TsBbr6felnDqFGSmGKpIHXm9R7fmhA==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com
Subject: [PATCH 3/3] nds32: To fix a cache inconsistency issue by setting correct cacheability of NTC
Date: Mon, 30 Apr 2018 15:20:41 +0800
Message-Id: <3638122ebb22882a5967cb1cbc62354a2ec4cc90.1525072601.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <a42871ba8088e343cdfd405426ea25e5727116af.1525072600.git.greentime@andestech.com>
References: <a42871ba8088e343cdfd405426ea25e5727116af.1525072600.git.greentime@andestech.com>
In-Reply-To: <a42871ba8088e343cdfd405426ea25e5727116af.1525072600.git.greentime@andestech.com>
References: <a42871ba8088e343cdfd405426ea25e5727116af.1525072600.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nds32 architecture will use physical memory when interrupt or
exception comes and it will use the setting of NTC0-4. The original
implementation didn't consider the DRAM start address may start from 1GB,
2GB or 3GB to cause this issue. It will write the data to DRAM if it is
running in physical address however kernel will read the data with
virtaul address through data cache. In this case, the data of DRAM is
latest.

This fix will set the correct cacheability to let kernel write/read the
latest data in cache instead of DRAM.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/bitfield.h |  1 +
 arch/nds32/kernel/head.S          | 28 +++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
index 28b7d797fd59..8e84fc385b94 100644
--- a/arch/nds32/include/asm/bitfield.h
+++ b/arch/nds32/include/asm/bitfield.h
@@ -396,6 +396,7 @@
 #define MMU_CTL_D8KB		1
 #define MMU_CTL_UNA		( 0x1  << MMU_CTL_offUNA )
 
+#define MMU_CTL_CACHEABLE_NON   0
 #define MMU_CTL_CACHEABLE_WB	2
 #define MMU_CTL_CACHEABLE_WT	3
 
diff --git a/arch/nds32/kernel/head.S b/arch/nds32/kernel/head.S
index 71f57bd70f3b..c5fdae174ced 100644
--- a/arch/nds32/kernel/head.S
+++ b/arch/nds32/kernel/head.S
@@ -57,14 +57,32 @@ _nodtb:
 	isb
 	mtsr    $r4, $L1_PPTB       ! load page table pointer\n"
 
-/* set NTC0 cacheable/writeback, mutliple page size in use */
+#ifdef CONFIG_CPU_DCACHE_DISABLE
+	#define MMU_CTL_NTCC MMU_CTL_CACHEABLE_NON
+#else
+	#ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
+		#define MMU_CTL_NTCC MMU_CTL_CACHEABLE_WT
+	#else
+		#define MMU_CTL_NTCC MMU_CTL_CACHEABLE_WB
+	#endif
+#endif
+
+/* set NTC cacheability, mutliple page size in use */
 	mfsr    $r3, $MMU_CTL
-	li      $r0, #~MMU_CTL_mskNTC0
-	and     $r3, $r3, $r0
+#if CONFIG_MEMORY_START >= 0xc0000000
+	ori     $r3, $r3, (MMU_CTL_NTCC << MMU_CTL_offNTC3)
+#elif CONFIG_MEMORY_START >= 0x80000000
+	ori     $r3, $r3, (MMU_CTL_NTCC << MMU_CTL_offNTC2)
+#elif CONFIG_MEMORY_START >= 0x40000000
+	ori     $r3, $r3, (MMU_CTL_NTCC << MMU_CTL_offNTC1)
+#else
+	ori     $r3, $r3, (MMU_CTL_NTCC << MMU_CTL_offNTC0)
+#endif
+
 #ifdef CONFIG_ANDES_PAGE_SIZE_4KB
-	ori     $r3, $r3, #(MMU_CTL_mskMPZIU|(MMU_CTL_CACHEABLE_WB << MMU_CTL_offNTC0))
+	ori     $r3, $r3, #(MMU_CTL_mskMPZIU)
 #else
-	ori     $r3, $r3, #(MMU_CTL_mskMPZIU|(MMU_CTL_CACHEABLE_WB << MMU_CTL_offNTC0)|MMU_CTL_D8KB)
+	ori     $r3, $r3, #(MMU_CTL_mskMPZIU|MMU_CTL_D8KB)
 #endif
 #ifdef CONFIG_HW_SUPPORT_UNALIGNMENT_ACCESS
 	li      $r0, #MMU_CTL_UNA
-- 
1.9.5
