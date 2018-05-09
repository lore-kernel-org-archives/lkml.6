Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934606AbeEIKfa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:35:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34960 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933864AbeEIKf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:35:28 -0400
X-Google-Smtp-Source: AB8JxZqRvJ/V5qsRzWtxazZkwquQyK29Ed+U9lBfPivbtif2cDVeP3I5k+hPb47Z5AMtLSQEDrJvhw==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] sched/schedutil: Don't set next_freq to UINT_MAX
Date: Wed,  9 May 2018 16:05:24 +0530
Message-Id: <dadd359a7fc0f719b9e95161b2ac469e1a3c70cc.1525861952.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <2276196.ev9rMjHTR0@aspire.rjw.lan>
References: <2276196.ev9rMjHTR0@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The schedutil driver sets sg_policy->next_freq to UINT_MAX on certain
occasions to discard the cached value of next freq:
- In sugov_start(), when the schedutil governor is started for a group
  of CPUs.
- And whenever we need to force a freq update before rate-limit
  duration, which happens when:
  - there is an update in cpufreq policy limits.
  - Or when the utilization of DL scheduling class increases.

In return, get_next_freq() doesn't return a cached next_freq value but
recalculates the next frequency instead.

But having special meaning for a particular value of frequency makes the
code less readable and error prone. We recently fixed a bug where the
UINT_MAX value was considered as valid frequency in
sugov_update_single().

All we need is a flag which can be used to discard the value of
sg_policy->next_freq and we already have need_freq_update for that. Lets
reuse it instead of setting next_freq to UINT_MAX.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Rebased over the fix sent by Rafael

  lkml.kernel.org/r/2276196.ev9rMjHTR0@aspire.rjw.lan

- Remove the additional check from sugov_update_single() as well.
- This is for 4.18 now instead of stable kernels.

 kernel/sched/cpufreq_schedutil.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e23e84724f39..daaca23697dc 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -95,15 +95,8 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	if (sg_policy->work_in_progress)
 		return false;
 
-	if (unlikely(sg_policy->need_freq_update)) {
-		sg_policy->need_freq_update = false;
-		/*
-		 * This happens when limits change, so forget the previous
-		 * next_freq value and force an update.
-		 */
-		sg_policy->next_freq = UINT_MAX;
+	if (unlikely(sg_policy->need_freq_update))
 		return true;
-	}
 
 	delta_ns = time - sg_policy->last_freq_update_time;
 
@@ -165,8 +158,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 	freq = (freq + (freq >> 2)) * util / max;
 
-	if (freq == sg_policy->cached_raw_freq && sg_policy->next_freq != UINT_MAX)
+	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
+
+	sg_policy->need_freq_update = false;
 	sg_policy->cached_raw_freq = freq;
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
@@ -305,8 +300,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
 	 */
-	if (busy && next_f < sg_policy->next_freq &&
-	    sg_policy->next_freq != UINT_MAX) {
+	if (busy && next_f < sg_policy->next_freq) {
 		next_f = sg_policy->next_freq;
 
 		/* Reset cached freq as next_freq has changed */
@@ -671,7 +665,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 
 	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time	= 0;
-	sg_policy->next_freq			= UINT_MAX;
+	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;
 	sg_policy->need_freq_update		= false;
 	sg_policy->cached_raw_freq		= 0;
-- 
2.15.0.194.g9af6a3dea062
