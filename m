Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12483C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9FF20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9FF20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeH3Cim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727588AbeH3CiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMciwr016506
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:07 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64f000q4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:06 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:05 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcwSa46268500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80E85B2078;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46F36B206A;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BEC9016C91D4; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 47/52] rcu: Eliminate grace-period management code use of rsp
Date:   Wed, 29 Aug 2018 15:38:49 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0052-0000-0000-0000032820CF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0053-0000-0000-00005DE5FB28
Message-Id: <20180829223854.4055-47-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is only one rcu_state structure, there is less point
in maintaining a pointer to it.  This commit therefore replaces
rsp with &rcu_state in rcu_start_this_gp(), rcu_accelerate_cbs(),
__note_gp_changes(), rcu_gp_init(), rcu_gp_fqs(), rcu_gp_cleanup(),
rcu_gp_kthread(), and rcu_report_qs_rsp().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 168 ++++++++++++++++++++++------------------------
 1 file changed, 82 insertions(+), 86 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ccef04bf1636..734cd95368e6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1524,7 +1524,6 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 			      unsigned long gp_seq_req)
 {
 	bool ret = false;
-	struct rcu_state *rsp = &rcu_state;
 	struct rcu_node *rnp;
 
 	/*
@@ -1573,13 +1572,13 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 		goto unlock_out;
 	}
 	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
-	WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
-	rsp->gp_req_activity = jiffies;
-	if (!rsp->gp_kthread) {
+	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | RCU_GP_FLAG_INIT);
+	rcu_state.gp_req_activity = jiffies;
+	if (!rcu_state.gp_kthread) {
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
-	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
+	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rcu_state.gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
@@ -1641,7 +1640,6 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	unsigned long gp_seq_req;
 	bool ret = false;
-	struct rcu_state *rsp = &rcu_state;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1659,15 +1657,15 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	gp_seq_req = rcu_seq_snap(&rsp->gp_seq);
+	gp_seq_req = rcu_seq_snap(&rcu_state.gp_seq);
 	if (rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req))
 		ret = rcu_start_this_gp(rnp, rdp, gp_seq_req);
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("AccWaitCB"));
+		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccWaitCB"));
 	else
-		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("AccReadyCB"));
+		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccReadyCB"));
 	return ret;
 }
 
@@ -1736,7 +1734,6 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret;
 	bool need_gp;
-	struct rcu_state __maybe_unused *rsp = &rcu_state;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1747,7 +1744,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
 	    unlikely(READ_ONCE(rdp->gpwrap))) {
 		ret = rcu_advance_cbs(rnp, rdp); /* Advance callbacks. */
-		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpuend"));
+		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuend"));
 	} else {
 		ret = rcu_accelerate_cbs(rnp, rdp); /* Recent callbacks. */
 	}
@@ -1760,7 +1757,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 		 * set up to detect a quiescent state, otherwise don't
 		 * go looking for one.
 		 */
-		trace_rcu_grace_period(rsp->name, rnp->gp_seq, TPS("cpustart"));
+		trace_rcu_grace_period(rcu_state.name, rnp->gp_seq, TPS("cpustart"));
 		need_gp = !!(rnp->qsmask & rdp->grpmask);
 		rdp->cpu_no_qs.b.norm = need_gp;
 		rdp->rcu_qs_ctr_snap = __this_cpu_read(rcu_dynticks.rcu_qs_ctr);
@@ -1813,16 +1810,15 @@ static bool rcu_gp_init(void)
 	unsigned long mask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root();
-	struct rcu_state *rsp = &rcu_state;
 
-	WRITE_ONCE(rsp->gp_activity, jiffies);
+	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	raw_spin_lock_irq_rcu_node(rnp);
-	if (!READ_ONCE(rsp->gp_flags)) {
+	if (!READ_ONCE(rcu_state.gp_flags)) {
 		/* Spurious wakeup, tell caller to go back to sleep.  */
 		raw_spin_unlock_irq_rcu_node(rnp);
 		return false;
 	}
-	WRITE_ONCE(rsp->gp_flags, 0); /* Clear all flags: New grace period. */
+	WRITE_ONCE(rcu_state.gp_flags, 0); /* Clear all flags: New GP. */
 
 	if (WARN_ON_ONCE(rcu_gp_in_progress())) {
 		/*
@@ -1836,8 +1832,8 @@ static bool rcu_gp_init(void)
 	/* Advance to a new grace period and initialize state. */
 	record_gp_stall_check_time();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
-	rcu_seq_start(&rsp->gp_seq);
-	trace_rcu_grace_period(rsp->name, rsp->gp_seq, TPS("start"));
+	rcu_seq_start(&rcu_state.gp_seq);
+	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
@@ -1846,15 +1842,15 @@ static bool rcu_gp_init(void)
 	 * for subsequent online CPUs, and that quiescent-state forcing
 	 * will handle subsequent offline CPUs.
 	 */
-	rsp->gp_state = RCU_GP_ONOFF;
+	rcu_state.gp_state = RCU_GP_ONOFF;
 	rcu_for_each_leaf_node(rnp) {
-		spin_lock(&rsp->ofl_lock);
+		spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
 		    !rnp->wait_blkd_tasks) {
 			/* Nothing to do on this leaf rcu_node structure. */
 			raw_spin_unlock_irq_rcu_node(rnp);
-			spin_unlock(&rsp->ofl_lock);
+			spin_unlock(&rcu_state.ofl_lock);
 			continue;
 		}
 
@@ -1890,34 +1886,34 @@ static bool rcu_gp_init(void)
 		}
 
 		raw_spin_unlock_irq_rcu_node(rnp);
-		spin_unlock(&rsp->ofl_lock);
+		spin_unlock(&rcu_state.ofl_lock);
 	}
 	rcu_gp_slow(gp_preinit_delay); /* Races with CPU hotplug. */
 
 	/*
 	 * Set the quiescent-state-needed bits in all the rcu_node
-	 * structures for all currently online CPUs in breadth-first order,
-	 * starting from the root rcu_node structure, relying on the layout
-	 * of the tree within the rsp->node[] array.  Note that other CPUs
-	 * will access only the leaves of the hierarchy, thus seeing that no
-	 * grace period is in progress, at least until the corresponding
-	 * leaf node has been initialized.
+	 * structures for all currently online CPUs in breadth-first
+	 * order, starting from the root rcu_node structure, relying on the
+	 * layout of the tree within the rcu_state.node[] array.  Note that
+	 * other CPUs will access only the leaves of the hierarchy, thus
+	 * seeing that no grace period is in progress, at least until the
+	 * corresponding leaf node has been initialized.
 	 *
 	 * The grace period cannot complete until the initialization
 	 * process finishes, because this kthread handles both.
 	 */
-	rsp->gp_state = RCU_GP_INIT;
+	rcu_state.gp_state = RCU_GP_INIT;
 	rcu_for_each_node_breadth_first(rnp) {
 		rcu_gp_slow(gp_init_delay);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rdp = this_cpu_ptr(&rcu_data);
 		rcu_preempt_check_blocked_tasks(rnp);
 		rnp->qsmask = rnp->qsmaskinit;
-		WRITE_ONCE(rnp->gp_seq, rsp->gp_seq);
+		WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
 		if (rnp == rdp->mynode)
 			(void)__note_gp_changes(rnp, rdp);
 		rcu_preempt_boost_start_gp(rnp);
-		trace_rcu_grace_period_init(rsp->name, rnp->gp_seq,
+		trace_rcu_grace_period_init(rcu_state.name, rnp->gp_seq,
 					    rnp->level, rnp->grplo,
 					    rnp->grphi, rnp->qsmask);
 		/* Quiescent states for tasks on any now-offline CPUs. */
@@ -1928,7 +1924,7 @@ static bool rcu_gp_init(void)
 		else
 			raw_spin_unlock_irq_rcu_node(rnp);
 		cond_resched_tasks_rcu_qs();
-		WRITE_ONCE(rsp->gp_activity, jiffies);
+		WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	}
 
 	return true;
@@ -1960,10 +1956,9 @@ static bool rcu_gp_fqs_check_wake(int *gfp)
 static void rcu_gp_fqs(bool first_time)
 {
 	struct rcu_node *rnp = rcu_get_root();
-	struct rcu_state *rsp = &rcu_state;
 
-	WRITE_ONCE(rsp->gp_activity, jiffies);
-	rsp->n_force_qs++;
+	WRITE_ONCE(rcu_state.gp_activity, jiffies);
+	rcu_state.n_force_qs++;
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
 		force_qs_rnp(dyntick_save_progress_counter);
@@ -1972,10 +1967,10 @@ static void rcu_gp_fqs(bool first_time)
 		force_qs_rnp(rcu_implicit_dynticks_qs);
 	}
 	/* Clear flag to prevent immediate re-entry. */
-	if (READ_ONCE(rsp->gp_flags) & RCU_GP_FLAG_FQS) {
+	if (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) {
 		raw_spin_lock_irq_rcu_node(rnp);
-		WRITE_ONCE(rsp->gp_flags,
-			   READ_ONCE(rsp->gp_flags) & ~RCU_GP_FLAG_FQS);
+		WRITE_ONCE(rcu_state.gp_flags,
+			   READ_ONCE(rcu_state.gp_flags) & ~RCU_GP_FLAG_FQS);
 		raw_spin_unlock_irq_rcu_node(rnp);
 	}
 }
@@ -1990,14 +1985,13 @@ static void rcu_gp_cleanup(void)
 	unsigned long new_gp_seq;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root();
-	struct rcu_state *rsp = &rcu_state;
 	struct swait_queue_head *sq;
 
-	WRITE_ONCE(rsp->gp_activity, jiffies);
+	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	raw_spin_lock_irq_rcu_node(rnp);
-	gp_duration = jiffies - rsp->gp_start;
-	if (gp_duration > rsp->gp_max)
-		rsp->gp_max = gp_duration;
+	gp_duration = jiffies - rcu_state.gp_start;
+	if (gp_duration > rcu_state.gp_max)
+		rcu_state.gp_max = gp_duration;
 
 	/*
 	 * We know the grace period is complete, but to everyone else
@@ -2018,7 +2012,7 @@ static void rcu_gp_cleanup(void)
 	 * the rcu_node structures before the beginning of the next grace
 	 * period is recorded in any of the rcu_node structures.
 	 */
-	new_gp_seq = rsp->gp_seq;
+	new_gp_seq = rcu_state.gp_seq;
 	rcu_seq_end(&new_gp_seq);
 	rcu_for_each_node_breadth_first(rnp) {
 		raw_spin_lock_irq_rcu_node(rnp);
@@ -2035,16 +2029,16 @@ static void rcu_gp_cleanup(void)
 		raw_spin_unlock_irq_rcu_node(rnp);
 		rcu_nocb_gp_cleanup(sq);
 		cond_resched_tasks_rcu_qs();
-		WRITE_ONCE(rsp->gp_activity, jiffies);
+		WRITE_ONCE(rcu_state.gp_activity, jiffies);
 		rcu_gp_slow(gp_cleanup_delay);
 	}
 	rnp = rcu_get_root();
-	raw_spin_lock_irq_rcu_node(rnp); /* GP before rsp->gp_seq update. */
+	raw_spin_lock_irq_rcu_node(rnp); /* GP before ->gp_seq update. */
 
 	/* Declare grace period done. */
-	rcu_seq_end(&rsp->gp_seq);
-	trace_rcu_grace_period(rsp->name, rsp->gp_seq, TPS("end"));
-	rsp->gp_state = RCU_GP_IDLE;
+	rcu_seq_end(&rcu_state.gp_seq);
+	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
+	rcu_state.gp_state = RCU_GP_IDLE;
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(&rcu_data);
 	if (!needgp && ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
@@ -2054,12 +2048,14 @@ static void rcu_gp_cleanup(void)
 	}
 	/* Advance CBs to reduce false positives below. */
 	if (!rcu_accelerate_cbs(rnp, rdp) && needgp) {
-		WRITE_ONCE(rsp->gp_flags, RCU_GP_FLAG_INIT);
-		rsp->gp_req_activity = jiffies;
-		trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq),
+		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
+		rcu_state.gp_req_activity = jiffies;
+		trace_rcu_grace_period(rcu_state.name,
+				       READ_ONCE(rcu_state.gp_seq),
 				       TPS("newreq"));
 	} else {
-		WRITE_ONCE(rsp->gp_flags, rsp->gp_flags & RCU_GP_FLAG_INIT);
+		WRITE_ONCE(rcu_state.gp_flags,
+			   rcu_state.gp_flags & RCU_GP_FLAG_INIT);
 	}
 	raw_spin_unlock_irq_rcu_node(rnp);
 }
@@ -2073,7 +2069,6 @@ static int __noreturn rcu_gp_kthread(void *unused)
 	int gf;
 	unsigned long j;
 	int ret;
-	struct rcu_state *rsp = &rcu_state;
 	struct rcu_node *rnp = rcu_get_root();
 
 	rcu_bind_gp_kthread();
@@ -2081,21 +2076,22 @@ static int __noreturn rcu_gp_kthread(void *unused)
 
 		/* Handle grace-period start. */
 		for (;;) {
-			trace_rcu_grace_period(rsp->name,
-					       READ_ONCE(rsp->gp_seq),
+			trace_rcu_grace_period(rcu_state.name,
+					       READ_ONCE(rcu_state.gp_seq),
 					       TPS("reqwait"));
-			rsp->gp_state = RCU_GP_WAIT_GPS;
-			swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
-						     RCU_GP_FLAG_INIT);
-			rsp->gp_state = RCU_GP_DONE_GPS;
+			rcu_state.gp_state = RCU_GP_WAIT_GPS;
+			swait_event_idle_exclusive(rcu_state.gp_wq,
+					 READ_ONCE(rcu_state.gp_flags) &
+					 RCU_GP_FLAG_INIT);
+			rcu_state.gp_state = RCU_GP_DONE_GPS;
 			/* Locking provides needed memory barrier. */
 			if (rcu_gp_init())
 				break;
 			cond_resched_tasks_rcu_qs();
-			WRITE_ONCE(rsp->gp_activity, jiffies);
+			WRITE_ONCE(rcu_state.gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
-			trace_rcu_grace_period(rsp->name,
-					       READ_ONCE(rsp->gp_seq),
+			trace_rcu_grace_period(rcu_state.name,
+					       READ_ONCE(rcu_state.gp_seq),
 					       TPS("reqwaitsig"));
 		}
 
@@ -2105,58 +2101,59 @@ static int __noreturn rcu_gp_kthread(void *unused)
 		ret = 0;
 		for (;;) {
 			if (!ret) {
-				rsp->jiffies_force_qs = jiffies + j;
-				WRITE_ONCE(rsp->jiffies_kick_kthreads,
+				rcu_state.jiffies_force_qs = jiffies + j;
+				WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
 					   jiffies + 3 * j);
 			}
-			trace_rcu_grace_period(rsp->name,
-					       READ_ONCE(rsp->gp_seq),
+			trace_rcu_grace_period(rcu_state.name,
+					       READ_ONCE(rcu_state.gp_seq),
 					       TPS("fqswait"));
-			rsp->gp_state = RCU_GP_WAIT_FQS;
-			ret = swait_event_idle_timeout_exclusive(rsp->gp_wq,
+			rcu_state.gp_state = RCU_GP_WAIT_FQS;
+			ret = swait_event_idle_timeout_exclusive(rcu_state.gp_wq,
 					rcu_gp_fqs_check_wake(&gf), j);
-			rsp->gp_state = RCU_GP_DOING_FQS;
+			rcu_state.gp_state = RCU_GP_DOING_FQS;
 			/* Locking provides needed memory barriers. */
 			/* If grace period done, leave loop. */
 			if (!READ_ONCE(rnp->qsmask) &&
 			    !rcu_preempt_blocked_readers_cgp(rnp))
 				break;
 			/* If time for quiescent-state forcing, do it. */
-			if (ULONG_CMP_GE(jiffies, rsp->jiffies_force_qs) ||
+			if (ULONG_CMP_GE(jiffies, rcu_state.jiffies_force_qs) ||
 			    (gf & RCU_GP_FLAG_FQS)) {
-				trace_rcu_grace_period(rsp->name,
-						       READ_ONCE(rsp->gp_seq),
+				trace_rcu_grace_period(rcu_state.name,
+						       READ_ONCE(rcu_state.gp_seq),
 						       TPS("fqsstart"));
 				rcu_gp_fqs(first_gp_fqs);
 				first_gp_fqs = false;
-				trace_rcu_grace_period(rsp->name,
-						       READ_ONCE(rsp->gp_seq),
+				trace_rcu_grace_period(rcu_state.name,
+						       READ_ONCE(rcu_state.gp_seq),
 						       TPS("fqsend"));
 				cond_resched_tasks_rcu_qs();
-				WRITE_ONCE(rsp->gp_activity, jiffies);
+				WRITE_ONCE(rcu_state.gp_activity, jiffies);
 				ret = 0; /* Force full wait till next FQS. */
 				j = jiffies_till_next_fqs;
 			} else {
 				/* Deal with stray signal. */
 				cond_resched_tasks_rcu_qs();
-				WRITE_ONCE(rsp->gp_activity, jiffies);
+				WRITE_ONCE(rcu_state.gp_activity, jiffies);
 				WARN_ON(signal_pending(current));
-				trace_rcu_grace_period(rsp->name,
-						       READ_ONCE(rsp->gp_seq),
+				trace_rcu_grace_period(rcu_state.name,
+						       READ_ONCE(rcu_state.gp_seq),
 						       TPS("fqswaitsig"));
 				ret = 1; /* Keep old FQS timing. */
 				j = jiffies;
-				if (time_after(jiffies, rsp->jiffies_force_qs))
+				if (time_after(jiffies,
+					       rcu_state.jiffies_force_qs))
 					j = 1;
 				else
-					j = rsp->jiffies_force_qs - j;
+					j = rcu_state.jiffies_force_qs - j;
 			}
 		}
 
 		/* Handle grace-period end. */
-		rsp->gp_state = RCU_GP_CLEANUP;
+		rcu_state.gp_state = RCU_GP_CLEANUP;
 		rcu_gp_cleanup();
-		rsp->gp_state = RCU_GP_CLEANED;
+		rcu_state.gp_state = RCU_GP_CLEANED;
 	}
 }
 
@@ -2172,11 +2169,10 @@ static int __noreturn rcu_gp_kthread(void *unused)
 static void rcu_report_qs_rsp(unsigned long flags)
 	__releases(rcu_get_root()->lock)
 {
-	struct rcu_state *rsp = &rcu_state;
-
 	raw_lockdep_assert_held_rcu_node(rcu_get_root());
 	WARN_ON_ONCE(!rcu_gp_in_progress());
-	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
+	WRITE_ONCE(rcu_state.gp_flags,
+		   READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(), flags);
 	rcu_gp_kthread_wake();
 }
-- 
2.17.1

