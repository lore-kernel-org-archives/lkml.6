Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeBZV6o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:58:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751752AbeBZVwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:51 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 17/20] rcu: Add more tracing of expedited grace periods
Date: Mon, 26 Feb 2018 13:53:07 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0044-0000-0000-000003EA613F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0045-0000-0000-0000081A6B10
Message-Id: <1519681990-31349-17-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds more tracing of expedited grace periods to enable
improved debugging of slowdowns.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h |  3 +++
 kernel/rcu/rcu.h           |  8 +++++++-
 kernel/rcu/tree_exp.h      | 12 ++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 0b50fda80db0..e56a618f2a59 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -179,6 +179,9 @@ TRACE_EVENT(rcu_grace_period_init,
  *
  *	"snap": Captured snapshot of expedited grace period sequence number.
  *	"start": Started a real expedited grace period.
+ *	"reset": Started resetting the tree
+ *	"select": Started selecting the CPUs to wait on.
+ *	"startwait": Started waiting on selected CPUs.
  *	"end": Ended a real expedited grace period.
  *	"endwake": Woke piggybackers up.
  *	"done": Someone else did the expedited grace period for us.
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 5d13f651cf08..507a0802c717 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -77,12 +77,18 @@ static inline void rcu_seq_start(unsigned long *sp)
 	WARN_ON_ONCE(rcu_seq_state(*sp) != 1);
 }
 
+/* Compute the end-of-grace-period value for the specified sequence number. */
+static inline unsigned long rcu_seq_endval(unsigned long *sp)
+{
+	return (*sp | RCU_SEQ_STATE_MASK) + 1;
+}
+
 /* Adjust sequence number for end of update-side operation. */
 static inline void rcu_seq_end(unsigned long *sp)
 {
 	smp_mb(); /* Ensure update-side operation before counter increment. */
 	WARN_ON_ONCE(!rcu_seq_state(*sp));
-	WRITE_ONCE(*sp, (*sp | RCU_SEQ_STATE_MASK) + 1);
+	WRITE_ONCE(*sp, rcu_seq_endval(sp));
 }
 
 /* Take a snapshot of the update side's sequence number. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 46d61b597731..70ad12abde36 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -29,6 +29,15 @@ static void rcu_exp_gp_seq_start(struct rcu_state *rsp)
 }
 
 /*
+ * Return then value that expedited-grace-period counter will have
+ * at the end of the current grace period.
+ */
+static unsigned long rcu_exp_gp_seq_endval(struct rcu_state *rsp)
+{
+	return rcu_seq_endval(&rsp->expedited_sequence);
+}
+
+/*
  * Record the end of an expedited grace period.
  */
 static void rcu_exp_gp_seq_end(struct rcu_state *rsp)
@@ -366,7 +375,9 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 	int ret;
 	struct rcu_node *rnp;
 
+	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
 	sync_exp_reset_tree(rsp);
+	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("select"));
 	rcu_for_each_leaf_node(rsp, rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 
@@ -443,6 +454,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 	struct rcu_node *rnp_root = rcu_get_root(rsp);
 	int ret;
 
+	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("startwait"));
 	jiffies_stall = rcu_jiffies_till_stall_check();
 	jiffies_start = jiffies;
 
-- 
2.5.2
