Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C33C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6492064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6492064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeH3DG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:06:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727375AbeH3DGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:06:55 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TN3rJb041289
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:42 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m629dw3s9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:42 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 19:07:42 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 19:07:38 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TN7bji27853048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 23:07:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39FAAB2070;
        Wed, 29 Aug 2018 19:06:33 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09EDFB2064;
        Wed, 29 Aug 2018 19:06:33 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4096C16C91CB; Wed, 29 Aug 2018 16:07:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 07/10] rcu: Switch dyntick nesting counters to rcu_data structure
Date:   Wed, 29 Aug 2018 16:07:32 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829230715.GA9431@linux.vnet.ibm.com>
References: <20180829230715.GA9431@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082923-0060-0000-0000-000002A66614
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080754; UDB=6.00557503; IPR=6.00860739;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 23:07:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082923-0061-0000-0000-00004655C51E
Message-Id: <20180829230735.10256-7-paulmck@linux.vnet.ibm.com>
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

This commit removes ->dynticks_nesting and ->dynticks_nmi_nesting from
the rcu_dynticks structure and updates the code to access them from the
rcu_data structure.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 79 +++++++++++++++++++++-------------------
 kernel/rcu/tree.h        |  2 -
 kernel/rcu/tree_plugin.h |  2 +-
 3 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 44f5e0a99e5a..35326d1005eb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -73,7 +73,10 @@
 
 /* Data structures. */
 
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
+	.dynticks_nesting = 1,
+	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
+};
 struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
 	.gp_state = RCU_GP_IDLE,
@@ -210,8 +213,6 @@ void rcu_softirq_qs(void)
 #endif
 
 static DEFINE_PER_CPU(struct rcu_dynticks, rcu_dynticks) = {
-	.dynticks_nesting = 1,
-	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
 };
 
@@ -378,8 +379,8 @@ static void __maybe_unused rcu_momentary_dyntick_idle(void)
  */
 static int rcu_is_cpu_rrupt_from_idle(void)
 {
-	return __this_cpu_read(rcu_dynticks.dynticks_nesting) <= 0 &&
-	       __this_cpu_read(rcu_dynticks.dynticks_nmi_nesting) <= 1;
+	return __this_cpu_read(rcu_data.dynticks_nesting) <= 0 &&
+	       __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
 }
 
 #define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch. */
@@ -571,27 +572,27 @@ static struct rcu_node *rcu_get_root(void)
  */
 static void rcu_eqs_enter(bool user)
 {
-	struct rcu_data *rdp;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_dynticks *rdtp;
 
 	rdtp = this_cpu_ptr(&rcu_dynticks);
-	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0);
+	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
+	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     rdtp->dynticks_nesting == 0);
-	if (rdtp->dynticks_nesting != 1) {
-		rdtp->dynticks_nesting--;
+		     rdp->dynticks_nesting == 0);
+	if (rdp->dynticks_nesting != 1) {
+		rdp->dynticks_nesting--;
 		return;
 	}
 
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), rdtp->dynticks_nesting, 0, rdtp->dynticks);
+	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdtp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rdp = this_cpu_ptr(&rcu_data);
 	do_nocb_deferred_wakeup(rdp);
 	rcu_prepare_for_idle();
 	rcu_preempt_deferred_qs(current);
-	WRITE_ONCE(rdtp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
+	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
 	rcu_dynticks_eqs_enter();
 	rcu_dynticks_task_enter();
 }
@@ -637,7 +638,7 @@ void rcu_user_enter(void)
  * @irq: Is this call from rcu_irq_exit?
  *
  * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
+ * RCU-idle period, update rdtp->dynticks and rdp->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
@@ -646,30 +647,31 @@ void rcu_user_enter(void)
  */
 static __always_inline void rcu_nmi_exit_common(bool irq)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct rcu_dynticks __maybe_unused *rdtp = this_cpu_ptr(&rcu_dynticks);
 
 	/*
 	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
-	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting <= 0);
+	WARN_ON_ONCE(rdp->dynticks_nmi_nesting <= 0);
 	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
 
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
 	 * leave it in non-RCU-idle state.
 	 */
-	if (rdtp->dynticks_nmi_nesting != 1) {
-		trace_rcu_dyntick(TPS("--="), rdtp->dynticks_nmi_nesting, rdtp->dynticks_nmi_nesting - 2, rdtp->dynticks);
-		WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* No store tearing. */
-			   rdtp->dynticks_nmi_nesting - 2);
+	if (rdp->dynticks_nmi_nesting != 1) {
+		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdtp->dynticks);
+		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
+			   rdp->dynticks_nmi_nesting - 2);
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdtp->dynticks);
+	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	if (irq)
 		rcu_prepare_for_idle();
@@ -738,25 +740,27 @@ void rcu_irq_exit_irqson(void)
  */
 static void rcu_eqs_exit(bool user)
 {
+	struct rcu_data *rdp;
 	struct rcu_dynticks *rdtp;
 	long oldval;
 
 	lockdep_assert_irqs_disabled();
 	rdtp = this_cpu_ptr(&rcu_dynticks);
-	oldval = rdtp->dynticks_nesting;
+	rdp = this_cpu_ptr(&rcu_data);
+	oldval = rdp->dynticks_nesting;
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
-		rdtp->dynticks_nesting++;
+		rdp->dynticks_nesting++;
 		return;
 	}
 	rcu_dynticks_task_exit();
 	rcu_dynticks_eqs_exit();
 	rcu_cleanup_after_idle();
-	trace_rcu_dyntick(TPS("End"), rdtp->dynticks_nesting, 1, rdtp->dynticks);
+	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdtp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	WRITE_ONCE(rdtp->dynticks_nesting, 1);
-	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
+	WRITE_ONCE(rdp->dynticks_nesting, 1);
+	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
+	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
 }
 
 /**
@@ -798,7 +802,7 @@ void rcu_user_exit(void)
  * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
- * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
+ * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
  * that the CPU is active.  This implementation permits nested NMIs, as
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
@@ -808,11 +812,12 @@ void rcu_user_exit(void)
  */
 static __always_inline void rcu_nmi_enter_common(bool irq)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	struct rcu_dynticks __maybe_unused *rdtp = this_cpu_ptr(&rcu_dynticks);
 	long incby = 2;
 
 	/* Complain about underflow. */
-	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting < 0);
+	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
 
 	/*
 	 * If idle from RCU viewpoint, atomically increment ->dynticks
@@ -835,10 +840,10 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		incby = 1;
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
-			  rdtp->dynticks_nmi_nesting,
-			  rdtp->dynticks_nmi_nesting + incby, rdtp->dynticks);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* Prevent store tearing. */
-		   rdtp->dynticks_nmi_nesting + incby);
+			  rdp->dynticks_nmi_nesting,
+			  rdp->dynticks_nmi_nesting + incby, rdtp->dynticks);
+	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
+		   rdp->dynticks_nmi_nesting + incby);
 	barrier();
 }
 
@@ -3193,7 +3198,7 @@ rcu_boot_init_percpu_data(int cpu)
 	/* Set up local state, ensuring consistent view of global state. */
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	rdp->dynticks = &per_cpu(rcu_dynticks, cpu);
-	WARN_ON_ONCE(rdp->dynticks->dynticks_nesting != 1);
+	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp->dynticks)));
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_flags = RCU_GP_CLEANED;
@@ -3226,7 +3231,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	if (rcu_segcblist_empty(&rdp->cblist) && /* No early-boot CBs? */
 	    !init_nocb_callback_list(rdp))
 		rcu_segcblist_init(&rdp->cblist);  /* Re-enable callbacks. */
-	rdp->dynticks->dynticks_nesting = 1;	/* CPU not up, no tearing. */
+	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
 	rcu_dynticks_eqs_online();
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4c31066ddb94..2e5eec48a94a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -38,8 +38,6 @@
  * Dynticks per-CPU state.
  */
 struct rcu_dynticks {
-	long dynticks_nesting;      /* Track process nesting level. */
-	long dynticks_nmi_nesting;  /* Track irq/NMI nesting level. */
 	atomic_t dynticks;	    /* Even value for idle, else odd. */
 };
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 161760957a07..7087ee3e1ea5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1831,7 +1831,7 @@ static void print_cpu_stall_info(int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       rcu_dynticks_snap(rdtp) & 0xfff,
-	       rdtp->dynticks_nesting, rdtp->dynticks_nmi_nesting,
+	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       READ_ONCE(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
 	       fast_no_hz);
-- 
2.17.1

