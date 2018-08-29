Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD5DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FA120644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FA120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeH3CiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727768AbeH3CiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcvVQ046948
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:06 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m62u3k67v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:05 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcwhj45678834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 754AFB2074;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F52BB206B;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D17A316C91E3; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 50/52] rcu: Eliminate RCU-barrier use of rsp
Date:   Wed, 29 Aug 2018 15:38:52 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0072-0000-0000-0000039968A9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0073-0000-0000-0000493EB379
Message-Id: <20180829223854.4055-50-paulmck@linux.vnet.ibm.com>
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

Now that there is only one rcu_state structure, there is less point
in maintaining a pointer to it.  This commit therefore replaces rsp
with &rcu_state in rcu_barrier_callback(), rcu_barrier_func(), and
_rcu_barrier().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 65 +++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 962b75c9722a..e573fb9f0ef8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3128,32 +3128,31 @@ static void _rcu_barrier_trace(const char *s, int cpu, unsigned long done)
  */
 static void rcu_barrier_callback(struct rcu_head *rhp)
 {
-	struct rcu_state *rsp = &rcu_state;
-
-	if (atomic_dec_and_test(&rsp->barrier_cpu_count)) {
-		_rcu_barrier_trace(TPS("LastCB"), -1, rsp->barrier_sequence);
-		complete(&rsp->barrier_completion);
+	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count)) {
+		_rcu_barrier_trace(TPS("LastCB"), -1,
+				   rcu_state.barrier_sequence);
+		complete(&rcu_state.barrier_completion);
 	} else {
-		_rcu_barrier_trace(TPS("CB"), -1, rsp->barrier_sequence);
+		_rcu_barrier_trace(TPS("CB"), -1, rcu_state.barrier_sequence);
 	}
 }
 
 /*
  * Called with preemption disabled, and from cross-cpu IRQ context.
  */
-static void rcu_barrier_func(void *type)
+static void rcu_barrier_func(void *unused)
 {
-	struct rcu_state *rsp = type;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 
-	_rcu_barrier_trace(TPS("IRQ"), -1, rsp->barrier_sequence);
+	_rcu_barrier_trace(TPS("IRQ"), -1, rcu_state.barrier_sequence);
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head, 0)) {
-		atomic_inc(&rsp->barrier_cpu_count);
+		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
 		debug_rcu_head_unqueue(&rdp->barrier_head);
-		_rcu_barrier_trace(TPS("IRQNQ"), -1, rsp->barrier_sequence);
+		_rcu_barrier_trace(TPS("IRQNQ"), -1,
+				   rcu_state.barrier_sequence);
 	}
 }
 
@@ -3165,25 +3164,25 @@ static void _rcu_barrier(void)
 {
 	int cpu;
 	struct rcu_data *rdp;
-	struct rcu_state *rsp = &rcu_state;
-	unsigned long s = rcu_seq_snap(&rsp->barrier_sequence);
+	unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
 
 	_rcu_barrier_trace(TPS("Begin"), -1, s);
 
 	/* Take mutex to serialize concurrent rcu_barrier() requests. */
-	mutex_lock(&rsp->barrier_mutex);
+	mutex_lock(&rcu_state.barrier_mutex);
 
 	/* Did someone else do our work for us? */
-	if (rcu_seq_done(&rsp->barrier_sequence, s)) {
-		_rcu_barrier_trace(TPS("EarlyExit"), -1, rsp->barrier_sequence);
+	if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
+		_rcu_barrier_trace(TPS("EarlyExit"), -1,
+				   rcu_state.barrier_sequence);
 		smp_mb(); /* caller's subsequent code after above check. */
-		mutex_unlock(&rsp->barrier_mutex);
+		mutex_unlock(&rcu_state.barrier_mutex);
 		return;
 	}
 
 	/* Mark the start of the barrier operation. */
-	rcu_seq_start(&rsp->barrier_sequence);
-	_rcu_barrier_trace(TPS("Inc1"), -1, rsp->barrier_sequence);
+	rcu_seq_start(&rcu_state.barrier_sequence);
+	_rcu_barrier_trace(TPS("Inc1"), -1, rcu_state.barrier_sequence);
 
 	/*
 	 * Initialize the count to one rather than to zero in order to
@@ -3191,8 +3190,8 @@ static void _rcu_barrier(void)
 	 * (or preemption of this task).  Exclude CPU-hotplug operations
 	 * to ensure that no offline CPU has callbacks queued.
 	 */
-	init_completion(&rsp->barrier_completion);
-	atomic_set(&rsp->barrier_cpu_count, 1);
+	init_completion(&rcu_state.barrier_completion);
+	atomic_set(&rcu_state.barrier_cpu_count, 1);
 	get_online_cpus();
 
 	/*
@@ -3207,22 +3206,22 @@ static void _rcu_barrier(void)
 		if (rcu_is_nocb_cpu(cpu)) {
 			if (!rcu_nocb_cpu_needs_barrier(cpu)) {
 				_rcu_barrier_trace(TPS("OfflineNoCB"), cpu,
-						   rsp->barrier_sequence);
+						   rcu_state.barrier_sequence);
 			} else {
 				_rcu_barrier_trace(TPS("OnlineNoCB"), cpu,
-						   rsp->barrier_sequence);
+						   rcu_state.barrier_sequence);
 				smp_mb__before_atomic();
-				atomic_inc(&rsp->barrier_cpu_count);
+				atomic_inc(&rcu_state.barrier_cpu_count);
 				__call_rcu(&rdp->barrier_head,
 					   rcu_barrier_callback, cpu, 0);
 			}
 		} else if (rcu_segcblist_n_cbs(&rdp->cblist)) {
 			_rcu_barrier_trace(TPS("OnlineQ"), cpu,
-					   rsp->barrier_sequence);
-			smp_call_function_single(cpu, rcu_barrier_func, rsp, 1);
+					   rcu_state.barrier_sequence);
+			smp_call_function_single(cpu, rcu_barrier_func, NULL, 1);
 		} else {
 			_rcu_barrier_trace(TPS("OnlineNQ"), cpu,
-					   rsp->barrier_sequence);
+					   rcu_state.barrier_sequence);
 		}
 	}
 	put_online_cpus();
@@ -3231,18 +3230,18 @@ static void _rcu_barrier(void)
 	 * Now that we have an rcu_barrier_callback() callback on each
 	 * CPU, and thus each counted, remove the initial count.
 	 */
-	if (atomic_dec_and_test(&rsp->barrier_cpu_count))
-		complete(&rsp->barrier_completion);
+	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count))
+		complete(&rcu_state.barrier_completion);
 
 	/* Wait for all rcu_barrier_callback() callbacks to be invoked. */
-	wait_for_completion(&rsp->barrier_completion);
+	wait_for_completion(&rcu_state.barrier_completion);
 
 	/* Mark the end of the barrier operation. */
-	_rcu_barrier_trace(TPS("Inc2"), -1, rsp->barrier_sequence);
-	rcu_seq_end(&rsp->barrier_sequence);
+	_rcu_barrier_trace(TPS("Inc2"), -1, rcu_state.barrier_sequence);
+	rcu_seq_end(&rcu_state.barrier_sequence);
 
 	/* Other rcu_barrier() invocations can now safely proceed. */
-	mutex_unlock(&rsp->barrier_mutex);
+	mutex_unlock(&rcu_state.barrier_mutex);
 }
 
 /**
-- 
2.17.1

