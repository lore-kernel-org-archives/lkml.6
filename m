Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4E5C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7554720880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7554720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeI3EZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:25:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51788 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728552AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000HA-QY; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006uj-OI; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.911672866@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 073/131] m32r: drop _PAGE_FILE and pte_file()-related
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

commit 406b16e26d0996516c8d1641008a7d326bf282d6 upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/m32r/include/asm/pgtable-2level.h |  4 ----
 arch/m32r/include/asm/pgtable.h        | 11 -----------
 2 files changed, 15 deletions(-)

--- a/arch/m32r/include/asm/pgtable-2level.h
+++ b/arch/m32r/include/asm/pgtable-2level.h
@@ -70,9 +70,5 @@ static inline pmd_t *pmd_offset(pgd_t *
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
-#define PTE_FILE_MAX_BITS	29
-#define pte_to_pgoff(pte)	(((pte_val(pte) >> 2) & 0x7f) | (((pte_val(pte) >> 10)) << 7))
-#define pgoff_to_pte(off)	((pte_t) { (((off) & 0x7f) << 2) | (((off) >> 7) << 10) | _PAGE_FILE })
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_M32R_PGTABLE_2LEVEL_H */
--- a/arch/m32r/include/asm/pgtable.h
+++ b/arch/m32r/include/asm/pgtable.h
@@ -80,8 +80,6 @@ extern unsigned long empty_zero_page[102
  */
 
 #define _PAGE_BIT_DIRTY		0	/* software: page changed */
-#define _PAGE_BIT_FILE		0	/* when !present: nonlinear file
-					   mapping */
 #define _PAGE_BIT_PRESENT	1	/* Valid: page is valid */
 #define _PAGE_BIT_GLOBAL	2	/* Global */
 #define _PAGE_BIT_LARGE		3	/* Large */
@@ -93,7 +91,6 @@ extern unsigned long empty_zero_page[102
 #define _PAGE_BIT_PROTNONE	9	/* software: if not present */
 
 #define _PAGE_DIRTY		(1UL << _PAGE_BIT_DIRTY)
-#define _PAGE_FILE		(1UL << _PAGE_BIT_FILE)
 #define _PAGE_PRESENT		(1UL << _PAGE_BIT_PRESENT)
 #define _PAGE_GLOBAL		(1UL << _PAGE_BIT_GLOBAL)
 #define _PAGE_LARGE		(1UL << _PAGE_BIT_LARGE)
@@ -206,14 +203,6 @@ static inline int pte_write(pte_t pte)
 	return pte_val(pte) & _PAGE_WRITE;
 }
 
-/*
- * The following only works if pte_present() is not true.
- */
-static inline int pte_file(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_FILE;
-}
-
 static inline int pte_special(pte_t pte)
 {
 	return 0;

