Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeDWCb0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:31:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753932AbeDWCbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:21 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 02/22] rcu: Inline rcu_preempt_do_callback() into its sole caller
Date: Sun, 22 Apr 2018 19:32:07 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0024-0000-0000-0000034CCE30
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0025-0000-0000-000047C2DB4A
Message-Id: <1524450747-22778-2-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Byungchul Park <byungchul.park@lge.com>

The rcu_preempt_do_callbacks() function was introduced in commit
09223371dea(rcu: Use softirq to address performance regression), where it
was necessary to handle kernel builds both containing and not containing
RCU-preempt.  Since then, various changes (most notably f8b7fc6b51
("rcu: use softirq instead of kthreads except when RCU_BOOST=y")) have
resulted in this function being invoked only from rcu_kthread_do_work(),
which is present only in kernels containing RCU-preempt, which in turn
means that the rcu_preempt_do_callbacks() function is no longer needed.

This commit therefore inlines rcu_preempt_do_callbacks() into its
sole remaining caller and also removes the rcu_state_p and rcu_data_p
indirection for added clarity.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[ paulmck: Remove the rcu_state_p and rcu_data_p indirection. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_plugin.h | 11 +----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index f491ab4f2e8e..3a0dc30100e8 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -438,7 +438,6 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static void invoke_rcu_callbacks_kthread(void);
 static bool rcu_is_callbacks_kthread(void);
 #ifdef CONFIG_RCU_BOOST
-static void rcu_preempt_do_callbacks(void);
 static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
 						 struct rcu_node *rnp);
 #endif /* #ifdef CONFIG_RCU_BOOST */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 84fbee4686d3..6c5df18bbf2f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -685,15 +685,6 @@ static void rcu_preempt_check_callbacks(void)
 		t->rcu_read_unlock_special.b.need_qs = true;
 }
 
-#ifdef CONFIG_RCU_BOOST
-
-static void rcu_preempt_do_callbacks(void)
-{
-	rcu_do_batch(rcu_state_p, this_cpu_ptr(rcu_data_p));
-}
-
-#endif /* #ifdef CONFIG_RCU_BOOST */
-
 /**
  * call_rcu() - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -1140,7 +1131,7 @@ static void rcu_kthread_do_work(void)
 {
 	rcu_do_batch(&rcu_sched_state, this_cpu_ptr(&rcu_sched_data));
 	rcu_do_batch(&rcu_bh_state, this_cpu_ptr(&rcu_bh_data));
-	rcu_preempt_do_callbacks();
+	rcu_do_batch(&rcu_preempt_state, this_cpu_ptr(&rcu_preempt_data));
 }
 
 static void rcu_cpu_kthread_setup(unsigned int cpu)
-- 
2.5.2
