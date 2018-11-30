Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDE5C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8917620834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8917620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeK3Ldg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:33:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:39495 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbeK3Ldg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:33:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 16:26:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,296,1539673200"; 
   d="scan'208";a="113732319"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002.jf.intel.com with ESMTP; 29 Nov 2018 16:26:13 -0800
Subject: [PATCH] dax: Fix Xarray conversion of dax_unlock_mapping_entry()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Nov 2018 16:13:46 -0800
Message-ID: <154353682674.1676897.15440708268545845062.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal to dax_unlock_mapping_entry(), dax_unlock_entry() is used to
store a replacement entry in the Xarray at the given xas-index with the
DAX_LOCKED bit clear. When called, dax_unlock_entry() expects the unlocked
value of the entry relative to the current Xarray state to be specified.

In most contexts dax_unlock_entry() is operating in the same scope as
the matched dax_lock_entry(). However, in the dax_unlock_mapping_entry()
case the implementation needs to recall the original entry. In the case
where the original entry is a 'pmd' entry it is possible that the pfn
performed to do the lookup is misaligned to the value retrieved in the
Xarray.

When creating the 'unlocked' entry be sure to align it to the expected
size as reflected by the DAX_PMD flag. Otherwise, future lookups become
confused by finding a 'pte' aligned value at an index that should return
a 'pmd' aligned value. This mismatch results in failure signatures like
the following:

 WARNING: CPU: 38 PID: 1396 at fs/dax.c:340 dax_insert_entry+0x2b2/0x2d0
 RIP: 0010:dax_insert_entry+0x2b2/0x2d0
 [..]
 Call Trace:
  dax_iomap_pte_fault.isra.41+0x791/0xde0
  ext4_dax_huge_fault+0x16f/0x1f0
  ? up_read+0x1c/0xa0
  __do_fault+0x1f/0x160
  __handle_mm_fault+0x1033/0x1490
  handle_mm_fault+0x18b/0x3d0

...and potential corruption of nearby page state as housekeeping
routines, like dax_disassociate_entry(), may overshoot their expected
bounds starting at the wrong page.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Fixes: 9f32d221301c ("dax: Convert dax_lock_mapping_entry to XArray")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 3f592dc18d67..6c5f8f345b1a 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -59,6 +59,7 @@ static inline unsigned int pe_order(enum page_entry_size pe_size)
 
 /* The order of a PMD entry */
 #define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
+#define PMD_ORDER_MASK	~((1UL << PMD_ORDER) - 1)
 
 static wait_queue_head_t wait_table[DAX_WAIT_TABLE_ENTRIES];
 
@@ -93,9 +94,13 @@ static unsigned long dax_to_pfn(void *entry)
 	return xa_to_value(entry) >> DAX_SHIFT;
 }
 
-static void *dax_make_entry(pfn_t pfn, unsigned long flags)
+static void *dax_make_entry(pfn_t pfn_t, unsigned long flags)
 {
-	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
+	unsigned long pfn = pfn_t_to_pfn(pfn_t);
+
+	if (flags & DAX_PMD)
+		pfn &= PMD_ORDER_MASK;
+	return xa_mk_value(flags | (pfn << DAX_SHIFT));
 }
 
 static bool dax_is_locked(void *entry)

