Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeBVGAD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:00:03 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35747 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbeBVGAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:00:00 -0500
X-Google-Smtp-Source: AH8x224ZgdIp9nl9GKboLD3/Ljf40+v3OOK9lxkqIZl857ZbvSMjmjjFOQLttzcHI6XzRX74uUFNxg==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: Validate cpufreq table from core
Date: Thu, 22 Feb 2018 11:29:44 +0530
Message-Id: <abf8127866227903b89ed2809f9ec0b838cd2310.1519279148.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <bd8c6133ad0bdd56c936802bcf26878d7cbdb679.1519279148.git.viresh.kumar@linaro.org>
References: <bd8c6133ad0bdd56c936802bcf26878d7cbdb679.1519279148.git.viresh.kumar@linaro.org>
In-Reply-To: <bd8c6133ad0bdd56c936802bcf26878d7cbdb679.1519279148.git.viresh.kumar@linaro.org>
References: <bd8c6133ad0bdd56c936802bcf26878d7cbdb679.1519279148.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By design, it is responsibility of the cpufreq drivers to call
cpufreq_frequency_table_cpuinfo() from their ->init() callback to
validate the cpufreq table.

But what if the cpufreq driver is buggy and fails to do so properly? It
may then result in unexpected behavior from the driver or the cpufreq
core at a later point of time. It would be better if the core can
validate the cpufreq table at the initial stage.

This commit adds another routine cpufreq_table_validate_and_sort() and
calls it right after calling the ->init() callback of the driver and
destroys the cpufreq policy if the table is invalid.

For the moment the validation of the table happens twice, once from the
driver and then from the core. The individual drivers would be updated
separately to drop table validation if they don't need it for other
purposes.

The cpufreq table is marked "sorted" or "unsorted" from the new helper
now instead of cpufreq_table_validate_and_show(), as we should be doing
that only after validating the table (which the drivers wouldn't do
going forward).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c    | 13 +++++++++----
 drivers/cpufreq/freq_table.c | 16 +++++++++++++++-
 include/linux/cpufreq.h      |  1 +
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8814c572e263..239063fb6afc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1219,6 +1219,10 @@ static int cpufreq_online(unsigned int cpu)
 		goto out_free_policy;
 	}
 
+	ret = cpufreq_table_validate_and_sort(policy);
+	if (ret)
+		goto out_exit_policy;
+
 	down_write(&policy->rwsem);
 
 	if (new_policy) {
@@ -1249,7 +1253,7 @@ static int cpufreq_online(unsigned int cpu)
 		policy->cur = cpufreq_driver->get(policy->cpu);
 		if (!policy->cur) {
 			pr_err("%s: ->get() failed\n", __func__);
-			goto out_exit_policy;
+			goto out_destroy_policy;
 		}
 	}
 
@@ -1296,7 +1300,7 @@ static int cpufreq_online(unsigned int cpu)
 	if (new_policy) {
 		ret = cpufreq_add_dev_interface(policy);
 		if (ret)
-			goto out_exit_policy;
+			goto out_destroy_policy;
 
 		cpufreq_stats_create_table(policy);
 
@@ -1311,7 +1315,7 @@ static int cpufreq_online(unsigned int cpu)
 		       __func__, cpu, ret);
 		/* cpufreq_policy_free() will notify based on this */
 		new_policy = false;
-		goto out_exit_policy;
+		goto out_destroy_policy;
 	}
 
 	up_write(&policy->rwsem);
@@ -1326,12 +1330,13 @@ static int cpufreq_online(unsigned int cpu)
 
 	return 0;
 
-out_exit_policy:
+out_destroy_policy:
 	for_each_cpu(j, policy->real_cpus)
 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
 
 	up_write(&policy->rwsem);
 
+out_exit_policy:
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 6d007f824ca7..10e119ae66dd 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -362,10 +362,24 @@ int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 		return ret;
 
 	policy->freq_table = table;
-	return set_freq_table_sorted(policy);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(cpufreq_table_validate_and_show);
 
+int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	if (!policy->freq_table)
+		return 0;
+
+	ret = cpufreq_frequency_table_cpuinfo(policy, policy->freq_table);
+	if (ret)
+		return ret;
+
+	return set_freq_table_sorted(policy);
+}
+
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq frequency table helpers");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 21e8d248d956..1fe49724da9e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -962,6 +962,7 @@ extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
 extern struct freq_attr *cpufreq_generic_attr[];
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 				      struct cpufreq_frequency_table *table);
+int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy);
 
 unsigned int cpufreq_generic_get(unsigned int cpu);
 int cpufreq_generic_init(struct cpufreq_policy *policy,
-- 
2.15.0.194.g9af6a3dea062
