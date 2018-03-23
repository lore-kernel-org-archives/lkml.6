Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeCWVwl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:52:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40867 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCWVwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:52:39 -0400
Date: Fri, 23 Mar 2018 14:51:49 -0700
From: tip-bot for Claudio Scordino <tipbot@zytor.com>
Message-ID: <tip-e97a90f7069b740575bcb1dae86596e0484b8957@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        mingo@kernel.org, morten.rasmussen@arm.com, patrick.bellasi@arm.com,
        rafael.j.wysocki@intel.com, vincent.guittot@linaro.org,
        peterz@infradead.org, claudio@evidence.eu.com, joelaf@google.com,
        hpa@zytor.com, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        tkjos@android.com, tglx@linutronix.de
Reply-To: morten.rasmussen@arm.com, mingo@kernel.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, joelaf@google.com,
        claudio@evidence.eu.com, peterz@infradead.org,
        vincent.guittot@linaro.org, patrick.bellasi@arm.com,
        rafael.j.wysocki@intel.com, tkjos@android.com, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <1520937340-2755-1-git-send-email-claudio@evidence.eu.com>
References: <1520937340-2755-1-git-send-email-claudio@evidence.eu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/cpufreq: Rate limits for SCHED_DEADLINE
Git-Commit-ID: e97a90f7069b740575bcb1dae86596e0484b8957
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e97a90f7069b740575bcb1dae86596e0484b8957
Gitweb:     https://git.kernel.org/tip/e97a90f7069b740575bcb1dae86596e0484b8957
Author:     Claudio Scordino <claudio@evidence.eu.com>
AuthorDate: Tue, 13 Mar 2018 11:35:40 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 23 Mar 2018 22:48:22 +0100

sched/cpufreq: Rate limits for SCHED_DEADLINE

When the SCHED_DEADLINE scheduling class increases the CPU utilization, it
should not wait for the rate limit, otherwise it may miss some deadline.

Tests using rt-app on Exynos5422 with up to 10 SCHED_DEADLINE tasks have
shown reductions of even 10% of deadline misses with a negligible
increase of energy consumption (measured through Baylibre Cape).

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lkml.kernel.org/r/1520937340-2755-1-git-send-email-claudio@evidence.eu.com
---
 kernel/sched/cpufreq_schedutil.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 89fe78ecb88c..2b124811947d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -267,6 +267,16 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
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
@@ -279,6 +289,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
+	ignore_dl_rate_limit(sg_cpu, sg_policy);
+
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
@@ -356,6 +368,8 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
+	ignore_dl_rate_limit(sg_cpu, sg_policy);
+
 	if (sugov_should_update_freq(sg_policy, time)) {
 		next_f = sugov_next_freq_shared(sg_cpu, time);
 		sugov_update_commit(sg_policy, time, next_f);
