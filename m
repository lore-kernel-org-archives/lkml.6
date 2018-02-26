Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeBZNxB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:53:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:54609 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753086AbeBZNww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:52:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="29836368"
From: Aaron Lu <aaron.lu@intel.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 2/3] mm/free_pcppages_bulk: do not hold lock when picking pages to free
Date: Mon, 26 Feb 2018 21:53:45 +0800
Message-Id: <20180226135346.7208-3-aaron.lu@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180226135346.7208-1-aaron.lu@intel.com>
References: <20180226135346.7208-1-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When freeing a batch of pages from Per-CPU-Pages(PCP) back to buddy,
the zone->lock is held and then pages are chosen from PCP's migratetype
list. While there is actually no need to do this 'choose part' under
lock since it's PCP pages, the only CPU that can touch them is us and
irq is also disabled.

Moving this part outside could reduce lock held time and improve
performance. Test with will-it-scale/page_fault1 full load:

kernel      Broadwell(2S)  Skylake(2S)   Broadwell(4S)  Skylake(4S)
v4.16-rc2+  9034215        7971818       13667135       15677465
this patch  9536374 +5.6%  8314710 +4.3% 14070408 +3.0% 16675866 +6.4%

What the test does is: starts $nr_cpu processes and each will repeatedly
do the following for 5 minutes:
1 mmap 128M anonymouse space;
2 write access to that space;
3 munmap.
The score is the aggregated iteration.

https://github.com/antonblanchard/will-it-scale/blob/master/tests/page_fault1.c

Acked-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 mm/page_alloc.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3154859cccd6..35576da0a6c9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1116,13 +1116,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	int migratetype = 0;
 	int batch_free = 0;
 	bool isolated_pageblocks;
+	struct page *page, *tmp;
+	LIST_HEAD(head);
 
 	pcp->count -= count;
-	spin_lock(&zone->lock);
-	isolated_pageblocks = has_isolate_pageblock(zone);
-
 	while (count) {
-		struct page *page;
 		struct list_head *list;
 
 		/*
@@ -1144,26 +1142,31 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			batch_free = count;
 
 		do {
-			int mt;	/* migratetype of the to-be-freed page */
-
 			page = list_last_entry(list, struct page, lru);
 			/* must delete as __free_one_page list manipulates */
 			list_del(&page->lru);
 
-			mt = get_pcppage_migratetype(page);
-			/* MIGRATE_ISOLATE page should not go to pcplists */
-			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
-			/* Pageblock could have been isolated meanwhile */
-			if (unlikely(isolated_pageblocks))
-				mt = get_pageblock_migratetype(page);
-
 			if (bulkfree_pcp_prepare(page))
 				continue;
 
-			__free_one_page(page, page_to_pfn(page), zone, 0, mt);
-			trace_mm_page_pcpu_drain(page, 0, mt);
+			list_add_tail(&page->lru, &head);
 		} while (--count && --batch_free && !list_empty(list));
 	}
+
+	spin_lock(&zone->lock);
+	isolated_pageblocks = has_isolate_pageblock(zone);
+
+	list_for_each_entry_safe(page, tmp, &head, lru) {
+		int mt = get_pcppage_migratetype(page);
+		/* MIGRATE_ISOLATE page should not go to pcplists */
+		VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
+		/* Pageblock could have been isolated meanwhile */
+		if (unlikely(isolated_pageblocks))
+			mt = get_pageblock_migratetype(page);
+
+		__free_one_page(page, page_to_pfn(page), zone, 0, mt);
+		trace_mm_page_pcpu_drain(page, 0, mt);
+	}
 	spin_unlock(&zone->lock);
 }
 
-- 
2.14.3
