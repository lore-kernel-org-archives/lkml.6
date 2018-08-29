Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C67C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E861820658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E861820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeH3CTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:19:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727247AbeH3CTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMIhcB094310
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:55 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m627rc12y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:54 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:54 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKnJq45416652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47F16B206B;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13E3EB206A;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 33DAE16C91CF; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 09/19] rcu: Define RCU-bh update API in terms of RCU
Date:   Wed, 29 Aug 2018 15:20:37 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0060-0000-0000-000002A6628E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860724;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0061-0000-0000-00004655AED5
Message-Id: <20180829222047.319-9-paulmck@linux.vnet.ibm.com>
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

Now that the main RCU API knows about softirq disabling and softirq's
quiescent states, the RCU-bh update code can be dispensed with.
This commit therefore removes the RCU-bh update-side implementation and
defines RCU-bh's update-side API in terms of that of either RCU-preempt or
RCU-sched, depending on the setting of the CONFIG_PREEMPT Kconfig option.

In kernels built with CONFIG_RCU_NOCB_CPU=y this has the knock-on effect
of reducing by one the number of rcuo kthreads per CPU.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/rcupdate.h |  10 ++--
 include/linux/rcutiny.h  |  10 +++-
 include/linux/rcutree.h  |   8 ++-
 kernel/rcu/tiny.c        | 115 +++++++--------------------------------
 kernel/rcu/tree.c        |  97 +++------------------------------
 kernel/rcu/tree_plugin.h |   1 -
 kernel/softirq.c         |   1 -
 7 files changed, 48 insertions(+), 194 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 75e5b393cf44..9ebfd436cec7 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -55,11 +55,15 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func);
 #define	call_rcu	call_rcu_sched
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
-void call_rcu_bh(struct rcu_head *head, rcu_callback_t func);
 void call_rcu_sched(struct rcu_head *head, rcu_callback_t func);
 void synchronize_sched(void);
 void rcu_barrier_tasks(void);
 
+static inline void call_rcu_bh(struct rcu_head *head, rcu_callback_t func)
+{
+	call_rcu(head, func);
+}
+
 #ifdef CONFIG_PREEMPT_RCU
 
 void __rcu_read_lock(void);
@@ -104,7 +108,6 @@ static inline int rcu_preempt_depth(void)
 void rcu_init(void);
 extern int rcu_scheduler_active __read_mostly;
 void rcu_sched_qs(void);
-void rcu_bh_qs(void);
 void rcu_check_callbacks(int user);
 void rcu_report_dead(unsigned int cpu);
 void rcutree_migrate_callbacks(int cpu);
@@ -326,8 +329,7 @@ static inline void rcu_preempt_sleep_check(void) { }
  * and rcu_assign_pointer().  Some of these could be folded into their
  * callers, but they are left separate in order to ease introduction of
  * multiple flavors of pointers to match the multiple flavors of RCU
- * (e.g., __rcu_bh, * __rcu_sched, and __srcu), should this make sense in
- * the future.
+ * (e.g., __rcu_sched, and __srcu), should this make sense in the future.
  */
 
 #ifdef __CHECKER__
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index bcfbc40a7239..ac26c27ccde8 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -56,19 +56,23 @@ static inline void cond_synchronize_sched(unsigned long oldstate)
 	might_sleep();
 }
 
-extern void rcu_barrier_bh(void);
-extern void rcu_barrier_sched(void);
-
 static inline void synchronize_rcu_expedited(void)
 {
 	synchronize_sched();	/* Only one CPU, so pretty fast anyway!!! */
 }
 
+extern void rcu_barrier_sched(void);
+
 static inline void rcu_barrier(void)
 {
 	rcu_barrier_sched();  /* Only one CPU, so only one list of callbacks! */
 }
 
+static inline void rcu_barrier_bh(void)
+{
+	rcu_barrier();
+}
+
 static inline void synchronize_rcu_bh(void)
 {
 	synchronize_sched();
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 664b580695d6..c789c302a2c9 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -45,7 +45,11 @@ static inline void rcu_virt_note_context_switch(int cpu)
 	rcu_note_context_switch(false);
 }
 
-void synchronize_rcu_bh(void);
+static inline void synchronize_rcu_bh(void)
+{
+	synchronize_rcu();
+}
+
 void synchronize_sched_expedited(void);
 void synchronize_rcu_expedited(void);
 
@@ -69,7 +73,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
  */
 static inline void synchronize_rcu_bh_expedited(void)
 {
-	synchronize_sched_expedited();
+	synchronize_rcu_expedited();
 }
 
 void rcu_barrier(void);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index befc9321a89c..cadcf63c4889 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -51,64 +51,22 @@ static struct rcu_ctrlblk rcu_sched_ctrlblk = {
 	.curtail	= &rcu_sched_ctrlblk.rcucblist,
 };
 
-static struct rcu_ctrlblk rcu_bh_ctrlblk = {
-	.donetail	= &rcu_bh_ctrlblk.rcucblist,
-	.curtail	= &rcu_bh_ctrlblk.rcucblist,
-};
-
-void rcu_barrier_bh(void)
-{
-	wait_rcu_gp(call_rcu_bh);
-}
-EXPORT_SYMBOL(rcu_barrier_bh);
-
 void rcu_barrier_sched(void)
 {
 	wait_rcu_gp(call_rcu_sched);
 }
 EXPORT_SYMBOL(rcu_barrier_sched);
 
-/*
- * Helper function for rcu_sched_qs() and rcu_bh_qs().
- * Also irqs are disabled to avoid confusion due to interrupt handlers
- * invoking call_rcu().
- */
-static int rcu_qsctr_help(struct rcu_ctrlblk *rcp)
-{
-	if (rcp->donetail != rcp->curtail) {
-		rcp->donetail = rcp->curtail;
-		return 1;
-	}
-
-	return 0;
-}
-
-/*
- * Record an rcu quiescent state.  And an rcu_bh quiescent state while we
- * are at it, given that any rcu quiescent state is also an rcu_bh
- * quiescent state.  Use "+" instead of "||" to defeat short circuiting.
- */
+/* Record an rcu quiescent state.  */
 void rcu_sched_qs(void)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if (rcu_qsctr_help(&rcu_sched_ctrlblk) +
-	    rcu_qsctr_help(&rcu_bh_ctrlblk))
-		raise_softirq(RCU_SOFTIRQ);
-	local_irq_restore(flags);
-}
-
-/*
- * Record an rcu_bh quiescent state.
- */
-void rcu_bh_qs(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	if (rcu_qsctr_help(&rcu_bh_ctrlblk))
+	if (rcu_sched_ctrlblk.donetail != rcu_sched_ctrlblk.curtail) {
+		rcu_sched_ctrlblk.donetail = rcu_sched_ctrlblk.curtail;
 		raise_softirq(RCU_SOFTIRQ);
+	}
 	local_irq_restore(flags);
 }
 
@@ -122,32 +80,27 @@ void rcu_check_callbacks(int user)
 {
 	if (user)
 		rcu_sched_qs();
-	if (user || !in_softirq())
-		rcu_bh_qs();
 }
 
-/*
- * Invoke the RCU callbacks on the specified rcu_ctrlkblk structure
- * whose grace period has elapsed.
- */
-static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp)
+/* Invoke the RCU callbacks whose grace period has elapsed.  */
+static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused)
 {
 	struct rcu_head *next, *list;
 	unsigned long flags;
 
 	/* Move the ready-to-invoke callbacks to a local list. */
 	local_irq_save(flags);
-	if (rcp->donetail == &rcp->rcucblist) {
+	if (rcu_sched_ctrlblk.donetail == &rcu_sched_ctrlblk.rcucblist) {
 		/* No callbacks ready, so just leave. */
 		local_irq_restore(flags);
 		return;
 	}
-	list = rcp->rcucblist;
-	rcp->rcucblist = *rcp->donetail;
-	*rcp->donetail = NULL;
-	if (rcp->curtail == rcp->donetail)
-		rcp->curtail = &rcp->rcucblist;
-	rcp->donetail = &rcp->rcucblist;
+	list = rcu_sched_ctrlblk.rcucblist;
+	rcu_sched_ctrlblk.rcucblist = *rcu_sched_ctrlblk.donetail;
+	*rcu_sched_ctrlblk.donetail = NULL;
+	if (rcu_sched_ctrlblk.curtail == rcu_sched_ctrlblk.donetail)
+		rcu_sched_ctrlblk.curtail = &rcu_sched_ctrlblk.rcucblist;
+	rcu_sched_ctrlblk.donetail = &rcu_sched_ctrlblk.rcucblist;
 	local_irq_restore(flags);
 
 	/* Invoke the callbacks on the local list. */
@@ -162,19 +115,13 @@ static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp)
 	}
 }
 
-static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused)
-{
-	__rcu_process_callbacks(&rcu_sched_ctrlblk);
-	__rcu_process_callbacks(&rcu_bh_ctrlblk);
-}
-
 /*
  * Wait for a grace period to elapse.  But it is illegal to invoke
  * synchronize_sched() from within an RCU read-side critical section.
  * Therefore, any legal call to synchronize_sched() is a quiescent
  * state, and so on a UP system, synchronize_sched() need do nothing.
- * Ditto for synchronize_rcu_bh().  (But Lai Jiangshan points out the
- * benefits of doing might_sleep() to reduce latency.)
+ * (But Lai Jiangshan points out the benefits of doing might_sleep()
+ * to reduce latency.)
  *
  * Cool, huh?  (Due to Josh Triplett.)
  */
@@ -188,11 +135,11 @@ void synchronize_sched(void)
 EXPORT_SYMBOL_GPL(synchronize_sched);
 
 /*
- * Helper function for call_rcu() and call_rcu_bh().
+ * Post an RCU callback to be invoked after the end of an RCU-sched grace
+ * period.  But since we have but one CPU, that would be after any
+ * quiescent state.
  */
-static void __call_rcu(struct rcu_head *head,
-		       rcu_callback_t func,
-		       struct rcu_ctrlblk *rcp)
+void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 
@@ -201,8 +148,8 @@ static void __call_rcu(struct rcu_head *head,
 	head->next = NULL;
 
 	local_irq_save(flags);
-	*rcp->curtail = head;
-	rcp->curtail = &head->next;
+	*rcu_sched_ctrlblk.curtail = head;
+	rcu_sched_ctrlblk.curtail = &head->next;
 	local_irq_restore(flags);
 
 	if (unlikely(is_idle_task(current))) {
@@ -210,28 +157,8 @@ static void __call_rcu(struct rcu_head *head,
 		resched_cpu(0);
 	}
 }
-
-/*
- * Post an RCU callback to be invoked after the end of an RCU-sched grace
- * period.  But since we have but one CPU, that would be after any
- * quiescent state.
- */
-void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
-{
-	__call_rcu(head, func, &rcu_sched_ctrlblk);
-}
 EXPORT_SYMBOL_GPL(call_rcu_sched);
 
-/*
- * Post an RCU bottom-half callback to be invoked after any subsequent
- * quiescent state.
- */
-void call_rcu_bh(struct rcu_head *head, rcu_callback_t func)
-{
-	__call_rcu(head, func, &rcu_bh_ctrlblk);
-}
-EXPORT_SYMBOL_GPL(call_rcu_bh);
-
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9b6bd12133c4..b602d60462ba 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -108,7 +108,6 @@ struct rcu_state sname##_state = { \
 }
 
 RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu_sched);
-RCU_STATE_INITIALIZER(rcu_bh, 'b', call_rcu_bh);
 
 static struct rcu_state *const rcu_state_p;
 LIST_HEAD(rcu_struct_flavors);
@@ -244,17 +243,6 @@ void rcu_sched_qs(void)
 			   this_cpu_ptr(&rcu_sched_data), true);
 }
 
-void rcu_bh_qs(void)
-{
-	RCU_LOCKDEP_WARN(preemptible(), "rcu_bh_qs() invoked with preemption enabled!!!");
-	if (__this_cpu_read(rcu_bh_data.cpu_no_qs.s)) {
-		trace_rcu_grace_period(TPS("rcu_bh"),
-				       __this_cpu_read(rcu_bh_data.gp_seq),
-				       TPS("cpuqs"));
-		__this_cpu_write(rcu_bh_data.cpu_no_qs.b.norm, false);
-	}
-}
-
 void rcu_softirq_qs(void)
 {
 	rcu_sched_qs();
@@ -581,7 +569,7 @@ EXPORT_SYMBOL_GPL(rcu_sched_get_gp_seq);
  */
 unsigned long rcu_bh_get_gp_seq(void)
 {
-	return READ_ONCE(rcu_bh_state.gp_seq);
+	return READ_ONCE(rcu_state_p->gp_seq);
 }
 EXPORT_SYMBOL_GPL(rcu_bh_get_gp_seq);
 
@@ -621,7 +609,7 @@ EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
  */
 void rcu_bh_force_quiescent_state(void)
 {
-	force_quiescent_state(&rcu_bh_state);
+	force_quiescent_state(rcu_state_p);
 }
 EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
 
@@ -680,10 +668,8 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 
 	switch (test_type) {
 	case RCU_FLAVOR:
-		rsp = rcu_state_p;
-		break;
 	case RCU_BH_FLAVOR:
-		rsp = &rcu_bh_state;
+		rsp = rcu_state_p;
 		break;
 	case RCU_SCHED_FLAVOR:
 		rsp = &rcu_sched_state;
@@ -2672,26 +2658,15 @@ void rcu_check_callbacks(int user)
 		 * nested interrupt.  In this case, the CPU is in
 		 * a quiescent state, so note it.
 		 *
-		 * No memory barrier is required here because both
-		 * rcu_sched_qs() and rcu_bh_qs() reference only CPU-local
-		 * variables that other CPUs neither access nor modify,
-		 * at least not while the corresponding CPU is online.
+		 * No memory barrier is required here because
+		 * rcu_sched_qs() references only CPU-local variables
+		 * that other CPUs neither access nor modify, at least
+		 * not while the corresponding CPU is online.
 		 */
 
 		rcu_sched_qs();
-		rcu_bh_qs();
 		rcu_note_voluntary_context_switch(current);
 
-	} else if (!in_softirq()) {
-
-		/*
-		 * Get here if this CPU did not take its interrupt from
-		 * softirq, in other words, if it is not interrupting
-		 * a rcu_bh read-side critical section.  This is an _bh
-		 * critical section, so note it.
-		 */
-
-		rcu_bh_qs();
 	}
 	rcu_preempt_check_callbacks();
 	if (rcu_pending())
@@ -3078,34 +3053,6 @@ void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu_sched);
 
-/**
- * call_rcu_bh() - Queue an RCU for invocation after a quicker grace period.
- * @head: structure to be used for queueing the RCU updates.
- * @func: actual callback function to be invoked after the grace period
- *
- * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_bh() assumes
- * that the read-side critical sections end on completion of a softirq
- * handler. This means that read-side critical sections in process
- * context must not be interrupted by softirqs. This interface is to be
- * used when most of the read-side critical sections are in softirq context.
- * RCU read-side critical sections are delimited by:
- *
- * - rcu_read_lock() and  rcu_read_unlock(), if in interrupt context, OR
- * - rcu_read_lock_bh() and rcu_read_unlock_bh(), if in process context.
- *
- * These may be nested.
- *
- * See the description of call_rcu() for more detailed information on
- * memory ordering guarantees.
- */
-void call_rcu_bh(struct rcu_head *head, rcu_callback_t func)
-{
-	__call_rcu(head, func, &rcu_bh_state, -1, 0);
-}
-EXPORT_SYMBOL_GPL(call_rcu_bh);
-
 /*
  * Queue an RCU callback for lazy invocation after a grace period.
  * This will likely be later named something like "call_rcu_lazy()",
@@ -3190,33 +3137,6 @@ void synchronize_sched(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_sched);
 
-/**
- * synchronize_rcu_bh - wait until an rcu_bh grace period has elapsed.
- *
- * Control will return to the caller some time after a full rcu_bh grace
- * period has elapsed, in other words after all currently executing rcu_bh
- * read-side critical sections have completed.  RCU read-side critical
- * sections are delimited by rcu_read_lock_bh() and rcu_read_unlock_bh(),
- * and may be nested.
- *
- * See the description of synchronize_sched() for more detailed information
- * on memory ordering guarantees.
- */
-void synchronize_rcu_bh(void)
-{
-	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
-			 lock_is_held(&rcu_lock_map) ||
-			 lock_is_held(&rcu_sched_lock_map),
-			 "Illegal synchronize_rcu_bh() in RCU-bh read-side critical section");
-	if (rcu_blocking_is_gp())
-		return;
-	if (rcu_gp_is_expedited())
-		synchronize_rcu_bh_expedited();
-	else
-		wait_rcu_gp(call_rcu_bh);
-}
-EXPORT_SYMBOL_GPL(synchronize_rcu_bh);
-
 /**
  * get_state_synchronize_rcu - Snapshot current RCU state
  *
@@ -3528,7 +3448,7 @@ static void _rcu_barrier(struct rcu_state *rsp)
  */
 void rcu_barrier_bh(void)
 {
-	_rcu_barrier(&rcu_bh_state);
+	_rcu_barrier(rcu_state_p);
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_bh);
 
@@ -4179,7 +4099,6 @@ void __init rcu_init(void)
 
 	rcu_bootup_announce();
 	rcu_init_geometry();
-	rcu_init_one(&rcu_bh_state);
 	rcu_init_one(&rcu_sched_state);
 	if (dump_tree)
 		rcu_dump_rcu_node_tree(&rcu_sched_state);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0d7107fb3dec..1ff742a3c8d1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1320,7 +1320,6 @@ static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
 static void rcu_kthread_do_work(void)
 {
 	rcu_do_batch(&rcu_sched_state, this_cpu_ptr(&rcu_sched_data));
-	rcu_do_batch(&rcu_bh_state, this_cpu_ptr(&rcu_bh_data));
 	rcu_do_batch(&rcu_preempt_state, this_cpu_ptr(&rcu_preempt_data));
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index ebd69694144a..7a0720a20003 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -301,7 +301,6 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		pending >>= softirq_bit;
 	}
 
-	rcu_bh_qs();
 	if (__this_cpu_read(ksoftirqd) == current)
 		rcu_softirq_qs();
 	local_irq_disable();
-- 
2.17.1

