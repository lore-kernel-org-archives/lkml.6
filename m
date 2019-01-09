Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FECC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA302075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfAIVTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:19:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbfAIVTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:19:00 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LIfV9093940
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:18:59 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwq4rme2t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:18:59 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:18:58 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:18:54 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LIrIU25231368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:18:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19B4BB2065;
        Wed,  9 Jan 2019 21:18:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D92ECB2068;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 65B9D16C6415; Wed,  9 Jan 2019 13:18:52 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 08/12] rcu: Determine expedited-GP IPI handler at build time
Date:   Wed,  9 Jan 2019 13:18:46 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109211830.GA30595@linux.ibm.com>
References: <20190109211830.GA30595@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0072-0000-0000-000003E73CC7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144142; UDB=6.00595707; IPR=6.00924404;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:18:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0073-0000-0000-00004ABF64F3
Message-Id: <20190109211850.31599-8-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back when there could be multiple RCU flavors running in the same kernel
at the same time, it was necessary to specify the expedited grace-period
IPI handler at runtime.  Now that there is only one RCU flavor, the
IPI handler can be determined at build time.  There is therefore no
longer any reason for the RCU-preempt and RCU-sched IPI handlers to
have different names, nor is there any reason to pass these handlers in
function arguments and in the data structures enclosing workqueues.

This commit therefore makes all these changes, pushing the specification
of the expedited grace-period IPI handler down to the point of use.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../Expedited-Grace-Periods/ExpSchedFlow.svg  | 18 ++++++-----
 .../Expedited-Grace-Periods.html              | 26 ++++++++--------
 kernel/rcu/tree.h                             |  1 -
 kernel/rcu/tree_exp.h                         | 30 +++++++++----------
 4 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/ExpSchedFlow.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/ExpSchedFlow.svg
index e4233ac93c2b..6189ffcc6aff 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/ExpSchedFlow.svg
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/ExpSchedFlow.svg
@@ -328,13 +328,13 @@
      inkscape:window-height="1148"
      id="namedview90"
      showgrid="true"
-     inkscape:zoom="0.80021373"
-     inkscape:cx="462.49289"
-     inkscape:cy="473.6718"
+     inkscape:zoom="0.69092787"
+     inkscape:cx="476.34085"
+     inkscape:cy="712.80957"
      inkscape:window-x="770"
      inkscape:window-y="24"
      inkscape:window-maximized="0"
-     inkscape:current-layer="g4114-9-3-9"
+     inkscape:current-layer="g4"
      inkscape:snap-grids="false"
      fit-margin-top="5"
      fit-margin-right="5"
@@ -813,14 +813,18 @@
       <text
          sodipodi:linespacing="125%"
          id="text4110-5-7-6-2-4-0"
-         y="841.88086"
+         y="670.74316"
          x="1460.1007"
          style="font-size:267.24359131px;font-style:normal;font-weight:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Sans"
          xml:space="preserve"><tspan
-           y="841.88086"
+           y="670.74316"
+           x="1460.1007"
+           sodipodi:role="line"
+           id="tspan4925-1-2-4-5">Request</tspan><tspan
+           y="1004.7976"
            x="1460.1007"
            sodipodi:role="line"
-           id="tspan4925-1-2-4-5">reched_cpu()</tspan></text>
+           id="tspan3100">context switch</tspan></text>
     </g>
   </g>
 </svg>
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
index 8e4f873b979f..19e7a5fb6b73 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
@@ -72,10 +72,10 @@ will ignore it because idle and offline CPUs are already residing
 in quiescent states.
 Otherwise, the expedited grace period will use
 <tt>smp_call_function_single()</tt> to send the CPU an IPI, which
-is handled by <tt>sync_rcu_exp_handler()</tt>.
+is handled by <tt>rcu_exp_handler()</tt>.
 
 <p>
-However, because this is preemptible RCU, <tt>sync_rcu_exp_handler()</tt>
+However, because this is preemptible RCU, <tt>rcu_exp_handler()</tt>
 can check to see if the CPU is currently running in an RCU read-side
 critical section.
 If not, the handler can immediately report a quiescent state.
@@ -145,19 +145,18 @@ expedited grace period is shown in the following diagram:
 <p><img src="ExpSchedFlow.svg" alt="ExpSchedFlow.svg" width="55%">
 
 <p>
-As with RCU-preempt's <tt>synchronize_rcu_expedited()</tt>,
+As with RCU-preempt, RCU-sched's
 <tt>synchronize_sched_expedited()</tt> ignores offline and
 idle CPUs, again because they are in remotely detectable
 quiescent states.
-However, the <tt>synchronize_rcu_expedited()</tt> handler
-is <tt>sync_sched_exp_handler()</tt>, and because the
+However, because the
 <tt>rcu_read_lock_sched()</tt> and <tt>rcu_read_unlock_sched()</tt>
 leave no trace of their invocation, in general it is not possible to tell
 whether or not the current CPU is in an RCU read-side critical section.
-The best that <tt>sync_sched_exp_handler()</tt> can do is to check
+The best that RCU-sched's <tt>rcu_exp_handler()</tt> can do is to check
 for idle, on the off-chance that the CPU went idle while the IPI
 was in flight.
-If the CPU is idle, then <tt>sync_sched_exp_handler()</tt> reports
+If the CPU is idle, then <tt>rcu_exp_handler()</tt> reports
 the quiescent state.
 
 <p> Otherwise, the handler forces a future context switch by setting the
@@ -298,19 +297,18 @@ Instead, the task pushing the grace period forward will include the
 idle CPUs in the mask passed to <tt>rcu_report_exp_cpu_mult()</tt>.
 
 <p>
-For RCU-sched, there is an additional check for idle in the IPI
-handler, <tt>sync_sched_exp_handler()</tt>.
+For RCU-sched, there is an additional check:
 If the IPI has interrupted the idle loop, then
-<tt>sync_sched_exp_handler()</tt> invokes <tt>rcu_report_exp_rdp()</tt>
+<tt>rcu_exp_handler()</tt> invokes <tt>rcu_report_exp_rdp()</tt>
 to report the corresponding quiescent state.
 
 <p>
 For RCU-preempt, there is no specific check for idle in the
-IPI handler (<tt>sync_rcu_exp_handler()</tt>), but because
+IPI handler (<tt>rcu_exp_handler()</tt>), but because
 RCU read-side critical sections are not permitted within the
-idle loop, if <tt>sync_rcu_exp_handler()</tt> sees that the CPU is within
+idle loop, if <tt>rcu_exp_handler()</tt> sees that the CPU is within
 RCU read-side critical section, the CPU cannot possibly be idle.
-Otherwise, <tt>sync_rcu_exp_handler()</tt> invokes
+Otherwise, <tt>rcu_exp_handler()</tt> invokes
 <tt>rcu_report_exp_rdp()</tt> to report the corresponding quiescent
 state, regardless of whether or not that quiescent state was due to
 the CPU being idle.
@@ -625,6 +623,8 @@ checks, but only during the mid-boot dead zone.
 <p>
 With this refinement, synchronous grace periods can now be used from
 task context pretty much any time during the life of the kernel.
+That is, aside from some points in the suspend, hibernate, or shutdown
+code path.
 
 <h3><a name="Summary">
 Summary</a></h3>
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index bcfd684a5c57..50bb41cdc5fb 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -36,7 +36,6 @@
 
 /* Communicate arguments to a workqueue handler. */
 struct rcu_exp_work {
-	smp_call_func_t rew_func;
 	unsigned long rew_s;
 	struct work_struct rew_work;
 };
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6d4eb4694b6f..7f5cb4228b59 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -22,6 +22,8 @@
 
 #include <linux/lockdep.h>
 
+static void rcu_exp_handler(void *unused);
+
 /*
  * Record the start of an expedited grace period.
  */
@@ -344,7 +346,6 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 {
 	int cpu;
 	unsigned long flags;
-	smp_call_func_t func;
 	unsigned long mask_ofl_test;
 	unsigned long mask_ofl_ipi;
 	int ret;
@@ -352,7 +353,6 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 		container_of(wp, struct rcu_exp_work, rew_work);
 	struct rcu_node *rnp = container_of(rewp, struct rcu_node, rew);
 
-	func = rewp->rew_func;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 
 	/* Each pass checks a CPU for identity, offline, and idle. */
@@ -396,7 +396,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 			mask_ofl_test |= mask;
 			continue;
 		}
-		ret = smp_call_function_single(cpu, func, NULL, 0);
+		ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
 		if (!ret) {
 			mask_ofl_ipi &= ~mask;
 			continue;
@@ -426,7 +426,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
  * Select the nodes that the upcoming expedited grace period needs
  * to wait for.
  */
-static void sync_rcu_exp_select_cpus(smp_call_func_t func)
+static void sync_rcu_exp_select_cpus(void)
 {
 	int cpu;
 	struct rcu_node *rnp;
@@ -440,7 +440,6 @@ static void sync_rcu_exp_select_cpus(smp_call_func_t func)
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
-		rnp->rew.rew_func = func;
 		if (!READ_ONCE(rcu_par_gp_wq) ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
 		    rcu_is_last_leaf_node(rnp)) {
@@ -580,10 +579,10 @@ static void rcu_exp_wait_wake(unsigned long s)
  * Common code to drive an expedited grace period forward, used by
  * workqueues and mid-boot-time tasks.
  */
-static void rcu_exp_sel_wait_wake(smp_call_func_t func, unsigned long s)
+static void rcu_exp_sel_wait_wake(unsigned long s)
 {
 	/* Initialize the rcu_node tree in preparation for the wait. */
-	sync_rcu_exp_select_cpus(func);
+	sync_rcu_exp_select_cpus();
 
 	/* Wait and clean up, including waking everyone. */
 	rcu_exp_wait_wake(s);
@@ -597,14 +596,14 @@ static void wait_rcu_exp_gp(struct work_struct *wp)
 	struct rcu_exp_work *rewp;
 
 	rewp = container_of(wp, struct rcu_exp_work, rew_work);
-	rcu_exp_sel_wait_wake(rewp->rew_func, rewp->rew_s);
+	rcu_exp_sel_wait_wake(rewp->rew_s);
 }
 
 /*
  * Given a smp_call_function() handler, kick off the specified
  * implementation of expedited grace period.
  */
-static void _synchronize_rcu_expedited(smp_call_func_t func)
+static void _synchronize_rcu_expedited(void)
 {
 	struct rcu_data *rdp;
 	struct rcu_exp_work rew;
@@ -625,10 +624,9 @@ static void _synchronize_rcu_expedited(smp_call_func_t func)
 	/* Ensure that load happens before action based on it. */
 	if (unlikely(rcu_scheduler_active == RCU_SCHEDULER_INIT)) {
 		/* Direct call during scheduler init and early_initcalls(). */
-		rcu_exp_sel_wait_wake(func, s);
+		rcu_exp_sel_wait_wake(s);
 	} else {
 		/* Marshall arguments & schedule the expedited grace period. */
-		rew.rew_func = func;
 		rew.rew_s = s;
 		INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
 		queue_work(rcu_gp_wq, &rew.rew_work);
@@ -654,7 +652,7 @@ static void _synchronize_rcu_expedited(smp_call_func_t func)
  * ->expmask fields in the rcu_node tree.  Otherwise, immediately
  * report the quiescent state.
  */
-static void sync_rcu_exp_handler(void *unused)
+static void rcu_exp_handler(void *unused)
 {
 	unsigned long flags;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
@@ -760,14 +758,14 @@ void synchronize_rcu_expedited(void)
 
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return;
-	_synchronize_rcu_expedited(sync_rcu_exp_handler);
+	_synchronize_rcu_expedited();
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /* Invoked on each online non-idle CPU for expedited quiescent state. */
-static void sync_sched_exp_handler(void *unused)
+static void rcu_exp_handler(void *unused)
 {
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
@@ -799,7 +797,7 @@ static void sync_sched_exp_online_cleanup(int cpu)
 	rnp = rdp->mynode;
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask))
 		return;
-	ret = smp_call_function_single(cpu, sync_sched_exp_handler, NULL, 0);
+	ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
 	WARN_ON_ONCE(ret);
 }
 
@@ -835,7 +833,7 @@ void synchronize_rcu_expedited(void)
 	if (rcu_blocking_is_gp())
 		return;
 
-	_synchronize_rcu_expedited(sync_sched_exp_handler);
+	_synchronize_rcu_expedited();
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 
-- 
2.17.1

