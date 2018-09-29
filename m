Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18433C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D3D2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D3D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeI3EYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:24:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51809 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728565AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000H1-PP; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006uu-Qs; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "James Hogan" <james.hogan@imgtec.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.708442601@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 075/131] metag: drop _PAGE_FILE and pte_file()-related
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

commit 22f9bf3950f20d24198791685f2dccac2c4ef38a upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/metag/include/asm/pgtable.h | 6 ------
 1 file changed, 6 deletions(-)

--- a/arch/metag/include/asm/pgtable.h
+++ b/arch/metag/include/asm/pgtable.h
@@ -47,7 +47,6 @@
  */
 #define _PAGE_ACCESSED		_PAGE_ALWAYS_ZERO_1
 #define _PAGE_DIRTY		_PAGE_ALWAYS_ZERO_2
-#define _PAGE_FILE		_PAGE_ALWAYS_ZERO_3
 
 /* Pages owned, and protected by, the kernel. */
 #define _PAGE_KERNEL		_PAGE_PRIV
@@ -219,7 +218,6 @@ extern unsigned long empty_zero_page;
 static inline int pte_write(pte_t pte)   { return pte_val(pte) & _PAGE_WRITE; }
 static inline int pte_dirty(pte_t pte)   { return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)   { return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)    { return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_special(pte_t pte) { return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte) { pte_val(pte) &= (~_PAGE_WRITE); return pte; }
@@ -327,10 +325,6 @@ static inline void update_mmu_cache(stru
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-#define PTE_FILE_MAX_BITS	22
-#define pte_to_pgoff(x)		(pte_val(x) >> 10)
-#define pgoff_to_pte(x)		__pte(((x) << 10) | _PAGE_FILE)
-
 #define kern_addr_valid(addr)	(1)
 
 /*

