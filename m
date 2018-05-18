Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeERUIB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:08:01 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40671 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbeERUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:07:32 -0400
X-Google-Smtp-Source: AB8JxZpBhq6XanGRA3a59KgVmrVC32AVFuWZ2wLjyUpGoNQxHwvDZ/5NeSYQhG2PDxNusc5RLgS4jg==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2 11/11] cpufreq: tegra20: Wrap cpufreq into platform driver
Date: Fri, 18 May 2018 23:06:42 +0300
Message-Id: <20180518200642.24815-12-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518200642.24815-1-digetx@gmail.com>
References: <20180518200642.24815-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently tegra20-cpufreq kernel module isn't getting autoloaded because
there is no device associated with the module, this is one of two patches
that resolves the module autoloading. This patch adds a module alias that
will associate the tegra20-cpufreq kernel module with the platform device,
other patch will instantiate the actual platform device. And now it makes
sense to wrap cpufreq driver into a platform driver for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra20-cpufreq.c | 145 ++++++++++++++++++------------
 1 file changed, 86 insertions(+), 59 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 7b425ebe81e7..05f57dcd5215 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -21,7 +21,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 
 static struct cpufreq_frequency_table freq_table[] = {
@@ -36,15 +36,20 @@ static struct cpufreq_frequency_table freq_table[] = {
 	{ .frequency = CPUFREQ_TABLE_END },
 };
 
-static struct clk *cpu_clk;
-static struct clk *pll_x_clk;
-static struct clk *pll_p_clk;
-static bool pll_x_prepared;
+struct tegra20_cpufreq {
+	struct device *dev;
+	struct cpufreq_driver driver;
+	struct clk *cpu_clk;
+	struct clk *pll_x_clk;
+	struct clk *pll_p_clk;
+	bool pll_x_prepared;
+};
 
 static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
 					   unsigned int index)
 {
-	unsigned int ifreq = clk_get_rate(pll_p_clk) / 1000;
+	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
+	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
 
 	/*
 	 * Don't switch to intermediate freq if:
@@ -60,6 +65,7 @@ static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
 static int tegra_target_intermediate(struct cpufreq_policy *policy,
 				     unsigned int index)
 {
+	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
 	int ret;
 
 	/*
@@ -72,21 +78,22 @@ static int tegra_target_intermediate(struct cpufreq_policy *policy,
 	 * Also, we wouldn't be using pll_x anymore and must not take extra
 	 * reference to it, as it can be disabled now to save some power.
 	 */
-	clk_prepare_enable(pll_x_clk);
+	clk_prepare_enable(cpufreq->pll_x_clk);
 
-	ret = clk_set_parent(cpu_clk, pll_p_clk);
+	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_p_clk);
 	if (ret)
-		clk_disable_unprepare(pll_x_clk);
+		clk_disable_unprepare(cpufreq->pll_x_clk);
 	else
-		pll_x_prepared = true;
+		cpufreq->pll_x_prepared = true;
 
 	return ret;
 }
 
 static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 {
+	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
 	unsigned long rate = freq_table[index].frequency;
-	unsigned int ifreq = clk_get_rate(pll_p_clk) / 1000;
+	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
 	int ret;
 
 	/*
@@ -94,14 +101,14 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 	 * as it isn't used anymore.
 	 */
 	if (rate == ifreq)
-		return clk_set_parent(cpu_clk, pll_p_clk);
+		return clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_p_clk);
 
-	ret = clk_set_rate(pll_x_clk, rate * 1000);
+	ret = clk_set_rate(cpufreq->pll_x_clk, rate * 1000);
 	/* Restore to earlier frequency on error, i.e. pll_x */
 	if (ret)
-		pr_err("Failed to change pll_x to %lu\n", rate);
+		dev_err(cpufreq->dev, "Failed to change pll_x to %lu\n", rate);
 
-	ret = clk_set_parent(cpu_clk, pll_x_clk);
+	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_x_clk);
 	/* This shouldn't fail while changing or restoring */
 	WARN_ON(ret);
 
@@ -109,9 +116,9 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 	 * Drop count to pll_x clock only if we switched to intermediate freq
 	 * earlier while transitioning to a target frequency.
 	 */
-	if (pll_x_prepared) {
-		clk_disable_unprepare(pll_x_clk);
-		pll_x_prepared = false;
+	if (cpufreq->pll_x_prepared) {
+		clk_disable_unprepare(cpufreq->pll_x_clk);
+		cpufreq->pll_x_prepared = false;
 	}
 
 	return ret;
@@ -119,91 +126,111 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 
 static int tegra_cpu_init(struct cpufreq_policy *policy)
 {
+	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
 	int ret;
 
-	clk_prepare_enable(cpu_clk);
+	clk_prepare_enable(cpufreq->cpu_clk);
 
 	/* FIXME: what's the actual transition time? */
 	ret = cpufreq_generic_init(policy, freq_table, 300 * 1000);
 	if (ret) {
-		clk_disable_unprepare(cpu_clk);
+		clk_disable_unprepare(cpufreq->cpu_clk);
 		return ret;
 	}
 
-	policy->clk = cpu_clk;
+	policy->clk = cpufreq->cpu_clk;
 	policy->suspend_freq = freq_table[0].frequency;
 	return 0;
 }
 
 static int tegra_cpu_exit(struct cpufreq_policy *policy)
 {
-	clk_disable_unprepare(cpu_clk);
+	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
+
+	clk_disable_unprepare(cpufreq->cpu_clk);
 	return 0;
 }
 
-static struct cpufreq_driver tegra_cpufreq_driver = {
-	.flags			= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
-	.verify			= cpufreq_generic_frequency_table_verify,
-	.get_intermediate	= tegra_get_intermediate,
-	.target_intermediate	= tegra_target_intermediate,
-	.target_index		= tegra_target,
-	.get			= cpufreq_generic_get,
-	.init			= tegra_cpu_init,
-	.exit			= tegra_cpu_exit,
-	.name			= "tegra",
-	.attr			= cpufreq_generic_attr,
-	.suspend		= cpufreq_generic_suspend,
-};
-
-static int __init tegra_cpufreq_init(void)
+static int tegra20_cpufreq_probe(struct platform_device *pdev)
 {
+	struct tegra20_cpufreq *cpufreq;
 	int err;
 
-	if (!of_machine_is_compatible("nvidia,tegra20"))
-		return -ENODEV;
+	cpufreq = devm_kzalloc(&pdev->dev, sizeof(*cpufreq), GFP_KERNEL);
+	if (!cpufreq)
+		return -ENOMEM;
 
-	cpu_clk = clk_get_sys(NULL, "cclk");
-	if (IS_ERR(cpu_clk))
-		return PTR_ERR(cpu_clk);
+	cpufreq->cpu_clk = clk_get_sys(NULL, "cclk");
+	if (IS_ERR(cpufreq->cpu_clk))
+		return PTR_ERR(cpufreq->cpu_clk);
 
-	pll_x_clk = clk_get_sys(NULL, "pll_x");
-	if (IS_ERR(pll_x_clk)) {
-		err = PTR_ERR(pll_x_clk);
+	cpufreq->pll_x_clk = clk_get_sys(NULL, "pll_x");
+	if (IS_ERR(cpufreq->pll_x_clk)) {
+		err = PTR_ERR(cpufreq->pll_x_clk);
 		goto put_cpu;
 	}
 
-	pll_p_clk = clk_get_sys(NULL, "pll_p");
-	if (IS_ERR(pll_p_clk)) {
-		err = PTR_ERR(pll_p_clk);
+	cpufreq->pll_p_clk = clk_get_sys(NULL, "pll_p");
+	if (IS_ERR(cpufreq->pll_p_clk)) {
+		err = PTR_ERR(cpufreq->pll_p_clk);
 		goto put_pll_x;
 	}
 
-	err = cpufreq_register_driver(&tegra_cpufreq_driver);
+	cpufreq->dev = &pdev->dev;
+	cpufreq->driver.get = cpufreq_generic_get;
+	cpufreq->driver.attr = cpufreq_generic_attr;
+	cpufreq->driver.init = tegra_cpu_init;
+	cpufreq->driver.exit = tegra_cpu_exit;
+	cpufreq->driver.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK;
+	cpufreq->driver.verify = cpufreq_generic_frequency_table_verify;
+	cpufreq->driver.suspend = cpufreq_generic_suspend;
+	cpufreq->driver.driver_data = cpufreq;
+	cpufreq->driver.target_index = tegra_target;
+	cpufreq->driver.get_intermediate = tegra_get_intermediate;
+	cpufreq->driver.target_intermediate = tegra_target_intermediate;
+	snprintf(cpufreq->driver.name, CPUFREQ_NAME_LEN, "tegra");
+
+	err = cpufreq_register_driver(&cpufreq->driver);
 	if (err)
 		goto put_pll_p;
 
+	platform_set_drvdata(pdev, cpufreq);
+
 	return 0;
 
 put_pll_p:
-	clk_put(pll_p_clk);
+	clk_put(cpufreq->pll_p_clk);
 put_pll_x:
-	clk_put(pll_x_clk);
+	clk_put(cpufreq->pll_x_clk);
 put_cpu:
-	clk_put(cpu_clk);
+	clk_put(cpufreq->cpu_clk);
 
 	return err;
 }
 
-static void __exit tegra_cpufreq_exit(void)
+static int tegra20_cpufreq_remove(struct platform_device *pdev)
 {
-	cpufreq_unregister_driver(&tegra_cpufreq_driver);
-	clk_put(pll_p_clk);
-	clk_put(pll_x_clk);
-	clk_put(cpu_clk);
+	struct tegra20_cpufreq *cpufreq = platform_get_drvdata(pdev);
+
+	cpufreq_unregister_driver(&cpufreq->driver);
+
+	clk_put(cpufreq->pll_p_clk);
+	clk_put(cpufreq->pll_x_clk);
+	clk_put(cpufreq->cpu_clk);
+
+	return 0;
 }
 
+static struct platform_driver tegra20_cpufreq_driver = {
+	.probe		= tegra20_cpufreq_probe,
+	.remove		= tegra20_cpufreq_remove,
+	.driver		= {
+		.name	= "tegra20-cpufreq",
+	},
+};
+module_platform_driver(tegra20_cpufreq_driver);
+
+MODULE_ALIAS("platform:tegra20-cpufreq");
 MODULE_AUTHOR("Colin Cross <ccross@android.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
 MODULE_LICENSE("GPL");
-module_init(tegra_cpufreq_init);
-module_exit(tegra_cpufreq_exit);
-- 
2.17.0
