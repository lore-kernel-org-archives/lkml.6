Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbeD3QUl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:20:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbeD3QUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:20:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E24C60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v6 1/3] clk: qcom: Configure the RCGs to a safe source as needed
Date: Mon, 30 Apr 2018 21:50:08 +0530
Message-Id: <1525105210-8689-2-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525105210-8689-1-git-send-email-anischal@codeaurora.org>
References: <1525105210-8689-1-git-send-email-anischal@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some root clock generators, there could be child branches which are
controlled by an entity other than application processor subsystem. For
such RCGs, as per application processor subsystem clock driver, all of
its downstream clocks are disabled and RCG is in disabled state but in
reality downstream clocks can be left enabled before.

So in this scenario, when RCG is disabled as per clock driver's point of
view and when rate scaling request comes before downstream clock enable
request, then RCG fails to update its configuration because in reality
RCG is on and it expects its new source to already be in enable state but
in reality new source is off. In order to avoid having the RCG to go into
an invalid state, add support to update the CFG, M, N and D registers
during set_rate() without configuration update and defer the actual RCG
configuration update to be done during clk_enable() as at this point of
time, both its new parent and safe source will be already enabled and RCG
can safely switch to new parent.

During clk_disable() request, configure it to safe source as both its
parents, safe source and current parent will be enabled and RCG can
safely execute a switch.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h  |   7 +-
 drivers/clk/qcom/clk-rcg2.c | 207 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 207 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 2a7489a..f795b3e 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2013, 2018, The Linux Foundation. All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -144,8 +144,10 @@ struct clk_dyn_rcg {
  * @cmd_rcgr: corresponds to *_CMD_RCGR
  * @mnd_width: number of bits in m/n/d values
  * @hid_width: number of bits in half integer divider
+ * @safe_src_index: safe src index value
  * @parent_map: map from software's parent index to hardware's src_sel field
  * @freq_tbl: frequency table
+ * @current_freq_tbl: Stores current frequency freq_tbl when using shared RCGs
  * @clkr: regmap clock handle
  *
  */
@@ -153,8 +155,10 @@ struct clk_rcg2 {
 	u32			cmd_rcgr;
 	u8			mnd_width;
 	u8			hid_width;
+	u8			safe_src_index;
 	const struct parent_map	*parent_map;
 	const struct freq_tbl	*freq_tbl;
+	const struct freq_tbl	*current_freq_tbl;
 	struct clk_regmap	clkr;
 };

@@ -167,5 +171,6 @@ struct clk_rcg2 {
 extern const struct clk_ops clk_byte2_ops;
 extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;
+extern const struct clk_ops clk_rcg2_shared_ops;

 #endif
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e63db10..4a23a7b 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -249,7 +249,8 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
 	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, FLOOR);
 }

-static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
+static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f,
+				bool update_rcg_config)
 {
 	u32 cfg, mask;
 	struct clk_hw *hw = &rcg->clkr.hw;
@@ -287,6 +288,9 @@ static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 	if (ret)
 		return ret;

+	if (!update_rcg_config)
+		return 0;
+
 	return update_config(rcg);
 }

@@ -310,7 +314,7 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!f)
 		return -EINVAL;

-	return clk_rcg2_configure(rcg, f);
+	return clk_rcg2_configure(rcg, f, true);
 }

 static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -419,7 +423,7 @@ static int clk_edp_pixel_set_rate(struct clk_hw *hw, unsigned long rate,
 		f.m = frac->num;
 		f.n = frac->den;

-		return clk_rcg2_configure(rcg, &f);
+		return clk_rcg2_configure(rcg, &f, true);
 	}

 	return -EINVAL;
@@ -523,7 +527,7 @@ static int clk_byte_set_rate(struct clk_hw *hw, unsigned long rate,

 	f.pre_div = div;

-	return clk_rcg2_configure(rcg, &f);
+	return clk_rcg2_configure(rcg, &f, true);
 }

 static int clk_byte_set_rate_and_parent(struct clk_hw *hw,
@@ -589,7 +593,7 @@ static int clk_byte2_set_rate(struct clk_hw *hw, unsigned long rate,
 	for (i = 0; i < num_parents; i++) {
 		if (cfg == rcg->parent_map[i].cfg) {
 			f.src = rcg->parent_map[i].src;
-			return clk_rcg2_configure(rcg, &f);
+			return clk_rcg2_configure(rcg, &f, true);
 		}
 	}

@@ -682,7 +686,7 @@ static int clk_pixel_set_rate(struct clk_hw *hw, unsigned long rate,
 		f.m = frac->num;
 		f.n = frac->den;

-		return clk_rcg2_configure(rcg, &f);
+		return clk_rcg2_configure(rcg, &f, true);
 	}
 	return -EINVAL;
 }
@@ -790,3 +794,194 @@ static int clk_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
 	.determine_rate = clk_gfx3d_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_gfx3d_ops);
+
+static int clk_rcg2_set_force_enable(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const char *name = clk_hw_get_name(hw);
+	int ret, count;
+
+	/* Force enable bit */
+	ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
+				 CMD_ROOT_EN, CMD_ROOT_EN);
+	if (ret)
+		return ret;
+
+	/* wait for RCG to turn ON */
+	for (count = 500; count > 0; count--) {
+		if (clk_rcg2_is_enabled(hw))
+			return 0;
+
+		/* Delay for 1usec and retry polling the status bit */
+		udelay(1);
+	}
+	if (!count)
+		pr_err("%s: RCG did not turn on\n", name);
+
+	return -ETIMEDOUT;
+}
+
+static int clk_rcg2_clear_force_enable(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/* Clear force enable bit */
+	return regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
+					CMD_ROOT_EN, 0);
+}
+
+static int
+clk_rcg2_shared_force_enable_clear(struct clk_hw *hw, const struct freq_tbl *f)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int ret;
+
+	if (!f)
+		return -EINVAL;
+
+	ret = clk_rcg2_set_force_enable(hw);
+	if (ret)
+		return ret;
+
+	ret = clk_rcg2_configure(rcg, f, true);
+	if (ret)
+		return ret;
+
+	return clk_rcg2_clear_force_enable(hw);
+}
+
+static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_tbl *f;
+
+	f = qcom_find_freq(rcg->freq_tbl, rate);
+	if (!f)
+		return -EINVAL;
+
+	/*
+	 * Store freq_tbl corresponding to requested rate in case disable() op
+	 * clears the cached registers - disable() gets call after set_rate().
+	 */
+	rcg->current_freq_tbl = f;
+
+	/*
+	 * In case clock is disabled, update the CFG, M, N and D registers
+	 * and do not hit the update bit of CMD register.
+	 */
+	if (!__clk_is_enabled(hw->clk))
+		/* Skip the configuration update */
+		return clk_rcg2_configure(rcg, rcg->current_freq_tbl, false);
+
+	return clk_rcg2_shared_force_enable_clear(hw, rcg->current_freq_tbl);
+}
+
+static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return clk_rcg2_shared_set_rate(hw, rate, parent_rate);
+}
+
+static unsigned long
+clk_rcg2_shared_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	if (!__clk_is_enabled(hw->clk) && rcg->current_freq_tbl)
+		return rcg->current_freq_tbl->freq;
+
+	return clk_rcg2_recalc_rate(hw, parent_rate);
+}
+
+static int clk_rcg2_shared_enable(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct freq_tbl safe_src_tbl = { 0 };
+	int ret;
+	u32 cfg_src;
+
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg_src);
+
+	cfg_src = cfg_src & CFG_SRC_SEL_MASK;
+	cfg_src >>= CFG_SRC_SEL_SHIFT;
+
+	if (!rcg->current_freq_tbl) {
+		/*
+		 * In the case where clk_enable() would be called
+		 * without a clk_set_rate(), check for RCG configuration
+		 * if done previously.
+		 */
+
+		if (cfg_src)
+			return 0;
+
+		/*
+		 * Configure RCG to safe_src, if following conditions
+		 * holds true:
+		 * - Bootloader configures the RCG to run from safe_src.
+		 * - RCG's frequency table does not hold entry for
+		 *   safe_src speed.
+		 */
+		safe_src_tbl.src = rcg->safe_src_index;
+		return clk_rcg2_shared_force_enable_clear(hw, &safe_src_tbl);
+	}
+
+	/*
+	 * Switch from safe source to the stashed mux selection. The current
+	 * parent has already been prepared and enabled at this point, and
+	 * the safe source is always on while application processor subsystem
+	 * is online. Therefore, the RCG can safely switch its source.
+	 */
+
+	if (!cfg_src)
+		/*
+		 * Reconfigure the RCG if cached registers are overwritten
+		 * by clk_disable() after clk_set_rate().
+		 */
+		return clk_rcg2_shared_force_enable_clear(hw,
+						rcg->current_freq_tbl);
+
+	/*
+	 * Set the update bit only as other required configuration has been
+	 * already done inside set_rate().
+	 */
+	ret = clk_rcg2_set_force_enable(hw);
+	if (ret)
+		return ret;
+
+	ret = update_config(rcg);
+	if (ret)
+		return ret;
+
+	return clk_rcg2_clear_force_enable(hw);
+}
+
+static void clk_rcg2_shared_disable(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct freq_tbl safe_src_tbl = { 0 };
+
+	/*
+	 * Park the RCG at a safe configuration - sourced off from safe source.
+	 * Force enable and disable the RCG while configuring it to safeguard
+	 * against any update signal coming from the downstream clock.
+	 * The current parent is still prepared and enabled at this point, and
+	 * the safe source is always on while application processor subsystem
+	 * is online. Therefore, the RCG can safely switch its parent.
+	 */
+	safe_src_tbl.src = rcg->safe_src_index;
+	clk_rcg2_shared_force_enable_clear(hw, &safe_src_tbl);
+}
+
+const struct clk_ops clk_rcg2_shared_ops = {
+	.enable = clk_rcg2_shared_enable,
+	.disable = clk_rcg2_shared_disable,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_shared_recalc_rate,
+	.determine_rate = clk_rcg2_determine_rate,
+	.set_rate = clk_rcg2_shared_set_rate,
+	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
