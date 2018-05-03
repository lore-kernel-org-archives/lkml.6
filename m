Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeECEM5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 00:12:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbeECEMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 00:12:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 968E660AD4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] clk: qcom: Add support for RCG to register for DFS
Date: Thu,  3 May 2018 09:42:32 +0530
Message-Id: <1525320752-15091-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the cases where a RCG requires a Dynamic Frequency switch support
requires to register which would at runtime read the clock perf level
registers to identify the frequencies supported and update the frequency
table accordingly.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h  |   7 +-
 drivers/clk/qcom/clk-rcg2.c | 172 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c   |  23 +++++-
 drivers/clk/qcom/common.h   |  14 +++-
 4 files changed, 213 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 2a7489a..06de69f 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2013, 2018, The Linux Foundation. All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -144,6 +144,7 @@ struct clk_dyn_rcg {
  * @cmd_rcgr: corresponds to *_CMD_RCGR
  * @mnd_width: number of bits in m/n/d values
  * @hid_width: number of bits in half integer divider
+ * @flags: additional flag parameters for the RCG
  * @parent_map: map from software's parent index to hardware's src_sel field
  * @freq_tbl: frequency table
  * @clkr: regmap clock handle
@@ -153,6 +154,8 @@ struct clk_rcg2 {
 	u32			cmd_rcgr;
 	u8			mnd_width;
 	u8			hid_width;
+	u8			flags;
+#define DFS_ENABLE_RCG		BIT(0)
 	const struct parent_map	*parent_map;
 	const struct freq_tbl	*freq_tbl;
 	struct clk_regmap	clkr;
@@ -168,4 +171,6 @@ struct clk_rcg2 {
 extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;

+extern int clk_rcg2_get_dfs_clock_rate(struct clk_rcg2 *clk,
+						struct device *dev);
 #endif
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e63db10..7c35bca 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -18,6 +18,7 @@
 #include <linux/export.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/regmap.h>
 #include <linux/math64.h>

@@ -48,6 +49,14 @@
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
@@ -122,6 +131,10 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
 	int ret;
 	u32 cfg = rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;

+	/* In DFS mode skip updating the RCG CFG */
+	if (rcg->flags & DFS_ENABLE_RCG)
+		return 0;
+
 	ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
 				 CFG_SRC_SEL_MASK, cfg);
 	if (ret)
@@ -296,6 +309,9 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;

+	if (rcg->flags & DFS_ENABLE_RCG)
+		return -EPERM;
+
 	switch (policy) {
 	case FLOOR:
 		f = qcom_find_freq_floor(rcg->freq_tbl, rate);
@@ -790,3 +806,159 @@ static int clk_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
 	.determine_rate = clk_gfx3d_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_gfx3d_ops);
+
+/* Common APIs to be used for DFS based RCGR */
+static u8 clk_parent_index_pre_div_and_mode(struct clk_hw *hw, u32 offset,
+		u32 *mode, u32 *pre_div)
+{
+	struct clk_rcg2 *rcg;
+	int num_parents;
+	u32 cfg, mask;
+	int i, ret;
+
+	if (!hw)
+		return -EINVAL;
+
+	num_parents = clk_hw_get_num_parents(hw);
+
+	rcg = to_clk_rcg2(hw);
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
+		u32 mode, u32 *m, u32 *n)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	u32 val, mask;
+	int ret = 0;
+
+	if (!hw)
+		return -EINVAL;
+
+	*m = *n = 0;
+
+	if (mode) {
+		/* Calculate M & N values */
+		mask = BIT(rcg->mnd_width) - 1;
+		ret =  regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + m_offset,
+					&val);
+		if (ret) {
+			pr_err("Failed to read M offset register\n");
+			goto err;
+		}
+
+		val &= mask;
+		*m  = val;
+
+		ret =  regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + n_offset,
+					&val);
+		if (ret) {
+			pr_err("Failed to read N offset register\n");
+			goto err;
+		}
+
+		/* val ~(N-M) */
+		val = ~val;
+		val &= mask;
+		val += *m;
+		*n = val;
+	}
+err:
+	return ret;
+}
+
+int clk_rcg2_get_dfs_clock_rate(struct clk_rcg2 *clk, struct device *dev)
+{
+	int i, j, index, ret = 0;
+	unsigned long calc_freq, prate;
+	u32 val, pre_div = 0, mode = 0, m = 0, n = 0;
+	struct freq_tbl *dfs_freq_tbl;
+	struct clk_hw *phw;
+
+	if (!clk)
+		return -EINVAL;
+
+	/* Check for DFS_EN */
+	ret = regmap_read(clk->clkr.regmap, clk->cmd_rcgr + SE_CMD_DFSR_OFFSET,
+						&val);
+	if (ret) {
+		dev_err(dev, "Failed to read DFS enable register\n");
+		return -EINVAL;
+	}
+
+	if (!(val & SE_CMD_DFS_EN))
+		return ret;
+
+	dfs_freq_tbl = devm_kzalloc(dev, MAX_PERF_LEVEL *
+				sizeof(struct freq_tbl), GFP_KERNEL);
+	if (!dfs_freq_tbl)
+		return -ENOMEM;
+
+	/* Populate the Perf Level */
+	for (i = 0; i < MAX_PERF_LEVEL; i++) {
+		/* Get parent index and mode */
+		index = clk_parent_index_pre_div_and_mode(&clk->clkr.hw,
+							SE_PERF_DFSR(i), &mode,
+							&pre_div);
+		if (index < 0) {
+			pr_err("Failed to get parent index & mode %d\n", index);
+			return index;
+		}
+
+		/* clock pre_div */
+		dfs_freq_tbl[i].pre_div = pre_div;
+
+		/* Fill the parent src */
+		dfs_freq_tbl[i].src = clk->parent_map[index].src;
+
+		/* Get the parent clock and parent rate */
+		phw = clk_hw_get_parent_by_index(&clk->clkr.hw, index);
+		prate = clk_hw_get_rate(phw);
+
+		ret = calculate_m_and_n(&clk->clkr.hw, SE_PERF_M_DFSR(i),
+					SE_PERF_N_DFSR(i), mode, &m, &n);
+		if (ret)
+			goto err;
+
+		dfs_freq_tbl[i].m = m;
+		dfs_freq_tbl[i].n = n;
+
+		/* calculate the final frequency */
+		calc_freq = calc_rate(prate, dfs_freq_tbl[i].m,
+						dfs_freq_tbl[i].n, mode,
+						dfs_freq_tbl[i].pre_div);
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
+	j = i;
+
+	clk->flags |= DFS_ENABLE_RCG;
+	clk->freq_tbl = dfs_freq_tbl;
+err:
+	return ret;
+}
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index b8064a3..b27699b 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2013-2014, 2018, The Linux Foundation. All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -288,4 +288,25 @@ int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
 }
 EXPORT_SYMBOL_GPL(qcom_cc_probe);

+int qcom_cc_register_rcg_dfs(struct platform_device *pdev,
+			 const struct qcom_cc_dfs_desc *desc)
+{
+	struct clk_dfs *clks = desc->clks;
+	size_t num_clks = desc->num_clks;
+	int i, ret = 0;
+
+	for (i = 0; i < num_clks; i++) {
+		ret = clk_rcg2_get_dfs_clock_rate(clks[i].rcg, &pdev->dev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed calculating DFS frequencies for %s\n",
+				clk_hw_get_name(&(clks[i].rcg)->clkr.hw));
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(qcom_cc_register_rcg_dfs);
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 00196ee..6627aec 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2014, 2018, The Linux Foundation. All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -48,6 +48,15 @@ struct parent_map {
 	u8 cfg;
 };

+struct clk_dfs {
+	struct clk_rcg2 *rcg;
+};
+
+struct qcom_cc_dfs_desc {
+	struct clk_dfs *clks;
+	size_t num_clks;
+};
+
 extern const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f,
 					     unsigned long rate);
 extern const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
@@ -69,4 +78,7 @@ extern int qcom_cc_really_probe(struct platform_device *pdev,
 extern int qcom_cc_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc);

+extern int qcom_cc_register_rcg_dfs(struct platform_device *pdev,
+			 const struct qcom_cc_dfs_desc *desc);
+
 #endif
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
