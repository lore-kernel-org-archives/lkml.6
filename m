Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D183C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327F220838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327F220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeLGFm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 00:42:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:55177 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbeLGFmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 00:42:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 21:42:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="105567354"
Received: from yhuang-mobile.sh.intel.com ([10.239.196.133])
  by fmsmga007.fm.intel.com with ESMTP; 06 Dec 2018 21:42:21 -0800
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
Subject: [PATCH -V8 20/21] swap: create PMD swap mapping when unmap the THP
Date:   Fri,  7 Dec 2018 13:41:20 +0800
Message-Id: <20181207054122.27822-21-ying.huang@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181207054122.27822-1-ying.huang@intel.com>
References: <20181207054122.27822-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the final step of the THP swapin support.  When reclaiming a
anonymous THP, after allocating the huge swap cluster and add the THP
into swap cache, the PMD page mapping will be changed to the mapping
to the swap space.  Previously, the PMD page mapping will be split
before being changed.  In this patch, the unmap code is enhanced not
to split the PMD mapping, but create a PMD swap mapping to replace it
instead.  So later when clear the SWAP_HAS_CACHE flag in the last step
of swapout, the huge swap cluster will be kept instead of being split,
and when swapin, the huge swap cluster will be read in one piece into a
THP.  That is, the THP will not be split during swapout/swapin.  This
can eliminate the overhead of splitting/collapsing, and reduce the
page fault count, etc.  But more important, the utilization of THP is
improved greatly, that is, much more THP will be kept when swapping is
used, so that we can take full advantage of THP including its high
performance for swapout/swapin.

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
 include/linux/huge_mm.h | 11 +++++++++++
 mm/huge_memory.c        | 30 ++++++++++++++++++++++++++++
 mm/rmap.c               | 43 ++++++++++++++++++++++++++++++++++++++++-
 mm/vmscan.c             |  6 +-----
 4 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 260357fc9d76..06e4fde57a0f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -375,12 +375,16 @@ static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+struct page_vma_mapped_walk;
+
 #ifdef CONFIG_THP_SWAP
 extern void __split_huge_swap_pmd(struct vm_area_struct *vma,
 				  unsigned long addr, pmd_t *pmd);
 extern int split_huge_swap_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			       unsigned long address, pmd_t orig_pmd);
 extern int do_huge_pmd_swap_page(struct vm_fault *vmf, pmd_t orig_pmd);
+extern bool set_pmd_swap_entry(struct page_vma_mapped_walk *pvmw,
+	struct page *page, unsigned long address, pmd_t pmdval);
 
 static inline bool transparent_hugepage_swapin_enabled(
 	struct vm_area_struct *vma)
@@ -421,6 +425,13 @@ static inline int do_huge_pmd_swap_page(struct vm_fault *vmf, pmd_t orig_pmd)
 	return 0;
 }
 
+static inline bool set_pmd_swap_entry(struct page_vma_mapped_walk *pvmw,
+				      struct page *page, unsigned long address,
+				      pmd_t pmdval)
+{
+	return false;
+}
+
 static inline bool transparent_hugepage_swapin_enabled(
 	struct vm_area_struct *vma)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b75af88c505a..27de3e547dc0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1938,6 +1938,36 @@ int do_huge_pmd_swap_page(struct vm_fault *vmf, pmd_t orig_pmd)
 	count_vm_event(THP_SWPIN_FALLBACK);
 	goto fallback;
 }
+
+bool set_pmd_swap_entry(struct page_vma_mapped_walk *pvmw, struct page *page,
+			unsigned long address, pmd_t pmdval)
+{
+	struct vm_area_struct *vma = pvmw->vma;
+	struct mm_struct *mm = vma->vm_mm;
+	pmd_t swp_pmd;
+	swp_entry_t entry = { .val = page_private(page) };
+
+	if (swap_duplicate(&entry, HPAGE_PMD_NR) < 0) {
+		set_pmd_at(mm, address, pvmw->pmd, pmdval);
+		return false;
+	}
+	if (list_empty(&mm->mmlist)) {
+		spin_lock(&mmlist_lock);
+		if (list_empty(&mm->mmlist))
+			list_add(&mm->mmlist, &init_mm.mmlist);
+		spin_unlock(&mmlist_lock);
+	}
+	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
+	add_mm_counter(mm, MM_SWAPENTS, HPAGE_PMD_NR);
+	swp_pmd = swp_entry_to_pmd(entry);
+	if (pmd_soft_dirty(pmdval))
+		swp_pmd = pmd_swp_mksoft_dirty(swp_pmd);
+	set_pmd_at(mm, address, pvmw->pmd, swp_pmd);
+
+	page_remove_rmap(page, true);
+	put_page(page);
+	return true;
+}
 #endif
 
 static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
diff --git a/mm/rmap.c b/mm/rmap.c
index a488d325946d..b7ea50d563a3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1413,11 +1413,52 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				continue;
 		}
 
+		address = pvmw.address;
+
+#ifdef CONFIG_THP_SWAP
+		/* PMD-mapped THP swap entry */
+		if (IS_ENABLED(CONFIG_THP_SWAP) &&
+		    !pvmw.pte && PageAnon(page)) {
+			pmd_t pmdval;
+
+			VM_BUG_ON_PAGE(PageHuge(page) ||
+				       !PageTransCompound(page), page);
+
+			flush_cache_range(vma, address,
+					  address + HPAGE_PMD_SIZE);
+			mmu_notifier_invalidate_range_start(mm, address,
+					address + HPAGE_PMD_SIZE);
+			if (should_defer_flush(mm, flags)) {
+				/* check comments for PTE below */
+				pmdval = pmdp_huge_get_and_clear(mm, address,
+								 pvmw.pmd);
+				set_tlb_ubc_flush_pending(mm,
+							  pmd_dirty(pmdval));
+			} else
+				pmdval = pmdp_huge_clear_flush(vma, address,
+							       pvmw.pmd);
+
+			/*
+			 * Move the dirty bit to the page. Now the pmd
+			 * is gone.
+			 */
+			if (pmd_dirty(pmdval))
+				set_page_dirty(page);
+
+			/* Update high watermark before we lower rss */
+			update_hiwater_rss(mm);
+
+			ret = set_pmd_swap_entry(&pvmw, page, address, pmdval);
+			mmu_notifier_invalidate_range_end(mm, address,
+					address + HPAGE_PMD_SIZE);
+			continue;
+		}
+#endif
+
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_PAGE(!pvmw.pte, page);
 
 		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
-		address = pvmw.address;
 
 		if (PageHuge(page)) {
 			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7a67923c09b3..c6af95025fb1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1340,11 +1340,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		 * processes. Try to unmap it here.
 		 */
 		if (page_mapped(page)) {
-			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
-
-			if (unlikely(PageTransHuge(page)))
-				flags |= TTU_SPLIT_HUGE_PMD;
-			if (!try_to_unmap(page, flags)) {
+			if (!try_to_unmap(page, ttu_flags | TTU_BATCH_FLUSH)) {
 				nr_unmap_fail++;
 				goto activate_locked;
 			}
-- 
2.18.1

