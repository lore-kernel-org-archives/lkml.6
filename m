Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeBZVyV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:54:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751861AbeBZVwx (ORCPT
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
Subject: [PATCH tip/core/rcu 10/20] rcu: Remove obsolete force-quiescent-state statistics for debugfs
Date: Mon, 26 Feb 2018 13:53:00 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0048-0000-0000-0000023FB3DB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0049-0000-0000-00004443360D
Message-Id: <1519681990-31349-10-git-send-email-paulmck@linux.vnet.ibm.com>
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

The debugfs interface displayed statistics on RCU-pending checks but
this interface has since been removed.  This commit therefore removes the
no-longer-used rcu_state structure's ->n_force_qs_lh and ->n_force_qs_ngp
fields along with their updates.  (Though the ->n_force_qs_ngp field
was actually not used at all, embarrassingly enough.)

If this information proves necessary in the future, the corresponding
event traces will be added.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 5 +----
 kernel/rcu/tree.h | 4 ----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 99d59be761d1..86fc087c7777 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2844,10 +2844,8 @@ static void force_quiescent_state(struct rcu_state *rsp)
 		      !raw_spin_trylock(&rnp->fqslock);
 		if (rnp_old != NULL)
 			raw_spin_unlock(&rnp_old->fqslock);
-		if (ret) {
-			rsp->n_force_qs_lh++;
+		if (ret)
 			return;
-		}
 		rnp_old = rnp;
 	}
 	/* rnp_old == rcu_get_root(rsp), rnp == NULL. */
@@ -2856,7 +2854,6 @@ static void force_quiescent_state(struct rcu_state *rsp)
 	raw_spin_lock_irqsave_rcu_node(rnp_old, flags);
 	raw_spin_unlock(&rnp_old->fqslock);
 	if (READ_ONCE(rsp->gp_flags) & RCU_GP_FLAG_FQS) {
-		rsp->n_force_qs_lh++;
 		raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
 		return;  /* Someone beat us to it. */
 	}
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d29bab8dea28..2edd56397b00 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -355,10 +355,6 @@ struct rcu_state {
 						/*  kthreads, if configured. */
 	unsigned long n_force_qs;		/* Number of calls to */
 						/*  force_quiescent_state(). */
-	unsigned long n_force_qs_lh;		/* ~Number of calls leaving */
-						/*  due to lock unavailable. */
-	unsigned long n_force_qs_ngp;		/* Number of calls leaving */
-						/*  due to no GP active. */
 	unsigned long gp_start;			/* Time at which GP started, */
 						/*  but in jiffies. */
 	unsigned long gp_activity;		/* Time of last GP kthread */
-- 
2.5.2
