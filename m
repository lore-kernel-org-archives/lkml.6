Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB69ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A4F2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IqwDZwC2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J4uxKREG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A4F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeGPGDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:03:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59288 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeGPGDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:03:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 460DB60B72; Mon, 16 Jul 2018 05:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531719486;
        bh=9E9CCoHfsk0/FgGSo4rQCO0sCuGGDi4ZjLxcMlehZ9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqwDZwC2hqkCI1EY7XGHBT9nH2j+A3Sn7MtGlDqJgBF1p3akpYWYfSYEXcB2gm0Ui
         og9TDcQj50nV/g1HmBlHxsN9XQDWpB4WC+TMl10Y0f92hx0NO7PXGGhUqN8ZIeTsxa
         XubM2IUQUrrLABZQMQjAtq6kBnw5v414ZkKvVNvg=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 027EC60B7B;
        Mon, 16 Jul 2018 05:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531719485;
        bh=9E9CCoHfsk0/FgGSo4rQCO0sCuGGDi4ZjLxcMlehZ9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4uxKREGyAeql0N1HHEBoboPKsBeSZEhoUwGrLc6vjvGX+5H8hYWi6i2SnvY+zN3S
         VCMmPXLGCXp7JbppJpTlZDZ8uigOqTGVDTcgzU3YwzU/v9QPRIuuog2xPvSOWm6YIF
         pNp+EXPqlcaRjcxioJxbHdWrilA4F+16TDpTwwfk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 027EC60B7B
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
Subject: [PATCH v3 1/2] clk: qcom: Add support for RCG to register for DFS
Date:   Mon, 16 Jul 2018 11:07:47 +0530
Message-Id: <1531719468-8458-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531719468-8458-1-git-send-email-tdas@codeaurora.org>
References: <1531719468-8458-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic Frequency switch is a feature of clock controller by which request
from peripherals allows automatic switching frequency of input clock
without SW intervention. There are various performance levels associated
with a root clock. When the input performance state changes, the source
clocks and division ratios of the new performance state are loaded on to
RCG via HW and the RCG switches to new clock frequency when the RCG is in
DFS HW enabled mode.

Register the root clock generators(RCG) to switch to use the dfs clock ops
in the cases where DFS is enabled. The clk_round_rate() called by the clock
consumer would invoke the dfs determine clock ops and would read the DFS
performance level registers to identify all the frequencies supported and
update the frequency table. The DFS clock consumers would maintain these
frequency mapping and request the desired performance levels.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h  |   2 +
 drivers/clk/qcom/clk-rcg2.c | 173 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index b209a2f..bffb625 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -161,4 +161,6 @@ struct clk_rcg2 {
 extern const struct clk_ops clk_gfx3d_ops;
 extern const struct clk_ops clk_rcg2_shared_ops;

+extern int qcom_cc_register_rcg_dfs(struct regmap *regmap,
+			     struct clk_rcg2 **rcgs, int num_clks);
 #endif
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 52208d4..f8f1417 100644
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
+#define MAX_PERF_LEVEL		8
+#define SE_CMD_DFSR_OFFSET	0x14
+#define SE_CMD_DFS_EN		BIT(0)
+#define SE_PERF_DFSR(level)	(0x1c + 0x4 * (level))
+#define SE_PERF_M_DFSR(level)	(0x5c + 0x4 * (level))
+#define SE_PERF_N_DFSR(level)	(0x9c + 0x4 * (level))
+
 enum freq_policy {
 	FLOOR,
 	CEIL,
@@ -929,3 +938,167 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
+
+/* Common APIs to be used for DFS based RCGR */
+static unsigned long clk_rcg2_calculate_freq(struct clk_hw *hw,
+		int level, struct freq_tbl *f)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct clk_hw *p;
+	unsigned long prate = 0;
+	u32 val, mask, cfg, m_off, n_off, offset, mode;
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
+	mode = cfg & CFG_MODE_MASK;
+	mode >>= CFG_MODE_SHIFT;
+
+	cfg &= CFG_SRC_SEL_MASK;
+	cfg >>= CFG_SRC_SEL_SHIFT;
+
+	num_parents = clk_hw_get_num_parents(hw);
+	for (i = 0; i < num_parents; i++) {
+		if (cfg == rcg->parent_map[i].cfg) {
+			f->src = rcg->parent_map[i].src;
+			p = clk_hw_get_parent_by_index(&rcg->clkr.hw, i);
+			prate = clk_hw_get_rate(p);
+		}
+	}
+
+	if (!mode)
+		goto done;
+
+	/* Calculate M & N values */
+	m_off = SE_PERF_M_DFSR(level);
+	n_off = SE_PERF_N_DFSR(level);
+
+	mask = BIT(rcg->mnd_width) - 1;
+	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + m_off, &val);
+	if (ret) {
+		pr_err("Failed to read M offset register\n");
+		return ret;
+	}
+	val &= mask;
+	f->m = val;
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
+done:
+	return calc_rate(prate, f->m, f->n, mode, f->pre_div);
+}
+
+static int clk_rcg2_dfs_populate_freq_table(struct clk_rcg2 *rcg)
+{
+	struct freq_tbl *freq_tbl;
+	unsigned long calc_freq;
+	int i;
+
+	freq_tbl = kcalloc(MAX_PERF_LEVEL, sizeof(*freq_tbl),
+				GFP_KERNEL);
+	if (!freq_tbl)
+		return -ENOMEM;
+
+	for (i = 0; i < MAX_PERF_LEVEL; i++) {
+		calc_freq = clk_rcg2_calculate_freq(&rcg->clkr.hw,
+							i, &freq_tbl[i]);
+		if (calc_freq < 0) {
+			kfree(freq_tbl);
+			return calc_freq;
+		}
+
+		freq_tbl[i].freq = calc_freq;
+	}
+	rcg->freq_tbl = freq_tbl;
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
+	if (!rcg->freq_tbl) {
+		ret = clk_rcg2_dfs_populate_freq_table(rcg);
+		if (ret) {
+			pr_err("Failed to update DFS tables for %s\n",
+					clk_hw_get_name(hw));
+			return ret;
+		}
+	}
+
+	return clk_rcg2_shared_ops.determine_rate(hw, req);
+}
+
+static const struct clk_ops clk_rcg2_dfs_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.determine_rate = clk_rcg2_dfs_determine_rate,
+};
+
+static int clk_rcg2_enable_dfs(struct clk_rcg2 *rcg, struct regmap *regmap)
+{
+	struct clk_init_data *init;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET,
+			  &val);
+	if (ret)
+		return -EINVAL;
+
+	if (!(val & SE_CMD_DFS_EN))
+		return 0;
+
+	init = kzalloc(sizeof(*init), GFP_KERNEL);
+	if (!init)
+		return -ENOMEM;
+
+	init->name = rcg->clkr.hw.init->name;
+	init->flags = rcg->clkr.hw.init->flags;
+	init->parent_names = rcg->clkr.hw.init->parent_names;
+	init->num_parents = rcg->clkr.hw.init->num_parents;
+	init->ops = &clk_rcg2_dfs_ops;
+
+	rcg->clkr.hw.init = init;
+	rcg->freq_tbl = NULL;
+
+	pr_debug("DFS registered for clk %s\n", init->name);
+
+	return 0;
+}
+
+int qcom_cc_register_rcg_dfs(struct regmap *regmap,
+			    struct clk_rcg2 **rcgs, int num_clks)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < num_clks; i++) {
+		ret = clk_rcg2_enable_dfs(rcgs[i], regmap);
+		if (ret) {
+			const char *name = rcgs[i]->clkr.hw.init->name;
+
+			pr_err("DFS register failed for clk %s\n", name);
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_cc_register_rcg_dfs);
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

