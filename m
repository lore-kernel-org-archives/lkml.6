Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC18ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D598120856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D598120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeGTIGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:06:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:13644 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbeGTIGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:06:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 00:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,377,1526367600"; 
   d="scan'208";a="68652040"
Received: from yhuang6-ux31a.sh.intel.com ([10.239.198.6])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2018 00:18:55 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v4 2/8] mm/swapfile.c: Replace some #ifdef with IS_ENABLED()
Date:   Fri, 20 Jul 2018 15:18:39 +0800
Message-Id: <20180720071845.17920-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180720071845.17920-1-ying.huang@intel.com>
References: <20180720071845.17920-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mm/swapfile.c, THP (Transparent Huge Page) swap specific code is
enclosed by #ifdef CONFIG_THP_SWAP/#endif to avoid code dilating when
THP isn't enabled.  But #ifdef/#endif in .c file hurt the code
readability, so Dave suggested to use IS_ENABLED(CONFIG_THP_SWAP)
instead and let compiler to do the dirty job for us.  This has
potential to remove some duplicated code too.  From output of `size`,

		text	   data	    bss	    dec	    hex	filename
THP=y:         26269	   2076	    340	  28685	   700d	mm/swapfile.o
ifdef/endif:   24115	   2028	    340	  26483	   6773	mm/swapfile.o
IS_ENABLED:    24179	   2028	    340	  26547	   67b3	mm/swapfile.o

IS_ENABLED() based solution works quite well, almost as good as that
of #ifdef/#endif.  And from the diffstat, the removed lines are more
than added lines.

One #ifdef for split_swap_cluster() is kept.  Because it is a public
function with a stub implementation for CONFIG_THP_SWAP=n in swap.h.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-and-acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 mm/swapfile.c | 60 ++++++++++++++++++++---------------------------------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index d101e044efbf..7283104bfafa 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -869,7 +869,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	return n_ret;
 }
 
-#ifdef CONFIG_THP_SWAP
 static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
 {
 	unsigned long idx;
@@ -877,6 +876,15 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
 	unsigned long offset, i;
 	unsigned char *map;
 
+	/*
+	 * Should not even be attempting cluster allocations when huge
+	 * page swap is disabled.  Warn and fail the allocation.
+	 */
+	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
+		VM_WARN_ON_ONCE(1);
+		return 0;
+	}
+
 	if (cluster_list_empty(&si->free_clusters))
 		return 0;
 
@@ -907,13 +915,6 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 	unlock_cluster(ci);
 	swap_range_free(si, offset, SWAPFILE_CLUSTER);
 }
-#else
-static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
-{
-	VM_WARN_ON_ONCE(1);
-	return 0;
-}
-#endif /* CONFIG_THP_SWAP */
 
 static unsigned long scan_swap_map(struct swap_info_struct *si,
 				   unsigned char usage)
@@ -1259,7 +1260,6 @@ static void swapcache_free(swp_entry_t entry)
 	}
 }
 
-#ifdef CONFIG_THP_SWAP
 static void swapcache_free_cluster(swp_entry_t entry)
 {
 	unsigned long offset = swp_offset(entry);
@@ -1270,6 +1270,9 @@ static void swapcache_free_cluster(swp_entry_t entry)
 	unsigned int i, free_entries = 0;
 	unsigned char val;
 
+	if (!IS_ENABLED(CONFIG_THP_SWAP))
+		return;
+
 	si = _swap_info_get(entry);
 	if (!si)
 		return;
@@ -1305,6 +1308,7 @@ static void swapcache_free_cluster(swp_entry_t entry)
 	}
 }
 
+#ifdef CONFIG_THP_SWAP
 int split_swap_cluster(swp_entry_t entry)
 {
 	struct swap_info_struct *si;
@@ -1319,11 +1323,7 @@ int split_swap_cluster(swp_entry_t entry)
 	unlock_cluster(ci);
 	return 0;
 }
-#else
-static inline void swapcache_free_cluster(swp_entry_t entry)
-{
-}
-#endif /* CONFIG_THP_SWAP */
+#endif
 
 void put_swap_page(struct page *page, swp_entry_t entry)
 {
@@ -1482,7 +1482,6 @@ int swp_swapcount(swp_entry_t entry)
 	return count;
 }
 
-#ifdef CONFIG_THP_SWAP
 static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 					 swp_entry_t entry)
 {
@@ -1493,6 +1492,9 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 	int i;
 	bool ret = false;
 
+	if (!IS_ENABLED(CONFIG_THP_SWAP))
+		return swap_swapcount(si, entry) != 0;
+
 	ci = lock_cluster_or_swap_info(si, offset);
 	if (!ci || !cluster_is_huge(ci)) {
 		if (map[roffset] != SWAP_HAS_CACHE)
@@ -1515,7 +1517,7 @@ static bool page_swapped(struct page *page)
 	swp_entry_t entry;
 	struct swap_info_struct *si;
 
-	if (likely(!PageTransCompound(page)))
+	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!PageTransCompound(page)))
 		return page_swapcount(page) != 0;
 
 	page = compound_head(page);
@@ -1539,10 +1541,8 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
 	/* hugetlbfs shouldn't call it */
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 
-	if (likely(!PageTransCompound(page))) {
-		mapcount = atomic_read(&page->_mapcount) + 1;
-		if (total_mapcount)
-			*total_mapcount = mapcount;
+	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!PageTransCompound(page))) {
+		mapcount = page_trans_huge_mapcount(page, total_mapcount);
 		if (PageSwapCache(page))
 			swapcount = page_swapcount(page);
 		if (total_swapcount)
@@ -1589,26 +1589,6 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
 
 	return map_swapcount;
 }
-#else
-#define swap_page_trans_huge_swapped(si, entry)	swap_swapcount(si, entry)
-#define page_swapped(page)			(page_swapcount(page) != 0)
-
-static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
-					 int *total_swapcount)
-{
-	int mapcount, swapcount = 0;
-
-	/* hugetlbfs shouldn't call it */
-	VM_BUG_ON_PAGE(PageHuge(page), page);
-
-	mapcount = page_trans_huge_mapcount(page, total_mapcount);
-	if (PageSwapCache(page))
-		swapcount = page_swapcount(page);
-	if (total_swapcount)
-		*total_swapcount = swapcount;
-	return mapcount + swapcount;
-}
-#endif
 
 /*
  * We can write to an anon page without COW if there are no other references
-- 
2.16.4

