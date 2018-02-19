Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeBSTtp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:49:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753808AbeBSTq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:46:27 -0500
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 47/61] shmem: Convert shmem_tag_pins to XArray
Date: Mon, 19 Feb 2018 11:45:42 -0800
Message-Id: <20180219194556.6575-48-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219194556.6575-1-willy@infradead.org>
References: <20180219194556.6575-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Simplify the locking by taking the spinlock while we walk the tree on
the assumption that many acquires and releases of the lock will be
worse than holding the lock for a (potentially) long time.

We could replicate the same locking behaviour with the xarray, but would
have to be careful that the xa_node wasn't RCU-freed under us before we
took the lock.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/shmem.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0179f9aa7d0e..5b70fbdec605 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2601,35 +2601,28 @@ static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
 
 static void shmem_tag_pins(struct address_space *mapping)
 {
-	struct radix_tree_iter iter;
-	void **slot;
-	pgoff_t start;
+	XA_STATE(xas, &mapping->pages, 0);
 	struct page *page;
+	unsigned int tagged = 0;
 
 	lru_add_drain();
-	start = 0;
-	rcu_read_lock();
 
-	radix_tree_for_each_slot(slot, &mapping->pages, &iter, start) {
-		page = radix_tree_deref_slot(slot);
-		if (!page || radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page)) {
-				slot = radix_tree_iter_retry(&iter);
-				continue;
-			}
-		} else if (page_count(page) - page_mapcount(page) > 1) {
-			xa_lock_irq(&mapping->pages);
-			radix_tree_tag_set(&mapping->pages, iter.index,
-					   SHMEM_TAG_PINNED);
-			xa_unlock_irq(&mapping->pages);
-		}
+	xas_lock_irq(&xas);
+	xas_for_each(&xas, page, ULONG_MAX) {
+		if (xa_is_value(page))
+			continue;
+		if (page_count(page) - page_mapcount(page) > 1)
+			xas_set_tag(&xas, SHMEM_TAG_PINNED);
 
-		if (need_resched()) {
-			slot = radix_tree_iter_resume(slot, &iter);
-			cond_resched_rcu();
-		}
+		if (++tagged % XA_CHECK_SCHED)
+			continue;
+
+		xas_pause(&xas);
+		xas_unlock_irq(&xas);
+		cond_resched();
+		xas_lock_irq(&xas);
 	}
-	rcu_read_unlock();
+	xas_unlock_irq(&xas);
 }
 
 /*
-- 
2.16.1
