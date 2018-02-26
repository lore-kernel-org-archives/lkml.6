Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBZVy2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:54:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751856AbeBZVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:53 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 07/20] rcu: Remove obsolete boost statistics for debugfs
Date: Mon, 26 Feb 2018 13:52:57 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0024-0000-0000-0000032CF4E3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0025-0000-0000-000047283C13
Message-Id: <1519681990-31349-7-git-send-email-paulmck@linux.vnet.ibm.com>
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

The debugfs interface displayed statistics on RCU priority boosting,
but this interface has since been removed.  This commit therefore
removes the no-longer-used rcu_data structure's ->n_tasks_boosted,
->n_exp_boosts, and ->n_exp_boosts and their updates.

If this information proves necessary in the future, the corresponding
event traces will be added.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.h        | 6 ------
 kernel/rcu/tree_plugin.h | 8 ++------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 6488a3b0e729..01abd1c4e5da 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -146,12 +146,6 @@ struct rcu_node {
 				/*  boosting for this rcu_node structure. */
 	unsigned int boost_kthread_status;
 				/* State of boost_kthread_task for tracing. */
-	unsigned long n_tasks_boosted;
-				/* Total number of tasks boosted. */
-	unsigned long n_exp_boosts;
-				/* Number of tasks boosted for expedited GP. */
-	unsigned long n_normal_boosts;
-				/* Number of tasks boosted for normal GP. */
 #ifdef CONFIG_RCU_NOCB_CPU
 	struct swait_queue_head nocb_gp_wq[2];
 				/* Place for rcu_nocb_kthread() to wait GP. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7e31fb1e9fd8..0d552985b905 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -963,14 +963,10 @@ static int rcu_boost(struct rcu_node *rnp)
 	 * expedited grace period must boost all blocked tasks, including
 	 * those blocking the pre-existing normal grace period.
 	 */
-	if (rnp->exp_tasks != NULL) {
+	if (rnp->exp_tasks != NULL)
 		tb = rnp->exp_tasks;
-		rnp->n_exp_boosts++;
-	} else {
+	else
 		tb = rnp->boost_tasks;
-		rnp->n_normal_boosts++;
-	}
-	rnp->n_tasks_boosted++;
 
 	/*
 	 * We boost task t by manufacturing an rt_mutex that appears to
-- 
2.5.2
