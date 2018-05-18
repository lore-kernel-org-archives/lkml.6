Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752993AbeERJTt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:19:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50634 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbeERJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:19:39 -0400
Date: Fri, 18 May 2018 11:19:36 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.16.8-rt3
Message-ID: <20180518091936.j5ep2tqvhba5lta7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.16.8-rt3 patch set. 

Changes since v4.16.8-rt2:

  - Drop two MCE related patches. They are no longer required since the
    timer wheel rework.

  - Replace the atomic_dec_lock_irqsave() patches with their
    refcount_dec_and_lock_irqsave() counterparts.

  - Make the sched/CFS timer fire in hard-irq context. The lock taken in
    the timer callback needs to be taken with disabled interrupts. Patch
    by Mike Galbraith.

  - Added a local lock to squashfs' multi CPU decompressor in order to
    avoid long preempt-disable sections. Reported by Alexander Stein,
    patch by Julia Cartwright.

  - A handful patches to the Inter-event patches which were collected by
    Steven Rostedt.

  - Add a locallock during saving/restoring of SIMD registers on ARM64.
    On RT we are preemptible there so extra protection is required.

  - Let softirq_count() return BH disable count. This should make the
    workarounds, we currently have in queue, unnecessary. 

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.16.8-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/incr/patch-4.16.8-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.16.8-rt3

The RT patch against v4.16.8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patch-4.16.8-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patches-4.16.8-rt3.tar.xz

Sebastian

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e7226c4c7493..3a5cd1908874 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -38,6 +38,7 @@
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/locallock.h>
 
 #include <asm/fpsimd.h>
 #include <asm/cputype.h>
@@ -235,7 +236,7 @@ static void sve_user_enable(void)
  *    whether TIF_SVE is clear or set, since these are not vector length
  *    dependent.
  */
-
+static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
 /*
  * Update current's FPSIMD/SVE registers from thread_struct.
  *
@@ -594,6 +595,7 @@ int sve_set_vector_length(struct task_struct *task,
 	 * non-SVE thread.
 	 */
 	if (task == current) {
+		local_lock(fpsimd_lock);
 		local_bh_disable();
 
 		task_fpsimd_save();
@@ -604,8 +606,10 @@ int sve_set_vector_length(struct task_struct *task,
 	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
 		sve_to_fpsimd(task);
 
-	if (task == current)
+	if (task == current) {
+		local_unlock(fpsimd_lock);
 		local_bh_enable();
+	}
 
 	/*
 	 * Force reallocation of task SVE state to the correct size
@@ -838,6 +842,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	sve_alloc(current);
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 
 	task_fpsimd_save();
 	fpsimd_to_sve(current);
@@ -849,6 +854,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
+	local_unlock(fpsimd_lock);
 	local_bh_enable();
 }
 
@@ -926,6 +932,7 @@ void fpsimd_flush_thread(void)
 		return;
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 	fpsimd_flush_task_state(current);
@@ -967,6 +974,7 @@ void fpsimd_flush_thread(void)
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
+	local_unlock(fpsimd_lock);
 	local_bh_enable();
 }
 
@@ -980,7 +988,9 @@ void fpsimd_preserve_current_state(void)
 		return;
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 	task_fpsimd_save();
+	local_unlock(fpsimd_lock);
 	local_bh_enable();
 }
 
@@ -1022,12 +1032,14 @@ void fpsimd_restore_current_state(void)
 		return;
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		task_fpsimd_load();
 		fpsimd_bind_to_cpu();
 	}
 
+	local_unlock(fpsimd_lock);
 	local_bh_enable();
 }
 
@@ -1042,6 +1054,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 		return;
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 
 	current->thread.fpsimd_state.user_fpsimd = *state;
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
@@ -1052,6 +1065,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_bind_to_cpu();
 
+	local_unlock(fpsimd_lock);
 	local_bh_enable();
 }
 
@@ -1116,6 +1130,7 @@ void kernel_neon_begin(void)
 	BUG_ON(!may_use_simd());
 
 	local_bh_disable();
+	local_lock(fpsimd_lock);
 
 	__this_cpu_write(kernel_neon_busy, true);
 
@@ -1128,6 +1143,7 @@ void kernel_neon_begin(void)
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	fpsimd_flush_cpu_state();
 
+	local_unlock(fpsimd_lock);
 	preempt_disable();
 
 	local_bh_enable();
diff --git a/arch/x86/kernel/cpu/mcheck/dev-mcelog.c b/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
index 4812ee9c7896..97685a0c3175 100644
--- a/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mcheck/dev-mcelog.c
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/poll.h>
-#include <linux/swork.h>
 
 #include "mce-internal.h"
 
@@ -87,43 +86,13 @@ static void mce_do_trigger(struct work_struct *work)
 
 static DECLARE_WORK(mce_trigger_work, mce_do_trigger);
 
-static void __mce_work_trigger(struct swork_event *event)
+
+void mce_work_trigger(void)
 {
 	if (mce_helper[0])
 		schedule_work(&mce_trigger_work);
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-static bool notify_work_ready __read_mostly;
-static struct swork_event notify_work;
-
-static int mce_notify_work_init(void)
-{
-	int err;
-
-	err = swork_get();
-	if (err)
-		return err;
-
-	INIT_SWORK(&notify_work, __mce_work_trigger);
-	notify_work_ready = true;
-	return 0;
-}
-
-void mce_work_trigger(void)
-{
-	if (notify_work_ready)
-		swork_queue(&notify_work);
-}
-
-#else
-void mce_work_trigger(void)
-{
-	__mce_work_trigger(NULL);
-}
-static inline int mce_notify_work_init(void) { return 0; }
-#endif
-
 static ssize_t
 show_trigger(struct device *s, struct device_attribute *attr, char *buf)
 {
@@ -387,7 +356,7 @@ static __init int dev_mcelog_init_device(void)
 
 		return err;
 	}
-	mce_notify_work_init();
+
 	mce_register_decode_chain(&dev_mcelog_nb);
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 53a8916d41b9..466f47301334 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -41,7 +41,6 @@
 #include <linux/debugfs.h>
 #include <linux/irq_work.h>
 #include <linux/export.h>
-#include <linux/jiffies.h>
 #include <linux/jump_label.h>
 
 #include <asm/intel-family.h>
@@ -1364,7 +1363,7 @@ int memory_failure(unsigned long pfn, int flags)
 static unsigned long check_interval = INITIAL_CHECK_INTERVAL;
 
 static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
-static DEFINE_PER_CPU(struct hrtimer, mce_timer);
+static DEFINE_PER_CPU(struct timer_list, mce_timer);
 
 static unsigned long mce_adjust_timer_default(unsigned long interval)
 {
@@ -1373,18 +1372,26 @@ static unsigned long mce_adjust_timer_default(unsigned long interval)
 
 static unsigned long (*mce_adjust_timer)(unsigned long interval) = mce_adjust_timer_default;
 
-static void __start_timer(struct hrtimer *t, unsigned long iv)
+static void __start_timer(struct timer_list *t, unsigned long interval)
 {
-	if (!iv)
-		return;
-	hrtimer_start_range_ns(t, ns_to_ktime(jiffies_to_usecs(iv) * 1000ULL),
-			       0, HRTIMER_MODE_REL_PINNED);
+	unsigned long when = jiffies + interval;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	if (!timer_pending(t) || time_before(when, t->expires))
+		mod_timer(t, round_jiffies(when));
+
+	local_irq_restore(flags);
 }
 
-static enum hrtimer_restart mce_timer_fn(struct hrtimer *timer)
+static void mce_timer_fn(struct timer_list *t)
 {
+	struct timer_list *cpu_t = this_cpu_ptr(&mce_timer);
 	unsigned long iv;
 
+	WARN_ON(cpu_t != t);
+
 	iv = __this_cpu_read(mce_next_interval);
 
 	if (mce_available(this_cpu_ptr(&cpu_info))) {
@@ -1407,11 +1414,7 @@ static enum hrtimer_restart mce_timer_fn(struct hrtimer *timer)
 
 done:
 	__this_cpu_write(mce_next_interval, iv);
-	if (!iv)
-		return HRTIMER_NORESTART;
-
-	hrtimer_forward_now(timer, ns_to_ktime(jiffies_to_nsecs(iv)));
-	return HRTIMER_RESTART;
+	__start_timer(t, iv);
 }
 
 /*
@@ -1419,7 +1422,7 @@ static enum hrtimer_restart mce_timer_fn(struct hrtimer *timer)
  */
 void mce_timer_kick(unsigned long interval)
 {
-	struct hrtimer *t = this_cpu_ptr(&mce_timer);
+	struct timer_list *t = this_cpu_ptr(&mce_timer);
 	unsigned long iv = __this_cpu_read(mce_next_interval);
 
 	__start_timer(t, interval);
@@ -1434,7 +1437,7 @@ static void mce_timer_delete_all(void)
 	int cpu;
 
 	for_each_online_cpu(cpu)
-		hrtimer_cancel(&per_cpu(mce_timer, cpu));
+		del_timer_sync(&per_cpu(mce_timer, cpu));
 }
 
 /*
@@ -1763,7 +1766,7 @@ static void __mcheck_cpu_clear_vendor(struct cpuinfo_x86 *c)
 	}
 }
 
-static void mce_start_timer(struct hrtimer *t)
+static void mce_start_timer(struct timer_list *t)
 {
 	unsigned long iv = check_interval * HZ;
 
@@ -1776,19 +1779,16 @@ static void mce_start_timer(struct hrtimer *t)
 
 static void __mcheck_cpu_setup_timer(void)
 {
-	struct hrtimer *t = this_cpu_ptr(&mce_timer);
+	struct timer_list *t = this_cpu_ptr(&mce_timer);
 
-	hrtimer_init(t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	t->function = mce_timer_fn;
+	timer_setup(t, mce_timer_fn, TIMER_PINNED);
 }
 
 static void __mcheck_cpu_init_timer(void)
 {
-	struct hrtimer *t = this_cpu_ptr(&mce_timer);
-
-	hrtimer_init(t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	t->function = mce_timer_fn;
+	struct timer_list *t = this_cpu_ptr(&mce_timer);
 
+	timer_setup(t, mce_timer_fn, TIMER_PINNED);
 	mce_start_timer(t);
 }
 
@@ -2307,7 +2307,7 @@ static int mce_cpu_dead(unsigned int cpu)
 
 static int mce_cpu_online(unsigned int cpu)
 {
-	struct hrtimer *t = this_cpu_ptr(&mce_timer);
+	struct timer_list *t = this_cpu_ptr(&mce_timer);
 	int ret;
 
 	mce_device_create(cpu);
@@ -2324,10 +2324,10 @@ static int mce_cpu_online(unsigned int cpu)
 
 static int mce_cpu_pre_down(unsigned int cpu)
 {
-	struct hrtimer *t = this_cpu_ptr(&mce_timer);
+	struct timer_list *t = this_cpu_ptr(&mce_timer);
 
 	mce_disable_cpu();
-	hrtimer_cancel(t);
+	del_timer_sync(t);
 	mce_threshold_remove_device(cpu);
 	mce_device_remove(cpu);
 	return 0;
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 3c65f52b68f5..532fdf56c117 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1049,7 +1049,7 @@ int r5l_write_stripe(struct r5l_log *log, struct stripe_head *sh)
 	 * don't delay.
 	 */
 	clear_bit(STRIPE_DELAYED, &sh->state);
-	atomic_inc(&sh->count);
+	refcount_inc(&sh->count);
 
 	mutex_lock(&log->io_mutex);
 	/* meta + data */
@@ -1388,7 +1388,7 @@ static void r5c_flush_stripe(struct r5conf *conf, struct stripe_head *sh)
 	lockdep_assert_held(&conf->device_lock);
 
 	list_del_init(&sh->lru);
-	atomic_inc(&sh->count);
+	refcount_inc(&sh->count);
 
 	set_bit(STRIPE_HANDLE, &sh->state);
 	atomic_inc(&conf->active_stripes);
@@ -1491,7 +1491,7 @@ static void r5c_do_reclaim(struct r5conf *conf)
 			 */
 			if (!list_empty(&sh->lru) &&
 			    !test_bit(STRIPE_HANDLE, &sh->state) &&
-			    atomic_read(&sh->count) == 0) {
+			    refcount_read(&sh->count) == 0) {
 				r5c_flush_stripe(conf, sh);
 				if (count++ >= R5C_RECLAIM_STRIPE_GROUP)
 					break;
@@ -2912,7 +2912,7 @@ int r5c_cache_data(struct r5l_log *log, struct stripe_head *sh)
 	 * don't delay.
 	 */
 	clear_bit(STRIPE_DELAYED, &sh->state);
-	atomic_inc(&sh->count);
+	refcount_inc(&sh->count);
 
 	mutex_lock(&log->io_mutex);
 	/* meta + data */
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 42890a08375b..87840cfe7a80 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -388,7 +388,7 @@ int ppl_write_stripe(struct r5conf *conf, struct stripe_head *sh)
 
 	set_bit(STRIPE_LOG_TRAPPED, &sh->state);
 	clear_bit(STRIPE_DELAYED, &sh->state);
-	atomic_inc(&sh->count);
+	refcount_inc(&sh->count);
 
 	if (ppl_log_stripe(log, sh)) {
 		spin_lock_irq(&ppl_conf->no_mem_stripes_lock);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index d8de7476d26a..eb967afd749a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -306,7 +306,7 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
 static void __release_stripe(struct r5conf *conf, struct stripe_head *sh,
 			     struct list_head *temp_inactive_list)
 {
-	if (atomic_dec_and_test(&sh->count))
+	if (refcount_dec_and_test(&sh->count))
 		do_release_stripe(conf, sh, temp_inactive_list);
 }
 
@@ -398,7 +398,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 
 	/* Avoid release_list until the last reference.
 	 */
-	if (atomic_add_unless(&sh->count, -1, 1))
+	if (refcount_dec_not_one(&sh->count))
 		return;
 
 	if (unlikely(!conf->mddev->thread) ||
@@ -410,7 +410,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 	return;
 slow_path:
 	/* we are ok here if STRIPE_ON_RELEASE_LIST is set or not */
-	if (atomic_dec_and_lock_irqsave(&sh->count, &conf->device_lock, flags)) {
+	if (refcount_dec_and_lock_irqsave(&sh->count, &conf->device_lock, &flags)) {
 		INIT_LIST_HEAD(&list);
 		hash = sh->hash_lock_index;
 		do_release_stripe(conf, sh, &list);
@@ -499,7 +499,7 @@ static void init_stripe(struct stripe_head *sh, sector_t sector, int previous)
 	struct r5conf *conf = sh->raid_conf;
 	int i, seq;
 
-	BUG_ON(atomic_read(&sh->count) != 0);
+	BUG_ON(refcount_read(&sh->count) != 0);
 	BUG_ON(test_bit(STRIPE_HANDLE, &sh->state));
 	BUG_ON(stripe_operations_active(sh));
 	BUG_ON(sh->batch_head);
@@ -676,11 +676,11 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 					  &conf->cache_state);
 			} else {
 				init_stripe(sh, sector, previous);
-				atomic_inc(&sh->count);
+				refcount_inc(&sh->count);
 			}
-		} else if (!atomic_inc_not_zero(&sh->count)) {
+		} else if (!refcount_inc_not_zero(&sh->count)) {
 			spin_lock(&conf->device_lock);
-			if (!atomic_read(&sh->count)) {
+			if (!refcount_read(&sh->count)) {
 				if (!test_bit(STRIPE_HANDLE, &sh->state))
 					atomic_inc(&conf->active_stripes);
 				BUG_ON(list_empty(&sh->lru) &&
@@ -696,7 +696,7 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 					sh->group = NULL;
 				}
 			}
-			atomic_inc(&sh->count);
+			refcount_inc(&sh->count);
 			spin_unlock(&conf->device_lock);
 		}
 	} while (sh == NULL);
@@ -758,9 +758,9 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 	hash = stripe_hash_locks_hash(head_sector);
 	spin_lock_irq(conf->hash_locks + hash);
 	head = __find_stripe(conf, head_sector, conf->generation);
-	if (head && !atomic_inc_not_zero(&head->count)) {
+	if (head && !refcount_inc_not_zero(&head->count)) {
 		spin_lock(&conf->device_lock);
-		if (!atomic_read(&head->count)) {
+		if (!refcount_read(&head->count)) {
 			if (!test_bit(STRIPE_HANDLE, &head->state))
 				atomic_inc(&conf->active_stripes);
 			BUG_ON(list_empty(&head->lru) &&
@@ -776,7 +776,7 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 				head->group = NULL;
 			}
 		}
-		atomic_inc(&head->count);
+		refcount_inc(&head->count);
 		spin_unlock(&conf->device_lock);
 	}
 	spin_unlock_irq(conf->hash_locks + hash);
@@ -845,7 +845,7 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 		sh->batch_head->bm_seq = seq;
 	}
 
-	atomic_inc(&sh->count);
+	refcount_inc(&sh->count);
 unlock_out:
 	unlock_two_stripes(head, sh);
 out:
@@ -1108,9 +1108,9 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			pr_debug("%s: for %llu schedule op %d on disc %d\n",
 				__func__, (unsigned long long)sh->sector,
 				bi->bi_opf, i);
-			atomic_inc(&sh->count);
+			refcount_inc(&sh->count);
 			if (sh != head_sh)
-				atomic_inc(&head_sh->count);
+				refcount_inc(&head_sh->count);
 			if (use_new_offset(conf, sh))
 				bi->bi_iter.bi_sector = (sh->sector
 						 + rdev->new_data_offset);
@@ -1172,9 +1172,9 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 				 "replacement disc %d\n",
 				__func__, (unsigned long long)sh->sector,
 				rbi->bi_opf, i);
-			atomic_inc(&sh->count);
+			refcount_inc(&sh->count);
 			if (sh != head_sh)
-				atomic_inc(&head_sh->count);
+				refcount_inc(&head_sh->count);
 			if (use_new_offset(conf, sh))
 				rbi->bi_iter.bi_sector = (sh->sector
 						  + rrdev->new_data_offset);
@@ -1352,7 +1352,7 @@ static void ops_run_biofill(struct stripe_head *sh)
 		}
 	}
 
-	atomic_inc(&sh->count);
+	refcount_inc(&sh->count);
 	init_async_submit(&submit, ASYNC_TX_ACK, tx, ops_complete_biofill, sh, NULL);
 	async_trigger_callback(&submit);
 }
@@ -1430,7 +1430,7 @@ ops_run_compute5(struct stripe_head *sh, struct raid5_percpu *percpu)
 		if (i != target)
 			xor_srcs[count++] = sh->dev[i].page;
 
-	atomic_inc(&sh->count);
+	refcount_inc(&sh->count);
 
 	init_async_submit(&submit, ASYNC_TX_FENCE|ASYNC_TX_XOR_ZERO_DST, NULL,
 			  ops_complete_compute, sh, to_addr_conv(sh, percpu, 0));
@@ -1519,7 +1519,7 @@ ops_run_compute6_1(struct stripe_head *sh, struct raid5_percpu *percpu)
 	BUG_ON(!test_bit(R5_Wantcompute, &tgt->flags));
 	dest = tgt->page;
 
-	atomic_inc(&sh->count);
+	refcount_inc(&sh->count);
 
 	if (target == qd_idx) {
 		count = set_syndrome_sources(blocks, sh, SYNDROME_SRC_ALL);
@@ -1594,7 +1594,7 @@ ops_run_compute6_2(struct stripe_head *sh, struct raid5_percpu *percpu)
 	pr_debug("%s: stripe: %llu faila: %d failb: %d\n",
 		 __func__, (unsigned long long)sh->sector, faila, failb);
 
-	atomic_inc(&sh->count);
+	refcount_inc(&sh->count);
 
 	if (failb == syndrome_disks+1) {
 		/* Q disk is one of the missing disks */
@@ -1865,7 +1865,7 @@ ops_run_reconstruct5(struct stripe_head *sh, struct raid5_percpu *percpu,
 			break;
 	}
 	if (i >= sh->disks) {
-		atomic_inc(&sh->count);
+		refcount_inc(&sh->count);
 		set_bit(R5_Discard, &sh->dev[pd_idx].flags);
 		ops_complete_reconstruct(sh);
 		return;
@@ -1906,7 +1906,7 @@ ops_run_reconstruct5(struct stripe_head *sh, struct raid5_percpu *percpu,
 		flags = ASYNC_TX_ACK |
 			(prexor ? ASYNC_TX_XOR_DROP_DST : ASYNC_TX_XOR_ZERO_DST);
 
-		atomic_inc(&head_sh->count);
+		refcount_inc(&head_sh->count);
 		init_async_submit(&submit, flags, tx, ops_complete_reconstruct, head_sh,
 				  to_addr_conv(sh, percpu, j));
 	} else {
@@ -1948,7 +1948,7 @@ ops_run_reconstruct6(struct stripe_head *sh, struct raid5_percpu *percpu,
 			break;
 	}
 	if (i >= sh->disks) {
-		atomic_inc(&sh->count);
+		refcount_inc(&sh->count);
 		set_bit(R5_Discard, &sh->dev[sh->pd_idx].flags);
 		set_bit(R5_Discard, &sh->dev[sh->qd_idx].flags);
 		ops_complete_reconstruct(sh);
@@ -1972,7 +1972,7 @@ ops_run_reconstruct6(struct stripe_head *sh, struct raid5_percpu *percpu,
 				 struct stripe_head, batch_list) == head_sh;
 
 	if (last_stripe) {
-		atomic_inc(&head_sh->count);
+		refcount_inc(&head_sh->count);
 		init_async_submit(&submit, txflags, tx, ops_complete_reconstruct,
 				  head_sh, to_addr_conv(sh, percpu, j));
 	} else
@@ -2029,7 +2029,7 @@ static void ops_run_check_p(struct stripe_head *sh, struct raid5_percpu *percpu)
 	tx = async_xor_val(xor_dest, xor_srcs, 0, count, STRIPE_SIZE,
 			   &sh->ops.zero_sum_result, &submit);
 
-	atomic_inc(&sh->count);
+	refcount_inc(&sh->count);
 	init_async_submit(&submit, ASYNC_TX_ACK, tx, ops_complete_check, sh, NULL);
 	tx = async_trigger_callback(&submit);
 }
@@ -2048,7 +2048,7 @@ static void ops_run_check_pq(struct stripe_head *sh, struct raid5_percpu *percpu
 	if (!checkp)
 		srcs[count] = NULL;
 
-	atomic_inc(&sh->count);
+	refcount_inc(&sh->count);
 	init_async_submit(&submit, ASYNC_TX_ACK, NULL, ops_complete_check,
 			  sh, to_addr_conv(sh, percpu, 0));
 	async_syndrome_val(srcs, 0, count+2, STRIPE_SIZE,
@@ -2150,7 +2150,7 @@ static struct stripe_head *alloc_stripe(struct kmem_cache *sc, gfp_t gfp,
 		INIT_LIST_HEAD(&sh->lru);
 		INIT_LIST_HEAD(&sh->r5c);
 		INIT_LIST_HEAD(&sh->log_list);
-		atomic_set(&sh->count, 1);
+		refcount_set(&sh->count, 1);
 		sh->raid_conf = conf;
 		sh->log_start = MaxSector;
 		for (i = 0; i < disks; i++) {
@@ -2451,7 +2451,7 @@ static int drop_one_stripe(struct r5conf *conf)
 	spin_unlock_irq(conf->hash_locks + hash);
 	if (!sh)
 		return 0;
-	BUG_ON(atomic_read(&sh->count));
+	BUG_ON(refcount_read(&sh->count));
 	shrink_buffers(sh);
 	free_stripe(conf->slab_cache, sh);
 	atomic_dec(&conf->active_stripes);
@@ -2483,7 +2483,7 @@ static void raid5_end_read_request(struct bio * bi)
 			break;
 
 	pr_debug("end_read_request %llu/%d, count: %d, error %d.\n",
-		(unsigned long long)sh->sector, i, atomic_read(&sh->count),
+		(unsigned long long)sh->sector, i, refcount_read(&sh->count),
 		bi->bi_status);
 	if (i == disks) {
 		bio_reset(bi);
@@ -2620,7 +2620,7 @@ static void raid5_end_write_request(struct bio *bi)
 		}
 	}
 	pr_debug("end_write_request %llu/%d, count %d, error: %d.\n",
-		(unsigned long long)sh->sector, i, atomic_read(&sh->count),
+		(unsigned long long)sh->sector, i, refcount_read(&sh->count),
 		bi->bi_status);
 	if (i == disks) {
 		bio_reset(bi);
@@ -4687,7 +4687,7 @@ static void handle_stripe(struct stripe_head *sh)
 	pr_debug("handling stripe %llu, state=%#lx cnt=%d, "
 		"pd_idx=%d, qd_idx=%d\n, check:%d, reconstruct:%d\n",
 	       (unsigned long long)sh->sector, sh->state,
-	       atomic_read(&sh->count), sh->pd_idx, sh->qd_idx,
+	       refcount_read(&sh->count), sh->pd_idx, sh->qd_idx,
 	       sh->check_state, sh->reconstruct_state);
 
 	analyse_stripe(sh, &s);
@@ -5062,7 +5062,7 @@ static void activate_bit_delay(struct r5conf *conf,
 		struct stripe_head *sh = list_entry(head.next, struct stripe_head, lru);
 		int hash;
 		list_del_init(&sh->lru);
-		atomic_inc(&sh->count);
+		refcount_inc(&sh->count);
 		hash = sh->hash_lock_index;
 		__release_stripe(conf, sh, &temp_inactive_list[hash]);
 	}
@@ -5387,7 +5387,8 @@ static struct stripe_head *__get_priority_stripe(struct r5conf *conf, int group)
 		sh->group = NULL;
 	}
 	list_del_init(&sh->lru);
-	BUG_ON(atomic_inc_return(&sh->count) != 1);
+	refcount_inc(&sh->count);
+	BUG_ON(refcount_read(&sh->count) != 1);
 	return sh;
 }
 
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 2796fb045885..8c6d39e9db41 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -4,7 +4,7 @@
 
 #include <linux/raid/xor.h>
 #include <linux/dmaengine.h>
-
+#include <linux/refcount.h>
 /*
  *
  * Each stripe contains one buffer per device.  Each buffer can be in
@@ -208,7 +208,7 @@ struct stripe_head {
 	short			ddf_layout;/* use DDF ordering to calculate Q */
 	short			hash_lock_index;
 	unsigned long		state;		/* state flags */
-	atomic_t		count;	      /* nr of active thread/requests */
+	refcount_t		count;	      /* nr of active thread/requests */
 	int			bm_seq;	/* sequence number for bitmap flushes */
 	int			disks;		/* disks in stripe */
 	int			overwrite_disks; /* total overwrite disks in stripe,
diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index 23a9c28ad8ea..6a73c4fa88e7 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 #include <linux/buffer_head.h>
+#include <linux/locallock.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -25,6 +26,8 @@ struct squashfs_stream {
 	void		*stream;
 };
 
+static DEFINE_LOCAL_IRQ_LOCK(stream_lock);
+
 void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
@@ -79,10 +82,15 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
 {
 	struct squashfs_stream __percpu *percpu =
 			(struct squashfs_stream __percpu *) msblk->stream;
-	struct squashfs_stream *stream = get_cpu_ptr(percpu);
-	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
-		offset, length, output);
-	put_cpu_ptr(stream);
+	struct squashfs_stream *stream;
+	int res;
+
+	stream = get_locked_ptr(stream_lock, percpu);
+
+	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
+			offset, length, output);
+
+	put_locked_ptr(stream_lock, stream);
 
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 0bd432a4d7bd..81c75934ca5b 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -12,6 +12,7 @@
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/kref.h>
+#include <linux/refcount.h>
 
 struct page;
 struct device;
@@ -76,7 +77,7 @@ enum wb_reason {
  */
 struct bdi_writeback_congested {
 	unsigned long state;		/* WB_[a]sync_congested flags */
-	atomic_t refcnt;		/* nr of attached wb's and blkg */
+	refcount_t refcnt;		/* nr of attached wb's and blkg */
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct backing_dev_info *__bdi;	/* the associated bdi, set to NULL
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 82e8b73117d1..82aeba375154 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -403,13 +403,13 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
 static inline struct bdi_writeback_congested *
 wb_congested_get_create(struct backing_dev_info *bdi, int blkcg_id, gfp_t gfp)
 {
-	atomic_inc(&bdi->wb_congested->refcnt);
+	refcount_inc(&bdi->wb_congested->refcnt);
 	return bdi->wb_congested;
 }
 
 static inline void wb_congested_put(struct bdi_writeback_congested *congested)
 {
-	if (atomic_dec_and_test(&congested->refcnt))
+	if (refcount_dec_and_test(&congested->refcnt))
 		kfree(congested);
 }
 
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index d658c2552601..921eab83cd34 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -222,6 +222,14 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 #define put_locked_var(lvar, var)	local_unlock(lvar);
 
+#define get_locked_ptr(lvar, var)					\
+	({								\
+		local_lock(lvar);					\
+		this_cpu_ptr(var);					\
+	})
+
+#define put_locked_ptr(lvar, var)	local_unlock(lvar);
+
 #define local_lock_cpu(lvar)						\
 	({								\
 		local_lock(lvar);					\
@@ -262,6 +270,8 @@ static inline void local_irq_lock_init(int lvar) { }
 
 #define get_locked_var(lvar, var)		get_cpu_var(var)
 #define put_locked_var(lvar, var)		put_cpu_var(var)
+#define get_locked_ptr(lvar, var)		get_cpu_ptr(var)
+#define put_locked_ptr(lvar, var)		put_cpu_ptr(var)
 
 #define local_lock_cpu(lvar)			get_cpu()
 #define local_unlock_cpu(lvar)			put_cpu()
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 0591df500e9d..043e431a7e8e 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -91,7 +91,7 @@
 # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
 # define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
 #else
-# define softirq_count()	(0UL)
+# define softirq_count()	((unsigned long)current->softirq_nestcnt)
 extern int in_serving_softirq(void);
 #endif
 
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 4193c41e383a..a685da2c4522 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -98,5 +98,7 @@ extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
 extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock);
 extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock);
-
+extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
+						       spinlock_t *lock,
+						       unsigned long *flags);
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 96fe289c4c6e..39ad98c09c58 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -4,6 +4,7 @@
 
 #include <linux/uidgid.h>
 #include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <linux/ratelimit.h>
 
 struct key;
@@ -12,7 +13,7 @@ struct key;
  * Some day this will be a full-fledged user tracking system..
  */
 struct user_struct {
-	atomic_t __count;	/* reference count */
+	refcount_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t sigpending;	/* How many pending signals does this user have? */
 #ifdef CONFIG_FANOTIFY
@@ -59,7 +60,7 @@ extern struct user_struct root_user;
 extern struct user_struct * alloc_uid(kuid_t);
 static inline struct user_struct *get_uid(struct user_struct *u)
 {
-	atomic_inc(&u->__count);
+	refcount_inc(&u->__count);
 	return u;
 }
 extern void free_uid(struct user_struct *);
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index f6f72c583e83..15068e3ef74e 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -419,11 +419,6 @@ extern int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
 #define atomic_dec_and_lock(atomic, lock) \
 		__cond_lock(lock, _atomic_dec_and_lock(atomic, lock))
 
-extern int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
-					unsigned long *flags);
-#define atomic_dec_and_lock_irqsave(atomic, lock, flags) \
-		__cond_lock(lock, _atomic_dec_and_lock_irqsave(atomic, lock, &(flags)))
-
 int alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 			   size_t max_size, unsigned int cpu_mult,
 			   gfp_t gfp);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 960ad0ce77d7..420624c49f38 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5007,9 +5007,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	cfs_b->period_timer.function = sched_cfs_period_timer;
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 }
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b87ea7421f3d..c555fe1164af 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1686,8 +1686,6 @@ static const char *hist_field_name(struct hist_field *field,
 	else if (field->flags & HIST_FIELD_FL_LOG2 ||
 		 field->flags & HIST_FIELD_FL_ALIAS)
 		field_name = hist_field_name(field->operands[0], ++level);
-	else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
-		field_name = "common_timestamp";
 	else if (field->flags & HIST_FIELD_FL_CPU)
 		field_name = "cpu";
 	else if (field->flags & HIST_FIELD_FL_EXPR ||
@@ -1703,7 +1701,8 @@ static const char *hist_field_name(struct hist_field *field,
 			field_name = full_name;
 		} else
 			field_name = field->name;
-	}
+	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
+		field_name = "common_timestamp";
 
 	if (field_name == NULL)
 		field_name = "";
@@ -2467,6 +2466,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 		else if (strcmp(modifier, "usecs") == 0)
 			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
 		else {
+			hist_err("Invalid field modifier: ", modifier);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -2482,6 +2482,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
+			hist_err("Couldn't find field: ", field_name);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -2776,6 +2777,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		expr->fn = hist_field_plus;
 		break;
 	default:
+		ret = -EINVAL;
 		goto free;
 	}
 
@@ -4411,7 +4413,7 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 	struct tracing_map *map = hist_data->map;
 	struct ftrace_event_field *field;
 	struct hist_field *hist_field;
-	int i, idx;
+	int i, idx = 0;
 
 	for_each_hist_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
@@ -4857,22 +4859,24 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 	if (hist_field->var.name)
 		seq_printf(m, "%s=", hist_field->var.name);
 
-	if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
-		seq_puts(m, "common_timestamp");
-	else if (hist_field->flags & HIST_FIELD_FL_CPU)
+	if (hist_field->flags & HIST_FIELD_FL_CPU)
 		seq_puts(m, "cpu");
 	else if (field_name) {
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF ||
 		    hist_field->flags & HIST_FIELD_FL_ALIAS)
 			seq_putc(m, '$');
 		seq_printf(m, "%s", field_name);
-	}
+	} else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
+		seq_puts(m, "common_timestamp");
 
 	if (hist_field->flags) {
-		const char *flags_str = get_hist_field_flags(hist_field);
+		if (!(hist_field->flags & HIST_FIELD_FL_VAR_REF) &&
+		    !(hist_field->flags & HIST_FIELD_FL_EXPR)) {
+			const char *flags = get_hist_field_flags(hist_field);
 
-		if (flags_str)
-			seq_printf(m, ".%s", flags_str);
+			if (flags)
+				seq_printf(m, ".%s", flags);
+		}
 	}
 }
 
diff --git a/kernel/user.c b/kernel/user.c
index 8959ad11d766..0df9b1640b2a 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -96,7 +96,7 @@ static DEFINE_SPINLOCK(uidhash_lock);
 
 /* root_user.__count is 1, for init task cred */
 struct user_struct root_user = {
-	.__count	= ATOMIC_INIT(1),
+	.__count	= REFCOUNT_INIT(1),
 	.processes	= ATOMIC_INIT(1),
 	.sigpending	= ATOMIC_INIT(0),
 	.locked_shm     = 0,
@@ -123,7 +123,7 @@ static struct user_struct *uid_hash_find(kuid_t uid, struct hlist_head *hashent)
 
 	hlist_for_each_entry(user, hashent, uidhash_node) {
 		if (uid_eq(user->uid, uid)) {
-			atomic_inc(&user->__count);
+			refcount_inc(&user->__count);
 			return user;
 		}
 	}
@@ -169,7 +169,7 @@ void free_uid(struct user_struct *up)
 	if (!up)
 		return;
 
-	if (atomic_dec_and_lock_irqsave(&up->__count, &uidhash_lock, flags))
+	if (refcount_dec_and_lock_irqsave(&up->__count, &uidhash_lock, &flags))
 		free_user(up, flags);
 }
 
@@ -188,7 +188,7 @@ struct user_struct *alloc_uid(kuid_t uid)
 			goto out_unlock;
 
 		new->uid = uid;
-		atomic_set(&new->__count, 1);
+		refcount_set(&new->__count, 1);
 		ratelimit_state_init(&new->ratelimit, HZ, 100);
 		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
 
diff --git a/lib/dec_and_lock.c b/lib/dec_and_lock.c
index f29d9cafc37a..347fa7ac2e8a 100644
--- a/lib/dec_and_lock.c
+++ b/lib/dec_and_lock.c
@@ -33,20 +33,3 @@ int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 }
 
 EXPORT_SYMBOL(_atomic_dec_and_lock);
-
-int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
-				 unsigned long *flags)
-{
-	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
-	if (atomic_add_unless(atomic, -1, 1))
-		return 0;
-
-	/* Otherwise do it the slow way */
-	spin_lock_irqsave(lock, *flags);
-	if (atomic_dec_and_test(atomic))
-		return 1;
-	spin_unlock_irqrestore(lock, *flags);
-	return 0;
-}
-
-EXPORT_SYMBOL(_atomic_dec_and_lock_irqsave);
diff --git a/lib/refcount.c b/lib/refcount.c
index 0eb48353abe3..d3b81cefce91 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -350,3 +350,31 @@ bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 }
 EXPORT_SYMBOL(refcount_dec_and_lock);
 
+/**
+ * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
+ *                                 interrupts if able to decrement refcount to 0
+ * @r: the refcount
+ * @lock: the spinlock to be locked
+ * @flags: saved IRQ-flags if the is acquired
+ *
+ * Same as refcount_dec_and_lock() above except that the spinlock is acquired
+ * with disabled interupts.
+ *
+ * Return: true and hold spinlock if able to decrement refcount to 0, false
+ *         otherwise
+ */
+bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
+				   unsigned long *flags)
+{
+	if (refcount_dec_not_one(r))
+		return false;
+
+	spin_lock_irqsave(lock, *flags);
+	if (!refcount_dec_and_test(r)) {
+		spin_unlock_irqrestore(lock, *flags);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
diff --git a/localversion-rt b/localversion-rt
index c3054d08a112..1445cd65885c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 96ab54d1dc9a..087403ed5164 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -460,10 +460,10 @@ wb_congested_get_create(struct backing_dev_info *bdi, int blkcg_id, gfp_t gfp)
 	if (new_congested) {
 		/* !found and storage for new one already allocated, insert */
 		congested = new_congested;
-		new_congested = NULL;
 		rb_link_node(&congested->rb_node, parent, node);
 		rb_insert_color(&congested->rb_node, &bdi->cgwb_congested_tree);
-		goto found;
+		spin_unlock_irqrestore(&cgwb_lock, flags);
+		return congested;
 	}
 
 	spin_unlock_irqrestore(&cgwb_lock, flags);
@@ -473,13 +473,13 @@ wb_congested_get_create(struct backing_dev_info *bdi, int blkcg_id, gfp_t gfp)
 	if (!new_congested)
 		return NULL;
 
-	atomic_set(&new_congested->refcnt, 0);
+	refcount_set(&new_congested->refcnt, 1);
 	new_congested->__bdi = bdi;
 	new_congested->blkcg_id = blkcg_id;
 	goto retry;
 
 found:
-	atomic_inc(&congested->refcnt);
+	refcount_inc(&congested->refcnt);
 	spin_unlock_irqrestore(&cgwb_lock, flags);
 	kfree(new_congested);
 	return congested;
@@ -495,7 +495,7 @@ void wb_congested_put(struct bdi_writeback_congested *congested)
 {
 	unsigned long flags;
 
-	if (!atomic_dec_and_lock_irqsave(&congested->refcnt, &cgwb_lock, flags))
+	if (!refcount_dec_and_lock_irqsave(&congested->refcnt, &cgwb_lock, &flags))
 		return;
 
 	/* bdi might already have been destroyed leaving @congested unlinked */
@@ -803,7 +803,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	if (!bdi->wb_congested)
 		return -ENOMEM;
 
-	atomic_set(&bdi->wb_congested->refcnt, 1);
+	refcount_set(&bdi->wb_congested->refcnt, 1);
 
 	err = wb_init(&bdi->wb, bdi, 1, GFP_KERNEL);
 	if (err) {
