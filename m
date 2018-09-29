Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19918C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35732087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35732087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeI3EZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:25:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51787 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728550AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000H9-QM; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006ue-N8; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Tony Luck" <tony.luck@intel.com>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.587827206@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 072/131] ia64: drop _PAGE_FILE and pte_file()-related
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

commit 636a002b704e0a36cefb5f4cf0293fab858fc46c upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

This patch also increase number of bits availble for swap offset.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/ia64/include/asm/pgtable.h | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -57,9 +57,6 @@
 #define _PAGE_ED		(__IA64_UL(1) << 52)	/* exception deferral */
 #define _PAGE_PROTNONE		(__IA64_UL(1) << 63)
 
-/* Valid only for a PTE with the present bit cleared: */
-#define _PAGE_FILE		(1 << 1)		/* see swap & file pte remarks below */
-
 #define _PFN_MASK		_PAGE_PPN_MASK
 /* Mask of bits which may be changed by pte_modify(); the odd bits are there for _PAGE_PROTNONE */
 #define _PAGE_CHG_MASK	(_PAGE_P | _PAGE_PROTNONE | _PAGE_PL_MASK | _PAGE_AR_MASK | _PAGE_ED)
@@ -300,7 +297,6 @@ extern unsigned long VMALLOC_END;
 #define pte_exec(pte)		((pte_val(pte) & _PAGE_AR_RX) != 0)
 #define pte_dirty(pte)		((pte_val(pte) & _PAGE_D) != 0)
 #define pte_young(pte)		((pte_val(pte) & _PAGE_A) != 0)
-#define pte_file(pte)		((pte_val(pte) & _PAGE_FILE) != 0)
 #define pte_special(pte)	0
 
 /*
@@ -472,27 +468,16 @@ extern void paging_init (void);
  *
  * Format of swap pte:
  *	bit   0   : present bit (must be zero)
- *	bit   1   : _PAGE_FILE (must be zero)
- *	bits  2- 8: swap-type
- *	bits  9-62: swap offset
- *	bit  63   : _PAGE_PROTNONE bit
- *
- * Format of file pte:
- *	bit   0   : present bit (must be zero)
- *	bit   1   : _PAGE_FILE (must be one)
- *	bits  2-62: file_offset/PAGE_SIZE
+ *	bits  1- 7: swap-type
+ *	bits  8-62: swap offset
  *	bit  63   : _PAGE_PROTNONE bit
  */
-#define __swp_type(entry)		(((entry).val >> 2) & 0x7f)
-#define __swp_offset(entry)		(((entry).val << 1) >> 10)
-#define __swp_entry(type,offset)	((swp_entry_t) { ((type) << 2) | ((long) (offset) << 9) })
+#define __swp_type(entry)		(((entry).val >> 1) & 0x7f)
+#define __swp_offset(entry)		(((entry).val << 1) >> 9)
+#define __swp_entry(type,offset)	((swp_entry_t) { ((type) << 1) | ((long) (offset) << 8) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-#define PTE_FILE_MAX_BITS		61
-#define pte_to_pgoff(pte)		((pte_val(pte) << 1) >> 3)
-#define pgoff_to_pte(off)		((pte_t) { ((off) << 2) | _PAGE_FILE })
-
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..

