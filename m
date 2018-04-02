Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeDBGUf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:20:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35748 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeDBGUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:20:34 -0400
X-Google-Smtp-Source: AIpwx49glDcF7Xq5Of7Gxfh/gnqn+eYlbxcIzRL/mFXgH5GoEq7WZVR+2YoPFHG6ayCIdBuFABXFQw==
Date: Mon, 2 Apr 2018 08:20:29 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] debugobjects changes for v4.17
Message-ID: <20180402062029.j2atgjcfwhxesz3y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-debugobjects-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-for-linus

   # HEAD: 163cf842f5837334bc69aaf09ad38e11f4573914 debugobjects: Avoid another unused variable warning

Misc improvements:

 - add better instrumentation/debugging
 - optimize the freeing logic improve performance

 Thanks,

	Ingo

------------------>
Arnd Bergmann (2):
      debugobjects: Fix debug_objects_freed accounting
      debugobjects: Avoid another unused variable warning

Yang Shi (4):
      debugobjects: Export max loops counter
      debugobjects: Add global free list and the counter
      debugobjects: Use global free list in free_object()
      debugobjects: Use global free list in __debug_check_no_obj_freed()


 lib/debugobjects.c | 141 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 92 insertions(+), 49 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 2f5349c6e81a..994be4805cec 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -42,14 +42,18 @@ static struct debug_obj		obj_static_pool[ODEBUG_POOL_SIZE] __initdata;
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
+static int __maybe_unused	debug_objects_maxchecked __read_mostly;
 static int			debug_objects_fixups __read_mostly;
 static int			debug_objects_warnings __read_mostly;
 static int			debug_objects_enabled __read_mostly
@@ -96,12 +100,32 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
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
 
@@ -177,62 +201,76 @@ alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
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
+	struct hlist_node *tmp;
+	struct debug_obj *obj;
 	unsigned long flags;
-	int i;
+	HLIST_HEAD(tofree);
 
 	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
 		return;
-	while (obj_pool_free >= debug_objects_pool_size + ODEBUG_FREE_BATCH) {
-		for (i = 0; i < ODEBUG_FREE_BATCH; i++) {
-			objs[i] = hlist_entry(obj_pool.first,
-					      typeof(*objs[0]), node);
-			hlist_del(&objs[i]->node);
-		}
 
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
+		debug_objects_freed += obj_nr_tofree;
+		obj_nr_tofree = 0;
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
+
+	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
+		hlist_del(&obj->node);
+		kmem_cache_free(obj_cache, obj);
+	}
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
 
@@ -714,13 +752,13 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
 static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
-	struct hlist_node *tmp;
-	HLIST_HEAD(freelist);
 	struct debug_obj_descr *descr;
 	enum debug_obj_state state;
 	struct debug_bucket *db;
+	struct hlist_node *tmp;
 	struct debug_obj *obj;
-	int cnt;
+	int cnt, objs_checked = 0;
+	bool work = false;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -751,21 +789,24 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 				goto repeat;
 			default:
 				hlist_del(&obj->node);
-				hlist_add_head(&obj->node, &freelist);
+				work |= __free_object(obj);
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
+
+		objs_checked += cnt;
 	}
+
+	if (objs_checked > debug_objects_maxchecked)
+		debug_objects_maxchecked = objs_checked;
+
+	/* Schedule work to actually kmem_cache_free() objects */
+	if (work)
+		schedule_work(&debug_obj_work);
 }
 
 void debug_check_no_obj_freed(const void *address, unsigned long size)
@@ -780,12 +821,14 @@ void debug_check_no_obj_freed(const void *address, unsigned long size)
 static int debug_stats_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
+	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
 	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
 	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
 	seq_printf(m, "pool_free     :%d\n", obj_pool_free);
 	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
 	seq_printf(m, "pool_used     :%d\n", obj_pool_used);
 	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
+	seq_printf(m, "on_free_list  :%d\n", obj_nr_tofree);
 	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
 	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
 	return 0;
