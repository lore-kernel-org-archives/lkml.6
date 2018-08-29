Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FF5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AE020647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AE020647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeH3CkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:40:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727589AbeH3CiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMciFa142531
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m627rcgy1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:03 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvQd26148968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3017EB2064;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ABEFB205F;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 47DF016C91C7; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 26/52] rcu: Remove rsp parameter from force-quiescent-state functions
Date:   Wed, 29 Aug 2018 15:38:28 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-2213-0000-0000-000002E508CF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-2214-0000-0000-00005B602DAD
Message-Id: <20180829223854.4055-26-paulmck@linux.vnet.ibm.com>
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

There now is only one rcu_state structure in a given build of the
Linux kernel, so there is no need to pass it as a parameter to RCU's
functions.  This commit therefore removes the rsp parameter from
force_qs_rnp() and force_quiescent_state().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 18161321633e..4e6bb2bb0874 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -479,8 +479,8 @@ module_param(rcu_kick_kthreads, bool, 0644);
 static ulong jiffies_till_sched_qs = HZ / 10;
 module_param(jiffies_till_sched_qs, ulong, 0444);
 
-static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp));
-static void force_quiescent_state(struct rcu_state *rsp);
+static void force_qs_rnp(int (*f)(struct rcu_data *rsp));
+static void force_quiescent_state(void);
 static int rcu_pending(void);
 
 /*
@@ -538,7 +538,7 @@ EXPORT_SYMBOL_GPL(rcu_exp_batches_completed_sched);
  */
 void rcu_force_quiescent_state(void)
 {
-	force_quiescent_state(&rcu_state);
+	force_quiescent_state();
 }
 EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 
@@ -547,7 +547,7 @@ EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
  */
 void rcu_bh_force_quiescent_state(void)
 {
-	force_quiescent_state(&rcu_state);
+	force_quiescent_state();
 }
 EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
 
@@ -1383,7 +1383,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 
 	panic_on_rcu_stall();
 
-	force_quiescent_state(rsp);  /* Kick them all. */
+	force_quiescent_state();  /* Kick them all. */
 }
 
 static void print_cpu_stall(void)
@@ -1991,10 +1991,10 @@ static void rcu_gp_fqs(bool first_time)
 	rsp->n_force_qs++;
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
-		force_qs_rnp(rsp, dyntick_save_progress_counter);
+		force_qs_rnp(dyntick_save_progress_counter);
 	} else {
 		/* Handle dyntick-idle and offline CPUs. */
-		force_qs_rnp(rsp, rcu_implicit_dynticks_qs);
+		force_qs_rnp(rcu_implicit_dynticks_qs);
 	}
 	/* Clear flag to prevent immediate re-entry. */
 	if (READ_ONCE(rsp->gp_flags) & RCU_GP_FLAG_FQS) {
@@ -2599,12 +2599,13 @@ void rcu_check_callbacks(int user)
  *
  * The caller must have suppressed start of new grace periods.
  */
-static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
+static void force_qs_rnp(int (*f)(struct rcu_data *rsp))
 {
 	int cpu;
 	unsigned long flags;
 	unsigned long mask;
 	struct rcu_node *rnp;
+	struct rcu_state *rsp = &rcu_state;
 
 	rcu_for_each_leaf_node(rsp, rnp) {
 		cond_resched_tasks_rcu_qs();
@@ -2646,12 +2647,13 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
  * Force quiescent states on reluctant CPUs, and also detect which
  * CPUs are in dyntick-idle mode.
  */
-static void force_quiescent_state(struct rcu_state *rsp)
+static void force_quiescent_state(void)
 {
 	unsigned long flags;
 	bool ret;
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_old = NULL;
+	struct rcu_state *rsp = &rcu_state;
 
 	/* Funnel through hierarchy to reduce memory contention. */
 	rnp = __this_cpu_read(rcu_data.mynode);
@@ -2858,7 +2860,7 @@ static void __call_rcu_core(struct rcu_state *rsp, struct rcu_data *rdp,
 			rdp->blimit = LONG_MAX;
 			if (rsp->n_force_qs == rdp->n_force_qs_snap &&
 			    rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
-				force_quiescent_state(rsp);
+				force_quiescent_state();
 			rdp->n_force_qs_snap = rsp->n_force_qs;
 			rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
 		}
-- 
2.17.1

