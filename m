Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeBHRB7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:01:59 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41779 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:01:57 -0500
X-Google-Smtp-Source: AH8x224evjmFeRuwPtgbSRslDrvtDNzhuC1/5JVvBsTb1ZgJh2hxh+QRfjE0CmRN4P3fYBhXCCWfow==
From: Claudio Scordino <claudio@evidence.eu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Claudio Scordino <claudio@evidence.eu.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Date: Thu,  8 Feb 2018 18:01:42 +0100
Message-Id: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the SCHED_DEADLINE scheduling class increases the CPU utilization,
we should not wait for the rate limit, otherwise we may miss some deadline.

Tests using rt-app on Exynos5422 have shown reductions of about 10% of deadline
misses for tasks with low RT periods.

The patch applies on top of the one recently proposed by Peter to drop the
SCHED_CPUFREQ_* flags.

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
CC: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
CC: Patrick Bellasi <patrick.bellasi@arm.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Morten Rasmussen <morten.rasmussen@arm.com>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Todd Kjos <tkjos@android.com>
CC: Joel Fernandes <joelaf@google.com>
CC: linux-pm@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index b0bd77d..d8dcba2 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -74,7 +74,10 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
-static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
+static bool sugov_should_update_freq(struct sugov_policy *sg_policy,
+				     u64 time,
+				     struct sugov_cpu *sg_cpu_old,
+				     struct sugov_cpu *sg_cpu_new)
 {
 	s64 delta_ns;
 
@@ -111,6 +114,10 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 		return true;
 	}
 
+	/* Ignore rate limit when DL increased utilization. */
+	if (sg_cpu_new->util_dl > sg_cpu_old->util_dl)
+		return true;
+
 	delta_ns = time - sg_policy->last_freq_update_time;
 	return delta_ns >= sg_policy->freq_update_delay_ns;
 }
@@ -271,6 +278,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 				unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	struct sugov_cpu sg_cpu_old = *sg_cpu;
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned long util, max;
 	unsigned int next_f;
@@ -279,7 +287,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	if (!sugov_should_update_freq(sg_policy, time))
+	if (!sugov_should_update_freq(sg_policy, time, &sg_cpu_old, sg_cpu))
 		return;
 
 	busy = sugov_cpu_is_busy(sg_cpu);
@@ -350,6 +358,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 				unsigned int flags)
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
+	struct sugov_cpu sg_cpu_old = *sg_cpu;
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	unsigned int next_f;
 
@@ -359,7 +368,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
-	if (sugov_should_update_freq(sg_policy, time)) {
+	if (sugov_should_update_freq(sg_policy, time, &sg_cpu_old, sg_cpu)) {
 		next_f = sugov_next_freq_shared(sg_cpu, time);
 		sugov_update_commit(sg_policy, time, next_f);
 	}
-- 
2.7.4
