Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030AFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE9D20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE9D20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeH3CkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:40:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727590AbeH3CiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcjct093188
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64a288mf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:02 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvBE19333150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91EDEB2075;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C3FBB206E;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8B53C16C91E9; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 38/52] rcu: Remove rsp parameter from no-CBs CPU functions
Date:   Wed, 29 Aug 2018 15:38:40 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0068-0000-0000-00000331B956
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0069-0000-0000-0000458F161A
Message-Id: <20180829223854.4055-38-paulmck@linux.vnet.ibm.com>
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
Linux kernel, so there is no need to pass it as a parameter to
RCU's functions.  This commit therefore removes the rsp parameter
from rcu_nocb_cpu_needs_barrier(), rcu_spawn_one_nocb_kthread(),
rcu_organize_nocb_kthreads(), rcu_nocb_cpu_needs_barrier(), and
rcu_nohz_full_cpu().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        |  4 ++--
 kernel/rcu/tree.h        |  6 +++---
 kernel/rcu/tree_plugin.h | 18 +++++++++---------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1b63a28f148d..6d8e4a4d8019 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3094,7 +3094,7 @@ static int rcu_pending(void)
 	check_cpu_stall(rdp);
 
 	/* Is this CPU a NO_HZ_FULL CPU that should ignore RCU? */
-	if (rcu_nohz_full_cpu(&rcu_state))
+	if (rcu_nohz_full_cpu())
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
@@ -3245,7 +3245,7 @@ static void _rcu_barrier(void)
 			continue;
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rcu_is_nocb_cpu(cpu)) {
-			if (!rcu_nocb_cpu_needs_barrier(rsp, cpu)) {
+			if (!rcu_nocb_cpu_needs_barrier(cpu)) {
 				_rcu_barrier_trace(TPS("OfflineNoCB"), cpu,
 						   rsp->barrier_sequence);
 			} else {
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2bf57de9f78a..7c6033d71e9d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -476,7 +476,7 @@ static void print_cpu_stall_info(int cpu);
 static void print_cpu_stall_info_end(void);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static void increment_cpu_stall_ticks(void);
-static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu);
+static bool rcu_nocb_cpu_needs_barrier(int cpu);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
@@ -491,11 +491,11 @@ static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);
 static void rcu_spawn_all_nocb_kthreads(int cpu);
 static void __init rcu_spawn_nocb_kthreads(void);
 #ifdef CONFIG_RCU_NOCB_CPU
-static void __init rcu_organize_nocb_kthreads(struct rcu_state *rsp);
+static void __init rcu_organize_nocb_kthreads(void);
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 static bool init_nocb_callback_list(struct rcu_data *rdp);
 static void rcu_bind_gp_kthread(void);
-static bool rcu_nohz_full_cpu(struct rcu_state *rsp);
+static bool rcu_nohz_full_cpu(void);
 static void rcu_dynticks_task_enter(void);
 static void rcu_dynticks_task_exit(void);
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 08ff162e02b3..69705ec13527 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1960,7 +1960,7 @@ static void wake_nocb_leader_defer(struct rcu_data *rdp, int waketype,
  * Does the specified CPU need an RCU callback for the specified flavor
  * of rcu_barrier()?
  */
-static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu)
+static bool rcu_nocb_cpu_needs_barrier(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	unsigned long ret;
@@ -2424,7 +2424,7 @@ void __init rcu_init_nohz(void)
 	for_each_rcu_flavor(rsp) {
 		for_each_cpu(cpu, rcu_nocb_mask)
 			init_nocb_callback_list(per_cpu_ptr(&rcu_data, cpu));
-		rcu_organize_nocb_kthreads(rsp);
+		rcu_organize_nocb_kthreads();
 	}
 }
 
@@ -2444,7 +2444,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
  * brought online out of order, this can require re-organizing the
  * leader-follower relationships.
  */
-static void rcu_spawn_one_nocb_kthread(struct rcu_state *rsp, int cpu)
+static void rcu_spawn_one_nocb_kthread(int cpu)
 {
 	struct rcu_data *rdp;
 	struct rcu_data *rdp_last;
@@ -2481,7 +2481,7 @@ static void rcu_spawn_one_nocb_kthread(struct rcu_state *rsp, int cpu)
 
 	/* Spawn the kthread for this CPU and RCU flavor. */
 	t = kthread_run(rcu_nocb_kthread, rdp_spawn,
-			"rcuo%c/%d", rsp->abbr, cpu);
+			"rcuo%c/%d", rcu_state.abbr, cpu);
 	BUG_ON(IS_ERR(t));
 	WRITE_ONCE(rdp_spawn->nocb_kthread, t);
 }
@@ -2496,7 +2496,7 @@ static void rcu_spawn_all_nocb_kthreads(int cpu)
 
 	if (rcu_scheduler_fully_active)
 		for_each_rcu_flavor(rsp)
-			rcu_spawn_one_nocb_kthread(rsp, cpu);
+			rcu_spawn_one_nocb_kthread(cpu);
 }
 
 /*
@@ -2520,7 +2520,7 @@ module_param(rcu_nocb_leader_stride, int, 0444);
 /*
  * Initialize leader-follower relationships for all no-CBs CPU.
  */
-static void __init rcu_organize_nocb_kthreads(struct rcu_state *rsp)
+static void __init rcu_organize_nocb_kthreads(void)
 {
 	int cpu;
 	int ls = rcu_nocb_leader_stride;
@@ -2579,7 +2579,7 @@ static bool init_nocb_callback_list(struct rcu_data *rdp)
 
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 
-static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu)
+static bool rcu_nocb_cpu_needs_barrier(int cpu)
 {
 	WARN_ON_ONCE(1); /* Should be dead code. */
 	return false;
@@ -2648,12 +2648,12 @@ static bool init_nocb_callback_list(struct rcu_data *rdp)
  * This code relies on the fact that all NO_HZ_FULL CPUs are also
  * CONFIG_RCU_NOCB_CPU CPUs.
  */
-static bool rcu_nohz_full_cpu(struct rcu_state *rsp)
+static bool rcu_nohz_full_cpu(void)
 {
 #ifdef CONFIG_NO_HZ_FULL
 	if (tick_nohz_full_cpu(smp_processor_id()) &&
 	    (!rcu_gp_in_progress() ||
-	     ULONG_CMP_LT(jiffies, READ_ONCE(rsp->gp_start) + HZ)))
+	     ULONG_CMP_LT(jiffies, READ_ONCE(rcu_state.gp_start) + HZ)))
 		return true;
 #endif /* #ifdef CONFIG_NO_HZ_FULL */
 	return false;
-- 
2.17.1

