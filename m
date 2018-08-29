Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29B420647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29B420647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeH3Cy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:54:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727664AbeH3CxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:24 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMs1XM003101
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:16 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61jbxhdc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:15 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:15 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:09 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs9KZ46989358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D354FB2068;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACCF0B206C;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CE17816C91DF; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 24/24] rcu: Inline _rcu_barrier() into its sole remaining caller
Date:   Wed, 29 Aug 2018 15:54:05 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0040-0000-0000-00000467593E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860735;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0041-0000-0000-0000086E731D
Message-Id: <20180829225405.7275-24-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because rcu_barrier() is a one-line wrapper function for _rcu_barrier()
and because nothing else calls _rcu_barrier(), this commit inlines
_rcu_barrier() into rcu_barrier().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h | 20 ++++++-------
 kernel/rcu/tree.c          | 58 +++++++++++++++++---------------------
 kernel/rcu/tree.h          |  4 +--
 kernel/rcu/tree_plugin.h   |  2 +-
 4 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index a8d07feff6a0..175e0bce22bd 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -705,20 +705,20 @@ TRACE_EVENT(rcu_torture_read,
 );
 
 /*
- * Tracepoint for _rcu_barrier() execution.  The string "s" describes
- * the _rcu_barrier phase:
- *	"Begin": _rcu_barrier() started.
- *	"EarlyExit": _rcu_barrier() piggybacked, thus early exit.
- *	"Inc1": _rcu_barrier() piggyback check counter incremented.
- *	"OfflineNoCB": _rcu_barrier() found callback on never-online CPU
- *	"OnlineNoCB": _rcu_barrier() found online no-CBs CPU.
- *	"OnlineQ": _rcu_barrier() found online CPU with callbacks.
- *	"OnlineNQ": _rcu_barrier() found online CPU, no callbacks.
+ * Tracepoint for rcu_barrier() execution.  The string "s" describes
+ * the rcu_barrier phase:
+ *	"Begin": rcu_barrier() started.
+ *	"EarlyExit": rcu_barrier() piggybacked, thus early exit.
+ *	"Inc1": rcu_barrier() piggyback check counter incremented.
+ *	"OfflineNoCB": rcu_barrier() found callback on never-online CPU
+ *	"OnlineNoCB": rcu_barrier() found online no-CBs CPU.
+ *	"OnlineQ": rcu_barrier() found online CPU with callbacks.
+ *	"OnlineNQ": rcu_barrier() found online CPU, no callbacks.
  *	"IRQ": An rcu_barrier_callback() callback posted on remote CPU.
  *	"IRQNQ": An rcu_barrier_callback() callback found no callbacks.
  *	"CB": An rcu_barrier_callback() invoked a callback, not the last.
  *	"LastCB": An rcu_barrier_callback() invoked the last callback.
- *	"Inc2": _rcu_barrier() piggyback check counter incremented.
+ *	"Inc2": rcu_barrier() piggyback check counter incremented.
  * The "cpu" argument is the CPU or -1 if meaningless, the "cnt" argument
  * is the count of remaining callbacks, and "done" is the piggybacking count.
  */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5f2a12a65b42..31e94f672d01 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2746,7 +2746,7 @@ static void rcu_leak_callback(struct rcu_head *rhp)
 /*
  * Helper function for call_rcu() and friends.  The cpu argument will
  * normally be -1, indicating "currently running CPU".  It may specify
- * a CPU only if that CPU is a no-CBs CPU.  Currently, only _rcu_barrier()
+ * a CPU only if that CPU is a no-CBs CPU.  Currently, only rcu_barrier()
  * is expected to specify a CPU.
  */
 static void
@@ -2980,27 +2980,27 @@ static bool rcu_cpu_has_callbacks(bool *all_lazy)
 }
 
 /*
- * Helper function for _rcu_barrier() tracing.  If tracing is disabled,
+ * Helper function for rcu_barrier() tracing.  If tracing is disabled,
  * the compiler is expected to optimize this away.
  */
-static void _rcu_barrier_trace(const char *s, int cpu, unsigned long done)
+static void rcu_barrier_trace(const char *s, int cpu, unsigned long done)
 {
 	trace_rcu_barrier(rcu_state.name, s, cpu,
 			  atomic_read(&rcu_state.barrier_cpu_count), done);
 }
 
 /*
- * RCU callback function for _rcu_barrier().  If we are last, wake
- * up the task executing _rcu_barrier().
+ * RCU callback function for rcu_barrier().  If we are last, wake
+ * up the task executing rcu_barrier().
  */
 static void rcu_barrier_callback(struct rcu_head *rhp)
 {
 	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count)) {
-		_rcu_barrier_trace(TPS("LastCB"), -1,
+		rcu_barrier_trace(TPS("LastCB"), -1,
 				   rcu_state.barrier_sequence);
 		complete(&rcu_state.barrier_completion);
 	} else {
-		_rcu_barrier_trace(TPS("CB"), -1, rcu_state.barrier_sequence);
+		rcu_barrier_trace(TPS("CB"), -1, rcu_state.barrier_sequence);
 	}
 }
 
@@ -3011,33 +3011,40 @@ static void rcu_barrier_func(void *unused)
 {
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 
-	_rcu_barrier_trace(TPS("IRQ"), -1, rcu_state.barrier_sequence);
+	rcu_barrier_trace(TPS("IRQ"), -1, rcu_state.barrier_sequence);
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head, 0)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
 		debug_rcu_head_unqueue(&rdp->barrier_head);
-		_rcu_barrier_trace(TPS("IRQNQ"), -1,
+		rcu_barrier_trace(TPS("IRQNQ"), -1,
 				   rcu_state.barrier_sequence);
 	}
 }
 
-/* Orchestrate an RCU barrier, waiting for all RCU callbacks to complete.  */
-static void _rcu_barrier(void)
+/**
+ * rcu_barrier - Wait until all in-flight call_rcu() callbacks complete.
+ *
+ * Note that this primitive does not necessarily wait for an RCU grace period
+ * to complete.  For example, if there are no RCU callbacks queued anywhere
+ * in the system, then rcu_barrier() is within its rights to return
+ * immediately, without waiting for anything, much less an RCU grace period.
+ */
+void rcu_barrier(void)
 {
 	int cpu;
 	struct rcu_data *rdp;
 	unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
 
-	_rcu_barrier_trace(TPS("Begin"), -1, s);
+	rcu_barrier_trace(TPS("Begin"), -1, s);
 
 	/* Take mutex to serialize concurrent rcu_barrier() requests. */
 	mutex_lock(&rcu_state.barrier_mutex);
 
 	/* Did someone else do our work for us? */
 	if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
-		_rcu_barrier_trace(TPS("EarlyExit"), -1,
+		rcu_barrier_trace(TPS("EarlyExit"), -1,
 				   rcu_state.barrier_sequence);
 		smp_mb(); /* caller's subsequent code after above check. */
 		mutex_unlock(&rcu_state.barrier_mutex);
@@ -3046,7 +3053,7 @@ static void _rcu_barrier(void)
 
 	/* Mark the start of the barrier operation. */
 	rcu_seq_start(&rcu_state.barrier_sequence);
-	_rcu_barrier_trace(TPS("Inc1"), -1, rcu_state.barrier_sequence);
+	rcu_barrier_trace(TPS("Inc1"), -1, rcu_state.barrier_sequence);
 
 	/*
 	 * Initialize the count to one rather than to zero in order to
@@ -3069,10 +3076,10 @@ static void _rcu_barrier(void)
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rcu_is_nocb_cpu(cpu)) {
 			if (!rcu_nocb_cpu_needs_barrier(cpu)) {
-				_rcu_barrier_trace(TPS("OfflineNoCB"), cpu,
+				rcu_barrier_trace(TPS("OfflineNoCB"), cpu,
 						   rcu_state.barrier_sequence);
 			} else {
-				_rcu_barrier_trace(TPS("OnlineNoCB"), cpu,
+				rcu_barrier_trace(TPS("OnlineNoCB"), cpu,
 						   rcu_state.barrier_sequence);
 				smp_mb__before_atomic();
 				atomic_inc(&rcu_state.barrier_cpu_count);
@@ -3080,11 +3087,11 @@ static void _rcu_barrier(void)
 					   rcu_barrier_callback, cpu, 0);
 			}
 		} else if (rcu_segcblist_n_cbs(&rdp->cblist)) {
-			_rcu_barrier_trace(TPS("OnlineQ"), cpu,
+			rcu_barrier_trace(TPS("OnlineQ"), cpu,
 					   rcu_state.barrier_sequence);
 			smp_call_function_single(cpu, rcu_barrier_func, NULL, 1);
 		} else {
-			_rcu_barrier_trace(TPS("OnlineNQ"), cpu,
+			rcu_barrier_trace(TPS("OnlineNQ"), cpu,
 					   rcu_state.barrier_sequence);
 		}
 	}
@@ -3101,25 +3108,12 @@ static void _rcu_barrier(void)
 	wait_for_completion(&rcu_state.barrier_completion);
 
 	/* Mark the end of the barrier operation. */
-	_rcu_barrier_trace(TPS("Inc2"), -1, rcu_state.barrier_sequence);
+	rcu_barrier_trace(TPS("Inc2"), -1, rcu_state.barrier_sequence);
 	rcu_seq_end(&rcu_state.barrier_sequence);
 
 	/* Other rcu_barrier() invocations can now safely proceed. */
 	mutex_unlock(&rcu_state.barrier_mutex);
 }
-
-/**
- * rcu_barrier - Wait until all in-flight call_rcu() callbacks complete.
- *
- * Note that this primitive does not necessarily wait for an RCU grace period
- * to complete.  For example, if there are no RCU callbacks queued anywhere
- * in the system, then rcu_barrier() is within its rights to return
- * immediately, without waiting for anything, much less an RCU grace period.
- */
-void rcu_barrier(void)
-{
-	_rcu_barrier();
-}
 EXPORT_SYMBOL_GPL(rcu_barrier);
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 46452d3d0fad..8cf93ac277ec 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -222,7 +222,7 @@ struct rcu_data {
 					/* Grace period that needs help */
 					/*  from cond_resched(). */
 
-	/* 5) _rcu_barrier(), OOM callbacks, and expediting. */
+	/* 5) rcu_barrier(), OOM callbacks, and expediting. */
 	struct rcu_head barrier_head;
 	int exp_dynticks_snap;		/* Double-check need for IPI. */
 
@@ -328,7 +328,7 @@ struct rcu_state {
 	atomic_t barrier_cpu_count;		/* # CPUs waiting on. */
 	struct completion barrier_completion;	/* Wake at barrier end. */
 	unsigned long barrier_sequence;		/* ++ at start and end of */
-						/*  _rcu_barrier(). */
+						/*  rcu_barrier(). */
 	/* End of fields guarded by barrier_mutex. */
 
 	struct mutex exp_mutex;			/* Serialize expedited GP. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7add1c297500..beaaca7a11f4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1993,7 +1993,7 @@ static bool rcu_nocb_cpu_needs_barrier(int cpu)
 	 * There needs to be a barrier before this function is called,
 	 * but associated with a prior determination that no more
 	 * callbacks would be posted.  In the worst case, the first
-	 * barrier in _rcu_barrier() suffices (but the caller cannot
+	 * barrier in rcu_barrier() suffices (but the caller cannot
 	 * necessarily rely on this, not a substitute for the caller
 	 * getting the concurrency design right!).  There must also be
 	 * a barrier between the following load an posting of a callback
-- 
2.17.1

