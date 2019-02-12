Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A1CC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69A92075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfBLPOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:14:22 -0500
Received: from relay.sw.ru ([185.231.240.75]:45228 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbfBLPOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:14:20 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gtZlJ-0001ZP-Gv; Tue, 12 Feb 2019 18:14:17 +0300
Subject: [PATCH 4/4] mm: Generalize putback scan functions
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, ktkhai@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Feb 2019 18:14:16 +0300
Message-ID: <154998445694.18704.16751838197928455484.stgit@localhost.localdomain>
In-Reply-To: <154998432043.18704.10326447825287153712.stgit@localhost.localdomain>
References: <154998432043.18704.10326447825287153712.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This combines two similar functions move_active_pages_to_lru()
and putback_inactive_pages() into single move_pages_to_lru().
This remove duplicate code and makes object file size smaller.

Before:
   text	   data	    bss	    dec	    hex	filename
  57082	   4732	    128	  61942	   f1f6	mm/vmscan.o
After:
   text	   data	    bss	    dec	    hex	filename
  55112	   4600	    128	  59840	   e9c0	mm/vmscan.o

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |  124 ++++++++++++++++++++---------------------------------------
 1 file changed, 41 insertions(+), 83 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 88fa71e4c28f..66e70cf1dd94 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1807,33 +1807,53 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 	return isolated > inactive;
 }
 
-static noinline_for_stack void
-putback_inactive_pages(struct lruvec *lruvec, struct list_head *page_list)
+/*
+ * This moves pages from @list to corresponding LRU list.
+ *
+ * We move them the other way if the page is referenced by one or more
+ * processes, from rmap.
+ *
+ * If the pages are mostly unmapped, the processing is fast and it is
+ * appropriate to hold zone_lru_lock across the whole operation.  But if
+ * the pages are mapped, the processing is slow (page_referenced()) so we
+ * should drop zone_lru_lock around each page.  It's impossible to balance
+ * this, so instead we remove the pages from the LRU while processing them.
+ * It is safe to rely on PG_active against the non-LRU pages in here because
+ * nobody will play with that bit on a non-LRU page.
+ *
+ * The downside is that we have to touch page->_refcount against each page.
+ * But we had to alter page->flags anyway.
+ *
+ * Returns the number of pages moved to the given lruvec.
+ */
+
+static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
+						     struct list_head *list)
 {
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
+	struct page *page;
+	enum lru_list lru;
 
-	/*
-	 * Put back any unfreeable pages.
-	 */
-	while (!list_empty(page_list)) {
-		struct page *page = lru_to_page(page_list);
-		int lru;
-
-		VM_BUG_ON_PAGE(PageLRU(page), page);
-		list_del(&page->lru);
+	while (!list_empty(list)) {
+		page = lru_to_page(list);
 		if (unlikely(!page_evictable(page))) {
+			list_del_init(&page->lru);
 			spin_unlock_irq(&pgdat->lru_lock);
 			putback_lru_page(page);
 			spin_lock_irq(&pgdat->lru_lock);
 			continue;
 		}
-
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
+		VM_BUG_ON_PAGE(PageLRU(page), page);
 		SetPageLRU(page);
 		lru = page_lru(page);
-		add_page_to_lru_list(page, lruvec, lru);
+
+		nr_pages = hpage_nr_pages(page);
+		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
+		list_move(&page->lru, &lruvec->lists[lru]);
 
 		if (put_page_testzero(page)) {
 			__ClearPageLRU(page);
@@ -1847,13 +1867,17 @@ putback_inactive_pages(struct lruvec *lruvec, struct list_head *page_list)
 				spin_lock_irq(&pgdat->lru_lock);
 			} else
 				list_add(&page->lru, &pages_to_free);
+		} else {
+			nr_moved += nr_pages;
 		}
 	}
 
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
 	 */
-	list_splice(&pages_to_free, page_list);
+	list_splice(&pages_to_free, list);
+
+	return nr_moved;
 }
 
 /*
@@ -1945,7 +1969,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	reclaim_stat->recent_rotated[0] = stat.nr_activate[0];
 	reclaim_stat->recent_rotated[1] = stat.nr_activate[1];
 
-	putback_inactive_pages(lruvec, &page_list);
+	move_pages_to_lru(lruvec, &page_list);
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 
@@ -1982,72 +2006,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	return nr_reclaimed;
 }
 
-/*
- * This moves pages from the active list to the inactive list.
- *
- * We move them the other way if the page is referenced by one or more
- * processes, from rmap.
- *
- * If the pages are mostly unmapped, the processing is fast and it is
- * appropriate to hold zone_lru_lock across the whole operation.  But if
- * the pages are mapped, the processing is slow (page_referenced()) so we
- * should drop zone_lru_lock around each page.  It's impossible to balance
- * this, so instead we remove the pages from the LRU while processing them.
- * It is safe to rely on PG_active against the non-LRU pages in here because
- * nobody will play with that bit on a non-LRU page.
- *
- * The downside is that we have to touch page->_refcount against each page.
- * But we had to alter page->flags anyway.
- *
- * Returns the number of pages moved to the given lru.
- */
-
-static unsigned move_active_pages_to_lru(struct lruvec *lruvec,
-				     struct list_head *list,
-				     enum lru_list lru)
-{
-	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
-	LIST_HEAD(pages_to_free);
-	struct page *page;
-	int nr_pages;
-	int nr_moved = 0;
-
-	while (!list_empty(list)) {
-		page = lru_to_page(list);
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-
-		VM_BUG_ON_PAGE(PageLRU(page), page);
-		SetPageLRU(page);
-
-		nr_pages = hpage_nr_pages(page);
-		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
-		list_move(&page->lru, &lruvec->lists[lru]);
-
-		if (put_page_testzero(page)) {
-			__ClearPageLRU(page);
-			__ClearPageActive(page);
-			del_page_from_lru_list(page, lruvec, lru);
-
-			if (unlikely(PageCompound(page))) {
-				spin_unlock_irq(&pgdat->lru_lock);
-				mem_cgroup_uncharge(page);
-				(*get_compound_page_dtor(page))(page);
-				spin_lock_irq(&pgdat->lru_lock);
-			} else
-				list_add(&page->lru, &pages_to_free);
-		} else {
-			nr_moved += nr_pages;
-		}
-	}
-
-	/*
-	 * To save our caller's stack, now use input list for pages to free.
-	 */
-	list_splice(&pages_to_free, list);
-
-	return nr_moved;
-}
-
 static void shrink_active_list(unsigned long nr_to_scan,
 			       struct lruvec *lruvec,
 			       struct scan_control *sc,
@@ -2134,8 +2092,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	 */
 	reclaim_stat->recent_rotated[file] += nr_rotated;
 
-	nr_activate = move_active_pages_to_lru(lruvec, &l_active, lru);
-	nr_deactivate = move_active_pages_to_lru(lruvec, &l_inactive, lru - LRU_ACTIVE);
+	nr_activate = move_pages_to_lru(lruvec, &l_active);
+	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
 	/* Keep all free pages are in l_active list */
 	list_splice(&l_inactive, &l_active);
 

