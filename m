Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C96C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2041B2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2041B2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeH3CT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:19:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727104AbeH3CT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMIhAJ094274
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m627rc13h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:55 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:55 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:49 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKmgx24510494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1008B2068;
        Wed, 29 Aug 2018 18:19:44 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92C0AB2067;
        Wed, 29 Aug 2018 18:19:44 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:44 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0A47716C025C; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt quiescent states when disabled
Date:   Wed, 29 Aug 2018 15:20:30 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0040-0000-0000-0000046756CD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860724;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0041-0000-0000-0000086E70A2
Message-Id: <20180829222047.319-2-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit defers reporting of RCU-preempt quiescent states at
rcu_read_unlock_special() time when any of interrupts, softirq, or
preemption are disabled.  These deferred quiescent states are reported
at a later RCU_SOFTIRQ, context switch, idle entry, or CPU-hotplug
offline operation.  Of course, if another RCU read-side critical
section has started in the meantime, the reporting of the quiescent
state will be further deferred.

This also means that disabling preemption, interrupts, and/or
softirqs will act as an RCU-preempt read-side critical section.
This is enforced by checking preempt_count() as needed.

Some special cases must be handled on an ad-hoc basis, for example,
context switch is a quiescent state even though both the scheduler and
do_exit() disable preemption.  In these cases, additional calls to
rcu_preempt_deferred_qs() override the preemption disabling.  Similar
logic overrides disabled interrupts in rcu_preempt_check_callbacks()
because in this case the quiescent state happened just before the
corresponding scheduling-clock interrupt.

In theory, this change lifts a long-standing restriction that required
that if interrupts were disabled across a call to rcu_read_unlock()
that the matching rcu_read_lock() also be contained within that
interrupts-disabled region of code.  Because the reporting of the
corresponding RCU-preempt quiescent state is now deferred until
after interrupts have been enabled, it is no longer possible for this
situation to result in deadlocks involving the scheduler's runqueue and
priority-inheritance locks.  This may allow some code simplification that
might reduce interrupt latency a bit.  Unfortunately, in practice this
would also defer deboosting a low-priority task that had been subjected
to RCU priority boosting, so real-time-response considerations might
well force this restriction to remain in place.

Because RCU-preempt grace periods are now blocked not only by RCU
read-side critical sections, but also by disabling of interrupts,
preemption, and softirqs, it will be possible to eliminate RCU-bh and
RCU-sched in favor of RCU-preempt in CONFIG_PREEMPT=y kernels.  This may
require some additional plumbing to provide the network denial-of-service
guarantees that have been traditionally provided by RCU-bh.  Once these
are in place, CONFIG_PREEMPT=n kernels will be able to fold RCU-bh
into RCU-sched.  This would mean that all kernels would have but
one flavor of RCU, which would open the door to significant code
cleanup.

Moving to a single flavor of RCU would also have the beneficial effect
of reducing the NOCB kthreads by at least a factor of two.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Apply rcu_read_unlock_special() preempt_count() feedback
  from Joel Fernandes. ]
[ paulmck: Adjust rcu_eqs_enter() call to rcu_preempt_deferred_qs() in
  response to bug reports from kbuild test robot. ]
[ paulmck: Fix bug located by kbuild test robot involving recursion
  via rcu_preempt_deferred_qs(). ]
---
 .../RCU/Design/Requirements/Requirements.html |  50 +++---
 include/linux/rcutiny.h                       |   5 +
 kernel/rcu/tree.c                             |   9 ++
 kernel/rcu/tree.h                             |   3 +
 kernel/rcu/tree_exp.h                         |  71 +++++++--
 kernel/rcu/tree_plugin.h                      | 144 +++++++++++++-----
 6 files changed, 205 insertions(+), 77 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 49690228b1c6..038714475edb 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2394,30 +2394,9 @@ when invoked from a CPU-hotplug notifier.
 <p>
 RCU depends on the scheduler, and the scheduler uses RCU to
 protect some of its data structures.
-This means the scheduler is forbidden from acquiring
-the runqueue locks and the priority-inheritance locks
-in the middle of an outermost RCU read-side critical section unless either
-(1)&nbsp;it releases them before exiting that same
-RCU read-side critical section, or
-(2)&nbsp;interrupts are disabled across
-that entire RCU read-side critical section.
-This same prohibition also applies (recursively!) to any lock that is acquired
-while holding any lock to which this prohibition applies.
-Adhering to this rule prevents preemptible RCU from invoking
-<tt>rcu_read_unlock_special()</tt> while either runqueue or
-priority-inheritance locks are held, thus avoiding deadlock.
-
-<p>
-Prior to v4.4, it was only necessary to disable preemption across
-RCU read-side critical sections that acquired scheduler locks.
-In v4.4, expedited grace periods started using IPIs, and these
-IPIs could force a <tt>rcu_read_unlock()</tt> to take the slowpath.
-Therefore, this expedited-grace-period change required disabling of
-interrupts, not just preemption.
-
-<p>
-For RCU's part, the preemptible-RCU <tt>rcu_read_unlock()</tt>
-implementation must be written carefully to avoid similar deadlocks.
+The preemptible-RCU <tt>rcu_read_unlock()</tt>
+implementation must therefore be written carefully to avoid deadlocks
+involving the scheduler's runqueue and priority-inheritance locks.
 In particular, <tt>rcu_read_unlock()</tt> must tolerate an
 interrupt where the interrupt handler invokes both
 <tt>rcu_read_lock()</tt> and <tt>rcu_read_unlock()</tt>.
@@ -2426,7 +2405,7 @@ negative nesting levels to avoid destructive recursion via
 interrupt handler's use of RCU.
 
 <p>
-This pair of mutual scheduler-RCU requirements came as a
+This scheduler-RCU requirement came as a
 <a href="https://lwn.net/Articles/453002/">complete surprise</a>.
 
 <p>
@@ -2437,9 +2416,28 @@ when running context-switch-heavy workloads when built with
 <tt>CONFIG_NO_HZ_FULL=y</tt>
 <a href="http://www.rdrop.com/users/paulmck/scalability/paper/BareMetal.2015.01.15b.pdf">did come as a surprise [PDF]</a>.
 RCU has made good progress towards meeting this requirement, even
-for context-switch-have <tt>CONFIG_NO_HZ_FULL=y</tt> workloads,
+for context-switch-heavy <tt>CONFIG_NO_HZ_FULL=y</tt> workloads,
 but there is room for further improvement.
 
+<p>
+In the past, it was forbidden to disable interrupts across an
+<tt>rcu_read_unlock()</tt> unless that interrupt-disabled region
+of code also included the matching <tt>rcu_read_lock()</tt>.
+Violating this restriction could result in deadlocks involving the
+scheduler's runqueue and priority-inheritance spinlocks.
+This restriction was lifted when interrupt-disabled calls to
+<tt>rcu_read_unlock()</tt> started deferring the reporting of
+the resulting RCU-preempt quiescent state until the end of that
+interrupts-disabled region.
+This deferred reporting means that the scheduler's runqueue and
+priority-inheritance locks cannot be held while reporting an RCU-preempt
+quiescent state, which lifts the earlier restriction, at least from
+a deadlock perspective.
+Unfortunately, real-time systems using RCU priority boosting may
+need this restriction to remain in effect because deferred
+quiescent-state reporting also defers deboosting, which in turn
+degrades real-time latencies.
+
 <h3><a name="Tracing and RCU">Tracing and RCU</a></h3>
 
 <p>
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 8d9a0ea8f0b5..f617ab19bb51 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -115,6 +115,11 @@ static inline void rcu_irq_exit_irqson(void) { }
 static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void exit_rcu(void) { }
+static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
+{
+	return false;
+}
+static inline void rcu_preempt_deferred_qs(struct task_struct *t) { }
 #ifdef CONFIG_SRCU
 void rcu_scheduler_starting(void);
 #else /* #ifndef CONFIG_SRCU */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0adf77923e8b..dc041c2afbcc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -422,6 +422,7 @@ static void rcu_momentary_dyntick_idle(void)
 	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR, &rdtp->dynticks);
 	/* It is illegal to call this from idle state. */
 	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
+	rcu_preempt_deferred_qs(current);
 }
 
 /*
@@ -729,6 +730,7 @@ static void rcu_eqs_enter(bool user)
 		do_nocb_deferred_wakeup(rdp);
 	}
 	rcu_prepare_for_idle();
+	rcu_preempt_deferred_qs(current);
 	WRITE_ONCE(rdtp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
 	rcu_dynticks_eqs_enter();
 	rcu_dynticks_task_enter();
@@ -2849,6 +2851,12 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 
 	WARN_ON_ONCE(!rdp->beenonline);
 
+	/* Report any deferred quiescent states if preemption enabled. */
+	if (!(preempt_count() & PREEMPT_MASK))
+		rcu_preempt_deferred_qs(current);
+	else if (rcu_preempt_need_deferred_qs(current))
+		resched_cpu(rdp->cpu); /* Provoke future context switch. */
+
 	/* Update RCU state based on any recent quiescent states. */
 	rcu_check_quiescent_state(rsp, rdp);
 
@@ -3822,6 +3830,7 @@ void rcu_report_dead(unsigned int cpu)
 	rcu_report_exp_rdp(&rcu_sched_state,
 			   this_cpu_ptr(rcu_sched_state.rda), true);
 	preempt_enable();
+	rcu_preempt_deferred_qs(current);
 	for_each_rcu_flavor(rsp)
 		rcu_cleanup_dying_idle_cpu(cpu, rsp);
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4e74df768c57..025bd2e5592b 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -195,6 +195,7 @@ struct rcu_data {
 	bool		core_needs_qs;	/* Core waits for quiesc state. */
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
+	bool		deferred_qs;	/* This CPU awaiting a deferred QS? */
 	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
 	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
 	unsigned long	ticks_this_gp;	/* The number of scheduling-clock */
@@ -461,6 +462,8 @@ static void rcu_cleanup_after_idle(void);
 static void rcu_prepare_for_idle(void);
 static void rcu_idle_count_callbacks_posted(void);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
+static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
+static void rcu_preempt_deferred_qs(struct task_struct *t);
 static void print_cpu_stall_info_begin(void);
 static void print_cpu_stall_info(struct rcu_state *rsp, int cpu);
 static void print_cpu_stall_info_end(void);
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 0b2c2ad69629..f9d5bbd8adce 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -262,6 +262,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_state *rsp, struct rcu_node *rnp,
 static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp,
 			       bool wake)
 {
+	WRITE_ONCE(rdp->deferred_qs, false);
 	rcu_report_exp_cpu_mult(rsp, rdp->mynode, rdp->grpmask, wake);
 }
 
@@ -735,32 +736,70 @@ EXPORT_SYMBOL_GPL(synchronize_sched_expedited);
  */
 static void sync_rcu_exp_handler(void *info)
 {
-	struct rcu_data *rdp;
+	unsigned long flags;
 	struct rcu_state *rsp = info;
+	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
+	struct rcu_node *rnp = rdp->mynode;
 	struct task_struct *t = current;
 
 	/*
-	 * Within an RCU read-side critical section, request that the next
-	 * rcu_read_unlock() report.  Unless this RCU read-side critical
-	 * section has already blocked, in which case it is already set
-	 * up for the expedited grace period to wait on it.
+	 * First, the common case of not being in an RCU read-side
+	 * critical section.  If also enabled or idle, immediately
+	 * report the quiescent state, otherwise defer.
 	 */
-	if (t->rcu_read_lock_nesting > 0 &&
-	    !t->rcu_read_unlock_special.b.blocked) {
-		t->rcu_read_unlock_special.b.exp_need_qs = true;
+	if (!t->rcu_read_lock_nesting) {
+		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
+		    rcu_dynticks_curr_cpu_in_eqs()) {
+			rcu_report_exp_rdp(rsp, rdp, true);
+		} else {
+			rdp->deferred_qs = true;
+			resched_cpu(rdp->cpu);
+		}
 		return;
 	}
 
 	/*
-	 * We are either exiting an RCU read-side critical section (negative
-	 * values of t->rcu_read_lock_nesting) or are not in one at all
-	 * (zero value of t->rcu_read_lock_nesting).  Or we are in an RCU
-	 * read-side critical section that blocked before this expedited
-	 * grace period started.  Either way, we can immediately report
-	 * the quiescent state.
+	 * Second, the less-common case of being in an RCU read-side
+	 * critical section.  In this case we can count on a future
+	 * rcu_read_unlock().  However, this rcu_read_unlock() might
+	 * execute on some other CPU, but in that case there will be
+	 * a future context switch.  Either way, if the expedited
+	 * grace period is still waiting on this CPU, set ->deferred_qs
+	 * so that the eventual quiescent state will be reported.
+	 * Note that there is a large group of race conditions that
+	 * can have caused this quiescent state to already have been
+	 * reported, so we really do need to check ->expmask.
 	 */
-	rdp = this_cpu_ptr(rsp->rda);
-	rcu_report_exp_rdp(rsp, rdp, true);
+	if (t->rcu_read_lock_nesting > 0) {
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+		if (rnp->expmask & rdp->grpmask)
+			rdp->deferred_qs = true;
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	}
+
+	/*
+	 * The final and least likely case is where the interrupted
+	 * code was just about to or just finished exiting the RCU-preempt
+	 * read-side critical section, and no, we can't tell which.
+	 * So either way, set ->deferred_qs to flag later code that
+	 * a quiescent state is required.
+	 *
+	 * If the CPU is fully enabled (or if some buggy RCU-preempt
+	 * read-side critical section is being used from idle), just
+	 * invoke rcu_preempt_defer_qs() to immediately report the
+	 * quiescent state.  We cannot use rcu_read_unlock_special()
+	 * because we are in an interrupt handler, which will cause that
+	 * function to take an early exit without doing anything.
+	 *
+	 * Otherwise, use resched_cpu() to force a context switch after
+	 * the CPU enables everything.
+	 */
+	rdp->deferred_qs = true;
+	if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
+	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs()))
+		rcu_preempt_deferred_qs(t);
+	else
+		resched_cpu(rdp->cpu);
 }
 
 /**
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index a97c20ea9bce..542791361908 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -371,6 +371,9 @@ static void rcu_preempt_note_context_switch(bool preempt)
 		 * behalf of preempted instance of __rcu_read_unlock().
 		 */
 		rcu_read_unlock_special(t);
+		rcu_preempt_deferred_qs(t);
+	} else {
+		rcu_preempt_deferred_qs(t);
 	}
 
 	/*
@@ -464,54 +467,51 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
 }
 
 /*
- * Handle special cases during rcu_read_unlock(), such as needing to
- * notify RCU core processing or task having blocked during the RCU
- * read-side critical section.
+ * Report deferred quiescent states.  The deferral time can
+ * be quite short, for example, in the case of the call from
+ * rcu_read_unlock_special().
  */
-static void rcu_read_unlock_special(struct task_struct *t)
+static void
+rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 {
 	bool empty_exp;
 	bool empty_norm;
 	bool empty_exp_now;
-	unsigned long flags;
 	struct list_head *np;
 	bool drop_boost_mutex = false;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	union rcu_special special;
 
-	/* NMI handlers cannot block and cannot safely manipulate state. */
-	if (in_nmi())
-		return;
-
-	local_irq_save(flags);
-
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
 	 * report the fact that it has exited.  Because irqs are disabled,
 	 * t->rcu_read_unlock_special cannot change.
 	 */
 	special = t->rcu_read_unlock_special;
+	rdp = this_cpu_ptr(rcu_state_p->rda);
+	if (!special.s && !rdp->deferred_qs) {
+		local_irq_restore(flags);
+		return;
+	}
 	if (special.b.need_qs) {
 		rcu_preempt_qs();
 		t->rcu_read_unlock_special.b.need_qs = false;
-		if (!t->rcu_read_unlock_special.s) {
+		if (!t->rcu_read_unlock_special.s && !rdp->deferred_qs) {
 			local_irq_restore(flags);
 			return;
 		}
 	}
 
 	/*
-	 * Respond to a request for an expedited grace period, but only if
-	 * we were not preempted, meaning that we were running on the same
-	 * CPU throughout.  If we were preempted, the exp_need_qs flag
-	 * would have been cleared at the time of the first preemption,
-	 * and the quiescent state would be reported when we were dequeued.
+	 * Respond to a request by an expedited grace period for a
+	 * quiescent state from this CPU.  Note that requests from
+	 * tasks are handled when removing the task from the
+	 * blocked-tasks list below.
 	 */
-	if (special.b.exp_need_qs) {
-		WARN_ON_ONCE(special.b.blocked);
+	if (special.b.exp_need_qs || rdp->deferred_qs) {
 		t->rcu_read_unlock_special.b.exp_need_qs = false;
-		rdp = this_cpu_ptr(rcu_state_p->rda);
+		rdp->deferred_qs = false;
 		rcu_report_exp_rdp(rcu_state_p, rdp, true);
 		if (!t->rcu_read_unlock_special.s) {
 			local_irq_restore(flags);
@@ -519,19 +519,6 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		}
 	}
 
-	/* Hardware IRQ handlers cannot block, complain if they get here. */
-	if (in_irq() || in_serving_softirq()) {
-		lockdep_rcu_suspicious(__FILE__, __LINE__,
-				       "rcu_read_unlock() from irq or softirq with blocking in critical section!!!\n");
-		pr_alert("->rcu_read_unlock_special: %#x (b: %d, enq: %d nq: %d)\n",
-			 t->rcu_read_unlock_special.s,
-			 t->rcu_read_unlock_special.b.blocked,
-			 t->rcu_read_unlock_special.b.exp_need_qs,
-			 t->rcu_read_unlock_special.b.need_qs);
-		local_irq_restore(flags);
-		return;
-	}
-
 	/* Clean up if blocked during RCU read-side critical section. */
 	if (special.b.blocked) {
 		t->rcu_read_unlock_special.b.blocked = false;
@@ -602,6 +589,72 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	}
 }
 
+/*
+ * Is a deferred quiescent-state pending, and are we also not in
+ * an RCU read-side critical section?  It is the caller's responsibility
+ * to ensure it is otherwise safe to report any deferred quiescent
+ * states.  The reason for this is that it is safe to report a
+ * quiescent state during context switch even though preemption
+ * is disabled.  This function cannot be expected to understand these
+ * nuances, so the caller must handle them.
+ */
+static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
+{
+	return (this_cpu_ptr(&rcu_preempt_data)->deferred_qs ||
+		READ_ONCE(t->rcu_read_unlock_special.s)) &&
+	       !t->rcu_read_lock_nesting;
+}
+
+/*
+ * Report a deferred quiescent state if needed and safe to do so.
+ * As with rcu_preempt_need_deferred_qs(), "safe" involves only
+ * not being in an RCU read-side critical section.  The caller must
+ * evaluate safety in terms of interrupt, softirq, and preemption
+ * disabling.
+ */
+static void rcu_preempt_deferred_qs(struct task_struct *t)
+{
+	unsigned long flags;
+	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
+
+	if (!rcu_preempt_need_deferred_qs(t))
+		return;
+	if (couldrecurse)
+		t->rcu_read_lock_nesting -= INT_MIN;
+	local_irq_save(flags);
+	rcu_preempt_deferred_qs_irqrestore(t, flags);
+	if (couldrecurse)
+		t->rcu_read_lock_nesting += INT_MIN;
+}
+
+/*
+ * Handle special cases during rcu_read_unlock(), such as needing to
+ * notify RCU core processing or task having blocked during the RCU
+ * read-side critical section.
+ */
+static void rcu_read_unlock_special(struct task_struct *t)
+{
+	unsigned long flags;
+	bool preempt_bh_were_disabled =
+			!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
+	bool irqs_were_disabled;
+
+	/* NMI handlers cannot block and cannot safely manipulate state. */
+	if (in_nmi())
+		return;
+
+	local_irq_save(flags);
+	irqs_were_disabled = irqs_disabled_flags(flags);
+	if ((preempt_bh_were_disabled || irqs_were_disabled) &&
+	    t->rcu_read_unlock_special.b.blocked) {
+		/* Need to defer quiescent state until everything is enabled. */
+		raise_softirq_irqoff(RCU_SOFTIRQ);
+		local_irq_restore(flags);
+		return;
+	}
+	rcu_preempt_deferred_qs_irqrestore(t, flags);
+}
+
 /*
  * Dump detailed information for all tasks blocking the current RCU
  * grace period on the specified rcu_node structure.
@@ -737,10 +790,20 @@ static void rcu_preempt_check_callbacks(void)
 	struct rcu_state *rsp = &rcu_preempt_state;
 	struct task_struct *t = current;
 
-	if (t->rcu_read_lock_nesting == 0) {
-		rcu_preempt_qs();
+	if (t->rcu_read_lock_nesting > 0 ||
+	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
+		/* No QS, force context switch if deferred. */
+		if (rcu_preempt_need_deferred_qs(t))
+			resched_cpu(smp_processor_id());
+	} else if (rcu_preempt_need_deferred_qs(t)) {
+		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
+		return;
+	} else if (!t->rcu_read_lock_nesting) {
+		rcu_preempt_qs(); /* Report immediate QS. */
 		return;
 	}
+
+	/* If GP is oldish, ask for help from rcu_read_unlock_special(). */
 	if (t->rcu_read_lock_nesting > 0 &&
 	    __this_cpu_read(rcu_data_p->core_needs_qs) &&
 	    __this_cpu_read(rcu_data_p->cpu_no_qs.b.norm) &&
@@ -859,6 +922,7 @@ void exit_rcu(void)
 	barrier();
 	t->rcu_read_unlock_special.b.blocked = true;
 	__rcu_read_unlock();
+	rcu_preempt_deferred_qs(current);
 }
 
 /*
@@ -940,6 +1004,16 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
 	return false;
 }
 
+/*
+ * Because there is no preemptible RCU, there can be no deferred quiescent
+ * states.
+ */
+static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
+{
+	return false;
+}
+static void rcu_preempt_deferred_qs(struct task_struct *t) { }
+
 /*
  * Because preemptible RCU does not exist, we never have to check for
  * tasks blocked within RCU read-side critical sections.
-- 
2.17.1

