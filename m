Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeBZNLN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:11:13 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49886 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752547AbeBZNLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:11:12 -0500
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2] cpufreq: scpi: invoke frequency-invariance setter function
Date: Mon, 26 Feb 2018 13:11:03 +0000
Message-Id: <20180226131103.5951-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
changed the cpufreq driver on juno from arm_big_little to scpi.

The scpi set_target function does not call the frequency-invariance
setter function arch_set_freq_scale() like the arm_big_little set_target
function does. As a result the task scheduler load and utilization
signals are not frequency-invariant on this platform anymore.

Fix this by adding a call to arch_set_freq_scale() into
scpi_cpufreq_set_target().

Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/scpi-cpufreq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index c32a833e1b00..d300a163945f 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -51,15 +51,23 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 static int
 scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
+	unsigned long freq = policy->freq_table[index].frequency;
 	struct scpi_data *priv = policy->driver_data;
-	u64 rate = policy->freq_table[index].frequency * 1000;
+	u64 rate = freq * 1000;
 	int ret;
 
 	ret = clk_set_rate(priv->clk, rate);
-	if (!ret && (clk_get_rate(priv->clk) != rate))
-		ret = -EIO;
 
-	return ret;
+	if (ret)
+		return ret;
+
+	if (clk_get_rate(priv->clk) != rate)
+		return -EIO;
+
+	arch_set_freq_scale(policy->related_cpus, freq,
+			    policy->cpuinfo.max_freq);
+
+	return 0;
 }
 
 static int
-- 
2.11.0
