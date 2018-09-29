Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58562C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183E62087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183E62087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeI3EYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:24:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51808 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728566AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000H2-Qd; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006v3-TI; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.99212249@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 077/131] mips: drop _PAGE_FILE and pte_file()-related
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

commit b32da82e28ce90bff4e371fc15d2816fa3175bb0 upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: Deleted definitions are slightly different]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -148,20 +148,6 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 #define __swp_entry(type,offset)	\
 	((swp_entry_t) { ((type) << 10) | ((offset) << 15) })
 
-/*
- * Bits 0, 4, 8, and 9 are taken, split up 28 bits of offset into this range:
- */
-#define PTE_FILE_MAX_BITS	28
-
-#define pte_to_pgoff(_pte)	((((_pte).pte >> 1 ) & 0x07) | \
-				 (((_pte).pte >> 2 ) & 0x38) | \
-				 (((_pte).pte >> 10) <<	 6 ))
-
-#define pgoff_to_pte(off)	((pte_t) { (((off) & 0x07) << 1 ) | \
-					   (((off) & 0x38) << 2 ) | \
-					   (((off) >>  6 ) << 10) | \
-					   _PAGE_FILE })
-
 #else
 
 /* Swap entries must have VALID and GLOBAL bits cleared. */
@@ -177,31 +163,6 @@ pfn_pte(unsigned long pfn, pgprot_t prot
 		((swp_entry_t)	{ ((type) << 8) | ((offset) << 13) })
 #endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
 
-#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
-/*
- * Bits 0 and 1 of pte_high are taken, use the rest for the page offset...
- */
-#define PTE_FILE_MAX_BITS	30
-
-#define pte_to_pgoff(_pte)	((_pte).pte_high >> 2)
-#define pgoff_to_pte(off)	((pte_t) { _PAGE_FILE, (off) << 2 })
-
-#else
-/*
- * Bits 0, 4, 6, and 7 are taken, split up 28 bits of offset into this range:
- */
-#define PTE_FILE_MAX_BITS	28
-
-#define pte_to_pgoff(_pte)	((((_pte).pte >> 1) & 0x7) | \
-				 (((_pte).pte >> 2) & 0x8) | \
-				 (((_pte).pte >> 8) <<	4))
-
-#define pgoff_to_pte(off)	((pte_t) { (((off) & 0x7) << 1) | \
-					   (((off) & 0x8) << 2) | \
-					   (((off) >>  4) << 8) | \
-					   _PAGE_FILE })
-#endif
-
 #endif
 
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -291,13 +291,4 @@ static inline pte_t mk_swap_pte(unsigned
 #define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-/*
- * Bits 0, 4, 6, and 7 are taken. Let's leave bits 1, 2, 3, and 5 alone to
- * make things easier, and only use the upper 56 bits for the page offset...
- */
-#define PTE_FILE_MAX_BITS	56
-
-#define pte_to_pgoff(_pte)	((_pte).pte >> 8)
-#define pgoff_to_pte(off)	((pte_t) { ((off) << 8) | _PAGE_FILE })
-
 #endif /* _ASM_PGTABLE_64_H */
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -50,8 +50,6 @@
 
 /*
  * The following bits are implemented in software
- *
- * _PAGE_FILE semantics: set:pagecache unset:swap
  */
 #define _PAGE_PRESENT_SHIFT	6
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
@@ -64,14 +62,10 @@
 #define _PAGE_MODIFIED_SHIFT	10
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
 
-#define _PAGE_FILE		(1 << 10)
-
 #elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
 /*
  * The following are implemented by software
- *
- * _PAGE_FILE semantics: set:pagecache unset:swap
  */
 #define _PAGE_PRESENT_SHIFT	0
 #define _PAGE_PRESENT		(1 <<  _PAGE_PRESENT_SHIFT)
@@ -83,8 +77,6 @@
 #define _PAGE_ACCESSED		(1 <<  _PAGE_ACCESSED_SHIFT)
 #define _PAGE_MODIFIED_SHIFT	4
 #define _PAGE_MODIFIED		(1 <<  _PAGE_MODIFIED_SHIFT)
-#define _PAGE_FILE_SHIFT	4
-#define _PAGE_FILE		(1 <<  _PAGE_FILE_SHIFT)
 
 /*
  * And these are the hardware TLB bits
@@ -114,7 +106,6 @@
  * The following bits are implemented in software
  *
  * _PAGE_READ / _PAGE_READ_SHIFT should be unused if cpu_has_rixi.
- * _PAGE_FILE semantics: set:pagecache unset:swap
  */
 #define _PAGE_PRESENT_SHIFT	(0)
 #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
@@ -126,7 +117,6 @@
 #define _PAGE_ACCESSED		(1 << _PAGE_ACCESSED_SHIFT)
 #define _PAGE_MODIFIED_SHIFT	(_PAGE_ACCESSED_SHIFT + 1)
 #define _PAGE_MODIFIED		(1 << _PAGE_MODIFIED_SHIFT)
-#define _PAGE_FILE		(_PAGE_MODIFIED)
 
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 /* huge tlb page */
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -253,7 +253,6 @@ extern pgd_t swapper_pg_dir[];
 static inline int pte_write(pte_t pte)	{ return pte.pte_low & _PAGE_WRITE; }
 static inline int pte_dirty(pte_t pte)	{ return pte.pte_low & _PAGE_MODIFIED; }
 static inline int pte_young(pte_t pte)	{ return pte.pte_low & _PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)	{ return pte.pte_low & _PAGE_FILE; }
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
@@ -309,7 +308,6 @@ static inline pte_t pte_mkyoung(pte_t pt
 static inline int pte_write(pte_t pte)	{ return pte_val(pte) & _PAGE_WRITE; }
 static inline int pte_dirty(pte_t pte)	{ return pte_val(pte) & _PAGE_MODIFIED; }
 static inline int pte_young(pte_t pte)	{ return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)	{ return pte_val(pte) & _PAGE_FILE; }
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {

