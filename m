Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B052CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8D221735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8D221735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeH0LlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:41:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:25995 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbeH0LlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:41:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 00:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="80463021"
Received: from yhuang-mobile.sh.intel.com ([10.239.198.115])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2018 00:55:39 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 1/3] swap: Use __try_to_reclaim_swap() in free_swap_and_cache()
Date:   Mon, 27 Aug 2018 15:55:33 +0800
Message-Id: <20180827075535.17406-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827075535.17406-1-ying.huang@intel.com>
References: <20180827075535.17406-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code path to reclaim the swap entry in free_swap_and_cache() is
almost same as that of __try_to_reclaim_swap().  The largest
difference is just coding style.  So the support to the additional
requirement of free_swap_and_cache() is added into
__try_to_reclaim_swap().  free_swap_and_cache() is changed to call
__try_to_reclaim_swap(), and delete the duplicated code.  This will
improve code readability and reduce the potential bugs.

There are 2 functionality differences between __try_to_reclaim_swap()
and swap entry reclaim code of free_swap_and_cache().

- free_swap_and_cache() only reclaims the swap entry if the page is
  unmapped or swap is getting full.  The support has been added into
  __try_to_reclaim_swap().

- try_to_free_swap() (called by __try_to_reclaim_swap()) checks
  pm_suspended_storage(), while free_swap_and_cache() not.  I think
  this is OK.  Because the page and the swap entry can be reclaimed
  later eventually.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
---
 mm/swapfile.c | 57 +++++++++++++++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9211c427a9ad..409926079607 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -104,26 +104,39 @@ static inline unsigned char swap_count(unsigned char ent)
 	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
 }
 
+/* Reclaim the swap entry anyway if possible */
+#define TTRS_ANYWAY		0x1
+/*
+ * Reclaim the swap entry if there are no more mappings of the
+ * corresponding page
+ */
+#define TTRS_UNMAPPED		0x2
+/* Reclaim the swap entry if swap is getting full*/
+#define TTRS_FULL		0x4
+
 /* returns 1 if swap entry is freed */
-static int
-__try_to_reclaim_swap(struct swap_info_struct *si, unsigned long offset)
+static int __try_to_reclaim_swap(struct swap_info_struct *si,
+				 unsigned long offset, unsigned long flags)
 {
 	swp_entry_t entry = swp_entry(si->type, offset);
 	struct page *page;
 	int ret = 0;
 
-	page = find_get_page(swap_address_space(entry), swp_offset(entry));
+	page = find_get_page(swap_address_space(entry), offset);
 	if (!page)
 		return 0;
 	/*
-	 * This function is called from scan_swap_map() and it's called
-	 * by vmscan.c at reclaiming pages. So, we hold a lock on a page, here.
-	 * We have to use trylock for avoiding deadlock. This is a special
+	 * When this function is called from scan_swap_map_slots() and it's
+	 * called by vmscan.c at reclaiming pages. So, we hold a lock on a page,
+	 * here. We have to use trylock for avoiding deadlock. This is a special
 	 * case and you should use try_to_free_swap() with explicit lock_page()
 	 * in usual operations.
 	 */
 	if (trylock_page(page)) {
-		ret = try_to_free_swap(page);
+		if ((flags & TTRS_ANYWAY) ||
+		    ((flags & TTRS_UNMAPPED) && !page_mapped(page)) ||
+		    ((flags & TTRS_FULL) && mem_cgroup_swap_full(page)))
+			ret = try_to_free_swap(page);
 		unlock_page(page);
 	}
 	put_page(page);
@@ -781,7 +794,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		int swap_was_freed;
 		unlock_cluster(ci);
 		spin_unlock(&si->lock);
-		swap_was_freed = __try_to_reclaim_swap(si, offset);
+		swap_was_freed = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
 		spin_lock(&si->lock);
 		/* entry was freed successfully, try to use this again */
 		if (swap_was_freed)
@@ -1680,7 +1693,6 @@ int try_to_free_swap(struct page *page)
 int free_swap_and_cache(swp_entry_t entry)
 {
 	struct swap_info_struct *p;
-	struct page *page = NULL;
 	unsigned char count;
 
 	if (non_swap_entry(entry))
@@ -1690,31 +1702,12 @@ int free_swap_and_cache(swp_entry_t entry)
 	if (p) {
 		count = __swap_entry_free(p, entry, 1);
 		if (count == SWAP_HAS_CACHE &&
-		    !swap_page_trans_huge_swapped(p, entry)) {
-			page = find_get_page(swap_address_space(entry),
-					     swp_offset(entry));
-			if (page && !trylock_page(page)) {
-				put_page(page);
-				page = NULL;
-			}
-		} else if (!count)
+		    !swap_page_trans_huge_swapped(p, entry))
+			__try_to_reclaim_swap(p, swp_offset(entry),
+					      TTRS_UNMAPPED | TTRS_FULL);
+		else if (!count)
 			free_swap_slot(entry);
 	}
-	if (page) {
-		/*
-		 * Not mapped elsewhere, or swap space full? Free it!
-		 * Also recheck PageSwapCache now page is locked (above).
-		 */
-		if (PageSwapCache(page) && !PageWriteback(page) &&
-		    (!page_mapped(page) || mem_cgroup_swap_full(page)) &&
-		    !swap_page_trans_huge_swapped(p, entry)) {
-			page = compound_head(page);
-			delete_from_swap_cache(page);
-			SetPageDirty(page);
-		}
-		unlock_page(page);
-		put_page(page);
-	}
 	return p != NULL;
 }
 
-- 
2.16.4

