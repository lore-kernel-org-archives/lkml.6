Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE9DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6AA21502
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6AA21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJJOsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:48:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:9718 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbeJJOsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:48:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 00:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,363,1534834800"; 
   d="scan'208";a="93870008"
Received: from yhuang-mobile.sh.intel.com ([10.239.198.87])
  by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2018 00:19:15 -0700
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
Subject: [PATCH -V6 08/21] swap: Support to read a huge swap cluster for swapin a THP
Date:   Wed, 10 Oct 2018 15:19:11 +0800
Message-Id: <20181010071924.18767-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181010071924.18767-1-ying.huang@intel.com>
References: <20181010071924.18767-1-ying.huang@intel.com>
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
 include/linux/huge_mm.h |  8 +++++++
 include/linux/swap.h    |  4 ++--
 mm/huge_memory.c        |  3 ++-
 mm/swap_state.c         | 59 ++++++++++++++++++++++++++++++++++++++++---------
 mm/swapfile.c           |  9 +++++---
 5 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0f3e1739986f..a0e7f4f9c12b 100644
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
index 60fd5189fde9..f2daf3fbdd4b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -457,7 +457,7 @@ extern sector_t map_swap_page(struct page *, struct block_device **);
 extern sector_t swapdev_block(int, pgoff_t);
 extern int page_swapcount(struct page *);
 extern int __swap_count(swp_entry_t entry);
-extern int __swp_swapcount(swp_entry_t entry);
+extern int __swp_swapcount(swp_entry_t entry, int *entry_size);
 extern int swp_swapcount(swp_entry_t entry);
 extern struct swap_info_struct *page_swap_info(struct page *);
 extern struct swap_info_struct *swp_swap_info(swp_entry_t entry);
@@ -585,7 +585,7 @@ static inline int __swap_count(swp_entry_t entry)
 	return 0;
 }
 
-static inline int __swp_swapcount(swp_entry_t entry)
+static inline int __swp_swapcount(swp_entry_t entry, int *entry_size)
 {
 	return 0;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 92e0cdb99c5a..a025494dd828 100644
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
index bca34fc7a5e5..784ad6388da0 100644
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
@@ -411,6 +441,9 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			 */
 			cond_resched();
 			continue;
+		} else if (err == -ENOTDIR) {
+			/* huge swap cluster has been split under us */
+			continue;
 		} else if (err) {	/* swp entry is obsolete ? */
 			break;
 		}
@@ -424,6 +457,9 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			SetPageWorkingset(new_page);
 			lru_cache_add_anon(new_page);
 			*new_page_allocated = true;
+			if (IS_ENABLED(CONFIG_THP_SWAP))
+				new_page += swp_offset(entry) &
+					(entry_size - 1);
 			return new_page;
 		}
 		__ClearPageLocked(new_page);
@@ -431,7 +467,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
 		 * clear SWAP_HAS_CACHE flag.
 		 */
-		put_swap_page(new_page, entry);
+		put_swap_page(new_page, hentry);
 	} while (err != -ENOMEM);
 
 	if (new_page)
@@ -453,7 +489,7 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 			vma, addr, &page_was_allocated);
 
 	if (page_was_allocated)
-		swap_readpage(retpage, do_poll);
+		swap_readpage(compound_head(retpage), do_poll);
 
 	return retpage;
 }
@@ -572,8 +608,9 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
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
@@ -734,8 +771,8 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
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
index 2020bd494419..2ca013df35e1 100644
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
2.16.4

