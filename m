Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeFENcO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:32:14 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33182 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeFENaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:30:01 -0400
X-Google-Smtp-Source: ADUXVKI6EOytrpNWj+//L63QnCUEvbp3zWck2ULYAEH6+91UpvkoZJew/ocKBqx1VHFzW1JzeKo/Yw==
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 06/13] blkcg: add generic throttling mechanism
Date: Tue,  5 Jun 2018 09:29:41 -0400
Message-Id: <20180605132948.1664-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605132948.1664-1-josef@toxicpanda.com>
References: <20180605132948.1664-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

Since IO can be issued from literally anywhere it's almost impossible to
do throttling without having some sort of adverse effect somewhere else
in the system because of locking or other dependencies.  The best way to
solve this is to do the throttling when we know we aren't holding any
other kernel resources.  Do this by tracking throttling in a per-blkg
basis, and if we require throttling flag the task that it needs to check
before it returns to user space and possibly sleep there.

This is to address the case where a process is doing work that is
generating IO that can't be throttled, whether that is directly with a
lot of REQ_META IO, or indirectly by allocating so much memory that it
is swamping the disk with REQ_SWAP.  We can't use task_add_work as we
don't want to induce a memory allocation in the IO path, so simply
saving the request queue in the task and flagging it to do the
notify_resume thing achieves the same result without the overhead of a
memory allocation.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/blk-cgroup.c          | 207 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-cgroup.h  |  72 +++++++++++++++
 include/linux/cgroup-defs.h |   3 +
 include/linux/sched.h       |   8 ++
 include/linux/tracehook.h   |   2 +
 5 files changed, 292 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b2ac6a7f851f..175a6d8f593d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -27,6 +27,7 @@
 #include <linux/atomic.h>
 #include <linux/ctype.h>
 #include <linux/blk-cgroup.h>
+#include <linux/tracehook.h>
 #include "blk.h"
 
 #define MAX_KEY_LEN 100
@@ -1340,6 +1341,13 @@ static void blkcg_bind(struct cgroup_subsys_state *root_css)
 	mutex_unlock(&blkcg_pol_mutex);
 }
 
+static void blkcg_exit(struct task_struct *tsk)
+{
+	if (tsk->throttle_queue)
+		blk_put_queue(tsk->throttle_queue);
+	tsk->throttle_queue = NULL;
+}
+
 struct cgroup_subsys io_cgrp_subsys = {
 	.css_alloc = blkcg_css_alloc,
 	.css_offline = blkcg_css_offline,
@@ -1349,6 +1357,7 @@ struct cgroup_subsys io_cgrp_subsys = {
 	.dfl_cftypes = blkcg_files,
 	.legacy_cftypes = blkcg_legacy_files,
 	.legacy_name = "blkio",
+	.exit = blkcg_exit,
 #ifdef CONFIG_MEMCG
 	/*
 	 * This ensures that, if available, memcg is automatically enabled
@@ -1600,5 +1609,203 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 }
 EXPORT_SYMBOL_GPL(blkcg_policy_unregister);
 
+/*
+ * Scale the accumulated delay based on how long it has been since we updated
+ * the delay.  We only call this when we are adding delay, in case it's been a
+ * while since we added delay, and when we are checking to see if we need to
+ * delay a task, to account for any delays that may have occurred.
+ */
+static void blkcg_scale_delay(struct blkcg_gq *blkg, u64 now)
+{
+	u64 old = atomic64_read(&blkg->delay_start);
+
+	/*
+	 * We only want to scale down every second.  The idea here is that we
+	 * want to delay people for min(delay_nsec, NSEC_PER_SEC) in a certain
+	 * time window.  We only want to throttle tasks for recent delay that
+	 * has occurred, in 1 second time windows since that's the maximum
+	 * things can be throttled.  We save the current delay window in
+	 * blkg->last_delay so we know what amount is still left to be charged
+	 * to the blkg from this point onward.  blkg->last_use keeps track of
+	 * the use_delay counter.  The idea is if we're unthrottling the blkg we
+	 * are ok with whatever is happening now, and we can take away more of
+	 * the accumulated delay as we've already throttled enough that
+	 * everybody is happy with their IO latencies.
+	 */
+	if (time_before64(old + NSEC_PER_SEC, now) &&
+	    atomic64_cmpxchg(&blkg->delay_start, old, now) == old) {
+		u64 cur = atomic64_read(&blkg->delay_nsec);
+		u64 sub = min_t(u64, blkg->last_delay, now - old);
+		int cur_use = atomic_read(&blkg->use_delay);
+
+		/*
+		 * We've been unthrottled, subtract a larger chunk of our
+		 * accumulated delay.
+		 */
+		if (cur_use < blkg->last_use)
+			sub = max_t(u64, sub, blkg->last_delay >> 1);
+
+		/*
+		 * This shouldn't happen, but handle it anyway.  Our delay_nsec
+		 * should only ever be growing except here where we subtract out
+		 * min(last_delay, 1 second), but lord knows bugs happen and I'd
+		 * rather not end up with negative numbers.
+		 */
+		if (unlikely(cur < sub)) {
+			atomic64_set(&blkg->delay_nsec, 0);
+			blkg->last_delay = 0;
+		} else {
+			atomic64_sub(sub, &blkg->delay_nsec);
+			blkg->last_delay = cur - sub;
+		}
+		blkg->last_use = cur_use;
+	}
+}
+
+/*
+ * This is called when we want to actually walk up the hierarchy and check to
+ * see if we need to throttle, and then actually throttle if there is some
+ * accumulated delay.  This should only be called upon return to user space so
+ * we're not holding some lock that would induce a priority inversion.
+ */
+static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
+{
+	u64 now = ktime_to_ns(ktime_get());
+	u64 exp;
+	u64 delay_nsec = 0;
+	int tok;
+
+	while (blkg->parent) {
+		if (atomic_read(&blkg->use_delay)) {
+			blkcg_scale_delay(blkg, now);
+			delay_nsec = max_t(u64, delay_nsec,
+					   atomic64_read(&blkg->delay_nsec));
+		}
+		blkg = blkg->parent;
+	}
+
+	if (!delay_nsec)
+		return;
+
+	/*
+	 * Let's not sleep for all eternity if we've amassed a huge delay.
+	 * Swapping or metadata IO can accumulate 10's of seconds worth of
+	 * delay, and we want userspace to be able to do _something_ so cap the
+	 * delays at 1 second.  If there's 10's of seconds worth of delay then
+	 * the tasks will be delayed for 1 second for every syscall.
+	 */
+	delay_nsec = min_t(u64, delay_nsec, NSEC_PER_SEC);
+
+	/*
+	 * TODO: the use_memdelay flag is going to be for the upcoming psi stuff
+	 * that hasn't landed upstream yet.  Once that stuff is in place we need
+	 * to do a psi_memstall_enter/leave if memdelay is set.
+	 */
+
+	exp = ktime_add_ns(now, delay_nsec);
+	tok = io_schedule_prepare();
+	do {
+		__set_current_state(TASK_KILLABLE);
+		if (!schedule_hrtimeout(&exp, HRTIMER_MODE_ABS))
+			break;
+	} while (!fatal_signal_pending(current));
+	io_schedule_finish(tok);
+}
+
+/**
+ * blkcg_maybe_throttle_current - throttle the current task if it has been marked
+ *
+ * This is only called if we've been marked with set_notify_resume().  Obviously
+ * we can be set_notify_resume() for reasons other than blkcg throttling, so we
+ * check to see if current->throttle_queue is set and if not this doesn't do
+ * anything.  This should only ever be called by the resume code, it's not meant
+ * to be called by people willy-nilly as it will actually do the work to
+ * throttle the task if it is setup for throttling.
+ */
+void blkcg_maybe_throttle_current(void)
+{
+	struct request_queue *q = current->throttle_queue;
+	struct cgroup_subsys_state *css;
+	struct blkcg *blkcg;
+	struct blkcg_gq *blkg;
+	bool use_memdelay = current->use_memdelay;
+
+	if (!q)
+		return;
+
+	current->throttle_queue = NULL;
+	current->use_memdelay = false;
+
+	rcu_read_lock();
+	css = kthread_blkcg();
+	if (css)
+		blkcg = css_to_blkcg(css);
+	else
+		blkcg = css_to_blkcg(task_css(current, io_cgrp_id));
+
+	if (!blkcg)
+		goto out;
+	blkg = blkg_lookup(blkcg, q);
+	if (!blkg)
+		goto out;
+	blkg = blkg_try_get(blkg);
+	if (!blkg)
+		goto out;
+	rcu_read_unlock();
+	blk_put_queue(q);
+
+	blkcg_maybe_throttle_blkg(blkg, use_memdelay);
+	blkg_put(blkg);
+	return;
+out:
+	rcu_read_unlock();
+	blk_put_queue(q);
+}
+EXPORT_SYMBOL_GPL(blkcg_maybe_throttle_current);
+
+/**
+ * blkcg_schedule_throttle - this task needs to check for throttling
+ * @q - the request queue IO was submitted on
+ * @use_memdelay - do we charge this to memory delay for PSI
+ *
+ * This is called by the IO controller when we know there's delay accumulated
+ * for the blkg for this task.  We do not pass the blkg because there are places
+ * we call this that may not have that information, the swapping code for
+ * instance will only have a request_queue at that point.  This set's the
+ * notify_resume for the task to check and see if it requires throttling before
+ * returning to user space.
+ */
+void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
+{
+	if (unlikely(current->flags & PF_KTHREAD))
+		return;
+
+	if (!blk_get_queue(q))
+		return;
+
+	if (current->throttle_queue)
+		blk_put_queue(current->throttle_queue);
+	current->throttle_queue = q;
+	if (use_memdelay)
+		current->use_memdelay = use_memdelay;
+	set_notify_resume(current);
+}
+EXPORT_SYMBOL_GPL(blkcg_schedule_throttle);
+
+/**
+ * blkcg_add_delay - add delay to this blkg
+ * @now - the current time in nanoseconds
+ * @delta - how many nanoseconds of delay to add
+ *
+ * Charge @delta to the blkg's current delay accumulation.  This is used to
+ * throttle tasks if an IO controller thinks we need more throttling.
+ */
+void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
+{
+	blkcg_scale_delay(blkg, now);
+	atomic64_add(delta, &blkg->delay_nsec);
+}
+EXPORT_SYMBOL_GPL(blkcg_add_delay);
+
 module_param(blkcg_debug_stats, bool, 0444);
 MODULE_PARM_DESC(blkcg_debug_stats, "True if you want debug stats, false if not");
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index a8f9ba8f33a4..327d00367c6b 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -136,6 +136,12 @@ struct blkcg_gq {
 	struct blkg_policy_data		*pd[BLKCG_MAX_POLS];
 
 	struct rcu_head			rcu_head;
+
+	atomic_t			use_delay;
+	atomic64_t			delay_nsec;
+	atomic64_t			delay_start;
+	u64				last_delay;
+	int				last_use;
 };
 
 typedef struct blkcg_policy_data *(blkcg_pol_alloc_cpd_fn)(gfp_t gfp);
@@ -374,6 +380,21 @@ static inline void blkg_get(struct blkcg_gq *blkg)
 	atomic_inc(&blkg->refcnt);
 }
 
+/**
+ * blkg_try_get - try and get a blkg reference
+ * @blkg: blkg to get
+ *
+ * This is for use when doing an RCU lookup of the blkg.  We may be in the midst
+ * of freeing this blkg, so we can only use it if the refcnt is not zero.
+ */
+static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
+{
+	if (atomic_inc_not_zero(&blkg->refcnt))
+		return blkg;
+	return NULL;
+}
+
+
 void __blkg_release_rcu(struct rcu_head *rcu);
 
 /**
@@ -734,6 +755,53 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	return !throtl;
 }
 
+static inline void blkcg_use_delay(struct blkcg_gq *blkg)
+{
+	if (atomic_inc_and_test(&blkg->use_delay))
+		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
+}
+
+static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
+{
+	int old = atomic_read(&blkg->use_delay);
+
+	if (old == 0)
+		return 0;
+
+	/*
+	 * We do this song and dance because we can race with somebody else
+	 * adding or removing delay.  If we just did an atomic_dec we'd end up
+	 * negative and we'd already be in trouble.  We need to subtract 1 and
+	 * then check to see if we were the last delay so we can drop the
+	 * congestion count on the cgroup.
+	 */
+	while (old) {
+		int cur = atomic_cmpxchg(&blkg->use_delay, old, old - 1);
+		if (cur == old)
+			break;
+		cur = old;
+	}
+
+	if (old == 0)
+		return 0;
+	if (old == 1)
+		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
+	return 1;
+}
+
+static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
+{
+	int old = atomic_read(&blkg->use_delay);
+	if (!old)
+		return;
+	/* We only want 1 person clearing the congestion count for this blkg. */
+	if (atomic_cmpxchg(&blkg->use_delay, old, 0) == old)
+		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
+}
+
+void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
+void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
+void blkcg_maybe_throttle_current(void);
 #else	/* CONFIG_BLK_CGROUP */
 
 struct blkcg {
@@ -753,8 +821,12 @@ struct blkcg_policy {
 
 #define blkcg_root_css	((struct cgroup_subsys_state *)ERR_PTR(-EINVAL))
 
+static inline void blkcg_maybe_throttle_current(void) { }
+
 #ifdef CONFIG_BLOCK
 
+static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
+
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
 static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
 static inline void blkcg_drain_queue(struct request_queue *q) { }
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index dc5b70449dc6..b3ab17d53f3d 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -427,6 +427,9 @@ struct cgroup {
 	/* used to store eBPF programs */
 	struct cgroup_bpf bpf;
 
+	/* If there is block congestion on this cgroup. */
+	atomic_t congestion_count;
+
 	/* ids of the ancestors at each level including self */
 	int ancestor_ids[];
 };
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b3d697f3b573..6fe0d3c1409b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -693,6 +693,10 @@ struct task_struct {
 	/* disallow userland-initiated cgroup migration */
 	unsigned			no_cgroup_migration:1;
 #endif
+#ifdef CONFIG_BLK_CGROUP
+	/* to be used once the psi infrastructure lands upstream. */
+	unsigned			use_memdelay:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
@@ -1099,6 +1103,10 @@ struct task_struct {
 	unsigned int			memcg_nr_pages_over_high;
 #endif
 
+#ifdef CONFIG_BLK_CGROUP
+	struct request_queue		*throttle_queue;
+#endif
+
 #ifdef CONFIG_UPROBES
 	struct uprobe_task		*utask;
 #endif
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 26c152122a42..4e24930306b9 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -51,6 +51,7 @@
 #include <linux/security.h>
 #include <linux/task_work.h>
 #include <linux/memcontrol.h>
+#include <linux/blk-cgroup.h>
 struct linux_binprm;
 
 /*
@@ -191,6 +192,7 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
 		task_work_run();
 
 	mem_cgroup_handle_over_high();
+	blkcg_maybe_throttle_current();
 }
 
 #endif	/* <linux/tracehook.h> */
-- 
2.14.3
