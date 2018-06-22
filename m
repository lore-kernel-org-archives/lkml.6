Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51290C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED8F23CC4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED8F23CC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934543AbeFVDzi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:55:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:9393 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934406AbeFVDzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:55:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 20:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,255,1526367600"; 
   d="scan'208";a="65335110"
Received: from wanpingl-mobl.ccr.corp.intel.com (HELO yhuang6-ux31a.ccr.corp.intel.com) ([10.254.212.200])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jun 2018 20:55:24 -0700
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
Subject: [PATCH -mm -v4 07/21] mm, THP, swap: Support PMD swap mapping in split_swap_cluster()
Date:   Fri, 22 Jun 2018 11:51:37 +0800
Message-Id: <20180622035151.6676-8-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180622035151.6676-1-ying.huang@intel.com>
References: <20180622035151.6676-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

When splitting a THP in swap cache or failing to allocate a THP when
swapin a huge swap cluster, the huge swap cluster will be split.  In
addition to clear the huge flag of the swap cluster, the PMD swap
mapping count recorded in cluster_count() will be set to 0.  But we
will not touch PMD swap mappings themselves, because it is hard to
find them all sometimes.  When the PMD swap mappings are operated
later, it will be found that the huge swap cluster has been split and
the PMD swap mappings will be split at that time.

Unless splitting a THP in swap cache (specified via "force"
parameter), split_swap_cluster() will return -EEXIST if there is
SWAP_HAS_CACHE flag in swap_map[offset].  Because this indicates there
is a THP corresponds to this huge swap cluster, and it isn't desired
to split the THP.

When splitting a THP in swap cache, the position to call
split_swap_cluster() is changed to before unlocking sub-pages.  So
that all sub-pages will be kept locked from the THP has been split to
the huge swap cluster is split.  This makes the code much easier to be
reasoned.

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
 include/linux/swap.h |  4 ++--
 mm/huge_memory.c     | 18 ++++++++++++------
 mm/swapfile.c        | 45 ++++++++++++++++++++++++++++++---------------
 3 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index bb9de2cb952a..878f132dabc0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -617,10 +617,10 @@ static inline swp_entry_t get_swap_page(struct page *page)
 #endif /* CONFIG_SWAP */
 
 #ifdef CONFIG_THP_SWAP
-extern int split_swap_cluster(swp_entry_t entry);
+extern int split_swap_cluster(swp_entry_t entry, bool force);
 extern int split_swap_cluster_map(swp_entry_t entry);
 #else
-static inline int split_swap_cluster(swp_entry_t entry)
+static inline int split_swap_cluster(swp_entry_t entry, bool force)
 {
 	return 0;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2d615328d77f..586d8693b8af 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2502,6 +2502,17 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	unfreeze_page(head);
 
+	/*
+	 * Split swap cluster before unlocking sub-pages.  So all
+	 * sub-pages will be kept locked from THP has been split to
+	 * swap cluster is split.
+	 */
+	if (PageSwapCache(head)) {
+		swp_entry_t entry = { .val = page_private(head) };
+
+		split_swap_cluster(entry, true);
+	}
+
 	for (i = 0; i < HPAGE_PMD_NR; i++) {
 		struct page *subpage = head + i;
 		if (subpage == page)
@@ -2728,12 +2739,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			__dec_node_page_state(page, NR_SHMEM_THPS);
 		spin_unlock(&pgdata->split_queue_lock);
 		__split_huge_page(page, list, flags);
-		if (PageSwapCache(head)) {
-			swp_entry_t entry = { .val = page_private(head) };
-
-			ret = split_swap_cluster(entry);
-		} else
-			ret = 0;
+		ret = 0;
 	} else {
 		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
 			pr_alert("total_mapcount: %u, page_count(): %u\n",
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a0141307f3ac..5ff2da89b77c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1410,21 +1410,6 @@ static void swapcache_free_cluster(swp_entry_t entry)
 		}
 	}
 }
-
-int split_swap_cluster(swp_entry_t entry)
-{
-	struct swap_info_struct *si;
-	struct swap_cluster_info *ci;
-	unsigned long offset = swp_offset(entry);
-
-	si = _swap_info_get(entry);
-	if (!si)
-		return -EBUSY;
-	ci = lock_cluster(si, offset);
-	cluster_clear_huge(ci);
-	unlock_cluster(ci);
-	return 0;
-}
 #else
 static inline void swapcache_free_cluster(swp_entry_t entry)
 {
@@ -4069,6 +4054,36 @@ int split_swap_cluster_map(swp_entry_t entry)
 	unlock_cluster(ci);
 	return 0;
 }
+
+int split_swap_cluster(swp_entry_t entry, bool force)
+{
+	struct swap_info_struct *si;
+	struct swap_cluster_info *ci;
+	unsigned long offset = swp_offset(entry);
+	int ret = 0;
+
+	si = get_swap_device(entry);
+	if (!si)
+		return -EINVAL;
+	ci = lock_cluster(si, offset);
+	/* The swap cluster has been split by someone else */
+	if (!cluster_is_huge(ci))
+		goto out;
+	VM_BUG_ON(!is_cluster_offset(offset));
+	VM_BUG_ON(cluster_count(ci) < SWAPFILE_CLUSTER);
+	/* If not forced, don't split swap cluster has swap cache */
+	if (!force && si->swap_map[offset] & SWAP_HAS_CACHE) {
+		ret = -EEXIST;
+		goto out;
+	}
+	cluster_set_count(ci, SWAPFILE_CLUSTER);
+	cluster_clear_huge(ci);
+
+out:
+	unlock_cluster(ci);
+	put_swap_device(si);
+	return ret;
+}
 #endif
 
 static int __init swapfile_init(void)
-- 
2.16.4

