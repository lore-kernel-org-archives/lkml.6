Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90B5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D3A20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D3A20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeH3CjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:39:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727476AbeH3CiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcirX062067
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61x8d8a5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:03 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvcs27197468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA122B2067;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77E12B205F;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9C90A16C91CB; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 41/52] rcu: Remove rcu_data structure's ->rsp field
Date:   Wed, 29 Aug 2018 15:38:43 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0060-0000-0000-000002A6641E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0061-0000-0000-00004655B6B1
Message-Id: <20180829223854.4055-41-paulmck@linux.vnet.ibm.com>
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

Now that there is only one rcu_state structure, there is no need for the
rcu_data structure to indicate which it corresponds to.  This commit
therefore removes the rcu_data structure's ->rsp field, replacing all
remaining uses of it with &rcu_state.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 28 +++++++++++++--------------
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_plugin.h | 42 ++++++++++++++++++++--------------------
 3 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35b705c1da40..bc52f8c16faf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1069,7 +1069,7 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 {
 	rdp->dynticks_snap = rcu_dynticks_snap(rdp->dynticks);
 	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
-		trace_rcu_fqs(rdp->rsp->name, rdp->gp_seq, rdp->cpu, TPS("dti"));
+		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
 		return 1;
 	}
@@ -1119,7 +1119,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * of the current RCU grace period.
 	 */
 	if (rcu_dynticks_in_eqs_since(rdp->dynticks, rdp->dynticks_snap)) {
-		trace_rcu_fqs(rdp->rsp->name, rdp->gp_seq, rdp->cpu, TPS("dti"));
+		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rdp->dynticks_fqs++;
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
@@ -1133,20 +1133,20 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 */
 	jtsq = jiffies_till_sched_qs;
 	ruqp = per_cpu_ptr(&rcu_dynticks.rcu_urgent_qs, rdp->cpu);
-	if (time_after(jiffies, rdp->rsp->gp_start + jtsq) &&
+	if (time_after(jiffies, rcu_state.gp_start + jtsq) &&
 	    READ_ONCE(rdp->rcu_qs_ctr_snap) != per_cpu(rcu_dynticks.rcu_qs_ctr, rdp->cpu) &&
 	    rcu_seq_current(&rdp->gp_seq) == rnp->gp_seq && !rdp->gpwrap) {
-		trace_rcu_fqs(rdp->rsp->name, rdp->gp_seq, rdp->cpu, TPS("rqc"));
+		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("rqc"));
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
-	} else if (time_after(jiffies, rdp->rsp->gp_start + jtsq)) {
+	} else if (time_after(jiffies, rcu_state.gp_start + jtsq)) {
 		/* Load rcu_qs_ctr before store to rcu_urgent_qs. */
 		smp_store_release(ruqp, true);
 	}
 
 	/* If waiting too long on an offline CPU, complain. */
 	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp)) &&
-	    time_after(jiffies, rdp->rsp->gp_start + HZ)) {
+	    time_after(jiffies, rcu_state.gp_start + HZ)) {
 		bool onl;
 		struct rcu_node *rnp1;
 
@@ -1184,12 +1184,12 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 */
 	rnhqp = &per_cpu(rcu_dynticks.rcu_need_heavy_qs, rdp->cpu);
 	if (!READ_ONCE(*rnhqp) &&
-	    (time_after(jiffies, rdp->rsp->gp_start + jtsq) ||
-	     time_after(jiffies, rdp->rsp->jiffies_resched))) {
+	    (time_after(jiffies, rcu_state.gp_start + jtsq) ||
+	     time_after(jiffies, rcu_state.jiffies_resched))) {
 		WRITE_ONCE(*rnhqp, true);
 		/* Store rcu_need_heavy_qs before rcu_urgent_qs. */
 		smp_store_release(ruqp, true);
-		rdp->rsp->jiffies_resched += jtsq; /* Re-enable beating. */
+		rcu_state.jiffies_resched += jtsq; /* Re-enable beating. */
 	}
 
 	/*
@@ -1198,7 +1198,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * see if the CPU is getting hammered with interrupts, but only
 	 * once per grace period, just to keep the IPIs down to a dull roar.
 	 */
-	if (jiffies - rdp->rsp->gp_start > rcu_jiffies_till_stall_check() / 2) {
+	if (jiffies - rcu_state.gp_start > rcu_jiffies_till_stall_check() / 2) {
 		resched_cpu(rdp->cpu);
 		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
@@ -1525,7 +1525,7 @@ void rcu_cpu_stall_reset(void)
 static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 			      unsigned long gp_seq_req, const char *s)
 {
-	trace_rcu_future_grace_period(rdp->rsp->name, rnp->gp_seq, gp_seq_req,
+	trace_rcu_future_grace_period(rcu_state.name, rnp->gp_seq, gp_seq_req,
 				      rnp->level, rnp->grplo, rnp->grphi, s);
 }
 
@@ -1549,7 +1549,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 			      unsigned long gp_seq_req)
 {
 	bool ret = false;
-	struct rcu_state *rsp = rdp->rsp;
+	struct rcu_state *rsp = &rcu_state;
 	struct rcu_node *rnp;
 
 	/*
@@ -3166,8 +3166,7 @@ static void _rcu_barrier_trace(const char *s, int cpu, unsigned long done)
  */
 static void rcu_barrier_callback(struct rcu_head *rhp)
 {
-	struct rcu_data *rdp = container_of(rhp, struct rcu_data, barrier_head);
-	struct rcu_state *rsp = rdp->rsp;
+	struct rcu_state *rsp = &rcu_state;
 
 	if (atomic_dec_and_test(&rsp->barrier_cpu_count)) {
 		_rcu_barrier_trace(TPS("LastCB"), -1, rsp->barrier_sequence);
@@ -3364,7 +3363,6 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->rcu_onl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_onl_gp_flags = RCU_GP_CLEANED;
 	rdp->cpu = cpu;
-	rdp->rsp = &rcu_state;
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b21d79bdab23..6f1b1a3fc23d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -265,7 +265,6 @@ struct rcu_data {
 	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
 
 	int cpu;
-	struct rcu_state *rsp;
 };
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b60d3df92ff5..5423f9e58494 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -350,7 +350,7 @@ void rcu_note_context_switch(bool preempt)
 		 */
 		WARN_ON_ONCE((rdp->grpmask & rcu_rnp_online_cpus(rnp)) == 0);
 		WARN_ON_ONCE(!list_empty(&t->rcu_node_entry));
-		trace_rcu_preempt_task(rdp->rsp->name,
+		trace_rcu_preempt_task(rcu_state.name,
 				       t->pid,
 				       (rnp->qsmask & rdp->grpmask)
 				       ? rnp->gp_seq
@@ -1951,7 +1951,7 @@ static void wake_nocb_leader_defer(struct rcu_data *rdp, int waketype,
 	if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT)
 		mod_timer(&rdp->nocb_timer, jiffies + 1);
 	WRITE_ONCE(rdp->nocb_defer_wakeup, waketype);
-	trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu, reason);
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, reason);
 	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 }
 
@@ -2030,7 +2030,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
 	/* If we are not being polled and there is a kthread, awaken it ... */
 	t = READ_ONCE(rdp->nocb_kthread);
 	if (rcu_nocb_poll || !t) {
-		trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu,
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("WakeNotPoll"));
 		return;
 	}
@@ -2039,7 +2039,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
 		if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
 			wake_nocb_leader(rdp, false);
-			trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu,
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
 			wake_nocb_leader_defer(rdp, RCU_NOCB_WAKE,
@@ -2050,7 +2050,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
 		/* ... or if many callbacks queued. */
 		if (!irqs_disabled_flags(flags)) {
 			wake_nocb_leader(rdp, true);
-			trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu,
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeOvf"));
 		} else {
 			wake_nocb_leader_defer(rdp, RCU_NOCB_WAKE_FORCE,
@@ -2058,7 +2058,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
 		}
 		rdp->qlen_last_fqs_check = LONG_MAX / 2;
 	} else {
-		trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu, TPS("WakeNot"));
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
 	return;
 }
@@ -2080,12 +2080,12 @@ static bool __call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *rhp,
 		return false;
 	__call_rcu_nocb_enqueue(rdp, rhp, &rhp->next, 1, lazy, flags);
 	if (__is_kfree_rcu_offset((unsigned long)rhp->func))
-		trace_rcu_kfree_callback(rdp->rsp->name, rhp,
+		trace_rcu_kfree_callback(rcu_state.name, rhp,
 					 (unsigned long)rhp->func,
 					 -atomic_long_read(&rdp->nocb_q_count_lazy),
 					 -atomic_long_read(&rdp->nocb_q_count));
 	else
-		trace_rcu_callback(rdp->rsp->name, rhp,
+		trace_rcu_callback(rcu_state.name, rhp,
 				   -atomic_long_read(&rdp->nocb_q_count_lazy),
 				   -atomic_long_read(&rdp->nocb_q_count));
 
@@ -2135,7 +2135,7 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 	struct rcu_node *rnp = rdp->mynode;
 
 	local_irq_save(flags);
-	c = rcu_seq_snap(&rdp->rsp->gp_seq);
+	c = rcu_seq_snap(&rcu_state.gp_seq);
 	if (!rdp->gpwrap && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
 		local_irq_restore(flags);
 	} else {
@@ -2180,7 +2180,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 
 	/* Wait for callbacks to appear. */
 	if (!rcu_nocb_poll) {
-		trace_rcu_nocb_wake(my_rdp->rsp->name, my_rdp->cpu, TPS("Sleep"));
+		trace_rcu_nocb_wake(rcu_state.name, my_rdp->cpu, TPS("Sleep"));
 		swait_event_interruptible_exclusive(my_rdp->nocb_wq,
 				!READ_ONCE(my_rdp->nocb_leader_sleep));
 		raw_spin_lock_irqsave(&my_rdp->nocb_lock, flags);
@@ -2190,7 +2190,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 		raw_spin_unlock_irqrestore(&my_rdp->nocb_lock, flags);
 	} else if (firsttime) {
 		firsttime = false; /* Don't drown trace log with "Poll"! */
-		trace_rcu_nocb_wake(my_rdp->rsp->name, my_rdp->cpu, TPS("Poll"));
+		trace_rcu_nocb_wake(rcu_state.name, my_rdp->cpu, TPS("Poll"));
 	}
 
 	/*
@@ -2217,7 +2217,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 		if (rcu_nocb_poll) {
 			schedule_timeout_interruptible(1);
 		} else {
-			trace_rcu_nocb_wake(my_rdp->rsp->name, my_rdp->cpu,
+			trace_rcu_nocb_wake(rcu_state.name, my_rdp->cpu,
 					    TPS("WokeEmpty"));
 		}
 		goto wait_again;
@@ -2262,7 +2262,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 static void nocb_follower_wait(struct rcu_data *rdp)
 {
 	for (;;) {
-		trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu, TPS("FollowerSleep"));
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FollowerSleep"));
 		swait_event_interruptible_exclusive(rdp->nocb_wq,
 					 READ_ONCE(rdp->nocb_follower_head));
 		if (smp_load_acquire(&rdp->nocb_follower_head)) {
@@ -2270,7 +2270,7 @@ static void nocb_follower_wait(struct rcu_data *rdp)
 			return;
 		}
 		WARN_ON(signal_pending(current));
-		trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu, TPS("WokeEmpty"));
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
 	}
 }
 
@@ -2305,10 +2305,10 @@ static int rcu_nocb_kthread(void *arg)
 		rdp->nocb_follower_tail = &rdp->nocb_follower_head;
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		BUG_ON(!list);
-		trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu, TPS("WokeNonEmpty"));
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeNonEmpty"));
 
 		/* Each pass through the following loop invokes a callback. */
-		trace_rcu_batch_start(rdp->rsp->name,
+		trace_rcu_batch_start(rcu_state.name,
 				      atomic_long_read(&rdp->nocb_q_count_lazy),
 				      atomic_long_read(&rdp->nocb_q_count), -1);
 		c = cl = 0;
@@ -2316,23 +2316,23 @@ static int rcu_nocb_kthread(void *arg)
 			next = list->next;
 			/* Wait for enqueuing to complete, if needed. */
 			while (next == NULL && &list->next != tail) {
-				trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu,
+				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 						    TPS("WaitQueue"));
 				schedule_timeout_interruptible(1);
-				trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu,
+				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 						    TPS("WokeQueue"));
 				next = list->next;
 			}
 			debug_rcu_head_unqueue(list);
 			local_bh_disable();
-			if (__rcu_reclaim(rdp->rsp->name, list))
+			if (__rcu_reclaim(rcu_state.name, list))
 				cl++;
 			c++;
 			local_bh_enable();
 			cond_resched_tasks_rcu_qs();
 			list = next;
 		}
-		trace_rcu_batch_end(rdp->rsp->name, c, !!list, 0, 0, 1);
+		trace_rcu_batch_end(rcu_state.name, c, !!list, 0, 0, 1);
 		smp_mb__before_atomic();  /* _add after CB invocation. */
 		atomic_long_add(-c, &rdp->nocb_q_count);
 		atomic_long_add(-cl, &rdp->nocb_q_count_lazy);
@@ -2360,7 +2360,7 @@ static void do_nocb_deferred_wakeup_common(struct rcu_data *rdp)
 	ndw = READ_ONCE(rdp->nocb_defer_wakeup);
 	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
 	__wake_nocb_leader(rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
-	trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu, TPS("DeferredWake"));
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 }
 
 /* Do a deferred wakeup of rcu_nocb_kthread() from a timer handler. */
-- 
2.17.1

