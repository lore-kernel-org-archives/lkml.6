Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbeDYET4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:19:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750962AbeDYETt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:19:49 -0400
Date: Tue, 24 Apr 2018 21:20:56 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, fweisbec <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>,
        kernel-team <kernel-team@lge.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180423172244.694dbc9d@gandalf.local.home>
 <20180424155655.GA820@linux.vnet.ibm.com>
 <CAJWu+or_-emRLeBbfOtQYyn9W8v-KHH8XecV_k-p5FX_3BLHAQ@mail.gmail.com>
 <20180424172658.GT26088@linux.vnet.ibm.com>
 <20180424182302.GA404@linux.vnet.ibm.com>
 <20180424182623.GA1357@linux.vnet.ibm.com>
 <CAJWu+opC9pLxoiXq7QDRUDe6ouC4ij398bHCfnUwp+h7Y_ssDg@mail.gmail.com>
 <849066633.939.1524612064698.JavaMail.zimbra@efficios.com>
 <68e4c123-a223-5e26-e57a-da2515041bf3@google.com>
 <20180425001049.GX26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425001049.GX26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042504-0040-0000-0000-00000421818B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008916; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022883; UDB=6.00522129; IPR=6.00802117;
 MB=3.00020761; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-25 04:19:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042504-0041-0000-0000-000008278CF7
Message-Id: <20180425042056.GA21412@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804250036
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 05:10:49PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 24, 2018 at 04:46:54PM -0700, Joel Fernandes wrote:
> > 
> > 
> > On 04/24/2018 04:21 PM, Mathieu Desnoyers wrote:
> > >----- On Apr 24, 2018, at 2:59 PM, Joel Fernandes joelaf@google.com wrote:
> > >>On Tue, Apr 24, 2018 at 11:26 AM, Paul E. McKenney
> > >><paulmck@linux.vnet.ibm.com> wrote:
> > >>>On Tue, Apr 24, 2018 at 11:23:02AM -0700, Paul E. McKenney wrote:
> > >>>>On Tue, Apr 24, 2018 at 10:26:58AM -0700, Paul E. McKenney wrote:
> > >>>>>On Tue, Apr 24, 2018 at 09:01:34AM -0700, Joel Fernandes wrote:
> > >>>>>>On Tue, Apr 24, 2018 at 8:56 AM, Paul E. McKenney
> > >>>>>><paulmck@linux.vnet.ibm.com> wrote:
> > >>>>>>>On Mon, Apr 23, 2018 at 05:22:44PM -0400, Steven Rostedt wrote:
> > >>>>>>>>On Mon, 23 Apr 2018 13:12:21 -0400 (EDT)
> > >>>>>>>>Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>>I'm inclined to explicitly declare the tracepoints with their given
> > >>>>>>>>>synchronization method. Tracepoint probe callback functions for currently
> > >>>>>>>>>existing tracepoints expect to have preemption disabled when invoked.
> > >>>>>>>>>This assumption will not be true anymore for srcu-tracepoints.
> > >>>>>>>>
> > >>>>>>>>Actually, why not have a flag attached to the tracepoint_func that
> > >>>>>>>>states if it expects preemption to be enabled or not? If a
> > >>>>>>>>trace_##event##_srcu() is called, then simply disable preemption before
> > >>>>>>>>calling the callbacks for it. That way if a callback is fine for use
> > >>>>>>>>with srcu, then it would require calling
> > >>>>>>>>
> > >>>>>>>>       register_trace_##event##_may_sleep();
> > >>>>>>>>
> > >>>>>>>>Then if someone uses this on a tracepoint where preemption is disabled,
> > >>>>>>>>we simply do not call it.
> > >>>>>>>
> > >>>>>>>One more stupid question...  If we are having to trace so much stuff
> > >>>>>>>in the idle loop, are we perhaps grossly overstating the extent of that
> > >>>>>>>"idle" loop?  For being called "idle", this code seems quite busy!
> > >>>>>>
> > >>>>>>;-)
> > >>>>>>The performance hit I am observing is when running a heavy workload,
> > >>>>>>like hackbench or something like that. That's what I am trying to
> > >>>>>>correct.
> > >>>>>>By the way is there any limitation on using SRCU too early during
> > >>>>>>boot? I backported Mathieu's srcu tracepoint patches but the kernel
> > >>>>>>hangs pretty early in the boot. I register lockdep probes in
> > >>>>>>start_kernel. I am hoping that's not why.
> > >>>>>>
> > >>>>>>I could also have just screwed up the backporting... may be for my
> > >>>>>>testing, I will just replace the rcu API with the srcu instead of all
> > >>>>>>of Mathieu's new TRACE_EVENT macros for SRCU, since all I am trying to
> > >>>>>>do right now is measure the performance of my patches with SRCU.
> > >>>>>
> > >>>>>Gah, yes, there is an entry on my capacious todo list on making SRCU
> > >>>>>grace periods work during early boot and mid-boot.  Let me see what
> > >>>>>I can do...
> > >>>>
> > >>>>OK, just need to verify that you are OK with call_srcu()'s callbacks
> > >>>>not being invoked until sometime during core_initcall() time.  (If you
> > >>>>really do need them to be invoked before that, in theory it is possible,
> > >>>>but in practice it is weird, even for RCU.)
> > >>>
> > >>>Oh, and that early at boot, you will need to use DEFINE_SRCU() or
> > >>>DEFINE_STATIC_SRCU() rather than dynamic allocation and initialization.
> > >>>
> > >>>                                                         Thanx, Paul
> > >>>
> > >>
> > >>Oh ok.
> > >>
> > >>About call_rcu, calling it later may be an issue since we register the
> > >>probes in start_kernel, for the first probe call_rcu will be sched,
> > >>but for the second one I think it'll try to call_rcu to get rid of the
> > >>first one.
> > >>
> > >>This is the relevant code that gets called when probes are added:
> > >>
> > >>static inline void release_probes(struct tracepoint_func *old)
> > >>{
> > >>        if (old) {
> > >>                struct tp_probes *tp_probes = container_of(old,
> > >>                        struct tp_probes, probes[0]);
> > >>                call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
> > >>        }
> > >>}
> > >>
> > >>Maybe we can somehow defer the call_srcu until later? Would that be possible?
> > >>
> > >>also Mathieu, you didn't modify the call_rcu_sched in your prototype
> > >>to be changed to use call_srcu, should you be doing that?
> > >
> > >You're right, I think I should have introduced a call_srcu in there.
> > >It's missing in my prototype.
> > >
> > >However, in the prototype I did, we need to wait for *both* sched-rcu
> > >and SRCU grace periods, because we don't track which site is using which
> > >rcu flavor.
> > >
> > >So you could achieve this relatively easily by means of two chained
> > >RCU callbacks, e.g.:
> > >
> > >release_probes() calls call_rcu_sched(... , rcu_free_old_probes)
> > >
> > >and then in rcu_free_old_probes() do:
> > >
> > >call_srcu(... , srcu_free_old_probes)
> > >
> > >and perform kfree(container_of(head, struct tp_probes, rcu));
> > >within srcu_free_old_probes.
> > >
> > >It is somewhat a hack, but should work.
> > 
> > Sounds good, thanks.
> > 
> > Also I found the reason for my boot issue. It was because the
> > init_srcu_struct in the prototype was being done in an initcall.
> > Instead if I do it in start_kernel before the tracepoint is used, it
> > fixes it (although I don't know if this is dangerous to do like this
> > but I can get it to boot atleast.. Let me know if this isn't the
> > right way to do it, or if something else could go wrong)
> > 
> > diff --git a/init/main.c b/init/main.c
> > index 34823072ef9e..ecc88319c6da 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -631,6 +631,7 @@ asmlinkage __visible void __init start_kernel(void)
> >         WARN(!irqs_disabled(), "Interrupts were enabled early\n");
> >         early_boot_irqs_disabled = false;
> > 
> > +       init_srcu_struct(&tracepoint_srcu);
> >         lockdep_init_early();
> > 
> >         local_irq_enable();
> > --
> > 
> > I benchmarked it and the performance also looks quite good compared
> > to the rcu tracepoint version.
> > 
> > If you, Paul and other think doing the init_srcu_struct like this
> > should be Ok, then I can try to work more on your srcu prototype and
> > roll into my series and post them in the next RFC series (or let me
> > know if you wanted to work your srcu stuff in a separate series..).
> 
> That is definitely not what I was expecting, but let's see if it works
> anyway...  ;-)
> 
> But first, I was instead expecting something like this:
> 
> DEFINE_SRCU(tracepoint_srcu);
> 
> With this approach, some of the initialization happens at compile time
> and the rest happens at the first call_srcu().
> 
> This will work -only- if the first call_srcu() doesn't happen until after
> workqueue_init_early() has been invoked.  Which I believe must have been
> the case in your testing, because otherwise it looks like __call_srcu()
> would have complained bitterly.
> 
> On the other hand, if you need to invoke call_srcu() before the call
> to workqueue_init_early(), then you need the patch that I am beating
> into shape.  Plus you would need to use DEFINE_SRCU() and to avoid
> invoking init_srcu_struct().

And here is the patch.  I do not intend to send it upstream unless it
actually proves necessary, and it appears that current SRCU does what
you need.

You would only need this patch if you wanted to invoke call_srcu()
before workqueue_init_early() was called, which does not seem likely.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28ecdb6d..c24eb9c1656c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4047,6 +4047,9 @@
 			expediting.  Set to zero to disable automatic
 			expediting.
 
+	srcutree.srcu_self_test [KNL]
+			Run the SRCU early boot self tests.
+
 	stack_guard_gap=	[MM]
 			override the default stack gap protection. The value
 			is in page units and it defines how many pages prior
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 4eda108abee0..b3b94c082da0 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -94,6 +94,7 @@ struct srcu_struct {
 						/*  callback for the barrier */
 						/*  operation. */
 	struct delayed_work work;
+	struct list_head srcu_boot;		/* Boottime call_srcu()? */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
@@ -109,6 +110,7 @@ struct srcu_struct {
 		.sda = &name##_srcu_data,				\
 		.lock = __SPIN_LOCK_UNLOCKED(name.lock),		\
 		.srcu_gp_seq_needed = 0 - 1,				\
+		.srcu_boot = LIST_HEAD_INIT(name.srcu_boot),		\
 		__SRCU_DEP_MAP_INIT(name)				\
 	}
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b4123d7a2cec..ec612895d0ec 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -80,6 +80,9 @@ do {									\
 #define spin_unlock_irqrestore_rcu_node(p, flags)			\
 	spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)	\
 
+LIST_HEAD(srcu_boot_list);  /* List and lock for early boot call_srcu(). */
+DEFINE_SPINLOCK(srcu_boot_lock);
+
 /*
  * Initialize SRCU combining tree.  Note that statically allocated
  * srcu_struct structures might already have srcu_read_lock() and
@@ -180,8 +183,10 @@ static int init_srcu_struct_fields(struct srcu_struct *sp, bool is_static)
 	mutex_init(&sp->srcu_barrier_mutex);
 	atomic_set(&sp->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&sp->work, process_srcu);
-	if (!is_static)
+	if (!is_static) {
 		sp->sda = alloc_percpu(struct srcu_data);
+		sp->srcu_boot.next = NULL; /* No early boot call_srcu()! */
+	}
 	init_srcu_struct_nodes(sp, is_static);
 	sp->srcu_gp_seq_needed_exp = 0;
 	sp->srcu_last_gp_end = ktime_get_mono_fast_ns();
@@ -691,6 +696,21 @@ static void srcu_funnel_gp_start(struct srcu_struct *sp, struct srcu_data *sdp,
 		sp->srcu_gp_seq_needed_exp = s;
 
 	/* If grace period not already done and none in progress, start it. */
+	if (list_empty(&sp->srcu_boot) &&
+	    rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
+		spin_unlock_irqrestore_rcu_node(sp, flags);
+		spin_lock_irqsave(&srcu_boot_lock, flags);
+		if (list_empty(&sp->srcu_boot) &&
+		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
+			/* No early boot call_srcu() on dynamic srcu_struct. */
+			WARN_ON(sp->srcu_boot.next == NULL);
+			list_add(&sp->srcu_boot, &srcu_boot_list);
+			spin_unlock_irqrestore(&srcu_boot_lock, flags);
+			return;
+		}
+		spin_unlock_irqrestore(&srcu_boot_lock, flags);
+		spin_lock_irqsave_rcu_node(sp, flags);
+	}
 	if (!rcu_seq_done(&sp->srcu_gp_seq, s) &&
 	    rcu_seq_state(sp->srcu_gp_seq) == SRCU_STATE_IDLE) {
 		WARN_ON_ONCE(ULONG_CMP_GE(sp->srcu_gp_seq, sp->srcu_gp_seq_needed));
@@ -823,17 +843,17 @@ static void srcu_leak_callback(struct rcu_head *rhp)
  * more than one CPU, this means that when "func()" is invoked, each CPU
  * is guaranteed to have executed a full memory barrier since the end of
  * its last corresponding SRCU read-side critical section whose beginning
- * preceded the call to call_rcu().  It also means that each CPU executing
+ * preceded the call to call_srcu().  It also means that each CPU executing
  * an SRCU read-side critical section that continues beyond the start of
- * "func()" must have executed a memory barrier after the call_rcu()
+ * "func()" must have executed a memory barrier after the call_srcu()
  * but before the beginning of that SRCU read-side critical section.
  * Note that these guarantees include CPUs that are offline, idle, or
  * executing in user mode, as well as CPUs that are executing in the kernel.
  *
- * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
+ * Furthermore, if CPU A invoked call_srcu() and CPU B invoked the
  * resulting SRCU callback function "func()", then both CPU A and CPU
  * B are guaranteed to execute a full memory barrier during the time
- * interval between the call to call_rcu() and the invocation of "func()".
+ * interval between the call to call_srcu() and the invocation of "func()".
  * This guarantee applies even if CPU A and CPU B are the same CPU (but
  * again only if the system has more than one CPU).
  *
@@ -1301,3 +1321,68 @@ static int __init srcu_bootup_announce(void)
 	return 0;
 }
 early_initcall(srcu_bootup_announce);
+
+/*
+ * Support for early boot call_srcu().  The trick is to create a list
+ * of all srcu_struct structures that were subjected to an early boot
+ * call_srcu(), and later in boot post a callback to each structure in
+ * the list to kick off the needed grace periods.
+ *
+ * Note that synchronize_srcu() and synchronize_srcu_expedited()
+ * remain unsupported during the mid-boot dead zone, which starts after
+ * the scheduler is running multiple processes and ends during the
+ * core_initcall() timeframe.
+ */
+
+/*
+ * Post an SRCU callback to each srcu_struct structure that was
+ * subjected to call_srcu() during early boot.
+ */
+void __init srcu_boot_cleanup(void)
+{
+	unsigned long flags;
+	struct srcu_struct *sp;
+
+	spin_lock_irqsave(&srcu_boot_lock, flags);
+	if (list_empty(&srcu_boot_list)) {
+		spin_unlock_irqrestore(&srcu_boot_lock, flags);
+		return;  /* No early boot call_srcu(), nothing to do. */
+	}
+	list_for_each_entry(sp, &srcu_boot_list, srcu_boot)
+		srcu_reschedule(sp, 0);
+	spin_unlock_irqrestore(&srcu_boot_lock, flags);
+}
+
+#ifdef CONFIG_PROVE_RCU
+
+static bool srcu_self_test;
+module_param(srcu_self_test, bool, 0444);
+static bool srcu_self_test_happened;
+DEFINE_SRCU(srcu_self_test_struct);
+
+static void srcu_test_callback(struct rcu_head *rhp)
+{
+	srcu_self_test_happened = true;
+	pr_info("SRCU test callback executed\n");
+}
+
+void __init srcu_early_boot_test(void)
+{
+	static struct rcu_head rh;
+
+	if (!srcu_self_test)
+		return;
+	call_srcu(&srcu_self_test_struct, &rh, srcu_test_callback);
+	pr_info("SRCU test callback registered\n");
+}
+
+static int srcu_verify_early_boot_test(void)
+{
+	if (!srcu_self_test)
+		return 0;
+	WARN_ON(!srcu_self_test_happened);
+	return 0;
+}
+late_initcall(srcu_verify_early_boot_test);
+
+#endif /* #ifdef CONFIG_PROVE_RCU */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a38803a0342f..129c02b6d6b0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4129,6 +4129,10 @@ static void __init rcu_dump_rcu_node_tree(struct rcu_state *rsp)
 	pr_cont("\n");
 }
 
+void __weak __init srcu_early_boot_test(void)
+{
+}
+
 struct workqueue_struct *rcu_gp_wq;
 struct workqueue_struct *rcu_par_gp_wq;
 
@@ -4137,6 +4141,7 @@ void __init rcu_init(void)
 	int cpu;
 
 	rcu_early_boot_tests();
+	srcu_early_boot_test();
 
 	rcu_bootup_announce();
 	rcu_init_geometry();
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 4c230a60ece4..810ec36e1449 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -212,6 +212,10 @@ void rcu_test_sync_prims(void)
 
 #if !defined(CONFIG_TINY_RCU) || defined(CONFIG_SRCU)
 
+void __weak __init srcu_boot_cleanup(void)
+{
+}
+
 /*
  * Switch to run-time mode once RCU has fully initialized.
  */
@@ -220,6 +224,7 @@ static int __init rcu_set_runtime_mode(void)
 	rcu_test_sync_prims();
 	rcu_scheduler_active = RCU_SCHEDULER_RUNNING;
 	rcu_test_sync_prims();
+	srcu_boot_cleanup();
 	return 0;
 }
 core_initcall(rcu_set_runtime_mode);
