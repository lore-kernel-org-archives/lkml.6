Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeBFQfb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:35:31 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18971 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbeBFQet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:34:49 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 06 Feb 2018 08:35:28 -0800
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: [PATCH v3 09/11] cpufreq: tegra124-cpufreq: extend to support Tegra210
Date: Tue, 6 Feb 2018 18:34:10 +0200
Message-ID: <1517934852-23255-10-git-send-email-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 has a very similar CPU clocking scheme than Tegra124. So add
support in this driver. Also allow for the case where the CPU voltage is
controlled directly by the DFLL rather than by a separate regulator object.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/cpufreq/tegra124-cpufreq.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 4353025..f8e01a8 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -64,7 +64,8 @@ static void tegra124_cpu_switch_to_pllx(struct tegra124_cpufreq_priv *priv)
 {
 	clk_set_parent(priv->cpu_clk, priv->pllp_clk);
 	clk_disable_unprepare(priv->dfll_clk);
-	regulator_sync_voltage(priv->vdd_cpu_reg);
+	if (priv->vdd_cpu_reg)
+		regulator_sync_voltage(priv->vdd_cpu_reg);
 	clk_set_parent(priv->cpu_clk, priv->pllx_clk);
 }
 
@@ -89,10 +90,10 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	priv->vdd_cpu_reg = regulator_get(cpu_dev, "vdd-cpu");
-	if (IS_ERR(priv->vdd_cpu_reg)) {
-		ret = PTR_ERR(priv->vdd_cpu_reg);
-		goto out_put_np;
-	}
+	if (IS_ERR(priv->vdd_cpu_reg) != -EPROBE_DEFER)
+		priv->vdd_cpu_reg = NULL;
+	else
+		return -EPROBE_DEFER;
 
 	priv->cpu_clk = of_clk_get_by_name(np, "cpu_g");
 	if (IS_ERR(priv->cpu_clk)) {
@@ -148,7 +149,6 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 	clk_put(priv->cpu_clk);
 out_put_vdd_cpu_reg:
 	regulator_put(priv->vdd_cpu_reg);
-out_put_np:
 	of_node_put(np);
 
 	return ret;
@@ -181,7 +181,8 @@ static int __init tegra_cpufreq_init(void)
 	int ret;
 	struct platform_device *pdev;
 
-	if (!of_machine_is_compatible("nvidia,tegra124"))
+	if (!(of_machine_is_compatible("nvidia,tegra124")
+		|| of_machine_is_compatible("nvidia,tegra210")))
 		return -ENODEV;
 
 	/*
-- 
1.9.1
