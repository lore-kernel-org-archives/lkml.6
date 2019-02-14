Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B5EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B837B2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438383AbfBNKfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:35:41 -0500
Received: from relay.sw.ru ([185.231.240.75]:43042 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438353AbfBNKfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:35:39 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1guEMj-00053m-CT; Thu, 14 Feb 2019 13:35:37 +0300
Subject: [PATCH v2 4/4] mm: Generalize putback scan functions
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        mhocko@suse.com, ktkhai@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Feb 2019 13:35:37 +0300
Message-ID: <155014053725.28944.7960592286711533914.stgit@localhost.localdomain>
In-Reply-To: <155014039859.28944.1726860521114076369.stgit@localhost.localdomain>
References: <155014039859.28944.1726860521114076369.stgit@localhost.localdomain>
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

Note, that now we are checking for !page_evictable() coming
from shrink_active_list(), which shouldn't change any behavior
since that path works with evictable pages only.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

v2: Move VM_BUG_ON() up.
---
 mm/vmscan.c |  122 +++++++++++++++++++----------------------------------------
 1 file changed, 40 insertions(+), 82 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 656a9b5af2a4..fcec2385dda2 100644
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
+	while (!list_empty(list)) {
+		page = lru_to_page(list);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
-		list_del(&page->lru);
 		if (unlikely(!page_evictable(page))) {
+			list_del_init(&page->lru);
 			spin_unlock_irq(&pgdat->lru_lock);
 			putback_lru_page(page);
 			spin_lock_irq(&pgdat->lru_lock);
 			continue;
 		}
-
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
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
 	/* Keep all free pages in l_active list */
 	list_splice(&l_inactive, &l_active);
 

