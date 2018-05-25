Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966103AbeEYKqN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:46:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39946 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965255AbeEYKqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:46:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C03160262
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1] clk: qcom: Add support for RCG to register for DFS
Date: Fri, 25 May 2018 16:15:50 +0530
Message-Id: <1527245150-2726-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527245150-2726-1-git-send-email-tdas@codeaurora.org>
References: <1527245150-2726-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the cases where a RCG requires a Dynamic Frequency switch support
requires to register which would at runtime read the clock perf level
registers to identify the frequencies supported and update the frequency
table accordingly.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h  |   6 +
 drivers/clk/qcom/clk-rcg2.c | 272 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c   |  22 ++++
 drivers/clk/qcom/common.h   |  18 +--
 4 files changed, 306 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index b209a2f..b5e5424 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -138,6 +138,7 @@ struct clk_dyn_rcg {
  * @parent_map: map from software's parent index to hardware's src_sel field
  * @freq_tbl: frequency table
  * @clkr: regmap clock handle
+ * @dfs_enable: corresponds to dfs mode enable
  *
  */
 struct clk_rcg2 {
@@ -148,6 +149,7 @@ struct clk_rcg2 {
 	const struct parent_map	*parent_map;
 	const struct freq_tbl	*freq_tbl;
 	struct clk_regmap	clkr;
+	bool			dfs_enable;
 };

 #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
@@ -160,5 +162,9 @@ struct clk_rcg2 {
 extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;
 extern const struct clk_ops clk_rcg2_shared_ops;
+extern const struct clk_ops clk_rcg2_dfs_ops;
+
+extern int clk_rcg2_enable_dfs(struct clk_rcg2 *clk, struct device *dev);
+extern int clk_rcg2_dfs_determine_rate_lazy(struct clk_rcg2 *clk);

 #endif
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 52208d4..9112891 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -10,8 +10,10 @@
 #include <linux/export.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/regmap.h>
 #include <linux/math64.h>
+#include <linux/slab.h>

 #include <asm/div64.h>

@@ -40,6 +42,14 @@
 #define N_REG			0xc
 #define D_REG			0x10

+/* Dynamic Frequency Scaling */
+#define MAX_PERF_LEVEL		16
+#define SE_CMD_DFSR_OFFSET	0x14
+#define SE_CMD_DFS_EN		BIT(0)
+#define SE_PERF_DFSR(level)	(0x1c + 0x4 * (level))
+#define SE_PERF_M_DFSR(level)	(0x5c + 0x4 * (level))
+#define SE_PERF_N_DFSR(level)	(0x9c + 0x4 * (level))
+
 enum freq_policy {
 	FLOOR,
 	CEIL,
@@ -929,3 +939,265 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
+
+/* Common APIs to be used for DFS based RCGR */
+struct dfs_table {
+	u8 src_index;
+	unsigned long prate;
+};
+
+static struct dfs_table *dfs_entry;
+
+static int clk_index_pre_div_and_mode(struct clk_hw *hw, u32 offset,
+		u32 *mode, u8 *pre_div)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int i, num_parents, ret;
+	u32 cfg, mask;
+
+	num_parents = clk_hw_get_num_parents(hw);
+
+	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + offset, &cfg);
+	if (ret)
+		goto err;
+
+	mask = BIT(rcg->hid_width) - 1;
+	*pre_div = cfg & mask ? (cfg & mask) : 1;
+
+	*mode = cfg & CFG_MODE_MASK;
+	*mode >>= CFG_MODE_SHIFT;
+
+	cfg &= CFG_SRC_SEL_MASK;
+	cfg >>= CFG_SRC_SEL_SHIFT;
+
+	for (i = 0; i < num_parents; i++)
+		if (cfg == rcg->parent_map[i].cfg)
+			return i;
+err:
+	return 0;
+}
+
+static int calculate_m_and_n(struct clk_hw *hw, u32 m_offset, u32 n_offset,
+		struct freq_tbl *f)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	u32 val, mask;
+	int ret;
+
+	/* Calculate M & N values */
+	mask = BIT(rcg->mnd_width) - 1;
+	ret =  regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + m_offset, &val);
+	if (ret) {
+		pr_err("Failed to read M offset register\n");
+		return ret;
+	}
+
+	val &= mask;
+	f->m  = val;
+
+	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + n_offset, &val);
+	if (ret) {
+		pr_err("Failed to read N offset register\n");
+		return ret;
+	}
+
+	/* val ~(N-M) */
+	val = ~val;
+	val &= mask;
+	val += f->m;
+	f->n = val;
+
+	return 0;
+}
+
+int clk_rcg2_dfs_determine_rate_lazy(struct clk_rcg2 *rcg)
+{
+	struct freq_tbl *dfs_freq_tbl;
+	int i, j, index, ret = 0;
+	unsigned long calc_freq, prate;
+	u32 mode = 0;
+
+	if (rcg->dfs_enable) {
+		pr_debug("DFS tables already populated\n");
+		return 0;
+	}
+
+	dfs_freq_tbl = kcalloc(MAX_PERF_LEVEL, sizeof(struct freq_tbl),
+				GFP_KERNEL);
+	if (!dfs_freq_tbl)
+		return -ENOMEM;
+
+	/* Populate the Perf Level frequencies */
+	for (i = 0; i < MAX_PERF_LEVEL; i++) {
+		/* Get parent index and mode */
+		index = clk_index_pre_div_and_mode(&rcg->clkr.hw,
+						SE_PERF_DFSR(i), &mode,
+						&dfs_freq_tbl[i].pre_div);
+		if (index < 0) {
+			pr_err("Failed to get parent index & mode %d\n", index);
+			kzfree(dfs_freq_tbl);
+			return index;
+		}
+
+		/* Fill parent src */
+		dfs_freq_tbl[i].src = rcg->parent_map[index].src;
+		prate = dfs_entry[index].prate;
+
+		if (mode) {
+			ret = calculate_m_and_n(&rcg->clkr.hw,
+						SE_PERF_M_DFSR(i),
+						SE_PERF_N_DFSR(i),
+						&dfs_freq_tbl[i]);
+			if (ret)
+				goto err;
+		} else {
+			dfs_freq_tbl[i].m = 0;
+			dfs_freq_tbl[i].n = 0;
+		}
+
+		/* calculate the final frequency */
+		calc_freq = calc_rate(prate, dfs_freq_tbl[i].m,
+					dfs_freq_tbl[i].n, mode,
+					dfs_freq_tbl[i].pre_div);
+
+		/* Check for duplicate frequencies */
+		for (j = 0; j  < i; j++) {
+			if (dfs_freq_tbl[j].freq == calc_freq)
+				goto done;
+		}
+
+		dfs_freq_tbl[i].freq = calc_freq;
+	}
+done:
+	rcg->freq_tbl = dfs_freq_tbl;
+err:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_rcg2_dfs_determine_rate_lazy);
+
+static int _freq_tbl_determine_dfs_rate(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct clk_hw *phw;
+	int i, num_parents;
+
+	num_parents = clk_hw_get_num_parents(hw);
+
+	dfs_entry = kcalloc(num_parents, sizeof(struct dfs_table), GFP_KERNEL);
+	if (!dfs_entry)
+		return -ENOMEM;
+
+	for (i = 0; i < num_parents; i++) {
+		dfs_entry[i].src_index = rcg->parent_map[i].src;
+		if (rcg->parent_map[i].cfg == 7)
+			break;
+		phw = clk_hw_get_parent_by_index(&rcg->clkr.hw, i);
+		if (!phw) {
+			kzfree(dfs_entry);
+			return -EINVAL;
+		}
+		dfs_entry[i].prate = clk_hw_get_rate(phw);
+	}
+
+	return 0;
+}
+
+static int clk_rcg2_dfs_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int ret;
+
+	if (!rcg->dfs_enable) {
+		ret = _freq_tbl_determine_dfs_rate(hw);
+		if (ret) {
+			pr_err("Failed to setup DFS frequency table\n");
+			return ret;
+		}
+
+		ret = clk_rcg2_dfs_determine_rate_lazy(rcg);
+		if (ret) {
+			pr_err("Failed to update DFS tables\n");
+			return ret;
+		}
+	}
+
+	return clk_rcg2_shared_ops.determine_rate(hw, req);
+}
+
+static int clk_rcg2_dfs_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/* DFS hardware takes care of setting the parent */
+	if (rcg->dfs_enable)
+		return 0;
+
+	return clk_rcg2_shared_ops.set_parent(hw, index);
+}
+
+static int clk_rcg2_dfs_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long prate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	if (rcg->dfs_enable)
+		return 0;
+
+	return clk_rcg2_shared_ops.set_rate(hw, rate, prate);
+}
+
+static int clk_rcg2_dfs_set_rate_and_parent(struct clk_hw *hw,
+				    unsigned long rate,
+				    unsigned long prate, u8 index)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	if (rcg->dfs_enable)
+		return 0;
+
+	return clk_rcg2_shared_ops.set_rate_and_parent(hw, rate, prate, index);
+}
+
+const struct clk_ops clk_rcg2_dfs_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_dfs_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.determine_rate = clk_rcg2_dfs_determine_rate,
+	.set_rate = clk_rcg2_dfs_set_rate,
+	.set_rate_and_parent = clk_rcg2_dfs_set_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_dfs_ops);
+
+int clk_rcg2_enable_dfs(struct clk_rcg2 *rcg, struct device *dev)
+{
+	struct regmap *regmap;
+	struct clk_rate_request req = { };
+	u32 val;
+	int ret;
+
+	regmap = dev_get_regmap(dev, NULL);
+	if (!regmap)
+		return -EINVAL;
+
+	/* Check for DFS_EN */
+	ret = regmap_read(regmap, rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET,
+			 &val);
+	if (ret) {
+		dev_err(dev, "Failed to read DFS enable register\n");
+		return -EINVAL;
+	}
+
+	if (!(val & SE_CMD_DFS_EN))
+		return ret;
+
+	ret = __clk_determine_rate(&rcg->clkr.hw, &req);
+	if (ret)
+		return ret;
+
+	rcg->dfs_enable = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(clk_rcg2_enable_dfs);
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index b8064a3..0b656ed 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -288,4 +288,26 @@ int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
 }
 EXPORT_SYMBOL_GPL(qcom_cc_probe);

+int qcom_cc_register_rcg_dfs(struct platform_device *pdev,
+			    struct clk_rcg2 **rcgs, int num_clks)
+{
+	struct clk_rcg2 *rcg;
+	int i, ret = 0;
+
+	for (i = 0; i < num_clks; i++) {
+		rcg = rcgs[i];
+		ret = clk_rcg2_enable_dfs(rcg, &pdev->dev);
+		if (ret) {
+			const char *name = (rcg->clkr.hw.init->name);
+
+			dev_err(&pdev->dev,
+				"%s DFS frequencies update failed\n", name);
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_cc_register_rcg_dfs);
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 00196ee..71d1c27 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -1,15 +1,6 @@
-/*
- * Copyright (c) 2014, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2014, 2018, The Linux Foundation. All rights reserved. */
+
 #ifndef __QCOM_CLK_COMMON_H__
 #define __QCOM_CLK_COMMON_H__

@@ -20,6 +11,7 @@
 struct regmap;
 struct freq_tbl;
 struct clk_hw;
+struct clk_rcg2;

 #define PLL_LOCK_COUNT_SHIFT	8
 #define PLL_LOCK_COUNT_MASK	0x3f
@@ -69,4 +61,6 @@ extern int qcom_cc_really_probe(struct platform_device *pdev,
 extern int qcom_cc_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc);

+extern int qcom_cc_register_rcg_dfs(struct platform_device *pdev,
+				   struct clk_rcg2 **rcgs, int num_clks);
 #endif
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
