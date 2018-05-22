Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeEVKBx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:01:53 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43320 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeEVKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:01:49 -0400
X-Google-Smtp-Source: AB8JxZouBJx+SFCO29y4jrvA12Z3GaWGlhk5Vg44U7fTLGMBvLD+y4/rUqjbeuJHh0bkeIiZqtl2qw==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Rename cpufreq_can_do_remote_dvfs()
Date: Tue, 22 May 2018 15:31:30 +0530
Message-Id: <17700bd99bc34e4e189b94b417591f328005ffbf.1526983276.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine checks if the CPU running this code belongs to the policy
of the target CPU or if not, can it do remote DVFS for it remotely. But
the current name of it implies as if it is only about doing remote
updates.

Rename it to make it more relevant.

Reported-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 2 +-
 include/linux/cpufreq.h            | 2 +-
 kernel/sched/cpufreq_schedutil.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index ca38229b045a..871bf9cf55cf 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -278,7 +278,7 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 	u64 delta_ns, lst;
 
-	if (!cpufreq_can_do_remote_dvfs(policy_dbs->policy))
+	if (!cpufreq_this_cpu_can_update(policy_dbs->policy))
 		return;
 
 	/*
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 87f48dd932eb..882a9b9e34bc 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -571,7 +571,7 @@ struct governor_attr {
 			 size_t count);
 };
 
-static inline bool cpufreq_can_do_remote_dvfs(struct cpufreq_policy *policy)
+static inline bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy)
 {
 	/*
 	 * Allow remote callbacks if:
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2442decbfec7..2145655dbd9e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -89,7 +89,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	 * schedule the kthread.
 	 */
 	if (sg_policy->policy->fast_switch_enabled &&
-	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
+	    !cpufreq_this_cpu_can_update(sg_policy->policy))
 		return false;
 
 	if (sg_policy->work_in_progress)
-- 
2.15.0.194.g9af6a3dea062
