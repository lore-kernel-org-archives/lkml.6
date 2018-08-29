Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC3EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5733020644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5733020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeH3Cmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:42:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727181AbeH3CiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMchfh062048
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61x8d888-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:02 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:01 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcuP819333136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 624D2B2075;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36135B2072;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 65C2216C91E2; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 31/52] rcu: Remove rsp parameter from _rcu_barrier() and friends
Date:   Wed, 29 Aug 2018 15:38:33 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0060-0000-0000-000002A66419
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0061-0000-0000-00004655B6AC
Message-Id: <20180829223854.4055-31-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There now is only one rcu_state structure in a given build of the
Linux kernel, so there is no need to pass it as a parameter to RCU's
functions.  This commit therefore removes the rsp parameter from
_rcu_barrier_trace() and _rcu_barrier().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e347a6b2984c..8028936dc95d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3155,11 +3155,10 @@ static bool rcu_cpu_has_callbacks(bool *all_lazy)
  * Helper function for _rcu_barrier() tracing.  If tracing is disabled,
  * the compiler is expected to optimize this away.
  */
-static void _rcu_barrier_trace(struct rcu_state *rsp, const char *s,
-			       int cpu, unsigned long done)
+static void _rcu_barrier_trace(const char *s, int cpu, unsigned long done)
 {
-	trace_rcu_barrier(rsp->name, s, cpu,
-			  atomic_read(&rsp->barrier_cpu_count), done);
+	trace_rcu_barrier(rcu_state.name, s, cpu,
+			  atomic_read(&rcu_state.barrier_cpu_count), done);
 }
 
 /*
@@ -3172,11 +3171,10 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
 	struct rcu_state *rsp = rdp->rsp;
 
 	if (atomic_dec_and_test(&rsp->barrier_cpu_count)) {
-		_rcu_barrier_trace(rsp, TPS("LastCB"), -1,
-				   rsp->barrier_sequence);
+		_rcu_barrier_trace(TPS("LastCB"), -1, rsp->barrier_sequence);
 		complete(&rsp->barrier_completion);
 	} else {
-		_rcu_barrier_trace(rsp, TPS("CB"), -1, rsp->barrier_sequence);
+		_rcu_barrier_trace(TPS("CB"), -1, rsp->barrier_sequence);
 	}
 }
 
@@ -3188,15 +3186,14 @@ static void rcu_barrier_func(void *type)
 	struct rcu_state *rsp = type;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 
-	_rcu_barrier_trace(rsp, TPS("IRQ"), -1, rsp->barrier_sequence);
+	_rcu_barrier_trace(TPS("IRQ"), -1, rsp->barrier_sequence);
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head, 0)) {
 		atomic_inc(&rsp->barrier_cpu_count);
 	} else {
 		debug_rcu_head_unqueue(&rdp->barrier_head);
-		_rcu_barrier_trace(rsp, TPS("IRQNQ"), -1,
-				   rsp->barrier_sequence);
+		_rcu_barrier_trace(TPS("IRQNQ"), -1, rsp->barrier_sequence);
 	}
 }
 
@@ -3204,21 +3201,21 @@ static void rcu_barrier_func(void *type)
  * Orchestrate the specified type of RCU barrier, waiting for all
  * RCU callbacks of the specified type to complete.
  */
-static void _rcu_barrier(struct rcu_state *rsp)
+static void _rcu_barrier(void)
 {
 	int cpu;
 	struct rcu_data *rdp;
+	struct rcu_state *rsp = &rcu_state;
 	unsigned long s = rcu_seq_snap(&rsp->barrier_sequence);
 
-	_rcu_barrier_trace(rsp, TPS("Begin"), -1, s);
+	_rcu_barrier_trace(TPS("Begin"), -1, s);
 
 	/* Take mutex to serialize concurrent rcu_barrier() requests. */
 	mutex_lock(&rsp->barrier_mutex);
 
 	/* Did someone else do our work for us? */
 	if (rcu_seq_done(&rsp->barrier_sequence, s)) {
-		_rcu_barrier_trace(rsp, TPS("EarlyExit"), -1,
-				   rsp->barrier_sequence);
+		_rcu_barrier_trace(TPS("EarlyExit"), -1, rsp->barrier_sequence);
 		smp_mb(); /* caller's subsequent code after above check. */
 		mutex_unlock(&rsp->barrier_mutex);
 		return;
@@ -3226,7 +3223,7 @@ static void _rcu_barrier(struct rcu_state *rsp)
 
 	/* Mark the start of the barrier operation. */
 	rcu_seq_start(&rsp->barrier_sequence);
-	_rcu_barrier_trace(rsp, TPS("Inc1"), -1, rsp->barrier_sequence);
+	_rcu_barrier_trace(TPS("Inc1"), -1, rsp->barrier_sequence);
 
 	/*
 	 * Initialize the count to one rather than to zero in order to
@@ -3249,10 +3246,10 @@ static void _rcu_barrier(struct rcu_state *rsp)
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rcu_is_nocb_cpu(cpu)) {
 			if (!rcu_nocb_cpu_needs_barrier(rsp, cpu)) {
-				_rcu_barrier_trace(rsp, TPS("OfflineNoCB"), cpu,
+				_rcu_barrier_trace(TPS("OfflineNoCB"), cpu,
 						   rsp->barrier_sequence);
 			} else {
-				_rcu_barrier_trace(rsp, TPS("OnlineNoCB"), cpu,
+				_rcu_barrier_trace(TPS("OnlineNoCB"), cpu,
 						   rsp->barrier_sequence);
 				smp_mb__before_atomic();
 				atomic_inc(&rsp->barrier_cpu_count);
@@ -3260,11 +3257,11 @@ static void _rcu_barrier(struct rcu_state *rsp)
 					   rcu_barrier_callback, cpu, 0);
 			}
 		} else if (rcu_segcblist_n_cbs(&rdp->cblist)) {
-			_rcu_barrier_trace(rsp, TPS("OnlineQ"), cpu,
+			_rcu_barrier_trace(TPS("OnlineQ"), cpu,
 					   rsp->barrier_sequence);
 			smp_call_function_single(cpu, rcu_barrier_func, rsp, 1);
 		} else {
-			_rcu_barrier_trace(rsp, TPS("OnlineNQ"), cpu,
+			_rcu_barrier_trace(TPS("OnlineNQ"), cpu,
 					   rsp->barrier_sequence);
 		}
 	}
@@ -3281,7 +3278,7 @@ static void _rcu_barrier(struct rcu_state *rsp)
 	wait_for_completion(&rsp->barrier_completion);
 
 	/* Mark the end of the barrier operation. */
-	_rcu_barrier_trace(rsp, TPS("Inc2"), -1, rsp->barrier_sequence);
+	_rcu_barrier_trace(TPS("Inc2"), -1, rsp->barrier_sequence);
 	rcu_seq_end(&rsp->barrier_sequence);
 
 	/* Other rcu_barrier() invocations can now safely proceed. */
@@ -3293,7 +3290,7 @@ static void _rcu_barrier(struct rcu_state *rsp)
  */
 void rcu_barrier_bh(void)
 {
-	_rcu_barrier(&rcu_state);
+	_rcu_barrier();
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_bh);
 
@@ -3307,7 +3304,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_bh);
  */
 void rcu_barrier(void)
 {
-	_rcu_barrier(&rcu_state);
+	_rcu_barrier();
 }
 EXPORT_SYMBOL_GPL(rcu_barrier);
 
-- 
2.17.1

