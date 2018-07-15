Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF44AECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932B22083D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932B22083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeGOXxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:53:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36599 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeGOXxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:53:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNSbui921387
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:28:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNSbUR921384;
        Sun, 15 Jul 2018 16:28:37 -0700
Date:   Sun, 15 Jul 2018 16:28:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-8cc90515a4fa419ccfc4703ff127699cdcb96839@git.kernel.org>
Cc:     hpa@zytor.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        viresh.kumar@linaro.org
Reply-To: linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
          hpa@zytor.com, viresh.kumar@linaro.org, peterz@infradead.org,
          mingo@kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org
In-Reply-To: <1530200714-4504-6-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-6-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] cpufreq/schedutil: Use DL utilization tracking
Git-Commit-ID: 8cc90515a4fa419ccfc4703ff127699cdcb96839
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

Commit-ID:  8cc90515a4fa419ccfc4703ff127699cdcb96839
Gitweb:     https://git.kernel.org/tip/8cc90515a4fa419ccfc4703ff127699cdcb96839
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 28 Jun 2018 17:45:08 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 15 Jul 2018 23:51:21 +0200

cpufreq/schedutil: Use DL utilization tracking

Now that we have both the DL class bandwidth requirement and the DL class
utilization, we can detect when CPU is fully used so we should run at max.
Otherwise, we keep using the DL bandwidth requirement to define the
utilization of the CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: claudio@evidence.eu.com
Cc: daniel.lezcano@linaro.org
Cc: dietmar.eggemann@arm.com
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: patrick.bellasi@arm.com
Cc: quentin.perret@arm.com
Cc: rjw@rjwysocki.net
Cc: valentin.schneider@arm.com
Link: http://lkml.kernel.org/r/1530200714-4504-6-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 23 +++++++++++++++++------
 kernel/sched/sched.h             |  7 ++++++-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index da29b5a33adb..07760bc7f69a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -56,6 +56,7 @@ struct sugov_cpu {
 	/* The fields below are only needed when sharing a policy: */
 	unsigned long		util_cfs;
 	unsigned long		util_dl;
+	unsigned long		bw_dl;
 	unsigned long		util_rt;
 	unsigned long		max;
 
@@ -187,6 +188,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 	sg_cpu->util_cfs = cpu_util_cfs(rq);
 	sg_cpu->util_dl  = cpu_util_dl(rq);
+	sg_cpu->bw_dl    = cpu_bw_dl(rq);
 	sg_cpu->util_rt  = cpu_util_rt(rq);
 }
 
@@ -198,20 +200,29 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	if (rt_rq_is_runnable(&rq->rt))
 		return sg_cpu->max;
 
-	util = sg_cpu->util_dl;
-	util += sg_cpu->util_cfs;
+	util = sg_cpu->util_cfs;
 	util += sg_cpu->util_rt;
 
+	if ((util + sg_cpu->util_dl) >= sg_cpu->max)
+		return sg_cpu->max;
+
 	/*
-	 * Utilization required by DEADLINE must always be granted while, for
-	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
-	 * gracefully reduce the frequency when no tasks show up for longer
+	 * As there is still idle time on the CPU, we need to compute the
+	 * utilization level of the CPU.
+	 *
+	 * Bandwidth required by DEADLINE must always be granted while, for
+	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
+	 * to gracefully reduce the frequency when no tasks show up for longer
 	 * periods of time.
 	 *
 	 * Ideally we would like to set util_dl as min/guaranteed freq and
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
+
+	/* Add DL bandwidth requirement */
+	util += sg_cpu->bw_dl;
+
 	return min(sg_cpu->max, util);
 }
 
@@ -367,7 +378,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
  */
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
 {
-	if (cpu_util_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->util_dl)
+	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
 		sg_policy->need_freq_update = true;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ab8b5296b5f6..9028f268f867 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2199,11 +2199,16 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif
 
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
-static inline unsigned long cpu_util_dl(struct rq *rq)
+static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
 }
 
+static inline unsigned long cpu_util_dl(struct rq *rq)
+{
+	return READ_ONCE(rq->avg_dl.util_avg);
+}
+
 static inline unsigned long cpu_util_cfs(struct rq *rq)
 {
 	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
