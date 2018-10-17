Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BA0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7A321523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7A321523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJQO1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:27:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:61980 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbeJQO1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:27:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 23:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,391,1534834800"; 
   d="scan'208";a="273090084"
Received: from aaronlu.sh.intel.com ([10.239.159.44])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2018 23:33:37 -0700
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
Subject: [RFC v4 PATCH 2/5] mm/__free_one_page: skip merge for order-0 page unless compaction failed
Date:   Wed, 17 Oct 2018 14:33:27 +0800
Message-Id: <20181017063330.15384-3-aaron.lu@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181017063330.15384-1-aaron.lu@intel.com>
References: <20181017063330.15384-1-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running will-it-scale/page_fault1 process mode workload on a 2 sockets
Intel Skylake server showed severe lock contention of zone->lock, as
high as about 80%(42% on allocation path and 35% on free path) CPU
cycles are burnt spinning. With perf, the most time consuming part inside
that lock on free path is cache missing on page structures, mostly on
the to-be-freed page's buddy due to merging.

One way to avoid this overhead is not do any merging at all for order-0
pages. With this approach, the lock contention for zone->lock on free
path dropped to 1.1% but allocation side still has as high as 42% lock
contention. In the meantime, the dropped lock contention on free side
doesn't translate to performance increase, instead, it's consumed by
increased lock contention of the per node lru_lock(rose from 5% to 37%)
and the final performance slightly dropped about 1%.

Though performance dropped a little, it almost eliminated zone lock
contention on free path and it is the foundation for the next patch
that eliminates zone lock contention for allocation path.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 include/linux/mm_types.h |  9 +++-
 mm/compaction.c          | 13 +++++-
 mm/internal.h            | 27 ++++++++++++
 mm/page_alloc.c          | 88 ++++++++++++++++++++++++++++++++++------
 4 files changed, 121 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f6292a53..aed93053ef6e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -179,8 +179,13 @@ struct page {
 		int units;			/* SLOB */
 	};
 
-	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
-	atomic_t _refcount;
+	union {
+		/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
+		atomic_t _refcount;
+
+		/* For pages in Buddy: if skipped merging when added to Buddy */
+		bool buddy_merge_skipped;
+	};
 
 #ifdef CONFIG_MEMCG
 	struct mem_cgroup *mem_cgroup;
diff --git a/mm/compaction.c b/mm/compaction.c
index faca45ebe62d..0c9c7a30dde3 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -777,8 +777,19 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * potential isolation targets.
 		 */
 		if (PageBuddy(page)) {
-			unsigned long freepage_order = page_order_unsafe(page);
+			unsigned long freepage_order;
 
+			/*
+			 * If this is a merge_skipped page, do merge now
+			 * since high-order pages are needed. zone lock
+			 * isn't taken for the merge_skipped check so the
+			 * check could be wrong but the worst case is we
+			 * lose a merge opportunity.
+			 */
+			if (page_merge_was_skipped(page))
+				try_to_merge_page(page);
+
+			freepage_order = page_order_unsafe(page);
 			/*
 			 * Without lock, we cannot be sure that what we got is
 			 * a valid page order. Consider only values in the
diff --git a/mm/internal.h b/mm/internal.h
index 87256ae1bef8..c166735a559e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -527,4 +527,31 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 
 void setup_zone_pageset(struct zone *zone);
 extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+
+static inline bool page_merge_was_skipped(struct page *page)
+{
+	return page->buddy_merge_skipped;
+}
+
+void try_to_merge_page(struct page *page);
+
+#ifdef CONFIG_COMPACTION
+static inline bool can_skip_merge(struct zone *zone, int order)
+{
+	/* Compaction has failed in this zone, we shouldn't skip merging */
+	if (zone->compact_considered)
+		return false;
+
+	/* Only consider no_merge for order 0 pages */
+	if (order)
+		return false;
+
+	return true;
+}
+#else /* CONFIG_COMPACTION */
+static inline bool can_skip_merge(struct zone *zone, int order)
+{
+	return false;
+}
+#endif  /* CONFIG_COMPACTION */
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 14c20bb3a3da..76d471e0ab24 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -691,6 +691,16 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
 				unsigned int order, int migratetype) {}
 #endif
 
+static inline void set_page_merge_skipped(struct page *page)
+{
+	page->buddy_merge_skipped = true;
+}
+
+static inline void clear_page_merge_skipped(struct page *page)
+{
+	page->buddy_merge_skipped = false;
+}
+
 static inline void set_page_order(struct page *page, unsigned int order)
 {
 	set_page_private(page, order);
@@ -700,6 +710,7 @@ static inline void set_page_order(struct page *page, unsigned int order)
 static inline void add_to_buddy_common(struct page *page, struct zone *zone,
 					unsigned int order)
 {
+	clear_page_merge_skipped(page);
 	set_page_order(page, order);
 	zone->free_area[order].nr_free++;
 }
@@ -730,6 +741,7 @@ static inline void remove_from_buddy(struct page *page, struct zone *zone,
 	list_del(&page->lru);
 	zone->free_area[order].nr_free--;
 	rmv_page_order(page);
+	clear_page_merge_skipped(page);
 }
 
 /*
@@ -797,7 +809,7 @@ static inline int page_is_buddy(struct page *page, struct page *buddy,
  * -- nyc
  */
 
-static inline void __free_one_page(struct page *page,
+static inline void do_merge(struct page *page,
 		unsigned long pfn,
 		struct zone *zone, unsigned int order,
 		int migratetype)
@@ -809,16 +821,6 @@ static inline void __free_one_page(struct page *page,
 
 	max_order = min_t(unsigned int, MAX_ORDER, pageblock_order + 1);
 
-	VM_BUG_ON(!zone_is_initialized(zone));
-	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
-
-	VM_BUG_ON(migratetype == -1);
-	if (likely(!is_migrate_isolate(migratetype)))
-		__mod_zone_freepage_state(zone, 1 << order, migratetype);
-
-	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
-	VM_BUG_ON_PAGE(bad_range(zone, page), page);
-
 continue_merging:
 	while (order < max_order - 1) {
 		buddy_pfn = __find_buddy_pfn(pfn, order);
@@ -891,6 +893,61 @@ static inline void __free_one_page(struct page *page,
 	add_to_buddy_head(page, zone, order, migratetype);
 }
 
+void try_to_merge_page(struct page *page)
+{
+	unsigned long pfn, buddy_pfn, flags;
+	struct page *buddy;
+	struct zone *zone;
+
+	/*
+	 * No need to do merging if buddy is not free.
+	 * zone lock isn't taken so this could be wrong but worst case
+	 * is we lose a merge opportunity.
+	 */
+	pfn = page_to_pfn(page);
+	buddy_pfn = __find_buddy_pfn(pfn, 0);
+	buddy = page + (buddy_pfn - pfn);
+	if (!PageBuddy(buddy))
+		return;
+
+	zone = page_zone(page);
+	spin_lock_irqsave(&zone->lock, flags);
+	/* Verify again after taking the lock */
+	if (likely(PageBuddy(page) && page_merge_was_skipped(page) &&
+		   PageBuddy(buddy))) {
+		int mt = get_pageblock_migratetype(page);
+
+		remove_from_buddy(page, zone, 0);
+		do_merge(page, pfn, zone, 0, mt);
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
+
+static inline void __free_one_page(struct page *page,
+		unsigned long pfn,
+		struct zone *zone, unsigned int order,
+		int migratetype)
+{
+	VM_BUG_ON(!zone_is_initialized(zone));
+	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
+
+	VM_BUG_ON(migratetype == -1);
+	if (likely(!is_migrate_isolate(migratetype)))
+		__mod_zone_freepage_state(zone, 1 << order, migratetype);
+
+	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
+	VM_BUG_ON_PAGE(bad_range(zone, page), page);
+
+	if (can_skip_merge(zone, order)) {
+		add_to_buddy_head(page, zone, 0, migratetype);
+		set_page_merge_skipped(page);
+		return;
+	}
+
+	do_merge(page, pfn, zone, order, migratetype);
+}
+
+
 /*
  * A bad page could be due to a number of fields. Instead of multiple branches,
  * try and check multiple fields with one check. The caller must do a detailed
@@ -1148,9 +1205,14 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			 * can be offset by reduced memory latency later. To
 			 * avoid excessive prefetching due to large count, only
 			 * prefetch buddy for the first pcp->batch nr of pages.
+			 *
+			 * If merge can be skipped, no need to prefetch buddy.
 			 */
-			if (prefetch_nr++ < pcp->batch)
-				prefetch_buddy(page);
+			if (can_skip_merge(zone, 0) || prefetch_nr > pcp->batch)
+				continue;
+
+			prefetch_buddy(page);
+			prefetch_nr++;
 		} while (--count && --batch_free && !list_empty(list));
 	}
 
-- 
2.17.2

