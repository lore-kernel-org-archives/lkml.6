Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C267DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F25A26311
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F25A26311
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935361AbeFZAKs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:10:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934483AbeFZAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03lja079287
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:04 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96raktn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:04 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:03 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06w0F9699832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C756CB2067;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A15F8B206C;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B852216CA0B1; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 36/40] rcutorture: Correctly handle grace-period sequence wrap
Date:   Mon, 25 Jun 2018 17:08:55 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-2213-0000-0000-000002BFDECB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-2214-0000-0000-00005A9B953F
Message-Id: <20180626000859.23572-36-paulmck@linux.vnet.ibm.com>
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

The new ->gq_seq grace-period sequence numbers must be shifted down,
which give artifacts when these numbers wrap.  This commit therefore
enables rcutorture and rcuperf to handle grace-period sequence numbers
even if they do wrap.  It does this by allowing a special subtraction
function to be specified, and this function subtracts before shifting.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h        |  9 +++++++++
 kernel/rcu/rcuperf.c    | 18 ++++++++++++++++--
 kernel/rcu/rcutorture.c | 19 +++++++++++++------
 kernel/rcu/tree.c       |  6 +++---
 4 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 1c5cbd9d7c97..aa215d6355f8 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -142,6 +142,15 @@ static inline bool rcu_seq_new_gp(unsigned long old, unsigned long new)
 			    new);
 }
 
+/*
+ * Roughly how many full grace periods have elapsed between the collection
+ * of the two specified grace periods?
+ */
+static inline unsigned long rcu_seq_diff(unsigned long new, unsigned long old)
+{
+	return (new - old) >> RCU_SEQ_CTR_SHIFT;
+}
+
 /*
  * debug_rcu_head_queue()/debug_rcu_head_unqueue() are used internally
  * by call_rcu() and rcu callback execution, and are therefore not part of the
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 2b5a613afcf3..b080bc4a4f45 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -139,6 +139,7 @@ struct rcu_perf_ops {
 	int (*readlock)(void);
 	void (*readunlock)(int idx);
 	unsigned long (*get_gp_seq)(void);
+	unsigned long (*gp_diff)(unsigned long new, unsigned long old);
 	unsigned long (*exp_completed)(void);
 	void (*async)(struct rcu_head *head, rcu_callback_t func);
 	void (*gp_barrier)(void);
@@ -179,6 +180,7 @@ static struct rcu_perf_ops rcu_ops = {
 	.readlock	= rcu_perf_read_lock,
 	.readunlock	= rcu_perf_read_unlock,
 	.get_gp_seq	= rcu_get_gp_seq,
+	.gp_diff	= rcu_seq_diff,
 	.exp_completed	= rcu_exp_batches_completed,
 	.async		= call_rcu,
 	.gp_barrier	= rcu_barrier,
@@ -208,6 +210,7 @@ static struct rcu_perf_ops rcu_bh_ops = {
 	.readlock	= rcu_bh_perf_read_lock,
 	.readunlock	= rcu_bh_perf_read_unlock,
 	.get_gp_seq	= rcu_bh_get_gp_seq,
+	.gp_diff	= rcu_seq_diff,
 	.exp_completed	= rcu_exp_batches_completed_sched,
 	.async		= call_rcu_bh,
 	.gp_barrier	= rcu_barrier_bh,
@@ -264,6 +267,7 @@ static struct rcu_perf_ops srcu_ops = {
 	.readlock	= srcu_perf_read_lock,
 	.readunlock	= srcu_perf_read_unlock,
 	.get_gp_seq	= srcu_perf_completed,
+	.gp_diff	= rcu_seq_diff,
 	.exp_completed	= srcu_perf_completed,
 	.async		= srcu_call_rcu,
 	.gp_barrier	= srcu_rcu_barrier,
@@ -292,6 +296,7 @@ static struct rcu_perf_ops srcud_ops = {
 	.readlock	= srcu_perf_read_lock,
 	.readunlock	= srcu_perf_read_unlock,
 	.get_gp_seq	= srcu_perf_completed,
+	.gp_diff	= rcu_seq_diff,
 	.exp_completed	= srcu_perf_completed,
 	.async		= srcu_call_rcu,
 	.gp_barrier	= srcu_rcu_barrier,
@@ -321,6 +326,7 @@ static struct rcu_perf_ops sched_ops = {
 	.readlock	= sched_perf_read_lock,
 	.readunlock	= sched_perf_read_unlock,
 	.get_gp_seq	= rcu_sched_get_gp_seq,
+	.gp_diff	= rcu_seq_diff,
 	.exp_completed	= rcu_exp_batches_completed_sched,
 	.async		= call_rcu_sched,
 	.gp_barrier	= rcu_barrier_sched,
@@ -348,6 +354,7 @@ static struct rcu_perf_ops tasks_ops = {
 	.readlock	= tasks_perf_read_lock,
 	.readunlock	= tasks_perf_read_unlock,
 	.get_gp_seq	= rcu_no_completed,
+	.gp_diff	= rcu_seq_diff,
 	.async		= call_rcu_tasks,
 	.gp_barrier	= rcu_barrier_tasks,
 	.sync		= synchronize_rcu_tasks,
@@ -355,6 +362,13 @@ static struct rcu_perf_ops tasks_ops = {
 	.name		= "tasks"
 };
 
+static unsigned long rcuperf_seq_diff(unsigned long new, unsigned long old)
+{
+	if (!cur_ops->gp_diff)
+		return new - old;
+	return cur_ops->gp_diff(new, old);
+}
+
 static bool __maybe_unused torturing_tasks(void)
 {
 	return cur_ops == &tasks_ops;
@@ -577,8 +591,8 @@ rcu_perf_cleanup(void)
 			 t_rcu_perf_writer_finished -
 			 t_rcu_perf_writer_started,
 			 ngps,
-			 b_rcu_perf_writer_finished -
-			 b_rcu_perf_writer_started);
+			 rcuperf_seq_diff(b_rcu_perf_writer_finished,
+					  b_rcu_perf_writer_started));
 		for (i = 0; i < nrealwriters; i++) {
 			if (!writer_durations)
 				break;
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 81fb43530d64..0481c7286875 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -265,6 +265,7 @@ struct rcu_torture_ops {
 	void (*read_delay)(struct torture_random_state *rrsp);
 	void (*readunlock)(int idx);
 	unsigned long (*get_gp_seq)(void);
+	unsigned long (*gp_diff)(unsigned long new, unsigned long old);
 	void (*deferred_free)(struct rcu_torture *p);
 	void (*sync)(void);
 	void (*exp_sync)(void);
@@ -400,6 +401,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.read_delay	= rcu_read_delay,
 	.readunlock	= rcu_torture_read_unlock,
 	.get_gp_seq	= rcu_get_gp_seq,
+	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= rcu_torture_deferred_free,
 	.sync		= synchronize_rcu,
 	.exp_sync	= synchronize_rcu_expedited,
@@ -441,6 +443,7 @@ static struct rcu_torture_ops rcu_bh_ops = {
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= rcu_bh_torture_read_unlock,
 	.get_gp_seq	= rcu_bh_get_gp_seq,
+	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= rcu_bh_torture_deferred_free,
 	.sync		= synchronize_rcu_bh,
 	.exp_sync	= synchronize_rcu_bh_expedited,
@@ -646,6 +649,7 @@ static struct rcu_torture_ops sched_ops = {
 	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
 	.readunlock	= sched_torture_read_unlock,
 	.get_gp_seq	= rcu_sched_get_gp_seq,
+	.gp_diff	= rcu_seq_diff,
 	.deferred_free	= rcu_sched_torture_deferred_free,
 	.sync		= synchronize_sched,
 	.exp_sync	= synchronize_sched_expedited,
@@ -695,6 +699,13 @@ static struct rcu_torture_ops tasks_ops = {
 	.name		= "tasks"
 };
 
+static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
+{
+	if (!cur_ops->gp_diff)
+		return new - old;
+	return cur_ops->gp_diff(new, old);
+}
+
 static bool __maybe_unused torturing_tasks(void)
 {
 	return cur_ops == &tasks_ops;
@@ -1127,9 +1138,7 @@ static void rcu_torture_timer(struct timer_list *unused)
 		rcu_ftrace_dump(DUMP_ALL);
 	}
 	__this_cpu_inc(rcu_torture_count[pipe_count]);
-	completed = completed - started;
-	if (completed > ULONG_MAX >> 1)
-		completed = 0; /* Not all gp_seq have full range. */
+	completed = rcutorture_seq_diff(completed, started);
 	if (completed > RCU_TORTURE_PIPE_LEN) {
 		/* Should not happen, but... */
 		completed = RCU_TORTURE_PIPE_LEN;
@@ -1205,9 +1214,7 @@ rcu_torture_reader(void *arg)
 			rcu_ftrace_dump(DUMP_ALL);
 		}
 		__this_cpu_inc(rcu_torture_count[pipe_count]);
-		completed = completed - started;
-		if (completed > ULONG_MAX >> 1)
-			completed = 0; /* Not all gp_seq have full range. */
+		completed = rcutorture_seq_diff(completed, started);
 		if (completed > RCU_TORTURE_PIPE_LEN) {
 			/* Should not happen, but... */
 			completed = RCU_TORTURE_PIPE_LEN;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 446163b6feba..fa82f0413d2c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -532,7 +532,7 @@ static int rcu_pending(void);
  */
 unsigned long rcu_get_gp_seq(void)
 {
-	return rcu_seq_ctr(READ_ONCE(rcu_state_p->gp_seq));
+	return READ_ONCE(rcu_state_p->gp_seq);
 }
 EXPORT_SYMBOL_GPL(rcu_get_gp_seq);
 
@@ -541,7 +541,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_seq);
  */
 unsigned long rcu_sched_get_gp_seq(void)
 {
-	return rcu_seq_ctr(READ_ONCE(rcu_sched_state.gp_seq));
+	return READ_ONCE(rcu_sched_state.gp_seq);
 }
 EXPORT_SYMBOL_GPL(rcu_sched_get_gp_seq);
 
@@ -550,7 +550,7 @@ EXPORT_SYMBOL_GPL(rcu_sched_get_gp_seq);
  */
 unsigned long rcu_bh_get_gp_seq(void)
 {
-	return rcu_seq_ctr(READ_ONCE(rcu_bh_state.gp_seq));
+	return READ_ONCE(rcu_bh_state.gp_seq);
 }
 EXPORT_SYMBOL_GPL(rcu_bh_get_gp_seq);
 
-- 
2.17.1

