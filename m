Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B0C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E318C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E318C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeFTJlV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:41:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46557 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932365AbeFTJlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:41:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K9etJA3448476
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Jun 2018 02:40:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K9etDS3448473;
        Wed, 20 Jun 2018 02:40:55 -0700
Date:   Wed, 20 Jun 2018 02:40:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-b3dae109fa89d67334bf3349babab3ad9b6f233f@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
          tglx@linutronix.de
In-Reply-To: <20180612083909.261946548@infradead.org>
References: <20180612083909.261946548@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/swait: Rename to exclusive
Git-Commit-ID: b3dae109fa89d67334bf3349babab3ad9b6f233f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b3dae109fa89d67334bf3349babab3ad9b6f233f
Gitweb:     https://git.kernel.org/tip/b3dae109fa89d67334bf3349babab3ad9b6f233f
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 12 Jun 2018 10:34:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 11:35:56 +0200

sched/swait: Rename to exclusive

Since swait basically implemented exclusive waits only, make sure
the API reflects that.

  $ git grep -l -e "\<swake_up\>"
		-e "\<swait_event[^ (]*"
		-e "\<prepare_to_swait\>" | while read file;
    do
	sed -i -e 's/\<swake_up\>/&_one/g'
	       -e 's/\<swait_event[^ (]*/&_exclusive/g'
	       -e 's/\<prepare_to_swait\>/&_exclusive/g' $file;
    done

With a few manual touch-ups.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bigeasy@linutronix.de
Cc: oleg@redhat.com
Cc: paulmck@linux.vnet.ibm.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180612083909.261946548@infradead.org

---
 arch/mips/kvm/mips.c         |  4 ++--
 arch/powerpc/kvm/book3s_hv.c |  6 +++---
 arch/s390/kvm/interrupt.c    |  2 +-
 arch/x86/kernel/kvm.c        |  4 ++--
 arch/x86/kvm/lapic.c         |  2 +-
 include/linux/swait.h        | 24 ++++++++++++------------
 kernel/power/suspend.c       |  4 ++--
 kernel/rcu/srcutiny.c        |  4 ++--
 kernel/rcu/tree.c            |  8 ++++----
 kernel/rcu/tree_exp.h        |  4 ++--
 kernel/rcu/tree_plugin.h     | 12 ++++++------
 kernel/sched/swait.c         | 10 +++++-----
 virt/kvm/arm/arm.c           |  4 ++--
 virt/kvm/arm/psci.c          |  2 +-
 virt/kvm/async_pf.c          |  2 +-
 virt/kvm/kvm_main.c          |  4 ++--
 16 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 7cd76f93a438..f7ea8e21656b 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -515,7 +515,7 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
 	dvcpu->arch.wait = 0;
 
 	if (swq_has_sleeper(&dvcpu->wq))
-		swake_up(&dvcpu->wq);
+		swake_up_one(&dvcpu->wq);
 
 	return 0;
 }
@@ -1204,7 +1204,7 @@ static void kvm_mips_comparecount_func(unsigned long data)
 
 	vcpu->arch.wait = 0;
 	if (swq_has_sleeper(&vcpu->wq))
-		swake_up(&vcpu->wq);
+		swake_up_one(&vcpu->wq);
 }
 
 /* low level hrtimer wake routine */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index de686b340f4a..ee4a8854985e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -216,7 +216,7 @@ static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
 
 	wqp = kvm_arch_vcpu_wq(vcpu);
 	if (swq_has_sleeper(wqp)) {
-		swake_up(wqp);
+		swake_up_one(wqp);
 		++vcpu->stat.halt_wakeup;
 	}
 
@@ -3188,7 +3188,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 		}
 	}
 
-	prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
+	prepare_to_swait_exclusive(&vc->wq, &wait, TASK_INTERRUPTIBLE);
 
 	if (kvmppc_vcore_check_block(vc)) {
 		finish_swait(&vc->wq, &wait);
@@ -3311,7 +3311,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 			kvmppc_start_thread(vcpu, vc);
 			trace_kvm_guest_enter(vcpu);
 		} else if (vc->vcore_state == VCORE_SLEEPING) {
-			swake_up(&vc->wq);
+			swake_up_one(&vc->wq);
 		}
 
 	}
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index daa09f89ca2d..fcb55b02990e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1145,7 +1145,7 @@ void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 		 * yield-candidate.
 		 */
 		vcpu->preempted = true;
-		swake_up(&vcpu->wq);
+		swake_up_one(&vcpu->wq);
 		vcpu->stat.halt_wakeup++;
 	}
 	/*
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5b2300b818af..a37bda38d205 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -154,7 +154,7 @@ void kvm_async_pf_task_wait(u32 token, int interrupt_kernel)
 
 	for (;;) {
 		if (!n.halted)
-			prepare_to_swait(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
+			prepare_to_swait_exclusive(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
 		if (hlist_unhashed(&n.link))
 			break;
 
@@ -188,7 +188,7 @@ static void apf_task_wake_one(struct kvm_task_sleep_node *n)
 	if (n->halted)
 		smp_send_reschedule(n->cpu);
 	else if (swq_has_sleeper(&n->wq))
-		swake_up(&n->wq);
+		swake_up_one(&n->wq);
 }
 
 static void apf_task_wake_all(void)
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index b5cd8465d44f..d536d457517b 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1379,7 +1379,7 @@ static void apic_timer_expired(struct kvm_lapic *apic)
 	 * using swait_active() is safe.
 	 */
 	if (swait_active(q))
-		swake_up(q);
+		swake_up_one(q);
 
 	if (apic_lvtt_tscdeadline(apic))
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
diff --git a/include/linux/swait.h b/include/linux/swait.h
index dd032061112d..73e06e9986d4 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -16,7 +16,7 @@
  * wait-queues, but the semantics are actually completely different, and
  * every single user we have ever had has been buggy (or pointless).
  *
- * A "swake_up()" only wakes up _one_ waiter, which is not at all what
+ * A "swake_up_one()" only wakes up _one_ waiter, which is not at all what
  * "wake_up()" does, and has led to problems. In other cases, it has
  * been fine, because there's only ever one waiter (kvm), but in that
  * case gthe whole "simple" wait-queue is just pointless to begin with,
@@ -115,7 +115,7 @@ extern void __init_swait_queue_head(struct swait_queue_head *q, const char *name
  *      CPU0 - waker                    CPU1 - waiter
  *
  *                                      for (;;) {
- *      @cond = true;                     prepare_to_swait(&wq_head, &wait, state);
+ *      @cond = true;                     prepare_to_swait_exclusive(&wq_head, &wait, state);
  *      smp_mb();                         // smp_mb() from set_current_state()
  *      if (swait_active(wq_head))        if (@cond)
  *        wake_up(wq_head);                      break;
@@ -157,11 +157,11 @@ static inline bool swq_has_sleeper(struct swait_queue_head *wq)
 	return swait_active(wq);
 }
 
-extern void swake_up(struct swait_queue_head *q);
+extern void swake_up_one(struct swait_queue_head *q);
 extern void swake_up_all(struct swait_queue_head *q);
 extern void swake_up_locked(struct swait_queue_head *q);
 
-extern void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
+extern void prepare_to_swait_exclusive(struct swait_queue_head *q, struct swait_queue *wait, int state);
 extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
 
 extern void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
@@ -196,7 +196,7 @@ __out:	__ret;								\
 	(void)___swait_event(wq, condition, TASK_UNINTERRUPTIBLE, 0,	\
 			    schedule())
 
-#define swait_event(wq, condition)					\
+#define swait_event_exclusive(wq, condition)				\
 do {									\
 	if (condition)							\
 		break;							\
@@ -208,7 +208,7 @@ do {									\
 		      TASK_UNINTERRUPTIBLE, timeout,			\
 		      __ret = schedule_timeout(__ret))
 
-#define swait_event_timeout(wq, condition, timeout)			\
+#define swait_event_timeout_exclusive(wq, condition, timeout)		\
 ({									\
 	long __ret = timeout;						\
 	if (!___wait_cond_timeout(condition))				\
@@ -220,7 +220,7 @@ do {									\
 	___swait_event(wq, condition, TASK_INTERRUPTIBLE, 0,		\
 		      schedule())
 
-#define swait_event_interruptible(wq, condition)			\
+#define swait_event_interruptible_exclusive(wq, condition)		\
 ({									\
 	int __ret = 0;							\
 	if (!(condition))						\
@@ -233,7 +233,7 @@ do {									\
 		      TASK_INTERRUPTIBLE, timeout,			\
 		      __ret = schedule_timeout(__ret))
 
-#define swait_event_interruptible_timeout(wq, condition, timeout)	\
+#define swait_event_interruptible_timeout_exclusive(wq, condition, timeout)\
 ({									\
 	long __ret = timeout;						\
 	if (!___wait_cond_timeout(condition))				\
@@ -246,7 +246,7 @@ do {									\
 	(void)___swait_event(wq, condition, TASK_IDLE, 0, schedule())
 
 /**
- * swait_event_idle - wait without system load contribution
+ * swait_event_idle_exclusive - wait without system load contribution
  * @wq: the waitqueue to wait on
  * @condition: a C expression for the event to wait for
  *
@@ -257,7 +257,7 @@ do {									\
  * condition and doesn't want to contribute to system load. Signals are
  * ignored.
  */
-#define swait_event_idle(wq, condition)					\
+#define swait_event_idle_exclusive(wq, condition)			\
 do {									\
 	if (condition)							\
 		break;							\
@@ -270,7 +270,7 @@ do {									\
 		       __ret = schedule_timeout(__ret))
 
 /**
- * swait_event_idle_timeout - wait up to timeout without load contribution
+ * swait_event_idle_timeout_exclusive - wait up to timeout without load contribution
  * @wq: the waitqueue to wait on
  * @condition: a C expression for the event to wait for
  * @timeout: timeout at which we'll give up in jiffies
@@ -288,7 +288,7 @@ do {									\
  * or the remaining jiffies (at least 1) if the @condition evaluated
  * to %true before the @timeout elapsed.
  */
-#define swait_event_idle_timeout(wq, condition, timeout)		\
+#define swait_event_idle_timeout_exclusive(wq, condition, timeout)	\
 ({									\
 	long __ret = timeout;						\
 	if (!___wait_cond_timeout(condition))				\
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 87331565e505..70178f6ffdc4 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -92,7 +92,7 @@ static void s2idle_enter(void)
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
 	/* Make the current CPU wait so it can enter the idle loop too. */
-	swait_event(s2idle_wait_head,
+	swait_event_exclusive(s2idle_wait_head,
 		    s2idle_state == S2IDLE_STATE_WAKE);
 
 	cpuidle_pause();
@@ -160,7 +160,7 @@ void s2idle_wake(void)
 	raw_spin_lock_irqsave(&s2idle_lock, flags);
 	if (s2idle_state > S2IDLE_STATE_NONE) {
 		s2idle_state = S2IDLE_STATE_WAKE;
-		swake_up(&s2idle_wait_head);
+		swake_up_one(&s2idle_wait_head);
 	}
 	raw_spin_unlock_irqrestore(&s2idle_lock, flags);
 }
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 622792abe41a..04fc2ed71af8 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -110,7 +110,7 @@ void __srcu_read_unlock(struct srcu_struct *sp, int idx)
 
 	WRITE_ONCE(sp->srcu_lock_nesting[idx], newval);
 	if (!newval && READ_ONCE(sp->srcu_gp_waiting))
-		swake_up(&sp->srcu_wq);
+		swake_up_one(&sp->srcu_wq);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
@@ -140,7 +140,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	idx = sp->srcu_idx;
 	WRITE_ONCE(sp->srcu_idx, !sp->srcu_idx);
 	WRITE_ONCE(sp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
-	swait_event(sp->srcu_wq, !READ_ONCE(sp->srcu_lock_nesting[idx]));
+	swait_event_exclusive(sp->srcu_wq, !READ_ONCE(sp->srcu_lock_nesting[idx]));
 	WRITE_ONCE(sp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
 
 	/* Invoke the callbacks we removed above. */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aa7cade1b9f3..91f888d3b23a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1727,7 +1727,7 @@ static void rcu_gp_kthread_wake(struct rcu_state *rsp)
 	    !READ_ONCE(rsp->gp_flags) ||
 	    !rsp->gp_kthread)
 		return;
-	swake_up(&rsp->gp_wq);
+	swake_up_one(&rsp->gp_wq);
 }
 
 /*
@@ -2002,7 +2002,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 }
 
 /*
- * Helper function for swait_event_idle() wakeup at force-quiescent-state
+ * Helper function for swait_event_idle_exclusive() wakeup at force-quiescent-state
  * time.
  */
 static bool rcu_gp_fqs_check_wake(struct rcu_state *rsp, int *gfp)
@@ -2144,7 +2144,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       READ_ONCE(rsp->gpnum),
 					       TPS("reqwait"));
 			rsp->gp_state = RCU_GP_WAIT_GPS;
-			swait_event_idle(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
+			swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
 						     RCU_GP_FLAG_INIT);
 			rsp->gp_state = RCU_GP_DONE_GPS;
 			/* Locking provides needed memory barrier. */
@@ -2176,7 +2176,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       READ_ONCE(rsp->gpnum),
 					       TPS("fqswait"));
 			rsp->gp_state = RCU_GP_WAIT_FQS;
-			ret = swait_event_idle_timeout(rsp->gp_wq,
+			ret = swait_event_idle_timeout_exclusive(rsp->gp_wq,
 					rcu_gp_fqs_check_wake(rsp, &gf), j);
 			rsp->gp_state = RCU_GP_DOING_FQS;
 			/* Locking provides needed memory barriers. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d40708e8c5d6..d428cc1064c8 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -212,7 +212,7 @@ static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			if (wake) {
 				smp_mb(); /* EGP done before wake_up(). */
-				swake_up(&rsp->expedited_wq);
+				swake_up_one(&rsp->expedited_wq);
 			}
 			break;
 		}
@@ -518,7 +518,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 	jiffies_start = jiffies;
 
 	for (;;) {
-		ret = swait_event_timeout(
+		ret = swait_event_timeout_exclusive(
 				rsp->expedited_wq,
 				sync_rcu_preempt_exp_done_unlocked(rnp_root),
 				jiffies_stall);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7fd12039e512..ad53d133f709 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1854,8 +1854,8 @@ static void __wake_nocb_leader(struct rcu_data *rdp, bool force,
 		WRITE_ONCE(rdp_leader->nocb_leader_sleep, false);
 		del_timer(&rdp->nocb_timer);
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
-		smp_mb(); /* ->nocb_leader_sleep before swake_up(). */
-		swake_up(&rdp_leader->nocb_wq);
+		smp_mb(); /* ->nocb_leader_sleep before swake_up_one(). */
+		swake_up_one(&rdp_leader->nocb_wq);
 	} else {
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 	}
@@ -2082,7 +2082,7 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 	 */
 	trace_rcu_this_gp(rnp, rdp, c, TPS("StartWait"));
 	for (;;) {
-		swait_event_interruptible(
+		swait_event_interruptible_exclusive(
 			rnp->nocb_gp_wq[c & 0x1],
 			(d = ULONG_CMP_GE(READ_ONCE(rnp->completed), c)));
 		if (likely(d))
@@ -2111,7 +2111,7 @@ wait_again:
 	/* Wait for callbacks to appear. */
 	if (!rcu_nocb_poll) {
 		trace_rcu_nocb_wake(my_rdp->rsp->name, my_rdp->cpu, TPS("Sleep"));
-		swait_event_interruptible(my_rdp->nocb_wq,
+		swait_event_interruptible_exclusive(my_rdp->nocb_wq,
 				!READ_ONCE(my_rdp->nocb_leader_sleep));
 		raw_spin_lock_irqsave(&my_rdp->nocb_lock, flags);
 		my_rdp->nocb_leader_sleep = true;
@@ -2176,7 +2176,7 @@ wait_again:
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		if (rdp != my_rdp && tail == &rdp->nocb_follower_head) {
 			/* List was empty, so wake up the follower.  */
-			swake_up(&rdp->nocb_wq);
+			swake_up_one(&rdp->nocb_wq);
 		}
 	}
 
@@ -2193,7 +2193,7 @@ static void nocb_follower_wait(struct rcu_data *rdp)
 {
 	for (;;) {
 		trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu, TPS("FollowerSleep"));
-		swait_event_interruptible(rdp->nocb_wq,
+		swait_event_interruptible_exclusive(rdp->nocb_wq,
 					 READ_ONCE(rdp->nocb_follower_head));
 		if (smp_load_acquire(&rdp->nocb_follower_head)) {
 			/* ^^^ Ensure CB invocation follows _head test. */
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 66890de93ee5..66b59ac77c22 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -32,7 +32,7 @@ void swake_up_locked(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_locked);
 
-void swake_up(struct swait_queue_head *q)
+void swake_up_one(struct swait_queue_head *q)
 {
 	unsigned long flags;
 
@@ -40,7 +40,7 @@ void swake_up(struct swait_queue_head *q)
 	swake_up_locked(q);
 	raw_spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL(swake_up);
+EXPORT_SYMBOL(swake_up_one);
 
 /*
  * Does not allow usage from IRQ disabled, since we must be able to
@@ -76,7 +76,7 @@ static void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *w
 		list_add_tail(&wait->task_list, &q->task_list);
 }
 
-void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state)
+void prepare_to_swait_exclusive(struct swait_queue_head *q, struct swait_queue *wait, int state)
 {
 	unsigned long flags;
 
@@ -85,7 +85,7 @@ void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int
 	set_current_state(state);
 	raw_spin_unlock_irqrestore(&q->lock, flags);
 }
-EXPORT_SYMBOL(prepare_to_swait);
+EXPORT_SYMBOL(prepare_to_swait_exclusive);
 
 long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state)
 {
@@ -95,7 +95,7 @@ long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait
 	raw_spin_lock_irqsave(&q->lock, flags);
 	if (unlikely(signal_pending_state(state, current))) {
 		/*
-		 * See prepare_to_wait_event(). TL;DR, subsequent swake_up()
+		 * See prepare_to_wait_event(). TL;DR, subsequent swake_up_one()
 		 * must not see us.
 		 */
 		list_del_init(&wait->task_list);
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 04e554cae3a2..108250e4d376 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -604,7 +604,7 @@ void kvm_arm_resume_guest(struct kvm *kvm)
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		vcpu->arch.pause = false;
-		swake_up(kvm_arch_vcpu_wq(vcpu));
+		swake_up_one(kvm_arch_vcpu_wq(vcpu));
 	}
 }
 
@@ -612,7 +612,7 @@ static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
 {
 	struct swait_queue_head *wq = kvm_arch_vcpu_wq(vcpu);
 
-	swait_event_interruptible(*wq, ((!vcpu->arch.power_off) &&
+	swait_event_interruptible_exclusive(*wq, ((!vcpu->arch.power_off) &&
 				       (!vcpu->arch.pause)));
 
 	if (vcpu->arch.power_off || vcpu->arch.pause) {
diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
index c95ab4c5a475..9b73d3ad918a 100644
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -155,7 +155,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	smp_mb();		/* Make sure the above is visible */
 
 	wq = kvm_arch_vcpu_wq(vcpu);
-	swake_up(wq);
+	swake_up_one(wq);
 
 	return PSCI_RET_SUCCESS;
 }
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 57bcb27dcf30..23c2519c5b32 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -107,7 +107,7 @@ static void async_pf_execute(struct work_struct *work)
 	trace_kvm_async_pf_completed(addr, gva);
 
 	if (swq_has_sleeper(&vcpu->wq))
-		swake_up(&vcpu->wq);
+		swake_up_one(&vcpu->wq);
 
 	mmput(mm);
 	kvm_put_kvm(vcpu->kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ada21f47f22b..940a4aed5b2d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2167,7 +2167,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_blocking(vcpu);
 
 	for (;;) {
-		prepare_to_swait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_swait_exclusive(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
 
 		if (kvm_vcpu_check_block(vcpu) < 0)
 			break;
@@ -2209,7 +2209,7 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 
 	wqp = kvm_arch_vcpu_wq(vcpu);
 	if (swq_has_sleeper(wqp)) {
-		swake_up(wqp);
+		swake_up_one(wqp);
 		++vcpu->stat.halt_wakeup;
 		return true;
 	}
