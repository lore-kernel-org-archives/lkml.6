Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeERIZB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:25:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeERIY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:24:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68E8160F74
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
From: Saravana Kannan <skannan@codeaurora.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "cpufreq: Remove policy create/remove notifiers"
Date: Fri, 18 May 2018 01:24:47 -0700
Message-Id: <1526631889-5084-2-git-send-email-skannan@codeaurora.org>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
References: <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f9f41e3ef99ac9d4e91b07634362e393fb929aad.

Change-Id: Iddde3ef56c9e5b14dcb14f8737899b85e56f5b43
---
 drivers/cpufreq/cpufreq.c | 16 +++++++++++-----
 include/linux/cpufreq.h   |  3 +++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 075d18f..f790686 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1129,11 +1129,15 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	return NULL;
 }
 
-static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
+static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
 {
 	struct kobject *kobj;
 	struct completion *cmp;
 
+	if (notify)
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+					     CPUFREQ_REMOVE_POLICY, policy);
+
 	down_write(&policy->rwsem);
 	cpufreq_stats_free_table(policy);
 	kobj = &policy->kobj;
@@ -1151,7 +1155,7 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
 	pr_debug("wait complete\n");
 }
 
-static void cpufreq_policy_free(struct cpufreq_policy *policy)
+static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
 {
 	unsigned long flags;
 	int cpu;
@@ -1164,7 +1168,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	cpufreq_policy_put_kobj(policy);
+	cpufreq_policy_put_kobj(policy, notify);
 	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
@@ -1296,6 +1300,8 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_destroy_policy;
 
 		cpufreq_stats_create_table(policy);
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+				CPUFREQ_CREATE_POLICY, policy);
 
 		write_lock_irqsave(&cpufreq_driver_lock, flags);
 		list_add(&policy->policy_list, &cpufreq_policy_list);
@@ -1334,7 +1340,7 @@ static int cpufreq_online(unsigned int cpu)
 		cpufreq_driver->exit(policy);
 
 out_free_policy:
-	cpufreq_policy_free(policy);
+	cpufreq_policy_free(policy, !new_policy);
 	return ret;
 }
 
@@ -1447,7 +1453,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	remove_cpu_dev_symlink(policy, dev);
 
 	if (cpumask_empty(policy->real_cpus))
-		cpufreq_policy_free(policy);
+		cpufreq_policy_free(policy, true);
 }
 
 /**
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 87f48dd..b6209b3 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -437,6 +437,9 @@ static inline void cpufreq_resume(void) {}
 /* Policy Notifiers  */
 #define CPUFREQ_ADJUST			(0)
 #define CPUFREQ_NOTIFY			(1)
+#define CPUFREQ_START			(2)
+#define CPUFREQ_CREATE_POLICY		(3)
+#define CPUFREQ_REMOVE_POLICY		(4)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
