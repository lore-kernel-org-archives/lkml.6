Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882A1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F0D20854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F0D20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbeKLGKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:10:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731826AbeKLGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:05 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABKJ8N1124546
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:35 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdjvjkw1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:35 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:20:34 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:20:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABKKS0522479026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:20:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E17EB2065;
        Sun, 11 Nov 2018 20:20:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFB98B2064;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C490616C5DA2; Sun, 11 Nov 2018 12:20:28 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 09/17] rcu: Account for nocb-CPU callback counts in RCU CPU stall warnings
Date:   Sun, 11 Nov 2018 12:20:19 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111201956.GA11935@linux.ibm.com>
References: <20181111201956.GA11935@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0072-0000-0000-000003C6F5DF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116031; UDB=6.00577118; IPR=6.00896132;
 MB=3.00024115; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:20:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0073-0000-0000-00004A135791
Message-Id: <20181111202027.13585-9-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCU CPU stall warnings print an estimate of the total number of
RCU callbacks queued in the system, but this estimate leaves out
the callbacks queued for nocbs CPUs.  This commit therefore introduces
rcu_get_n_cbs_cpu(), which gives an accurate callback estimate for
both nocbs and normal CPUs, and uses this new function as needed.

This commit also introduces a rcu_get_n_cbs_nocb_cpu() helper function
that returns the number of callbacks for nocbs CPUs or zero otherwise,
and also uses this function in place of direct access to ->nocb_q_count
while in the area (fewer characters, you see).

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c        | 19 +++++++++++++++----
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h | 24 +++++++++++++++++++-----
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6f04352011d7..67f2c7a055b6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -207,6 +207,19 @@ static int rcu_gp_in_progress(void)
 	return rcu_seq_state(rcu_seq_current(&rcu_state.gp_seq));
 }
 
+/*
+ * Return the number of callbacks queued on the specified CPU.
+ * Handles both the nocbs and normal cases.
+ */
+static long rcu_get_n_cbs_cpu(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	if (rcu_segcblist_is_enabled(&rdp->cblist)) /* Online normal CPU? */
+		return rcu_segcblist_n_cbs(&rdp->cblist);
+	return rcu_get_n_cbs_nocb_cpu(rdp); /* Works for offline, too. */
+}
+
 void rcu_softirq_qs(void)
 {
 	rcu_qs();
@@ -1262,8 +1275,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 
 	print_cpu_stall_info_end();
 	for_each_possible_cpu(cpu)
-		totqlen += rcu_segcblist_n_cbs(&per_cpu_ptr(&rcu_data,
-							    cpu)->cblist);
+		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_cont("(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
 	       smp_processor_id(), (long)(jiffies - rcu_state.gp_start),
 	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
@@ -1323,8 +1335,7 @@ static void print_cpu_stall(void)
 	raw_spin_unlock_irqrestore_rcu_node(rdp->mynode, flags);
 	print_cpu_stall_info_end();
 	for_each_possible_cpu(cpu)
-		totqlen += rcu_segcblist_n_cbs(&per_cpu_ptr(&rcu_data,
-							    cpu)->cblist);
+		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_cont(" (t=%lu jiffies g=%ld q=%lu)\n",
 		jiffies - rcu_state.gp_start,
 		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 703e19ff532d..14f6758f0989 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -466,6 +466,7 @@ static void __init rcu_spawn_nocb_kthreads(void);
 static void __init rcu_organize_nocb_kthreads(void);
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 static bool init_nocb_callback_list(struct rcu_data *rdp);
+static unsigned long rcu_get_n_cbs_nocb_cpu(struct rcu_data *rdp);
 static void rcu_bind_gp_kthread(void);
 static bool rcu_nohz_full_cpu(void);
 static void rcu_dynticks_task_enter(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1db2b0780c62..6d0c651c5f35 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1997,7 +1997,7 @@ static bool rcu_nocb_cpu_needs_barrier(int cpu)
 	 * (if a callback is in fact needed).  This is associated with an
 	 * atomic_inc() in the caller.
 	 */
-	ret = atomic_long_read(&rdp->nocb_q_count);
+	ret = rcu_get_n_cbs_nocb_cpu(rdp);
 
 #ifdef CONFIG_PROVE_RCU
 	rhp = READ_ONCE(rdp->nocb_head);
@@ -2052,7 +2052,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
 				    TPS("WakeNotPoll"));
 		return;
 	}
-	len = atomic_long_read(&rdp->nocb_q_count);
+	len = rcu_get_n_cbs_nocb_cpu(rdp);
 	if (old_rhpp == &rdp->nocb_head) {
 		if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
@@ -2101,11 +2101,11 @@ static bool __call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *rhp,
 		trace_rcu_kfree_callback(rcu_state.name, rhp,
 					 (unsigned long)rhp->func,
 					 -atomic_long_read(&rdp->nocb_q_count_lazy),
-					 -atomic_long_read(&rdp->nocb_q_count));
+					 -rcu_get_n_cbs_nocb_cpu(rdp));
 	else
 		trace_rcu_callback(rcu_state.name, rhp,
 				   -atomic_long_read(&rdp->nocb_q_count_lazy),
-				   -atomic_long_read(&rdp->nocb_q_count));
+				   -rcu_get_n_cbs_nocb_cpu(rdp));
 
 	/*
 	 * If called from an extended quiescent state with interrupts
@@ -2328,7 +2328,7 @@ static int rcu_nocb_kthread(void *arg)
 		/* Each pass through the following loop invokes a callback. */
 		trace_rcu_batch_start(rcu_state.name,
 				      atomic_long_read(&rdp->nocb_q_count_lazy),
-				      atomic_long_read(&rdp->nocb_q_count), -1);
+				      rcu_get_n_cbs_nocb_cpu(rdp), -1);
 		c = cl = 0;
 		while (list) {
 			next = list->next;
@@ -2598,6 +2598,15 @@ void rcu_bind_current_to_nocb(void)
 }
 EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
 
+/*
+ * Return the number of RCU callbacks still queued from the specified
+ * CPU, which must be a nocbs CPU.
+ */
+static unsigned long rcu_get_n_cbs_nocb_cpu(struct rcu_data *rdp)
+{
+	return atomic_long_read(&rdp->nocb_q_count);
+}
+
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 
 static bool rcu_nocb_cpu_needs_barrier(int cpu)
@@ -2658,6 +2667,11 @@ static bool init_nocb_callback_list(struct rcu_data *rdp)
 	return false;
 }
 
+static unsigned long rcu_get_n_cbs_nocb_cpu(struct rcu_data *rdp)
+{
+	return 0;
+}
+
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
 /*
-- 
2.17.1

