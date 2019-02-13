Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EDDC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9AE222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391279AbfBMJF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:05:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46403 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfBMJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:05:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D95knt198397
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 01:05:46 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D95jo4198393;
        Wed, 13 Feb 2019 01:05:45 -0800
Date:   Wed, 13 Feb 2019 01:05:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Viresh Kumar <tipbot@zytor.com>
Message-ID: <tip-c89d92eddfad11e912fb506f85e1796064a9f9d2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        viresh.kumar@linaro.org, mingo@kernel.org,
        vincent.guittot@linaro.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          viresh.kumar@linaro.org
In-Reply-To: <2e2a10f84b9049a81eef94ed6d5989447c21e34a.1549963617.git.viresh.kumar@linaro.org>
References: <2e2a10f84b9049a81eef94ed6d5989447c21e34a.1549963617.git.viresh.kumar@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Use non-atomic
 cpumask_{set,clear}_cpu()
Git-Commit-ID: c89d92eddfad11e912fb506f85e1796064a9f9d2
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

Commit-ID:  c89d92eddfad11e912fb506f85e1796064a9f9d2
Gitweb:     https://git.kernel.org/tip/c89d92eddfad11e912fb506f85e1796064a9f9d2
Author:     Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate: Tue, 12 Feb 2019 14:57:01 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:34:13 +0100

sched/fair: Use non-atomic cpumask_{set,clear}_cpu()

The cpumasks updated here are not subject to concurrency and using
atomic bitops for them is pointless and expensive. Use the non-atomic
variants instead.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: http://lkml.kernel.org/r/2e2a10f84b9049a81eef94ed6d5989447c21e34a.1549963617.git.viresh.kumar@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c      | 6 +++---
 kernel/sched/isolation.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8abd1c271499..8213ff6e365d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6097,7 +6097,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		bool idle = true;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			cpumask_clear_cpu(cpu, cpus);
+			__cpumask_clear_cpu(cpu, cpus);
 			if (!available_idle_cpu(cpu))
 				idle = false;
 		}
@@ -9105,7 +9105,7 @@ more_balance:
 		if ((env.flags & LBF_DST_PINNED) && env.imbalance > 0) {
 
 			/* Prevent to re-select dst_cpu via env's CPUs */
-			cpumask_clear_cpu(env.dst_cpu, env.cpus);
+			__cpumask_clear_cpu(env.dst_cpu, env.cpus);
 
 			env.dst_rq	 = cpu_rq(env.new_dst_cpu);
 			env.dst_cpu	 = env.new_dst_cpu;
@@ -9132,7 +9132,7 @@ more_balance:
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
 		if (unlikely(env.flags & LBF_ALL_PINNED)) {
-			cpumask_clear_cpu(cpu_of(busiest), cpus);
+			__cpumask_clear_cpu(cpu_of(busiest), cpus);
 			/*
 			 * Attempting to continue load balancing at the current
 			 * sched_domain level only makes sense if there are
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 81faddba9e20..b02d148e7672 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -80,7 +80,7 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 		cpumask_andnot(housekeeping_mask,
 			       cpu_possible_mask, non_housekeeping_mask);
 		if (cpumask_empty(housekeeping_mask))
-			cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
+			__cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
 	} else {
 		cpumask_var_t tmp;
 
