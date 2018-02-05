Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeBEXTX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:19:23 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:45395 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751913AbeBEXTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:19:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SxlA7uj_1517872711;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: tglx@linutronix.de, longman@redhat.com
Cc: yang.shi@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4 v6] lib: debugobjects: add global free list and the counter
Date: Tue,  6 Feb 2018 07:18:26 +0800
Message-Id: <1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a global free list and counter for reusing the objects.

Moving free objects from the global free list to pool list when pool list
is not full when freeing them. If the pool list is full already, just free
the memory of the objects later.

When initializing objects, fill the pool list from the global free list
first if it has free objects for reuse.

Reuse pool lock to protect the global free list and its counter.

And, export the number of objects on the global free list to sysfs:

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

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 166488d..c15fb5f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -42,11 +42,14 @@ struct debug_bucket {
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
@@ -97,9 +100,23 @@ static int __init disable_object_debug(char *str)
 static void fill_pool(void)
 {
 	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
-	struct debug_obj *new;
+	struct debug_obj *new, *obj;
 	unsigned long flags;
 
+	/*
+	 * Reuse objs from the global free list, they will be reinitialized
+	 * when allocating
+	 */
+	while (obj_nr_tofree > 0 && (obj_pool_free < obj_pool_min_free)) {
+		raw_spin_lock_irqsave(&pool_lock, flags);
+		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+		hlist_del(&obj->node);
+		obj_nr_tofree--;
+		hlist_add_head(&obj->node, &obj_pool);
+		obj_pool_free++;
+		raw_spin_unlock_irqrestore(&pool_lock, flags);
+	}
+
 	if (likely(obj_pool_free >= debug_objects_pool_min_level))
 		return;
 
@@ -186,11 +203,40 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
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
+	while (obj_pool_free < debug_objects_pool_size) {
+		if (obj_nr_tofree <= 0)
+			break;
+
+		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+		hlist_del(&obj->node);
+		hlist_add_head(&obj->node, &obj_pool);
+		obj_pool_free++;
+		obj_nr_tofree--;
+	}
+
+	/*
+	 * pool list is already full, and there are still objs on the free list,
+	 * move remaining free objs to a separate list to free the memory later.
+	 */
+	if (obj_nr_tofree > 0) {
+		hlist_move_list(&obj_to_free, &tofree);
+		obj_nr_tofree = 0;
+	}
+
 	while (obj_pool_free >= debug_objects_pool_size + ODEBUG_FREE_BATCH) {
 		for (i = 0; i < ODEBUG_FREE_BATCH; i++) {
 			objs[i] = hlist_entry(obj_pool.first,
@@ -211,6 +257,13 @@ static void free_obj_work(struct work_struct *work)
 			return;
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
+
+	if (!hlist_empty(&tofree)) {
+		hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
+			hlist_del(&obj->node);
+			kmem_cache_free(obj_cache, obj);
+		}
+	}
 }
 
 /*
@@ -793,6 +846,7 @@ static int debug_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
 	seq_printf(m, "pool_used     :%d\n", obj_pool_used);
 	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
+	seq_printf(m, "on_free_list  :%d\n", obj_nr_tofree);
 	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
 	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
 	return 0;
-- 
1.8.3.1
