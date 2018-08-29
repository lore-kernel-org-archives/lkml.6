Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE595C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9449220644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9449220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeH3CiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727539AbeH3CiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMchxI062045
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:06 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61x8d8ay-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:04 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcwcH4784470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75198B2065;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46330B2068;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C4BF516C91D5; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 48/52] rcu: Eliminate callback-invocation/invocation use of rsp
Date:   Wed, 29 Aug 2018 15:38:50 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0052-0000-0000-0000032820CB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0053-0000-0000-00005DE5FB26
Message-Id: <20180829223854.4055-48-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=945 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is only one rcu_state structure, there is less point in
maintaining a pointer to it.  This commit therefore replaces rsp with
&rcu_state in rcu_do_batch(), invoke_rcu_callbacks(), and __call_rcu().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 734cd95368e6..e6f0d8b6bde3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2466,14 +2466,13 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count;
-	struct rcu_state *rsp = &rcu_state;
 
 	/* If no callbacks are ready, just return. */
 	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
-		trace_rcu_batch_start(rsp->name,
+		trace_rcu_batch_start(rcu_state.name,
 				      rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 				      rcu_segcblist_n_cbs(&rdp->cblist), 0);
-		trace_rcu_batch_end(rsp->name, 0,
+		trace_rcu_batch_end(rcu_state.name, 0,
 				    !rcu_segcblist_empty(&rdp->cblist),
 				    need_resched(), is_idle_task(current),
 				    rcu_is_callbacks_kthread());
@@ -2488,7 +2487,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	local_irq_save(flags);
 	WARN_ON_ONCE(cpu_is_offline(smp_processor_id()));
 	bl = rdp->blimit;
-	trace_rcu_batch_start(rsp->name, rcu_segcblist_n_lazy_cbs(&rdp->cblist),
+	trace_rcu_batch_start(rcu_state.name,
+			      rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
 	local_irq_restore(flags);
@@ -2497,7 +2497,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rhp = rcu_cblist_dequeue(&rcl);
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		debug_rcu_head_unqueue(rhp);
-		if (__rcu_reclaim(rsp->name, rhp))
+		if (__rcu_reclaim(rcu_state.name, rhp))
 			rcu_cblist_dequeued_lazy(&rcl);
 		/*
 		 * Stop only if limit reached and CPU has something to do.
@@ -2511,7 +2511,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	count = -rcl.len;
-	trace_rcu_batch_end(rsp->name, count, !!rcl.head, need_resched(),
+	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
 
 	/* Update counts and requeue any remaining callbacks. */
@@ -2527,7 +2527,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Reset ->qlen_last_fqs_check trigger if enough CBs have drained. */
 	if (count == 0 && rdp->qlen_last_fqs_check != 0) {
 		rdp->qlen_last_fqs_check = 0;
-		rdp->n_force_qs_snap = rsp->n_force_qs;
+		rdp->n_force_qs_snap = rcu_state.n_force_qs;
 	} else if (count < rdp->qlen_last_fqs_check - qhimark)
 		rdp->qlen_last_fqs_check = count;
 
@@ -2763,11 +2763,9 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
  */
 static void invoke_rcu_callbacks(struct rcu_data *rdp)
 {
-	struct rcu_state *rsp = &rcu_state;
-
 	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
 		return;
-	if (likely(!rsp->boost)) {
+	if (likely(!rcu_state.boost)) {
 		rcu_do_batch(rdp);
 		return;
 	}
@@ -2843,7 +2841,6 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, int cpu, bool lazy)
 {
 	unsigned long flags;
 	struct rcu_data *rdp;
-	struct rcu_state __maybe_unused *rsp = &rcu_state;
 
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
@@ -2892,11 +2889,12 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, int cpu, bool lazy)
 		rcu_idle_count_callbacks_posted();
 
 	if (__is_kfree_rcu_offset((unsigned long)func))
-		trace_rcu_kfree_callback(rsp->name, head, (unsigned long)func,
+		trace_rcu_kfree_callback(rcu_state.name, head,
+					 (unsigned long)func,
 					 rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 					 rcu_segcblist_n_cbs(&rdp->cblist));
 	else
-		trace_rcu_callback(rsp->name, head,
+		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
-- 
2.17.1

