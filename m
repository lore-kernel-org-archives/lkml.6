Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5035AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0971120644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0971120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeH3CiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727480AbeH3CiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:06 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcklV118326
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:02 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m60r189w1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:02 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:01 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcudR46792710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77482B206B;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50E05B206C;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7BD0F16C91E6; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 35/52] rcu: Remove rsp parameter from dump_blkd_tasks() and friend
Date:   Wed, 29 Aug 2018 15:38:37 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0064-0000-0000-000003440006
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860729;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0065-0000-0000-00003A7847CA
Message-Id: <20180829223854.4055-35-paulmck@linux.vnet.ibm.com>
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
dump_blkd_tasks() and rcu_preempt_blocked_readers_cgp().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        |  4 ++--
 kernel/rcu/tree.h        |  6 ++----
 kernel/rcu/tree_plugin.h | 12 +++++-------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e484ee95a192..aa81958edec8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1936,7 +1936,7 @@ static bool rcu_gp_init(void)
 		rcu_gp_slow(gp_init_delay);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rdp = this_cpu_ptr(&rcu_data);
-		rcu_preempt_check_blocked_tasks(rsp, rnp);
+		rcu_preempt_check_blocked_tasks(rnp);
 		rnp->qsmask = rnp->qsmaskinit;
 		WRITE_ONCE(rnp->gp_seq, rsp->gp_seq);
 		if (rnp == rdp->mynode)
@@ -2048,7 +2048,7 @@ static void rcu_gp_cleanup(void)
 	rcu_for_each_node_breadth_first(rsp, rnp) {
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
-			dump_blkd_tasks(rsp, rnp, 10);
+			dump_blkd_tasks(rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
 		rdp = this_cpu_ptr(&rcu_data);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 00d268cb4d04..ccdee6bd3919 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -455,12 +455,10 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static void rcu_print_detail_task_stall(void);
 static int rcu_print_task_stall(struct rcu_node *rnp);
 static int rcu_print_task_exp_stall(struct rcu_node *rnp);
-static void rcu_preempt_check_blocked_tasks(struct rcu_state *rsp,
-					    struct rcu_node *rnp);
+static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
 static void rcu_flavor_check_callbacks(int user);
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
-static void dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp,
-			    int ncheck);
+static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static void invoke_rcu_callbacks_kthread(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1d8148b0d4e5..9a3d30121815 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -756,14 +756,13 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  * Also, if there are blocked tasks on the list, they automatically
  * block the newly created grace period, so set up ->gp_tasks accordingly.
  */
-static void
-rcu_preempt_check_blocked_tasks(struct rcu_state *rsp, struct rcu_node *rnp)
+static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 {
 	struct task_struct *t;
 
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_check_blocked_tasks() invoked with preemption enabled!!!\n");
 	if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
-		dump_blkd_tasks(rsp, rnp, 10);
+		dump_blkd_tasks(rnp, 10);
 	if (rcu_preempt_has_tasks(rnp) &&
 	    (rnp->qsmaskinit || rnp->wait_blkd_tasks)) {
 		rnp->gp_tasks = rnp->blkd_tasks.next;
@@ -884,7 +883,7 @@ void exit_rcu(void)
  * specified number of elements.
  */
 static void
-dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp, int ncheck)
+dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 {
 	int cpu;
 	int i;
@@ -1033,8 +1032,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  * so there is no need to check for blocked tasks.  So check only for
  * bogus qsmask values.
  */
-static void
-rcu_preempt_check_blocked_tasks(struct rcu_state *rsp, struct rcu_node *rnp)
+static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 {
 	WARN_ON_ONCE(rnp->qsmask);
 }
@@ -1095,7 +1093,7 @@ void exit_rcu(void)
  * Dump the guaranteed-empty blocked-tasks state.  Trust but verify.
  */
 static void
-dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp, int ncheck)
+dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 {
 	WARN_ON_ONCE(!list_empty(&rnp->blkd_tasks));
 }
-- 
2.17.1

