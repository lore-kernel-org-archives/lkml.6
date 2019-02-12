Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8A4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B557B217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfBLPOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:14:15 -0500
Received: from relay.sw.ru ([185.231.240.75]:45214 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbfBLPOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:14:14 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gtZlD-0001ZB-Od; Tue, 12 Feb 2019 18:14:11 +0300
Subject: [PATCH 3/4] mm: Remove pages_to_free argument of
 move_active_pages_to_lru()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, ktkhai@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Feb 2019 18:14:11 +0300
Message-ID: <154998445148.18704.11244772245027520877.stgit@localhost.localdomain>
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

We may use input argument list as output argument too.
This makes the function more similar to putback_inactive_pages().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8d7d55e71511..88fa71e4c28f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2004,10 +2004,10 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 static unsigned move_active_pages_to_lru(struct lruvec *lruvec,
 				     struct list_head *list,
-				     struct list_head *pages_to_free,
 				     enum lru_list lru)
 {
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+	LIST_HEAD(pages_to_free);
 	struct page *page;
 	int nr_pages;
 	int nr_moved = 0;
@@ -2034,12 +2034,17 @@ static unsigned move_active_pages_to_lru(struct lruvec *lruvec,
 				(*get_compound_page_dtor(page))(page);
 				spin_lock_irq(&pgdat->lru_lock);
 			} else
-				list_add(&page->lru, pages_to_free);
+				list_add(&page->lru, &pages_to_free);
 		} else {
 			nr_moved += nr_pages;
 		}
 	}
 
+	/*
+	 * To save our caller's stack, now use input list for pages to free.
+	 */
+	list_splice(&pages_to_free, list);
+
 	return nr_moved;
 }
 
@@ -2129,8 +2134,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	 */
 	reclaim_stat->recent_rotated[file] += nr_rotated;
 
-	nr_activate = move_active_pages_to_lru(lruvec, &l_active, &l_hold, lru);
-	nr_deactivate = move_active_pages_to_lru(lruvec, &l_inactive, &l_hold, lru - LRU_ACTIVE);
+	nr_activate = move_active_pages_to_lru(lruvec, &l_active, lru);
+	nr_deactivate = move_active_pages_to_lru(lruvec, &l_inactive, lru - LRU_ACTIVE);
+	/* Keep all free pages are in l_active list */
+	list_splice(&l_inactive, &l_active);
 
 	__count_vm_events(PGDEACTIVATE, nr_deactivate);
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
@@ -2138,8 +2145,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	spin_unlock_irq(&pgdat->lru_lock);
 
-	mem_cgroup_uncharge_list(&l_hold);
-	free_unref_page_list(&l_hold);
+	mem_cgroup_uncharge_list(&l_active);
+	free_unref_page_list(&l_active);
 	trace_mm_vmscan_lru_shrink_active(pgdat->node_id, nr_taken, nr_activate,
 			nr_deactivate, nr_rotated, sc->priority, file);
 }

