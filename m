Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769B9C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1E52087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1E52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeI3E0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:26:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51748 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727985AbeI3ES2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:28 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N66-0000HA-4k; Sat, 29 Sep 2018 22:48:22 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006wL-GN; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Minchan Kim" <minchan@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Zi Yan" <zi.yan@cs.rutgers.edu>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Anshuman Khandual" <khandual@linux.vnet.ibm.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        "Ingo Molnar" <mingo@elte.hu>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David Nellans" <dnellans@nvidia.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.976276189@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 093/131] mm: x86: move _PAGE_SWP_SOFT_DIRTY from bit
 7 to bit 1
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

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

commit eee4818baac0f2b37848fdf90e4b16430dc536ac upstream.

_PAGE_PSE is used to distinguish between a truly non-present
(_PAGE_PRESENT=0) PMD, and a PMD which is undergoing a THP split and
should be treated as present.

But _PAGE_SWP_SOFT_DIRTY currently uses the _PAGE_PSE bit, which would
cause confusion between one of those PMDs undergoing a THP split, and a
soft-dirty PMD.  Dropping _PAGE_PSE check in pmd_present() does not work
well, because it can hurt optimization of tlb handling in thp split.

Thus, we need to move the bit.

In the current kernel, bits 1-4 are not used in non-present format since
commit 00839ee3b299 ("x86/mm: Move swap offset/type up in PTE to work
around erratum").  So let's move _PAGE_SWP_SOFT_DIRTY to bit 1.  Bit 7
is used as reserved (always clear), so please don't use it for other
purpose.

Link: http://lkml.kernel.org/r/20170717193955.20207-3-zi.yan@sent.com
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: David Nellans <dnellans@nvidia.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: Bit 9 may be reserved for PAGE_BIT_NUMA here]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/pgtable_64.h    | 12 +++++++++---
 arch/x86/include/asm/pgtable_types.h | 10 +++++-----
 2 files changed, 14 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -165,15 +165,21 @@ static inline int pgd_large(pgd_t pgd) {
 /*
  * Encode and de-code a swap entry
  *
- * |     ...                | 11| 10|  9|8|7|6|5| 4| 3|2|1|0| <- bit number
- * |     ...                |SW3|SW2|SW1|G|L|D|A|CD|WT|U|W|P| <- bit names
- * | OFFSET (15->63) | TYPE (10-14) | 0 |0|X|X|X| X| X|X|X|0| <- swp entry
+ * |     ...                | 11| 10|  9|8|7|6|5| 4| 3|2| 1|0| <- bit number
+ * |     ...                |SW3|SW2|SW1|G|L|D|A|CD|WT|U| W|P| <- bit names
+ * | OFFSET (15->63) | TYPE (10-14) | 0 |0|0|X|X| X| X|X|SD|0| <- swp entry
  *
  * G (8) is aliased and used as a PROT_NONE indicator for
  * !present ptes.  We need to start storing swap entries above
  * there.  We also need to avoid using A and D because of an
  * erratum where they can be incorrectly set by hardware on
  * non-present PTEs.
+ *
+ * SD (1) in swp entry is used to store soft dirty bit, which helps us
+ * remember soft dirty over page migration
+ *
+ * Bit 7 in swp entry should be 0 because pmd_present checks not only P,
+ * but also L and G.
  */
 #ifdef CONFIG_NUMA_BALANCING
 /* Automatic NUMA balancing needs to be distinguishable from swap entries */
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -94,15 +94,15 @@
 /*
  * Tracking soft dirty bit when a page goes to a swap is tricky.
  * We need a bit which can be stored in pte _and_ not conflict
- * with swap entry format. On x86 bits 6 and 7 are *not* involved
- * into swap entry computation, but bit 6 is used for nonlinear
- * file mapping, so we borrow bit 7 for soft dirty tracking.
+ * with swap entry format. On x86 bits 1-4 are *not* involved
+ * into swap entry computation, but bit 7 is used for thp migration,
+ * so we borrow bit 1 for soft dirty tracking.
  *
  * Please note that this bit must be treated as swap dirty page
- * mark if and only if the PTE has present bit clear!
+ * mark if and only if the PTE/PMD has present bit clear!
  */
 #ifdef CONFIG_MEM_SOFT_DIRTY
-#define _PAGE_SWP_SOFT_DIRTY	_PAGE_PSE
+#define _PAGE_SWP_SOFT_DIRTY	_PAGE_RW
 #else
 #define _PAGE_SWP_SOFT_DIRTY	(_AT(pteval_t, 0))
 #endif

