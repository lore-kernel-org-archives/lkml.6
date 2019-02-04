Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0138C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5F6214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfBDJBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:01:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59717 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDJBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:01:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1491NpY358874
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 01:01:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1491M51358871;
        Mon, 4 Feb 2019 01:01:22 -0800
Date:   Mon, 4 Feb 2019 01:01:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-10a35e6812aa0953f02a956c499d23fe4e68af4a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, efault@gmx.de, tglx@linutronix.de,
        patrick.bellasi@arm.com, mingo@kernel.org, peterz@infradead.org,
        hpa@zytor.com
Reply-To: efault@gmx.de, tglx@linutronix.de, patrick.bellasi@arm.com,
          mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
          torvalds@linux-foundation.org
In-Reply-To: <1548257214-13745-4-git-send-email-vincent.guittot@linaro.org>
References: <1548257214-13745-4-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/pelt: Skip updating util_est when
 utilization is higher than CPU's capacity
Git-Commit-ID: 10a35e6812aa0953f02a956c499d23fe4e68af4a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  10a35e6812aa0953f02a956c499d23fe4e68af4a
Gitweb:     https://git.kernel.org/tip/10a35e6812aa0953f02a956c499d23fe4e68af4a
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Wed, 23 Jan 2019 16:26:54 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 09:13:21 +0100

sched/pelt: Skip updating util_est when utilization is higher than CPU's capacity

util_est is mainly meant to be a lower-bound for tasks utilization.
That's why task_util_est() returns the actual util_avg when it's higher
than the estimated utilization.

With new invaraince signal and without any special check on samples
collection, if a task is limited because of thermal capping for
example, we could end up overestimating its utilization and thus
perhaps generating an unwanted frequency spike when the capping is
relaxed... and (even worst) it will take some more activations for the
estimated utilization to converge back to the actual utilization.

Since we cannot easily know if there is idle time in a CPU when a task
completes an activation with a utilization higher then the CPU capacity,
we skip the sampling when utilization is higher than CPU's capacity.

Suggested-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bsegall@google.com
Cc: dietmar.eggemann@arm.com
Cc: pjt@google.com
Cc: pkondeti@codeaurora.org
Cc: quentin.perret@arm.com
Cc: rjw@rjwysocki.net
Cc: srinivas.pandruvada@linux.intel.com
Cc: thara.gopinath@linaro.org
Link: https://lkml.kernel.org/r/1548257214-13745-4-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 14 +++++++++-----
 kernel/sched/sched.h |  7 +++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f41f2eec6186..8c165f0d33b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3638,6 +3638,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 {
 	long last_ewma_diff;
 	struct util_est ue;
+	int cpu;
 
 	if (!sched_feat(UTIL_EST))
 		return;
@@ -3671,6 +3672,14 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
 		return;
 
+	/*
+	 * To avoid overestimation of actual task utilization, skip updates if
+	 * we cannot grant there is idle time in this CPU.
+	 */
+	cpu = cpu_of(rq_of(cfs_rq));
+	if (task_util(p) > capacity_orig_of(cpu))
+		return;
+
 	/*
 	 * Update Task's estimated utilization
 	 *
@@ -5542,11 +5551,6 @@ static unsigned long capacity_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity;
 }
 
-static unsigned long capacity_orig_of(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_orig;
-}
-
 static unsigned long cpu_avg_load_per_task(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fe31bc472f3e..99e2a7772d16 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2230,6 +2230,13 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 # define arch_scale_freq_invariant()	false
 #endif
 
+#ifdef CONFIG_SMP
+static inline unsigned long capacity_orig_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_orig;
+}
+#endif
+
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
 /**
  * enum schedutil_type - CPU utilization type
