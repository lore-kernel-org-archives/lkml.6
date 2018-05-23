Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754708AbeEWQB1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:01:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39144 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754430AbeEWQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:01:12 -0400
X-Google-Smtp-Source: AB8JxZoRaexpCwkCh7jcaNACalyqZw33KyLEBrHa90cLIvnX/dHK1hITijZx9qWLlxAlZJV9NEuLDQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] cpufreq: tegra20: Use PLL_C as intermediate clock source
Date: Wed, 23 May 2018 19:00:20 +0300
Message-Id: <20180523160020.15291-2-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523160020.15291-1-digetx@gmail.com>
References: <20180523160020.15291-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLL_C is running at 600MHz which is significantly higher than the 216MHz
of the PLL_P and it is known that PLL_C is always-ON because AHB BUS is
running on that PLL. Let's use PLL_C as intermediate clock source, making
CPU snappier a tad during of the frequency transition.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 3ad6bded6efc..4bf5ba7da40b 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -25,12 +25,13 @@
 #include <linux/types.h>
 
 #define PLL_P_FREQ	216000
+#define PLL_C_FREQ	600000
 
 static struct cpufreq_frequency_table freq_table[] = {
 	{ .frequency = 216000 },
 	{ .frequency = 312000 },
 	{ .frequency = 456000 },
-	{ .frequency = 608000 },
+	{ .frequency = 600000 },
 	{ .frequency = 760000 },
 	{ .frequency = 816000 },
 	{ .frequency = 912000 },
@@ -44,6 +45,7 @@ struct tegra20_cpufreq {
 	struct clk *cpu_clk;
 	struct clk *pll_x_clk;
 	struct clk *pll_p_clk;
+	struct clk *pll_c_clk;
 	bool pll_x_prepared;
 };
 
@@ -58,7 +60,10 @@ static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
 	if (index == 0 || policy->cur == PLL_P_FREQ)
 		return 0;
 
-	return PLL_P_FREQ;
+	if (index == 3 || policy->cur == PLL_C_FREQ)
+		return 0;
+
+	return PLL_C_FREQ;
 }
 
 static int tegra_target_intermediate(struct cpufreq_policy *policy,
@@ -79,7 +84,7 @@ static int tegra_target_intermediate(struct cpufreq_policy *policy,
 	 */
 	clk_prepare_enable(cpufreq->pll_x_clk);
 
-	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_p_clk);
+	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_c_clk);
 	if (ret)
 		clk_disable_unprepare(cpufreq->pll_x_clk);
 	else
@@ -101,6 +106,9 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 	if (index == 0)
 		return clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_p_clk);
 
+	if (index == 3)
+		return clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_c_clk);
+
 	ret = clk_set_rate(cpufreq->pll_x_clk, rate * 1000);
 	/* Restore to earlier frequency on error, i.e. pll_x */
 	if (ret)
@@ -174,6 +182,12 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
 		goto put_pll_x;
 	}
 
+	cpufreq->pll_c_clk = clk_get_sys(NULL, "pll_c");
+	if (IS_ERR(cpufreq->pll_c_clk)) {
+		err = PTR_ERR(cpufreq->pll_c_clk);
+		goto put_pll_p;
+	}
+
 	cpufreq->dev = &pdev->dev;
 	cpufreq->driver.get = cpufreq_generic_get;
 	cpufreq->driver.attr = cpufreq_generic_attr;
@@ -190,12 +204,14 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
 
 	err = cpufreq_register_driver(&cpufreq->driver);
 	if (err)
-		goto put_pll_p;
+		goto put_pll_c;
 
 	platform_set_drvdata(pdev, cpufreq);
 
 	return 0;
 
+put_pll_c:
+	clk_put(cpufreq->pll_c_clk);
 put_pll_p:
 	clk_put(cpufreq->pll_p_clk);
 put_pll_x:
@@ -212,6 +228,7 @@ static int tegra20_cpufreq_remove(struct platform_device *pdev)
 
 	cpufreq_unregister_driver(&cpufreq->driver);
 
+	clk_put(cpufreq->pll_c_clk);
 	clk_put(cpufreq->pll_p_clk);
 	clk_put(cpufreq->pll_x_clk);
 	clk_put(cpufreq->cpu_clk);
-- 
2.17.0
