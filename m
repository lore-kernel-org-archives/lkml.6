Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B11C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D007520685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfAIV3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:29:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727082AbfAIV2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:28:46 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LSZbi114247
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:28:45 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwnf7sbgn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:28:45 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:28:42 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:28:37 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LSaTh23265314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:28:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C7F5B2066;
        Wed,  9 Jan 2019 21:28:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBCC0B2070;
        Wed,  9 Jan 2019 21:28:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:28:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7D67B16C63C9; Wed,  9 Jan 2019 13:28:35 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 08/12] rcu: Improve diagnostics for failed RCU grace-period start
Date:   Wed,  9 Jan 2019 13:28:30 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109212816.GA32282@linux.ibm.com>
References: <20190109212816.GA32282@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0064-0000-0000-0000039410D6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144145; UDB=6.00595708; IPR=6.00924407;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:28:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0065-0000-0000-00003BF962E3
Message-Id: <20190109212834.1257-8-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a grace period fails to start (for example, because you commented
out the last two lines of rcu_accelerate_cbs_unlocked()), rcu_core()
will invoke rcu_check_gp_start_stall(), which will notice and complain.
However, this complaint is lacking crucial debugging information such
as when the last wakeup executed and what the value of ->gp_seq was at
that time.  This commit therefore removes the current pr_alert() from
rcu_check_gp_start_stall(), instead invoking show_rcu_gp_kthreads(),
which has been updated to print the needed information, which is collected
by rcu_gp_kthread_wake().

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 55 +++++++++++++++++++++++++++--------------------
 kernel/rcu/tree.h |  2 ++
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b003a3cfe192..8543a90d53f2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -512,6 +512,14 @@ void rcu_force_quiescent_state(void)
 }
 EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 
+/*
+ * Return the root node of the rcu_state structure.
+ */
+static struct rcu_node *rcu_get_root(void)
+{
+	return &rcu_state.node[0];
+}
+
 /*
  * Convert a ->gp_state value to a character string.
  */
@@ -529,19 +537,30 @@ void show_rcu_gp_kthreads(void)
 {
 	int cpu;
 	unsigned long j;
+	unsigned long ja;
+	unsigned long jr;
+	unsigned long jw;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
-	j = jiffies - READ_ONCE(rcu_state.gp_activity);
-	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %ld\n",
+	j = jiffies;
+	ja = j - READ_ONCE(rcu_state.gp_activity);
+	jr = j - READ_ONCE(rcu_state.gp_req_activity);
+	jw = j - READ_ONCE(rcu_state.gp_wake_time);
+	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state, rcu_state.gp_kthread->state, j);
+		rcu_state.gp_state,
+		rcu_state.gp_kthread ? rcu_state.gp_kthread->state : 0x1ffffL,
+		ja, jr, jw, (long)READ_ONCE(rcu_state.gp_wake_seq),
+		(long)READ_ONCE(rcu_state.gp_seq),
+		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
+		READ_ONCE(rcu_state.gp_flags));
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_GE(rcu_state.gp_seq, rnp->gp_seq_needed))
 			continue;
-		pr_info("\trcu_node %d:%d ->gp_seq %lu ->gp_seq_needed %lu\n",
-			rnp->grplo, rnp->grphi, rnp->gp_seq,
-			rnp->gp_seq_needed);
+		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld\n",
+			rnp->grplo, rnp->grphi, (long)rnp->gp_seq,
+			(long)rnp->gp_seq_needed);
 		if (!rcu_is_leaf_node(rnp))
 			continue;
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
@@ -550,8 +569,8 @@ void show_rcu_gp_kthreads(void)
 			    ULONG_CMP_GE(rcu_state.gp_seq,
 					 rdp->gp_seq_needed))
 				continue;
-			pr_info("\tcpu %d ->gp_seq_needed %lu\n",
-				cpu, rdp->gp_seq_needed);
+			pr_info("\tcpu %d ->gp_seq_needed %ld\n",
+				cpu, (long)rdp->gp_seq_needed);
 		}
 	}
 	/* sched_show_task(rcu_state.gp_kthread); */
@@ -577,14 +596,6 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 }
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
-/*
- * Return the root node of the rcu_state structure.
- */
-static struct rcu_node *rcu_get_root(void)
-{
-	return &rcu_state.node[0];
-}
-
 /*
  * Enter an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
@@ -1560,7 +1571,8 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
  * Awaken the grace-period kthread.  Don't do a self-awaken, and don't
  * bother awakening when there is nothing for the grace-period kthread
  * to do (as in several CPUs raced to awaken, and we lost), and finally
- * don't try to awaken a kthread that has not yet been created.
+ * don't try to awaken a kthread that has not yet been created.  If
+ * all those checks are passed, track some debug information and awaken.
  */
 static void rcu_gp_kthread_wake(void)
 {
@@ -1568,6 +1580,8 @@ static void rcu_gp_kthread_wake(void)
 	    !READ_ONCE(rcu_state.gp_flags) ||
 	    !rcu_state.gp_kthread)
 		return;
+	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
+	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
 	swake_up_one(&rcu_state.gp_wq);
 }
 
@@ -2657,16 +2671,11 @@ rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
-	pr_alert("%s: g%ld->%ld gar:%lu ga:%lu f%#x gs:%d %s->state:%#lx\n",
-		 __func__, (long)READ_ONCE(rcu_state.gp_seq),
-		 (long)READ_ONCE(rnp_root->gp_seq_needed),
-		 j - rcu_state.gp_req_activity, j - rcu_state.gp_activity,
-		 rcu_state.gp_flags, rcu_state.gp_state, rcu_state.name,
-		 rcu_state.gp_kthread ? rcu_state.gp_kthread->state : 0x1ffffL);
 	WARN_ON(1);
 	if (rnp_root != rnp)
 		raw_spin_unlock_rcu_node(rnp_root);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	show_rcu_gp_kthreads();
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 008c356c7033..1f2ada7ef7d7 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -309,6 +309,8 @@ struct rcu_state {
 	struct swait_queue_head gp_wq;		/* Where GP task waits. */
 	short gp_flags;				/* Commands for GP task. */
 	short gp_state;				/* GP kthread sleep state. */
+	unsigned long gp_wake_time;		/* Last GP kthread wake. */
+	unsigned long gp_wake_seq;		/* ->gp_seq at ^^^. */
 
 	/* End of fields guarded by root rcu_node's lock. */
 
-- 
2.17.1

