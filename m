Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966520AbeEJPqv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:46:51 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:38861 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966508AbeEJPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:47 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:69:327:355:379:541:800:960:966:967:973:988:989:1260:1263:1345:1359:1437:1605:1730:1747:1777:1792:2194:2196:2199:2200:2393:2525:2559:2563:2682:2685:2859:2895:2898:2904:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3165:3865:3866:3867:3868:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4385:4398:4605:5007:6117:6119:6261:7903:8599:8660:8957:9025:9388:10004:10049:10848:10954:11026:11473:11658:11914:12043:12048:12198:12291:12294:12296:12438:12555:12683:12776:12895:12986:13148:13230:14110:14394:14651:21080:21324:21451:21627:30029:30045:30054:30056:30070:30075,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: card46_1dc16bb332c5c
X-Filterd-Recvd-Size: 20077
From: Joe Perches <joe@perches.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging output
Date: Thu, 10 May 2018 08:45:44 -0700
Message-Id: <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a consistent logging prefix for all rcu related output.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/rcu/rcu_segcblist.c |  2 ++
 kernel/rcu/rcuperf.c       | 10 ++++---
 kernel/rcu/rcutorture.c    | 46 +++++++++++++++----------------
 kernel/rcu/srcutiny.c      |  2 ++
 kernel/rcu/srcutree.c      |  5 +++-
 kernel/rcu/tiny.c          |  3 +++
 kernel/rcu/tree.c          |  8 +++---
 kernel/rcu/tree_plugin.h   | 67 +++++++++++++++++++++++++++-------------------
 kernel/rcu/update.c        | 19 ++++++++-----
 9 files changed, 96 insertions(+), 66 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 5aff271adf1e..b5f0e7234c4b 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -20,6 +20,8 @@
  * Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
  */
 
+#define pr_fmt(fmt) "rcu: " fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 076a50fb22ad..ebdd77b45470 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -19,6 +19,9 @@
  *
  * Authors: Paul E. McKenney <paulmck@us.ibm.com>
  */
+
+#define pr_fmt(fmt) "rcu: " fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -663,12 +666,11 @@ rcu_perf_init(void)
 			break;
 	}
 	if (i == ARRAY_SIZE(perf_ops)) {
-		pr_alert("rcu-perf: invalid perf type: \"%s\"\n",
-			 perf_type);
+		pr_alert("rcu-perf: invalid perf type: \"%s\"\n", perf_type);
 		pr_alert("rcu-perf types:");
 		for (i = 0; i < ARRAY_SIZE(perf_ops); i++)
-			pr_alert(" %s", perf_ops[i]->name);
-		pr_alert("\n");
+			pr_cont(" %s", perf_ops[i]->name);
+		pr_cont("\n");
 		firsterr = -EINVAL;
 		goto unwind;
 	}
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 648e1c25707d..45d98ff0d5b8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -22,6 +22,7 @@
  *
  * See also:  Documentation/RCU/torture.txt
  */
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -908,7 +909,7 @@ rcu_torture_writer(void *arg)
 	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
 	if (!can_expedite)
 		pr_alert("%s" TORTURE_FLAG
-			 " GP expediting controlled from boot/sysfs for %s.\n",
+			 " GP expediting controlled from boot/sysfs for %s\n",
 			 torture_type, cur_ops->name);
 
 	/* Initialize synctype[] array.  If none set, take default. */
@@ -916,27 +917,27 @@ rcu_torture_writer(void *arg)
 		gp_cond1 = gp_exp1 = gp_normal1 = gp_sync1 = true;
 	if (gp_cond1 && cur_ops->get_state && cur_ops->cond_sync) {
 		synctype[nsynctypes++] = RTWS_COND_GET;
-		pr_info("%s: Testing conditional GPs.\n", __func__);
+		pr_info("%s: Testing conditional GPs\n", __func__);
 	} else if (gp_cond && (!cur_ops->get_state || !cur_ops->cond_sync)) {
-		pr_alert("%s: gp_cond without primitives.\n", __func__);
+		pr_alert("%s: gp_cond without primitives\n", __func__);
 	}
 	if (gp_exp1 && cur_ops->exp_sync) {
 		synctype[nsynctypes++] = RTWS_EXP_SYNC;
-		pr_info("%s: Testing expedited GPs.\n", __func__);
+		pr_info("%s: Testing expedited GPs\n", __func__);
 	} else if (gp_exp && !cur_ops->exp_sync) {
-		pr_alert("%s: gp_exp without primitives.\n", __func__);
+		pr_alert("%s: gp_exp without primitives\n", __func__);
 	}
 	if (gp_normal1 && cur_ops->deferred_free) {
 		synctype[nsynctypes++] = RTWS_DEF_FREE;
-		pr_info("%s: Testing asynchronous GPs.\n", __func__);
+		pr_info("%s: Testing asynchronous GPs\n", __func__);
 	} else if (gp_normal && !cur_ops->deferred_free) {
-		pr_alert("%s: gp_normal without primitives.\n", __func__);
+		pr_alert("%s: gp_normal without primitives\n", __func__);
 	}
 	if (gp_sync1 && cur_ops->sync) {
 		synctype[nsynctypes++] = RTWS_SYNC;
-		pr_info("%s: Testing normal GPs.\n", __func__);
+		pr_info("%s: Testing normal GPs\n", __func__);
 	} else if (gp_sync && !cur_ops->sync) {
-		pr_alert("%s: gp_sync without primitives.\n", __func__);
+		pr_alert("%s: gp_sync without primitives\n", __func__);
 	}
 	if (WARN_ONCE(nsynctypes == 0,
 		      "rcu_torture_writer: No update-side primitives.\n")) {
@@ -1027,7 +1028,7 @@ rcu_torture_writer(void *arg)
 	WARN_ON_ONCE(can_expedite && rcu_gp_is_expedited());
 	if (!can_expedite)
 		pr_alert("%s" TORTURE_FLAG
-			 " Dynamic grace-period expediting was disabled.\n",
+			 " Dynamic grace-period expediting was disabled\n",
 			 torture_type);
 	rcu_torture_writer_state = RTWS_STOPPING;
 	torture_kthread_stopping("rcu_torture_writer");
@@ -1436,7 +1437,7 @@ static int rcu_torture_stall(void *args)
 			local_irq_disable();
 		else
 			preempt_disable();
-		pr_alert("rcu_torture_stall start on CPU %d.\n",
+		pr_alert("rcu_torture_stall start on CPU %d\n",
 			 smp_processor_id());
 		while (ULONG_CMP_LT(get_seconds(), stop_at))
 			continue;  /* Induce RCU CPU stall warning. */
@@ -1445,7 +1446,7 @@ static int rcu_torture_stall(void *args)
 		else
 			preempt_enable();
 		rcu_read_unlock();
-		pr_alert("rcu_torture_stall end.\n");
+		pr_alert("rcu_torture_stall end\n");
 	}
 	torture_shutdown_absorb("rcu_torture_stall");
 	while (!kthread_should_stop())
@@ -1547,10 +1548,10 @@ static int rcu_torture_barrier_init(void)
 		return 0;
 	if (cur_ops->call == NULL || cur_ops->cb_barrier == NULL) {
 		pr_alert("%s" TORTURE_FLAG
-			 " Call or barrier ops missing for %s,\n",
+			 " Call or barrier ops missing for %s\n",
 			 torture_type, cur_ops->name);
 		pr_alert("%s" TORTURE_FLAG
-			 " RCU barrier testing omitted from run.\n",
+			 " RCU barrier testing omitted from run\n",
 			 torture_type);
 		return 0;
 	}
@@ -1679,7 +1680,7 @@ static void rcu_torture_err_cb(struct rcu_head *rhp)
 	 * next grace period.  Unlikely, but can happen.  If it
 	 * does happen, the debug-objects subsystem won't have splatted.
 	 */
-	pr_alert("%s: duplicated callback was invoked.\n", KBUILD_MODNAME);
+	pr_alert("duplicated callback was invoked\n");
 }
 #endif /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
@@ -1696,7 +1697,7 @@ static void rcu_test_debug_objects(void)
 
 	init_rcu_head_on_stack(&rh1);
 	init_rcu_head_on_stack(&rh2);
-	pr_alert("%s: WARN: Duplicate call_rcu() test starting.\n", KBUILD_MODNAME);
+	pr_alert("WARN: Duplicate call_rcu() test starting\n");
 
 	/* Try to queue the rh2 pair of callbacks for the same grace period. */
 	preempt_disable(); /* Prevent preemption from interrupting test. */
@@ -1711,11 +1712,11 @@ static void rcu_test_debug_objects(void)
 
 	/* Wait for them all to get done so we can safely return. */
 	rcu_barrier();
-	pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
+	pr_alert("WARN: Duplicate call_rcu() test complete\n");
 	destroy_rcu_head_on_stack(&rh1);
 	destroy_rcu_head_on_stack(&rh2);
 #else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
-	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
+	pr_alert("!CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n");
 #endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 }
 
@@ -1740,17 +1741,16 @@ rcu_torture_init(void)
 			break;
 	}
 	if (i == ARRAY_SIZE(torture_ops)) {
-		pr_alert("rcu-torture: invalid torture type: \"%s\"\n",
-			 torture_type);
+		pr_alert("invalid torture type: \"%s\"\n", torture_type);
 		pr_alert("rcu-torture types:");
 		for (i = 0; i < ARRAY_SIZE(torture_ops); i++)
-			pr_alert(" %s", torture_ops[i]->name);
-		pr_alert("\n");
+			pr_cont(" %s", torture_ops[i]->name);
+		pr_cont("\n");
 		firsterr = -EINVAL;
 		goto unwind;
 	}
 	if (cur_ops->fqs == NULL && fqs_duration != 0) {
-		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
+		pr_alert("->fqs NULL and non-zero fqs_duration, fqs disabled\n");
 		fqs_duration = 0;
 	}
 	if (cur_ops->init)
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 622792abe41a..9392404cd0fb 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -21,6 +21,8 @@
  * Author: Paul McKenney <paulmck@us.ibm.com>
  */
 
+#define pr_fmt(fmt) "rcu: " fmt
+
 #include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ff894ae6d386..031d2713701f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -26,6 +26,8 @@
  *
  */
 
+#define pr_fmt(fmt) "rcu: " fmt
+
 #include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/percpu.h>
@@ -390,7 +392,8 @@ void _cleanup_srcu_struct(struct srcu_struct *sp, bool quiesced)
 		}
 	if (WARN_ON(rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
 	    WARN_ON(srcu_readers_active(sp))) {
-		pr_info("%s: Active srcu_struct %p state: %d\n", __func__, sp, rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)));
+		pr_info("%s: Active srcu_struct %p state: %d\n",
+			__func__, sp, rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)));
 		return; /* Caller forgot to stop doing call_srcu()? */
 	}
 	free_percpu(sp->sda);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index a64eee0db39e..52ab205db6e6 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -22,6 +22,9 @@
  * For detailed explanation of Read-Copy Update mechanism see -
  *		Documentation/RCU
  */
+
+#define pr_fmt(fmt) "rcu: " fmt
+
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index effcb898acca..fac633b3aa5e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -27,6 +27,9 @@
  * For detailed explanation of Read-Copy Update mechanism see -
  *	Documentation/RCU
  */
+
+#define pr_fmt(fmt) "rcu: " fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -1360,8 +1363,7 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 	 * See Documentation/RCU/stallwarn.txt for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
-	pr_err("INFO: %s detected stalls on CPUs/tasks:",
-	       rsp->name);
+	pr_err("INFO: %s detected stalls on CPUs/tasks:", rsp->name);
 	print_cpu_stall_info_begin();
 	rcu_for_each_leaf_node(rsp, rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -3984,7 +3986,7 @@ static void __init rcu_init_geometry(void)
 	if (rcu_fanout_leaf == RCU_FANOUT_LEAF &&
 	    nr_cpu_ids == NR_CPUS)
 		return;
-	pr_info("RCU: Adjusting geometry for rcu_fanout_leaf=%d, nr_cpu_ids=%u\n",
+	pr_info("Adjusting geometry for rcu_fanout_leaf=%d, nr_cpu_ids=%u\n",
 		rcu_fanout_leaf, nr_cpu_ids);
 
 	/*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index f2dae728c446..7aafff8590d7 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -71,51 +71,62 @@ static bool __read_mostly rcu_nocb_poll;    /* Offload kthread are to poll. */
 static void __init rcu_bootup_announce_oddness(void)
 {
 	if (IS_ENABLED(CONFIG_RCU_TRACE))
-		pr_info("\tRCU event tracing is enabled.\n");
+		pr_info("\tRCU event tracing is enabled\n");
 	if ((IS_ENABLED(CONFIG_64BIT) && RCU_FANOUT != 64) ||
 	    (!IS_ENABLED(CONFIG_64BIT) && RCU_FANOUT != 32))
 		pr_info("\tCONFIG_RCU_FANOUT set to non-default value of %d\n",
-		       RCU_FANOUT);
+			RCU_FANOUT);
 	if (rcu_fanout_exact)
-		pr_info("\tHierarchical RCU autobalancing is disabled.\n");
+		pr_info("\tHierarchical RCU autobalancing is disabled\n");
 	if (IS_ENABLED(CONFIG_RCU_FAST_NO_HZ))
-		pr_info("\tRCU dyntick-idle grace-period acceleration is enabled.\n");
+		pr_info("\tRCU dyntick-idle grace-period acceleration is enabled\n");
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
-		pr_info("\tRCU lockdep checking is enabled.\n");
+		pr_info("\tRCU lockdep checking is enabled\n");
 	if (RCU_NUM_LVLS >= 4)
-		pr_info("\tFour(or more)-level hierarchy is enabled.\n");
+		pr_info("\tFour(or more)-level hierarchy is enabled\n");
 	if (RCU_FANOUT_LEAF != 16)
-		pr_info("\tBuild-time adjustment of leaf fanout to %d.\n",
+		pr_info("\tBuild-time adjustment of leaf fanout to %d\n",
 			RCU_FANOUT_LEAF);
 	if (rcu_fanout_leaf != RCU_FANOUT_LEAF)
-		pr_info("\tBoot-time adjustment of leaf fanout to %d.\n", rcu_fanout_leaf);
+		pr_info("\tBoot-time adjustment of leaf fanout to %d\n",
+			rcu_fanout_leaf);
 	if (nr_cpu_ids != NR_CPUS)
-		pr_info("\tRCU restricting CPUs from NR_CPUS=%d to nr_cpu_ids=%u.\n", NR_CPUS, nr_cpu_ids);
+		pr_info("\tRCU restricting CPUs from NR_CPUS=%d to nr_cpu_ids=%u\n",
+			NR_CPUS, nr_cpu_ids);
 #ifdef CONFIG_RCU_BOOST
-	pr_info("\tRCU priority boosting: priority %d delay %d ms.\n", kthread_prio, CONFIG_RCU_BOOST_DELAY);
+	pr_info("\tRCU priority boosting: priority %d delay %d ms\n",
+		kthread_prio, CONFIG_RCU_BOOST_DELAY);
 #endif
 	if (blimit != DEFAULT_RCU_BLIMIT)
-		pr_info("\tBoot-time adjustment of callback invocation limit to %ld.\n", blimit);
+		pr_info("\tBoot-time adjustment of callback invocation limit to %ld\n",
+			blimit);
 	if (qhimark != DEFAULT_RCU_QHIMARK)
-		pr_info("\tBoot-time adjustment of callback high-water mark to %ld.\n", qhimark);
+		pr_info("\tBoot-time adjustment of callback high-water mark to %ld\n",
+			qhimark);
 	if (qlowmark != DEFAULT_RCU_QLOMARK)
-		pr_info("\tBoot-time adjustment of callback low-water mark to %ld.\n", qlowmark);
+		pr_info("\tBoot-time adjustment of callback low-water mark to %ld\n",
+			qlowmark);
 	if (jiffies_till_first_fqs != ULONG_MAX)
-		pr_info("\tBoot-time adjustment of first FQS scan delay to %ld jiffies.\n", jiffies_till_first_fqs);
+		pr_info("\tBoot-time adjustment of first FQS scan delay to %ld jiffies\n",
+			jiffies_till_first_fqs);
 	if (jiffies_till_next_fqs != ULONG_MAX)
-		pr_info("\tBoot-time adjustment of subsequent FQS scan delay to %ld jiffies.\n", jiffies_till_next_fqs);
+		pr_info("\tBoot-time adjustment of subsequent FQS scan delay to %ld jiffies\n",
+			jiffies_till_next_fqs);
 	if (rcu_kick_kthreads)
-		pr_info("\tKick kthreads if too-long grace period.\n");
+		pr_info("\tKick kthreads if too-long grace period\n");
 	if (IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD))
-		pr_info("\tRCU callback double-/use-after-free debug enabled.\n");
+		pr_info("\tRCU callback double-/use-after-free debug enabled\n");
 	if (gp_preinit_delay)
-		pr_info("\tRCU debug GP pre-init slowdown %d jiffies.\n", gp_preinit_delay);
+		pr_info("\tRCU debug GP pre-init slowdown %d jiffies\n",
+			gp_preinit_delay);
 	if (gp_init_delay)
-		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
+		pr_info("\tRCU debug GP init slowdown %d jiffies\n",
+			gp_init_delay);
 	if (gp_cleanup_delay)
-		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_cleanup_delay);
+		pr_info("\tRCU debug GP init slowdown %d jiffies\n",
+			gp_cleanup_delay);
 	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
-		pr_info("\tRCU debug extended QS entry/exit.\n");
+		pr_info("\tRCU debug extended QS entry/exit\n");
 	rcupdate_announce_bootup_oddness();
 }
 
@@ -133,7 +144,7 @@ static void rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
  */
 static void __init rcu_bootup_announce(void)
 {
-	pr_info("Preemptible hierarchical RCU implementation.\n");
+	pr_info("Preemptible hierarchical RCU implementation\n");
 	rcu_bootup_announce_oddness();
 }
 
@@ -885,7 +896,7 @@ static struct rcu_state *const rcu_state_p = &rcu_sched_state;
  */
 static void __init rcu_bootup_announce(void)
 {
-	pr_info("Hierarchical RCU implementation.\n");
+	pr_info("Hierarchical RCU implementation\n");
 	rcu_bootup_announce_oddness();
 }
 
@@ -2374,7 +2385,7 @@ void __init rcu_init_nohz(void)
 
 	if (!cpumask_available(rcu_nocb_mask) && need_rcu_nocb_mask) {
 		if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
-			pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
+			pr_info("rcu_nocb_mask allocation failed, callback offloading disabled\n");
 			return;
 		}
 	}
@@ -2387,17 +2398,17 @@ void __init rcu_init_nohz(void)
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
-		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
+		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
 			    rcu_nocb_mask);
 	}
 	if (cpumask_empty(rcu_nocb_mask))
-		pr_info("\tOffload RCU callbacks from CPUs: (none).\n");
+		pr_info("\tOffload RCU callbacks from CPUs: (none)\n");
 	else
-		pr_info("\tOffload RCU callbacks from CPUs: %*pbl.\n",
+		pr_info("\tOffload RCU callbacks from CPUs: %*pbl\n",
 			cpumask_pr_args(rcu_nocb_mask));
 	if (rcu_nocb_poll)
-		pr_info("\tPoll for callbacks from no-CBs CPUs.\n");
+		pr_info("\tPoll for callbacks from no-CBs CPUs\n");
 
 	for_each_rcu_flavor(rsp) {
 		for_each_cpu(cpu, rcu_nocb_mask)
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 4c230a60ece4..e6ccf4864fe6 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -30,6 +30,9 @@
  *		http://lse.sourceforge.net/locking/rcupdate.html
  *
  */
+
+#define pr_fmt(fmt) "rcu: " fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -844,9 +847,10 @@ static void __init rcu_tasks_bootup_oddness(void)
 {
 #ifdef CONFIG_TASKS_RCU
 	if (rcu_task_stall_timeout != RCU_TASK_STALL_TIMEOUT)
-		pr_info("\tTasks-RCU CPU stall warnings timeout set to %d (rcu_task_stall_timeout).\n", rcu_task_stall_timeout);
+		pr_info("\tTasks-RCU CPU stall warnings timeout set to %d (rcu_task_stall_timeout)\n",
+			rcu_task_stall_timeout);
 	else
-		pr_info("\tTasks RCU enabled.\n");
+		pr_info("\tTasks RCU enabled\n");
 #endif /* #ifdef CONFIG_TASKS_RCU */
 }
 
@@ -945,15 +949,16 @@ void rcu_early_boot_tests(void) {}
 void __init rcupdate_announce_bootup_oddness(void)
 {
 	if (rcu_normal)
-		pr_info("\tNo expedited grace period (rcu_normal).\n");
+		pr_info("\tNo expedited grace period (rcu_normal)\n");
 	else if (rcu_normal_after_boot)
-		pr_info("\tNo expedited grace period (rcu_normal_after_boot).\n");
+		pr_info("\tNo expedited grace period (rcu_normal_after_boot)\n");
 	else if (rcu_expedited)
-		pr_info("\tAll grace periods are expedited (rcu_expedited).\n");
+		pr_info("\tAll grace periods are expedited (rcu_expedited)\n");
 	if (rcu_cpu_stall_suppress)
-		pr_info("\tRCU CPU stall warnings suppressed (rcu_cpu_stall_suppress).\n");
+		pr_info("\tRCU CPU stall warnings suppressed (rcu_cpu_stall_suppress)\n");
 	if (rcu_cpu_stall_timeout != CONFIG_RCU_CPU_STALL_TIMEOUT)
-		pr_info("\tRCU CPU stall warnings timeout set to %d (rcu_cpu_stall_timeout).\n", rcu_cpu_stall_timeout);
+		pr_info("\tRCU CPU stall warnings timeout set to %d (rcu_cpu_stall_timeout)\n",
+			rcu_cpu_stall_timeout);
 	rcu_tasks_bootup_oddness();
 }
 
-- 
2.15.0
