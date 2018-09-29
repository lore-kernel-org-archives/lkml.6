Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62FDC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973332087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973332087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51763 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728528AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000Gy-G6; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006vw-AS; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.606649658@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 088/131] x86: drop _PAGE_FILE and pte_file()-related
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

commit 0a191362058391878cc2a4d4ccddcd8223eb4f79 upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/pgtable-2level.h | 38 +--------------------------
 arch/x86/include/asm/pgtable-3level.h | 12 ---------
 arch/x86/include/asm/pgtable.h        | 20 --------------
 arch/x86/include/asm/pgtable_64.h     |  6 +----
 arch/x86/include/asm/pgtable_types.h  |  3 ---
 5 files changed, 2 insertions(+), 77 deletions(-)

--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -62,44 +62,8 @@ static inline unsigned long pte_bitop(un
 	return ((value >> rightshift) & mask) << leftshift;
 }
 
-/*
- * Bits _PAGE_BIT_PRESENT, _PAGE_BIT_FILE and _PAGE_BIT_PROTNONE are taken,
- * split up the 29 bits of offset into this range.
- */
-#define PTE_FILE_MAX_BITS	29
-#define PTE_FILE_SHIFT1		(_PAGE_BIT_PRESENT + 1)
-#define PTE_FILE_SHIFT2		(_PAGE_BIT_FILE + 1)
-#define PTE_FILE_SHIFT3		(_PAGE_BIT_PROTNONE + 1)
-#define PTE_FILE_BITS1		(PTE_FILE_SHIFT2 - PTE_FILE_SHIFT1 - 1)
-#define PTE_FILE_BITS2		(PTE_FILE_SHIFT3 - PTE_FILE_SHIFT2 - 1)
-
-#define PTE_FILE_MASK1		((1U << PTE_FILE_BITS1) - 1)
-#define PTE_FILE_MASK2		((1U << PTE_FILE_BITS2) - 1)
-
-#define PTE_FILE_LSHIFT2	(PTE_FILE_BITS1)
-#define PTE_FILE_LSHIFT3	(PTE_FILE_BITS1 + PTE_FILE_BITS2)
-
-static __always_inline pgoff_t pte_to_pgoff(pte_t pte)
-{
-	return (pgoff_t)
-		(pte_bitop(pte.pte_low, PTE_FILE_SHIFT1, PTE_FILE_MASK1,  0)		    +
-		 pte_bitop(pte.pte_low, PTE_FILE_SHIFT2, PTE_FILE_MASK2,  PTE_FILE_LSHIFT2) +
-		 pte_bitop(pte.pte_low, PTE_FILE_SHIFT3,           -1UL,  PTE_FILE_LSHIFT3));
-}
-
-static __always_inline pte_t pgoff_to_pte(pgoff_t off)
-{
-	return (pte_t){
-		.pte_low =
-			pte_bitop(off,                0, PTE_FILE_MASK1,  PTE_FILE_SHIFT1) +
-			pte_bitop(off, PTE_FILE_LSHIFT2, PTE_FILE_MASK2,  PTE_FILE_SHIFT2) +
-			pte_bitop(off, PTE_FILE_LSHIFT3,           -1UL,  PTE_FILE_SHIFT3) +
-			_PAGE_FILE,
-	};
-}
-
 /* Encode and de-code a swap entry */
-#define SWP_TYPE_BITS (_PAGE_BIT_FILE - _PAGE_BIT_PRESENT - 1)
+#define SWP_TYPE_BITS 5
 #define SWP_OFFSET_SHIFT (_PAGE_BIT_PROTNONE + 1)
 
 #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -176,18 +176,6 @@ static inline pmd_t native_pmdp_get_and_
 #define native_pmdp_get_and_clear(xp) native_local_pmdp_get_and_clear(xp)
 #endif
 
-/*
- * Bits 0, 6 and 7 are taken in the low part of the pte,
- * put the 32 bits of offset into the high part.
- *
- * For soft-dirty tracking 11 bit is taken from
- * the low part of pte as well.
- */
-#define pte_to_pgoff(pte) ((pte).pte_high)
-#define pgoff_to_pte(off)						\
-	((pte_t) { { .pte_low = _PAGE_FILE, .pte_high = (off) } })
-#define PTE_FILE_MAX_BITS       32
-
 /* Encode and de-code a swap entry */
 #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > 5)
 #define __swp_type(x)			(((x).val) & 0x1f)
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -115,11 +115,6 @@ static inline int pte_write(pte_t pte)
 	return pte_flags(pte) & _PAGE_RW;
 }
 
-static inline int pte_file(pte_t pte)
-{
-	return pte_flags(pte) & _PAGE_FILE;
-}
-
 static inline int pte_huge(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_PSE;
@@ -329,21 +324,6 @@ static inline pmd_t pmd_mksoft_dirty(pmd
 	return pmd_set_flags(pmd, _PAGE_SOFT_DIRTY);
 }
 
-static inline pte_t pte_file_clear_soft_dirty(pte_t pte)
-{
-	return pte_clear_flags(pte, _PAGE_SOFT_DIRTY);
-}
-
-static inline pte_t pte_file_mksoft_dirty(pte_t pte)
-{
-	return pte_set_flags(pte, _PAGE_SOFT_DIRTY);
-}
-
-static inline int pte_file_soft_dirty(pte_t pte)
-{
-	return pte_flags(pte) & _PAGE_SOFT_DIRTY;
-}
-
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
 /*
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -155,10 +155,6 @@ static inline int pgd_large(pgd_t pgd) {
 /* PUD - Level3 access */
 
 /* PMD  - Level 2 access */
-#define pte_to_pgoff(pte) ((pte_val((pte)) & PHYSICAL_PAGE_MASK) >> PAGE_SHIFT)
-#define pgoff_to_pte(off) ((pte_t) { .pte = ((off) << PAGE_SHIFT) |	\
-					    _PAGE_FILE })
-#define PTE_FILE_MAX_BITS __PHYSICAL_MASK_SHIFT
 
 /* PTE - Level 1 access. */
 
@@ -167,7 +163,7 @@ static inline int pgd_large(pgd_t pgd) {
 #define pte_unmap(pte) ((void)(pte))/* NOP */
 
 /* Encode and de-code a swap entry */
-#define SWP_TYPE_BITS (_PAGE_BIT_FILE - _PAGE_BIT_PRESENT - 1)
+#define SWP_TYPE_BITS 5
 #ifdef CONFIG_NUMA_BALANCING
 /* Automatic NUMA balancing needs to be distinguishable from swap entries */
 #define SWP_OFFSET_SHIFT (_PAGE_BIT_PROTNONE + 2)
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -39,8 +39,6 @@
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
 /* - if the user mapped it with PROT_NONE; pte_present gives true */
 #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
-/* - set: nonlinear file mapping, saved PTE; unset:swap */
-#define _PAGE_BIT_FILE		_PAGE_BIT_DIRTY
 
 #define _PAGE_PRESENT	(_AT(pteval_t, 1) << _PAGE_BIT_PRESENT)
 #define _PAGE_RW	(_AT(pteval_t, 1) << _PAGE_BIT_RW)
@@ -115,7 +113,6 @@
 #define _PAGE_NX	(_AT(pteval_t, 0))
 #endif
 
-#define _PAGE_FILE	(_AT(pteval_t, 1) << _PAGE_BIT_FILE)
 #define _PAGE_PROTNONE  (_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |	\

