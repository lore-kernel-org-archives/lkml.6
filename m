Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeEQSBo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:01:44 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43182 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbeEQSBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:01:24 -0400
X-Google-Smtp-Source: AB8JxZpy0Lv+6Dh2t32W7f2YOJJnH4TFmC/Ers/f4YT1KuBwhDBjk6c9Ss6r+Omvmbf16/GFz9LhqQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 10/11] cpufreq: tegra20: Wrap cpufreq into platform driver
Date: Thu, 17 May 2018 21:00:55 +0300
Message-Id: <20180517180056.13336-11-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
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
---
 drivers/cpufreq/tegra20-cpufreq.c | 116 +++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 43 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index c0a7b5a78aa6..f9d02a28df9e 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -19,7 +19,7 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/platform_device.h>
 
 static struct cpufreq_frequency_table freq_table[] = {
 	{ .frequency = 216000 },
@@ -33,15 +33,19 @@ static struct cpufreq_frequency_table freq_table[] = {
 	{ .frequency = CPUFREQ_TABLE_END },
 };
 
-static struct clk *cpu_clk;
-static struct clk *pll_x_clk;
-static struct clk *pll_p_clk;
-static bool pll_x_prepared;
+struct tegra20_cpufreq_data {
+	struct device *dev;
+	struct clk *cpu_clk;
+	struct clk *pll_x_clk;
+	struct clk *pll_p_clk;
+	bool pll_x_prepared;
+};
 
 static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
 					   unsigned int index)
 {
-	unsigned int ifreq = clk_get_rate(pll_p_clk) / 1000;
+	struct tegra20_cpufreq_data *data = cpufreq_get_driver_data();
+	unsigned int ifreq = clk_get_rate(data->pll_p_clk) / 1000;
 
 	/*
 	 * Don't switch to intermediate freq if:
@@ -57,6 +61,7 @@ static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
 static int tegra_target_intermediate(struct cpufreq_policy *policy,
 				     unsigned int index)
 {
+	struct tegra20_cpufreq_data *data = cpufreq_get_driver_data();
 	int ret;
 
 	/*
@@ -69,21 +74,22 @@ static int tegra_target_intermediate(struct cpufreq_policy *policy,
 	 * Also, we wouldn't be using pll_x anymore and must not take extra
 	 * reference to it, as it can be disabled now to save some power.
 	 */
-	clk_prepare_enable(pll_x_clk);
+	clk_prepare_enable(data->pll_x_clk);
 
-	ret = clk_set_parent(cpu_clk, pll_p_clk);
+	ret = clk_set_parent(data->cpu_clk, data->pll_p_clk);
 	if (ret)
-		clk_disable_unprepare(pll_x_clk);
+		clk_disable_unprepare(data->pll_x_clk);
 	else
-		pll_x_prepared = true;
+		data->pll_x_prepared = true;
 
 	return ret;
 }
 
 static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 {
+	struct tegra20_cpufreq_data *data = cpufreq_get_driver_data();
 	unsigned long rate = freq_table[index].frequency;
-	unsigned int ifreq = clk_get_rate(pll_p_clk) / 1000;
+	unsigned int ifreq = clk_get_rate(data->pll_p_clk) / 1000;
 	int ret;
 
 	/*
@@ -91,14 +97,14 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 	 * as it isn't used anymore.
 	 */
 	if (rate == ifreq)
-		return clk_set_parent(cpu_clk, pll_p_clk);
+		return clk_set_parent(data->cpu_clk, data->pll_p_clk);
 
-	ret = clk_set_rate(pll_x_clk, rate * 1000);
+	ret = clk_set_rate(data->pll_x_clk, rate * 1000);
 	/* Restore to earlier frequency on error, i.e. pll_x */
 	if (ret)
-		pr_err("Failed to change pll_x to %lu\n", rate);
+		dev_err(data->dev, "Failed to change pll_x to %lu\n", rate);
 
-	ret = clk_set_parent(cpu_clk, pll_x_clk);
+	ret = clk_set_parent(data->cpu_clk, data->pll_x_clk);
 	/* This shouldn't fail while changing or restoring */
 	WARN_ON(ret);
 
@@ -106,9 +112,9 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 	 * Drop count to pll_x clock only if we switched to intermediate freq
 	 * earlier while transitioning to a target frequency.
 	 */
-	if (pll_x_prepared) {
-		clk_disable_unprepare(pll_x_clk);
-		pll_x_prepared = false;
+	if (data->pll_x_prepared) {
+		clk_disable_unprepare(data->pll_x_clk);
+		data->pll_x_prepared = false;
 	}
 
 	return ret;
@@ -116,25 +122,28 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 
 static int tegra_cpu_init(struct cpufreq_policy *policy)
 {
+	struct tegra20_cpufreq_data *data = cpufreq_get_driver_data();
 	int ret;
 
-	clk_prepare_enable(cpu_clk);
+	clk_prepare_enable(data->cpu_clk);
 
 	/* FIXME: what's the actual transition time? */
 	ret = cpufreq_generic_init(policy, freq_table, 300 * 1000);
 	if (ret) {
-		clk_disable_unprepare(cpu_clk);
+		clk_disable_unprepare(data->cpu_clk);
 		return ret;
 	}
 
-	policy->clk = cpu_clk;
+	policy->clk = data->cpu_clk;
 	policy->suspend_freq = freq_table[0].frequency;
 	return 0;
 }
 
 static int tegra_cpu_exit(struct cpufreq_policy *policy)
 {
-	clk_disable_unprepare(cpu_clk);
+	struct tegra20_cpufreq_data *data = cpufreq_get_driver_data();
+
+	clk_disable_unprepare(data->cpu_clk);
 	return 0;
 }
 
@@ -152,55 +161,76 @@ static struct cpufreq_driver tegra_cpufreq_driver = {
 	.suspend		= cpufreq_generic_suspend,
 };
 
-static int __init tegra_cpufreq_init(void)
+static int tegra20_cpufreq_probe(struct platform_device *pdev)
 {
+	struct tegra20_cpufreq_data *data;
 	int err;
 
-	if (!of_machine_is_compatible("nvidia,tegra20"))
-		return -ENODEV;
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	cpu_clk = clk_get_sys(NULL, "cclk");
-	if (IS_ERR(cpu_clk))
-		return PTR_ERR(cpu_clk);
+	data->cpu_clk = clk_get_sys(NULL, "cclk");
+	if (IS_ERR(data->cpu_clk))
+		return PTR_ERR(data->cpu_clk);
 
-	pll_x_clk = clk_get_sys(NULL, "pll_x");
-	if (IS_ERR(pll_x_clk)) {
-		err = PTR_ERR(pll_x_clk);
+	data->pll_x_clk = clk_get_sys(NULL, "pll_x");
+	if (IS_ERR(data->pll_x_clk)) {
+		err = PTR_ERR(data->pll_x_clk);
 		goto put_cpu;
 	}
 
-	pll_p_clk = clk_get_sys(NULL, "pll_p");
-	if (IS_ERR(pll_p_clk)) {
-		err = PTR_ERR(pll_p_clk);
+	data->pll_p_clk = clk_get_sys(NULL, "pll_p");
+	if (IS_ERR(data->pll_p_clk)) {
+		err = PTR_ERR(data->pll_p_clk);
 		goto put_pll_x;
 	}
 
+	data->dev = &pdev->dev;
+
+	tegra_cpufreq_driver.driver_data = data;
+
 	err = cpufreq_register_driver(&tegra_cpufreq_driver);
 	if (err)
 		goto put_pll_p;
 
+	platform_set_drvdata(pdev, data);
+
 	return 0;
 
 put_pll_p:
-	clk_put(pll_p_clk);
+	clk_put(data->pll_p_clk);
 put_pll_x:
-	clk_put(pll_x_clk);
+	clk_put(data->pll_x_clk);
 put_cpu:
-	clk_put(cpu_clk);
+	clk_put(data->cpu_clk);
 
 	return err;
 }
 
-static void __exit tegra_cpufreq_exit(void)
+static int tegra20_cpufreq_remove(struct platform_device *pdev)
 {
+	struct tegra20_cpufreq_data *data = platform_get_drvdata(pdev);
+
 	cpufreq_unregister_driver(&tegra_cpufreq_driver);
-	clk_put(pll_p_clk);
-	clk_put(pll_x_clk);
-	clk_put(cpu_clk);
+
+	clk_put(data->pll_p_clk);
+	clk_put(data->pll_x_clk);
+	clk_put(data->cpu_clk);
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
 MODULE_AUTHOR("Colin Cross <ccross@android.com>");
+MODULE_ALIAS("platform:tegra20-cpufreq");
 MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
 MODULE_LICENSE("GPL");
-module_init(tegra_cpufreq_init);
-module_exit(tegra_cpufreq_exit);
-- 
2.17.0
