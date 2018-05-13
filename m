Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeEMMTw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 08:19:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49157 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeEMMTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 08:19:50 -0400
Date: Sun, 13 May 2018 14:19:48 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86/pti updates for 4.17
Message-ID: <alpine.DEB.2.21.1805131409270.1582@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

A mixed bag of fixes and updates for the ghosts which are hunting us. The
scheduler fixes have been pulled into that branch to avoid conflicts.

  - A set of fixes to address a khread_parkme() race which caused lost
    wakeups and loss of state.

  - A deadlock fix for stop_machine() solved by moving the wakeups outside
    of the stopper_lock held region.

  - A set of Spectre V1 array access restrictions. The possible problematic
    spots were discuvered by Dan Carpenters new checks in smatch.

  - Removal of an unused file which was forgotten when the rest of that
    functionality was removed.

Thanks,

	tglx

------------------>
Jann Horn (1):
      x86/vdso: Remove unused file

Peter Zijlstra (11):
      stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock
      kthread, sched/wait: Fix kthread_parkme() wait-loop
      kthread, sched/wait: Fix kthread_parkme() completion issue
      sched/core: Introduce set_special_state()
      sched/core: Fix possible Spectre-v1 indexing for sched_prio_to_weight[]
      sched/autogroup: Fix possible Spectre-v1 indexing for sched_prio_to_weight[]
      perf/core: Fix possible Spectre-v1 indexing for ->aux_pages[]
      perf/x86: Fix possible Spectre-v1 indexing for hw_perf_event cache_*
      perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()
      perf/x86/msr: Fix possible Spectre-v1 indexing in the MSR driver
      perf/x86/cstate: Fix possible Spectre-v1 indexing for pkg_msr

Vincent Guittot (1):
      sched/fair: Fix the update of blocked load when newly idle


 arch/x86/entry/vdso/vdso32/vdso-fakesections.c |  1 -
 arch/x86/events/core.c                         |  8 +++-
 arch/x86/events/intel/cstate.c                 |  2 +
 arch/x86/events/msr.c                          |  9 +++--
 include/linux/kthread.h                        |  1 +
 include/linux/sched.h                          | 50 ++++++++++++++++++++---
 include/linux/sched/signal.h                   |  2 +-
 kernel/events/ring_buffer.c                    |  7 +++-
 kernel/kthread.c                               | 50 +++++++++++------------
 kernel/sched/autogroup.c                       |  7 +++-
 kernel/sched/core.c                            | 56 +++++++++++++-------------
 kernel/sched/fair.c                            |  2 +-
 kernel/signal.c                                | 17 +++++++-
 kernel/stop_machine.c                          | 19 ++++++---
 14 files changed, 153 insertions(+), 78 deletions(-)
 delete mode 100644 arch/x86/entry/vdso/vdso32/vdso-fakesections.c

diff --git a/arch/x86/entry/vdso/vdso32/vdso-fakesections.c b/arch/x86/entry/vdso/vdso32/vdso-fakesections.c
deleted file mode 100644
index 541468e25265..000000000000
--- a/arch/x86/entry/vdso/vdso32/vdso-fakesections.c
+++ /dev/null
@@ -1 +0,0 @@
-#include "../vdso-fakesections.c"
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a6006e7bb729..45b2b1c93d04 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -27,6 +27,7 @@
 #include <linux/cpu.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/nospec.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -304,17 +305,20 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 
 	config = attr->config;
 
-	cache_type = (config >>  0) & 0xff;
+	cache_type = (config >> 0) & 0xff;
 	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
 		return -EINVAL;
+	cache_type = array_index_nospec(cache_type, PERF_COUNT_HW_CACHE_MAX);
 
 	cache_op = (config >>  8) & 0xff;
 	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
 		return -EINVAL;
+	cache_op = array_index_nospec(cache_op, PERF_COUNT_HW_CACHE_OP_MAX);
 
 	cache_result = (config >> 16) & 0xff;
 	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
 		return -EINVAL;
+	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
 
 	val = hw_cache_event_ids[cache_type][cache_op][cache_result];
 
@@ -421,6 +425,8 @@ int x86_setup_perfctr(struct perf_event *event)
 	if (attr->config >= x86_pmu.max_events)
 		return -EINVAL;
 
+	attr->config = array_index_nospec((unsigned long)attr->config, x86_pmu.max_events);
+
 	/*
 	 * The generic map:
 	 */
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 9aca448bb8e6..9f8084f18d58 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -92,6 +92,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
@@ -302,6 +303,7 @@ static int cstate_pmu_event_init(struct perf_event *event)
 	} else if (event->pmu == &cstate_pkg_pmu) {
 		if (cfg >= PERF_CSTATE_PKG_EVENT_MAX)
 			return -EINVAL;
+		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
 		if (!pkg_msr[cfg].attr)
 			return -EINVAL;
 		event->hw.event_base = pkg_msr[cfg].msr;
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index e7edf19e64c2..b4771a6ddbc1 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 #include <asm/intel-family.h>
 
 enum perf_msr_id {
@@ -158,9 +159,6 @@ static int msr_event_init(struct perf_event *event)
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (cfg >= PERF_MSR_EVENT_MAX)
-		return -EINVAL;
-
 	/* unsupported modes and filters */
 	if (event->attr.exclude_user   ||
 	    event->attr.exclude_kernel ||
@@ -171,6 +169,11 @@ static int msr_event_init(struct perf_event *event)
 	    event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
+	if (cfg >= PERF_MSR_EVENT_MAX)
+		return -EINVAL;
+
+	cfg = array_index_nospec((unsigned long)cfg, PERF_MSR_EVENT_MAX);
+
 	if (!msr[cfg].attr)
 		return -EINVAL;
 
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index c1961761311d..2803264c512f 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -62,6 +62,7 @@ void *kthread_probe_data(struct task_struct *k);
 int kthread_park(struct task_struct *k);
 void kthread_unpark(struct task_struct *k);
 void kthread_parkme(void);
+void kthread_park_complete(struct task_struct *k);
 
 int kthreadd(void *unused);
 extern struct task_struct *kthreadd_task;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b3d697f3b573..c2413703f45d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -112,17 +112,36 @@ struct task_group;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
+/*
+ * Special states are those that do not use the normal wait-loop pattern. See
+ * the comment with set_special_state().
+ */
+#define is_special_task_state(state)				\
+	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_DEAD))
+
 #define __set_current_state(state_value)			\
 	do {							\
+		WARN_ON_ONCE(is_special_task_state(state_value));\
 		current->task_state_change = _THIS_IP_;		\
 		current->state = (state_value);			\
 	} while (0)
+
 #define set_current_state(state_value)				\
 	do {							\
+		WARN_ON_ONCE(is_special_task_state(state_value));\
 		current->task_state_change = _THIS_IP_;		\
 		smp_store_mb(current->state, (state_value));	\
 	} while (0)
 
+#define set_special_state(state_value)					\
+	do {								\
+		unsigned long flags; /* may shadow */			\
+		WARN_ON_ONCE(!is_special_task_state(state_value));	\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
+		current->task_state_change = _THIS_IP_;			\
+		current->state = (state_value);				\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
+	} while (0)
 #else
 /*
  * set_current_state() includes a barrier so that the write of current->state
@@ -144,8 +163,8 @@ struct task_group;
  *
  * The above is typically ordered against the wakeup, which does:
  *
- *	need_sleep = false;
- *	wake_up_state(p, TASK_UNINTERRUPTIBLE);
+ *   need_sleep = false;
+ *   wake_up_state(p, TASK_UNINTERRUPTIBLE);
  *
  * Where wake_up_state() (and all other wakeup primitives) imply enough
  * barriers to order the store of the variable against wakeup.
@@ -154,12 +173,33 @@ struct task_group;
  * once it observes the TASK_UNINTERRUPTIBLE store the waking CPU can issue a
  * TASK_RUNNING store which can collide with __set_current_state(TASK_RUNNING).
  *
- * This is obviously fine, since they both store the exact same value.
+ * However, with slightly different timing the wakeup TASK_RUNNING store can
+ * also collide with the TASK_UNINTERRUPTIBLE store. Loosing that store is not
+ * a problem either because that will result in one extra go around the loop
+ * and our @cond test will save the day.
  *
  * Also see the comments of try_to_wake_up().
  */
-#define __set_current_state(state_value) do { current->state = (state_value); } while (0)
-#define set_current_state(state_value)	 smp_store_mb(current->state, (state_value))
+#define __set_current_state(state_value)				\
+	current->state = (state_value)
+
+#define set_current_state(state_value)					\
+	smp_store_mb(current->state, (state_value))
+
+/*
+ * set_special_state() should be used for those states when the blocking task
+ * can not use the regular condition based wait-loop. In that case we must
+ * serialize against wakeups such that any possible in-flight TASK_RUNNING stores
+ * will not collide with our state change.
+ */
+#define set_special_state(state_value)					\
+	do {								\
+		unsigned long flags; /* may shadow */			\
+		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
+		current->state = (state_value);				\
+		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
+	} while (0)
+
 #endif
 
 /* Task command name length: */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index a7ce74c74e49..113d1ad1ced7 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -280,7 +280,7 @@ static inline void kernel_signal_stop(void)
 {
 	spin_lock_irq(&current->sighand->siglock);
 	if (current->jobctl & JOBCTL_STOP_DEQUEUED)
-		__set_current_state(TASK_STOPPED);
+		set_special_state(TASK_STOPPED);
 	spin_unlock_irq(&current->sighand->siglock);
 
 	schedule();
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 6c6b3c48db71..1d8ca9ea9979 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/circ_buf.h>
 #include <linux/poll.h>
+#include <linux/nospec.h>
 
 #include "internal.h"
 
@@ -867,8 +868,10 @@ perf_mmap_to_page(struct ring_buffer *rb, unsigned long pgoff)
 			return NULL;
 
 		/* AUX space */
-		if (pgoff >= rb->aux_pgoff)
-			return virt_to_page(rb->aux_pages[pgoff - rb->aux_pgoff]);
+		if (pgoff >= rb->aux_pgoff) {
+			int aux_pgoff = array_index_nospec(pgoff - rb->aux_pgoff, rb->aux_nr_pages);
+			return virt_to_page(rb->aux_pages[aux_pgoff]);
+		}
 	}
 
 	return __perf_mmap_to_page(rb, pgoff);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index cd50e99202b0..2017a39ab490 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -55,7 +55,6 @@ enum KTHREAD_BITS {
 	KTHREAD_IS_PER_CPU = 0,
 	KTHREAD_SHOULD_STOP,
 	KTHREAD_SHOULD_PARK,
-	KTHREAD_IS_PARKED,
 };
 
 static inline void set_kthread_struct(void *kthread)
@@ -177,14 +176,12 @@ void *kthread_probe_data(struct task_struct *task)
 
 static void __kthread_parkme(struct kthread *self)
 {
-	__set_current_state(TASK_PARKED);
-	while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {
-		if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))
-			complete(&self->parked);
+	for (;;) {
+		set_current_state(TASK_PARKED);
+		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
+			break;
 		schedule();
-		__set_current_state(TASK_PARKED);
 	}
-	clear_bit(KTHREAD_IS_PARKED, &self->flags);
 	__set_current_state(TASK_RUNNING);
 }
 
@@ -194,6 +191,11 @@ void kthread_parkme(void)
 }
 EXPORT_SYMBOL_GPL(kthread_parkme);
 
+void kthread_park_complete(struct task_struct *k)
+{
+	complete(&to_kthread(k)->parked);
+}
+
 static int kthread(void *_create)
 {
 	/* Copy data: it's on kthread's stack */
@@ -450,22 +452,15 @@ void kthread_unpark(struct task_struct *k)
 {
 	struct kthread *kthread = to_kthread(k);
 
-	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	/*
-	 * We clear the IS_PARKED bit here as we don't wait
-	 * until the task has left the park code. So if we'd
-	 * park before that happens we'd see the IS_PARKED bit
-	 * which might be about to be cleared.
+	 * Newly created kthread was parked when the CPU was offline.
+	 * The binding was lost and we need to set it again.
 	 */
-	if (test_and_clear_bit(KTHREAD_IS_PARKED, &kthread->flags)) {
-		/*
-		 * Newly created kthread was parked when the CPU was offline.
-		 * The binding was lost and we need to set it again.
-		 */
-		if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
-			__kthread_bind(k, kthread->cpu, TASK_PARKED);
-		wake_up_state(k, TASK_PARKED);
-	}
+	if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
+		__kthread_bind(k, kthread->cpu, TASK_PARKED);
+
+	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
+	wake_up_state(k, TASK_PARKED);
 }
 EXPORT_SYMBOL_GPL(kthread_unpark);
 
@@ -488,12 +483,13 @@ int kthread_park(struct task_struct *k)
 	if (WARN_ON(k->flags & PF_EXITING))
 		return -ENOSYS;
 
-	if (!test_bit(KTHREAD_IS_PARKED, &kthread->flags)) {
-		set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
-		if (k != current) {
-			wake_up_process(k);
-			wait_for_completion(&kthread->parked);
-		}
+	if (WARN_ON_ONCE(test_bit(KTHREAD_SHOULD_PARK, &kthread->flags)))
+		return -EBUSY;
+
+	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
+	if (k != current) {
+		wake_up_process(k);
+		wait_for_completion(&kthread->parked);
 	}
 
 	return 0;
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 6be6c575b6cd..2d4ff5353ded 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -2,6 +2,7 @@
 /*
  * Auto-group scheduling implementation:
  */
+#include <linux/nospec.h>
 #include "sched.h"
 
 unsigned int __read_mostly sysctl_sched_autogroup_enabled = 1;
@@ -209,7 +210,7 @@ int proc_sched_autogroup_set_nice(struct task_struct *p, int nice)
 	static unsigned long next = INITIAL_JIFFIES;
 	struct autogroup *ag;
 	unsigned long shares;
-	int err;
+	int err, idx;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -EINVAL;
@@ -227,7 +228,9 @@ int proc_sched_autogroup_set_nice(struct task_struct *p, int nice)
 
 	next = HZ / 10 + jiffies;
 	ag = autogroup_task_get(p);
-	shares = scale_load(sched_prio_to_weight[nice + 20]);
+
+	idx = array_index_nospec(nice + 20, 40);
+	shares = scale_load(sched_prio_to_weight[idx]);
 
 	down_write(&ag->lock);
 	err = sched_group_set_shares(ag->tg, shares);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10aaeebfcc..092f7c4de903 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7,6 +7,9 @@
  */
 #include "sched.h"
 
+#include <linux/kthread.h>
+#include <linux/nospec.h>
+
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
 
@@ -2718,20 +2721,28 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		membarrier_mm_sync_core_before_usermode(mm);
 		mmdrop(mm);
 	}
-	if (unlikely(prev_state == TASK_DEAD)) {
-		if (prev->sched_class->task_dead)
-			prev->sched_class->task_dead(prev);
+	if (unlikely(prev_state & (TASK_DEAD|TASK_PARKED))) {
+		switch (prev_state) {
+		case TASK_DEAD:
+			if (prev->sched_class->task_dead)
+				prev->sched_class->task_dead(prev);
 
-		/*
-		 * Remove function-return probe instances associated with this
-		 * task and put them back on the free list.
-		 */
-		kprobe_flush_task(prev);
+			/*
+			 * Remove function-return probe instances associated with this
+			 * task and put them back on the free list.
+			 */
+			kprobe_flush_task(prev);
+
+			/* Task is done with its stack. */
+			put_task_stack(prev);
 
-		/* Task is done with its stack. */
-		put_task_stack(prev);
+			put_task_struct(prev);
+			break;
 
-		put_task_struct(prev);
+		case TASK_PARKED:
+			kthread_park_complete(prev);
+			break;
+		}
 	}
 
 	tick_nohz_task_switch();
@@ -3498,23 +3509,8 @@ static void __sched notrace __schedule(bool preempt)
 
 void __noreturn do_task_dead(void)
 {
-	/*
-	 * The setting of TASK_RUNNING by try_to_wake_up() may be delayed
-	 * when the following two conditions become true.
-	 *   - There is race condition of mmap_sem (It is acquired by
-	 *     exit_mm()), and
-	 *   - SMI occurs before setting TASK_RUNINNG.
-	 *     (or hypervisor of virtual machine switches to other guest)
-	 *  As a result, we may become TASK_RUNNING after becoming TASK_DEAD
-	 *
-	 * To avoid it, we have to wait for releasing tsk->pi_lock which
-	 * is held by try_to_wake_up()
-	 */
-	raw_spin_lock_irq(&current->pi_lock);
-	raw_spin_unlock_irq(&current->pi_lock);
-
 	/* Causes final put_task_struct in finish_task_switch(): */
-	__set_current_state(TASK_DEAD);
+	set_special_state(TASK_DEAD);
 
 	/* Tell freezer to ignore us: */
 	current->flags |= PF_NOFREEZE;
@@ -6928,11 +6924,15 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 				     struct cftype *cft, s64 nice)
 {
 	unsigned long weight;
+	int idx;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -ERANGE;
 
-	weight = sched_prio_to_weight[NICE_TO_PRIO(nice) - MAX_RT_PRIO];
+	idx = NICE_TO_PRIO(nice) - MAX_RT_PRIO;
+	idx = array_index_nospec(idx, 40);
+	weight = sched_prio_to_weight[idx];
+
 	return sched_group_set_shares(css_tg(css), scale_load(weight));
 }
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54dc31e7ab9b..e3002e5ada31 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9847,6 +9847,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
 
+out:
 	/*
 	 * While browsing the domains, we released the rq lock, a task could
 	 * have been enqueued in the meantime. Since we're not going idle,
@@ -9855,7 +9856,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->cfs.h_nr_running && !pulled_task)
 		pulled_task = 1;
 
-out:
 	/* Move the next balance forward */
 	if (time_after(this_rq->next_balance, next_balance))
 		this_rq->next_balance = next_balance;
diff --git a/kernel/signal.c b/kernel/signal.c
index d4ccea599692..9c33163a6165 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1961,14 +1961,27 @@ static void ptrace_stop(int exit_code, int why, int clear_code, siginfo_t *info)
 			return;
 	}
 
+	set_special_state(TASK_TRACED);
+
 	/*
 	 * We're committing to trapping.  TRACED should be visible before
 	 * TRAPPING is cleared; otherwise, the tracer might fail do_wait().
 	 * Also, transition to TRACED and updates to ->jobctl should be
 	 * atomic with respect to siglock and should be done after the arch
 	 * hook as siglock is released and regrabbed across it.
+	 *
+	 *     TRACER				    TRACEE
+	 *
+	 *     ptrace_attach()
+	 * [L]   wait_on_bit(JOBCTL_TRAPPING)	[S] set_special_state(TRACED)
+	 *     do_wait()
+	 *       set_current_state()                smp_wmb();
+	 *       ptrace_do_wait()
+	 *         wait_task_stopped()
+	 *           task_stopped_code()
+	 * [L]         task_is_traced()		[S] task_clear_jobctl_trapping();
 	 */
-	set_current_state(TASK_TRACED);
+	smp_wmb();
 
 	current->last_siginfo = info;
 	current->exit_code = exit_code;
@@ -2176,7 +2189,7 @@ static bool do_signal_stop(int signr)
 		if (task_participate_group_stop(current))
 			notify = CLD_STOPPED;
 
-		__set_current_state(TASK_STOPPED);
+		set_special_state(TASK_STOPPED);
 		spin_unlock_irq(&current->sighand->siglock);
 
 		/*
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b7591261652d..64c0291b579c 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -21,6 +21,7 @@
 #include <linux/smpboot.h>
 #include <linux/atomic.h>
 #include <linux/nmi.h>
+#include <linux/sched/wake_q.h>
 
 /*
  * Structure to determine completion condition and record errors.  May
@@ -65,27 +66,31 @@ static void cpu_stop_signal_done(struct cpu_stop_done *done)
 }
 
 static void __cpu_stop_queue_work(struct cpu_stopper *stopper,
-					struct cpu_stop_work *work)
+					struct cpu_stop_work *work,
+					struct wake_q_head *wakeq)
 {
 	list_add_tail(&work->list, &stopper->works);
-	wake_up_process(stopper->thread);
+	wake_q_add(wakeq, stopper->thread);
 }
 
 /* queue @work to @stopper.  if offline, @work is completed immediately */
 static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 {
 	struct cpu_stopper *stopper = &per_cpu(cpu_stopper, cpu);
+	DEFINE_WAKE_Q(wakeq);
 	unsigned long flags;
 	bool enabled;
 
 	spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
 	if (enabled)
-		__cpu_stop_queue_work(stopper, work);
+		__cpu_stop_queue_work(stopper, work, &wakeq);
 	else if (work->done)
 		cpu_stop_signal_done(work->done);
 	spin_unlock_irqrestore(&stopper->lock, flags);
 
+	wake_up_q(&wakeq);
+
 	return enabled;
 }
 
@@ -229,6 +234,7 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 {
 	struct cpu_stopper *stopper1 = per_cpu_ptr(&cpu_stopper, cpu1);
 	struct cpu_stopper *stopper2 = per_cpu_ptr(&cpu_stopper, cpu2);
+	DEFINE_WAKE_Q(wakeq);
 	int err;
 retry:
 	spin_lock_irq(&stopper1->lock);
@@ -252,8 +258,8 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 			goto unlock;
 
 	err = 0;
-	__cpu_stop_queue_work(stopper1, work1);
-	__cpu_stop_queue_work(stopper2, work2);
+	__cpu_stop_queue_work(stopper1, work1, &wakeq);
+	__cpu_stop_queue_work(stopper2, work2, &wakeq);
 unlock:
 	spin_unlock(&stopper2->lock);
 	spin_unlock_irq(&stopper1->lock);
@@ -263,6 +269,9 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 			cpu_relax();
 		goto retry;
 	}
+
+	wake_up_q(&wakeq);
+
 	return err;
 }
 /**
