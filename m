Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81708C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1ED2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1ED2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeI3EYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:24:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51810 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728564AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000Gs-FB; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006vm-7w; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Richard Weinberger" <richard@nod.at>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Jeff Dike" <jdike@addtoit.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.743352770@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 086/131] um: drop _PAGE_FILE and pte_file()-related
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

commit 3513006a5691ae3629eef9ddef0b71a47c40dfbc upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/um/include/asm/pgtable-2level.h |  9 ---------
 arch/um/include/asm/pgtable-3level.h | 20 --------------------
 arch/um/include/asm/pgtable.h        |  9 ---------
 3 files changed, 38 deletions(-)

--- a/arch/um/include/asm/pgtable-2level.h
+++ b/arch/um/include/asm/pgtable-2level.h
@@ -41,13 +41,4 @@ static inline void pgd_mkuptodate(pgd_t
 #define pfn_pte(pfn, prot) __pte(pfn_to_phys(pfn) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot) __pmd(pfn_to_phys(pfn) | pgprot_val(prot))
 
-/*
- * Bits 0 through 4 are taken
- */
-#define PTE_FILE_MAX_BITS	27
-
-#define pte_to_pgoff(pte) (pte_val(pte) >> 5)
-
-#define pgoff_to_pte(off) ((pte_t) { ((off) << 5) + _PAGE_FILE })
-
 #endif
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -112,25 +112,5 @@ static inline pmd_t pfn_pmd(pfn_t page_n
 	return __pmd((page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
 }
 
-/*
- * Bits 0 through 3 are taken in the low part of the pte,
- * put the 32 bits of offset into the high part.
- */
-#define PTE_FILE_MAX_BITS	32
-
-#ifdef CONFIG_64BIT
-
-#define pte_to_pgoff(p) ((p).pte >> 32)
-
-#define pgoff_to_pte(off) ((pte_t) { ((off) << 32) | _PAGE_FILE })
-
-#else
-
-#define pte_to_pgoff(pte) ((pte).pte_high)
-
-#define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
-
-#endif
-
 #endif
 
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -18,7 +18,6 @@
 #define _PAGE_ACCESSED	0x080
 #define _PAGE_DIRTY	0x100
 /* If _PAGE_PRESENT is clear, we use these: */
-#define _PAGE_FILE	0x008	/* nonlinear file mapping, saved PTE; unset:swap */
 #define _PAGE_PROTNONE	0x010	/* if the user mapped it with PROT_NONE;
 				   pte_present gives true */
 
@@ -151,14 +150,6 @@ static inline int pte_write(pte_t pte)
 	       !(pte_get_bits(pte, _PAGE_PROTNONE)));
 }
 
-/*
- * The following only works if pte_present() is not true.
- */
-static inline int pte_file(pte_t pte)
-{
-	return pte_get_bits(pte, _PAGE_FILE);
-}
-
 static inline int pte_dirty(pte_t pte)
 {
 	return pte_get_bits(pte, _PAGE_DIRTY);

