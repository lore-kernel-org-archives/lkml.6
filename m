Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C7FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17E420B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbfAaPhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:37:09 -0500
Received: from relay.sw.ru ([185.231.240.75]:50392 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfAaPhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:37:09 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gpEOl-00039g-7T; Thu, 31 Jan 2019 18:37:03 +0300
Subject: [PATCH] mm: Do not allocate duplicate stack variables in
 shrink_page_list()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
        ktkhai@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 31 Jan 2019 18:37:02 +0300
Message-ID: <154894900030.5211.12104993874109647641.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On path shrink_inactive_list() ---> shrink_page_list()
we allocate stack variables for the statistics twice.
This is completely useless, and this just consumes stack
much more, then we really need.

The patch kills duplicate stack variables from shrink_page_list(),
and this reduce stack usage and object file size significantly:

Stack usage:
Before: vmscan.c:1122:22:shrink_page_list	648	static
After:  vmscan.c:1122:22:shrink_page_list	616	static

Size of vmscan.o:
         text	   data	    bss	    dec	    hex	filename
Before: 56866	   4720	    128	  61714	   f112	mm/vmscan.o
After:  56770	   4720	    128	  61618	   f0b2	mm/vmscan.o

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index dd9554f5d788..54a389fd91e2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1128,16 +1128,9 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
-	int pgactivate = 0;
-	unsigned nr_unqueued_dirty = 0;
-	unsigned nr_dirty = 0;
-	unsigned nr_congested = 0;
 	unsigned nr_reclaimed = 0;
-	unsigned nr_writeback = 0;
-	unsigned nr_immediate = 0;
-	unsigned nr_ref_keep = 0;
-	unsigned nr_unmap_fail = 0;
 
+	memset(stat, 0, sizeof(*stat));
 	cond_resched();
 
 	while (!list_empty(page_list)) {
@@ -1181,10 +1174,10 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		 */
 		page_check_dirty_writeback(page, &dirty, &writeback);
 		if (dirty || writeback)
-			nr_dirty++;
+			stat->nr_dirty++;
 
 		if (dirty && !writeback)
-			nr_unqueued_dirty++;
+			stat->nr_unqueued_dirty++;
 
 		/*
 		 * Treat this page as congested if the underlying BDI is or if
@@ -1196,7 +1189,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		if (((dirty || writeback) && mapping &&
 		     inode_write_congested(mapping->host)) ||
 		    (writeback && PageReclaim(page)))
-			nr_congested++;
+			stat->nr_congested++;
 
 		/*
 		 * If a page at the tail of the LRU is under writeback, there
@@ -1245,7 +1238,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			if (current_is_kswapd() &&
 			    PageReclaim(page) &&
 			    test_bit(PGDAT_WRITEBACK, &pgdat->flags)) {
-				nr_immediate++;
+				stat->nr_immediate++;
 				goto activate_locked;
 
 			/* Case 2 above */
@@ -1263,7 +1256,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				 * and it's also appropriate in global reclaim.
 				 */
 				SetPageReclaim(page);
-				nr_writeback++;
+				stat->nr_writeback++;
 				goto activate_locked;
 
 			/* Case 3 above */
@@ -1283,7 +1276,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		case PAGEREF_ACTIVATE:
 			goto activate_locked;
 		case PAGEREF_KEEP:
-			nr_ref_keep++;
+			stat->nr_ref_keep++;
 			goto keep_locked;
 		case PAGEREF_RECLAIM:
 		case PAGEREF_RECLAIM_CLEAN:
@@ -1348,7 +1341,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			if (unlikely(PageTransHuge(page)))
 				flags |= TTU_SPLIT_HUGE_PMD;
 			if (!try_to_unmap(page, flags)) {
-				nr_unmap_fail++;
+				stat->nr_unmap_fail++;
 				goto activate_locked;
 			}
 		}
@@ -1496,7 +1489,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		VM_BUG_ON_PAGE(PageActive(page), page);
 		if (!PageMlocked(page)) {
 			SetPageActive(page);
-			pgactivate++;
+			stat->nr_activate++;
 			count_memcg_page_event(page, PGACTIVATE);
 		}
 keep_locked:
@@ -1511,18 +1504,8 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 	free_unref_page_list(&free_pages);
 
 	list_splice(&ret_pages, page_list);
-	count_vm_events(PGACTIVATE, pgactivate);
-
-	if (stat) {
-		stat->nr_dirty = nr_dirty;
-		stat->nr_congested = nr_congested;
-		stat->nr_unqueued_dirty = nr_unqueued_dirty;
-		stat->nr_writeback = nr_writeback;
-		stat->nr_immediate = nr_immediate;
-		stat->nr_activate = pgactivate;
-		stat->nr_ref_keep = nr_ref_keep;
-		stat->nr_unmap_fail = nr_unmap_fail;
-	}
+	count_vm_events(PGACTIVATE, stat->nr_activate);
+
 	return nr_reclaimed;
 }
 
@@ -1534,6 +1517,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 		.priority = DEF_PRIORITY,
 		.may_unmap = 1,
 	};
+	struct reclaim_stat dummy_stat;
 	unsigned long ret;
 	struct page *page, *next;
 	LIST_HEAD(clean_pages);
@@ -1547,7 +1531,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 	}
 
 	ret = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
-			TTU_IGNORE_ACCESS, NULL, true);
+			TTU_IGNORE_ACCESS, &dummy_stat, true);
 	list_splice(&clean_pages, page_list);
 	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -ret);
 	return ret;
@@ -1922,7 +1906,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	unsigned long nr_scanned;
 	unsigned long nr_reclaimed = 0;
 	unsigned long nr_taken;
-	struct reclaim_stat stat = {};
+	struct reclaim_stat stat;
 	int file = is_file_lru(lru);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;

