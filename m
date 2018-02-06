Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeBFQep (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:34:45 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2233 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeBFQei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:34:38 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 06 Feb 2018 08:35:21 -0800
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: [PATCH v3 02/11] clk: tegra: retrieve regulator info from framework
Date: Tue, 6 Feb 2018 18:34:03 +0200
Message-ID: <1517934852-23255-3-git-send-email-pdeschrijver@nvidia.com>
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

The CVB table contains calibration data for the CPU DFLL based on
process charaterization. The regulator step and offset parameters depend
on the regulator supplying vdd-cpu , not on the specific Tegra SKU.
Hence than hardcoding those regulator parameters in the CVB table,
retrieve them from the regulator framework and store them as part of the
tegra_dfll_soc_data struct.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-dfll.h               |  2 ++
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 42 +++++++++++++++++++++++++-----
 drivers/clk/tegra/cvb.c                    | 16 +++++++++---
 drivers/clk/tegra/cvb.h                    |  6 ++---
 4 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/tegra/clk-dfll.h b/drivers/clk/tegra/clk-dfll.h
index 83352c8..e7cbc5b 100644
--- a/drivers/clk/tegra/clk-dfll.h
+++ b/drivers/clk/tegra/clk-dfll.h
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/types.h>
+#include "cvb.h"
 
 /**
  * struct tegra_dfll_soc_data - SoC-specific hooks/integration for the DFLL driver
@@ -35,6 +36,7 @@ struct tegra_dfll_soc_data {
 	struct device *dev;
 	unsigned long max_freq;
 	const struct cvb_table *cvb;
+	struct rail_alignment alignment;
 
 	void (*init_clock_trimmers)(void);
 	void (*set_clock_trimmers_high)(void);
diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 269d359..e2dbb79 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <soc/tegra/fuse.h>
 
 #include "clk.h"
@@ -42,9 +43,6 @@
 		.process_id = -1,
 		.min_millivolts = 900,
 		.max_millivolts = 1260,
-		.alignment = {
-			.step_uv = 10000, /* 10mV */
-		},
 		.speedo_scale = 100,
 		.voltage_scale = 1000,
 		.entries = {
@@ -82,6 +80,34 @@
 	},
 };
 
+static int get_alignment_from_regulator(struct device *dev,
+					struct rail_alignment *align)
+{
+	int min_uV, max_uV, n_voltages, ret;
+	struct regulator *reg;
+
+	reg = devm_regulator_get(dev, "vdd-cpu");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	ret = regulator_get_constraint_voltages(reg, &min_uV, &max_uV);
+	if (!ret)
+		align->offset_uv = min_uV;
+	else
+		return ret;
+
+	align->step_uv = regulator_get_linear_step(reg);
+	if (!align->step_uv && !ret) {
+		n_voltages = regulator_count_voltages(reg);
+		if (n_voltages > 1)
+			align->step_uv = (max_uV - min_uV) / (n_voltages - 1);
+	}
+
+	devm_regulator_put(reg);
+
+	return 0;
+}
+
 static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 {
 	int process_id, speedo_id, speedo_value, err;
@@ -108,10 +134,14 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
 	}
 
 	soc->max_freq = cpu_max_freq_table[speedo_id];
+	err = get_alignment_from_regulator(&pdev->dev, &soc->alignment);
+	if (err < 0)
+		return err;
 
-	soc->cvb = tegra_cvb_add_opp_table(soc->dev, tegra124_cpu_cvb_tables,
-					   ARRAY_SIZE(tegra124_cpu_cvb_tables),
-					   process_id, speedo_id, speedo_value,
+	soc->cvb = tegra_cvb_add_opp_table(soc->dev, fcpu_data->cpu_cvb_tables,
+					   fcpu_data->cpu_cvb_tables_size,
+					   &soc->alignment, process_id,
+					   speedo_id, speedo_value,
 					   soc->max_freq);
 	if (IS_ERR(soc->cvb)) {
 		dev_err(&pdev->dev, "couldn't add OPP table: %ld\n",
diff --git a/drivers/clk/tegra/cvb.c b/drivers/clk/tegra/cvb.c
index da9e8e7..2aa9639 100644
--- a/drivers/clk/tegra/cvb.c
+++ b/drivers/clk/tegra/cvb.c
@@ -62,11 +62,17 @@ static int round_voltage(int mv, const struct rail_alignment *align, int up)
 }
 
 static int build_opp_table(struct device *dev, const struct cvb_table *table,
+			   struct rail_alignment *align,
 			   int speedo_value, unsigned long max_freq)
 {
-	const struct rail_alignment *align = &table->alignment;
 	int i, ret, dfll_mv, min_mv, max_mv;
 
+	if (!align->step_uv)
+		return -EINVAL;
+
+	if (!align->offset_uv)
+		return -EINVAL;
+
 	min_mv = round_voltage(table->min_millivolts, align, UP);
 	max_mv = round_voltage(table->max_millivolts, align, DOWN);
 
@@ -109,8 +115,9 @@ static int build_opp_table(struct device *dev, const struct cvb_table *table,
  */
 const struct cvb_table *
 tegra_cvb_add_opp_table(struct device *dev, const struct cvb_table *tables,
-			size_t count, int process_id, int speedo_id,
-			int speedo_value, unsigned long max_freq)
+			size_t count, struct rail_alignment *align,
+			int process_id, int speedo_id, int speedo_value,
+			unsigned long max_freq)
 {
 	size_t i;
 	int ret;
@@ -124,7 +131,8 @@ static int build_opp_table(struct device *dev, const struct cvb_table *table,
 		if (table->process_id != -1 && table->process_id != process_id)
 			continue;
 
-		ret = build_opp_table(dev, table, speedo_value, max_freq);
+		ret = build_opp_table(dev, table, align, speedo_value,
+				      max_freq);
 		return ret ? ERR_PTR(ret) : table;
 	}
 
diff --git a/drivers/clk/tegra/cvb.h b/drivers/clk/tegra/cvb.h
index c1f0779..bcf15a0 100644
--- a/drivers/clk/tegra/cvb.h
+++ b/drivers/clk/tegra/cvb.h
@@ -49,7 +49,6 @@ struct cvb_table {
 
 	int min_millivolts;
 	int max_millivolts;
-	struct rail_alignment alignment;
 
 	int speedo_scale;
 	int voltage_scale;
@@ -59,8 +58,9 @@ struct cvb_table {
 
 const struct cvb_table *
 tegra_cvb_add_opp_table(struct device *dev, const struct cvb_table *cvb_tables,
-			size_t count, int process_id, int speedo_id,
-			int speedo_value, unsigned long max_freq);
+			size_t count, struct rail_alignment *align,
+			int process_id, int speedo_id, int speedo_value,
+			unsigned long max_freq);
 void tegra_cvb_remove_opp_table(struct device *dev,
 				const struct cvb_table *table,
 				unsigned long max_freq);
-- 
1.9.1
