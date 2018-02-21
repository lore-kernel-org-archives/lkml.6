Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938321AbeBUP36 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:29:58 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36405 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938264AbeBUP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:29:47 -0500
X-Google-Smtp-Source: AH8x224RGcr9U24YCnt6ltJvuyvxkElIS/FajQhfeol9aPnOwt5pRlUJwn1ML/U8KVDli0Nvqp43lA==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/7] thermal/drivers/Kconfig: Convert the CPU cooling device to a choice
Date: Wed, 21 Feb 2018 16:29:25 +0100
Message-Id: <1519226968-19821-5-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next changes will add new way to cool down a CPU. In order to
sanitize and make the overall cpu cooling code consistent and robust
we must prevent the cpu cooling devices to co-exists with the same
purpose at the same time in the kernel.

Make the CPU cooling device a choice in the Kconfig, so only one CPU
cooling strategy can be chosen.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig       | 20 +++++++++++++++++---
 drivers/thermal/cpu_cooling.c |  2 ++
 include/linux/cpu_cooling.h   |  6 +++---
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b6adc54..5aaae1b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -142,17 +142,31 @@ config THERMAL_GOV_POWER_ALLOCATOR
 	  allocating and limiting power to devices.
 
 config CPU_THERMAL
-	bool "generic cpu cooling support"
-	depends on CPU_FREQ
+	bool "Generic cpu cooling support"
 	depends on THERMAL_OF
 	help
+	  Enable the CPU cooling features. If the system has no active
+	  cooling device available, this option allows to use the CPU
+	  as a cooling device.
+
+choice
+	prompt "CPU cooling strategies"
+	depends on CPU_THERMAL
+	default CPU_FREQ_THERMAL
+	help
+	  Select the CPU cooling strategy.
+
+config CPU_FREQ_THERMAL
+        bool "CPU frequency cooling strategy"
+	depends on CPU_FREQ
+	help
 	  This implements the generic cpu cooling mechanism through frequency
 	  reduction. An ACPI version of this already exists
 	  (drivers/acpi/processor_thermal.c).
 	  This will be useful for platforms using the generic thermal interface
 	  and not the ACPI interface.
 
-	  If you want this support, you should say Y here.
+endchoice
 
 config CLOCK_THERMAL
 	bool "Generic clock cooling support"
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 7bdc19f..5c219dc 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -22,6 +22,7 @@
 
 #include <trace/events/thermal.h>
 
+#ifdef CONFIG_CPU_FREQ_THERMAL
 /*
  * Cooling state <-> CPUFreq frequency
  *
@@ -926,3 +927,4 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	kfree(cpufreq_cdev);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
+#endif /* CONFIG_CPU_FREQ_THERMAL */
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index d4292eb..c0accc7 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -33,7 +33,7 @@ struct cpufreq_policy;
 typedef int (*get_static_t)(cpumask_t *cpumask, int interval,
 			    unsigned long voltage, u32 *power);
 
-#ifdef CONFIG_CPU_THERMAL
+#ifdef CONFIG_CPU_FREQ_THERMAL
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
  * @policy: cpufreq policy.
@@ -84,7 +84,7 @@ of_cpufreq_power_cooling_register(struct device_node *np,
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 
-#else /* !CONFIG_CPU_THERMAL */
+#else /* !CONFIG_CPU_FREQ_THERMAL */
 static inline struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
@@ -118,6 +118,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	return;
 }
-#endif	/* CONFIG_CPU_THERMAL */
+#endif	/* CONFIG_CPU_FREQ_THERMAL */
 
 #endif /* __CPU_COOLING_H__ */
-- 
2.7.4
