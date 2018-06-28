Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4B5C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFC9272E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DUSE3DWE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NowV7L5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFC9272E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965774AbeF1LsE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:48:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42722 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753649AbeF1Lr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:47:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 034FB60B1E; Thu, 28 Jun 2018 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530186479;
        bh=SiKs+xSaCTsJn3OMCGhp9Id8PaSpsGM6UPezVkRrFG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUSE3DWEqnOpfQJl9BwwcO2lCs073PzYiqQJvhJnGBzl7Vi6v36rhJrRotS8xLypb
         /gurg0+U8Gwx5BkupvgRHHaYCWwcHFWczbJOMzZ9SWGQiDyp+OKfxNlN3c5/T1GLFZ
         zAFPInPz7m75oGIYqCONuFp15AACvkFD+2wEw0iA=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84AF8608C8;
        Thu, 28 Jun 2018 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530186478;
        bh=SiKs+xSaCTsJn3OMCGhp9Id8PaSpsGM6UPezVkRrFG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NowV7L5iOYcILODrxTNKY3p0l0isTVNyvUchia9790yJap5hAVvN6SQUShe1n/NJK
         fOEci2+qRCMqWqbNZQir2nmUDdlLoTA0c4Pkh3xF8tGHVekTgcjWHz3FR3D0G75MR9
         8UuT4wRwTLoatkaPkkctDo0NmD5IHZVDEDlun+fE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84AF8608C8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 1/2] clk: qcom: Add support for RCG to register for DFS
Date:   Thu, 28 Jun 2018 17:17:30 +0530
Message-Id: <1530186451-24648-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530186451-24648-1-git-send-email-tdas@codeaurora.org>
References: <1530186451-24648-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic Frequency switch is a feature of clock controller by which request
from peripherals allows automatic switching frequency of input clock.
There are various performance levels associated to a root clock generator.
Register the root clock generators(RCG) to switch to use the dfs clock ops
in the cases where DFS is enabled.
The DFS clock ops would at runtime read the clock perf level registers to
identify the frequencies supported and update the frequency table
accordingly.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h  |   5 ++
 drivers/clk/qcom/clk-rcg2.c | 214 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c   |  14 +--
 drivers/clk/qcom/common.h   |  16 +---
 4 files changed, 224 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index b209a2f..05e3584 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -5,6 +5,7 @@
 #define __QCOM_CLK_RCG_H__

 #include <linux/clk-provider.h>
+#include <linux/platform_device.h>
 #include "clk-regmap.h"

 struct freq_tbl {
@@ -160,5 +161,9 @@ struct clk_rcg2 {
 extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;
 extern const struct clk_ops clk_rcg2_shared_ops;
+extern const struct clk_ops clk_rcg2_dfs_ops;
+
+extern int qcom_cc_register_rcg_dfs(struct platform_device *pdev,
+			     struct clk_rcg2 **rcgs, int num_clks);

 #endif
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 52208d4..25b0560 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/regmap.h>
 #include <linux/math64.h>
+#include <linux/slab.h>

 #include <asm/div64.h>

@@ -40,6 +41,14 @@
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
@@ -929,3 +938,208 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
+
+/* Common APIs to be used for DFS based RCGR */
+static int clk_rcg2_calculate_m_and_n(struct clk_hw *hw, u32 *mode,
+		unsigned long *prate, int level, struct freq_tbl *f)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct clk_hw *phw;
+	u32 val, mask, cfg, m_off, n_off, offset;
+	int i, ret, num_parents;
+
+	offset = SE_PERF_DFSR(level);
+	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + offset, &cfg);
+	if (ret)
+		return ret;
+
+	mask = BIT(rcg->hid_width) - 1;
+	f->pre_div = cfg & mask ? (cfg & mask) : 1;
+
+	*mode = cfg & CFG_MODE_MASK;
+	*mode >>= CFG_MODE_SHIFT;
+
+	cfg &= CFG_SRC_SEL_MASK;
+	cfg >>= CFG_SRC_SEL_SHIFT;
+
+	num_parents = clk_hw_get_num_parents(hw);
+	for (i = 0; i < num_parents; i++) {
+		if (cfg == rcg->parent_map[i].cfg) {
+			f->src = rcg->parent_map[i].src;
+			phw = clk_hw_get_parent_by_index(&rcg->clkr.hw, i);
+			*prate = clk_hw_get_rate(phw);
+		}
+	}
+
+	if (!*mode)
+		return 0;
+
+	/* Calculate M & N values */
+	m_off = SE_PERF_M_DFSR(level);
+	n_off = SE_PERF_N_DFSR(level);
+
+	mask = BIT(rcg->mnd_width) - 1;
+	ret =  regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + m_off, &val);
+	if (ret) {
+		pr_err("Failed to read M offset register\n");
+		return ret;
+	}
+	val &= mask;
+	f->m  = val;
+
+	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + n_off, &val);
+	if (ret) {
+		pr_err("Failed to read N offset register\n");
+		return ret;
+	}
+	/* val ~(N-M) */
+	val = ~val;
+	val &= mask;
+	val += f->m;
+	f->n = val;
+
+	return 0;
+}
+
+static int clk_rcg2_dfs_populate_freq_table(struct clk_rcg2 *rcg)
+{
+	struct freq_tbl *dfs_freq_tbl;
+	int i, j, ret = 0;
+	unsigned long calc_freq, prate = 0;
+	u32 mode = 0;
+
+	dfs_freq_tbl = kcalloc(MAX_PERF_LEVEL, sizeof(struct freq_tbl),
+				GFP_KERNEL);
+	if (!dfs_freq_tbl)
+		return -ENOMEM;
+
+	for (i = 0; i < MAX_PERF_LEVEL; i++) {
+		ret = clk_rcg2_calculate_m_and_n(&rcg->clkr.hw, &mode, &prate,
+						 i, &dfs_freq_tbl[i]);
+		if (ret) {
+			kfree(dfs_freq_tbl);
+			return ret;
+		}
+
+		calc_freq = calc_rate(prate, dfs_freq_tbl[i].m,
+					dfs_freq_tbl[i].n, mode,
+					dfs_freq_tbl[i].pre_div);
+
+		/* Check for duplicate frequencies to end table */
+		for (j = 0; j  < i; j++) {
+			if (dfs_freq_tbl[j].freq == calc_freq)
+				goto done;
+		}
+
+		dfs_freq_tbl[i].freq = calc_freq;
+	}
+done:
+	rcg->freq_tbl = dfs_freq_tbl;
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
+	if (rcg->freq_tbl == NULL) {
+		ret = clk_rcg2_dfs_populate_freq_table(rcg);
+		if (ret) {
+			pr_err("Failed to update DFS tables\n");
+			return ret;
+		}
+	}
+
+	return clk_rcg2_shared_ops.determine_rate(hw, req);
+}
+
+static int clk_rcg2_dfs_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long prate)
+{
+	return 0;
+}
+
+static unsigned long
+clk_rcg2_dfs_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	return 0;
+}
+
+const struct clk_ops clk_rcg2_dfs_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.recalc_rate = clk_rcg2_dfs_recalc_rate,
+	.determine_rate = clk_rcg2_dfs_determine_rate,
+	.set_rate = clk_rcg2_dfs_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_dfs_ops);
+
+static int clk_rcg2_enable_dfs(struct clk_rcg2 *rcg, struct device *dev)
+{
+	struct regmap *regmap;
+	struct clk_init_data *init;
+	struct clk_rate_request req = { };
+	u32 val;
+	int ret;
+
+	regmap = dev_get_regmap(dev, NULL);
+	if (!regmap)
+		return -EINVAL;
+
+	init = kzalloc(sizeof(struct clk_init_data), GFP_KERNEL);
+	if (!init)
+		return -ENOMEM;
+
+	init->name = rcg->clkr.hw.init->name;
+	init->ops = &clk_rcg2_shared_ops;
+	init->flags = rcg->clkr.hw.init->flags;
+	init->parent_names = rcg->clkr.hw.init->parent_names;
+	init->num_parents = rcg->clkr.hw.init->num_parents;
+	rcg->clkr.hw.init = init;
+
+	ret = regmap_read(regmap, rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET,
+			  &val);
+	if (ret) {
+		dev_err(dev, "Failed to read DFS enable register\n");
+		return -EINVAL;
+	}
+
+	if (!(val & SE_CMD_DFS_EN))
+		return 0;
+
+	init->ops = &clk_rcg2_dfs_ops;
+	rcg->clkr.hw.init = init;
+	rcg->freq_tbl = NULL;
+
+	/*
+	 * In case the clocks are registered earlier than determine the dfs
+	 * rates.
+	 */
+	if (__clk_lookup(rcg->clkr.hw.init->name))
+		return clk_rcg2_dfs_determine_rate(&rcg->clkr.hw, &req);
+
+	return 0;
+}
+
+int qcom_cc_register_rcg_dfs(struct platform_device *pdev,
+			    struct clk_rcg2 **rcgs, int num_clks)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < num_clks; i++) {
+		ret = clk_rcg2_enable_dfs(rcgs[i], &pdev->dev);
+		if (ret) {
+			const char *name = rcgs[i]->clkr.hw.init->name;
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
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 39ce64c..958d27c 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
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
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2013-2014, The Linux Foundation. All rights reserved. */

 #include <linux/export.h>
 #include <linux/module.h>
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 00196ee..52d2dce 100644
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

@@ -68,5 +59,4 @@ extern int qcom_cc_really_probe(struct platform_device *pdev,
 				struct regmap *regmap);
 extern int qcom_cc_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc);
-
 #endif
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

