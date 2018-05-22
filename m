Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeEVVPI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:15:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53314 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752660AbeEVVPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:15:06 -0400
X-Google-Smtp-Source: AB8JxZoxq3uDhh+xGiCgaP7FI3+yHCRR5xd8JiJfa8h+vwtlvaiyGB+mexWI7gd/6QddRJkbzUaq9Q==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] cpufreq: tegra20: Fix imbalanced clock enable count
Date: Wed, 23 May 2018 00:14:20 +0300
Message-Id: <20180522211420.2006-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20-cpufreq driver missed enabling the CPU clocks. This results in a
clock-enable refcount disbalance on PLL_P <-> PLL_X reparent, causing
PLL_X to get disabled while it shouldn't. Fix this by enabling the clocks
on the driver probe.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

CPUFreq maintainers,

Please take into account that this patch is made on top of my recent
series of patches [0] "Clean up Tegra20 cpufreq driver" that was fully
reviewed, but seems not applied yet. Let me know if you prefer to re-spin
the [0], including this patch into the series.

[0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=45321

 drivers/cpufreq/tegra20-cpufreq.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 05f57dcd5215..ca5229265b60 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -176,6 +176,14 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
 		goto put_pll_x;
 	}
 
+	err = clk_prepare_enable(cpufreq->pll_x_clk);
+	if (err)
+		goto put_pll_p;
+
+	err = clk_prepare_enable(cpufreq->pll_p_clk);
+	if (err)
+		goto disable_pll_x;
+
 	cpufreq->dev = &pdev->dev;
 	cpufreq->driver.get = cpufreq_generic_get;
 	cpufreq->driver.attr = cpufreq_generic_attr;
@@ -192,12 +200,16 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
 
 	err = cpufreq_register_driver(&cpufreq->driver);
 	if (err)
-		goto put_pll_p;
+		goto disable_pll_p;
 
 	platform_set_drvdata(pdev, cpufreq);
 
 	return 0;
 
+disable_pll_p:
+	clk_disable_unprepare(cpufreq->pll_p_clk);
+disable_pll_x:
+	clk_disable_unprepare(cpufreq->pll_x_clk);
 put_pll_p:
 	clk_put(cpufreq->pll_p_clk);
 put_pll_x:
@@ -214,6 +226,8 @@ static int tegra20_cpufreq_remove(struct platform_device *pdev)
 
 	cpufreq_unregister_driver(&cpufreq->driver);
 
+	clk_disable_unprepare(cpufreq->pll_p_clk);
+	clk_disable_unprepare(cpufreq->pll_x_clk);
 	clk_put(cpufreq->pll_p_clk);
 	clk_put(cpufreq->pll_x_clk);
 	clk_put(cpufreq->cpu_clk);
-- 
2.17.0
