Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6869CC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBBB2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBBB2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbeI3E0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:26:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51771 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727997AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000H5-No; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006vX-4K; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.857066697@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 083/131] sh: drop _PAGE_FILE and pte_file()-related
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

commit 8b70beac99466b6d164de9fe647b3567e6f17e3a upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/sh/include/asm/pgtable_32.h | 30 ++++--------------------------
 arch/sh/include/asm/pgtable_64.h |  9 +--------
 2 files changed, 5 insertions(+), 34 deletions(-)

--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -26,8 +26,6 @@
  *   and timing control which (together with bit 0) are moved into the
  *   old-style PTEA on the parts that support it.
  *
- * XXX: Leave the _PAGE_FILE and _PAGE_WT overhaul for a rainy day.
- *
  * SH-X2 MMUs and extended PTEs
  *
  * SH-X2 supports an extended mode TLB with split data arrays due to the
@@ -51,7 +49,6 @@
 #define _PAGE_PRESENT	0x100		/* V-bit   : page is valid */
 #define _PAGE_PROTNONE	0x200		/* software: if not present  */
 #define _PAGE_ACCESSED	0x400		/* software: page referenced */
-#define _PAGE_FILE	_PAGE_WT	/* software: pagecache or swap? */
 #define _PAGE_SPECIAL	0x800		/* software: special page */
 
 #define _PAGE_SZ_MASK	(_PAGE_SZ0 | _PAGE_SZ1)
@@ -105,14 +102,13 @@ static inline unsigned long copy_ptea_at
 /* Mask which drops unused bits from the PTEL value */
 #if defined(CONFIG_CPU_SH3)
 #define _PAGE_CLEAR_FLAGS	(_PAGE_PROTNONE | _PAGE_ACCESSED| \
-				 _PAGE_FILE	| _PAGE_SZ1	| \
-				 _PAGE_HW_SHARED)
+				  _PAGE_SZ1	| _PAGE_HW_SHARED)
 #elif defined(CONFIG_X2TLB)
 /* Get rid of the legacy PR/SZ bits when using extended mode */
 #define _PAGE_CLEAR_FLAGS	(_PAGE_PROTNONE | _PAGE_ACCESSED | \
-				 _PAGE_FILE | _PAGE_PR_MASK | _PAGE_SZ_MASK)
+				 _PAGE_PR_MASK | _PAGE_SZ_MASK)
 #else
-#define _PAGE_CLEAR_FLAGS	(_PAGE_PROTNONE | _PAGE_ACCESSED | _PAGE_FILE)
+#define _PAGE_CLEAR_FLAGS	(_PAGE_PROTNONE | _PAGE_ACCESSED)
 #endif
 
 #define _PAGE_FLAGS_HARDWARE_MASK	(phys_addr_mask() & ~(_PAGE_CLEAR_FLAGS))
@@ -343,7 +339,6 @@ static inline void set_pte(pte_t *ptep,
 #define pte_not_present(pte)	(!((pte).pte_low & _PAGE_PRESENT))
 #define pte_dirty(pte)		((pte).pte_low & _PAGE_DIRTY)
 #define pte_young(pte)		((pte).pte_low & _PAGE_ACCESSED)
-#define pte_file(pte)		((pte).pte_low & _PAGE_FILE)
 #define pte_special(pte)	((pte).pte_low & _PAGE_SPECIAL)
 
 #ifdef CONFIG_X2TLB
@@ -445,7 +440,6 @@ static inline pte_t pte_modify(pte_t pte
  * Encode and de-code a swap entry
  *
  * Constraints:
- *	_PAGE_FILE at bit 0
  *	_PAGE_PRESENT at bit 8
  *	_PAGE_PROTNONE at bit 9
  *
@@ -453,9 +447,7 @@ static inline pte_t pte_modify(pte_t pte
  * swap offset into bits 10:30. For the 64-bit PTE case, we keep the
  * preserved bits in the low 32-bits and use the upper 32 as the swap
  * offset (along with a 5-bit type), following the same approach as x86
- * PAE. This keeps the logic quite simple, and allows for a full 32
- * PTE_FILE_MAX_BITS, as opposed to the 29-bits we're constrained with
- * in the pte_low case.
+ * PAE. This keeps the logic quite simple.
  *
  * As is evident by the Alpha code, if we ever get a 64-bit unsigned
  * long (swp_entry_t) to match up with the 64-bit PTEs, this all becomes
@@ -471,13 +463,6 @@ static inline pte_t pte_modify(pte_t pte
 #define __pte_to_swp_entry(pte)		((swp_entry_t){ (pte).pte_high })
 #define __swp_entry_to_pte(x)		((pte_t){ 0, (x).val })
 
-/*
- * Encode and decode a nonlinear file mapping entry
- */
-#define pte_to_pgoff(pte)		((pte).pte_high)
-#define pgoff_to_pte(off)		((pte_t) { _PAGE_FILE, (off) })
-
-#define PTE_FILE_MAX_BITS		32
 #else
 #define __swp_type(x)			((x).val & 0xff)
 #define __swp_offset(x)			((x).val >> 10)
@@ -485,13 +470,6 @@ static inline pte_t pte_modify(pte_t pte
 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 1 })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 1 })
-
-/*
- * Encode and decode a nonlinear file mapping entry
- */
-#define PTE_FILE_MAX_BITS	29
-#define pte_to_pgoff(pte)	(pte_val(pte) >> 1)
-#define pgoff_to_pte(off)	((pte_t) { ((off) << 1) | _PAGE_FILE })
 #endif
 
 #endif /* __ASSEMBLY__ */
--- a/arch/sh/include/asm/pgtable_64.h
+++ b/arch/sh/include/asm/pgtable_64.h
@@ -107,7 +107,6 @@ static __inline__ void set_pte(pte_t *pt
 #define _PAGE_DEVICE	0x001  /* CB0: if uncacheable, 1->device (i.e. no write-combining or reordering at bus level) */
 #define _PAGE_CACHABLE	0x002  /* CB1: uncachable/cachable */
 #define _PAGE_PRESENT	0x004  /* software: page referenced */
-#define _PAGE_FILE	0x004  /* software: only when !present */
 #define _PAGE_SIZE0	0x008  /* SZ0-bit : size of page */
 #define _PAGE_SIZE1	0x010  /* SZ1-bit : size of page */
 #define _PAGE_SHARED	0x020  /* software: reflects PTEH's SH */
@@ -129,7 +128,7 @@ static __inline__ void set_pte(pte_t *pt
 #define _PAGE_WIRED	_PAGE_EXT(0x001) /* software: wire the tlb entry */
 #define _PAGE_SPECIAL	_PAGE_EXT(0x002)
 
-#define _PAGE_CLEAR_FLAGS	(_PAGE_PRESENT | _PAGE_FILE | _PAGE_SHARED | \
+#define _PAGE_CLEAR_FLAGS	(_PAGE_PRESENT | _PAGE_SHARED | \
 				 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_WIRED)
 
 /* Mask which drops software flags */
@@ -260,7 +259,6 @@ static __inline__ void set_pte(pte_t *pt
  */
 static inline int pte_dirty(pte_t pte)  { return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)  { return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)   { return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_write(pte_t pte)  { return pte_val(pte) & _PAGE_WRITE; }
 static inline int pte_special(pte_t pte){ return pte_val(pte) & _PAGE_SPECIAL; }
 
@@ -304,11 +302,6 @@ static inline pte_t pte_modify(pte_t pte
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-/* Encode and decode a nonlinear file mapping entry */
-#define PTE_FILE_MAX_BITS		29
-#define pte_to_pgoff(pte)		(pte_val(pte))
-#define pgoff_to_pte(off)		((pte_t) { (off) | _PAGE_FILE })
-
 #endif /* !__ASSEMBLY__ */
 
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))

