Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963B1C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348320880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6348320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51774 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728536AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000H0-Kw; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006vS-36; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Chen Liqin" <liqin.linux@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Lennox Wu" <lennox.wu@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.848379423@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 082/131] score: drop _PAGE_FILE and pte_file()-related
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

commit 917e401ea75478d4f4575bc8b0ef3d14ecf9ef69 upstream.

We've replaced remap_file_pages(2) implementation with emulation.
Nobody creates non-linear mapping anymore.

This patch also increase number of bits availble for swap offset.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Chen Liqin <liqin.linux@gmail.com>
Cc: Lennox Wu <lennox.wu@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/score/include/asm/pgtable-bits.h |  1 -
 arch/score/include/asm/pgtable.h      | 18 ++----------------
 2 files changed, 2 insertions(+), 17 deletions(-)

--- a/arch/score/include/asm/pgtable-bits.h
+++ b/arch/score/include/asm/pgtable-bits.h
@@ -6,7 +6,6 @@
 #define _PAGE_WRITE			(1<<7)	/* implemented in software */
 #define _PAGE_PRESENT			(1<<9)	/* implemented in software */
 #define _PAGE_MODIFIED			(1<<10)	/* implemented in software */
-#define _PAGE_FILE			(1<<10)
 
 #define _PAGE_GLOBAL			(1<<0)
 #define _PAGE_VALID			(1<<1)
--- a/arch/score/include/asm/pgtable.h
+++ b/arch/score/include/asm/pgtable.h
@@ -90,15 +90,6 @@ static inline void pmd_clear(pmd_t *pmdp
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
 #define pte_unmap(pte) ((void)(pte))
 
-/*
- * Bits 9(_PAGE_PRESENT) and 10(_PAGE_FILE)are taken,
- * split up 30 bits of offset into this range:
- */
-#define PTE_FILE_MAX_BITS	30
-#define pte_to_pgoff(_pte)		\
-	(((_pte).pte & 0x1ff) | (((_pte).pte >> 11) << 9))
-#define pgoff_to_pte(off)		\
-	((pte_t) {((off) & 0x1ff) | (((off) >> 9) << 11) | _PAGE_FILE})
 #define __pte_to_swp_entry(pte)		\
 	((swp_entry_t) { pte_val(pte)})
 #define __swp_entry_to_pte(x)	((pte_t) {(x).val})
@@ -169,8 +160,8 @@ static inline pgprot_t pgprot_noncached(
 }
 
 #define __swp_type(x)		((x).val & 0x1f)
-#define __swp_offset(x) 	((x).val >> 11)
-#define __swp_entry(type, offset) ((swp_entry_t){(type) | ((offset) << 11)})
+#define __swp_offset(x) 	((x).val >> 10)
+#define __swp_entry(type, offset) ((swp_entry_t){(type) | ((offset) << 10)})
 
 extern unsigned long empty_zero_page;
 extern unsigned long zero_page_mask;
@@ -198,11 +189,6 @@ static inline int pte_young(pte_t pte)
 	return pte_val(pte) & _PAGE_ACCESSED;
 }
 
-static inline int pte_file(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_FILE;
-}
-
 #define pte_special(pte)	(0)
 
 static inline pte_t pte_wrprotect(pte_t pte)

