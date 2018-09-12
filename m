Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44DBC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643C7206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643C7206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeILFrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:47:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:11341 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbeILFrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:47:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 17:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="69284006"
Received: from unknown (HELO yhuang-mobile.sh.intel.com) ([10.239.198.87])
  by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2018 17:45:13 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH -V5 RESEND 16/21] swap: Free PMD swap mapping when zap_huge_pmd()
Date:   Wed, 12 Sep 2018 08:44:09 +0800
Message-Id: <20180912004414.22583-17-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180912004414.22583-1-ying.huang@intel.com>
References: <20180912004414.22583-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a PMD swap mapping, zap_huge_pmd() will clear the PMD and call
free_swap_and_cache() to decrease the swap reference count and maybe
free or split the huge swap cluster and the THP in swap cache.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
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
 mm/huge_memory.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4e2230583c53..d4e8b4f80543 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2024,7 +2024,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		if (is_huge_zero_pmd(orig_pmd))
 			tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
-	} else if (is_huge_zero_pmd(orig_pmd)) {
+	} else if (pmd_present(orig_pmd) && is_huge_zero_pmd(orig_pmd)) {
 		zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 		tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
@@ -2037,17 +2037,27 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			page_remove_rmap(page, true);
 			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
-		} else if (thp_migration_supported()) {
-			swp_entry_t entry;
-
-			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
-			entry = pmd_to_swp_entry(orig_pmd);
-			page = pfn_to_page(swp_offset(entry));
+		} else {
+			swp_entry_t entry = pmd_to_swp_entry(orig_pmd);
+
+			if (thp_migration_supported() &&
+			    is_migration_entry(entry))
+				page = pfn_to_page(swp_offset(entry));
+			else if (IS_ENABLED(CONFIG_THP_SWAP) &&
+				 !non_swap_entry(entry))
+				free_swap_and_cache(entry, HPAGE_PMD_NR);
+			else {
+				WARN_ONCE(1,
+"Non present huge pmd without pmd migration or swap enabled!");
+				goto unlock;
+			}
 			flush_needed = 0;
-		} else
-			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
+		}
 
-		if (PageAnon(page)) {
+		if (!page) {
+			zap_deposited_table(tlb->mm, pmd);
+			add_mm_counter(tlb->mm, MM_SWAPENTS, -HPAGE_PMD_NR);
+		} else if (PageAnon(page)) {
 			zap_deposited_table(tlb->mm, pmd);
 			add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR);
 		} else {
@@ -2055,7 +2065,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				zap_deposited_table(tlb->mm, pmd);
 			add_mm_counter(tlb->mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		}
-
+unlock:
 		spin_unlock(ptl);
 		if (flush_needed)
 			tlb_remove_page_size(tlb, page, HPAGE_PMD_SIZE);
-- 
2.16.4

