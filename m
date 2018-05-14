Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeENVDW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:03:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752120AbeENVDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:03:17 -0400
Date: Mon, 14 May 2018 14:04:42 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, peterz@infradead.org
Subject: Re: [PATCH] rcu: Report a quiescent state when it's exactly in the
 state
Reply-To: paulmck@linux.vnet.ibm.com
References: <1526027434-21237-1-git-send-email-byungchul.park@lge.com>
 <3af4cec0-4019-e3ac-77f9-8631252fb6da@lge.com>
 <20180511161746.GX26088@linux.vnet.ibm.com>
 <20180511224138.GA89902@joelaf.mtv.corp.google.com>
 <9f2e445b-15b0-d1fa-832c-f801efc34d03@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f2e445b-15b0-d1fa-832c-f801efc34d03@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051421-0008-0000-0000-00000307632E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032333; UDB=6.00527754; IPR=6.00811465;
 MB=3.00021113; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 21:03:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051421-0009-0000-0000-0000393FC083
Message-Id: <20180514210441.GL26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:59:41AM +0900, Byungchul Park wrote:
> On 2018-05-12 오전 7:41, Joel Fernandes wrote:
> >On Fri, May 11, 2018 at 09:17:46AM -0700, Paul E. McKenney wrote:
> >>On Fri, May 11, 2018 at 09:57:54PM +0900, Byungchul Park wrote:
> >>>Hello folks,
> >>>
> >>>I think I wrote the title in a misleading way.
> >>>
> >>>Please change the title to something else such as,
> >>>"rcu: Report a quiescent state when it's in the state" or,
> >>>"rcu: Add points reporting quiescent states where proper" or so on.
> >>>
> >>>On 2018-05-11 오후 5:30, Byungchul Park wrote:
> >>>>We expect a quiescent state of TASKS_RCU when cond_resched_tasks_rcu_qs()
> >>>>is called, no matter whether it actually be scheduled or not. However,
> >>>>it currently doesn't report the quiescent state when the task enters
> >>>>into __schedule() as it's called with preempt = true. So make it report
> >>>>the quiescent state unconditionally when cond_resched_tasks_rcu_qs() is
> >>>>called.
> >>>>
> >>>>And in TINY_RCU, even though the quiescent state of rcu_bh also should
> >>>>be reported when the tick interrupt comes from user, it doesn't. So make
> >>>>it reported.
> >>>>
> >>>>Lastly in TREE_RCU, rcu_note_voluntary_context_switch() should be
> >>>>reported when the tick interrupt comes from not only user but also idle,
> >>>>as an extended quiescent state.
> >>>>
> >>>>Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> >>>>---
> >>>>  include/linux/rcupdate.h | 4 ++--
> >>>>  kernel/rcu/tiny.c        | 6 +++---
> >>>>  kernel/rcu/tree.c        | 4 ++--
> >>>>  3 files changed, 7 insertions(+), 7 deletions(-)
> >>>>
> >>>>diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> >>>>index ee8cf5fc..7432261 100644
> >>>>--- a/include/linux/rcupdate.h
> >>>>+++ b/include/linux/rcupdate.h
> >>>>@@ -195,8 +195,8 @@ static inline void exit_tasks_rcu_finish(void) { }
> >>>>   */
> >>>>  #define cond_resched_tasks_rcu_qs() \
> >>>>  do { \
> >>>>-	if (!cond_resched()) \
> >>>>-		rcu_note_voluntary_context_switch_lite(current); \
> >>>>+	rcu_note_voluntary_context_switch_lite(current); \
> >>>>+	cond_resched(); \
> >>
> >>Ah, good point.
> >>
> >>Peter, I have to ask...  Why is "cond_resched()" considered a preemption
> >>while "schedule()" is not?
> >
> >Infact something interesting I inferred from the __schedule loop related to
> >your question:
> >
> >switch_count can either be set to prev->invcsw or prev->nvcsw. If we can
> >assume that switch_count reflects whether the context switch is involuntary
> >or voluntary,
> >task-running-state	preempt		switch_count
> >0 (running)		1		involuntary
> >0			0		involuntary
> >1			0		voluntary
> >1			1		involuntary
> >
> >According to the above table, both the task's running state and the preempt
> >parameter to __schedule should be used together to determine if the switch is
> >a voluntary one or not.
> >
> >So this code in rcu_note_context_switch should really be:
> >if (!preempt && !(current->state & TASK_RUNNING))
> >	rcu_note_voluntary_context_switch_lite(current);
> >
> >According to the above table, cond_resched always classifies as an
> >involuntary switch which makes sense to me. Even though cond_resched is
> 
> Hello guys,
> 
> The classification for nivcsw/nvcsw used in scheduler core, Joel, you
> showed us is different from that used in when we distinguish between
> non preemption/voluntary preemption/preemption/full and so on, even
> they use the same word, "voluntary" though.
> 
> The name, rcu_note_voluntary_context_switch_lite() used in RCU has
> a lot to do with the latter, the term of preemption. Furthermore, I
> think the function should be called even when calling schedule() for
> sleep as well. I think it would be better to change the function
> name to something else to prevent confusing, it's up to Paul tho. :)

Given what it currently does, the name should be rcu_tasks_qs() to go
along with rcu_bh_qs(), rcu_preempt_qs(), and rcu_sched_qs().  Much as
I would like cond_resched() to be an RCU-tasks quiescent state, it is
nothingness for PREEMPT=y kernels, and Peter has indicated a strong
interest in having it remain so.  But I did update a few comments.

I left rcu_note_voluntary_context_switch() alone because it should be
disappearing entirely Real Soon Now.

Please see patch below.

							Thanx, Paul

PS.  Oddly enough, the recent patch removing the "if" from
     cond_resched_tasks_rcu_qs() is (technically speaking) pointless.
     If the kernel contains RCU-tasks, it must be preemptible, which
     means that cond_resched() unconditionally returns false, which
     in turn means that rcu_note_voluntary_context_switch_lite() was
     unconditionally invoked.

     Simiarly, in non-preemptible kernels, where cond_resched()
     might well return true, rcu_note_voluntary_context_switch_lite()
     is a no-op.

     So that patch had no effect, but I am keeping it due to the
     improved readability.  I should probably update its commit log,
     though.  ;-)

------------------------------------------------------------------------

commit 5b39fc0d9bc6c806cb42ed546c37655689b4dbdd
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon May 14 13:52:27 2018 -0700

    rcu: Improve RCU-tasks naming and comments
    
    The naming and comments associated with some RCU-tasks code make
    the faulty assumption that context switches due to cond_resched()
    are voluntary.  As several people pointed out, this is not the case.
    This commit therefore updates function names and comments to better
    reflect current reality.
    
    Reported-by: Byungchul Park <byungchul.park@lge.com>
    Reported-by: Joel Fernandes <joel@joelfernandes.org>
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 028d07ce198a..713b93af26f3 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -159,11 +159,11 @@ static inline void rcu_init_nohz(void) { }
 	} while (0)
 
 /*
- * Note a voluntary context switch for RCU-tasks benefit.  This is a
- * macro rather than an inline function to avoid #include hell.
+ * Note a quasi-voluntary context switch for RCU-tasks's benefit.
+ * This is a macro rather than an inline function to avoid #include hell.
  */
 #ifdef CONFIG_TASKS_RCU
-#define rcu_note_voluntary_context_switch_lite(t) \
+#define rcu_tasks_qs(t) \
 	do { \
 		if (READ_ONCE((t)->rcu_tasks_holdout)) \
 			WRITE_ONCE((t)->rcu_tasks_holdout, false); \
@@ -171,14 +171,14 @@ static inline void rcu_init_nohz(void) { }
 #define rcu_note_voluntary_context_switch(t) \
 	do { \
 		rcu_all_qs(); \
-		rcu_note_voluntary_context_switch_lite(t); \
+		rcu_tasks_qs(t); \
 	} while (0)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
 void exit_tasks_rcu_start(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU */
-#define rcu_note_voluntary_context_switch_lite(t)	do { } while (0)
+#define rcu_tasks_qs(t)	do { } while (0)
 #define rcu_note_voluntary_context_switch(t)		rcu_all_qs()
 #define call_rcu_tasks call_rcu_sched
 #define synchronize_rcu_tasks synchronize_sched
@@ -195,7 +195,7 @@ static inline void exit_tasks_rcu_finish(void) { }
  */
 #define cond_resched_tasks_rcu_qs() \
 do { \
-	rcu_note_voluntary_context_switch_lite(current); \
+	rcu_tasks_qs(current); \
 	cond_resched(); \
 } while (0)
 
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index ce9beec35e34..79409dbb5478 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -93,7 +93,7 @@ static inline void kfree_call_rcu(struct rcu_head *head,
 #define rcu_note_context_switch(preempt) \
 	do { \
 		rcu_sched_qs(); \
-		rcu_note_voluntary_context_switch_lite(current); \
+		rcu_tasks_qs(current); \
 	} while (0)
 
 static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3826ce90fd6e..4e96761ce367 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -456,7 +456,7 @@ void rcu_note_context_switch(bool preempt)
 		rcu_momentary_dyntick_idle();
 	this_cpu_inc(rcu_dynticks.rcu_qs_ctr);
 	if (!preempt)
-		rcu_note_voluntary_context_switch_lite(current);
+		rcu_tasks_qs(current);
 out:
 	trace_rcu_utilization(TPS("End context switch"));
 	barrier(); /* Avoid RCU read-side critical sections leaking up. */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 4c230a60ece4..5783bdf86e5a 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -507,14 +507,15 @@ early_initcall(check_cpu_stall_init);
 #ifdef CONFIG_TASKS_RCU
 
 /*
- * Simple variant of RCU whose quiescent states are voluntary context switch,
- * user-space execution, and idle.  As such, grace periods can take one good
- * long time.  There are no read-side primitives similar to rcu_read_lock()
- * and rcu_read_unlock() because this implementation is intended to get
- * the system into a safe state for some of the manipulations involved in
- * tracing and the like.  Finally, this implementation does not support
- * high call_rcu_tasks() rates from multiple CPUs.  If this is required,
- * per-CPU callback lists will be needed.
+ * Simple variant of RCU whose quiescent states are voluntary context
+ * switch, cond_resched_rcu_qs(), user-space execution, and idle.
+ * As such, grace periods can take one good long time.  There are no
+ * read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
+ * because this implementation is intended to get the system into a safe
+ * state for some of the manipulations involved in tracing and the like.
+ * Finally, this implementation does not support high call_rcu_tasks()
+ * rates from multiple CPUs.  If this is required, per-CPU callback lists
+ * will be needed.
  */
 
 /* Global list of callbacks and associated lock. */
@@ -542,11 +543,11 @@ static struct task_struct *rcu_tasks_kthread_ptr;
  * period elapses, in other words after all currently executing RCU
  * read-side critical sections have completed. call_rcu_tasks() assumes
  * that the read-side critical sections end at a voluntary context
- * switch (not a preemption!), entry into idle, or transition to usermode
- * execution.  As such, there are no read-side primitives analogous to
- * rcu_read_lock() and rcu_read_unlock() because this primitive is intended
- * to determine that all tasks have passed through a safe state, not so
- * much for data-strcuture synchronization.
+ * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
+ * or transition to usermode execution.  As such, there are no read-side
+ * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
+ * this primitive is intended to determine that all tasks have passed
+ * through a safe state, not so much for data-strcuture synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
