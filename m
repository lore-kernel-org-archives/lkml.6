Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E41C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C924C2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH5+rigi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C924C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389129AbeK3Bg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388410AbeK3Bg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 499FC213A2;
        Thu, 29 Nov 2018 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501884;
        bh=9tAUdfqXACG9zEftg+skvYofyXHrZ2lRv4kJa3RWWOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UH5+rigi4vCagtTwybBmPFW1z4plR7wSFw5zNo436rhEKb9aUZrDdIgzhM3r4j99E
         vQV6dvR6QQzHLf7QuexTaGRJhmUqRT8J+rkUIT+qr0iPzoMFW9t4y0pl+TthOR4XE4
         WowbImpGytYLiaiI1zB+BUT6umDeauLQcIxWXbS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 080/110] sched/fair: Fix cpu_util_wake() for execl type workloads
Date:   Thu, 29 Nov 2018 15:12:51 +0100
Message-Id: <20181129135924.486138879@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c469933e772132aad040bd6a2adc8edf9ad6f825 ]

A ~10% regression has been reported for UnixBench's execl throughput
test by Aaron Lu and Ye Xiaolong:

  https://lkml.org/lkml/2018/10/30/765

That test is pretty simple, it does a "recursive" execve() syscall on the
same binary. Starting from the syscall, this sequence is possible:

   do_execve()
     do_execveat_common()
       __do_execve_file()
         sched_exec()
           select_task_rq_fair()          <==| Task already enqueued
             find_idlest_cpu()
               find_idlest_group()
                 capacity_spare_wake()    <==| Functions not called from
		   cpu_util_wake()           | the wakeup path

which means we can end up calling cpu_util_wake() not only from the
"wakeup path", as its name would suggest. Indeed, the task doing an
execve() syscall is already enqueued on the CPU we want to get the
cpu_util_wake() for.

The estimated utilization for a CPU computed in cpu_util_wake() was
written under the assumption that function can be called only from the
wakeup path. If instead the task is already enqueued, we end up with a
utilization which does not remove the current task's contribution from
the estimated utilization of the CPU.
This will wrongly assume a reduced spare capacity on the current CPU and
increase the chances to migrate the task on execve.

The regression is tracked down to:

 commit d519329f72a6 ("sched/fair: Update util_est only on util_avg updates")

because in that patch we turn on by default the UTIL_EST sched feature.
However, the real issue is introduced by:

 commit f9be3e5961c5 ("sched/fair: Use util_est in LB and WU paths")

Let's fix this by ensuring to always discount the task estimated
utilization from the CPU's estimated utilization when the task is also
the current one. The same benchmark of the bug report, executed on a
dual socket 40 CPUs Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz machine,
reports these "Execl Throughput" figures (higher the better):

   mainline     : 48136.5 lps
   mainline+fix : 55376.5 lps

which correspond to a 15% speedup.

Moreover, since {cpu_util,capacity_spare}_wake() are not really only
used from the wakeup path, let's remove this ambiguity by using a better
matching name: {cpu_util,capacity_spare}_without().

Since we are at that, let's also improve the existing documentation.

Reported-by: Aaron Lu <aaron.lu@intel.com>
Reported-by: Ye Xiaolong <xiaolong.ye@intel.com>
Tested-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Fixes: f9be3e5961c5 (sched/fair: Use util_est in LB and WU paths)
Link: https://lore.kernel.org/lkml/20181025093100.GB13236@e110439-lin/
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 62 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 908c9cdae2f0..1162552dc3cc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5672,11 +5672,11 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	return target;
 }
 
-static unsigned long cpu_util_wake(int cpu, struct task_struct *p);
+static unsigned long cpu_util_without(int cpu, struct task_struct *p);
 
-static unsigned long capacity_spare_wake(int cpu, struct task_struct *p)
+static unsigned long capacity_spare_without(int cpu, struct task_struct *p)
 {
-	return max_t(long, capacity_of(cpu) - cpu_util_wake(cpu, p), 0);
+	return max_t(long, capacity_of(cpu) - cpu_util_without(cpu, p), 0);
 }
 
 /*
@@ -5736,7 +5736,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 
 			avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
 
-			spare_cap = capacity_spare_wake(i, p);
+			spare_cap = capacity_spare_without(i, p);
 
 			if (spare_cap > max_spare_cap)
 				max_spare_cap = spare_cap;
@@ -5887,8 +5887,8 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 		return prev_cpu;
 
 	/*
-	 * We need task's util for capacity_spare_wake, sync it up to prev_cpu's
-	 * last_update_time.
+	 * We need task's util for capacity_spare_without, sync it up to
+	 * prev_cpu's last_update_time.
 	 */
 	if (!(sd_flag & SD_BALANCE_FORK))
 		sync_entity_load_avg(&p->se);
@@ -6214,10 +6214,19 @@ static inline unsigned long cpu_util(int cpu)
 }
 
 /*
- * cpu_util_wake: Compute CPU utilization with any contributions from
- * the waking task p removed.
+ * cpu_util_without: compute cpu utilization without any contributions from *p
+ * @cpu: the CPU which utilization is requested
+ * @p: the task which utilization should be discounted
+ *
+ * The utilization of a CPU is defined by the utilization of tasks currently
+ * enqueued on that CPU as well as tasks which are currently sleeping after an
+ * execution on that CPU.
+ *
+ * This method returns the utilization of the specified CPU by discounting the
+ * utilization of the specified task, whenever the task is currently
+ * contributing to the CPU utilization.
  */
-static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
+static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 {
 	struct cfs_rq *cfs_rq;
 	unsigned int util;
@@ -6229,7 +6238,7 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 	cfs_rq = &cpu_rq(cpu)->cfs;
 	util = READ_ONCE(cfs_rq->avg.util_avg);
 
-	/* Discount task's blocked util from CPU's util */
+	/* Discount task's util from CPU's util */
 	util -= min_t(unsigned int, util, task_util(p));
 
 	/*
@@ -6238,14 +6247,14 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 	 * a) if *p is the only task sleeping on this CPU, then:
 	 *      cpu_util (== task_util) > util_est (== 0)
 	 *    and thus we return:
-	 *      cpu_util_wake = (cpu_util - task_util) = 0
+	 *      cpu_util_without = (cpu_util - task_util) = 0
 	 *
 	 * b) if other tasks are SLEEPING on this CPU, which is now exiting
 	 *    IDLE, then:
 	 *      cpu_util >= task_util
 	 *      cpu_util > util_est (== 0)
 	 *    and thus we discount *p's blocked utilization to return:
-	 *      cpu_util_wake = (cpu_util - task_util) >= 0
+	 *      cpu_util_without = (cpu_util - task_util) >= 0
 	 *
 	 * c) if other tasks are RUNNABLE on that CPU and
 	 *      util_est > cpu_util
@@ -6258,8 +6267,33 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 	 * covered by the following code when estimated utilization is
 	 * enabled.
 	 */
-	if (sched_feat(UTIL_EST))
-		util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));
+	if (sched_feat(UTIL_EST)) {
+		unsigned int estimated =
+			READ_ONCE(cfs_rq->avg.util_est.enqueued);
+
+		/*
+		 * Despite the following checks we still have a small window
+		 * for a possible race, when an execl's select_task_rq_fair()
+		 * races with LB's detach_task():
+		 *
+		 *   detach_task()
+		 *     p->on_rq = TASK_ON_RQ_MIGRATING;
+		 *     ---------------------------------- A
+		 *     deactivate_task()                   \
+		 *       dequeue_task()                     + RaceTime
+		 *         util_est_dequeue()              /
+		 *     ---------------------------------- B
+		 *
+		 * The additional check on "current == p" it's required to
+		 * properly fix the execl regression and it helps in further
+		 * reducing the chances for the above race.
+		 */
+		if (unlikely(task_on_rq_queued(p) || current == p)) {
+			estimated -= min_t(unsigned int, estimated,
+					   (_task_util_est(p) | UTIL_AVG_UNCHANGED));
+		}
+		util = max(util, estimated);
+	}
 
 	/*
 	 * Utilization (estimated) can exceed the CPU capacity, thus let's
-- 
2.17.1



