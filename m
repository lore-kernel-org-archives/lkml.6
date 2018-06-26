Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F4C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B0526330
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B0526330
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935182AbeFZAMu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:12:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934351AbeFZAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03mGn110246
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96q2m2r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:01 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06uEG5308782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5174B2065;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81D53B206A;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F1F7616CA095; Mon, 25 Jun 2018 17:09:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 03/40] rcu: Make rcutorture's batches-completed API use ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:22 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0064-0000-0000-000003202F8E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0065-0000-0000-000039B74445
Message-Id: <20180626000859.23572-3-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcutorture test invokes rcu_batches_started(),
rcu_batches_completed(), rcu_batches_started_bh(),
rcu_batches_completed_bh(), rcu_batches_started_sched(), and
rcu_batches_completed_sched() to do grace-period consistency checks,
and rcuperf uses the _completed variants for statistics.
These functions use ->gpnum and ->completed.  This commit therefore
replaces them with rcu_get_gp_seq(), rcu_bh_get_gp_seq(), and
rcu_sched_get_gp_seq(), adjusting rcutorture and rcuperf to make
use of them.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h        | 18 +++++----------
 kernel/rcu/rcuperf.c    | 26 ++++++++-------------
 kernel/rcu/rcutorture.c | 50 +++++++++++++++-------------------------
 kernel/rcu/tree.c       | 51 ++++++++++-------------------------------
 4 files changed, 45 insertions(+), 100 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index db0870acfdff..f0907f9f6cd0 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -463,12 +463,9 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
 #endif
 
 #ifdef CONFIG_TINY_RCU
-static inline unsigned long rcu_batches_started(void) { return 0; }
-static inline unsigned long rcu_batches_started_bh(void) { return 0; }
-static inline unsigned long rcu_batches_started_sched(void) { return 0; }
-static inline unsigned long rcu_batches_completed(void) { return 0; }
-static inline unsigned long rcu_batches_completed_bh(void) { return 0; }
-static inline unsigned long rcu_batches_completed_sched(void) { return 0; }
+static inline unsigned long rcu_get_gp_seq(void) { return 0; }
+static inline unsigned long rcu_bh_get_gp_seq(void) { return 0; }
+static inline unsigned long rcu_sched_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed_sched(void) { return 0; }
 static inline unsigned long
@@ -480,12 +477,9 @@ static inline void show_rcu_gp_kthreads(void) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 extern unsigned long rcutorture_testseq;
 extern unsigned long rcutorture_vernum;
-unsigned long rcu_batches_started(void);
-unsigned long rcu_batches_started_bh(void);
-unsigned long rcu_batches_started_sched(void);
-unsigned long rcu_batches_completed(void);
-unsigned long rcu_batches_completed_bh(void);
-unsigned long rcu_batches_completed_sched(void);
+unsigned long rcu_get_gp_seq(void);
+unsigned long rcu_bh_get_gp_seq(void);
+unsigned long rcu_sched_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long rcu_exp_batches_completed_sched(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index df29119b2013..2b5a613afcf3 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -138,8 +138,7 @@ struct rcu_perf_ops {
 	void (*cleanup)(void);
 	int (*readlock)(void);
 	void (*readunlock)(int idx);
-	unsigned long (*started)(void);
-	unsigned long (*completed)(void);
+	unsigned long (*get_gp_seq)(void);
 	unsigned long (*exp_completed)(void);
 	void (*async)(struct rcu_head *head, rcu_callback_t func);
 	void (*gp_barrier)(void);
@@ -179,8 +178,7 @@ static struct rcu_perf_ops rcu_ops = {
 	.init		= rcu_sync_perf_init,
 	.readlock	= rcu_perf_read_lock,
 	.readunlock	= rcu_perf_read_unlock,
-	.started	= rcu_batches_started,
-	.completed	= rcu_batches_completed,
+	.get_gp_seq	= rcu_get_gp_seq,
 	.exp_completed	= rcu_exp_batches_completed,
 	.async		= call_rcu,
 	.gp_barrier	= rcu_barrier,
@@ -209,8 +207,7 @@ static struct rcu_perf_ops rcu_bh_ops = {
 	.init		= rcu_sync_perf_init,
 	.readlock	= rcu_bh_perf_read_lock,
 	.readunlock	= rcu_bh_perf_read_unlock,
-	.started	= rcu_batches_started_bh,
-	.completed	= rcu_batches_completed_bh,
+	.get_gp_seq	= rcu_bh_get_gp_seq,
 	.exp_completed	= rcu_exp_batches_completed_sched,
 	.async		= call_rcu_bh,
 	.gp_barrier	= rcu_barrier_bh,
@@ -266,8 +263,7 @@ static struct rcu_perf_ops srcu_ops = {
 	.init		= rcu_sync_perf_init,
 	.readlock	= srcu_perf_read_lock,
 	.readunlock	= srcu_perf_read_unlock,
-	.started	= NULL,
-	.completed	= srcu_perf_completed,
+	.get_gp_seq	= srcu_perf_completed,
 	.exp_completed	= srcu_perf_completed,
 	.async		= srcu_call_rcu,
 	.gp_barrier	= srcu_rcu_barrier,
@@ -295,8 +291,7 @@ static struct rcu_perf_ops srcud_ops = {
 	.cleanup	= srcu_sync_perf_cleanup,
 	.readlock	= srcu_perf_read_lock,
 	.readunlock	= srcu_perf_read_unlock,
-	.started	= NULL,
-	.completed	= srcu_perf_completed,
+	.get_gp_seq	= srcu_perf_completed,
 	.exp_completed	= srcu_perf_completed,
 	.async		= srcu_call_rcu,
 	.gp_barrier	= srcu_rcu_barrier,
@@ -325,8 +320,7 @@ static struct rcu_perf_ops sched_ops = {
 	.init		= rcu_sync_perf_init,
 	.readlock	= sched_perf_read_lock,
 	.readunlock	= sched_perf_read_unlock,
-	.started	= rcu_batches_started_sched,
-	.completed	= rcu_batches_completed_sched,
+	.get_gp_seq	= rcu_sched_get_gp_seq,
 	.exp_completed	= rcu_exp_batches_completed_sched,
 	.async		= call_rcu_sched,
 	.gp_barrier	= rcu_barrier_sched,
@@ -353,8 +347,7 @@ static struct rcu_perf_ops tasks_ops = {
 	.init		= rcu_sync_perf_init,
 	.readlock	= tasks_perf_read_lock,
 	.readunlock	= tasks_perf_read_unlock,
-	.started	= rcu_no_completed,
-	.completed	= rcu_no_completed,
+	.get_gp_seq	= rcu_no_completed,
 	.async		= call_rcu_tasks,
 	.gp_barrier	= rcu_barrier_tasks,
 	.sync		= synchronize_rcu_tasks,
@@ -447,8 +440,7 @@ rcu_perf_writer(void *arg)
 			b_rcu_perf_writer_started =
 				cur_ops->exp_completed() / 2;
 		} else {
-			b_rcu_perf_writer_started =
-				cur_ops->completed();
+			b_rcu_perf_writer_started = cur_ops->get_gp_seq();
 		}
 	}
 
@@ -505,7 +497,7 @@ rcu_perf_writer(void *arg)
 						cur_ops->exp_completed() / 2;
 				} else {
 					b_rcu_perf_writer_finished =
-						cur_ops->completed();
+						cur_ops->get_gp_seq();
 				}
 				if (shutdown) {
 					smp_mb(); /* Assign before wake. */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5604bfac8df4..1f66597c7783 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -264,8 +264,7 @@ struct rcu_torture_ops {
 	int (*readlock)(void);
 	void (*read_delay)(struct torture_random_state *rrsp);
 	void (*readunlock)(int idx);
-	unsigned long (*started)(void);
-	unsigned long (*completed)(void);
+	unsigned long (*get_gp_seq)(void);
 	void (*deferred_free)(struct rcu_torture *p);
 	void (*sync)(void);
 	void (*exp_sync)(void);
@@ -305,10 +304,10 @@ static void rcu_read_delay(struct torture_random_state *rrsp)
 	 * force_quiescent_state. */
 
 	if (!(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
-		started = cur_ops->completed();
+		started = cur_ops->get_gp_seq();
 		ts = rcu_trace_clock_local();
 		mdelay(longdelay_ms);
-		completed = cur_ops->completed();
+		completed = cur_ops->get_gp_seq();
 		do_trace_rcu_torture_read(cur_ops->name, NULL, ts,
 					  started, completed);
 	}
@@ -400,8 +399,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.readlock	= rcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,
 	.readunlock	= rcu_torture_read_unlock,
-	.started	= rcu_batches_started,
-	.completed	= rcu_batches_completed,
+	.get_gp_seq	= rcu_get_gp_seq,
 	.deferred_free	= rcu_torture_deferred_free,
 	.sync		= synchronize_rcu,
 	.exp_sync	= synchronize_rcu_expedited,
@@ -442,8 +440,7 @@ static struct rcu_torture_ops rcu_bh_ops = {
 	.readlock	= rcu_bh_torture_read_lock,
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= rcu_bh_torture_read_unlock,
-	.started	= rcu_batches_started_bh,
-	.completed	= rcu_batches_completed_bh,
+	.get_gp_seq	= rcu_bh_get_gp_seq,
 	.deferred_free	= rcu_bh_torture_deferred_free,
 	.sync		= synchronize_rcu_bh,
 	.exp_sync	= synchronize_rcu_bh_expedited,
@@ -486,8 +483,7 @@ static struct rcu_torture_ops rcu_busted_ops = {
 	.readlock	= rcu_torture_read_lock,
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= rcu_torture_read_unlock,
-	.started	= rcu_no_completed,
-	.completed	= rcu_no_completed,
+	.get_gp_seq	= rcu_no_completed,
 	.deferred_free	= rcu_busted_torture_deferred_free,
 	.sync		= synchronize_rcu_busted,
 	.exp_sync	= synchronize_rcu_busted,
@@ -575,8 +571,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
-	.started	= NULL,
-	.completed	= srcu_torture_completed,
+	.get_gp_seq	= srcu_torture_completed,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
@@ -613,8 +608,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
-	.started	= NULL,
-	.completed	= srcu_torture_completed,
+	.get_gp_seq	= srcu_torture_completed,
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
@@ -651,8 +645,7 @@ static struct rcu_torture_ops sched_ops = {
 	.readlock	= sched_torture_read_lock,
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= sched_torture_read_unlock,
-	.started	= rcu_batches_started_sched,
-	.completed	= rcu_batches_completed_sched,
+	.get_gp_seq	= rcu_sched_get_gp_seq,
 	.deferred_free	= rcu_sched_torture_deferred_free,
 	.sync		= synchronize_sched,
 	.exp_sync	= synchronize_sched_expedited,
@@ -690,8 +683,7 @@ static struct rcu_torture_ops tasks_ops = {
 	.readlock	= tasks_torture_read_lock,
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= tasks_torture_read_unlock,
-	.started	= rcu_no_completed,
-	.completed	= rcu_no_completed,
+	.get_gp_seq	= rcu_no_completed,
 	.deferred_free	= rcu_tasks_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks,
 	.exp_sync	= synchronize_rcu_tasks,
@@ -1104,10 +1096,7 @@ static void rcu_torture_timer(struct timer_list *unused)
 	unsigned long long ts;
 
 	idx = cur_ops->readlock();
-	if (cur_ops->started)
-		started = cur_ops->started();
-	else
-		started = cur_ops->completed();
+	started = cur_ops->get_gp_seq();
 	ts = rcu_trace_clock_local();
 	p = rcu_dereference_check(rcu_torture_current,
 				  rcu_read_lock_bh_held() ||
@@ -1131,7 +1120,7 @@ static void rcu_torture_timer(struct timer_list *unused)
 		/* Should not happen, but... */
 		pipe_count = RCU_TORTURE_PIPE_LEN;
 	}
-	completed = cur_ops->completed();
+	completed = cur_ops->get_gp_seq();
 	if (pipe_count > 1) {
 		do_trace_rcu_torture_read(cur_ops->name, &p->rtort_rcu, ts,
 					  started, completed);
@@ -1139,8 +1128,8 @@ static void rcu_torture_timer(struct timer_list *unused)
 	}
 	__this_cpu_inc(rcu_torture_count[pipe_count]);
 	completed = completed - started;
-	if (cur_ops->started)
-		completed++;
+	if (completed > ULONG_MAX >> 1)
+		completed = 0; /* Not all gp_seq have full range. */
 	if (completed > RCU_TORTURE_PIPE_LEN) {
 		/* Should not happen, but... */
 		completed = RCU_TORTURE_PIPE_LEN;
@@ -1187,10 +1176,7 @@ rcu_torture_reader(void *arg)
 				mod_timer(&t, jiffies + 1);
 		}
 		idx = cur_ops->readlock();
-		if (cur_ops->started)
-			started = cur_ops->started();
-		else
-			started = cur_ops->completed();
+		started = cur_ops->get_gp_seq();
 		ts = rcu_trace_clock_local();
 		p = rcu_dereference_check(rcu_torture_current,
 					  rcu_read_lock_bh_held() ||
@@ -1212,7 +1198,7 @@ rcu_torture_reader(void *arg)
 			/* Should not happen, but... */
 			pipe_count = RCU_TORTURE_PIPE_LEN;
 		}
-		completed = cur_ops->completed();
+		completed = cur_ops->get_gp_seq();
 		if (pipe_count > 1) {
 			do_trace_rcu_torture_read(cur_ops->name, &p->rtort_rcu,
 						  ts, started, completed);
@@ -1220,8 +1206,8 @@ rcu_torture_reader(void *arg)
 		}
 		__this_cpu_inc(rcu_torture_count[pipe_count]);
 		completed = completed - started;
-		if (cur_ops->started)
-			completed++;
+		if (completed > ULONG_MAX >> 1)
+			completed = 0; /* Not all gp_seq have full range. */
 		if (completed > RCU_TORTURE_PIPE_LEN) {
 			/* Should not happen, but... */
 			completed = RCU_TORTURE_PIPE_LEN;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 90346ffd721f..0961f6c61894 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -530,58 +530,31 @@ static void force_quiescent_state(struct rcu_state *rsp);
 static int rcu_pending(void);
 
 /*
- * Return the number of RCU batches started thus far for debug & stats.
+ * Return the number of RCU GPs completed thus far for debug & stats.
  */
-unsigned long rcu_batches_started(void)
+unsigned long rcu_get_gp_seq(void)
 {
-	return rcu_state_p->gpnum;
+	return rcu_seq_ctr(READ_ONCE(rcu_state_p->gp_seq));
 }
-EXPORT_SYMBOL_GPL(rcu_batches_started);
+EXPORT_SYMBOL_GPL(rcu_get_gp_seq);
 
 /*
- * Return the number of RCU-sched batches started thus far for debug & stats.
+ * Return the number of RCU-sched GPs completed thus far for debug & stats.
  */
-unsigned long rcu_batches_started_sched(void)
+unsigned long rcu_sched_get_gp_seq(void)
 {
-	return rcu_sched_state.gpnum;
+	return rcu_seq_ctr(READ_ONCE(rcu_sched_state.gp_seq));
 }
-EXPORT_SYMBOL_GPL(rcu_batches_started_sched);
+EXPORT_SYMBOL_GPL(rcu_sched_get_gp_seq);
 
 /*
- * Return the number of RCU BH batches started thus far for debug & stats.
+ * Return the number of RCU-bh GPs completed thus far for debug & stats.
  */
-unsigned long rcu_batches_started_bh(void)
+unsigned long rcu_bh_get_gp_seq(void)
 {
-	return rcu_bh_state.gpnum;
+	return rcu_seq_ctr(READ_ONCE(rcu_bh_state.gp_seq));
 }
-EXPORT_SYMBOL_GPL(rcu_batches_started_bh);
-
-/*
- * Return the number of RCU batches completed thus far for debug & stats.
- */
-unsigned long rcu_batches_completed(void)
-{
-	return rcu_state_p->completed;
-}
-EXPORT_SYMBOL_GPL(rcu_batches_completed);
-
-/*
- * Return the number of RCU-sched batches completed thus far for debug & stats.
- */
-unsigned long rcu_batches_completed_sched(void)
-{
-	return rcu_sched_state.completed;
-}
-EXPORT_SYMBOL_GPL(rcu_batches_completed_sched);
-
-/*
- * Return the number of RCU BH batches completed thus far for debug & stats.
- */
-unsigned long rcu_batches_completed_bh(void)
-{
-	return rcu_bh_state.completed;
-}
-EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);
+EXPORT_SYMBOL_GPL(rcu_bh_get_gp_seq);
 
 /*
  * Return the number of RCU expedited batches completed thus far for
-- 
2.17.1

