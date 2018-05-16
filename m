Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeEPG7A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 02:59:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30166 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751040AbeEPG67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 02:58:59 -0400
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: get rid of PMD_PAGE_SIZE() and _PMD_SIZE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180516065857.8043B6F6F2@po14934vm.idsi0.si.c-s.fr>
Date: Wed, 16 May 2018 08:58:57 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMD_PAGE_SIZE() is nowhere used and _PMD_SIZE is only
used by PMD_PAGE_SIZE().

This patch removes them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Superseeds "powerpc: get rid of PMD_PAGE_SIZE()" sent a few minutes ago.

 arch/powerpc/include/asm/nohash/32/pte-40x.h | 3 ---
 arch/powerpc/include/asm/pte-common.h        | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index 124f9ac23a1e..bb4b3a4b92a0 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -52,12 +52,9 @@
 
 #define _PMD_PRESENT	0x400	/* PMD points to page of PTEs */
 #define _PMD_BAD	0x802
-#define _PMD_SIZE	0x0e0	/* size field, != 0 for large-page PMD entry */
 #define _PMD_SIZE_4M	0x0c0
 #define _PMD_SIZE_16M	0x0e0
 
-#define PMD_PAGE_SIZE(pmdval)	(1024 << (((pmdval) & _PMD_SIZE) >> 4))
-
 /* Until my rework is finished, 40x still needs atomic PTE updates */
 #define PTE_ATOMIC_UPDATES	1
 
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index c4a72c7a8c83..050b0d775324 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -60,10 +60,6 @@
 #ifndef _PMD_PRESENT_MASK
 #define _PMD_PRESENT_MASK	_PMD_PRESENT
 #endif
-#ifndef _PMD_SIZE
-#define _PMD_SIZE	0
-#define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
-#endif
 #ifndef _PMD_USER
 #define _PMD_USER	0
 #endif
@@ -88,11 +84,7 @@
 #define _PTE_NONE_MASK	_PAGE_HPTEFLAGS
 #endif
 
-/* Make sure we get a link error if PMD_PAGE_SIZE is ever called on a
- * kernel without large page PMD support
- */
 #ifndef __ASSEMBLY__
-extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 
 /*
  * Don't just check for any non zero bits in __PAGE_USER, since for book3e
-- 
2.13.3
