Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeERUHb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:07:31 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41571 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeERUHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:07:22 -0400
X-Google-Smtp-Source: AB8JxZqqNMrVWhfgGFP3qDxWm8rWwGTkQLhOKYRW1LnfvJdCjMX2YksQbMdFV4u5Ly2kX7ErtZ91FA==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2 04/11] cpufreq: tegra20: Remove EMC clock usage
Date: Fri, 18 May 2018 23:06:35 +0300
Message-Id: <20180518200642.24815-5-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518200642.24815-1-digetx@gmail.com>
References: <20180518200642.24815-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EMC driver has been gone 4 years ago, since the commit a7cbe92cef27
("ARM: tegra: remove tegra EMC scaling driver"). Remove the EMC clock
usage as it does nothing. We may consider re-implementing the EMC scaling
later, probably using PM Memory Bandwidth QoS API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index bec1a50a8138..4b09a8b410c4 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -40,7 +40,6 @@ static struct cpufreq_frequency_table freq_table[] = {
 static struct clk *cpu_clk;
 static struct clk *pll_x_clk;
 static struct clk *pll_p_clk;
-static struct clk *emc_clk;
 static bool pll_x_prepared;
 
 static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
@@ -91,17 +90,6 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 	unsigned int ifreq = clk_get_rate(pll_p_clk) / 1000;
 	int ret = 0;
 
-	/*
-	 * Vote on memory bus frequency based on cpu frequency
-	 * This sets the minimum frequency, display or avp may request higher
-	 */
-	if (rate >= 816000)
-		clk_set_rate(emc_clk, 600000000); /* cpu 816 MHz, emc max */
-	else if (rate >= 456000)
-		clk_set_rate(emc_clk, 300000000); /* cpu 456 MHz, emc 150Mhz */
-	else
-		clk_set_rate(emc_clk, 100000000);  /* emc 50Mhz */
-
 	/*
 	 * target freq == pll_p, don't need to take extra reference to pll_x_clk
 	 * as it isn't used anymore.
@@ -137,14 +125,12 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 	if (policy->cpu >= NUM_CPUS)
 		return -EINVAL;
 
-	clk_prepare_enable(emc_clk);
 	clk_prepare_enable(cpu_clk);
 
 	/* FIXME: what's the actual transition time? */
 	ret = cpufreq_generic_init(policy, freq_table, 300 * 1000);
 	if (ret) {
 		clk_disable_unprepare(cpu_clk);
-		clk_disable_unprepare(emc_clk);
 		return ret;
 	}
 
@@ -156,7 +142,6 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 static int tegra_cpu_exit(struct cpufreq_policy *policy)
 {
 	clk_disable_unprepare(cpu_clk);
-	clk_disable_unprepare(emc_clk);
 	return 0;
 }
 
@@ -188,19 +173,12 @@ static int __init tegra_cpufreq_init(void)
 	if (IS_ERR(pll_p_clk))
 		return PTR_ERR(pll_p_clk);
 
-	emc_clk = clk_get_sys("cpu", "emc");
-	if (IS_ERR(emc_clk)) {
-		clk_put(cpu_clk);
-		return PTR_ERR(emc_clk);
-	}
-
 	return cpufreq_register_driver(&tegra_cpufreq_driver);
 }
 
 static void __exit tegra_cpufreq_exit(void)
 {
 	cpufreq_unregister_driver(&tegra_cpufreq_driver);
-	clk_put(emc_clk);
 	clk_put(cpu_clk);
 }
 
-- 
2.17.0
