Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935643AbeCCAxp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 19:53:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935626AbeCCAxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 19:53:43 -0500
Date: Fri, 2 Mar 2018 16:54:05 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 06/10] trace: Eliminate
 cond_resched_rcu_qs() in favor of cond_resched()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180225174927.GC2855@linux.vnet.ibm.com>
 <20180225181730.GA3963@linux.vnet.ibm.com>
 <20180225183944.GA8840@linux.vnet.ibm.com>
 <20180226212920.43e25d6e@vmware.local.home>
 <20180227153646.GD3777@linux.vnet.ibm.com>
 <20180228181252.55e0590c@vmware.local.home>
 <20180301012144.GX3777@linux.vnet.ibm.com>
 <20180301000404.64828a0e@vmware.local.home>
 <20180301204858.GH3777@linux.vnet.ibm.com>
 <20180302150621.069d1443@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302150621.069d1443@vmware.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030300-0008-0000-0000-000002DE758F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008611; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00997508; UDB=6.00507213; IPR=6.00776826;
 MB=3.00019827; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-03 00:53:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030300-0009-0000-0000-00003870DFDC
Message-Id: <20180303005405.GA3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803030010
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 03:06:21PM -0500, Steven Rostedt wrote:
> On Thu, 1 Mar 2018 12:48:58 -0800
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > So how about I rename cond_resched_rcu_qs() to cond_resched_tasks_rcu_qs(),
> > which at least gives a hint as to where it needs to be used?
> > 
> > Would that work for you?
> 
> Yes, definitely!

Like this?

							Thanx, Paul

------------------------------------------------------------------------

commit 4551cfd69a85393f478462fe5e16e42f0fa6391e
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Fri Mar 2 16:35:27 2018 -0800

    rcu: Rename cond_resched_rcu_qs() to cond_resched_tasks_rcu_qs()
    
    Commit e31d28b6ab8f ("trace: Eliminate cond_resched_rcu_qs() in favor
    of cond_resched()") substituted cond_resched() for the earlier call
    to cond_resched_rcu_qs().  However, the new-age cond_resched() does
    not do anything to help RCU-tasks grace periods because (1) RCU-tasks
    is only enabled when CONFIG_PREEMPT=y and (2) cond_resched() is a
    complete no-op when preemption is enabled.  This situation results
    in hangs when running the trace benchmarks.
    
    A number of potential fixes were discussed on LKML
    (https://lkml.kernel.org/r/20180224151240.0d63a059@vmware.local.home),
    including making cond_resched() not be a no-op; making cond_resched()
    not be a no-op, but only when running tracing benchmarks; reverting
    the aforementioned commit (which works because cond_resched_rcu_qs()
    does provide an RCU-tasks quiescent state; and adding a call to the
    scheduler/RCU rcu_note_voluntary_context_switch() function.  All were
    deemed unsatisfactory, either due to added cond_resched() overhead or
    due to magic functions inviting cargo culting.
    
    This commit renames cond_resched_rcu_qs() to cond_resched_tasks_rcu_qs(),
    which provides a clear hint as to what this function is doing and
    why and where it should be used, and then replaces the call to
    cond_resched() with cond_resched_tasks_rcu_qs() in the trace benchmark's
    benchmark_event_kthread() function.
    
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 36360d07f25b..19d235fefdb9 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -188,13 +188,13 @@ static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
 
 /**
- * cond_resched_rcu_qs - Report potential quiescent states to RCU
+ * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
  *
  * This macro resembles cond_resched(), except that it is defined to
  * report potential quiescent states to RCU-tasks even if the cond_resched()
  * machinery were to be shut off, as some advocate for PREEMPT kernels.
  */
-#define cond_resched_rcu_qs() \
+#define cond_resched_tasks_rcu_qs() \
 do { \
 	if (!cond_resched()) \
 		rcu_note_voluntary_context_switch_lite(current); \
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 777e7a6a0292..e232846516b3 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -369,7 +369,7 @@ static bool __maybe_unused torturing_tasks(void)
  */
 static void rcu_perf_wait_shutdown(void)
 {
-	cond_resched_rcu_qs();
+	cond_resched_tasks_rcu_qs();
 	if (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters)
 		return;
 	while (!torture_must_stop())
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8fde264e24aa..381b47a68ac6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1234,10 +1234,10 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	}
 
 	/*
-	 * Has this CPU encountered a cond_resched_rcu_qs() since the
-	 * beginning of the grace period?  For this to be the case,
-	 * the CPU has to have noticed the current grace period.  This
-	 * might not be the case for nohz_full CPUs looping in the kernel.
+	 * Has this CPU encountered a cond_resched() since the beginning
+	 * of the grace period?  For this to be the case, the CPU has to
+	 * have noticed the current grace period.  This might not be the
+	 * case for nohz_full CPUs looping in the kernel.
 	 */
 	jtsq = jiffies_till_sched_qs;
 	ruqp = per_cpu_ptr(&rcu_dynticks.rcu_urgent_qs, rdp->cpu);
@@ -2049,7 +2049,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 					    rnp->level, rnp->grplo,
 					    rnp->grphi, rnp->qsmask);
 		raw_spin_unlock_irq_rcu_node(rnp);
-		cond_resched_rcu_qs();
+		cond_resched_tasks_rcu_qs();
 		WRITE_ONCE(rsp->gp_activity, jiffies);
 	}
 
@@ -2152,7 +2152,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 		sq = rcu_nocb_gp_get(rnp);
 		raw_spin_unlock_irq_rcu_node(rnp);
 		rcu_nocb_gp_cleanup(sq);
-		cond_resched_rcu_qs();
+		cond_resched_tasks_rcu_qs();
 		WRITE_ONCE(rsp->gp_activity, jiffies);
 		rcu_gp_slow(rsp, gp_cleanup_delay);
 	}
@@ -2203,7 +2203,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 			/* Locking provides needed memory barrier. */
 			if (rcu_gp_init(rsp))
 				break;
-			cond_resched_rcu_qs();
+			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rsp->gp_activity, jiffies);
 			WARN_ON(signal_pending(current));
 			trace_rcu_grace_period(rsp->name,
@@ -2248,7 +2248,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 				trace_rcu_grace_period(rsp->name,
 						       READ_ONCE(rsp->gpnum),
 						       TPS("fqsend"));
-				cond_resched_rcu_qs();
+				cond_resched_tasks_rcu_qs();
 				WRITE_ONCE(rsp->gp_activity, jiffies);
 				ret = 0; /* Force full wait till next FQS. */
 				j = jiffies_till_next_fqs;
@@ -2261,7 +2261,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 				}
 			} else {
 				/* Deal with stray signal. */
-				cond_resched_rcu_qs();
+				cond_resched_tasks_rcu_qs();
 				WRITE_ONCE(rsp->gp_activity, jiffies);
 				WARN_ON(signal_pending(current));
 				trace_rcu_grace_period(rsp->name,
@@ -2784,7 +2784,7 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rsp, rnp) {
-		cond_resched_rcu_qs();
+		cond_resched_tasks_rcu_qs();
 		mask = 0;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->qsmask == 0) {
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3695c12cfcdc..9accacffd138 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1632,7 +1632,7 @@ static int rcu_oom_notify(struct notifier_block *self,
 
 	for_each_online_cpu(cpu) {
 		smp_call_function_single(cpu, rcu_oom_notify_cpu, NULL, 1);
-		cond_resched_rcu_qs();
+		cond_resched_tasks_rcu_qs();
 	}
 
 	/* Unconditionally decrement: no need to wake ourselves up. */
@@ -2261,7 +2261,7 @@ static int rcu_nocb_kthread(void *arg)
 				cl++;
 			c++;
 			local_bh_enable();
-			cond_resched_rcu_qs();
+			cond_resched_tasks_rcu_qs();
 			list = next;
 		}
 		trace_rcu_batch_end(rdp->rsp->name, c, !!list, 0, 0, 1);
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 68fa19a5e7bd..e401960c7f51 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -624,7 +624,7 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks);
  * grace period has elapsed, in other words after all currently
  * executing rcu-tasks read-side critical sections have elapsed.  These
  * read-side critical sections are delimited by calls to schedule(),
- * cond_resched_rcu_qs(), idle execution, userspace execution, calls
+ * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
  * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
  *
  * This is a very specialized primitive, intended only for a few uses in
diff --git a/kernel/torture.c b/kernel/torture.c
index 37b94012a3f8..3de1efbecd6a 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -574,7 +574,7 @@ void stutter_wait(const char *title)
 {
 	int spt;
 
-	cond_resched_rcu_qs();
+	cond_resched_tasks_rcu_qs();
 	spt = READ_ONCE(stutter_pause_test);
 	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
 		if (spt == 1) {
diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 22fee766081b..80e0b2aca703 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -159,13 +159,13 @@ static int benchmark_event_kthread(void *arg)
 		 * wants to run, schedule in, but if the CPU is idle,
 		 * we'll keep burning cycles.
 		 *
-		 * Note the _rcu_qs() version of cond_resched() will
+		 * Note the tasks_rcu_qs() version of cond_resched() will
 		 * notify synchronize_rcu_tasks() that this thread has
 		 * passed a quiescent state for rcu_tasks. Otherwise
 		 * this thread will never voluntarily schedule which would
 		 * block synchronize_rcu_tasks() indefinitely.
 		 */
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 	}
 
 	return 0;
