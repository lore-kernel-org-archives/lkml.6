Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C24C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA726206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA726206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeH3CT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:19:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727346AbeH3CT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMIiXj038595
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m62g7ub19-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:55 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:55 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKn8F36569272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58B4CB2067;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B548B2072;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4F6CD16C91D4; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH tip/core/rcu 13/19] rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds
Date:   Wed, 29 Aug 2018 15:20:41 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0072-0000-0000-000003996712
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860724;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0073-0000-0000-0000493EAB56
Message-Id: <20180829222047.319-13-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that RCU-preempt knows about preemption disabling, its implementation
of synchronize_rcu() works for synchronize_sched(), and likewise for the
other RCU-sched update-side API members.  This commit therefore confines
the RCU-sched update-side code to CONFIG_PREEMPT=n builds, and defines
RCU-sched's update-side API members in terms of those of RCU-preempt.

This means that any given build of the Linux kernel has only one
update-side flavor of RCU, namely RCU-preempt for CONFIG_PREEMPT=y builds
and RCU-sched for CONFIG_PREEMPT=n builds.  This in turn means that kernels
built with CONFIG_RCU_NOCB_CPU=y have only one rcuo kthread per CPU.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 include/linux/rcupdate.h |  14 +-
 include/linux/rcutiny.h  |   7 +
 include/linux/rcutree.h  |   7 +-
 kernel/rcu/tree.c        | 301 +++++++++++++--------------------------
 kernel/rcu/tree.h        |   9 +-
 kernel/rcu/tree_exp.h    | 153 ++++++++++----------
 kernel/rcu/tree_plugin.h | 297 ++++++++++++++------------------------
 7 files changed, 308 insertions(+), 480 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 8d5740edd63c..94474bb6b5c4 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -49,11 +49,11 @@
 
 /* Exported common interfaces */
 
-#ifdef CONFIG_PREEMPT_RCU
-void call_rcu(struct rcu_head *head, rcu_callback_t func);
-#else /* #ifdef CONFIG_PREEMPT_RCU */
+#ifdef CONFIG_TINY_RCU
 #define	call_rcu	call_rcu_sched
-#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
+#else
+void call_rcu(struct rcu_head *head, rcu_callback_t func);
+#endif
 
 void call_rcu_sched(struct rcu_head *head, rcu_callback_t func);
 void synchronize_sched(void);
@@ -92,11 +92,6 @@ static inline void __rcu_read_unlock(void)
 		preempt_enable();
 }
 
-static inline void synchronize_rcu(void)
-{
-	synchronize_sched();
-}
-
 static inline int rcu_preempt_depth(void)
 {
 	return 0;
@@ -107,7 +102,6 @@ static inline int rcu_preempt_depth(void)
 /* Internal to kernel */
 void rcu_init(void);
 extern int rcu_scheduler_active __read_mostly;
-void rcu_sched_qs(void);
 void rcu_check_callbacks(int user);
 void rcu_report_dead(unsigned int cpu);
 void rcutree_migrate_callbacks(int cpu);
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index ac26c27ccde8..df2c0895c5e7 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -36,6 +36,11 @@ static inline int rcu_dynticks_snap(struct rcu_dynticks *rdtp)
 /* Never flag non-existent other CPUs! */
 static inline bool rcu_eqs_special_set(int cpu) { return false; }
 
+static inline void synchronize_rcu(void)
+{
+	synchronize_sched();
+}
+
 static inline unsigned long get_state_synchronize_rcu(void)
 {
 	return 0;
@@ -94,6 +99,8 @@ static inline void kfree_call_rcu(struct rcu_head *head,
 	call_rcu(head, func);
 }
 
+void rcu_sched_qs(void);
+
 static inline void rcu_softirq_qs(void)
 {
 	rcu_sched_qs();
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index f7a41323aa54..0c44720f0e84 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -45,14 +45,19 @@ static inline void rcu_virt_note_context_switch(int cpu)
 	rcu_note_context_switch(false);
 }
 
+void synchronize_rcu(void);
 static inline void synchronize_rcu_bh(void)
 {
 	synchronize_rcu();
 }
 
-void synchronize_sched_expedited(void);
 void synchronize_rcu_expedited(void);
 
+static inline void synchronize_sched_expedited(void)
+{
+	synchronize_rcu_expedited();
+}
+
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 /**
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5cc035dc61cb..a8965a7caf25 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -92,24 +92,29 @@ static const char *tp_##sname##_varname __used __tracepoint_string = sname##_var
 
 #define RCU_STATE_INITIALIZER(sname, sabbr, cr) \
 DEFINE_RCU_TPS(sname) \
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, sname##_data); \
-struct rcu_state sname##_state = { \
-	.level = { &sname##_state.node[0] }, \
-	.rda = &sname##_data, \
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data); \
+struct rcu_state rcu_state = { \
+	.level = { &rcu_state.node[0] }, \
+	.rda = &rcu_data, \
 	.call = cr, \
 	.gp_state = RCU_GP_IDLE, \
 	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT, \
-	.barrier_mutex = __MUTEX_INITIALIZER(sname##_state.barrier_mutex), \
+	.barrier_mutex = __MUTEX_INITIALIZER(rcu_state.barrier_mutex), \
 	.name = RCU_STATE_NAME(sname), \
 	.abbr = sabbr, \
-	.exp_mutex = __MUTEX_INITIALIZER(sname##_state.exp_mutex), \
-	.exp_wake_mutex = __MUTEX_INITIALIZER(sname##_state.exp_wake_mutex), \
-	.ofl_lock = __SPIN_LOCK_UNLOCKED(sname##_state.ofl_lock), \
+	.exp_mutex = __MUTEX_INITIALIZER(rcu_state.exp_mutex), \
+	.exp_wake_mutex = __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex), \
+	.ofl_lock = __SPIN_LOCK_UNLOCKED(rcu_state.ofl_lock), \
 }
 
-RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu_sched);
+#ifdef CONFIG_PREEMPT_RCU
+RCU_STATE_INITIALIZER(rcu_preempt, 'p', call_rcu);
+#else
+RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu);
+#endif
 
-static struct rcu_state *const rcu_state_p;
+static struct rcu_state *const rcu_state_p = &rcu_state;
+static struct rcu_data __percpu *const rcu_data_p = &rcu_data;
 LIST_HEAD(rcu_struct_flavors);
 
 /* Dump rcu_node combining tree at boot to verify correct setup. */
@@ -220,31 +225,9 @@ static int rcu_gp_in_progress(struct rcu_state *rsp)
 	return rcu_seq_state(rcu_seq_current(&rsp->gp_seq));
 }
 
-/*
- * Note a quiescent state.  Because we do not need to know
- * how many quiescent states passed, just if there was at least
- * one since the start of the grace period, this just sets a flag.
- * The caller must have disabled preemption.
- */
-void rcu_sched_qs(void)
-{
-	RCU_LOCKDEP_WARN(preemptible(), "rcu_sched_qs() invoked with preemption enabled!!!");
-	if (!__this_cpu_read(rcu_sched_data.cpu_no_qs.s))
-		return;
-	trace_rcu_grace_period(TPS("rcu_sched"),
-			       __this_cpu_read(rcu_sched_data.gp_seq),
-			       TPS("cpuqs"));
-	__this_cpu_write(rcu_sched_data.cpu_no_qs.b.norm, false);
-	if (!__this_cpu_read(rcu_sched_data.cpu_no_qs.b.exp))
-		return;
-	__this_cpu_write(rcu_sched_data.cpu_no_qs.b.exp, false);
-	rcu_report_exp_rdp(&rcu_sched_state, this_cpu_ptr(&rcu_sched_data));
-}
-
 void rcu_softirq_qs(void)
 {
-	rcu_sched_qs();
-	rcu_preempt_qs();
+	rcu_qs();
 	rcu_preempt_deferred_qs(current);
 }
 
@@ -418,31 +401,18 @@ static void rcu_momentary_dyntick_idle(void)
 	rcu_preempt_deferred_qs(current);
 }
 
-/*
- * Note a context switch.  This is a quiescent state for RCU-sched,
- * and requires special handling for preemptible RCU.
- * The caller must have disabled interrupts.
+/**
+ * rcu_is_cpu_rrupt_from_idle - see if idle or immediately interrupted from idle
+ *
+ * If the current CPU is idle or running at a first-level (not nested)
+ * interrupt from idle, return true.  The caller must have at least
+ * disabled preemption.
  */
-void rcu_note_context_switch(bool preempt)
+static int rcu_is_cpu_rrupt_from_idle(void)
 {
-	barrier(); /* Avoid RCU read-side critical sections leaking down. */
-	trace_rcu_utilization(TPS("Start context switch"));
-	rcu_sched_qs();
-	rcu_preempt_note_context_switch(preempt);
-	/* Load rcu_urgent_qs before other flags. */
-	if (!smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs)))
-		goto out;
-	this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
-	if (unlikely(raw_cpu_read(rcu_dynticks.rcu_need_heavy_qs)))
-		rcu_momentary_dyntick_idle();
-	this_cpu_inc(rcu_dynticks.rcu_qs_ctr);
-	if (!preempt)
-		rcu_tasks_qs(current);
-out:
-	trace_rcu_utilization(TPS("End context switch"));
-	barrier(); /* Avoid RCU read-side critical sections leaking up. */
+	return __this_cpu_read(rcu_dynticks.dynticks_nesting) <= 0 &&
+	       __this_cpu_read(rcu_dynticks.dynticks_nmi_nesting) <= 1;
 }
-EXPORT_SYMBOL_GPL(rcu_note_context_switch);
 
 /*
  * Register a quiescent state for all RCU flavors.  If there is an
@@ -476,8 +446,8 @@ void rcu_all_qs(void)
 		rcu_momentary_dyntick_idle();
 		local_irq_restore(flags);
 	}
-	if (unlikely(raw_cpu_read(rcu_sched_data.cpu_no_qs.b.exp)))
-		rcu_sched_qs();
+	if (unlikely(raw_cpu_read(rcu_data.cpu_no_qs.b.exp)))
+		rcu_qs();
 	this_cpu_inc(rcu_dynticks.rcu_qs_ctr);
 	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 	preempt_enable();
@@ -558,7 +528,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_seq);
  */
 unsigned long rcu_sched_get_gp_seq(void)
 {
-	return READ_ONCE(rcu_sched_state.gp_seq);
+	return rcu_get_gp_seq();
 }
 EXPORT_SYMBOL_GPL(rcu_sched_get_gp_seq);
 
@@ -590,7 +560,7 @@ EXPORT_SYMBOL_GPL(rcu_exp_batches_completed);
  */
 unsigned long rcu_exp_batches_completed_sched(void)
 {
-	return rcu_sched_state.expedited_sequence;
+	return rcu_state.expedited_sequence;
 }
 EXPORT_SYMBOL_GPL(rcu_exp_batches_completed_sched);
 
@@ -617,7 +587,7 @@ EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
  */
 void rcu_sched_force_quiescent_state(void)
 {
-	force_quiescent_state(&rcu_sched_state);
+	rcu_force_quiescent_state();
 }
 EXPORT_SYMBOL_GPL(rcu_sched_force_quiescent_state);
 
@@ -668,10 +638,8 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 	switch (test_type) {
 	case RCU_FLAVOR:
 	case RCU_BH_FLAVOR:
-		rsp = rcu_state_p;
-		break;
 	case RCU_SCHED_FLAVOR:
-		rsp = &rcu_sched_state;
+		rsp = rcu_state_p;
 		break;
 	default:
 		break;
@@ -1106,19 +1074,6 @@ EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
 
 #endif /* #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU) */
 
-/**
- * rcu_is_cpu_rrupt_from_idle - see if idle or immediately interrupted from idle
- *
- * If the current CPU is idle or running at a first-level (not nested)
- * interrupt from idle, return true.  The caller must have at least
- * disabled preemption.
- */
-static int rcu_is_cpu_rrupt_from_idle(void)
-{
-	return __this_cpu_read(rcu_dynticks.dynticks_nesting) <= 0 &&
-	       __this_cpu_read(rcu_dynticks.dynticks_nmi_nesting) <= 1;
-}
-
 /*
  * We are reporting a quiescent state on behalf of some other CPU, so
  * it is our responsibility to check for and handle potential overflow
@@ -2363,7 +2318,7 @@ rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
 	struct rcu_node *rnp_p;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (WARN_ON_ONCE(rcu_state_p == &rcu_sched_state) ||
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT)) ||
 	    WARN_ON_ONCE(rsp != rcu_state_p) ||
 	    WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)) ||
 	    rnp->qsmask != 0) {
@@ -2649,25 +2604,7 @@ void rcu_check_callbacks(int user)
 {
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
 	increment_cpu_stall_ticks();
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
-
-		/*
-		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
-		 *
-		 * No memory barrier is required here because
-		 * rcu_sched_qs() references only CPU-local variables
-		 * that other CPUs neither access nor modify, at least
-		 * not while the corresponding CPU is online.
-		 */
-
-		rcu_sched_qs();
-		rcu_note_voluntary_context_switch(current);
-
-	}
-	rcu_preempt_check_callbacks();
+	rcu_flavor_check_callbacks(user);
 	if (rcu_pending())
 		invoke_rcu_core();
 
@@ -2693,7 +2630,7 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
 		mask = 0;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->qsmask == 0) {
-			if (rcu_state_p == &rcu_sched_state ||
+			if (!IS_ENABLED(CONFIG_PREEMPT) ||
 			    rsp != rcu_state_p ||
 			    rcu_preempt_blocked_readers_cgp(rnp)) {
 				/*
@@ -3027,28 +2964,56 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func,
 }
 
 /**
- * call_rcu_sched() - Queue an RCU for invocation after sched grace period.
+ * call_rcu() - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
  * @func: actual callback function to be invoked after the grace period
  *
  * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_sched() assumes
- * that the read-side critical sections end on enabling of preemption
- * or on voluntary preemption.
- * RCU read-side critical sections are delimited by:
- *
- * - rcu_read_lock_sched() and rcu_read_unlock_sched(), OR
- * - anything that disables preemption.
- *
- *  These may be nested.
+ * period elapses, in other words after all pre-existing RCU read-side
+ * critical sections have completed.  However, the callback function
+ * might well execute concurrently with RCU read-side critical sections
+ * that started after call_rcu() was invoked.  RCU read-side critical
+ * sections are delimited by rcu_read_lock() and rcu_read_unlock(), and
+ * may be nested.  In addition, regions of code across which interrupts,
+ * preemption, or softirqs have been disabled also serve as RCU read-side
+ * critical sections.  This includes hardware interrupt handlers, softirq
+ * handlers, and NMI handlers.
+ *
+ * Note that all CPUs must agree that the grace period extended beyond
+ * all pre-existing RCU read-side critical section.  On systems with more
+ * than one CPU, this means that when "func()" is invoked, each CPU is
+ * guaranteed to have executed a full memory barrier since the end of its
+ * last RCU read-side critical section whose beginning preceded the call
+ * to call_rcu().  It also means that each CPU executing an RCU read-side
+ * critical section that continues beyond the start of "func()" must have
+ * executed a memory barrier after the call_rcu() but before the beginning
+ * of that RCU read-side critical section.  Note that these guarantees
+ * include CPUs that are offline, idle, or executing in user mode, as
+ * well as CPUs that are executing in the kernel.
+ *
+ * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
+ * resulting RCU callback function "func()", then both CPU A and CPU B are
+ * guaranteed to execute a full memory barrier during the time interval
+ * between the call to call_rcu() and the invocation of "func()" -- even
+ * if CPU A and CPU B are the same CPU (but again only if the system has
+ * more than one CPU).
+ */
+void call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	__call_rcu(head, func, rcu_state_p, -1, 0);
+}
+EXPORT_SYMBOL_GPL(call_rcu);
+
+/**
+ * call_rcu_sched() - Queue an RCU for invocation after sched grace period.
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
  *
- * See the description of call_rcu() for more detailed information on
- * memory ordering guarantees.
+ * This is transitional.
  */
 void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu(head, func, &rcu_sched_state, -1, 0);
+	call_rcu(head, func);
 }
 EXPORT_SYMBOL_GPL(call_rcu_sched);
 
@@ -3066,73 +3031,14 @@ void kfree_call_rcu(struct rcu_head *head,
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
-/*
- * Because a context switch is a grace period for RCU-sched, any blocking
- * grace-period wait automatically implies a grace period if there
- * is only one CPU online at any point time during execution of either
- * synchronize_sched() or synchronize_rcu_bh().  It is OK to occasionally
- * incorrectly indicate that there are multiple CPUs online when there
- * was in fact only one the whole time, as this just adds some overhead:
- * RCU still operates correctly.
- */
-static int rcu_blocking_is_gp(void)
-{
-	int ret;
-
-	might_sleep();  /* Check for RCU read-side critical section. */
-	preempt_disable();
-	ret = num_online_cpus() <= 1;
-	preempt_enable();
-	return ret;
-}
-
 /**
  * synchronize_sched - wait until an rcu-sched grace period has elapsed.
  *
- * Control will return to the caller some time after a full rcu-sched
- * grace period has elapsed, in other words after all currently executing
- * rcu-sched read-side critical sections have completed.   These read-side
- * critical sections are delimited by rcu_read_lock_sched() and
- * rcu_read_unlock_sched(), and may be nested.  Note that preempt_disable(),
- * local_irq_disable(), and so on may be used in place of
- * rcu_read_lock_sched().
- *
- * This means that all preempt_disable code sequences, including NMI and
- * non-threaded hardware-interrupt handlers, in progress on entry will
- * have completed before this primitive returns.  However, this does not
- * guarantee that softirq handlers will have completed, since in some
- * kernels, these handlers can run in process context, and can block.
- *
- * Note that this guarantee implies further memory-ordering guarantees.
- * On systems with more than one CPU, when synchronize_sched() returns,
- * each CPU is guaranteed to have executed a full memory barrier since the
- * end of its last RCU-sched read-side critical section whose beginning
- * preceded the call to synchronize_sched().  In addition, each CPU having
- * an RCU read-side critical section that extends beyond the return from
- * synchronize_sched() is guaranteed to have executed a full memory barrier
- * after the beginning of synchronize_sched() and before the beginning of
- * that RCU read-side critical section.  Note that these guarantees include
- * CPUs that are offline, idle, or executing in user mode, as well as CPUs
- * that are executing in the kernel.
- *
- * Furthermore, if CPU A invoked synchronize_sched(), which returned
- * to its caller on CPU B, then both CPU A and CPU B are guaranteed
- * to have executed a full memory barrier during the execution of
- * synchronize_sched() -- even if CPU A and CPU B are the same CPU (but
- * again only if the system has more than one CPU).
+ * This is transitional.
  */
 void synchronize_sched(void)
 {
-	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
-			 lock_is_held(&rcu_lock_map) ||
-			 lock_is_held(&rcu_sched_lock_map),
-			 "Illegal synchronize_sched() in RCU-sched read-side critical section");
-	if (rcu_blocking_is_gp())
-		return;
-	if (rcu_gp_is_expedited())
-		synchronize_sched_expedited();
-	else
-		wait_rcu_gp(call_rcu_sched);
+	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(synchronize_sched);
 
@@ -3180,41 +3086,23 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
 /**
  * get_state_synchronize_sched - Snapshot current RCU-sched state
  *
- * Returns a cookie that is used by a later call to cond_synchronize_sched()
- * to determine whether or not a full grace period has elapsed in the
- * meantime.
+ * This is transitional, and only used by rcutorture.
  */
 unsigned long get_state_synchronize_sched(void)
 {
-	/*
-	 * Any prior manipulation of RCU-protected data must happen
-	 * before the load from ->gp_seq.
-	 */
-	smp_mb();  /* ^^^ */
-	return rcu_seq_snap(&rcu_sched_state.gp_seq);
+	return get_state_synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_sched);
 
 /**
  * cond_synchronize_sched - Conditionally wait for an RCU-sched grace period
- *
  * @oldstate: return value from earlier call to get_state_synchronize_sched()
  *
- * If a full RCU-sched grace period has elapsed since the earlier call to
- * get_state_synchronize_sched(), just return.  Otherwise, invoke
- * synchronize_sched() to wait for a full grace period.
- *
- * Yes, this function does not take counter wrap into account.  But
- * counter wrap is harmless.  If the counter wraps, we have waited for
- * more than 2 billion grace periods (and way more on a 64-bit system!),
- * so waiting for one additional grace period should be just fine.
+ * This is transitional and only used by rcutorture.
  */
 void cond_synchronize_sched(unsigned long oldstate)
 {
-	if (!rcu_seq_done(&rcu_sched_state.gp_seq, oldstate))
-		synchronize_sched();
-	else
-		smp_mb(); /* Ensure GP ends before subsequent accesses. */
+	cond_synchronize_rcu(oldstate);
 }
 EXPORT_SYMBOL_GPL(cond_synchronize_sched);
 
@@ -3451,12 +3339,28 @@ void rcu_barrier_bh(void)
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_bh);
 
+/**
+ * rcu_barrier - Wait until all in-flight call_rcu() callbacks complete.
+ *
+ * Note that this primitive does not necessarily wait for an RCU grace period
+ * to complete.  For example, if there are no RCU callbacks queued anywhere
+ * in the system, then rcu_barrier() is within its rights to return
+ * immediately, without waiting for anything, much less an RCU grace period.
+ */
+void rcu_barrier(void)
+{
+	_rcu_barrier(rcu_state_p);
+}
+EXPORT_SYMBOL_GPL(rcu_barrier);
+
 /**
  * rcu_barrier_sched - Wait for in-flight call_rcu_sched() callbacks.
+ *
+ * This is transitional.
  */
 void rcu_barrier_sched(void)
 {
-	_rcu_barrier(&rcu_sched_state);
+	rcu_barrier();
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_sched);
 
@@ -3755,7 +3659,7 @@ void rcu_report_dead(unsigned int cpu)
 
 	/* QS for any half-done expedited RCU-sched GP. */
 	preempt_disable();
-	rcu_report_exp_rdp(&rcu_sched_state, this_cpu_ptr(rcu_sched_state.rda));
+	rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(rcu_state.rda));
 	preempt_enable();
 	rcu_preempt_deferred_qs(current);
 	for_each_rcu_flavor(rsp)
@@ -4097,10 +4001,9 @@ void __init rcu_init(void)
 
 	rcu_bootup_announce();
 	rcu_init_geometry();
-	rcu_init_one(&rcu_sched_state);
+	rcu_init_one(&rcu_state);
 	if (dump_tree)
-		rcu_dump_rcu_node_tree(&rcu_sched_state);
-	__rcu_init_preempt();
+		rcu_dump_rcu_node_tree(&rcu_state);
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
 
 	/*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e02c882861eb..38658ca87dcb 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -225,9 +225,6 @@ struct rcu_data {
 
 	/* 5) _rcu_barrier(), OOM callbacks, and expediting. */
 	struct rcu_head barrier_head;
-#ifdef CONFIG_RCU_FAST_NO_HZ
-	struct rcu_head oom_head;
-#endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
 	int exp_dynticks_snap;		/* Double-check need for IPI. */
 
 	/* 6) Callback offloading. */
@@ -433,8 +430,7 @@ DECLARE_PER_CPU(char, rcu_cpu_has_work);
 
 /* Forward declarations for rcutree_plugin.h */
 static void rcu_bootup_announce(void);
-static void rcu_preempt_qs(void);
-static void rcu_preempt_note_context_switch(bool preempt);
+static void rcu_qs(void);
 static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp);
 #ifdef CONFIG_HOTPLUG_CPU
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
@@ -444,9 +440,8 @@ static int rcu_print_task_stall(struct rcu_node *rnp);
 static int rcu_print_task_exp_stall(struct rcu_node *rnp);
 static void rcu_preempt_check_blocked_tasks(struct rcu_state *rsp,
 					    struct rcu_node *rnp);
-static void rcu_preempt_check_callbacks(void);
+static void rcu_flavor_check_callbacks(int user);
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
-static void __init __rcu_init_preempt(void);
 static void dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp,
 			    int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 0f8f225c1b46..5619edfd414e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -265,7 +265,7 @@ static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp)
 	rcu_report_exp_cpu_mult(rsp, rdp->mynode, rdp->grpmask, true);
 }
 
-/* Common code for synchronize_{rcu,sched}_expedited() work-done checking. */
+/* Common code for work-done checking. */
 static bool sync_exp_work_done(struct rcu_state *rsp, unsigned long s)
 {
 	if (rcu_exp_gp_seq_done(rsp, s)) {
@@ -337,45 +337,6 @@ static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
 	return false;
 }
 
-/* Invoked on each online non-idle CPU for expedited quiescent state. */
-static void sync_sched_exp_handler(void *data)
-{
-	struct rcu_data *rdp;
-	struct rcu_node *rnp;
-	struct rcu_state *rsp = data;
-
-	rdp = this_cpu_ptr(rsp->rda);
-	rnp = rdp->mynode;
-	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
-	    __this_cpu_read(rcu_sched_data.cpu_no_qs.b.exp))
-		return;
-	if (rcu_is_cpu_rrupt_from_idle()) {
-		rcu_report_exp_rdp(&rcu_sched_state,
-				   this_cpu_ptr(&rcu_sched_data));
-		return;
-	}
-	__this_cpu_write(rcu_sched_data.cpu_no_qs.b.exp, true);
-	/* Store .exp before .rcu_urgent_qs. */
-	smp_store_release(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs), true);
-	resched_cpu(smp_processor_id());
-}
-
-/* Send IPI for expedited cleanup if needed at end of CPU-hotplug operation. */
-static void sync_sched_exp_online_cleanup(int cpu)
-{
-	struct rcu_data *rdp;
-	int ret;
-	struct rcu_node *rnp;
-	struct rcu_state *rsp = &rcu_sched_state;
-
-	rdp = per_cpu_ptr(rsp->rda, cpu);
-	rnp = rdp->mynode;
-	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask))
-		return;
-	ret = smp_call_function_single(cpu, sync_sched_exp_handler, rsp, 0);
-	WARN_ON_ONCE(ret);
-}
-
 /*
  * Select the CPUs within the specified rcu_node that the upcoming
  * expedited grace period needs to wait for.
@@ -691,39 +652,6 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
 	mutex_unlock(&rsp->exp_mutex);
 }
 
-/**
- * synchronize_sched_expedited - Brute-force RCU-sched grace period
- *
- * Wait for an RCU-sched grace period to elapse, but use a "big hammer"
- * approach to force the grace period to end quickly.  This consumes
- * significant time on all CPUs and is unfriendly to real-time workloads,
- * so is thus not recommended for any sort of common-case code.  In fact,
- * if you are using synchronize_sched_expedited() in a loop, please
- * restructure your code to batch your updates, and then use a single
- * synchronize_sched() instead.
- *
- * This implementation can be thought of as an application of sequence
- * locking to expedited grace periods, but using the sequence counter to
- * determine when someone else has already done the work instead of for
- * retrying readers.
- */
-void synchronize_sched_expedited(void)
-{
-	struct rcu_state *rsp = &rcu_sched_state;
-
-	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
-			 lock_is_held(&rcu_lock_map) ||
-			 lock_is_held(&rcu_sched_lock_map),
-			 "Illegal synchronize_sched_expedited() in RCU read-side critical section");
-
-	/* If only one CPU, this is automatically a grace period. */
-	if (rcu_blocking_is_gp())
-		return;
-
-	_synchronize_rcu_expedited(rsp, sync_sched_exp_handler);
-}
-EXPORT_SYMBOL_GPL(synchronize_sched_expedited);
-
 #ifdef CONFIG_PREEMPT_RCU
 
 /*
@@ -801,6 +729,11 @@ static void sync_rcu_exp_handler(void *info)
 		resched_cpu(rdp->cpu);
 }
 
+/* PREEMPT=y, so no RCU-sched to clean up after. */
+static void sync_sched_exp_online_cleanup(int cpu)
+{
+}
+
 /**
  * synchronize_rcu_expedited - Brute-force RCU grace period
  *
@@ -818,6 +751,8 @@ static void sync_rcu_exp_handler(void *info)
  * you are using synchronize_rcu_expedited() in a loop, please restructure
  * your code to batch your updates, and then Use a single synchronize_rcu()
  * instead.
+ *
+ * This has the same semantics as (but is more brutal than) synchronize_rcu().
  */
 void synchronize_rcu_expedited(void)
 {
@@ -836,13 +771,79 @@ EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
+/* Invoked on each online non-idle CPU for expedited quiescent state. */
+static void sync_sched_exp_handler(void *data)
+{
+	struct rcu_data *rdp;
+	struct rcu_node *rnp;
+	struct rcu_state *rsp = data;
+
+	rdp = this_cpu_ptr(rsp->rda);
+	rnp = rdp->mynode;
+	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
+	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
+		return;
+	if (rcu_is_cpu_rrupt_from_idle()) {
+		rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(&rcu_data));
+		return;
+	}
+	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
+	/* Store .exp before .rcu_urgent_qs. */
+	smp_store_release(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs), true);
+	resched_cpu(smp_processor_id());
+}
+
+/* Send IPI for expedited cleanup if needed at end of CPU-hotplug operation. */
+static void sync_sched_exp_online_cleanup(int cpu)
+{
+	struct rcu_data *rdp;
+	int ret;
+	struct rcu_node *rnp;
+	struct rcu_state *rsp = &rcu_state;
+
+	rdp = per_cpu_ptr(rsp->rda, cpu);
+	rnp = rdp->mynode;
+	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask))
+		return;
+	ret = smp_call_function_single(cpu, sync_sched_exp_handler, rsp, 0);
+	WARN_ON_ONCE(ret);
+}
+
 /*
- * Wait for an rcu-preempt grace period, but make it happen quickly.
- * But because preemptible RCU does not exist, map to rcu-sched.
+ * Because a context switch is a grace period for RCU-sched, any blocking
+ * grace-period wait automatically implies a grace period if there
+ * is only one CPU online at any point time during execution of either
+ * synchronize_sched() or synchronize_rcu_bh().  It is OK to occasionally
+ * incorrectly indicate that there are multiple CPUs online when there
+ * was in fact only one the whole time, as this just adds some overhead:
+ * RCU still operates correctly.
  */
+static int rcu_blocking_is_gp(void)
+{
+	int ret;
+
+	might_sleep();  /* Check for RCU read-side critical section. */
+	preempt_disable();
+	ret = num_online_cpus() <= 1;
+	preempt_enable();
+	return ret;
+}
+
+/* PREEMPT=n implementation of synchronize_rcu_expedited(). */
 void synchronize_rcu_expedited(void)
 {
-	synchronize_sched_expedited();
+	struct rcu_state *rsp = &rcu_state;
+
+	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
+			 lock_is_held(&rcu_lock_map) ||
+			 lock_is_held(&rcu_sched_lock_map),
+			 "Illegal synchronize_sched_expedited() in RCU read-side critical section");
+
+	/* If only one CPU, this is automatically a grace period. */
+	if (rcu_blocking_is_gp())
+		return;
+
+	_synchronize_rcu_expedited(rsp, sync_sched_exp_handler);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9f0d054e6c20..2c81f8dd63b4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -123,10 +123,6 @@ static void __init rcu_bootup_announce_oddness(void)
 
 #ifdef CONFIG_PREEMPT_RCU
 
-RCU_STATE_INITIALIZER(rcu_preempt, 'p', call_rcu);
-static struct rcu_state *const rcu_state_p = &rcu_preempt_state;
-static struct rcu_data __percpu *const rcu_data_p = &rcu_preempt_data;
-
 static void rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 			       bool wake);
 static void rcu_read_unlock_special(struct task_struct *t);
@@ -303,15 +299,15 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
  *
  * Callers to this function must disable preemption.
  */
-static void rcu_preempt_qs(void)
+static void rcu_qs(void)
 {
-	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_qs() invoked with preemption enabled!!!\n");
+	RCU_LOCKDEP_WARN(preemptible(), "rcu_qs() invoked with preemption enabled!!!\n");
 	if (__this_cpu_read(rcu_data_p->cpu_no_qs.s)) {
 		trace_rcu_grace_period(TPS("rcu_preempt"),
 				       __this_cpu_read(rcu_data_p->gp_seq),
 				       TPS("cpuqs"));
 		__this_cpu_write(rcu_data_p->cpu_no_qs.b.norm, false);
-		barrier(); /* Coordinate with rcu_preempt_check_callbacks(). */
+		barrier(); /* Coordinate with rcu_flavor_check_callbacks(). */
 		current->rcu_read_unlock_special.b.need_qs = false;
 	}
 }
@@ -329,12 +325,14 @@ static void rcu_preempt_qs(void)
  *
  * Caller must disable interrupts.
  */
-static void rcu_preempt_note_context_switch(bool preempt)
+void rcu_note_context_switch(bool preempt)
 {
 	struct task_struct *t = current;
 	struct rcu_data *rdp = this_cpu_ptr(rcu_state_p->rda);
 	struct rcu_node *rnp;
 
+	barrier(); /* Avoid RCU read-side critical sections leaking down. */
+	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
 	if (t->rcu_read_lock_nesting > 0 &&
@@ -381,10 +379,13 @@ static void rcu_preempt_note_context_switch(bool preempt)
 	 * grace period, then the fact that the task has been enqueued
 	 * means that we continue to block the current grace period.
 	 */
-	rcu_preempt_qs();
+	rcu_qs();
 	if (rdp->deferred_qs)
 		rcu_report_exp_rdp(rcu_state_p, rdp);
+	trace_rcu_utilization(TPS("End context switch"));
+	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 }
+EXPORT_SYMBOL_GPL(rcu_note_context_switch);
 
 /*
  * Check for preempted RCU readers blocking the current grace period
@@ -493,7 +494,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		return;
 	}
 	if (special.b.need_qs) {
-		rcu_preempt_qs();
+		rcu_qs();
 		t->rcu_read_unlock_special.b.need_qs = false;
 		if (!t->rcu_read_unlock_special.s && !rdp->deferred_qs) {
 			local_irq_restore(flags);
@@ -596,7 +597,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
  */
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
-	return (this_cpu_ptr(&rcu_preempt_data)->deferred_qs ||
+	return (this_cpu_ptr(&rcu_data)->deferred_qs ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
 	       t->rcu_read_lock_nesting <= 0;
 }
@@ -781,11 +782,14 @@ rcu_preempt_check_blocked_tasks(struct rcu_state *rsp, struct rcu_node *rnp)
  *
  * Caller must disable hard irqs.
  */
-static void rcu_preempt_check_callbacks(void)
+static void rcu_flavor_check_callbacks(int user)
 {
-	struct rcu_state *rsp = &rcu_preempt_state;
+	struct rcu_state *rsp = &rcu_state;
 	struct task_struct *t = current;
 
+	if (user || rcu_is_cpu_rrupt_from_idle()) {
+		rcu_note_voluntary_context_switch(current);
+	}
 	if (t->rcu_read_lock_nesting > 0 ||
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
@@ -795,7 +799,7 @@ static void rcu_preempt_check_callbacks(void)
 		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
 		return;
 	} else if (!t->rcu_read_lock_nesting) {
-		rcu_preempt_qs(); /* Report immediate QS. */
+		rcu_qs(); /* Report immediate QS. */
 		return;
 	}
 
@@ -808,44 +812,6 @@ static void rcu_preempt_check_callbacks(void)
 		t->rcu_read_unlock_special.b.need_qs = true;
 }
 
-/**
- * call_rcu() - Queue an RCU callback for invocation after a grace period.
- * @head: structure to be used for queueing the RCU updates.
- * @func: actual callback function to be invoked after the grace period
- *
- * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all pre-existing RCU read-side
- * critical sections have completed.  However, the callback function
- * might well execute concurrently with RCU read-side critical sections
- * that started after call_rcu() was invoked.  RCU read-side critical
- * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
- * and may be nested.
- *
- * Note that all CPUs must agree that the grace period extended beyond
- * all pre-existing RCU read-side critical section.  On systems with more
- * than one CPU, this means that when "func()" is invoked, each CPU is
- * guaranteed to have executed a full memory barrier since the end of its
- * last RCU read-side critical section whose beginning preceded the call
- * to call_rcu().  It also means that each CPU executing an RCU read-side
- * critical section that continues beyond the start of "func()" must have
- * executed a memory barrier after the call_rcu() but before the beginning
- * of that RCU read-side critical section.  Note that these guarantees
- * include CPUs that are offline, idle, or executing in user mode, as
- * well as CPUs that are executing in the kernel.
- *
- * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
- * resulting RCU callback function "func()", then both CPU A and CPU B are
- * guaranteed to execute a full memory barrier during the time interval
- * between the call to call_rcu() and the invocation of "func()" -- even
- * if CPU A and CPU B are the same CPU (but again only if the system has
- * more than one CPU).
- */
-void call_rcu(struct rcu_head *head, rcu_callback_t func)
-{
-	__call_rcu(head, func, rcu_state_p, -1, 0);
-}
-EXPORT_SYMBOL_GPL(call_rcu);
-
 /**
  * synchronize_rcu - wait until a grace period has elapsed.
  *
@@ -856,14 +822,28 @@ EXPORT_SYMBOL_GPL(call_rcu);
  * concurrently with new RCU read-side critical sections that began while
  * synchronize_rcu() was waiting.  RCU read-side critical sections are
  * delimited by rcu_read_lock() and rcu_read_unlock(), and may be nested.
+ * In addition, regions of code across which interrupts, preemption, or
+ * softirqs have been disabled also serve as RCU read-side critical
+ * sections.  This includes hardware interrupt handlers, softirq handlers,
+ * and NMI handlers.
+ *
+ * Note that this guarantee implies further memory-ordering guarantees.
+ * On systems with more than one CPU, when synchronize_rcu() returns,
+ * each CPU is guaranteed to have executed a full memory barrier since the
+ * end of its last RCU-sched read-side critical section whose beginning
+ * preceded the call to synchronize_rcu().  In addition, each CPU having
+ * an RCU read-side critical section that extends beyond the return from
+ * synchronize_rcu() is guaranteed to have executed a full memory barrier
+ * after the beginning of synchronize_rcu() and before the beginning of
+ * that RCU read-side critical section.  Note that these guarantees include
+ * CPUs that are offline, idle, or executing in user mode, as well as CPUs
+ * that are executing in the kernel.
  *
- * See the description of synchronize_sched() for more detailed
- * information on memory-ordering guarantees.  However, please note
- * that -only- the memory-ordering guarantees apply.  For example,
- * synchronize_rcu() is -not- guaranteed to wait on things like code
- * protected by preempt_disable(), instead, synchronize_rcu() is -only-
- * guaranteed to wait on RCU read-side critical sections, that is, sections
- * of code protected by rcu_read_lock().
+ * Furthermore, if CPU A invoked synchronize_rcu(), which returned
+ * to its caller on CPU B, then both CPU A and CPU B are guaranteed
+ * to have executed a full memory barrier during the execution of
+ * synchronize_rcu() -- even if CPU A and CPU B are the same CPU (but
+ * again only if the system has more than one CPU).
  */
 void synchronize_rcu(void)
 {
@@ -880,28 +860,6 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
-/**
- * rcu_barrier - Wait until all in-flight call_rcu() callbacks complete.
- *
- * Note that this primitive does not necessarily wait for an RCU grace period
- * to complete.  For example, if there are no RCU callbacks queued anywhere
- * in the system, then rcu_barrier() is within its rights to return
- * immediately, without waiting for anything, much less an RCU grace period.
- */
-void rcu_barrier(void)
-{
-	_rcu_barrier(rcu_state_p);
-}
-EXPORT_SYMBOL_GPL(rcu_barrier);
-
-/*
- * Initialize preemptible RCU's state structures.
- */
-static void __init __rcu_init_preempt(void)
-{
-	rcu_init_one(rcu_state_p);
-}
-
 /*
  * Check for a task exiting while in a preemptible-RCU read-side
  * critical section, clean up if so.  No need to issue warnings,
@@ -964,8 +922,6 @@ dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp, int ncheck)
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
-static struct rcu_state *const rcu_state_p = &rcu_sched_state;
-
 /*
  * Tell them what RCU they are running.
  */
@@ -975,18 +931,48 @@ static void __init rcu_bootup_announce(void)
 	rcu_bootup_announce_oddness();
 }
 
-/* Because preemptible RCU does not exist, we can ignore its QSes. */
-static void rcu_preempt_qs(void)
+/*
+ * Note a quiescent state for PREEMPT=n.  Because we do not need to know
+ * how many quiescent states passed, just if there was at least one since
+ * the start of the grace period, this just sets a flag.  The caller must
+ * have disabled preemption.
+ */
+static void rcu_qs(void)
 {
+	RCU_LOCKDEP_WARN(preemptible(), "rcu_qs() invoked with preemption enabled!!!");
+	if (!__this_cpu_read(rcu_data.cpu_no_qs.s))
+		return;
+	trace_rcu_grace_period(TPS("rcu_sched"),
+			       __this_cpu_read(rcu_data.gp_seq), TPS("cpuqs"));
+	__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
+	if (!__this_cpu_read(rcu_data.cpu_no_qs.b.exp))
+		return;
+	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, false);
+	rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(&rcu_data));
 }
 
 /*
- * Because preemptible RCU does not exist, we never have to check for
- * CPUs being in quiescent states.
+ * Note a PREEMPT=n context switch.  The caller must have disabled interrupts.
  */
-static void rcu_preempt_note_context_switch(bool preempt)
+void rcu_note_context_switch(bool preempt)
 {
+	barrier(); /* Avoid RCU read-side critical sections leaking down. */
+	trace_rcu_utilization(TPS("Start context switch"));
+	rcu_qs();
+	/* Load rcu_urgent_qs before other flags. */
+	if (!smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs)))
+		goto out;
+	this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
+	if (unlikely(raw_cpu_read(rcu_dynticks.rcu_need_heavy_qs)))
+		rcu_momentary_dyntick_idle();
+	this_cpu_inc(rcu_dynticks.rcu_qs_ctr);
+	if (!preempt)
+		rcu_tasks_qs(current);
+out:
+	trace_rcu_utilization(TPS("End context switch"));
+	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 }
+EXPORT_SYMBOL_GPL(rcu_note_context_switch);
 
 /*
  * Because preemptible RCU does not exist, there are never any preempted
@@ -1054,29 +1040,48 @@ rcu_preempt_check_blocked_tasks(struct rcu_state *rsp, struct rcu_node *rnp)
 }
 
 /*
- * Because preemptible RCU does not exist, it never has any callbacks
- * to check.
+ * Check to see if this CPU is in a non-context-switch quiescent state
+ * (user mode or idle loop for rcu, non-softirq execution for rcu_bh).
+ * Also schedule RCU core processing.
+ *
+ * This function must be called from hardirq context.  It is normally
+ * invoked from the scheduling-clock interrupt.
  */
-static void rcu_preempt_check_callbacks(void)
+static void rcu_flavor_check_callbacks(int user)
 {
-}
+	if (user || rcu_is_cpu_rrupt_from_idle()) {
 
-/*
- * Because preemptible RCU does not exist, rcu_barrier() is just
- * another name for rcu_barrier_sched().
- */
-void rcu_barrier(void)
-{
-	rcu_barrier_sched();
+		/*
+		 * Get here if this CPU took its interrupt from user
+		 * mode or from the idle loop, and if this is not a
+		 * nested interrupt.  In this case, the CPU is in
+		 * a quiescent state, so note it.
+		 *
+		 * No memory barrier is required here because rcu_qs()
+		 * references only CPU-local variables that other CPUs
+		 * neither access nor modify, at least not while the
+		 * corresponding CPU is online.
+		 */
+
+		rcu_qs();
+	}
 }
-EXPORT_SYMBOL_GPL(rcu_barrier);
 
-/*
- * Because preemptible RCU does not exist, it need not be initialized.
- */
-static void __init __rcu_init_preempt(void)
+/* PREEMPT=n implementation of synchronize_rcu(). */
+void synchronize_rcu(void)
 {
+	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
+			 lock_is_held(&rcu_lock_map) ||
+			 lock_is_held(&rcu_sched_lock_map),
+			 "Illegal synchronize_rcu() in RCU-sched read-side critical section");
+	if (rcu_blocking_is_gp())
+		return;
+	if (rcu_gp_is_expedited())
+		synchronize_rcu_expedited();
+	else
+		wait_rcu_gp(call_rcu);
 }
+EXPORT_SYMBOL_GPL(synchronize_rcu);
 
 /*
  * Because preemptible RCU does not exist, tasks cannot possibly exit
@@ -1319,8 +1324,7 @@ static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
 
 static void rcu_kthread_do_work(void)
 {
-	rcu_do_batch(&rcu_sched_state, this_cpu_ptr(&rcu_sched_data));
-	rcu_do_batch(&rcu_preempt_state, this_cpu_ptr(&rcu_preempt_data));
+	rcu_do_batch(&rcu_state, this_cpu_ptr(&rcu_data));
 }
 
 static void rcu_cpu_kthread_setup(unsigned int cpu)
@@ -1727,87 +1731,6 @@ static void rcu_idle_count_callbacks_posted(void)
 	__this_cpu_add(rcu_dynticks.nonlazy_posted, 1);
 }
 
-/*
- * Data for flushing lazy RCU callbacks at OOM time.
- */
-static atomic_t oom_callback_count;
-static DECLARE_WAIT_QUEUE_HEAD(oom_callback_wq);
-
-/*
- * RCU OOM callback -- decrement the outstanding count and deliver the
- * wake-up if we are the last one.
- */
-static void rcu_oom_callback(struct rcu_head *rhp)
-{
-	if (atomic_dec_and_test(&oom_callback_count))
-		wake_up(&oom_callback_wq);
-}
-
-/*
- * Post an rcu_oom_notify callback on the current CPU if it has at
- * least one lazy callback.  This will unnecessarily post callbacks
- * to CPUs that already have a non-lazy callback at the end of their
- * callback list, but this is an infrequent operation, so accept some
- * extra overhead to keep things simple.
- */
-static void rcu_oom_notify_cpu(void *unused)
-{
-	struct rcu_state *rsp;
-	struct rcu_data *rdp;
-
-	for_each_rcu_flavor(rsp) {
-		rdp = raw_cpu_ptr(rsp->rda);
-		if (rcu_segcblist_n_lazy_cbs(&rdp->cblist)) {
-			atomic_inc(&oom_callback_count);
-			rsp->call(&rdp->oom_head, rcu_oom_callback);
-		}
-	}
-}
-
-/*
- * If low on memory, ensure that each CPU has a non-lazy callback.
- * This will wake up CPUs that have only lazy callbacks, in turn
- * ensuring that they free up the corresponding memory in a timely manner.
- * Because an uncertain amount of memory will be freed in some uncertain
- * timeframe, we do not claim to have freed anything.
- */
-static int rcu_oom_notify(struct notifier_block *self,
-			  unsigned long notused, void *nfreed)
-{
-	int cpu;
-
-	/* Wait for callbacks from earlier instance to complete. */
-	wait_event(oom_callback_wq, atomic_read(&oom_callback_count) == 0);
-	smp_mb(); /* Ensure callback reuse happens after callback invocation. */
-
-	/*
-	 * Prevent premature wakeup: ensure that all increments happen
-	 * before there is a chance of the counter reaching zero.
-	 */
-	atomic_set(&oom_callback_count, 1);
-
-	for_each_online_cpu(cpu) {
-		smp_call_function_single(cpu, rcu_oom_notify_cpu, NULL, 1);
-		cond_resched_tasks_rcu_qs();
-	}
-
-	/* Unconditionally decrement: no need to wake ourselves up. */
-	atomic_dec(&oom_callback_count);
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block rcu_oom_nb = {
-	.notifier_call = rcu_oom_notify
-};
-
-static int __init rcu_register_oom_notifier(void)
-{
-	register_oom_notifier(&rcu_oom_nb);
-	return 0;
-}
-early_initcall(rcu_register_oom_notifier);
-
 #endif /* #else #if !defined(CONFIG_RCU_FAST_NO_HZ) */
 
 #ifdef CONFIG_RCU_FAST_NO_HZ
-- 
2.17.1

