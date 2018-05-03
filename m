Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeECSU7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:20:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751019AbeECSU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:20:57 -0400
Date: Thu, 3 May 2018 11:22:13 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com
Subject: Re: [PATCH tip/core/rcu 13/22] rcu: Exclude near-simultaneous RCU
 CPU stall warnings
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180423023150.GA21533@linux.vnet.ibm.com>
 <1524450747-22778-13-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524450747-22778-13-git-send-email-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050318-2213-0000-0000-0000029DD368
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008963; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027001; UDB=6.00524569; IPR=6.00806134;
 MB=3.00020910; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-03 18:20:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050318-2214-0000-0000-000059FB34C9
Message-Id: <20180503182213.GA1981@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030157
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 07:32:18PM -0700, Paul E. McKenney wrote:
> There is a two-jiffy delay between the time that a CPU will self-report
> an RCU CPU stall warning and the time that some other CPU will report a
> warning on behalf of the first CPU.  This has worked well in the past,
> but on busy systems, it is possible for the two warnings to overlap,
> which makes interpreting them extremely difficult.
> 
> This commit therefore uses a cmpxchg-based timing decision that
> allows only one report in a given one-minute period (assuming default
> stall-warning Kconfig parameters).  This approach will of course fail
> if you are seeing minute-long vCPU preemption, but in that case the
> overlapping RCU CPU stall warnings are the least of your worries.
> 
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

And later testing showed that this commit had the unfortunate side-effect
of completely suppressing other-CPU reporting of RCU CPU stalls.  The
patch below includes a fix, and this patch has been kicked out of the
queue for the next merge window in favor of the one following.

							Thanx, Paul

------------------------------------------------------------------------

commit ed569311d8d655a72f93310dbf479ca84daa736f
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Apr 9 11:04:46 2018 -0700

    rcu: Exclude near-simultaneous RCU CPU stall warnings
    
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

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35efe85c35b4..f066269d5b91 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1368,7 +1368,6 @@ static inline void panic_on_rcu_stall(void)
 static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 {
 	int cpu;
-	long delta;
 	unsigned long flags;
 	unsigned long gpa;
 	unsigned long j;
@@ -1381,18 +1380,6 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 	if (rcu_cpu_stall_suppress)
 		return;
 
-	/* Only let one CPU complain about others per time interval. */
-
-	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	delta = jiffies - READ_ONCE(rsp->jiffies_stall);
-	if (delta < RCU_STALL_RAT_DELAY || !rcu_gp_in_progress(rsp)) {
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-		return;
-	}
-	WRITE_ONCE(rsp->jiffies_stall,
-		   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
-	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-
 	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.txt for info on how to debug
@@ -1441,6 +1428,10 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 			sched_show_task(current);
 		}
 	}
+	/* Rewrite if needed in case of slow consoles. */
+	if (ULONG_CMP_GE(jiffies, READ_ONCE(rsp->jiffies_stall)))
+		WRITE_ONCE(rsp->jiffies_stall,
+			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 
 	rcu_check_gp_kthread_starvation(rsp);
 
@@ -1485,6 +1476,7 @@ static void print_cpu_stall(struct rcu_state *rsp)
 	rcu_dump_cpu_stacks(rsp);
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	/* Rewrite if needed in case of slow consoles. */
 	if (ULONG_CMP_GE(jiffies, READ_ONCE(rsp->jiffies_stall)))
 		WRITE_ONCE(rsp->jiffies_stall,
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
@@ -1508,6 +1500,7 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 	unsigned long gpnum;
 	unsigned long gps;
 	unsigned long j;
+	unsigned long jn;
 	unsigned long js;
 	struct rcu_node *rnp;
 
@@ -1546,14 +1539,17 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
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
