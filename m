Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6766AC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA172087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA172087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeI3EYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:24:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51798 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728563AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000H8-QH; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006uo-PY; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.771351616@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 074/131] m68k: drop _PAGE_FILE and pte_file()-related
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

From: "Kirill A. Shutemov" <kirill@shutemov.name>

commit 1eeda0abf4425c91e7ce3ca32f1908c3a51bf84e upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/m68k/include/asm/mcf_pgtable.h      | 23 ++---------------------
 arch/m68k/include/asm/motorola_pgtable.h | 15 ---------------
 arch/m68k/include/asm/pgtable_no.h       |  2 --
 arch/m68k/include/asm/sun3_pgtable.h     | 15 ---------------
 4 files changed, 2 insertions(+), 53 deletions(-)

--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -35,7 +35,6 @@
  * hitting hardware.
  */
 #define CF_PAGE_DIRTY		0x00000001
-#define CF_PAGE_FILE		0x00000200
 #define CF_PAGE_ACCESSED	0x00001000
 
 #define _PAGE_CACHE040		0x020   /* 68040 cache mode, cachable, copyback */
@@ -243,11 +242,6 @@ static inline int pte_young(pte_t pte)
 	return pte_val(pte) & CF_PAGE_ACCESSED;
 }
 
-static inline int pte_file(pte_t pte)
-{
-	return pte_val(pte) & CF_PAGE_FILE;
-}
-
 static inline int pte_special(pte_t pte)
 {
 	return 0;
@@ -391,26 +385,13 @@ static inline void cache_page(void *vadd
 	*ptep = pte_mkcache(*ptep);
 }
 
-#define PTE_FILE_MAX_BITS	21
-#define PTE_FILE_SHIFT		11
-
-static inline unsigned long pte_to_pgoff(pte_t pte)
-{
-	return pte_val(pte) >> PTE_FILE_SHIFT;
-}
-
-static inline pte_t pgoff_to_pte(unsigned pgoff)
-{
-	return __pte((pgoff << PTE_FILE_SHIFT) + CF_PAGE_FILE);
-}
-
 /*
  * Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e))
  */
 #define __swp_type(x)		((x).val & 0xFF)
-#define __swp_offset(x)		((x).val >> PTE_FILE_SHIFT)
+#define __swp_offset(x)		((x).val >> 11)
 #define __swp_entry(typ, off)	((swp_entry_t) { (typ) | \
-					(off << PTE_FILE_SHIFT) })
+					(off << 11) })
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	(__pte((x).val))
 
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -28,7 +28,6 @@
 #define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_NOCACHE)
 
 #define _PAGE_PROTNONE	0x004
-#define _PAGE_FILE	0x008	/* pagecache or swap? */
 
 #ifndef __ASSEMBLY__
 
@@ -168,7 +167,6 @@ static inline void pgd_set(pgd_t *pgdp,
 static inline int pte_write(pte_t pte)		{ return !(pte_val(pte) & _PAGE_RONLY); }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |= _PAGE_RONLY; return pte; }
@@ -266,19 +264,6 @@ static inline void cache_page(void *vadd
 	}
 }
 
-#define PTE_FILE_MAX_BITS	28
-
-static inline unsigned long pte_to_pgoff(pte_t pte)
-{
-	return pte.pte >> 4;
-}
-
-static inline pte_t pgoff_to_pte(unsigned off)
-{
-	pte_t pte = { (off << 4) + _PAGE_FILE };
-	return pte;
-}
-
 /* Encode and de-code a swap entry (must be !pte_none(e) && !pte_present(e)) */
 #define __swp_type(x)		(((x).val >> 4) & 0xff)
 #define __swp_offset(x)		((x).val >> 12)
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -37,8 +37,6 @@ extern void paging_init(void);
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-static inline int pte_file(pte_t pte) { return 0; }
-
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -38,8 +38,6 @@
 #define _PAGE_PRESENT	(SUN3_PAGE_VALID)
 #define _PAGE_ACCESSED	(SUN3_PAGE_ACCESSED)
 
-#define PTE_FILE_MAX_BITS 28
-
 /* Compound page protection values. */
 //todo: work out which ones *should* have SUN3_PAGE_NOCACHE and fix...
 // is it just PAGE_KERNEL and PAGE_SHARED?
@@ -168,7 +166,6 @@ static inline void pgd_clear (pgd_t *pgd
 static inline int pte_write(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_WRITEABLE; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_MODIFIED; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)		{ return pte_val(pte) & SUN3_PAGE_ACCESSED; }
 static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &= ~SUN3_PAGE_WRITEABLE; return pte; }
@@ -202,18 +199,6 @@ static inline pmd_t *pmd_offset (pgd_t *
 	return (pmd_t *) pgd;
 }
 
-static inline unsigned long pte_to_pgoff(pte_t pte)
-{
-	return pte.pte & SUN3_PAGE_PGNUM_MASK;
-}
-
-static inline pte_t pgoff_to_pte(unsigned off)
-{
-	pte_t pte = { off + SUN3_PAGE_ACCESSED };
-	return pte;
-}
-
-
 /* Find an entry in the third-level pagetable. */
 #define pte_index(address) ((address >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 #define pte_offset_kernel(pmd, address) ((pte_t *) __pmd_page(*pmd) + pte_index(address))

