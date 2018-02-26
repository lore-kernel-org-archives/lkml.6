Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeBZWC0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:02:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751677AbeBZWCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:02:21 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 02/12] rcutorture: Abstract function and module names
Date: Mon, 26 Feb 2018 14:02:31 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226220225.GA32136@linux.vnet.ibm.com>
References: <20180226220225.GA32136@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022622-2213-0000-0000-000002764605
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995533; UDB=6.00506035; IPR=6.00774861;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:02:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-2214-0000-0000-0000593F3C6D
Message-Id: <1519682561-510-2-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit moves to __func__ for function names and for KBUILD_MODNAME
for module names, all in the name of better resilience to change.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b4a201dcbc55..0f94025c672a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -924,19 +924,19 @@ rcu_torture_writer(void *arg)
 	if (gp_cond1 && cur_ops->get_state && cur_ops->cond_sync)
 		synctype[nsynctypes++] = RTWS_COND_GET;
 	else if (gp_cond && (!cur_ops->get_state || !cur_ops->cond_sync))
-		pr_alert("rcu_torture_writer: gp_cond without primitives.\n");
+		pr_alert("%s: gp_cond without primitives.\n", __func__);
 	if (gp_exp1 && cur_ops->exp_sync)
 		synctype[nsynctypes++] = RTWS_EXP_SYNC;
 	else if (gp_exp && !cur_ops->exp_sync)
-		pr_alert("rcu_torture_writer: gp_exp without primitives.\n");
+		pr_alert("%s: gp_exp without primitives.\n", __func__);
 	if (gp_normal1 && cur_ops->deferred_free)
 		synctype[nsynctypes++] = RTWS_DEF_FREE;
 	else if (gp_normal && !cur_ops->deferred_free)
-		pr_alert("rcu_torture_writer: gp_normal without primitives.\n");
+		pr_alert("%s: gp_normal without primitives.\n", __func__);
 	if (gp_sync1 && cur_ops->sync)
 		synctype[nsynctypes++] = RTWS_SYNC;
 	else if (gp_sync && !cur_ops->sync)
-		pr_alert("rcu_torture_writer: gp_sync without primitives.\n");
+		pr_alert("%s: gp_sync without primitives.\n", __func__);
 	if (WARN_ONCE(nsynctypes == 0,
 		      "rcu_torture_writer: No update-side primitives.\n")) {
 		/*
@@ -1673,7 +1673,7 @@ static void rcu_torture_err_cb(struct rcu_head *rhp)
 	 * next grace period.  Unlikely, but can happen.  If it
 	 * does happen, the debug-objects subsystem won't have splatted.
 	 */
-	pr_alert("rcutorture: duplicated callback was invoked.\n");
+	pr_alert("%s: duplicated callback was invoked.\n", KBUILD_MODNAME);
 }
 #endif /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
@@ -1690,7 +1690,7 @@ static void rcu_test_debug_objects(void)
 
 	init_rcu_head_on_stack(&rh1);
 	init_rcu_head_on_stack(&rh2);
-	pr_alert("rcutorture: WARN: Duplicate call_rcu() test starting.\n");
+	pr_alert("%s: WARN: Duplicate call_rcu() test starting.\n", KBUILD_MODNAME);
 
 	/* Try to queue the rh2 pair of callbacks for the same grace period. */
 	preempt_disable(); /* Prevent preemption from interrupting test. */
@@ -1705,11 +1705,11 @@ static void rcu_test_debug_objects(void)
 
 	/* Wait for them all to get done so we can safely return. */
 	rcu_barrier();
-	pr_alert("rcutorture: WARN: Duplicate call_rcu() test complete.\n");
+	pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
 	destroy_rcu_head_on_stack(&rh1);
 	destroy_rcu_head_on_stack(&rh2);
 #else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
-	pr_alert("rcutorture: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n");
+	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
 #endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 }
 
-- 
2.5.2
