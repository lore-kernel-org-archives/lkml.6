Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754245AbeDWCdf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:33:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753947AbeDWCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:31:23 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 13/22] rcu: Exclude near-simultaneous RCU CPU stall warnings
Date: Sun, 22 Apr 2018 19:32:18 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423023150.GA21533@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042302-0044-0000-0000-0000040972DB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:31:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0045-0000-0000-0000083B7BD8
Message-Id: <1524450747-22778-13-git-send-email-paulmck@linux.vnet.ibm.com>
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

There is a two-jiffy delay between the time that a CPU will self-report
an RCU CPU stall warning and the time that some other CPU will report a
warning on behalf of the first CPU.  This has worked well in the past,
but on busy systems, it is possible for the two warnings to overlap,
which makes interpreting them extremely difficult.

This commit therefore uses a cmpxchg-based timing decision that
allows only one report in a given one-minute period (assuming default
stall-warning Kconfig parameters).  This approach will of course fail
if you are seeing minute-long vCPU preemption, but in that case the
overlapping RCU CPU stall warnings are the least of your worries.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c4db0e20b035..19d9475d74f2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1429,8 +1429,6 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
-	WRITE_ONCE(rsp->jiffies_stall,
-		   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	/*
@@ -1481,6 +1479,10 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 			sched_show_task(current);
 		}
 	}
+	/* Rewrite if needed in case of slow consoles. */
+	if (ULONG_CMP_GE(jiffies, READ_ONCE(rsp->jiffies_stall)))
+		WRITE_ONCE(rsp->jiffies_stall,
+			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 
 	rcu_check_gp_kthread_starvation(rsp);
 
@@ -1525,6 +1527,7 @@ static void print_cpu_stall(struct rcu_state *rsp)
 	rcu_dump_cpu_stacks(rsp);
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	/* Rewrite if needed in case of slow consoles. */
 	if (ULONG_CMP_GE(jiffies, READ_ONCE(rsp->jiffies_stall)))
 		WRITE_ONCE(rsp->jiffies_stall,
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
@@ -1548,6 +1551,7 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 	unsigned long gpnum;
 	unsigned long gps;
 	unsigned long j;
+	unsigned long jn;
 	unsigned long js;
 	struct rcu_node *rnp;
 
@@ -1586,14 +1590,17 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 	    ULONG_CMP_GE(gps, js))
 		return; /* No stall or GP completed since entering function. */
 	rnp = rdp->mynode;
+	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
 	if (rcu_gp_in_progress(rsp) &&
-	    (READ_ONCE(rnp->qsmask) & rdp->grpmask)) {
+	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
+	    cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
 
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall(rsp);
 
 	} else if (rcu_gp_in_progress(rsp) &&
-		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY)) {
+		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
+		   cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
 
 		/* They had a few time units to dump stack, so complain. */
 		print_other_cpu_stall(rsp, gpnum);
-- 
2.5.2
