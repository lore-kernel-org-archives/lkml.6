Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E20EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140222627B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140222627B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934253AbeFYXC5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:02:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755554AbeFYXCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:02:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMwra3021714
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 19:02:31 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96urxbt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 19:02:31 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 19:02:30 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 19:02:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PN2OSb10879558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 23:02:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1AFFB2068;
        Mon, 25 Jun 2018 19:02:18 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A04C1B2067;
        Mon, 25 Jun 2018 19:02:18 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 19:02:18 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F31B916CA098; Mon, 25 Jun 2018 16:04:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 4/5] rcu: Diagnostics for grace-period hangs
Date:   Mon, 25 Jun 2018 16:04:26 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625230410.GA13250@linux.vnet.ibm.com>
References: <20180625230410.GA13250@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062523-0068-0000-0000-0000030E1221
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052306; UDB=6.00539451; IPR=6.00830231;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 23:02:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062523-0069-0000-0000-000044CEE5CD
Message-Id: <20180625230427.13877-4-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit causes a splat if RCU is idle and a request for a new grace
period is ignored for more than one second.  This splat normally indicates
that some code path asked for a new grace period, but failed to wake up
the RCU grace-period kthread.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Fix bug located by Dan Carpenter and his static checker. ]
---
 kernel/rcu/tree.c | 63 +++++++++++++++++++++++++++++++++++++++++++++--
 kernel/rcu/tree.h |  2 ++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b1fffa21b9e4..fae4df831e52 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1681,6 +1681,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	}
 	trace_rcu_this_gp(rnp_root, rdp, c, TPS("Startedroot"));
 	WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
+	rsp->gp_req_activity = jiffies;
 	if (!rsp->gp_kthread) {
 		trace_rcu_this_gp(rnp_root, rdp, c, TPS("NoGPkthread"));
 		goto unlock_out;
@@ -2113,6 +2114,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	/* Advance CBs to reduce false positives below. */
 	if (!rcu_accelerate_cbs(rsp, rnp, rdp) && needgp) {
 		WRITE_ONCE(rsp->gp_flags, RCU_GP_FLAG_INIT);
+		rsp->gp_req_activity = jiffies;
 		trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gpnum),
 				       TPS("newreq"));
 	}
@@ -2744,6 +2746,62 @@ static void force_quiescent_state(struct rcu_state *rsp)
 	rcu_gp_kthread_wake(rsp);
 }
 
+/*
+ * This function checks for grace-period requests that fail to motivate
+ * RCU to come out of its idle mode.
+ */
+static void
+rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
+			 struct rcu_data *rdp)
+{
+	unsigned long flags;
+	unsigned long j;
+	struct rcu_node *rnp_root = rcu_get_root(rsp);
+	static atomic_t warned = ATOMIC_INIT(0);
+
+	if (rcu_gp_in_progress(rsp) || !need_any_future_gp(rcu_get_root(rsp)))
+		return;
+	j = jiffies; /* Expensive access, and in common case don't get here. */
+	if (time_before(j, READ_ONCE(rsp->gp_req_activity) + HZ) ||
+	    time_before(j, READ_ONCE(rsp->gp_activity) + HZ) ||
+	    atomic_read(&warned))
+		return;
+
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	j = jiffies;
+	if (rcu_gp_in_progress(rsp) || !need_any_future_gp(rcu_get_root(rsp)) ||
+	    time_before(j, READ_ONCE(rsp->gp_req_activity) + HZ) ||
+	    time_before(j, READ_ONCE(rsp->gp_activity) + HZ) ||
+	    atomic_read(&warned)) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return;
+	}
+	/* Hold onto the leaf lock to make others see warned==1. */
+
+	raw_spin_lock_rcu_node(rnp_root); /* irqs already disabled. */
+	j = jiffies;
+	if (rcu_gp_in_progress(rsp) || !need_any_future_gp(rcu_get_root(rsp)) ||
+	    time_before(j, rsp->gp_req_activity + HZ) ||
+	    time_before(j, rsp->gp_activity + HZ) ||
+	    atomic_xchg(&warned, 1)) {
+		raw_spin_unlock_rcu_node(rnp_root); /* irqs remain disabled. */
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return;
+	}
+	pr_alert("%s: g%lu %d%d%d%d gar:%lu ga:%lu f%#x %s->state:%#lx\n",
+		 __func__, READ_ONCE(rsp->gpnum),
+		 need_future_gp_element(rcu_get_root(rsp), 0),
+		 need_future_gp_element(rcu_get_root(rsp), 1),
+		 need_future_gp_element(rcu_get_root(rsp), 2),
+		 need_future_gp_element(rcu_get_root(rsp), 3),
+		 j - rsp->gp_req_activity, j - rsp->gp_activity,
+		 rsp->gp_flags, rsp->name,
+		 rsp->gp_kthread ? rsp->gp_kthread->state : 0x1ffffL);
+	WARN_ON(1);
+	raw_spin_unlock_rcu_node(rnp_root);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+}
+
 /*
  * This does the RCU core processing work for the specified rcu_state
  * and rcu_data structures.  This may be called only from the CPU to
@@ -2755,7 +2813,7 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 	unsigned long flags;
 	bool needwake;
 	struct rcu_data *rdp = raw_cpu_ptr(rsp->rda);
-	struct rcu_node *rnp;
+	struct rcu_node *rnp = rdp->mynode;
 
 	WARN_ON_ONCE(!rdp->beenonline);
 
@@ -2769,7 +2827,6 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 		if (rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL)) {
 			local_irq_restore(flags);
 		} else {
-			rnp = rdp->mynode;
 			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
 			needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -2778,6 +2835,8 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 		}
 	}
 
+	rcu_check_gp_start_stall(rsp, rnp, rdp);
+
 	/* If there are callbacks ready, invoke them. */
 	if (rcu_segcblist_ready_cbs(&rdp->cblist))
 		invoke_rcu_callbacks(rsp, rdp);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7365ac53fdd9..3c1942174c56 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -374,6 +374,8 @@ struct rcu_state {
 						/*  but in jiffies. */
 	unsigned long gp_activity;		/* Time of last GP kthread */
 						/*  activity in jiffies. */
+	unsigned long gp_req_activity;		/* Time of last GP request */
+						/*  in jiffies. */
 	unsigned long jiffies_stall;		/* Time at which to check */
 						/*  for CPU stalls. */
 	unsigned long jiffies_resched;		/* Time at which to resched */
-- 
2.17.1

