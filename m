Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A502175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A502175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeHCO1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:27:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:14338 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbeHCO1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:27:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 05:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,438,1526367600"; 
   d="scan'208";a="250839337"
Received: from xw.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.212.101])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2018 05:31:19 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] swap: Use __try_to_reclaim_swap() in free_swap_and_cache()
Date:   Fri,  3 Aug 2018 20:30:14 +0800
Message-Id: <20180803123014.15431-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code path to reclaim the swap entry in free_swap_and_cache() is
almost same as that of __try_to_reclaim_swap(), the largest difference
is just coding style.  So the support to the additional requirement of
free_swap_and_cache() is added into __try_to_reclaim_swap(), and
__try_to_reclaim_swap() is called in free_swap_and_cache() to delete
the duplicated code.  This will improve code readability and reduce
the potential bugs.

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
index 8ee4c93e3316..00bb4ed08410 100644
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

