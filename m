Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934778AbeBMKFH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:05:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60887 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934196AbeBMKE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:04:58 -0500
Date: Tue, 13 Feb 2018 02:04:49 -0800
From: tip-bot for Yang Shi <tipbot@zytor.com>
Message-ID: <tip-636e1970fd7deaa0d0ee0dfb6ac65fbd690b32d2@git.kernel.org>
Cc: hpa@zytor.com, yang.shi@linux.alibaba.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: yang.shi@linux.alibaba.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1517872708-24207-4-git-send-email-yang.shi@linux.alibaba.com>
References: <1517872708-24207-4-git-send-email-yang.shi@linux.alibaba.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Use global free list in
 free_object()
Git-Commit-ID: 636e1970fd7deaa0d0ee0dfb6ac65fbd690b32d2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  636e1970fd7deaa0d0ee0dfb6ac65fbd690b32d2
Gitweb:     https://git.kernel.org/tip/636e1970fd7deaa0d0ee0dfb6ac65fbd690b32d2
Author:     Yang Shi <yang.shi@linux.alibaba.com>
AuthorDate: Tue, 6 Feb 2018 07:18:27 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 13 Feb 2018 10:58:59 +0100

debugobjects: Use global free list in free_object()

The newly added global free list allows to avoid lengthy pool_list
iterations in free_obj_work() by putting objects either into the pool list
when the fill level of the pool is below the maximum or by putting them on
the global free list immediately.

As the pool is now guaranteed to never exceed the maximum fill level this
allows to remove the batch removal from pool list in free_obj_work().

Split free_object() into two parts, so the actual queueing function can be
reused without invoking schedule_work() on every invocation.

[ tglx: Remove the batch removal from pool list and massage changelog ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: longman@redhat.com
Link: https://lkml.kernel.org/r/1517872708-24207-4-git-send-email-yang.shi@linux.alibaba.com

---
 lib/debugobjects.c | 63 +++++++++++++++++++-----------------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index e31273b..3e79c10 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -201,18 +201,13 @@ alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
  * workqueue function to free objects.
  *
  * To reduce contention on the global pool_lock, the actual freeing of
- * debug objects will be delayed if the pool_lock is busy. We also free
- * the objects in a batch of 4 for each lock/unlock cycle.
+ * debug objects will be delayed if the pool_lock is busy.
  */
-#define ODEBUG_FREE_BATCH	4
-
 static void free_obj_work(struct work_struct *work)
 {
-	struct debug_obj *objs[ODEBUG_FREE_BATCH];
 	struct hlist_node *tmp;
 	struct debug_obj *obj;
 	unsigned long flags;
-	int i;
 	HLIST_HEAD(tofree);
 
 	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
@@ -240,26 +235,6 @@ static void free_obj_work(struct work_struct *work)
 		hlist_move_list(&obj_to_free, &tofree);
 		obj_nr_tofree = 0;
 	}
-
-	while (obj_pool_free >= debug_objects_pool_size + ODEBUG_FREE_BATCH) {
-		for (i = 0; i < ODEBUG_FREE_BATCH; i++) {
-			objs[i] = hlist_entry(obj_pool.first,
-					      typeof(*objs[0]), node);
-			hlist_del(&objs[i]->node);
-		}
-
-		obj_pool_free -= ODEBUG_FREE_BATCH;
-		debug_objects_freed += ODEBUG_FREE_BATCH;
-		/*
-		 * We release pool_lock across kmem_cache_free() to
-		 * avoid contention on pool_lock.
-		 */
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
-		for (i = 0; i < ODEBUG_FREE_BATCH; i++)
-			kmem_cache_free(obj_cache, objs[i]);
-		if (!raw_spin_trylock_irqsave(&pool_lock, flags))
-			return;
-	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
 
 	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
@@ -268,27 +243,33 @@ static void free_obj_work(struct work_struct *work)
 	}
 }
 
-/*
- * Put the object back into the pool and schedule work to free objects
- * if necessary.
- */
-static void free_object(struct debug_obj *obj)
+static bool __free_object(struct debug_obj *obj)
 {
 	unsigned long flags;
-	int sched = 0;
+	bool work;
 
 	raw_spin_lock_irqsave(&pool_lock, flags);
-	/*
-	 * schedule work when the pool is filled and the cache is
-	 * initialized:
-	 */
-	if (obj_pool_free > debug_objects_pool_size && obj_cache)
-		sched = 1;
-	hlist_add_head(&obj->node, &obj_pool);
-	obj_pool_free++;
+	work = (obj_pool_free > debug_objects_pool_size) && obj_cache;
 	obj_pool_used--;
+
+	if (work) {
+		obj_nr_tofree++;
+		hlist_add_head(&obj->node, &obj_to_free);
+	} else {
+		obj_pool_free++;
+		hlist_add_head(&obj->node, &obj_pool);
+	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
-	if (sched)
+	return work;
+}
+
+/*
+ * Put the object back into the pool and schedule work to free objects
+ * if necessary.
+ */
+static void free_object(struct debug_obj *obj)
+{
+	if (__free_object(obj))
 		schedule_work(&debug_obj_work);
 }
 
