Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E484FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A788A208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A788A208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934593AbeGFFw1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:52:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33828 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934554AbeGFFwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:52:23 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34274B14;
        Fri,  6 Jul 2018 05:52:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 57/61] sched/core: Fix rules for running on online && !active CPUs
Date:   Fri,  6 Jul 2018 07:47:21 +0200
Message-Id: <20180706054714.517481938@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 175f0e25abeaa2218d431141ce19cf1de70fa82d ]

As already enforced by the WARN() in __set_cpus_allowed_ptr(), the rules
for running on an online && !active CPU are stricter than just being a
kthread, you need to be a per-cpu kthread.

If you're not strictly per-CPU, you have better CPUs to run on and
don't need the partially booted one to get your work done.

The exception is to allow smpboot threads to bootstrap the CPU itself
and get kernel 'services' initialized before we allow userspace on it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 955dbdf4ce87 ("sched: Allow migrating kthreads into online but inactive CPUs")
Link: http://lkml.kernel.org/r/20170725165821.cejhb7v2s3kecems@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c |   42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -894,6 +894,33 @@ void check_preempt_curr(struct rq *rq, s
 }
 
 #ifdef CONFIG_SMP
+
+static inline bool is_per_cpu_kthread(struct task_struct *p)
+{
+	if (!(p->flags & PF_KTHREAD))
+		return false;
+
+	if (p->nr_cpus_allowed != 1)
+		return false;
+
+	return true;
+}
+
+/*
+ * Per-CPU kthreads are allowed to run on !actie && online CPUs, see
+ * __set_cpus_allowed_ptr() and select_fallback_rq().
+ */
+static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
+{
+	if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+		return false;
+
+	if (is_per_cpu_kthread(p))
+		return cpu_online(cpu);
+
+	return cpu_active(cpu);
+}
+
 /*
  * This is how migration works:
  *
@@ -951,16 +978,8 @@ struct migration_arg {
 static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 				 struct task_struct *p, int dest_cpu)
 {
-	if (p->flags & PF_KTHREAD) {
-		if (unlikely(!cpu_online(dest_cpu)))
-			return rq;
-	} else {
-		if (unlikely(!cpu_active(dest_cpu)))
-			return rq;
-	}
-
 	/* Affinity changed (again). */
-	if (!cpumask_test_cpu(dest_cpu, &p->cpus_allowed))
+	if (!is_cpu_allowed(p, dest_cpu))
 		return rq;
 
 	update_rq_clock(rq);
@@ -1489,10 +1508,9 @@ static int select_fallback_rq(int cpu, s
 	for (;;) {
 		/* Any allowed, online CPU? */
 		for_each_cpu(dest_cpu, &p->cpus_allowed) {
-			if (!(p->flags & PF_KTHREAD) && !cpu_active(dest_cpu))
-				continue;
-			if (!cpu_online(dest_cpu))
+			if (!is_cpu_allowed(p, dest_cpu))
 				continue;
+
 			goto out;
 		}
 


