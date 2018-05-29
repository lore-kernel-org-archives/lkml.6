Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965161AbeE2QmP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:42:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43298 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936494AbeE2QmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:42:13 -0400
Date: Tue, 29 May 2018 18:42:10 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.16.12-rt5
Message-ID: <20180529164210.4os2rn5femjpku6a@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.16.12-rt5 patch set. 

Changes since v4.16.12-rt4:

  - Update the "suspend prevent might sleep splat" patch. The newer
    version also supports s2idle.

  - The seqlock implementation had a missing memory barrier. Patch by
    Julia Cartwright.

  - The new priority reported by trace_sched_pi_setprio() was wrong in
    case the task was de-boosted. Reported by Christian Mansky.

  - Update of the refcount_t queue: The raid5 patch was replaced with
    the atomic interface because it does not fit for the refcount_t API.

  - Since the last release softirq_count() returns the "BH disable"
    count. In this release I am dropping the workarounds we had because
    softirq_count() returned always 0.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.16.12-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/incr/patch-4.16.12-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.16.12-rt5

The RT patch against v4.16.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patch-4.16.12-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patches-4.16.12-rt5.tar.xz

Sebastian

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index ea01621ed769..2e76fbcba76e 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -57,7 +57,7 @@ static void split_counters(unsigned int *cnt, unsigned int *inpr)
 /* A preserved old value of the events counter. */
 static unsigned int saved_count;
 
-static DEFINE_SPINLOCK(events_lock);
+static DEFINE_RAW_SPINLOCK(events_lock);
 
 static void pm_wakeup_timer_fn(struct timer_list *t);
 
@@ -185,9 +185,9 @@ void wakeup_source_add(struct wakeup_source *ws)
 	ws->active = false;
 	ws->last_time = ktime_get();
 
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	list_add_rcu(&ws->entry, &wakeup_sources);
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_add);
 
@@ -202,9 +202,9 @@ void wakeup_source_remove(struct wakeup_source *ws)
 	if (WARN_ON(!ws))
 		return;
 
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	list_del_rcu(&ws->entry);
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 	synchronize_srcu(&wakeup_srcu);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_remove);
@@ -843,7 +843,7 @@ bool pm_wakeup_pending(void)
 	unsigned long flags;
 	bool ret = false;
 
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	if (events_check_enabled) {
 		unsigned int cnt, inpr;
 
@@ -851,7 +851,7 @@ bool pm_wakeup_pending(void)
 		ret = (cnt != saved_count || inpr > 0);
 		events_check_enabled = !ret;
 	}
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 
 	if (ret) {
 		pr_info("PM: Wakeup pending, aborting suspend\n");
@@ -940,13 +940,13 @@ bool pm_save_wakeup_count(unsigned int count)
 	unsigned long flags;
 
 	events_check_enabled = false;
-	spin_lock_irqsave(&events_lock, flags);
+	raw_spin_lock_irqsave(&events_lock, flags);
 	split_counters(&cnt, &inpr);
 	if (cnt == count && inpr == 0) {
 		saved_count = count;
 		events_check_enabled = true;
 	}
-	spin_unlock_irqrestore(&events_lock, flags);
+	raw_spin_unlock_irqrestore(&events_lock, flags);
 	return events_check_enabled;
 }
 
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 532fdf56c117..3c65f52b68f5 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1049,7 +1049,7 @@ int r5l_write_stripe(struct r5l_log *log, struct stripe_head *sh)
 	 * don't delay.
 	 */
 	clear_bit(STRIPE_DELAYED, &sh->state);
-	refcount_inc(&sh->count);
+	atomic_inc(&sh->count);
 
 	mutex_lock(&log->io_mutex);
 	/* meta + data */
@@ -1388,7 +1388,7 @@ static void r5c_flush_stripe(struct r5conf *conf, struct stripe_head *sh)
 	lockdep_assert_held(&conf->device_lock);
 
 	list_del_init(&sh->lru);
-	refcount_inc(&sh->count);
+	atomic_inc(&sh->count);
 
 	set_bit(STRIPE_HANDLE, &sh->state);
 	atomic_inc(&conf->active_stripes);
@@ -1491,7 +1491,7 @@ static void r5c_do_reclaim(struct r5conf *conf)
 			 */
 			if (!list_empty(&sh->lru) &&
 			    !test_bit(STRIPE_HANDLE, &sh->state) &&
-			    refcount_read(&sh->count) == 0) {
+			    atomic_read(&sh->count) == 0) {
 				r5c_flush_stripe(conf, sh);
 				if (count++ >= R5C_RECLAIM_STRIPE_GROUP)
 					break;
@@ -2912,7 +2912,7 @@ int r5c_cache_data(struct r5l_log *log, struct stripe_head *sh)
 	 * don't delay.
 	 */
 	clear_bit(STRIPE_DELAYED, &sh->state);
-	refcount_inc(&sh->count);
+	atomic_inc(&sh->count);
 
 	mutex_lock(&log->io_mutex);
 	/* meta + data */
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 87840cfe7a80..42890a08375b 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -388,7 +388,7 @@ int ppl_write_stripe(struct r5conf *conf, struct stripe_head *sh)
 
 	set_bit(STRIPE_LOG_TRAPPED, &sh->state);
 	clear_bit(STRIPE_DELAYED, &sh->state);
-	refcount_inc(&sh->count);
+	atomic_inc(&sh->count);
 
 	if (ppl_log_stripe(log, sh)) {
 		spin_lock_irq(&ppl_conf->no_mem_stripes_lock);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index eb967afd749a..d8de7476d26a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -306,7 +306,7 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
 static void __release_stripe(struct r5conf *conf, struct stripe_head *sh,
 			     struct list_head *temp_inactive_list)
 {
-	if (refcount_dec_and_test(&sh->count))
+	if (atomic_dec_and_test(&sh->count))
 		do_release_stripe(conf, sh, temp_inactive_list);
 }
 
@@ -398,7 +398,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 
 	/* Avoid release_list until the last reference.
 	 */
-	if (refcount_dec_not_one(&sh->count))
+	if (atomic_add_unless(&sh->count, -1, 1))
 		return;
 
 	if (unlikely(!conf->mddev->thread) ||
@@ -410,7 +410,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 	return;
 slow_path:
 	/* we are ok here if STRIPE_ON_RELEASE_LIST is set or not */
-	if (refcount_dec_and_lock_irqsave(&sh->count, &conf->device_lock, &flags)) {
+	if (atomic_dec_and_lock_irqsave(&sh->count, &conf->device_lock, flags)) {
 		INIT_LIST_HEAD(&list);
 		hash = sh->hash_lock_index;
 		do_release_stripe(conf, sh, &list);
@@ -499,7 +499,7 @@ static void init_stripe(struct stripe_head *sh, sector_t sector, int previous)
 	struct r5conf *conf = sh->raid_conf;
 	int i, seq;
 
-	BUG_ON(refcount_read(&sh->count) != 0);
+	BUG_ON(atomic_read(&sh->count) != 0);
 	BUG_ON(test_bit(STRIPE_HANDLE, &sh->state));
 	BUG_ON(stripe_operations_active(sh));
 	BUG_ON(sh->batch_head);
@@ -676,11 +676,11 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 					  &conf->cache_state);
 			} else {
 				init_stripe(sh, sector, previous);
-				refcount_inc(&sh->count);
+				atomic_inc(&sh->count);
 			}
-		} else if (!refcount_inc_not_zero(&sh->count)) {
+		} else if (!atomic_inc_not_zero(&sh->count)) {
 			spin_lock(&conf->device_lock);
-			if (!refcount_read(&sh->count)) {
+			if (!atomic_read(&sh->count)) {
 				if (!test_bit(STRIPE_HANDLE, &sh->state))
 					atomic_inc(&conf->active_stripes);
 				BUG_ON(list_empty(&sh->lru) &&
@@ -696,7 +696,7 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 					sh->group = NULL;
 				}
 			}
-			refcount_inc(&sh->count);
+			atomic_inc(&sh->count);
 			spin_unlock(&conf->device_lock);
 		}
 	} while (sh == NULL);
@@ -758,9 +758,9 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 	hash = stripe_hash_locks_hash(head_sector);
 	spin_lock_irq(conf->hash_locks + hash);
 	head = __find_stripe(conf, head_sector, conf->generation);
-	if (head && !refcount_inc_not_zero(&head->count)) {
+	if (head && !atomic_inc_not_zero(&head->count)) {
 		spin_lock(&conf->device_lock);
-		if (!refcount_read(&head->count)) {
+		if (!atomic_read(&head->count)) {
 			if (!test_bit(STRIPE_HANDLE, &head->state))
 				atomic_inc(&conf->active_stripes);
 			BUG_ON(list_empty(&head->lru) &&
@@ -776,7 +776,7 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 				head->group = NULL;
 			}
 		}
-		refcount_inc(&head->count);
+		atomic_inc(&head->count);
 		spin_unlock(&conf->device_lock);
 	}
 	spin_unlock_irq(conf->hash_locks + hash);
@@ -845,7 +845,7 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 		sh->batch_head->bm_seq = seq;
 	}
 
-	refcount_inc(&sh->count);
+	atomic_inc(&sh->count);
 unlock_out:
 	unlock_two_stripes(head, sh);
 out:
@@ -1108,9 +1108,9 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			pr_debug("%s: for %llu schedule op %d on disc %d\n",
 				__func__, (unsigned long long)sh->sector,
 				bi->bi_opf, i);
-			refcount_inc(&sh->count);
+			atomic_inc(&sh->count);
 			if (sh != head_sh)
-				refcount_inc(&head_sh->count);
+				atomic_inc(&head_sh->count);
 			if (use_new_offset(conf, sh))
 				bi->bi_iter.bi_sector = (sh->sector
 						 + rdev->new_data_offset);
@@ -1172,9 +1172,9 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 				 "replacement disc %d\n",
 				__func__, (unsigned long long)sh->sector,
 				rbi->bi_opf, i);
-			refcount_inc(&sh->count);
+			atomic_inc(&sh->count);
 			if (sh != head_sh)
-				refcount_inc(&head_sh->count);
+				atomic_inc(&head_sh->count);
 			if (use_new_offset(conf, sh))
 				rbi->bi_iter.bi_sector = (sh->sector
 						  + rrdev->new_data_offset);
@@ -1352,7 +1352,7 @@ static void ops_run_biofill(struct stripe_head *sh)
 		}
 	}
 
-	refcount_inc(&sh->count);
+	atomic_inc(&sh->count);
 	init_async_submit(&submit, ASYNC_TX_ACK, tx, ops_complete_biofill, sh, NULL);
 	async_trigger_callback(&submit);
 }
@@ -1430,7 +1430,7 @@ ops_run_compute5(struct stripe_head *sh, struct raid5_percpu *percpu)
 		if (i != target)
 			xor_srcs[count++] = sh->dev[i].page;
 
-	refcount_inc(&sh->count);
+	atomic_inc(&sh->count);
 
 	init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_XOR_ZERO_DST, NULL,
 			  ops_complete_compute, sh, to_addr_conv(sh, percpu, 0));
@@ -1519,7 +1519,7 @@ ops_run_compute6_1(struct stripe_head *sh, struct raid5_percpu *percpu)
 	BUG_ON(!test_bit(R5_Wantcompute, &tgt->flags));
 	dest = tgt->page;
 
-	refcount_inc(&sh->count);
+	atomic_inc(&sh->count);
 
 	if (target == qd_idx) {
 		count = set_syndrome_sources(blocks, sh, SYNDROME_SRC_ALL);
@@ -1594,7 +1594,7 @@ ops_run_compute6_2(struct stripe_head *sh, struct raid5_percpu *percpu)
 	pr_debug("%s: stripe: %llu faila: %d failb: %d\n",
 		 __func__, (unsigned long long)sh->sector, faila, failb);
 
-	refcount_inc(&sh->count);
+	atomic_inc(&sh->count);
 
 	if (failb == syndrome_disks+1) {
 		/* Q disk is one of the missing disks */
@@ -1865,7 +1865,7 @@ ops_run_reconstruct5(struct stripe_head *sh, struct raid5_percpu *percpu,
 			break;
 	}
 	if (i >= sh->disks) {
-		refcount_inc(&sh->count);
+		atomic_inc(&sh->count);
 		set_bit(R5_Discard, &sh->dev[pd_idx].flags);
 		ops_complete_reconstruct(sh);
 		return;
@@ -1906,7 +1906,7 @@ ops_run_reconstruct5(struct stripe_head *sh, struct raid5_percpu *percpu,
 		flags = ASYNC_TX_ACK |
 			(prexor ? ASYNC_TX_XOR_DROP_DST : ASYNC_TX_XOR_ZERO_DST);
 
-		refcount_inc(&head_sh->count);
+		atomic_inc(&head_sh->count);
 		init_async_submit(&submit, flags, tx, ops_complete_reconstruct, head_sh,
 				  to_addr_conv(sh, percpu, j));
 	} else {
@@ -1948,7 +1948,7 @@ ops_run_reconstruct6(struct stripe_head *sh, struct raid5_percpu *percpu,
 			break;
 	}
 	if (i >= sh->disks) {
-		refcount_inc(&sh->count);
+		atomic_inc(&sh->count);
 		set_bit(R5_Discard, &sh->dev[sh->pd_idx].flags);
 		set_bit(R5_Discard, &sh->dev[sh->qd_idx].flags);
 		ops_complete_reconstruct(sh);
@@ -1972,7 +1972,7 @@ ops_run_reconstruct6(struct stripe_head *sh, struct raid5_percpu *percpu,
 				 struct stripe_head, batch_list) == head_sh;
 
 	if (last_stripe) {
-		refcount_inc(&head_sh->count);
+		atomic_inc(&head_sh->count);
 		init_async_submit(&submit, txflags, tx, ops_complete_reconstruct,
 				  head_sh, to_addr_conv(sh, percpu, j));
 	} else
@@ -2029,7 +2029,7 @@ static void ops_run_check_p(struct stripe_head *sh, struct raid5_percpu *percpu)
 	tx = async_xor_val(xor_dest, xor_srcs, 0, count, STRIPE_SIZE,
 			   &sh->ops.zero_sum_result, &submit);
 
-	refcount_inc(&sh->count);
+	atomic_inc(&sh->count);
 	init_async_submit(&submit, ASYNC_TX_ACK, tx, ops_complete_check, sh, NULL);
 	tx = async_trigger_callback(&submit);
 }
@@ -2048,7 +2048,7 @@ static void ops_run_check_pq(struct stripe_head *sh, struct raid5_percpu *percpu
 	if (!checkp)
 		srcs[count] = NULL;
 
-	refcount_inc(&sh->count);
+	atomic_inc(&sh->count);
 	init_async_submit(&submit, ASYNC_TX_ACK, NULL, ops_complete_check,
 			  sh, to_addr_conv(sh, percpu, 0));
 	async_syndrome_val(srcs, 0, count+2, STRIPE_SIZE,
@@ -2150,7 +2150,7 @@ static struct stripe_head *alloc_stripe(struct kmem_cache *sc, gfp_t gfp,
 		INIT_LIST_HEAD(&sh->lru);
 		INIT_LIST_HEAD(&sh->r5c);
 		INIT_LIST_HEAD(&sh->log_list);
-		refcount_set(&sh->count, 1);
+		atomic_set(&sh->count, 1);
 		sh->raid_conf = conf;
 		sh->log_start = MaxSector;
 		for (i = 0; i < disks; i++) {
@@ -2451,7 +2451,7 @@ static int drop_one_stripe(struct r5conf *conf)
 	spin_unlock_irq(conf->hash_locks + hash);
 	if (!sh)
 		return 0;
-	BUG_ON(refcount_read(&sh->count));
+	BUG_ON(atomic_read(&sh->count));
 	shrink_buffers(sh);
 	free_stripe(conf->slab_cache, sh);
 	atomic_dec(&conf->active_stripes);
@@ -2483,7 +2483,7 @@ static void raid5_end_read_request(struct bio * bi)
 			break;
 
 	pr_debug("end_read_request %llu/%d, count: %d, error %d.\n",
-		(unsigned long long)sh->sector, i, refcount_read(&sh->count),
+		(unsigned long long)sh->sector, i, atomic_read(&sh->count),
 		bi->bi_status);
 	if (i == disks) {
 		bio_reset(bi);
@@ -2620,7 +2620,7 @@ static void raid5_end_write_request(struct bio *bi)
 		}
 	}
 	pr_debug("end_write_request %llu/%d, count %d, error: %d.\n",
-		(unsigned long long)sh->sector, i, refcount_read(&sh->count),
+		(unsigned long long)sh->sector, i, atomic_read(&sh->count),
 		bi->bi_status);
 	if (i == disks) {
 		bio_reset(bi);
@@ -4687,7 +4687,7 @@ static void handle_stripe(struct stripe_head *sh)
 	pr_debug("handling stripe %llu, state=%#lx cnt=%d, "
 		"pd_idx=%d, qd_idx=%d\n, check:%d, reconstruct:%d\n",
 	       (unsigned long long)sh->sector, sh->state,
-	       refcount_read(&sh->count), sh->pd_idx, sh->qd_idx,
+	       atomic_read(&sh->count), sh->pd_idx, sh->qd_idx,
 	       sh->check_state, sh->reconstruct_state);
 
 	analyse_stripe(sh, &s);
@@ -5062,7 +5062,7 @@ static void activate_bit_delay(struct r5conf *conf,
 		struct stripe_head *sh = list_entry(head.next, struct stripe_head, lru);
 		int hash;
 		list_del_init(&sh->lru);
-		refcount_inc(&sh->count);
+		atomic_inc(&sh->count);
 		hash = sh->hash_lock_index;
 		__release_stripe(conf, sh, &temp_inactive_list[hash]);
 	}
@@ -5387,8 +5387,7 @@ static struct stripe_head *__get_priority_stripe(struct r5conf *conf, int group)
 		sh->group = NULL;
 	}
 	list_del_init(&sh->lru);
-	refcount_inc(&sh->count);
-	BUG_ON(refcount_read(&sh->count) != 1);
+	BUG_ON(atomic_inc_return(&sh->count) != 1);
 	return sh;
 }
 
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 8c6d39e9db41..2796fb045885 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -4,7 +4,7 @@
 
 #include <linux/raid/xor.h>
 #include <linux/dmaengine.h>
-#include <linux/refcount.h>
+
 /*
  *
  * Each stripe contains one buffer per device.  Each buffer can be in
@@ -208,7 +208,7 @@ struct stripe_head {
 	short			ddf_layout;/* use DDF ordering to calculate Q */
 	short			hash_lock_index;
 	unsigned long		state;		/* state flags */
-	refcount_t		count;	      /* nr of active thread/requests */
+	atomic_t		count;	      /* nr of active thread/requests */
 	int			bm_seq;	/* sequence number for bitmap flushes */
 	int			disks;		/* disks in stripe */
 	int			overwrite_disks; /* total overwrite disks in stripe,
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b1f2d663ab6e..6fc77d4dbdcd 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -608,22 +608,11 @@ do {									\
 			  "IRQs not disabled as expected\n");		\
 	} while (0)
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-# define lockdep_assert_in_softirq() do { } while (0)
-#else
-# define lockdep_assert_in_softirq()	do {				\
-		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
-			  !current->softirq_context,			\
-			  "Not in softirq context as expected\n");	\
-	} while (0)
-#endif
-
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
-# define lockdep_assert_in_softirq() do { } while (0)
 #endif
 
 #ifdef CONFIG_LOCKDEP
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 97eb2c0d4502..58f9909d6659 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -461,6 +461,7 @@ static inline unsigned read_seqbegin(seqlock_t *sl)
 		spin_unlock_wait(&sl->lock);
 		goto repeat;
 	}
+	smp_rmb();
 	return ret;
 }
 #endif
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 15068e3ef74e..f6f72c583e83 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -419,6 +419,11 @@ extern int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
 #define atomic_dec_and_lock(atomic, lock) \
 		__cond_lock(lock, _atomic_dec_and_lock(atomic, lock))
 
+extern int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
+					unsigned long *flags);
+#define atomic_dec_and_lock_irqsave(atomic, lock, flags) \
+		__cond_lock(lock, _atomic_dec_and_lock_irqsave(atomic, lock, &(flags)))
+
 int alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 			   size_t max_size, unsigned int cpu_mult,
 			   gfp_t gfp);
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index bc01e06bc716..0be866c91f62 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -435,7 +435,9 @@ TRACE_EVENT(sched_pi_setprio,
 		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
 		__entry->pid		= tsk->pid;
 		__entry->oldprio	= tsk->prio;
-		__entry->newprio	= pi_task ? pi_task->prio : tsk->prio;
+		__entry->newprio	= pi_task ?
+				min(tsk->normal_prio, pi_task->prio) :
+				tsk->normal_prio;
 		/* XXX SCHED_DEADLINE bits missing */
 	),
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 44e17d70154f..b89605fe0e88 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
+#include <linux/swait.h>
 #include <linux/ftrace.h>
 #include <trace/events/power.h>
 #include <linux/compiler.h>
@@ -57,10 +58,10 @@ EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
 
 static const struct platform_suspend_ops *suspend_ops;
 static const struct platform_s2idle_ops *s2idle_ops;
-static DECLARE_WAIT_QUEUE_HEAD(s2idle_wait_head);
+static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
 
 enum s2idle_states __read_mostly s2idle_state;
-static DEFINE_SPINLOCK(s2idle_lock);
+static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
@@ -78,12 +79,12 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
-	spin_lock_irq(&s2idle_lock);
+	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
 
 	s2idle_state = S2IDLE_STATE_ENTER;
-	spin_unlock_irq(&s2idle_lock);
+	raw_spin_unlock_irq(&s2idle_lock);
 
 	get_online_cpus();
 	cpuidle_resume();
@@ -91,17 +92,17 @@ static void s2idle_enter(void)
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
 	/* Make the current CPU wait so it can enter the idle loop too. */
-	wait_event(s2idle_wait_head,
-		   s2idle_state == S2IDLE_STATE_WAKE);
+	swait_event(s2idle_wait_head,
+		    s2idle_state == S2IDLE_STATE_WAKE);
 
 	cpuidle_pause();
 	put_online_cpus();
 
-	spin_lock_irq(&s2idle_lock);
+	raw_spin_lock_irq(&s2idle_lock);
 
  out:
 	s2idle_state = S2IDLE_STATE_NONE;
-	spin_unlock_irq(&s2idle_lock);
+	raw_spin_unlock_irq(&s2idle_lock);
 
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
 }
@@ -156,12 +157,12 @@ void s2idle_wake(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&s2idle_lock, flags);
+	raw_spin_lock_irqsave(&s2idle_lock, flags);
 	if (s2idle_state > S2IDLE_STATE_NONE) {
 		s2idle_state = S2IDLE_STATE_WAKE;
-		wake_up(&s2idle_wait_head);
+		swake_up(&s2idle_wait_head);
 	}
-	spin_unlock_irqrestore(&s2idle_lock, flags);
+	raw_spin_unlock_irqrestore(&s2idle_lock, flags);
 }
 EXPORT_SYMBOL_GPL(s2idle_wake);
 
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 7f5a26c3a8ee..7a87a4488a5e 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -492,6 +492,7 @@ void tick_freeze(void)
 	if (tick_freeze_depth == num_online_cpus()) {
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), true);
+		system_state = SYSTEM_SUSPEND;
 		timekeeping_suspend();
 	} else {
 		tick_suspend_local();
@@ -515,6 +516,7 @@ void tick_unfreeze(void)
 
 	if (tick_freeze_depth == num_online_cpus()) {
 		timekeeping_resume();
+		system_state = SYSTEM_RUNNING;
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), false);
 	} else {
diff --git a/lib/dec_and_lock.c b/lib/dec_and_lock.c
index 347fa7ac2e8a..9555b68bb774 100644
--- a/lib/dec_and_lock.c
+++ b/lib/dec_and_lock.c
@@ -33,3 +33,19 @@ int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 }
 
 EXPORT_SYMBOL(_atomic_dec_and_lock);
+
+int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
+				 unsigned long *flags)
+{
+	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
+	if (atomic_add_unless(atomic, -1, 1))
+		return 0;
+
+	/* Otherwise do it the slow way */
+	spin_lock_irqsave(lock, *flags);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	spin_unlock_irqrestore(lock, *flags);
+	return 0;
+}
+EXPORT_SYMBOL(_atomic_dec_and_lock_irqsave);
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e..0efe7ba1930e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
diff --git a/net/core/dev.c b/net/core/dev.c
index 2f47c4304cec..2677398054e9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4736,9 +4736,6 @@ static int netif_receive_skb_internal(struct sk_buff *skb)
  */
 int netif_receive_skb(struct sk_buff *skb)
 {
-	lockdep_assert_irqs_enabled();
-	lockdep_assert_in_softirq();
-
 	trace_netif_receive_skb_entry(skb);
 
 	return netif_receive_skb_internal(skb);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 691de29f3e0c..56fe16b07538 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4245,6 +4245,8 @@ void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
+	WARN_ON_ONCE(softirq_count() == 0);
+
 	if (WARN_ON(status->band >= NUM_NL80211_BANDS))
 		goto drop;
 
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 66916c270efc..4dcf6e18563a 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -258,6 +258,8 @@ void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	u16 crc;
 
+	WARN_ON_ONCE(softirq_count() == 0);
+
 	if (local->suspended)
 		goto drop;
 
