Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE59C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955D420647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955D420647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeH3DG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:06:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727498AbeH3DG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:06:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TN3qTa055702
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:43 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m627rd9ym-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:43 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 19:07:42 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 19:07:38 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TN7bZE24772742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 23:07:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E795B2072;
        Wed, 29 Aug 2018 19:06:33 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09270B205F;
        Wed, 29 Aug 2018 19:06:33 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 463DF16C91CC; Wed, 29 Aug 2018 16:07:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 08/10] rcu: Switch ->dynticks to rcu_data structure, remove rcu_dynticks
Date:   Wed, 29 Aug 2018 16:07:33 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829230715.GA9431@linux.vnet.ibm.com>
References: <20180829230715.GA9431@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082923-2213-0000-0000-000002E50ACD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080754; UDB=6.00557503; IPR=6.00860739;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 23:07:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082923-2214-0000-0000-00005B603BD4
Message-Id: <20180829230735.10256-8-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit move ->dynticks from the rcu_dynticks structure to the
rcu_data structure, replacing the field of the same name.  It also updates
the code to access ->dynticks from the rcu_data structure and to use the
rcu_data structure rather than following to now-gone ->dynticks field
to the now-gone rcu_dynticks structure.  While in the area, this commit
also fixes up comments.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 92 ++++++++++++++++++----------------------
 kernel/rcu/tree.h        | 35 ++++++---------
 kernel/rcu/tree_exp.h    |  6 +--
 kernel/rcu/tree_plugin.h |  3 +-
 4 files changed, 56 insertions(+), 80 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35326d1005eb..ad09707d99ee 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -73,9 +73,20 @@
 
 /* Data structures. */
 
+/*
+ * Steal a bit from the bottom of ->dynticks for idle entry/exit
+ * control.  Initially this is for TLB flushing.
+ */
+#define RCU_DYNTICK_CTRL_MASK 0x1
+#define RCU_DYNTICK_CTRL_CTR  (RCU_DYNTICK_CTRL_MASK + 1)
+#ifndef rcu_eqs_special_exit
+#define rcu_eqs_special_exit() do { } while (0)
+#endif
+
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
+	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
 };
 struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
@@ -202,27 +213,13 @@ void rcu_softirq_qs(void)
 	rcu_preempt_deferred_qs(current);
 }
 
-/*
- * Steal a bit from the bottom of ->dynticks for idle entry/exit
- * control.  Initially this is for TLB flushing.
- */
-#define RCU_DYNTICK_CTRL_MASK 0x1
-#define RCU_DYNTICK_CTRL_CTR  (RCU_DYNTICK_CTRL_MASK + 1)
-#ifndef rcu_eqs_special_exit
-#define rcu_eqs_special_exit() do { } while (0)
-#endif
-
-static DEFINE_PER_CPU(struct rcu_dynticks, rcu_dynticks) = {
-	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
-};
-
 /*
  * Record entry into an extended quiescent state.  This is only to be
  * called when not already in an extended quiescent state.
  */
 static void rcu_dynticks_eqs_enter(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int seq;
 
 	/*
@@ -230,7 +227,7 @@ static void rcu_dynticks_eqs_enter(void)
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
-	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdtp->dynticks);
+	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
 	/* Better be in an extended quiescent state! */
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     (seq & RCU_DYNTICK_CTRL_CTR));
@@ -245,7 +242,7 @@ static void rcu_dynticks_eqs_enter(void)
  */
 static void rcu_dynticks_eqs_exit(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int seq;
 
 	/*
@@ -253,11 +250,11 @@ static void rcu_dynticks_eqs_exit(void)
 	 * and we also must force ordering with the next RCU read-side
 	 * critical section.
 	 */
-	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdtp->dynticks);
+	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     !(seq & RCU_DYNTICK_CTRL_CTR));
 	if (seq & RCU_DYNTICK_CTRL_MASK) {
-		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdtp->dynticks);
+		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
 		smp_mb__after_atomic(); /* _exit after clearing mask. */
 		/* Prefer duplicate flushes to losing a flush. */
 		rcu_eqs_special_exit();
@@ -276,11 +273,11 @@ static void rcu_dynticks_eqs_exit(void)
  */
 static void rcu_dynticks_eqs_online(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	if (atomic_read(&rdtp->dynticks) & RCU_DYNTICK_CTRL_CTR)
+	if (atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR)
 		return;
-	atomic_add(RCU_DYNTICK_CTRL_CTR, &rdtp->dynticks);
+	atomic_add(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
 }
 
 /*
@@ -290,18 +287,18 @@ static void rcu_dynticks_eqs_online(void)
  */
 bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	return !(atomic_read(&rdtp->dynticks) & RCU_DYNTICK_CTRL_CTR);
+	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
 }
 
 /*
  * Snapshot the ->dynticks counter with full ordering so as to allow
  * stable comparison of this counter with past and future snapshots.
  */
-int rcu_dynticks_snap(struct rcu_dynticks *rdtp)
+int rcu_dynticks_snap(struct rcu_data *rdp)
 {
-	int snap = atomic_add_return(0, &rdtp->dynticks);
+	int snap = atomic_add_return(0, &rdp->dynticks);
 
 	return snap & ~RCU_DYNTICK_CTRL_MASK;
 }
@@ -316,13 +313,13 @@ static bool rcu_dynticks_in_eqs(int snap)
 }
 
 /*
- * Return true if the CPU corresponding to the specified rcu_dynticks
+ * Return true if the CPU corresponding to the specified rcu_data
  * structure has spent some time in an extended quiescent state since
  * rcu_dynticks_snap() returned the specified snapshot.
  */
-static bool rcu_dynticks_in_eqs_since(struct rcu_dynticks *rdtp, int snap)
+static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 {
-	return snap != rcu_dynticks_snap(rdtp);
+	return snap != rcu_dynticks_snap(rdp);
 }
 
 /*
@@ -336,14 +333,14 @@ bool rcu_eqs_special_set(int cpu)
 {
 	int old;
 	int new;
-	struct rcu_dynticks *rdtp = &per_cpu(rcu_dynticks, cpu);
+	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
 
 	do {
-		old = atomic_read(&rdtp->dynticks);
+		old = atomic_read(&rdp->dynticks);
 		if (old & RCU_DYNTICK_CTRL_CTR)
 			return false;
 		new = old | RCU_DYNTICK_CTRL_MASK;
-	} while (atomic_cmpxchg(&rdtp->dynticks, old, new) != old);
+	} while (atomic_cmpxchg(&rdp->dynticks, old, new) != old);
 	return true;
 }
 
@@ -360,11 +357,11 @@ bool rcu_eqs_special_set(int cpu)
  */
 static void __maybe_unused rcu_momentary_dyntick_idle(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	int special;
 
 	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
-	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR, &rdtp->dynticks);
+	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR,
+				    &this_cpu_ptr(&rcu_data)->dynticks);
 	/* It is illegal to call this from idle state. */
 	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
 	rcu_preempt_deferred_qs(current);
@@ -573,9 +570,7 @@ static struct rcu_node *rcu_get_root(void)
 static void rcu_eqs_enter(bool user)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	struct rcu_dynticks *rdtp;
 
-	rdtp = this_cpu_ptr(&rcu_dynticks);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
@@ -586,7 +581,7 @@ static void rcu_eqs_enter(bool user)
 	}
 
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdtp->dynticks);
+	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rdp = this_cpu_ptr(&rcu_data);
 	do_nocb_deferred_wakeup(rdp);
@@ -638,7 +633,7 @@ void rcu_user_enter(void)
  * @irq: Is this call from rcu_irq_exit?
  *
  * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update rdtp->dynticks and rdp->dynticks_nmi_nesting
+ * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
@@ -648,7 +643,6 @@ void rcu_user_enter(void)
 static __always_inline void rcu_nmi_exit_common(bool irq)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	struct rcu_dynticks __maybe_unused *rdtp = this_cpu_ptr(&rcu_dynticks);
 
 	/*
 	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
@@ -663,14 +657,14 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 * leave it in non-RCU-idle state.
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
-		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdtp->dynticks);
+		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdtp->dynticks);
+	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdp->dynticks);
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	if (irq)
@@ -741,11 +735,9 @@ void rcu_irq_exit_irqson(void)
 static void rcu_eqs_exit(bool user)
 {
 	struct rcu_data *rdp;
-	struct rcu_dynticks *rdtp;
 	long oldval;
 
 	lockdep_assert_irqs_disabled();
-	rdtp = this_cpu_ptr(&rcu_dynticks);
 	rdp = this_cpu_ptr(&rcu_data);
 	oldval = rdp->dynticks_nesting;
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
@@ -756,7 +748,7 @@ static void rcu_eqs_exit(bool user)
 	rcu_dynticks_task_exit();
 	rcu_dynticks_eqs_exit();
 	rcu_cleanup_after_idle();
-	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdtp->dynticks);
+	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
@@ -801,7 +793,7 @@ void rcu_user_exit(void)
  * rcu_nmi_enter_common - inform RCU of entry to NMI context
  * @irq: Is this call from rcu_irq_enter?
  *
- * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
+ * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
  * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
  * that the CPU is active.  This implementation permits nested NMIs, as
  * long as the nesting level does not overflow an int.  (You will probably
@@ -813,7 +805,6 @@ void rcu_user_exit(void)
 static __always_inline void rcu_nmi_enter_common(bool irq)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	struct rcu_dynticks __maybe_unused *rdtp = this_cpu_ptr(&rcu_dynticks);
 	long incby = 2;
 
 	/* Complain about underflow. */
@@ -841,7 +832,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
-			  rdp->dynticks_nmi_nesting + incby, rdtp->dynticks);
+			  rdp->dynticks_nmi_nesting + incby, rdp->dynticks);
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nmi_nesting + incby);
 	barrier();
@@ -994,7 +985,7 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
  */
 static int dyntick_save_progress_counter(struct rcu_data *rdp)
 {
-	rdp->dynticks_snap = rcu_dynticks_snap(rdp->dynticks);
+	rdp->dynticks_snap = rcu_dynticks_snap(rdp);
 	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
@@ -1045,7 +1036,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * read-side critical section that started before the beginning
 	 * of the current RCU grace period.
 	 */
-	if (rcu_dynticks_in_eqs_since(rdp->dynticks, rdp->dynticks_snap)) {
+	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rdp->dynticks_fqs++;
 		rcu_gpnum_ovf(rnp, rdp);
@@ -3197,9 +3188,8 @@ rcu_boot_init_percpu_data(int cpu)
 
 	/* Set up local state, ensuring consistent view of global state. */
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
-	rdp->dynticks = &per_cpu(rcu_dynticks, cpu);
 	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
-	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp->dynticks)));
+	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp)));
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_flags = RCU_GP_CLEANED;
 	rdp->rcu_onl_gp_seq = rcu_state.gp_seq;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2e5eec48a94a..af8681fec23b 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -34,13 +34,6 @@
 
 #include "rcu_segcblist.h"
 
-/*
- * Dynticks per-CPU state.
- */
-struct rcu_dynticks {
-	atomic_t dynticks;	    /* Even value for idle, else odd. */
-};
-
 /* Communicate arguments to a workqueue handler. */
 struct rcu_exp_work {
 	smp_call_func_t rew_func;
@@ -194,24 +187,20 @@ struct rcu_data {
 	long		blimit;		/* Upper limit on a processed batch */
 
 	/* 3) dynticks interface. */
-	struct rcu_dynticks *dynticks;	/* Shared per-CPU dynticks state. */
 	int dynticks_snap;		/* Per-GP tracking for dynticks. */
-	long dynticks_nesting;      /* Track process nesting level. */
-	long dynticks_nmi_nesting;  /* Track irq/NMI nesting level. */
-	// atomic_t dynticks;	    /* Even value for idle, else odd. */
-	bool rcu_need_heavy_qs;     /* GP old, need heavy quiescent state. */
-	bool rcu_urgent_qs;	    /* GP old need light quiescent state. */
+	long dynticks_nesting;		/* Track process nesting level. */
+	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
+	atomic_t dynticks;		/* Even value for idle, else odd. */
+	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
+	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 #ifdef CONFIG_RCU_FAST_NO_HZ
-	bool all_lazy;		    /* Are all CPU's CBs lazy? */
-	unsigned long nonlazy_posted;
-				    /* # times non-lazy CBs posted to CPU. */
+	bool all_lazy;			/* Are all CPU's CBs lazy? */
+	unsigned long nonlazy_posted;	/* # times non-lazy CB posted to CPU. */
 	unsigned long nonlazy_posted_snap;
-				    /* idle-period nonlazy_posted snapshot. */
-	unsigned long last_accelerate;
-				    /* Last jiffy CBs were accelerated. */
-	unsigned long last_advance_all;
-				    /* Last jiffy CBs were all advanced. */
-	int tick_nohz_enabled_snap; /* Previously seen value from sysfs. */
+					/* Nonlazy_posted snapshot. */
+	unsigned long last_accelerate;	/* Last jiffy CBs were accelerated. */
+	unsigned long last_advance_all;	/* Last jiffy CBs were all advanced. */
+	int tick_nohz_enabled_snap;	/* Previously seen value from sysfs. */
 #endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
 
 	/* 4) reasons this CPU needed to be kicked by force_quiescent_state */
@@ -426,7 +415,7 @@ extern struct rcu_state rcu_bh_state;
 extern struct rcu_state rcu_preempt_state;
 #endif /* #ifdef CONFIG_PREEMPT_RCU */
 
-int rcu_dynticks_snap(struct rcu_dynticks *rdtp);
+int rcu_dynticks_snap(struct rcu_data *rdp);
 
 #ifdef CONFIG_RCU_BOOST
 DECLARE_PER_CPU(unsigned int, rcu_cpu_kthread_status);
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 11387fcd4d85..8d18c1014e2b 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -360,14 +360,13 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
 		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-		struct rcu_dynticks *rdtp = per_cpu_ptr(&rcu_dynticks, cpu);
 		int snap;
 
 		if (raw_smp_processor_id() == cpu ||
 		    !(rnp->qsmaskinitnext & mask)) {
 			mask_ofl_test |= mask;
 		} else {
-			snap = rcu_dynticks_snap(rdtp);
+			snap = rcu_dynticks_snap(rdp);
 			if (rcu_dynticks_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
@@ -393,8 +392,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 		if (!(mask_ofl_ipi & mask))
 			continue;
 retry_ipi:
-		if (rcu_dynticks_in_eqs_since(rdp->dynticks,
-					      rdp->exp_dynticks_snap)) {
+		if (rcu_dynticks_in_eqs_since(rdp, rdp->exp_dynticks_snap)) {
 			mask_ofl_test |= mask;
 			continue;
 		}
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7087ee3e1ea5..05915e536336 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1802,7 +1802,6 @@ static void print_cpu_stall_info(int cpu)
 	unsigned long delta;
 	char fast_no_hz[72];
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_dynticks *rdtp = rdp->dynticks;
 	char *ticks_title;
 	unsigned long ticks_value;
 
@@ -1830,7 +1829,7 @@ static void print_cpu_stall_info(int cpu)
 			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
 				"!."[!delta],
 	       ticks_value, ticks_title,
-	       rcu_dynticks_snap(rdtp) & 0xfff,
+	       rcu_dynticks_snap(rdp) & 0xfff,
 	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       READ_ONCE(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-- 
2.17.1

