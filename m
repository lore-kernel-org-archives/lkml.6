Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DE2ECDFC0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD46206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD46206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeIKKeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:34:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:62545 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeIKKeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:34:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 22:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="262426344"
Received: from aaronlu.sh.intel.com ([10.239.159.44])
  by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2018 22:36:43 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Yosef Lev <levyossi@icloud.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [RFC PATCH 9/9] mm: page_alloc: merge before sending pages to global pool
Date:   Tue, 11 Sep 2018 13:36:16 +0800
Message-Id: <20180911053616.6894-10-aaron.lu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911053616.6894-1-aaron.lu@intel.com>
References: <20180911053616.6894-1-aaron.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have mergable pages in Buddy unmerged, this is a step
to reduce such things from happening to some extent.

Suppose two buddy pages are on the list to be freed in free_pcppages_bulk(),
the first page goes to merge but its buddy is not in Buddy yet so we
hold it locally as an order0 page; then its buddy page goes to merge and
couldn't merge either because we hold the first page locally instead of
having it in Buddy. The end result is, we have two mergable buddy pages
but failed to merge it.

So this patch will attempt merge for these to-be-freed pages before
acquiring any lock, it could, to some extent, reduce fragmentation caused
by last patch.

With this change, the pcp_drain trace isn't easy to use so I removed it.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 mm/page_alloc.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index df38c3f2a1cc..d3eafe857713 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1098,6 +1098,72 @@ void __init percpu_mergelist_init(void)
 	}
 }
 
+static inline bool buddy_in_list(struct page *page, struct page *buddy,
+				 struct list_head *list)
+{
+	list_for_each_entry_continue(page, list, lru)
+		if (page == buddy)
+			return true;
+
+	return false;
+}
+
+static inline void merge_in_pcp(struct list_head *list)
+{
+	int order;
+	struct page *page;
+
+	/* Set order information to 0 initially since they are PCP pages */
+	list_for_each_entry(page, list, lru)
+		set_page_private(page, 0);
+
+	/*
+	 * Check for mergable pages for each order.
+	 *
+	 * For each order, check if their buddy is also in the list and
+	 * if so, do merge, then remove the merged buddy from the list.
+	 */
+	for (order = 0; order < MAX_ORDER - 1; order++) {
+		bool has_merge = false;
+
+		page = list_first_entry(list, struct page, lru);
+		while (&page->lru != list) {
+			unsigned long pfn, buddy_pfn, combined_pfn;
+			struct page *buddy, *n;
+
+			if (page_order(page) != order) {
+				page = list_next_entry(page, lru);
+				continue;
+			}
+
+			pfn = page_to_pfn(page);
+			buddy_pfn = __find_buddy_pfn(pfn, order);
+			buddy = page + (buddy_pfn - pfn);
+			if (!buddy_in_list(page, buddy, list) ||
+			    page_order(buddy) != order) {
+				page = list_next_entry(page, lru);
+				continue;
+			}
+
+			combined_pfn = pfn & buddy_pfn;
+			if (combined_pfn == pfn) {
+				set_page_private(page, order + 1);
+				list_del(&buddy->lru);
+				page = list_next_entry(page, lru);
+			} else {
+				set_page_private(buddy, order + 1);
+				n = list_next_entry(page, lru);
+				list_del(&page->lru);
+				page = n;
+			}
+			has_merge = true;
+		}
+
+		if (!has_merge)
+			break;
+	}
+}
+
 /*
  * Frees a number of pages from the PCP lists
  * Assumes all pages on list are in same zone, and of same order.
@@ -1165,6 +1231,12 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		} while (--count && --batch_free && !list_empty(list));
 	}
 
+	/*
+	 * Before acquiring the possibly heavily contended zone lock, do merge
+	 * among these to-be-freed PCP pages before sending them to Buddy.
+	 */
+	merge_in_pcp(&head);
+
 	read_lock(&zone->lock);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
@@ -1182,10 +1254,9 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		if (unlikely(isolated_pageblocks))
 			mt = get_pageblock_migratetype(page);
 
-		order = 0;
+		order = page_order(page);
 		merged_page = do_merge(page, page_to_pfn(page), zone, &order, mt);
 		list_add(&merged_page->lru, this_cpu_ptr(&merge_lists[order][mt]));
-		trace_mm_page_pcpu_drain(page, 0, mt);
 	}
 
 	for_each_migratetype_order(order, migratetype) {
-- 
2.17.1

