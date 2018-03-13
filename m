Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932776AbeCMKfw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:35:52 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33273 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932733AbeCMKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:35:50 -0400
X-Google-Smtp-Source: AG47ELtcgZyBsnZEyHxp1iKr2dyjoDFrIJAH8lRNtMKdNDOjGjrMrd9cPRPAJlv9mJjM5R8Oy6PwuA==
From: Claudio Scordino <claudio@evidence.eu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Claudio Scordino <claudio@evidence.eu.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Date: Tue, 13 Mar 2018 11:35:40 +0100
Message-Id: <1520937340-2755-1-git-send-email-claudio@evidence.eu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the SCHED_DEADLINE scheduling class increases the CPU utilization,
we should not wait for the rate limit, otherwise we may miss some
deadline.

Tests using rt-app on Exynos5422 with up to 10 SCHED_DEADLINE tasks have
shown reductions of even 10% of deadline misses with a negligible
increase of energy consumption (measured through Baylibre Cape).

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: Patrick Bellasi <patrick.bellasi@arm.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Morten Rasmussen <morten.rasmussen@arm.com>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Todd Kjos <tkjos@android.com>
CC: Joel Fernandes <joelaf@google.com>
CC: linux-pm@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
Changes from v3:
 - Specific routine renamed as ignore_dl_rate_limit()
---
Changes from v2:
 - Rate limit ignored also in case of "fast switch"
 - Specific routine added
---
Changes from v1:
 - Logic moved from sugov_should_update_freq() to
   sugov_update_single()/_shared() to not duplicate data structures
 - Rate limit not ignored in case of "fast switch"
---
 kernel/sched/cpufreq_schedutil.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index feb5f89..2aeb1ca 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -257,6 +257,16 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
 static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
 #endif /* CONFIG_NO_HZ_COMMON */
 
+/*
+ * Make sugov_should_update_freq() ignore the rate limit when DL
+ * has increased the utilization.
+ */
+static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
+{
+	if (cpu_util_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->util_dl)
+		sg_policy->need_freq_update = true;
+}
+
 static void sugov_update_single(struct update_util_data *hook, u64 time,
 				unsigned int flags)
 {
@@ -270,6 +280,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time);
 	sg_cpu->last_update = time;
 
+	ignore_dl_rate_limit(sg_cpu, sg_policy);
+
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
@@ -351,6 +363,8 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
 	raw_spin_lock(&sg_policy->update_lock);
 
+	ignore_dl_rate_limit(sg_cpu, sg_policy);
+
 	sugov_get_util(sg_cpu);
 	sg_cpu->flags = flags;
 
-- 
2.7.4
