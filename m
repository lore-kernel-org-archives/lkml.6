Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934423AbeEIIoy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:44:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:19279 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934205AbeEIIj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:39:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="52769729"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Shaohua Li <shli@kernel.org>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: [PATCH -mm -V2 16/21] mm, THP, swap: Free PMD swap mapping when zap_huge_pmd()
Date: Wed,  9 May 2018 16:38:41 +0800
Message-Id: <20180509083846.14823-17-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180509083846.14823-1-ying.huang@intel.com>
References: <20180509083846.14823-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

For a PMD swap mapping, zap_huge_pmd() will clear the PMD and call
free_swap_and_cache() to decrease the swap reference count and maybe
free or split the huge swap cluster and the THP in swap cache.

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
---
 mm/huge_memory.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6f3129c068bc..154316bb34bb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2010,7 +2010,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		if (is_huge_zero_pmd(orig_pmd))
 			tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
-	} else if (is_huge_zero_pmd(orig_pmd)) {
+	} else if (pmd_present(orig_pmd) && is_huge_zero_pmd(orig_pmd)) {
 		zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 		tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
@@ -2023,17 +2023,27 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
+			else if (thp_swap_supported() &&
+				 !non_swap_entry(entry))
+				free_swap_and_cache(entry, true);
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
@@ -2041,7 +2051,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				zap_deposited_table(tlb->mm, pmd);
 			add_mm_counter(tlb->mm, MM_FILEPAGES, -HPAGE_PMD_NR);
 		}
-
+unlock:
 		spin_unlock(ptl);
 		if (flush_needed)
 			tlb_remove_page_size(tlb, page, HPAGE_PMD_SIZE);
-- 
2.16.1
