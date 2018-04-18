Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeDRNfM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:35:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752624AbeDRNfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:35:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 840506071A
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
        linux-kernel@vger.kernel.org, Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v5 1/2] clk: qcom: Configure the RCGs to a safe source as needed
Date: Wed, 18 Apr 2018 19:04:32 +0530
Message-Id: <1524058473-15860-2-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524058473-15860-1-git-send-email-anischal@codeaurora.org>
References: <1524058473-15860-1-git-send-email-anischal@codeaurora.org>
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
RCG is on and it expects its new source to alredy be in enable state but
in reality new source is off. In order to avoid having the RCG to go into
an invalid state, add support to cache the rate of RCG during set_rate(),
defer actual RCG configuration update to be done during clk_enable() as
at this point of time, both its new parent and safe source will be
already enabled and RCG can safely switch to new parent.

During clk_disable() request, configure it to safe source as both its
parents, safe source and current parent will be enabled and RCG can
safely execute a switch. Also add support to have safe configuration
frequency table structure for each shared RCG.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h  |   7 +-
 drivers/clk/qcom/clk-rcg2.c | 173 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 2a7489a..9d9d59d 100644
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
+ * @current_freq: last cached frequency when using branches with shared RCGs
  * @clkr: regmap clock handle
  *
  */
@@ -153,8 +155,10 @@ struct clk_rcg2 {
 	u32			cmd_rcgr;
 	u8			mnd_width;
 	u8			hid_width;
+	const u8		safe_src_index;
 	const struct parent_map	*parent_map;
 	const struct freq_tbl	*freq_tbl;
+	unsigned long		current_freq;
 	struct clk_regmap	clkr;
 };

@@ -167,5 +171,6 @@ struct clk_rcg2 {
 extern const struct clk_ops clk_byte2_ops;
 extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;
+extern const struct clk_ops clk_rcg2_shared_ops;

 #endif
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 984de9c..4d971bf 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2013, 2018 The Linux Foundation. All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -790,3 +790,174 @@ static int clk_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
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
+clk_rcg2_shared_force_enable_clear(struct clk_hw *hw, unsigned long rate)
+{
+	int ret;
+
+	ret = clk_rcg2_set_force_enable(hw);
+	if (ret)
+		return ret;
+
+	/* set clock rate */
+	ret = __clk_rcg2_set_rate(hw, rate, CEIL);
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
+	int ret;
+
+	/*
+	 * Return if the RCG is currently disabled. This configuration
+	 * update will happen as part of the RCG enable sequence.
+	 */
+	if (!__clk_is_enabled(hw->clk)) {
+		rcg->current_freq = rate;
+		return 0;
+	}
+
+	ret = clk_rcg2_shared_force_enable_clear(hw, rate);
+	if (ret)
+		return ret;
+
+	/* Update current frequency with the requested frequency. */
+	rcg->current_freq = rate;
+
+	return ret;
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
+	if (!__clk_is_enabled(hw->clk) && rcg->current_freq)
+		return rcg->current_freq;
+
+	return rcg->current_freq = clk_rcg2_recalc_rate(hw, parent_rate);
+}
+
+static unsigned long clk_rcg2_get_safe_src_rate(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int index;
+
+	index = qcom_find_src_index(hw, rcg->parent_map, rcg->safe_src_index);
+	if (index < 0)
+		index = 0;
+
+	return clk_hw_get_rate(clk_hw_get_parent_by_index(hw, index));
+}
+
+static int clk_rcg2_shared_enable(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct freq_tbl safe_src_freq_tbl = { 0 };
+
+	safe_src_freq_tbl.freq = clk_rcg2_get_safe_src_rate(hw);
+
+	if (rcg->current_freq == safe_src_freq_tbl.freq) {
+		safe_src_freq_tbl.src = rcg->safe_src_index;
+		/*
+		 * Reconfigure the RCG - Incase if any other sub system updates
+		 * the div or src without the knowledge of application processor
+		 * subsystem and RCG could run at different rate other than
+		 * software cached rate.
+		 */
+		clk_rcg2_set_force_enable(hw);
+		clk_rcg2_configure(rcg, &safe_src_freq_tbl);
+		clk_rcg2_clear_force_enable(hw);
+
+		return 0;
+	}
+
+	/*
+	 * Switch from safe source to the stashed mux selection. The current
+	 * parent has already been prepared and enabled at this point, and
+	 * the safe source is always on while application processor subsystem
+	 * is online. Therefore, the RCG can safely switch its source.
+	 */
+
+	return clk_rcg2_shared_force_enable_clear(hw, rcg->current_freq);
+}
+
+static void clk_rcg2_shared_disable(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct freq_tbl safe_src_freq_tbl = { 0 };
+
+	safe_src_freq_tbl.src = rcg->safe_src_index;
+	safe_src_freq_tbl.freq = clk_rcg2_get_safe_src_rate(hw);
+
+	/*
+	 * Park the RCG at a safe configuration - sourced off from safe source.
+	 * Force enable and disable the RCG while configuring it to safeguard
+	 * against any update signal coming from the downstream clock.
+	 * The current parent is still prepared and enabled at this point, and
+	 * the safe source is always on while application processor subsystem
+	 * is online. Therefore, the RCG can safely switch its parent.
+	 */
+	clk_rcg2_set_force_enable(hw);
+	clk_rcg2_configure(rcg, &safe_src_freq_tbl);
+	clk_rcg2_clear_force_enable(hw);
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
