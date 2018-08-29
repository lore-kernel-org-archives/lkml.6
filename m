Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444E2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0085320658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0085320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeH3CiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727588AbeH3CiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcjeO012275
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m637yj9jp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:02 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvC363176792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78270B2067;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63DFEB2066;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 80CFD16C91E7; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 36/52] rcu: Remove rsp parameter from rcu_spawn_one_boost_kthread()
Date:   Wed, 29 Aug 2018 15:38:38 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0064-0000-0000-00000344000A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860729;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0065-0000-0000-00003A7847CC
Message-Id: <20180829223854.4055-36-paulmck@linux.vnet.ibm.com>
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
rcu_spawn_one_boost_kthread().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.h        |  4 ----
 kernel/rcu/tree_plugin.h | 13 ++++++-------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index ccdee6bd3919..dc1c337f6da9 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -463,10 +463,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static void invoke_rcu_callbacks_kthread(void);
 static bool rcu_is_callbacks_kthread(void);
-#ifdef CONFIG_RCU_BOOST
-static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
-						 struct rcu_node *rnp);
-#endif /* #ifdef CONFIG_RCU_BOOST */
 static void __init rcu_spawn_boost_kthreads(void);
 static void rcu_prepare_kthreads(int cpu);
 static void rcu_cleanup_after_idle(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9a3d30121815..9a6dea5fab86 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1290,21 +1290,20 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
  * already exist.  We only create this kthread for preemptible RCU.
  * Returns zero if all is well, a negated errno otherwise.
  */
-static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
-				       struct rcu_node *rnp)
+static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
-	int rnp_index = rnp - &rsp->node[0];
+	int rnp_index = rnp - rcu_get_root();
 	unsigned long flags;
 	struct sched_param sp;
 	struct task_struct *t;
 
-	if (&rcu_state != rsp)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
 		return 0;
 
 	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
 		return 0;
 
-	rsp->boost = 1;
+	rcu_state.boost = 1;
 	if (rnp->boost_kthread_task != NULL)
 		return 0;
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
@@ -1430,7 +1429,7 @@ static void __init rcu_spawn_boost_kthreads(void)
 		per_cpu(rcu_cpu_has_work, cpu) = 0;
 	BUG_ON(smpboot_register_percpu_thread(&rcu_cpu_thread_spec));
 	rcu_for_each_leaf_node(&rcu_state, rnp)
-		(void)rcu_spawn_one_boost_kthread(&rcu_state, rnp);
+		(void)rcu_spawn_one_boost_kthread(rnp);
 }
 
 static void rcu_prepare_kthreads(int cpu)
@@ -1440,7 +1439,7 @@ static void rcu_prepare_kthreads(int cpu)
 
 	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
 	if (rcu_scheduler_fully_active)
-		(void)rcu_spawn_one_boost_kthread(&rcu_state, rnp);
+		(void)rcu_spawn_one_boost_kthread(rnp);
 }
 
 #else /* #ifdef CONFIG_RCU_BOOST */
-- 
2.17.1

