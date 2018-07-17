Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D95BECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102C2208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102C2208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbeGQBZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:25:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:31703 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731128AbeGQBZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:25:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 17:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="245788297"
Received: from yhuang6-ux31a.sh.intel.com ([10.239.197.184])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2018 17:55:55 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 5/7] swap: Unify normal/huge code path in put_swap_page()
Date:   Tue, 17 Jul 2018 08:55:54 +0800
Message-Id: <20180717005556.29758-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180717005556.29758-1-ying.huang@intel.com>
References: <20180717005556.29758-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch, the normal/huge code path in put_swap_page() and
several helper functions are unified to avoid duplicated code, bugs,
etc. and make it easier to review the code.

The removed lines are more than added lines.  And the binary size is
kept exactly same when CONFIG_TRANSPARENT_HUGEPAGE=n.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 mm/swapfile.c | 83 ++++++++++++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a6d8b8117bc5..622edc47b67a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -205,8 +205,16 @@ static void discard_swap_cluster(struct swap_info_struct *si,
 
 #ifdef CONFIG_THP_SWAP
 #define SWAPFILE_CLUSTER	HPAGE_PMD_NR
+
+#define nr_swap_entries(nr)	(nr)
 #else
 #define SWAPFILE_CLUSTER	256
+
+/*
+ * Define nr_swap_entries() as constant to let compiler to optimize
+ * out some code if !CONFIG_THP_SWAP
+ */
+#define nr_swap_entries(nr)	1
 #endif
 #define LATENCY_LIMIT		256
 
@@ -1249,18 +1257,7 @@ void swap_free(swp_entry_t entry)
 /*
  * Called after dropping swapcache to decrease refcnt to swap entries.
  */
-static void swapcache_free(swp_entry_t entry)
-{
-	struct swap_info_struct *p;
-
-	p = _swap_info_get(entry);
-	if (p) {
-		if (!__swap_entry_free(p, entry, SWAP_HAS_CACHE))
-			free_swap_slot(entry);
-	}
-}
-
-static void swapcache_free_cluster(swp_entry_t entry)
+void put_swap_page(struct page *page, swp_entry_t entry)
 {
 	unsigned long offset = swp_offset(entry);
 	unsigned long idx = offset / SWAPFILE_CLUSTER;
@@ -1269,39 +1266,41 @@ static void swapcache_free_cluster(swp_entry_t entry)
 	unsigned char *map;
 	unsigned int i, free_entries = 0;
 	unsigned char val;
-
-	if (!IS_ENABLED(CONFIG_THP_SWAP))
-		return;
+	int nr = nr_swap_entries(hpage_nr_pages(page));
 
 	si = _swap_info_get(entry);
 	if (!si)
 		return;
 
-	ci = lock_cluster(si, offset);
-	VM_BUG_ON(!cluster_is_huge(ci));
-	map = si->swap_map + offset;
-	for (i = 0; i < SWAPFILE_CLUSTER; i++) {
-		val = map[i];
-		VM_BUG_ON(!(val & SWAP_HAS_CACHE));
-		if (val == SWAP_HAS_CACHE)
-			free_entries++;
-	}
-	if (!free_entries) {
-		for (i = 0; i < SWAPFILE_CLUSTER; i++)
-			map[i] &= ~SWAP_HAS_CACHE;
-	}
-	cluster_clear_huge(ci);
-	unlock_cluster(ci);
-	if (free_entries == SWAPFILE_CLUSTER) {
-		spin_lock(&si->lock);
+	if (nr == SWAPFILE_CLUSTER) {
 		ci = lock_cluster(si, offset);
-		memset(map, 0, SWAPFILE_CLUSTER);
+		VM_BUG_ON(!cluster_is_huge(ci));
+		map = si->swap_map + offset;
+		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
+			val = map[i];
+			VM_BUG_ON(!(val & SWAP_HAS_CACHE));
+			if (val == SWAP_HAS_CACHE)
+				free_entries++;
+		}
+		if (!free_entries) {
+			for (i = 0; i < SWAPFILE_CLUSTER; i++)
+				map[i] &= ~SWAP_HAS_CACHE;
+		}
+		cluster_clear_huge(ci);
 		unlock_cluster(ci);
-		mem_cgroup_uncharge_swap(entry, SWAPFILE_CLUSTER);
-		swap_free_cluster(si, idx);
-		spin_unlock(&si->lock);
-	} else if (free_entries) {
-		for (i = 0; i < SWAPFILE_CLUSTER; i++, entry.val++) {
+		if (free_entries == SWAPFILE_CLUSTER) {
+			spin_lock(&si->lock);
+			ci = lock_cluster(si, offset);
+			memset(map, 0, SWAPFILE_CLUSTER);
+			unlock_cluster(ci);
+			mem_cgroup_uncharge_swap(entry, SWAPFILE_CLUSTER);
+			swap_free_cluster(si, idx);
+			spin_unlock(&si->lock);
+			return;
+		}
+	}
+	if (nr == 1 || free_entries) {
+		for (i = 0; i < nr; i++, entry.val++) {
 			if (!__swap_entry_free(si, entry, SWAP_HAS_CACHE))
 				free_swap_slot(entry);
 		}
@@ -1325,14 +1324,6 @@ int split_swap_cluster(swp_entry_t entry)
 }
 #endif
 
-void put_swap_page(struct page *page, swp_entry_t entry)
-{
-	if (!PageTransHuge(page))
-		swapcache_free(entry);
-	else
-		swapcache_free_cluster(entry);
-}
-
 static int swp_entry_cmp(const void *ent1, const void *ent2)
 {
 	const swp_entry_t *e1 = ent1, *e2 = ent2;
-- 
2.16.4

