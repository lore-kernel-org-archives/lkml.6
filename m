Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24114C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94102087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94102087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJQO1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:27:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:61980 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbeJQO1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:27:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 23:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,391,1534834800"; 
   d="scan'208";a="273090123"
Received: from aaronlu.sh.intel.com ([10.239.159.44])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2018 23:33:43 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [RFC v4 PATCH 4/5] mm/free_pcppages_bulk: reduce overhead of cluster operation on free path
Date:   Wed, 17 Oct 2018 14:33:29 +0800
Message-Id: <20181017063330.15384-5-aaron.lu@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181017063330.15384-1-aaron.lu@intel.com>
References: <20181017063330.15384-1-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After "no_merge for order 0", the biggest overhead in free path for
order 0 pages is now add_to_cluster(). As pages are freed one by one,
it caused frequent operation of add_to_cluster().

Ideally, if only one migratetype pcp list has pages to free and
count=pcp->batch in free_pcppages_bulk(), we can avoid calling
add_to_cluster() one time per page but adding them in one go as
a single cluster so this patch just did this.

This optimization brings zone->lock contention down from 25% to
almost zero again using the parallel free workload.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 mm/page_alloc.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e60a248030dc..204696f6c2f4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1242,6 +1242,36 @@ static inline void prefetch_buddy(struct page *page)
 	prefetch(buddy);
 }
 
+static inline bool free_cluster_pages(struct zone *zone, struct list_head *list,
+				      int mt, int count)
+{
+	struct cluster *c;
+	struct page *page, *n;
+
+	if (!can_skip_merge(zone, 0))
+		return false;
+
+	if (count != this_cpu_ptr(zone->pageset)->pcp.batch)
+		return false;
+
+	c = new_cluster(zone, count, list_first_entry(list, struct page, lru));
+	if (unlikely(!c))
+		return false;
+
+	list_for_each_entry_safe(page, n, list, lru) {
+		set_page_order(page, 0);
+		set_page_merge_skipped(page);
+		page->cluster = c;
+		list_add(&page->lru, &zone->free_area[0].free_list[mt]);
+	}
+
+	INIT_LIST_HEAD(list);
+	zone->free_area[0].nr_free += count;
+	__mod_zone_page_state(zone, NR_FREE_PAGES, count);
+
+	return true;
+}
+
 /*
  * Frees a number of pages from the PCP lists
  * Assumes all pages on list are in same zone, and of same order.
@@ -1256,10 +1286,10 @@ static inline void prefetch_buddy(struct page *page)
 static void free_pcppages_bulk(struct zone *zone, int count,
 					struct per_cpu_pages *pcp)
 {
-	int migratetype = 0;
-	int batch_free = 0;
+	int migratetype = 0, i, count_mt[MIGRATE_PCPTYPES] = {0};
+	int batch_free = 0, saved_count = count;
 	int prefetch_nr = 0;
-	bool isolated_pageblocks;
+	bool isolated_pageblocks, single_mt = false;
 	struct page *page, *tmp;
 	LIST_HEAD(head);
 
@@ -1283,6 +1313,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		/* This is the only non-empty list. Free them all. */
 		if (batch_free == MIGRATE_PCPTYPES)
 			batch_free = count;
+		count_mt[migratetype] += batch_free;
 
 		do {
 			page = list_last_entry(list, struct page, lru);
@@ -1314,12 +1345,24 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		} while (--count && --batch_free && !list_empty(list));
 	}
 
+	for (i = 0; i < MIGRATE_PCPTYPES; i++) {
+		if (count_mt[i] == saved_count) {
+			single_mt = true;
+			break;
+		}
+	}
+
 	spin_lock(&zone->lock);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
+	if (!isolated_pageblocks && single_mt)
+		free_cluster_pages(zone, &head, migratetype, saved_count);
+
 	/*
 	 * Use safe version since after __free_one_page(),
 	 * page->lru.next will not point to original list.
+	 *
+	 * If free_cluster_pages() succeeds, head will be an empty list here.
 	 */
 	list_for_each_entry_safe(page, tmp, &head, lru) {
 		int mt = get_pcppage_migratetype(page);
-- 
2.17.2

