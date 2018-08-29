Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A79EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0BD2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0BD2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeH3CTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:19:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727285AbeH3CTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMInDL071875
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:55 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61jbwpky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:55 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:54 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKnnG34668764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45216B2065;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15355B2070;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 414D716C91D2; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 11/19] rcu: Drop "wake" parameter from rcu_report_exp_rdp()
Date:   Wed, 29 Aug 2018 15:20:39 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-2213-0000-0000-000002E50743
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860724;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-2214-0000-0000-00005B602598
Message-Id: <20180829222047.319-11-paulmck@linux.vnet.ibm.com>
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

The rcu_report_exp_rdp() function is always invoked with its "wake"
argument set to "true", so this commit drops this parameter.  The only
potential call site that would use "false" is in the code driving the
expedited grace period, and that code uses rcu_report_exp_cpu_mult()
instead, which therefore retains its "wake" parameter.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 9 +++------
 kernel/rcu/tree_exp.h    | 9 ++++-----
 kernel/rcu/tree_plugin.h | 6 +++---
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8d04cf2c6f76..bb40d3598a0d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -165,8 +165,7 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu);
 static void invoke_rcu_core(void);
 static void invoke_rcu_callbacks(struct rcu_state *rsp, struct rcu_data *rdp);
-static void rcu_report_exp_rdp(struct rcu_state *rsp,
-			       struct rcu_data *rdp, bool wake);
+static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
 
 /* rcuc/rcub kthread realtime priority */
@@ -239,8 +238,7 @@ void rcu_sched_qs(void)
 	if (!__this_cpu_read(rcu_sched_data.cpu_no_qs.b.exp))
 		return;
 	__this_cpu_write(rcu_sched_data.cpu_no_qs.b.exp, false);
-	rcu_report_exp_rdp(&rcu_sched_state,
-			   this_cpu_ptr(&rcu_sched_data), true);
+	rcu_report_exp_rdp(&rcu_sched_state, this_cpu_ptr(&rcu_sched_data));
 }
 
 void rcu_softirq_qs(void)
@@ -3757,8 +3755,7 @@ void rcu_report_dead(unsigned int cpu)
 
 	/* QS for any half-done expedited RCU-sched GP. */
 	preempt_disable();
-	rcu_report_exp_rdp(&rcu_sched_state,
-			   this_cpu_ptr(rcu_sched_state.rda), true);
+	rcu_report_exp_rdp(&rcu_sched_state, this_cpu_ptr(rcu_sched_state.rda));
 	preempt_enable();
 	rcu_preempt_deferred_qs(current);
 	for_each_rcu_flavor(rsp)
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index f9d5bbd8adce..0f8f225c1b46 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -259,11 +259,10 @@ static void rcu_report_exp_cpu_mult(struct rcu_state *rsp, struct rcu_node *rnp,
 /*
  * Report expedited quiescent state for specified rcu_data (CPU).
  */
-static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp,
-			       bool wake)
+static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp)
 {
 	WRITE_ONCE(rdp->deferred_qs, false);
-	rcu_report_exp_cpu_mult(rsp, rdp->mynode, rdp->grpmask, wake);
+	rcu_report_exp_cpu_mult(rsp, rdp->mynode, rdp->grpmask, true);
 }
 
 /* Common code for synchronize_{rcu,sched}_expedited() work-done checking. */
@@ -352,7 +351,7 @@ static void sync_sched_exp_handler(void *data)
 		return;
 	if (rcu_is_cpu_rrupt_from_idle()) {
 		rcu_report_exp_rdp(&rcu_sched_state,
-				   this_cpu_ptr(&rcu_sched_data), true);
+				   this_cpu_ptr(&rcu_sched_data));
 		return;
 	}
 	__this_cpu_write(rcu_sched_data.cpu_no_qs.b.exp, true);
@@ -750,7 +749,7 @@ static void sync_rcu_exp_handler(void *info)
 	if (!t->rcu_read_lock_nesting) {
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 		    rcu_dynticks_curr_cpu_in_eqs()) {
-			rcu_report_exp_rdp(rsp, rdp, true);
+			rcu_report_exp_rdp(rsp, rdp);
 		} else {
 			rdp->deferred_qs = true;
 			resched_cpu(rdp->cpu);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1ff742a3c8d1..9f0d054e6c20 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -285,7 +285,7 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * still in a quiescent state in any case.)
 	 */
 	if (blkd_state & RCU_EXP_BLKD && rdp->deferred_qs)
-		rcu_report_exp_rdp(rdp->rsp, rdp, true);
+		rcu_report_exp_rdp(rdp->rsp, rdp);
 	else
 		WARN_ON_ONCE(rdp->deferred_qs);
 }
@@ -383,7 +383,7 @@ static void rcu_preempt_note_context_switch(bool preempt)
 	 */
 	rcu_preempt_qs();
 	if (rdp->deferred_qs)
-		rcu_report_exp_rdp(rcu_state_p, rdp, true);
+		rcu_report_exp_rdp(rcu_state_p, rdp);
 }
 
 /*
@@ -508,7 +508,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * blocked-tasks list below.
 	 */
 	if (rdp->deferred_qs) {
-		rcu_report_exp_rdp(rcu_state_p, rdp, true);
+		rcu_report_exp_rdp(rcu_state_p, rdp);
 		if (!t->rcu_read_unlock_special.s) {
 			local_irq_restore(flags);
 			return;
-- 
2.17.1

