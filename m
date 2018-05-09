Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934246AbeEIIjs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:39:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:63119 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934205AbeEIIjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:39:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="52769688"
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
Subject: [PATCH -mm -V2 13/21] mm, THP, swap: Support PMD swap mapping in madvise_free()
Date: Wed,  9 May 2018 16:38:38 +0800
Message-Id: <20180509083846.14823-14-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180509083846.14823-1-ying.huang@intel.com>
References: <20180509083846.14823-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

When madvise_free() found a PMD swap mapping, if only part of the huge
swap cluster is operated on, the PMD swap mapping will be split and
fallback to PTE swap mapping processing.  Otherwise, if all huge swap
cluster is operated on, free_swap_and_cache() will be called to
decrease the PMD swap mapping count and probably free the swap space
and the THP in swap cache too.

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
 mm/huge_memory.c | 50 +++++++++++++++++++++++++++++++++++---------------
 mm/madvise.c     |  2 +-
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 26f15fe99931..2f6786425249 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1845,6 +1845,15 @@ static inline void __split_huge_swap_pmd(struct vm_area_struct *vma,
 }
 #endif
 
+static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
+{
+	pgtable_t pgtable;
+
+	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+	pte_free(mm, pgtable);
+	mm_dec_nr_ptes(mm);
+}
+
 /*
  * Return true if we do MADV_FREE successfully on entire pmd page.
  * Otherwise, return false.
@@ -1865,15 +1874,35 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		goto out_unlocked;
 
 	orig_pmd = *pmd;
-	if (is_huge_zero_pmd(orig_pmd))
-		goto out;
-
 	if (unlikely(!pmd_present(orig_pmd))) {
-		VM_BUG_ON(thp_migration_supported() &&
-				  !is_pmd_migration_entry(orig_pmd));
-		goto out;
+		swp_entry_t entry = pmd_to_swp_entry(orig_pmd);
+
+		if (is_migration_entry(entry)) {
+			VM_BUG_ON(!thp_migration_supported());
+			goto out;
+		} else if (thp_swap_supported() && !non_swap_entry(entry)) {
+			/* If part of THP is discarded */
+			if (next - addr != HPAGE_PMD_SIZE) {
+				unsigned long haddr = addr & HPAGE_PMD_MASK;
+
+				__split_huge_swap_pmd(vma, haddr, pmd);
+				goto out;
+			}
+			free_swap_and_cache(entry, true);
+			pmd_clear(pmd);
+			zap_deposited_table(mm, pmd);
+			if (current->mm == mm)
+				sync_mm_rss(mm);
+			add_mm_counter(mm, MM_SWAPENTS, -HPAGE_PMD_NR);
+			ret = true;
+			goto out;
+		} else
+			VM_BUG_ON(1);
 	}
 
+	if (is_huge_zero_pmd(orig_pmd))
+		goto out;
+
 	page = pmd_page(orig_pmd);
 	/*
 	 * If other processes are mapping this page, we couldn't discard
@@ -1919,15 +1948,6 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	return ret;
 }
 
-static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
-{
-	pgtable_t pgtable;
-
-	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
-	pte_free(mm, pgtable);
-	mm_dec_nr_ptes(mm);
-}
-
 int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pmd_t *pmd, unsigned long addr)
 {
diff --git a/mm/madvise.c b/mm/madvise.c
index d180000c626b..e03e85a20fb4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -321,7 +321,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	unsigned long next;
 
 	next = pmd_addr_end(addr, end);
-	if (pmd_trans_huge(*pmd))
+	if (pmd_trans_huge(*pmd) || is_swap_pmd(*pmd))
 		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
 			goto next;
 
-- 
2.16.1
