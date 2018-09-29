Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47418C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145F720880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145F720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeI3ESg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51942 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728708AbeI3ESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:32 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000H5-QM; Sat, 29 Sep 2018 22:48:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006u5-EX; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Russell King" <linux@arm.linux.org.uk>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.877399154@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 065/131] arm: drop L_PTE_FILE and pte_file()-related
 helpers
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

commit b007ea798f5c568d3f464d37288220ef570f062c upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

This patch also adjust __SWP_TYPE_SHIFT, effectively increase size of
possible swap file to 128G.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/include/asm/pgtable-2level.h |  1 -
 arch/arm/include/asm/pgtable-3level.h |  1 -
 arch/arm/include/asm/pgtable-nommu.h  |  2 --
 arch/arm/include/asm/pgtable.h        | 20 +++-----------------
 arch/arm/mm/proc-macros.S             |  2 +-
 5 files changed, 4 insertions(+), 22 deletions(-)

--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -118,7 +118,6 @@
 #define L_PTE_VALID		(_AT(pteval_t, 1) << 0)		/* Valid */
 #define L_PTE_PRESENT		(_AT(pteval_t, 1) << 0)
 #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 1)
-#define L_PTE_FILE		(_AT(pteval_t, 1) << 2)	/* only when !PRESENT */
 #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 6)
 #define L_PTE_RDONLY		(_AT(pteval_t, 1) << 7)
 #define L_PTE_USER		(_AT(pteval_t, 1) << 8)
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -77,7 +77,6 @@
  */
 #define L_PTE_VALID		(_AT(pteval_t, 1) << 0)		/* Valid */
 #define L_PTE_PRESENT		(_AT(pteval_t, 3) << 0)		/* Present */
-#define L_PTE_FILE		(_AT(pteval_t, 1) << 2)		/* only when !PRESENT */
 #define L_PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
 #define L_PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
 #define L_PTE_YOUNG		(_AT(pteval_t, 1) << 10)	/* AF */
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -54,8 +54,6 @@
 
 typedef pte_t *pte_addr_t;
 
-static inline int pte_file(pte_t pte) { return 0; }
-
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -279,12 +279,12 @@ static inline pte_t pte_modify(pte_t pte
  *
  *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
  *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
- *   <--------------- offset ----------------------> < type -> 0 0 0
+ *   <--------------- offset ------------------------> < type -> 0 0
  *
- * This gives us up to 31 swap files and 64GB per swap file.  Note that
+ * This gives us up to 31 swap files and 128GB per swap file.  Note that
  * the offset field is always non-zero.
  */
-#define __SWP_TYPE_SHIFT	3
+#define __SWP_TYPE_SHIFT	2
 #define __SWP_TYPE_BITS		5
 #define __SWP_TYPE_MASK		((1 << __SWP_TYPE_BITS) - 1)
 #define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
@@ -303,20 +303,6 @@ static inline pte_t pte_modify(pte_t pte
  */
 #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYPE_BITS)
 
-/*
- * Encode and decode a file entry.  File entries are stored in the Linux
- * page tables as follows:
- *
- *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
- *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
- *   <----------------------- offset ------------------------> 1 0 0
- */
-#define pte_file(pte)		(pte_val(pte) & L_PTE_FILE)
-#define pte_to_pgoff(x)		(pte_val(x) >> 3)
-#define pgoff_to_pte(x)		__pte(((x) << 3) | L_PTE_FILE)
-
-#define PTE_FILE_MAX_BITS	29
-
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 /* FIXME: this is not correct */
 #define kern_addr_valid(addr)	(1)
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -98,7 +98,7 @@
 #endif
 #if !defined (CONFIG_ARM_LPAE) && \
 	(L_PTE_XN+L_PTE_USER+L_PTE_RDONLY+L_PTE_DIRTY+L_PTE_YOUNG+\
-	 L_PTE_FILE+L_PTE_PRESENT) > L_PTE_SHARED
+	 L_PTE_PRESENT) > L_PTE_SHARED
 #error Invalid Linux PTE bit settings
 #endif
 #endif	/* CONFIG_MMU */

