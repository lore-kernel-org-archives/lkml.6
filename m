Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6EBC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1F020672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1F020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeLKPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:38:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51487 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLKPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:38:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFcTtn4043326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:38:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFcTCi4043322;
        Tue, 11 Dec 2018 07:38:29 -0800
Date:   Tue, 11 Dec 2018 07:38:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Quentin Perret <tipbot@zytor.com>
Message-ID: <tip-390031e4c309c94ecc07a558187eb5185200df83@git.kernel.org>
Cc:     quentin.perret@arm.com, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        efault@gmx.de
Reply-To: mingo@kernel.org, quentin.perret@arm.com, peterz@infradead.org,
          efault@gmx.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20181203095628.11858-14-quentin.perret@arm.com>
References: <20181203095628.11858-14-quentin.perret@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Introduce an energy estimation helper
 function
Git-Commit-ID: 390031e4c309c94ecc07a558187eb5185200df83
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

Commit-ID:  390031e4c309c94ecc07a558187eb5185200df83
Gitweb:     https://git.kernel.org/tip/390031e4c309c94ecc07a558187eb5185200df83
Author:     Quentin Perret <quentin.perret@arm.com>
AuthorDate: Mon, 3 Dec 2018 09:56:26 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 15:17:02 +0100

sched/fair: Introduce an energy estimation helper function

In preparation for the definition of an energy-aware wakeup path,
introduce a helper function to estimate the consequence on system energy
when a specific task wakes-up on a specific CPU. compute_energy()
estimates the capacity state to be reached by all performance domains
and estimates the consumption of each online CPU according to its Energy
Model and its percentage of busy time.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: adharmap@codeaurora.org
Cc: chris.redpath@arm.com
Cc: currojerez@riseup.net
Cc: dietmar.eggemann@arm.com
Cc: edubezval@gmail.com
Cc: gregkh@linuxfoundation.org
Cc: javi.merino@kernel.org
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: morten.rasmussen@arm.com
Cc: patrick.bellasi@arm.com
Cc: pkondeti@codeaurora.org
Cc: rjw@rjwysocki.net
Cc: skannan@codeaurora.org
Cc: smuckle@google.com
Cc: srinivas.pandruvada@linux.intel.com
Cc: thara.gopinath@linaro.org
Cc: tkjos@google.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Cc: viresh.kumar@linaro.org
Link: https://lkml.kernel.org/r/20181203095628.11858-14-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 767e7675774b..b3c94584d947 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6377,6 +6377,82 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	return !task_fits_capacity(p, min_cap);
 }
 
+/*
+ * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
+ * to @dst_cpu.
+ */
+static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
+{
+	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
+	unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
+
+	/*
+	 * If @p migrates from @cpu to another, remove its contribution. Or,
+	 * if @p migrates from another CPU to @cpu, add its contribution. In
+	 * the other cases, @cpu is not impacted by the migration, so the
+	 * util_avg should already be correct.
+	 */
+	if (task_cpu(p) == cpu && dst_cpu != cpu)
+		sub_positive(&util, task_util(p));
+	else if (task_cpu(p) != cpu && dst_cpu == cpu)
+		util += task_util(p);
+
+	if (sched_feat(UTIL_EST)) {
+		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+
+		/*
+		 * During wake-up, the task isn't enqueued yet and doesn't
+		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
+		 * so just add it (if needed) to "simulate" what will be
+		 * cpu_util() after the task has been enqueued.
+		 */
+		if (dst_cpu == cpu)
+			util_est += _task_util_est(p);
+
+		util = max(util, util_est);
+	}
+
+	return min(util, capacity_orig_of(cpu));
+}
+
+/*
+ * compute_energy(): Estimates the energy that would be consumed if @p was
+ * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
+ * landscape of the * CPUs after the task migration, and uses the Energy Model
+ * to compute what would be the energy if we decided to actually migrate that
+ * task.
+ */
+static long
+compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
+{
+	long util, max_util, sum_util, energy = 0;
+	int cpu;
+
+	for (; pd; pd = pd->next) {
+		max_util = sum_util = 0;
+		/*
+		 * The capacity state of CPUs of the current rd can be driven by
+		 * CPUs of another rd if they belong to the same performance
+		 * domain. So, account for the utilization of these CPUs too
+		 * by masking pd with cpu_online_mask instead of the rd span.
+		 *
+		 * If an entire performance domain is outside of the current rd,
+		 * it will not appear in its pd list and will not be accounted
+		 * by compute_energy().
+		 */
+		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
+			util = cpu_util_next(cpu, p, dst_cpu);
+			util = schedutil_energy_util(cpu, util);
+			max_util = max(util, max_util);
+			sum_util += util;
+		}
+
+		energy += em_pd_energy(pd->em_pd, max_util, sum_util);
+	}
+
+	return energy;
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
