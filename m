Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52769C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AFB2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AFB2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeI3ESa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51777 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728535AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000Gu-EV; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006w6-DZ; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Paul Mackerras" <paulus@samba.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.218981167@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 090/131] powerpc: drop _PAGE_FILE and pte_file()-related
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

commit 780fc5642f59b6c6e2b05794de60b2d2ad5f040e upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/include/asm/pgtable-ppc32.h | 9 ++-------
 arch/powerpc/include/asm/pgtable-ppc64.h | 5 +----
 arch/powerpc/include/asm/pgtable.h       | 1 -
 arch/powerpc/include/asm/pte-40x.h       | 1 -
 arch/powerpc/include/asm/pte-44x.h       | 5 -----
 arch/powerpc/include/asm/pte-8xx.h       | 1 -
 arch/powerpc/include/asm/pte-book3e.h    | 1 -
 arch/powerpc/include/asm/pte-fsl-booke.h | 3 ---
 arch/powerpc/include/asm/pte-hash32.h    | 1 -
 arch/powerpc/include/asm/pte-hash64.h    | 1 -
 arch/powerpc/mm/pgtable_64.c             | 2 +-
 11 files changed, 4 insertions(+), 26 deletions(-)

--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -314,8 +314,8 @@ static inline void __ptep_set_access_fla
 /*
  * Encode and decode a swap entry.
  * Note that the bits we use in a PTE for representing a swap entry
- * must not include the _PAGE_PRESENT bit, the _PAGE_FILE bit, or the
- *_PAGE_HASHPTE bit (if used).  -- paulus
+ * must not include the _PAGE_PRESENT bit or the _PAGE_HASHPTE bit (if used).
+ *   -- paulus
  */
 #define __swp_type(entry)		((entry).val & 0x1f)
 #define __swp_offset(entry)		((entry).val >> 5)
@@ -323,11 +323,6 @@ static inline void __ptep_set_access_fla
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
 
-/* Encode and decode a nonlinear file mapping entry */
-#define PTE_FILE_MAX_BITS	29
-#define pte_to_pgoff(pte)	(pte_val(pte) >> 3)
-#define pgoff_to_pte(off)	((pte_t) { ((off) << 3) | _PAGE_FILE })
-
 /*
  * No page table caches to initialise
  */
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -352,9 +352,6 @@ static inline void __ptep_set_access_fla
 #define __swp_entry(type, offset) ((swp_entry_t){((type)<< 1)|((offset)<<8)})
 #define __pte_to_swp_entry(pte)	((swp_entry_t){pte_val(pte) >> PTE_RPN_SHIFT})
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val << PTE_RPN_SHIFT })
-#define pte_to_pgoff(pte)	(pte_val(pte) >> PTE_RPN_SHIFT)
-#define pgoff_to_pte(off)	((pte_t) {((off) << PTE_RPN_SHIFT)|_PAGE_FILE})
-#define PTE_FILE_MAX_BITS	(BITS_PER_LONG - PTE_RPN_SHIFT)
 
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
@@ -389,7 +386,7 @@ void pgtable_cache_init(void);
  * The last three bits are intentionally left to zero. This memory location
  * are also used as normal page PTE pointers. So if we have any pointers
  * left around while we collapse a hugepage, we need to make sure
- * _PAGE_PRESENT and _PAGE_FILE bits of that are zero when we look at them
+ * _PAGE_PRESENT bit of that is zero when we look at them
  */
 static inline unsigned int hpte_valid(unsigned char *hpte_slot_array, int index)
 {
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -32,7 +32,6 @@ struct mm_struct;
 static inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_RW; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
--- a/arch/powerpc/include/asm/pte-40x.h
+++ b/arch/powerpc/include/asm/pte-40x.h
@@ -38,7 +38,6 @@
  */
 
 #define	_PAGE_GUARDED	0x001	/* G: page is guarded from prefetch */
-#define _PAGE_FILE	0x001	/* when !present: nonlinear file mapping */
 #define _PAGE_PRESENT	0x002	/* software: PTE contains a translation */
 #define	_PAGE_NO_CACHE	0x004	/* I: caching is inhibited */
 #define	_PAGE_WRITETHRU	0x008	/* W: caching is write-through */
--- a/arch/powerpc/include/asm/pte-44x.h
+++ b/arch/powerpc/include/asm/pte-44x.h
@@ -44,9 +44,6 @@
  *   - PRESENT *must* be in the bottom three bits because swap cache
  *     entries use the top 29 bits for TLB2.
  *
- *   - FILE *must* be in the bottom three bits because swap cache
- *     entries use the top 29 bits for TLB2.
- *
  *   - CACHE COHERENT bit (M) has no effect on original PPC440 cores,
  *     because it doesn't support SMP. However, some later 460 variants
  *     have -some- form of SMP support and so I keep the bit there for
@@ -68,7 +65,6 @@
  *
  * There are three protection bits available for SWAP entry:
  *	_PAGE_PRESENT
- *	_PAGE_FILE
  *	_PAGE_HASHPTE (if HW has)
  *
  * So those three bits have to be inside of 0-2nd LSB of PTE.
@@ -77,7 +73,6 @@
 
 #define _PAGE_PRESENT	0x00000001		/* S: PTE valid */
 #define _PAGE_RW	0x00000002		/* S: Write permission */
-#define _PAGE_FILE	0x00000004		/* S: nonlinear file mapping */
 #define _PAGE_EXEC	0x00000004		/* H: Execute permission */
 #define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
 #define _PAGE_DIRTY	0x00000010		/* S: Page dirty */
--- a/arch/powerpc/include/asm/pte-8xx.h
+++ b/arch/powerpc/include/asm/pte-8xx.h
@@ -29,7 +29,6 @@
 
 /* Definitions for 8xx embedded chips. */
 #define _PAGE_PRESENT	0x0001	/* Page is valid */
-#define _PAGE_FILE	0x0002	/* when !present: nonlinear file mapping */
 #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
 #define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
 #define _PAGE_SPECIAL	0x0008	/* SW entry, forced to 0 by the TLB miss */
--- a/arch/powerpc/include/asm/pte-book3e.h
+++ b/arch/powerpc/include/asm/pte-book3e.h
@@ -10,7 +10,6 @@
 
 /* Architected bits */
 #define _PAGE_PRESENT	0x000001 /* software: pte contains a translation */
-#define _PAGE_FILE	0x000002 /* (!present only) software: pte holds file offset */
 #define _PAGE_SW1	0x000002
 #define _PAGE_BAP_SR	0x000004
 #define _PAGE_BAP_UR	0x000008
--- a/arch/powerpc/include/asm/pte-fsl-booke.h
+++ b/arch/powerpc/include/asm/pte-fsl-booke.h
@@ -13,14 +13,11 @@
    - PRESENT *must* be in the bottom three bits because swap cache
      entries use the top 29 bits.
 
-   - FILE *must* be in the bottom three bits because swap cache
-     entries use the top 29 bits.
 */
 
 /* Definitions for FSL Book-E Cores */
 #define _PAGE_PRESENT	0x00001	/* S: PTE contains a translation */
 #define _PAGE_USER	0x00002	/* S: User page (maps to UR) */
-#define _PAGE_FILE	0x00002	/* S: when !present: nonlinear file mapping */
 #define _PAGE_RW	0x00004	/* S: Write permission (SW) */
 #define _PAGE_DIRTY	0x00008	/* S: Page dirty */
 #define _PAGE_EXEC	0x00010	/* H: SX permission */
--- a/arch/powerpc/include/asm/pte-hash32.h
+++ b/arch/powerpc/include/asm/pte-hash32.h
@@ -18,7 +18,6 @@
 
 #define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
 #define _PAGE_HASHPTE	0x002	/* hash_page has made an HPTE for this pte */
-#define _PAGE_FILE	0x004	/* when !present: nonlinear file mapping */
 #define _PAGE_USER	0x004	/* usermode access allowed */
 #define _PAGE_GUARDED	0x008	/* G: prohibit speculative access */
 #define _PAGE_COHERENT	0x010	/* M: enforce memory coherence (SMP systems) */
--- a/arch/powerpc/include/asm/pte-hash64.h
+++ b/arch/powerpc/include/asm/pte-hash64.h
@@ -16,7 +16,6 @@
  */
 #define _PAGE_PRESENT		0x0001 /* software: pte contains a translation */
 #define _PAGE_USER		0x0002 /* matches one of the PP bits */
-#define _PAGE_FILE		0x0002 /* (!present only) software: pte holds file offset */
 #define _PAGE_EXEC		0x0004 /* No execute on POWER4 and newer (we invert) */
 #define _PAGE_GUARDED		0x0008
 /* We can derive Memory coherence from _PAGE_NO_CACHE */
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -807,7 +807,7 @@ pmd_t pfn_pmd(unsigned long pfn, pgprot_
 {
 	pmd_t pmd;
 	/*
-	 * For a valid pte, we would have _PAGE_PRESENT or _PAGE_FILE always
+	 * For a valid pte, we would have _PAGE_PRESENT always
 	 * set. We use this to check THP page at pmd level.
 	 * leaf pte for huge page, bottom two bits != 00
 	 */

