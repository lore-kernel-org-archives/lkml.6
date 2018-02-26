Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeBZVxA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:53:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751610AbeBZVwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:50 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 08/20] rcu: Remove obsolete callback-invocation statistics for debugfs
Date: Mon, 26 Feb 2018 13:52:58 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0008-0000-0000-000002DB9D2D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0009-0000-0000-00003864E4FA
Message-Id: <1519681990-31349-8-git-send-email-paulmck@linux.vnet.ibm.com>
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

The debugfs interface displayed statistics on RCU callback invocation but
this interface has since been removed.  This commit therefore removes the
no-longer-used rcu_data structure's ->n_cbs_invoked and ->n_nocbs_invoked
fields along with their updates.

If this information proves necessary in the future, the corresponding
event traces will be added.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 1 -
 kernel/rcu/tree.h        | 2 --
 kernel/rcu/tree_plugin.h | 1 -
 3 files changed, 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 66c73a214cff..8e0711954bbf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2691,7 +2691,6 @@ static void rcu_do_batch(struct rcu_state *rsp, struct rcu_data *rdp)
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
 	smp_mb(); /* List handling before counting for rcu_barrier(). */
-	rdp->n_cbs_invoked += count;
 	rcu_segcblist_insert_count(&rdp->cblist, &rcl);
 
 	/* Reinstate batch limit if we have worked down the excess. */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 01abd1c4e5da..b258fac73524 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -211,8 +211,6 @@ struct rcu_data {
 					/* different grace periods. */
 	long		qlen_last_fqs_check;
 					/* qlen at last check for QS forcing */
-	unsigned long	n_cbs_invoked;	/* count of RCU cbs invoked. */
-	unsigned long	n_nocbs_invoked; /* count of no-CBs RCU cbs invoked. */
 	unsigned long	n_force_qs_snap;
 					/* did other CPU force QS recently? */
 	long		blimit;		/* Upper limit on a processed batch */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0d552985b905..1c2d58a85511 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2243,7 +2243,6 @@ static int rcu_nocb_kthread(void *arg)
 		smp_mb__before_atomic();  /* _add after CB invocation. */
 		atomic_long_add(-c, &rdp->nocb_q_count);
 		atomic_long_add(-cl, &rdp->nocb_q_count_lazy);
-		rdp->n_nocbs_invoked += c;
 	}
 	return 0;
 }
-- 
2.5.2
