Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934486AbeBMKEi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:04:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58865 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933964AbeBMKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:04:29 -0500
Date: Tue, 13 Feb 2018 02:04:20 -0800
From: tip-bot for Yang Shi <tipbot@zytor.com>
Message-ID: <tip-36c4ead6f6dfbbe777d3d7e9cc8702530b71a94f@git.kernel.org>
Cc: hpa@zytor.com, yang.shi@linux.alibaba.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        yang.shi@linux.alibaba.com, hpa@zytor.com
In-Reply-To: <1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com>
References: <1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Add global free list and the
 counter
Git-Commit-ID: 36c4ead6f6dfbbe777d3d7e9cc8702530b71a94f
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

Commit-ID:  36c4ead6f6dfbbe777d3d7e9cc8702530b71a94f
Gitweb:     https://git.kernel.org/tip/36c4ead6f6dfbbe777d3d7e9cc8702530b71a94f
Author:     Yang Shi <yang.shi@linux.alibaba.com>
AuthorDate: Tue, 6 Feb 2018 07:18:26 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 13 Feb 2018 10:58:58 +0100

debugobjects: Add global free list and the counter

free_object() adds objects to the pool list and schedules work when the
pool list is larger than the pool size.  The worker handles the actual
kfree() of the object by iterating the pool list until the pool size is
below the maximum pool size again.

To iterate the pool list, pool_lock has to be held and the objects which
should be freed() need to be put into temporary storage so pool_lock can be
dropped for the actual kmem_cache_free() invocation. That's a pointless and
expensive exercise if there is a large number of objects to free.

In such a case its better to evaulate the fill level of the pool in
free_objects() and queue the object to free either in the pool list or if
it's full on a separate global free list.

The worker can then do the following simpler operation:

  - Move objects back from the global free list to the pool list if the
    pool list is not longer full.

  - Remove the remaining objects in a single list move operation from the
    global free list and do the kmem_cache_free() operation lockless from
    the temporary list head.

In fill_pool() the global free list is checked as well to avoid real
allocations from the kmem cache.

Add the necessary list head and a counter for the number of objects on the
global free list and export that counter via sysfs:

max_chain     :79
max_loops     :8147
warnings      :0
fixups        :0
pool_free     :1697
pool_min_free :346
pool_used     :15356
pool_max_used :23933
on_free_list  :39
objs_allocated:32617
objs_freed    :16588

Nothing queues objects on the global free list yet. This happens in a
follow up change.

[ tglx: Simplified implementation and massaged changelog ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: longman@redhat.com
Link: https://lkml.kernel.org/r/1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com

---
 lib/debugobjects.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index f6d57a1..e31273b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -42,11 +42,14 @@ static struct debug_obj		obj_static_pool[ODEBUG_POOL_SIZE] __initdata;
 static DEFINE_RAW_SPINLOCK(pool_lock);
 
 static HLIST_HEAD(obj_pool);
+static HLIST_HEAD(obj_to_free);
 
 static int			obj_pool_min_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_used;
 static int			obj_pool_max_used;
+/* The number of objs on the global free list */
+static int			obj_nr_tofree;
 static struct kmem_cache	*obj_cache;
 
 static int			debug_objects_maxchain __read_mostly;
@@ -97,12 +100,32 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 static void fill_pool(void)
 {
 	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
-	struct debug_obj *new;
+	struct debug_obj *new, *obj;
 	unsigned long flags;
 
 	if (likely(obj_pool_free >= debug_objects_pool_min_level))
 		return;
 
+	/*
+	 * Reuse objs from the global free list; they will be reinitialized
+	 * when allocating.
+	 */
+	while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
+		raw_spin_lock_irqsave(&pool_lock, flags);
+		/*
+		 * Recheck with the lock held as the worker thread might have
+		 * won the race and freed the global free list already.
+		 */
+		if (obj_nr_tofree) {
+			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+			hlist_del(&obj->node);
+			obj_nr_tofree--;
+			hlist_add_head(&obj->node, &obj_pool);
+			obj_pool_free++;
+		}
+		raw_spin_unlock_irqrestore(&pool_lock, flags);
+	}
+
 	if (unlikely(!obj_cache))
 		return;
 
@@ -186,11 +209,38 @@ alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 static void free_obj_work(struct work_struct *work)
 {
 	struct debug_obj *objs[ODEBUG_FREE_BATCH];
+	struct hlist_node *tmp;
+	struct debug_obj *obj;
 	unsigned long flags;
 	int i;
+	HLIST_HEAD(tofree);
 
 	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
 		return;
+
+	/*
+	 * The objs on the pool list might be allocated before the work is
+	 * run, so recheck if pool list it full or not, if not fill pool
+	 * list from the global free list
+	 */
+	while (obj_nr_tofree && obj_pool_free < debug_objects_pool_size) {
+		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+		hlist_del(&obj->node);
+		hlist_add_head(&obj->node, &obj_pool);
+		obj_pool_free++;
+		obj_nr_tofree--;
+	}
+
+	/*
+	 * Pool list is already full and there are still objs on the free
+	 * list. Move remaining free objs to a temporary list to free the
+	 * memory outside the pool_lock held region.
+	 */
+	if (obj_nr_tofree) {
+		hlist_move_list(&obj_to_free, &tofree);
+		obj_nr_tofree = 0;
+	}
+
 	while (obj_pool_free >= debug_objects_pool_size + ODEBUG_FREE_BATCH) {
 		for (i = 0; i < ODEBUG_FREE_BATCH; i++) {
 			objs[i] = hlist_entry(obj_pool.first,
@@ -211,6 +261,11 @@ static void free_obj_work(struct work_struct *work)
 			return;
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
+
+	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
+		hlist_del(&obj->node);
+		kmem_cache_free(obj_cache, obj);
+	}
 }
 
 /*
@@ -793,6 +848,7 @@ static int debug_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
 	seq_printf(m, "pool_used     :%d\n", obj_pool_used);
 	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
+	seq_printf(m, "on_free_list  :%d\n", obj_nr_tofree);
 	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
 	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
 	return 0;
