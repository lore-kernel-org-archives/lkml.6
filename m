Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71382C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAD820644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAD820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeH3Bqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:46:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727357AbeH3Bqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:46:51 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TLcqCk024966
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:59 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m637ygwfy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:59 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:47:57 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:47:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TLlpNe16253128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:47:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB18CB2067;
        Wed, 29 Aug 2018 17:46:47 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DF9CB2064;
        Wed, 29 Aug 2018 17:46:47 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 17:46:47 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A740016C91CA; Wed, 29 Aug 2018 14:47:51 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 06/17] rcutorture: Add forward-progress tests for RCU grace periods
Date:   Wed, 29 Aug 2018 14:47:39 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829214722.GA23411@linux.vnet.ibm.com>
References: <20180829214722.GA23411@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082921-0068-0000-0000-00000331B4F3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080727; UDB=6.00557487; IPR=6.00860713;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:47:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-0069-0000-0000-0000458EFD7B
Message-Id: <20180829214750.26972-6-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a kthread that loops going into and out of RCU
read-side critical sections, but also including a cond_resched(),
optionally guarded by a check of need_resched(), in that same loop.
This commit relies solely on rcu_torture_writer() progress to judge
the forward progress of grace periods.

Note that Tasks RCU and SRCU are exempted from forward-progress testing
due their (intentionally) less-robust forward-progress guarantees.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/rcutiny.h |  1 +
 kernel/rcu/rcutorture.c | 73 ++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/update.c     |  1 +
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 8d9a0ea8f0b5..a6353f3d6094 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -108,6 +108,7 @@ static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
  */
 static inline void rcu_virt_note_context_switch(int cpu) { }
 static inline void rcu_cpu_stall_reset(void) { }
+static inline int rcu_jiffies_till_stall_check(void) { return 21 * HZ; }
 static inline void rcu_idle_enter(void) { }
 static inline void rcu_idle_exit(void) { }
 static inline void rcu_irq_enter(void) { }
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5df2411f7aee..fd3ce6cc8eea 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -89,6 +89,12 @@ torture_param(int, fqs_duration, 0,
 	      "Duration of fqs bursts (us), 0 to disable");
 torture_param(int, fqs_holdoff, 0, "Holdoff time within fqs bursts (us)");
 torture_param(int, fqs_stutter, 3, "Wait time between fqs bursts (s)");
+torture_param(bool, fwd_progress, 1, "Test grace-period forward progress");
+torture_param(int, fwd_progress_div, 4, "Fraction of CPU stall to wait");
+torture_param(int, fwd_progress_holdoff, 60,
+	      "Time between forward-progress tests (s)");
+torture_param(bool, fwd_progress_need_resched, 1,
+	      "Hide cond_resched() behind need_resched()");
 torture_param(bool, gp_cond, false, "Use conditional/async GP wait primitives");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
 torture_param(bool, gp_normal, false,
@@ -137,6 +143,7 @@ static struct task_struct **cbflood_task;
 static struct task_struct *fqs_task;
 static struct task_struct *boost_tasks[NR_CPUS];
 static struct task_struct *stall_task;
+static struct task_struct *fwd_prog_task;
 static struct task_struct **barrier_cbs_tasks;
 static struct task_struct *barrier_task;
 
@@ -291,6 +298,7 @@ struct rcu_torture_ops {
 	void (*cb_barrier)(void);
 	void (*fqs)(void);
 	void (*stats)(void);
+	int (*stall_dur)(void);
 	int irq_capable;
 	int can_boost;
 	int extendables;
@@ -429,6 +437,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.cb_barrier	= rcu_barrier,
 	.fqs		= rcu_force_quiescent_state,
 	.stats		= NULL,
+	.stall_dur	= rcu_jiffies_till_stall_check,
 	.irq_capable	= 1,
 	.can_boost	= rcu_can_boost(),
 	.name		= "rcu"
@@ -1116,7 +1125,8 @@ rcu_torture_writer(void *arg)
 				break;
 			}
 		}
-		rcu_torture_current_version++;
+		WRITE_ONCE(rcu_torture_current_version,
+			   rcu_torture_current_version + 1);
 		/* Cycle through nesting levels of rcu_expedite_gp() calls. */
 		if (can_expedite &&
 		    !(torture_random(&rand) & 0xff & (!!expediting - 1))) {
@@ -1660,6 +1670,63 @@ static int __init rcu_torture_stall_init(void)
 	return torture_create_kthread(rcu_torture_stall, NULL, stall_task);
 }
 
+/* Carry out grace-period forward-progress testing. */
+static int rcu_torture_fwd_prog(void *args)
+{
+	unsigned long cvar;
+	int idx;
+	unsigned long stopat;
+	bool tested = false;
+
+	VERBOSE_TOROUT_STRING("rcu_torture_fwd_progress task started");
+	do {
+		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
+		cvar = READ_ONCE(rcu_torture_current_version);
+		stopat = jiffies + cur_ops->stall_dur() / fwd_progress_div;
+		while (time_before(jiffies, stopat) && !torture_must_stop()) {
+			idx = cur_ops->readlock();
+			udelay(10);
+			cur_ops->readunlock(idx);
+			if (!fwd_progress_need_resched || need_resched())
+				cond_resched();
+		}
+		if (!time_before(jiffies, stopat) && !torture_must_stop()) {
+			tested = true;
+			WARN_ON_ONCE(cvar ==
+				     READ_ONCE(rcu_torture_current_version));
+		}
+		/* Avoid slow periods, better to test when busy. */
+		stutter_wait("rcu_torture_fwd_prog");
+	} while (!torture_must_stop());
+	WARN_ON(!tested);
+	torture_kthread_stopping("rcu_torture_fwd_prog");
+	return 0;
+}
+
+/* If forward-progress checking is requested and feasible, spawn the thread. */
+static int __init rcu_torture_fwd_prog_init(void)
+{
+	if (!fwd_progress)
+		return 0; /* Not requested, so don't do it. */
+	if (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0) {
+		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test");
+		return 0;
+	}
+	if (stall_cpu > 0) {
+		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, conflicts with CPU-stall testing");
+		if (IS_MODULE(CONFIG_RCU_TORTURE_TESTS))
+			return -EINVAL; /* In module, can fail back to user. */
+		WARN_ON(1); /* Make sure rcutorture notices conflict. */
+		return 0;
+	}
+	if (fwd_progress_holdoff <= 0)
+		fwd_progress_holdoff = 1;
+	if (fwd_progress_div <= 0)
+		fwd_progress_div = 4;
+	return torture_create_kthread(rcu_torture_fwd_prog,
+				      NULL, fwd_prog_task);
+}
+
 /* Callback function for RCU barrier testing. */
 static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
 {
@@ -1833,6 +1900,7 @@ rcu_torture_cleanup(void)
 	}
 
 	rcu_torture_barrier_cleanup();
+	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
 	torture_stop_kthread(rcu_torture_stall, stall_task);
 	torture_stop_kthread(rcu_torture_writer, writer_task);
 
@@ -2104,6 +2172,9 @@ rcu_torture_init(void)
 	if (firsterr)
 		goto unwind;
 	firsterr = rcu_torture_stall_init();
+	if (firsterr)
+		goto unwind;
+	firsterr = rcu_torture_fwd_prog_init();
 	if (firsterr)
 		goto unwind;
 	firsterr = rcu_torture_barrier_init();
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 39cb23d22109..a6b860422d18 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -472,6 +472,7 @@ int rcu_jiffies_till_stall_check(void)
 	}
 	return till_stall_check * HZ + RCU_STALL_DELAY_DELTA;
 }
+EXPORT_SYMBOL_GPL(rcu_jiffies_till_stall_check);
 
 void rcu_sysrq_start(void)
 {
-- 
2.17.1

