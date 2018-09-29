Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBE3C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0FB20880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0FB20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeI3EXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:23:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51954 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728713AbeI3ESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:32 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000Gt-R8; Sat, 29 Sep 2018 22:48:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006uA-Fh; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Hans-Christian Egtvedt" <egtvedt@samfundet.no>,
        "Haavard Skinnemoen" <hskinnemoen@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.514385498@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 066/131] avr32: drop _PAGE_FILE and pte_file()-related
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

commit 7a7d2db4b8b3505a3195178619ffcc80985c4be1 upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/avr32/include/asm/pgtable.h | 25 -------------------------
 1 file changed, 25 deletions(-)

--- a/arch/avr32/include/asm/pgtable.h
+++ b/arch/avr32/include/asm/pgtable.h
@@ -86,9 +86,6 @@ extern struct page *empty_zero_page;
 #define _PAGE_BIT_PRESENT	10
 #define _PAGE_BIT_ACCESSED	11 /* software: page was accessed */
 
-/* The following flags are only valid when !PRESENT */
-#define _PAGE_BIT_FILE		0 /* software: pagecache or swap? */
-
 #define _PAGE_WT		(1 << _PAGE_BIT_WT)
 #define _PAGE_DIRTY		(1 << _PAGE_BIT_DIRTY)
 #define _PAGE_EXECUTE		(1 << _PAGE_BIT_EXECUTE)
@@ -101,7 +98,6 @@ extern struct page *empty_zero_page;
 /* Software flags */
 #define _PAGE_ACCESSED		(1 << _PAGE_BIT_ACCESSED)
 #define _PAGE_PRESENT		(1 << _PAGE_BIT_PRESENT)
-#define _PAGE_FILE		(1 << _PAGE_BIT_FILE)
 
 /*
  * Page types, i.e. sizes. _PAGE_TYPE_NONE corresponds to what is
@@ -210,14 +206,6 @@ static inline int pte_special(pte_t pte)
 	return 0;
 }
 
-/*
- * The following only work if pte_present() is not true.
- */
-static inline int pte_file(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_FILE;
-}
-
 /* Mutator functions for PTE bits */
 static inline pte_t pte_wrprotect(pte_t pte)
 {
@@ -329,7 +317,6 @@ extern void update_mmu_cache(struct vm_a
  * Encode and decode a swap entry
  *
  * Constraints:
- *   _PAGE_FILE at bit 0
  *   _PAGE_TYPE_* at bits 2-3 (for emulating _PAGE_PROTNONE)
  *   _PAGE_PRESENT at bit 10
  *
@@ -346,18 +333,6 @@ extern void update_mmu_cache(struct vm_a
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-/*
- * Encode and decode a nonlinear file mapping entry. We have to
- * preserve _PAGE_FILE and _PAGE_PRESENT here. _PAGE_TYPE_* isn't
- * necessary, since _PAGE_FILE implies !_PAGE_PROTNONE (?)
- */
-#define PTE_FILE_MAX_BITS	30
-#define pte_to_pgoff(pte)	(((pte_val(pte) >> 1) & 0x1ff)		\
-				 | ((pte_val(pte) >> 11) << 9))
-#define pgoff_to_pte(off)	((pte_t) { ((((off) & 0x1ff) << 1)	\
-					    | (((off) >> 9) << 11)	\
-					    | _PAGE_FILE) })
-
 typedef pte_t *pte_addr_t;
 
 #define kern_addr_valid(addr)	(1)

