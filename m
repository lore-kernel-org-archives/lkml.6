Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D82C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFD923CC9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFD923CC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934597AbeFVDz7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:55:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:30400 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934385AbeFVDz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:55:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 20:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,255,1526367600"; 
   d="scan'208";a="65335188"
Received: from wanpingl-mobl.ccr.corp.intel.com (HELO yhuang6-ux31a.ccr.corp.intel.com) ([10.254.212.200])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jun 2018 20:55:52 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH -mm -v4 17/21] mm, THP, swap: Support PMD swap mapping for MADV_WILLNEED
Date:   Fri, 22 Jun 2018 11:51:47 +0800
Message-Id: <20180622035151.6676-18-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180622035151.6676-1-ying.huang@intel.com>
References: <20180622035151.6676-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

During MADV_WILLNEED, for a PMD swap mapping, if THP swapin is enabled
for the VMA, the whole swap cluster will be swapin.  Otherwise, the
huge swap cluster and the PMD swap mapping will be split and fallback
to PTE swap mapping.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/madvise.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index fc423d96d4d6..6c7a96357626 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -196,14 +196,36 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	pte_t *orig_pte;
 	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
+	swp_entry_t entry;
+	struct page *page;
+	pmd_t pmdval;
+
+	pmdval = *pmd;
+	if (thp_swap_supported() && is_swap_pmd(pmdval) &&
+	    !is_pmd_migration_entry(pmdval)) {
+		entry = pmd_to_swp_entry(pmdval);
+		if (!transparent_hugepage_swapin_enabled(vma)) {
+			if (!split_swap_cluster(entry, false))
+				split_huge_swap_pmd(vma, pmd, start, pmdval);
+		} else {
+			page = read_swap_cache_async(entry,
+						     GFP_HIGHUSER_MOVABLE,
+						     vma, start, false);
+			/* The swap cluster has been split under us */
+			if (page) {
+				if (!PageTransHuge(page))
+					split_huge_swap_pmd(vma, pmd, start,
+							    pmdval);
+				put_page(page);
+			}
+		}
+	}
 
 	if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 		return 0;
 
 	for (index = start; index != end; index += PAGE_SIZE) {
 		pte_t pte;
-		swp_entry_t entry;
-		struct page *page;
 		spinlock_t *ptl;
 
 		orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
-- 
2.16.4

