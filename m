Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752741AbeBFQhp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:37:45 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2243 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbeBFQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:34:41 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 06 Feb 2018 08:34:40 -0800
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: [PATCH v3 03/11] clk: tegra: dfll registration for multiple SoCs
Date: Tue, 6 Feb 2018 18:34:04 +0200
Message-ID: <1517934852-23255-4-git-send-email-pdeschrijver@nvidia.com>
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

In a future patch, support for the DFLL in Tegra210 will be introduced.
This requires support for more than 1 set of CVB and CPU max frequency
tables.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 37 ++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index e2dbb79..6486ad9 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <soc/tegra/fuse.h>
@@ -29,8 +30,15 @@
 #include "clk-dfll.h"
 #include "cvb.h"
 
+struct dfll_fcpu_data {
+	const unsigned long *cpu_max_freq_table;
+	unsigned int cpu_max_freq_table_size;
+	const struct cvb_table *cpu_cvb_tables;
+	unsigned int cpu_cvb_tables_size;
+};
+
 /* Maximum CPU frequency, indexed by CPU speedo id */
-static const unsigned long cpu_max_freq_table[] = {
+static const unsigned long tegra124_cpu_max_freq_table[] = {
 	[0] = 2014500000UL,
 	[1] = 2320500000UL,
 	[2] = 2116500000UL,
@@ -80,6 +88,21 @@
 	},
 };
 
+static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
+	.cpu_max_freq_table = tegra124_cpu_max_freq_table,
+	.cpu_max_freq_table_size = ARRAY_SIZE(tegra124_cpu_max_freq_table),
+	.cpu_cvb_tables = tegra124_cpu_cvb_tables,
+	.cpu_cvb_tables_size = ARRAY_SIZE(tegra124_cpu_cvb_tables)
+};
+
+static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
+	{
+		.compatible = "nvidia,tegra124-dfll",
+		.data = &tegra124_dfll_fcpu_data,
+	},
+	{ },
+};
+
 static int get_alignment_from_regulator(struct device *dev,
 					struct rail_alignment *align)
 {
@@ -112,12 +135,17 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 {
 	int process_id, speedo_id, speedo_value, err;
 	struct tegra_dfll_soc_data *soc;
+	const struct of_device_id *of_id;
+	const struct dfll_fcpu_data *fcpu_data;
+
+	of_id = of_match_device(tegra124_dfll_fcpu_of_match, &pdev->dev);
+	fcpu_data = of_id->data;
 
 	process_id = tegra_sku_info.cpu_process_id;
 	speedo_id = tegra_sku_info.cpu_speedo_id;
 	speedo_value = tegra_sku_info.cpu_speedo_value;
 
-	if (speedo_id >= ARRAY_SIZE(cpu_max_freq_table)) {
+	if (speedo_id >= fcpu_data->cpu_max_freq_table_size) {
 		dev_err(&pdev->dev, "unknown max CPU freq for speedo_id=%d\n",
 			speedo_id);
 		return -ENODEV;
@@ -172,11 +200,6 @@ static int tegra124_dfll_fcpu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
-	{ .compatible = "nvidia,tegra124-dfll", },
-	{ },
-};
-
 static const struct dev_pm_ops tegra124_dfll_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra_dfll_runtime_suspend,
 			   tegra_dfll_runtime_resume, NULL)
-- 
1.9.1
