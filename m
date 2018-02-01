Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeBASQ2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:16:28 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47633 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752901AbeBASQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:16:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0SxX0U2T_1517508959;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: tglx@linutronix.de, longman@redhat.com
Cc: yang.shi@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2 v5] lib: debugobjects: handle objects free in a batch outside the loop
Date: Fri,  2 Feb 2018 02:15:59 +0800
Message-Id: <1517508959-63958-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1517508959-63958-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1517508959-63958-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are nested loops on debug objects free path, sometimes it may take
over hundred thousands of loops, then cause soft lockup with
!CONFIG_PREEMPT occasionally, like below:

NMI watchdog: BUG: soft lockup - CPU#15 stuck for 22s! [stress-ng-getde:110342]

 CPU: 15 PID: 110342 Comm: stress-ng-getde Tainted: G
E   4.9.44-003.ali3000.alios7.x86_64.debug #1
 Hardware name: Dell Inc. PowerEdge R720xd/0X6FFV, BIOS
1.6.0 03/07/2013

Call Trace:
  [<ffffffff8141177e>] debug_check_no_obj_freed+0x13e/0x220
  [<ffffffff811f8751>] __free_pages_ok+0x1f1/0x5c0
  [<ffffffff811fa785>] __free_pages+0x25/0x40
  [<ffffffff812638db>] __free_slab+0x19b/0x270
  [<ffffffff812639e9>] discard_slab+0x39/0x50
  [<ffffffff812679f7>] __slab_free+0x207/0x270
  [<ffffffff81269966>] ___cache_free+0xa6/0xb0
  [<ffffffff8126c267>] qlist_free_all+0x47/0x80
  [<ffffffff8126c5a9>] quarantine_reduce+0x159/0x190
  [<ffffffff8126b3bf>] kasan_kmalloc+0xaf/0xc0
  [<ffffffff8126b8a2>] kasan_slab_alloc+0x12/0x20
  [<ffffffff81265e8a>] kmem_cache_alloc+0xfa/0x360
  [<ffffffff812abc8f>] ? getname_flags+0x4f/0x1f0
  [<ffffffff812abc8f>] getname_flags+0x4f/0x1f0
  [<ffffffff812abe42>] getname+0x12/0x20
  [<ffffffff81298da9>] do_sys_open+0xf9/0x210
  [<ffffffff81298ede>] SyS_open+0x1e/0x20
  [<ffffffff817d6e01>] entry_SYSCALL_64_fastpath+0x1f/0xc2

The code path might be called in either atomic or non-atomic context,
and in_atomic() can't tell if current context is atomic or not on
!PREEMPT kernel, so cond_resched() can't be used to prevent from the
softlockup.

Defer objects free outside of the loop in a batch to save some cycles
in the loop.
The objects will be added to a global free list, then put them back to
pool list in a work if the pool list is not full. If the pool list is
already full, the objects will stay on the global free list, then will
be freed later.
When allocating objects, check if there are any objects available on
the global free list and just reuse the objects if the global free list
is not empty. Reuse pool lock to protect the free list. Using a new lock
sounds overkilling.

Export the number of objects on the global freelist to sysfs, which
looks like:

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
v5: Trimmed commit log to just keep call stack and process info.
    Per tglx's comment, just move free objs to the pool list when it is not
    full. If the pool list is full, free the memory of objs on the free list.
v4: Dropped touching softlockup watchdog approach, and defer objects free
    outside the for loop per the suggestion from tglx.

 lib/debugobjects.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 166488d..943882b 100644
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
@@ -141,7 +144,8 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 }
 
 /*
- * Allocate a new object. If the pool is empty, switch off the debugger.
+ * Allocate a new object. Retrieve from global freelist first. If the pool is
+ * empty, switch off the debugger.
  * Must be called with interrupts disabled.
  */
 static struct debug_obj *
@@ -150,6 +154,13 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 	struct debug_obj *obj = NULL;
 
 	raw_spin_lock(&pool_lock);
+	if (obj_nr_tofree > 0 && (obj_pool_free < obj_pool_min_free)) {
+		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+		obj_nr_tofree--;
+		hlist_del(&obj->node);
+		goto out;
+	}
+
 	if (obj_pool.first) {
 		obj	    = hlist_entry(obj_pool.first, typeof(*obj), node);
 
@@ -169,6 +180,8 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 		if (obj_pool_free < obj_pool_min_free)
 			obj_pool_min_free = obj_pool_free;
 	}
+
+out:
 	raw_spin_unlock(&pool_lock);
 
 	return obj;
@@ -186,11 +199,37 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
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
+	/* When pool list is not full move free objs to pool list */
+	while (obj_pool_free < debug_objects_pool_size) {
+		if (obj_nr_tofree <= 0)
+			break;
+
+		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+		hlist_del(&obj->node);
+		hlist_add_head(&obj->node, &obj_pool);
+		obj_pool_free++;
+		obj_pool_used--;
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
@@ -211,6 +250,13 @@ static void free_obj_work(struct work_struct *work)
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
@@ -716,7 +762,6 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
 	struct hlist_node *tmp;
-	HLIST_HEAD(freelist);
 	struct debug_obj_descr *descr;
 	enum debug_obj_state state;
 	struct debug_bucket *db;
@@ -752,18 +797,17 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 				goto repeat;
 			default:
 				hlist_del(&obj->node);
-				hlist_add_head(&obj->node, &freelist);
+				/* Put obj on the global free list */
+				raw_spin_lock(&pool_lock);
+				hlist_add_head(&obj->node, &obj_to_free);
+				/* Update the counter of objs on the global freelist */
+				obj_nr_tofree++;
+				raw_spin_unlock(&pool_lock);
 				break;
 			}
 		}
 		raw_spin_unlock_irqrestore(&db->lock, flags);
 
-		/* Now free them */
-		hlist_for_each_entry_safe(obj, tmp, &freelist, node) {
-			hlist_del(&obj->node);
-			free_object(obj);
-		}
-
 		if (cnt > debug_objects_maxchain)
 			debug_objects_maxchain = cnt;
 
@@ -772,6 +816,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 	if (max_loops > debug_objects_maxloops)
 		debug_objects_maxloops = max_loops;
+
+	/* Schedule work to move free objs to pool list */
+	if (obj_nr_tofree > 0)
+		schedule_work(&debug_obj_work);
 }
 
 void debug_check_no_obj_freed(const void *address, unsigned long size)
@@ -793,6 +841,7 @@ static int debug_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
 	seq_printf(m, "pool_used     :%d\n", obj_pool_used);
 	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
+	seq_printf(m, "on_free_list  :%d\n", obj_nr_tofree);
 	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
 	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
 	return 0;
-- 
1.8.3.1
