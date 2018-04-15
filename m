Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeDOHmh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 03:42:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33285 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbeDOHmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 03:42:36 -0400
X-Google-Smtp-Source: AIpwx49JWmHn4VHDbZVIujOvyxPbiheEjiYQue3qInRm8Cbf5o4E6fzUsQ/O2x22zwxm6R4cQB0SNg==
From: Omar Sandoval <osandov@osandov.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, kernel-team@fb.com
Subject: [PATCH] lockdep: fix fs_reclaim annotation
Date: Sun, 15 Apr 2018 00:42:25 -0700
Message-Id: <9f8aa70652a98e98d7c4de0fc96a4addcee13efe.1523778026.git.osandov@fb.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

While revisiting my Btrfs swapfile series [1], I introduced a situation
in which reclaim would lock i_rwsem, and even though the swapon() path
clearly made GFP_KERNEL allocations while holding i_rwsem, I got no
complaints from lockdep. It turns out that the rework of the fs_reclaim
annotation was broken: if the current task has PF_MEMALLOC set, we don't
acquire the dummy fs_reclaim lock, but when reclaiming we always check
this _after_ we've just set the PF_MEMALLOC flag. In most cases, we can
fix this by moving the fs_reclaim_{acquire,release}() outside of the
memalloc_noreclaim_{save,restore}(), althought kswapd is slightly
different. After applying this, I got the expected lockdep splats.

1: https://lwn.net/Articles/625412/
Fixes: d92a8cfcb37e ("locking/lockdep: Rework FS_RECLAIM annotation")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/sched/mm.h |  4 ++++
 mm/page_alloc.c          | 20 +++++++++++++++-----
 mm/vmscan.c              | 20 +++++++++++++-------
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2c570cd934af..93294695688a 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -163,9 +163,13 @@ static inline gfp_t current_gfp_context(gfp_t flags)
 }
 
 #ifdef CONFIG_LOCKDEP
+extern void __fs_reclaim_acquire(void);
+extern void __fs_reclaim_release(void);
 extern void fs_reclaim_acquire(gfp_t gfp_mask);
 extern void fs_reclaim_release(gfp_t gfp_mask);
 #else
+static inline void __fs_reclaim_acquire(void) { }
+static inline void __fs_reclaim_release(void) { }
 static inline void fs_reclaim_acquire(gfp_t gfp_mask) { }
 static inline void fs_reclaim_release(gfp_t gfp_mask) { }
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 905db9d7962f..ddcbcf8dae05 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3708,7 +3708,7 @@ should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_fla
 #endif /* CONFIG_COMPACTION */
 
 #ifdef CONFIG_LOCKDEP
-struct lockdep_map __fs_reclaim_map =
+static struct lockdep_map __fs_reclaim_map =
 	STATIC_LOCKDEP_MAP_INIT("fs_reclaim", &__fs_reclaim_map);
 
 static bool __need_fs_reclaim(gfp_t gfp_mask)
@@ -3733,17 +3733,27 @@ static bool __need_fs_reclaim(gfp_t gfp_mask)
 	return true;
 }
 
+void __fs_reclaim_acquire(void)
+{
+	lock_map_acquire(&__fs_reclaim_map);
+}
+
+void __fs_reclaim_release(void)
+{
+	lock_map_release(&__fs_reclaim_map);
+}
+
 void fs_reclaim_acquire(gfp_t gfp_mask)
 {
 	if (__need_fs_reclaim(gfp_mask))
-		lock_map_acquire(&__fs_reclaim_map);
+		__fs_reclaim_acquire();
 }
 EXPORT_SYMBOL_GPL(fs_reclaim_acquire);
 
 void fs_reclaim_release(gfp_t gfp_mask)
 {
 	if (__need_fs_reclaim(gfp_mask))
-		lock_map_release(&__fs_reclaim_map);
+		__fs_reclaim_release();
 }
 EXPORT_SYMBOL_GPL(fs_reclaim_release);
 #endif
@@ -3761,8 +3771,8 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 
 	/* We now go into synchronous reclaim */
 	cpuset_memory_pressure_bump();
-	noreclaim_flag = memalloc_noreclaim_save();
 	fs_reclaim_acquire(gfp_mask);
+	noreclaim_flag = memalloc_noreclaim_save();
 	reclaim_state.reclaimed_slab = 0;
 	current->reclaim_state = &reclaim_state;
 
@@ -3770,8 +3780,8 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 								ac->nodemask);
 
 	current->reclaim_state = NULL;
-	fs_reclaim_release(gfp_mask);
 	memalloc_noreclaim_restore(noreclaim_flag);
+	fs_reclaim_release(gfp_mask);
 
 	cond_resched();
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8b920ce3ae02..68ed72b52c59 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3299,11 +3299,15 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 		.may_unmap = 1,
 		.may_swap = 1,
 	};
+
+	__fs_reclaim_acquire();
+
 	count_vm_event(PAGEOUTRUN);
 
 	do {
 		unsigned long nr_reclaimed = sc.nr_reclaimed;
 		bool raise_priority = true;
+		bool ret;
 
 		sc.reclaim_idx = classzone_idx;
 
@@ -3376,7 +3380,10 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 			wake_up_all(&pgdat->pfmemalloc_wait);
 
 		/* Check if kswapd should be suspending */
-		if (try_to_freeze() || kthread_should_stop())
+		__fs_reclaim_release();
+		ret = try_to_freeze();
+		__fs_reclaim_acquire();
+		if (ret || kthread_should_stop())
 			break;
 
 		/*
@@ -3393,6 +3400,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 
 out:
 	snapshot_refaults(NULL, pgdat);
+	__fs_reclaim_release();
 	/*
 	 * Return the order kswapd stopped reclaiming at as
 	 * prepare_kswapd_sleep() takes it into account. If another caller
@@ -3581,9 +3589,7 @@ static int kswapd(void *p)
 		 */
 		trace_mm_vmscan_kswapd_wake(pgdat->node_id, classzone_idx,
 						alloc_order);
-		fs_reclaim_acquire(GFP_KERNEL);
 		reclaim_order = balance_pgdat(pgdat, alloc_order, classzone_idx);
-		fs_reclaim_release(GFP_KERNEL);
 		if (reclaim_order < alloc_order)
 			goto kswapd_try_sleep;
 	}
@@ -3665,16 +3671,16 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 	unsigned long nr_reclaimed;
 	unsigned int noreclaim_flag;
 
-	noreclaim_flag = memalloc_noreclaim_save();
 	fs_reclaim_acquire(sc.gfp_mask);
+	noreclaim_flag = memalloc_noreclaim_save();
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
 	p->reclaim_state = NULL;
-	fs_reclaim_release(sc.gfp_mask);
 	memalloc_noreclaim_restore(noreclaim_flag);
+	fs_reclaim_release(sc.gfp_mask);
 
 	return nr_reclaimed;
 }
@@ -3851,6 +3857,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	};
 
 	cond_resched();
+	fs_reclaim_acquire(sc.gfp_mask);
 	/*
 	 * We need to be able to allocate from the reserves for RECLAIM_UNMAP
 	 * and we also need to be able to write out pages for RECLAIM_WRITE
@@ -3858,7 +3865,6 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	 */
 	noreclaim_flag = memalloc_noreclaim_save();
 	p->flags |= PF_SWAPWRITE;
-	fs_reclaim_acquire(sc.gfp_mask);
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;
 
@@ -3873,9 +3879,9 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	}
 
 	p->reclaim_state = NULL;
-	fs_reclaim_release(gfp_mask);
 	current->flags &= ~PF_SWAPWRITE;
 	memalloc_noreclaim_restore(noreclaim_flag);
+	fs_reclaim_release(sc.gfp_mask);
 	return sc.nr_reclaimed >= nr_pages;
 }
 
-- 
2.17.0
