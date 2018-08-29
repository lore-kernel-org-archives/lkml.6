Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB67C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E440C2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E440C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeH3DG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:06:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727597AbeH3DG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:06:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TN3nRt139868
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:44 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m62g7vhra-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:44 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 19:07:44 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 19:07:38 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TN7bwO26148972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 23:07:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D8E0B2071;
        Wed, 29 Aug 2018 19:06:33 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A2AEB2065;
        Wed, 29 Aug 2018 19:06:33 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 39ED916C91CA; Wed, 29 Aug 2018 16:07:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 06/10] rcu: Switch urgent quiescent-state requests to rcu_data structure
Date:   Wed, 29 Aug 2018 16:07:31 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829230715.GA9431@linux.vnet.ibm.com>
References: <20180829230715.GA9431@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082923-2213-0000-0000-000002E50ACE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080754; UDB=6.00557503; IPR=6.00860739;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 23:07:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082923-2214-0000-0000-00005B603BD5
Message-Id: <20180829230735.10256-6-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes ->rcu_need_heavy_qs and ->rcu_urgent_qs from the
rcu_dynticks structure and updates the code to access them from the
rcu_data structure.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 12 ++++++------
 kernel/rcu/tree.h        |  2 --
 kernel/rcu/tree_exp.h    |  2 +-
 kernel/rcu/tree_plugin.h | 14 +++++++-------
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 70f760f28432..44f5e0a99e5a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -362,7 +362,7 @@ static void __maybe_unused rcu_momentary_dyntick_idle(void)
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	int special;
 
-	raw_cpu_write(rcu_dynticks.rcu_need_heavy_qs, false);
+	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
 	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR, &rdtp->dynticks);
 	/* It is illegal to call this from idle state. */
 	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
@@ -927,7 +927,7 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 	cpu = task_cpu(t);
 	if (!task_curr(t))
 		return; /* This task is not running on that CPU. */
-	smp_store_release(per_cpu_ptr(&rcu_dynticks.rcu_urgent_qs, cpu), true);
+	smp_store_release(per_cpu_ptr(&rcu_data.rcu_urgent_qs, cpu), true);
 }
 
 #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU)
@@ -1080,8 +1080,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * is set way high.
 	 */
 	jtsq = READ_ONCE(jiffies_to_sched_qs);
-	ruqp = per_cpu_ptr(&rcu_dynticks.rcu_urgent_qs, rdp->cpu);
-	rnhqp = &per_cpu(rcu_dynticks.rcu_need_heavy_qs, rdp->cpu);
+	ruqp = per_cpu_ptr(&rcu_data.rcu_urgent_qs, rdp->cpu);
+	rnhqp = &per_cpu(rcu_data.rcu_need_heavy_qs, rdp->cpu);
 	if (!READ_ONCE(*rnhqp) &&
 	    (time_after(jiffies, rcu_state.gp_start + jtsq * 2) ||
 	     time_after(jiffies, rcu_state.jiffies_resched))) {
@@ -2498,13 +2498,13 @@ void rcu_check_callbacks(int user)
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
 	raw_cpu_inc(rcu_data.ticks_this_gp);
 	/* The load-acquire pairs with the store-release setting to true. */
-	if (smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs))) {
+	if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
 		/* Idle and userspace execution already are quiescent states. */
 		if (!rcu_is_cpu_rrupt_from_idle() && !user) {
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 		}
-		__this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
+		__this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	}
 	rcu_flavor_check_callbacks(user);
 	if (rcu_pending())
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 36a47c7bd882..4c31066ddb94 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -41,8 +41,6 @@ struct rcu_dynticks {
 	long dynticks_nesting;      /* Track process nesting level. */
 	long dynticks_nmi_nesting;  /* Track irq/NMI nesting level. */
 	atomic_t dynticks;	    /* Even value for idle, else odd. */
-	bool rcu_need_heavy_qs;     /* GP old, need heavy quiescent state. */
-	bool rcu_urgent_qs;	    /* GP old need light quiescent state. */
 };
 
 /* Communicate arguments to a workqueue handler. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 030df96e0d3c..11387fcd4d85 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -780,7 +780,7 @@ static void sync_sched_exp_handler(void *unused)
 	}
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
 	/* Store .exp before .rcu_urgent_qs. */
-	smp_store_release(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs), true);
+	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
 	set_tsk_need_resched(current);
 	set_preempt_need_resched();
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b5aeb2fe4cfe..161760957a07 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -967,17 +967,17 @@ void rcu_all_qs(void)
 {
 	unsigned long flags;
 
-	if (!raw_cpu_read(rcu_dynticks.rcu_urgent_qs))
+	if (!raw_cpu_read(rcu_data.rcu_urgent_qs))
 		return;
 	preempt_disable();
 	/* Load rcu_urgent_qs before other flags. */
-	if (!smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs))) {
+	if (!smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
 		preempt_enable();
 		return;
 	}
-	this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
+	this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	barrier(); /* Avoid RCU read-side critical sections leaking down. */
-	if (unlikely(raw_cpu_read(rcu_dynticks.rcu_need_heavy_qs))) {
+	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
 		local_irq_save(flags);
 		rcu_momentary_dyntick_idle();
 		local_irq_restore(flags);
@@ -997,10 +997,10 @@ void rcu_note_context_switch(bool preempt)
 	trace_rcu_utilization(TPS("Start context switch"));
 	rcu_qs();
 	/* Load rcu_urgent_qs before other flags. */
-	if (!smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs)))
+	if (!smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs)))
 		goto out;
-	this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
-	if (unlikely(raw_cpu_read(rcu_dynticks.rcu_need_heavy_qs)))
+	this_cpu_write(rcu_data.rcu_urgent_qs, false);
+	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs)))
 		rcu_momentary_dyntick_idle();
 	if (!preempt)
 		rcu_tasks_qs(current);
-- 
2.17.1

