Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B0BC32788
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DDB21104
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DDB21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeKTTXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:23:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:57263 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbeKTTXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:23:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 00:55:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,256,1539673200"; 
   d="scan'208";a="106105817"
Received: from yhuang-mobile.sh.intel.com ([10.239.197.245])
  by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2018 00:55:15 -0800
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
Subject: [PATCH -V7 RESEND 08/21] swap: Support to read a huge swap cluster for swapin a THP
Date:   Tue, 20 Nov 2018 16:54:36 +0800
Message-Id: <20181120085449.5542-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181120085449.5542-1-ying.huang@intel.com>
References: <20181120085449.5542-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To swapin a THP in one piece, we need to read a huge swap cluster from
the swap device.  This patch revised the __read_swap_cache_async() and
its callers and callees to support this.  If __read_swap_cache_async()
find the swap cluster of the specified swap entry is huge, it will try
to allocate a THP, add it into the swap cache.  So later the contents
of the huge swap cluster can be read into the THP.

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
 include/linux/huge_mm.h |  8 ++++++
 include/linux/swap.h    |  4 +--
 mm/huge_memory.c        |  3 +-
 mm/swap_state.c         | 61 +++++++++++++++++++++++++++++++++--------
 mm/swapfile.c           |  9 ++++--
 5 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 1c0fda003d6a..f4dbd0662438 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -250,6 +250,8 @@ static inline bool thp_migration_supported(void)
 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
 }
 
+gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma,
+				    unsigned long addr);
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
 #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
@@ -363,6 +365,12 @@ static inline bool thp_migration_supported(void)
 {
 	return false;
 }
+
+static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma,
+						  unsigned long addr)
+{
+	return 0;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 441da4a832a6..4bd532c9315e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -462,7 +462,7 @@ extern sector_t map_swap_page(struct page *, struct block_device **);
 extern sector_t swapdev_block(int, pgoff_t);
 extern int page_swapcount(struct page *);
 extern int __swap_count(swp_entry_t entry);
-extern int __swp_swapcount(swp_entry_t entry);
+extern int __swp_swapcount(swp_entry_t entry, int *entry_size);
 extern int swp_swapcount(swp_entry_t entry);
 extern struct swap_info_struct *page_swap_info(struct page *);
 extern struct swap_info_struct *swp_swap_info(swp_entry_t entry);
@@ -590,7 +590,7 @@ static inline int __swap_count(swp_entry_t entry)
 	return 0;
 }
 
-static inline int __swp_swapcount(swp_entry_t entry)
+static inline int __swp_swapcount(swp_entry_t entry, int *entry_size)
 {
 	return 0;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a38d549fb4dc..eeea00070da8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -629,7 +629,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
  *	    available
  * never: never stall for any thp allocation
  */
-static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
+gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma,
+				    unsigned long addr)
 {
 	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
 	gfp_t this_node = 0;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 97831166994a..1eedbc0aede2 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -361,7 +361,9 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 {
 	struct page *found_page = NULL, *new_page = NULL;
 	struct swap_info_struct *si;
-	int err;
+	int err, entry_size = 1;
+	swp_entry_t hentry;
+
 	*new_page_allocated = false;
 
 	do {
@@ -387,14 +389,42 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * as SWAP_HAS_CACHE.  That's done in later part of code or
 		 * else swap_off will be aborted if we return NULL.
 		 */
-		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
+		if (!__swp_swapcount(entry, &entry_size) &&
+		    swap_slot_cache_enabled)
 			break;
 
 		/*
 		 * Get a new page to read into from swap.
 		 */
-		if (!new_page) {
-			new_page = alloc_page_vma(gfp_mask, vma, addr);
+		if (!new_page ||
+		    (IS_ENABLED(CONFIG_THP_SWAP) &&
+		     hpage_nr_pages(new_page) != entry_size)) {
+			if (new_page)
+				put_page(new_page);
+			if (IS_ENABLED(CONFIG_THP_SWAP) &&
+			    entry_size == HPAGE_PMD_NR) {
+				gfp_t gfp;
+
+				gfp = alloc_hugepage_direct_gfpmask(vma, addr);
+				/*
+				 * Make sure huge page allocation flags are
+				 * compatible with that of normal page
+				 */
+				VM_WARN_ONCE(gfp_mask & ~(gfp | __GFP_RECLAIM),
+					     "ignoring gfp_mask bits: %x",
+					     gfp_mask & ~(gfp | __GFP_RECLAIM));
+				new_page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER,
+							   vma, addr,
+							   numa_node_id());
+				if (new_page)
+					prep_transhuge_page(new_page);
+				hentry = swp_entry(swp_type(entry),
+						   round_down(swp_offset(entry),
+							      HPAGE_PMD_NR));
+			} else {
+				new_page = alloc_page_vma(gfp_mask, vma, addr);
+				hentry = entry;
+			}
 			if (!new_page)
 				break;		/* Out of memory */
 		}
@@ -402,7 +432,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		/*
 		 * Swap entry may have been freed since our caller observed it.
 		 */
-		err = swapcache_prepare(entry, 1);
+		err = swapcache_prepare(hentry, entry_size);
 		if (err == -EEXIST) {
 			/*
 			 * We might race against get_swap_page() and stumble
@@ -411,18 +441,24 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			 */
 			cond_resched();
 			continue;
+		} else if (err == -ENOTDIR) {
+			/* huge swap cluster has been split under us */
+			continue;
 		} else if (err)		/* swp entry is obsolete ? */
 			break;
 
 		/* May fail (-ENOMEM) if XArray node allocation failed. */
 		__SetPageLocked(new_page);
 		__SetPageSwapBacked(new_page);
-		err = add_to_swap_cache(new_page, entry, gfp_mask & GFP_KERNEL);
+		err = add_to_swap_cache(new_page, hentry, gfp_mask & GFP_KERNEL);
 		if (likely(!err)) {
 			/* Initiate read into locked page */
 			SetPageWorkingset(new_page);
 			lru_cache_add_anon(new_page);
 			*new_page_allocated = true;
+			if (IS_ENABLED(CONFIG_THP_SWAP))
+				new_page += swp_offset(entry) &
+					(entry_size - 1);
 			return new_page;
 		}
 		__ClearPageLocked(new_page);
@@ -430,7 +466,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
 		 * clear SWAP_HAS_CACHE flag.
 		 */
-		put_swap_page(new_page, entry);
+		put_swap_page(new_page, hentry);
 	} while (err != -ENOMEM);
 
 	if (new_page)
@@ -452,7 +488,7 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			vma, addr, &page_was_allocated);
 
 	if (page_was_allocated)
-		swap_readpage(retpage, do_poll);
+		swap_readpage(compound_head(retpage), do_poll);
 
 	return retpage;
 }
@@ -571,8 +607,9 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		if (!page)
 			continue;
 		if (page_allocated) {
-			swap_readpage(page, false);
-			if (offset != entry_offset) {
+			swap_readpage(compound_head(page), false);
+			if (offset != entry_offset &&
+			    !PageTransCompound(page)) {
 				SetPageReadahead(page);
 				count_vm_event(SWAP_RA);
 			}
@@ -733,8 +770,8 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		if (!page)
 			continue;
 		if (page_allocated) {
-			swap_readpage(page, false);
-			if (i != ra_info.offset) {
+			swap_readpage(compound_head(page), false);
+			if (i != ra_info.offset && !PageTransCompound(page)) {
 				SetPageReadahead(page);
 				count_vm_event(SWAP_RA);
 			}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a57967292a8d..c22c11b4a879 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1542,7 +1542,8 @@ int __swap_count(swp_entry_t entry)
 	return count;
 }
 
-static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
+static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry,
+			  int *entry_size)
 {
 	int count = 0;
 	pgoff_t offset = swp_offset(entry);
@@ -1550,6 +1551,8 @@ static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
 
 	ci = lock_cluster_or_swap_info(si, offset);
 	count = swap_count(si->swap_map[offset]);
+	if (entry_size)
+		*entry_size = ci && cluster_is_huge(ci) ? SWAPFILE_CLUSTER : 1;
 	unlock_cluster_or_swap_info(si, ci);
 	return count;
 }
@@ -1559,14 +1562,14 @@ static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
  * This does not give an exact answer when swap count is continued,
  * but does include the high COUNT_CONTINUED flag to allow for that.
  */
-int __swp_swapcount(swp_entry_t entry)
+int __swp_swapcount(swp_entry_t entry, int *entry_size)
 {
 	int count = 0;
 	struct swap_info_struct *si;
 
 	si = get_swap_device(entry);
 	if (si) {
-		count = swap_swapcount(si, entry);
+		count = swap_swapcount(si, entry, entry_size);
 		put_swap_device(si);
 	}
 	return count;
-- 
2.18.1

