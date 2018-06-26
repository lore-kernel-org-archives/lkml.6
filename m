Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748BAC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B75A2630C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B75A2630C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935164AbeFZAJY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:09:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934581AbeFZAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q04N8R061860
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:06 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96ttuma-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06w8O48496880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DDB4B205F;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F2C8B206C;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6045316CA0A6; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 20/40] rcu: Convert rcu_grace_period tracepoint to gp_seq
Date:   Mon, 25 Jun 2018 17:08:39 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0072-0000-0000-000003746094
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0073-0000-0000-0000487C5229
Message-Id: <20180626000859.23572-20-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the rcu_grace_period tracepoint use gp_seq instead
of ->gpnum or ->completed.  It also introduces a "cpuofl-bgp" string to
less obscurely indicate when a CPU has gone offline while a grace period
is waiting on it.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h | 13 ++++++------
 kernel/rcu/tree.c          | 43 +++++++++++++++++++-------------------
 kernel/rcu/tree_plugin.h   |  2 +-
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5936aac357ab..cd229e82ec8b 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -52,6 +52,7 @@ TRACE_EVENT(rcu_utilization,
  *	"cpuqs": CPU passes through a quiescent state.
  *	"cpuonl": CPU comes online.
  *	"cpuofl": CPU goes offline.
+ *	"cpuofl-bgp": CPU goes offline while blocking a grace period.
  *	"reqwait": GP kthread sleeps waiting for grace-period request.
  *	"reqwaitsig": GP kthread awakened by signal from reqwait state.
  *	"fqswait": GP kthread waiting until time to force quiescent states.
@@ -63,24 +64,24 @@ TRACE_EVENT(rcu_utilization,
  */
 TRACE_EVENT(rcu_grace_period,
 
-	TP_PROTO(const char *rcuname, unsigned long gpnum, const char *gpevent),
+	TP_PROTO(const char *rcuname, unsigned long gp_seq, const char *gpevent),
 
-	TP_ARGS(rcuname, gpnum, gpevent),
+	TP_ARGS(rcuname, gp_seq, gpevent),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gpnum)
+		__field(unsigned long, gp_seq)
 		__field(const char *, gpevent)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gpnum = gpnum;
+		__entry->gp_seq = gp_seq;
 		__entry->gpevent = gpevent;
 	),
 
 	TP_printk("%s %lu %s",
-		  __entry->rcuname, __entry->gpnum, __entry->gpevent)
+		  __entry->rcuname, __entry->gp_seq, __entry->gpevent)
 );
 
 /*
@@ -753,7 +754,7 @@ TRACE_EVENT(rcu_barrier,
 
 #else /* #ifdef CONFIG_RCU_TRACE */
 
-#define trace_rcu_grace_period(rcuname, gpnum, gpevent) do { } while (0)
+#define trace_rcu_grace_period(rcuname, gp_seq, gpevent) do { } while (0)
 #define trace_rcu_future_grace_period(rcuname, gpnum, completed, c, \
 				      level, grplo, grphi, event) \
 				      do { } while (0)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0da0db1128d0..70e5d155042c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -234,7 +234,7 @@ void rcu_sched_qs(void)
 	if (!__this_cpu_read(rcu_sched_data.cpu_no_qs.s))
 		return;
 	trace_rcu_grace_period(TPS("rcu_sched"),
-			       __this_cpu_read(rcu_sched_data.gpnum),
+			       __this_cpu_read(rcu_sched_data.gp_seq),
 			       TPS("cpuqs"));
 	__this_cpu_write(rcu_sched_data.cpu_no_qs.b.norm, false);
 	if (!__this_cpu_read(rcu_sched_data.cpu_no_qs.b.exp))
@@ -249,7 +249,7 @@ void rcu_bh_qs(void)
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_bh_qs() invoked with preemption enabled!!!");
 	if (__this_cpu_read(rcu_bh_data.cpu_no_qs.s)) {
 		trace_rcu_grace_period(TPS("rcu_bh"),
-				       __this_cpu_read(rcu_bh_data.gpnum),
+				       __this_cpu_read(rcu_bh_data.gp_seq),
 				       TPS("cpuqs"));
 		__this_cpu_write(rcu_bh_data.cpu_no_qs.b.norm, false);
 	}
@@ -1615,7 +1615,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 		trace_rcu_this_gp(rnp_root, rdp, c, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
-	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gpnum), TPS("newreq"));
+	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
@@ -1702,9 +1702,9 @@ static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-		trace_rcu_grace_period(rsp->name, rdp->gpnum, TPS("AccWaitCB"));
+		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("AccWaitCB"));
 	else
-		trace_rcu_grace_period(rsp->name, rdp->gpnum, TPS("AccReadyCB"));
+		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("AccReadyCB"));
 	return ret;
 }
 
@@ -1774,7 +1774,7 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 		 * go looking for one.
 		 */
 		rdp->gpnum = rnp->gpnum;
-		trace_rcu_grace_period(rsp->name, rdp->gpnum, TPS("cpustart"));
+		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpustart"));
 		need_gp = !!(rnp->qsmask & rdp->grpmask);
 		rdp->cpu_no_qs.b.norm = need_gp;
 		rdp->rcu_qs_ctr_snap = __this_cpu_read(rcu_dynticks.rcu_qs_ctr);
@@ -1851,7 +1851,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	rcu_seq_start(&rsp->gp_seq);
 	if (WARN_ON_ONCE(((rnp->completed << RCU_SEQ_CTR_SHIFT) >> RCU_SEQ_CTR_SHIFT) != rcu_seq_ctr(rnp->gp_seq))) /* Catch any ->completed/->gp_seq mismatches. */
 		pr_info("%s ->completed: %#lx (%#lx) ->gp_seq %#lx (%#lx)\n", __func__, rnp->completed, (rnp->completed << RCU_SEQ_CTR_SHIFT) >> RCU_SEQ_CTR_SHIFT, rnp->gp_seq, rcu_seq_ctr(rnp->gp_seq));
-	trace_rcu_grace_period(rsp->name, rsp->gpnum, TPS("start"));
+	trace_rcu_grace_period(rsp->name, rsp->gp_seq, TPS("start"));
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
@@ -1928,7 +1928,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		if (rnp == rdp->mynode)
 			(void)__note_gp_changes(rsp, rnp, rdp);
 		rcu_preempt_boost_start_gp(rnp);
-		trace_rcu_grace_period_init(rsp->name, rnp->gpnum,
+		trace_rcu_grace_period_init(rsp->name, rnp->gp_seq,
 					    rnp->level, rnp->grplo,
 					    rnp->grphi, rnp->qsmask);
 		raw_spin_unlock_irq_rcu_node(rnp);
@@ -2048,7 +2048,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	/* Declare grace period done. */
 	WRITE_ONCE(rsp->completed, rsp->gpnum);
 	rcu_seq_end(&rsp->gp_seq);
-	trace_rcu_grace_period(rsp->name, rsp->completed, TPS("end"));
+	trace_rcu_grace_period(rsp->name, rsp->gp_seq, TPS("end"));
 	rsp->gp_state = RCU_GP_IDLE;
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(rsp->rda);
@@ -2061,7 +2061,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	if (!rcu_accelerate_cbs(rsp, rnp, rdp) && needgp) {
 		WRITE_ONCE(rsp->gp_flags, RCU_GP_FLAG_INIT);
 		rsp->gp_req_activity = jiffies;
-		trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gpnum),
+		trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq),
 				       TPS("newreq"));
 	} else {
 		WRITE_ONCE(rsp->gp_flags, rsp->gp_flags & RCU_GP_FLAG_INIT);
@@ -2087,7 +2087,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 		/* Handle grace-period start. */
 		for (;;) {
 			trace_rcu_grace_period(rsp->name,
-					       READ_ONCE(rsp->gpnum),
+					       READ_ONCE(rsp->gp_seq),
 					       TPS("reqwait"));
 			rsp->gp_state = RCU_GP_WAIT_GPS;
 			swait_event_idle(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
@@ -2100,7 +2100,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 			WRITE_ONCE(rsp->gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
 			trace_rcu_grace_period(rsp->name,
-					       READ_ONCE(rsp->gpnum),
+					       READ_ONCE(rsp->gp_seq),
 					       TPS("reqwaitsig"));
 		}
 
@@ -2119,7 +2119,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					   jiffies + 3 * j);
 			}
 			trace_rcu_grace_period(rsp->name,
-					       READ_ONCE(rsp->gpnum),
+					       READ_ONCE(rsp->gp_seq),
 					       TPS("fqswait"));
 			rsp->gp_state = RCU_GP_WAIT_FQS;
 			ret = swait_event_idle_timeout(rsp->gp_wq,
@@ -2134,12 +2134,12 @@ static int __noreturn rcu_gp_kthread(void *arg)
 			if (ULONG_CMP_GE(jiffies, rsp->jiffies_force_qs) ||
 			    (gf & RCU_GP_FLAG_FQS)) {
 				trace_rcu_grace_period(rsp->name,
-						       READ_ONCE(rsp->gpnum),
+						       READ_ONCE(rsp->gp_seq),
 						       TPS("fqsstart"));
 				rcu_gp_fqs(rsp, first_gp_fqs);
 				first_gp_fqs = false;
 				trace_rcu_grace_period(rsp->name,
-						       READ_ONCE(rsp->gpnum),
+						       READ_ONCE(rsp->gp_seq),
 						       TPS("fqsend"));
 				cond_resched_tasks_rcu_qs();
 				WRITE_ONCE(rsp->gp_activity, jiffies);
@@ -2158,7 +2158,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 				WRITE_ONCE(rsp->gp_activity, jiffies);
 				WARN_ON(signal_pending(current));
 				trace_rcu_grace_period(rsp->name,
-						       READ_ONCE(rsp->gpnum),
+						       READ_ONCE(rsp->gp_seq),
 						       TPS("fqswaitsig"));
 				ret = 1; /* Keep old FQS timing. */
 				j = jiffies;
@@ -2388,17 +2388,16 @@ rcu_check_quiescent_state(struct rcu_state *rsp, struct rcu_data *rdp)
  */
 static void rcu_cleanup_dying_cpu(struct rcu_state *rsp)
 {
-	RCU_TRACE(unsigned long mask;)
+	RCU_TRACE(bool blkd;)
 	RCU_TRACE(struct rcu_data *rdp = this_cpu_ptr(rsp->rda);)
 	RCU_TRACE(struct rcu_node *rnp = rdp->mynode;)
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return;
 
-	RCU_TRACE(mask = rdp->grpmask;)
-	trace_rcu_grace_period(rsp->name,
-			       rnp->gpnum + 1 - !!(rnp->qsmask & mask),
-			       TPS("cpuofl"));
+	RCU_TRACE(blkd = !!(rnp->qsmask & rdp->grpmask);)
+	trace_rcu_grace_period(rsp->name, rnp->gp_seq,
+			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
 }
 
 /*
@@ -3536,7 +3535,7 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
 	rdp->rcu_iw_gp_seq = rnp->gp_seq - 1;
-	trace_rcu_grace_period(rsp->name, rdp->gpnum, TPS("cpuonl"));
+	trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ca73931f7b30..aca9d187c509 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -301,7 +301,7 @@ static void rcu_preempt_qs(void)
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_qs() invoked with preemption enabled!!!\n");
 	if (__this_cpu_read(rcu_data_p->cpu_no_qs.s)) {
 		trace_rcu_grace_period(TPS("rcu_preempt"),
-				       __this_cpu_read(rcu_data_p->gpnum),
+				       __this_cpu_read(rcu_data_p->gp_seq),
 				       TPS("cpuqs"));
 		__this_cpu_write(rcu_data_p->cpu_no_qs.b.norm, false);
 		barrier(); /* Coordinate with rcu_preempt_check_callbacks(). */
-- 
2.17.1

