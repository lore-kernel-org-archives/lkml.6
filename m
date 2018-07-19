Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417B6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA14A2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA14A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbeGSJbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:31:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:10716 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbeGSJbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:31:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 01:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,374,1526367600"; 
   d="scan'208";a="76038316"
Received: from yhuang6-ux31a.sh.intel.com ([10.239.195.246])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2018 01:49:02 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 6/8] swap, get_swap_pages: Use entry_size instead of cluster in parameter
Date:   Thu, 19 Jul 2018 16:48:40 +0800
Message-Id: <20180719084842.11385-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180719084842.11385-1-ying.huang@intel.com>
References: <20180719084842.11385-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Matthew Wilcox, it is better to use "int entry_size"
instead of "bool cluster" as parameter to specify whether to operate
for huge or normal swap entries.  Because this improve the flexibility
to support other swap entry size.  And Dave Hansen thinks that this
improves code readability too.

So in this patch, the "bool cluster" parameter of get_swap_pages() is
replaced by "int entry_size".

And nr_swap_entries() trick is used to reduce the binary size when
!CONFIG_TRANSPARENT_HUGE_PAGE.

       text	   data	    bss	    dec	    hex	filename
base  24215	   2028	    340	  26583	   67d7	mm/swapfile.o
head  24123	   2004	    340	  26467	   6763	mm/swapfile.o

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/swap.h |  2 +-
 mm/swap_slots.c      |  8 ++++----
 mm/swapfile.c        | 16 ++++++++--------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index e20c240d6c65..34de0d8bf4fa 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -443,7 +443,7 @@ extern void si_swapinfo(struct sysinfo *);
 extern swp_entry_t get_swap_page(struct page *page);
 extern void put_swap_page(struct page *page, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
-extern int get_swap_pages(int n, bool cluster, swp_entry_t swp_entries[]);
+extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 008ccb22fee6..63a7b4563a57 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -269,8 +269,8 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
 
 	cache->cur = 0;
 	if (swap_slot_cache_active)
-		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE, false,
-					   cache->slots);
+		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
+					   cache->slots, 1);
 
 	return cache->nr;
 }
@@ -316,7 +316,7 @@ swp_entry_t get_swap_page(struct page *page)
 
 	if (PageTransHuge(page)) {
 		if (IS_ENABLED(CONFIG_THP_SWAP))
-			get_swap_pages(1, true, &entry);
+			get_swap_pages(1, &entry, HPAGE_PMD_NR);
 		goto out;
 	}
 
@@ -350,7 +350,7 @@ swp_entry_t get_swap_page(struct page *page)
 			goto out;
 	}
 
-	get_swap_pages(1, false, &entry);
+	get_swap_pages(1, &entry, 1);
 out:
 	if (mem_cgroup_try_charge_swap(page, entry)) {
 		put_swap_page(page, entry);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 407f97287ab3..318ceb527c78 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -943,18 +943,18 @@ static unsigned long scan_swap_map(struct swap_info_struct *si,
 
 }
 
-int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
+int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 {
-	unsigned long nr_pages = cluster ? SWAPFILE_CLUSTER : 1;
+	unsigned long size = swap_entry_size(entry_size);
 	struct swap_info_struct *si, *next;
 	long avail_pgs;
 	int n_ret = 0;
 	int node;
 
 	/* Only single cluster request supported */
-	WARN_ON_ONCE(n_goal > 1 && cluster);
+	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
 
-	avail_pgs = atomic_long_read(&nr_swap_pages) / nr_pages;
+	avail_pgs = atomic_long_read(&nr_swap_pages) / size;
 	if (avail_pgs <= 0)
 		goto noswap;
 
@@ -964,7 +964,7 @@ int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
 	if (n_goal > avail_pgs)
 		n_goal = avail_pgs;
 
-	atomic_long_sub(n_goal * nr_pages, &nr_swap_pages);
+	atomic_long_sub(n_goal * size, &nr_swap_pages);
 
 	spin_lock(&swap_avail_lock);
 
@@ -991,14 +991,14 @@ int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
 			spin_unlock(&si->lock);
 			goto nextsi;
 		}
-		if (cluster) {
+		if (size == SWAPFILE_CLUSTER) {
 			if (!(si->flags & SWP_FILE))
 				n_ret = swap_alloc_cluster(si, swp_entries);
 		} else
 			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
 						    n_goal, swp_entries);
 		spin_unlock(&si->lock);
-		if (n_ret || cluster)
+		if (n_ret || size == SWAPFILE_CLUSTER)
 			goto check_out;
 		pr_debug("scan_swap_map of si %d failed to find offset\n",
 			si->type);
@@ -1024,7 +1024,7 @@ int get_swap_pages(int n_goal, bool cluster, swp_entry_t swp_entries[])
 
 check_out:
 	if (n_ret < n_goal)
-		atomic_long_add((long)(n_goal - n_ret) * nr_pages,
+		atomic_long_add((long)(n_goal - n_ret) * size,
 				&nr_swap_pages);
 noswap:
 	return n_ret;
-- 
2.16.4

