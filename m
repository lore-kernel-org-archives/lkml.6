Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64827C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3179E2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3179E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeI3EZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:25:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51800 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728560AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000H7-QT; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006vD-Vd; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jonas Bonn" <jonas@southpole.se>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.123664619@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 079/131] openrisc: drop _PAGE_FILE and
 pte_file()-related helpers
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

commit 3824e3cf7e865b2ff0b71de23b16e332fe6a853a upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jonas Bonn <jonas@southpole.se>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/openrisc/include/asm/pgtable.h | 8 --------
 arch/openrisc/kernel/head.S         | 5 -----
 2 files changed, 13 deletions(-)

--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -125,7 +125,6 @@ extern void paging_init(void);
 #define _PAGE_CC       0x001 /* software: pte contains a translation */
 #define _PAGE_CI       0x002 /* cache inhibit          */
 #define _PAGE_WBC      0x004 /* write back cache       */
-#define _PAGE_FILE     0x004 /* set: pagecache, unset: swap (when !PRESENT) */
 #define _PAGE_WOM      0x008 /* weakly ordered memory  */
 
 #define _PAGE_A        0x010 /* accessed               */
@@ -240,7 +239,6 @@ static inline int pte_write(pte_t pte) {
 static inline int pte_exec(pte_t pte)  { return pte_val(pte) & _PAGE_EXEC; }
 static inline int pte_dirty(pte_t pte) { return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte) { return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)  { return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_special(pte_t pte) { return 0; }
 static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
@@ -438,12 +436,6 @@ static inline void update_mmu_cache(stru
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-/* Encode and decode a nonlinear file mapping entry */
-
-#define PTE_FILE_MAX_BITS               26
-#define pte_to_pgoff(x)	                (pte_val(x) >> 6)
-#define pgoff_to_pte(x)	                __pte(((x) << 6) | _PAGE_FILE)
-
 #define kern_addr_valid(addr)           (1)
 
 #include <asm-generic/pgtable.h>
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -754,11 +754,6 @@ _dc_enable:
 
 /* ===============================================[ page table masks ]=== */
 
-/* bit 4 is used in hardware as write back cache bit. we never use this bit
- * explicitly, so we can reuse it as _PAGE_FILE bit and mask it out when
- * writing into hardware pte's
- */
-
 #define DTLB_UP_CONVERT_MASK  0x3fa
 #define ITLB_UP_CONVERT_MASK  0x3a
 

