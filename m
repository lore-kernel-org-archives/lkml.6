Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeAaK4J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 05:56:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752382AbeAaK4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 05:56:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7545A6053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH 3/4] clk: qcom: Add support for controlling Fabia PLL
Date: Wed, 31 Jan 2018 16:24:34 +0530
Message-Id: <1517396075-29297-4-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517396075-29297-1-git-send-email-anischal@codeaurora.org>
References: <1517396075-29297-1-git-send-email-anischal@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fabia PLL is a Digital Frequency Locked Loop (DFLL) clock
generator which has a wide range of frequency output. It
supports dynamic updating of the output frequency
("frequency slewing") without need to turn off the PLL
before configuration. Add support for initial configuration
and programming sequence to control fabia PLLs.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 322 ++++++++++++++++++++++++++++++++++++++-
 drivers/clk/qcom/clk-alpha-pll.h |  16 ++
 2 files changed, 332 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 6d04cd9..530b25a 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -58,6 +58,8 @@
 #define PLL_TEST_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_TEST_CTL])
 #define PLL_TEST_CTL_U(p)	((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U])
 #define PLL_STATUS(p)		((p)->offset + (p)->regs[PLL_OFF_STATUS])
+#define PLL_OPMODE(p)		((p)->offset + (p)->regs[PLL_OFF_OPMODE])
+#define PLL_FRAC(p)		((p)->offset + (p)->regs[PLL_OFF_FRAC])
 
 const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 	[CLK_ALPHA_PLL_TYPE_DEFAULT] =  {
@@ -90,6 +92,18 @@
 		[PLL_OFF_TEST_CTL] = 0x1c,
 		[PLL_OFF_STATUS] = 0x24,
 	},
+	[CLK_ALPHA_PLL_TYPE_FABIA] =  {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_USER_CTL] = 0x0c,
+		[PLL_OFF_USER_CTL_U] = 0x10,
+		[PLL_OFF_CONFIG_CTL] = 0x14,
+		[PLL_OFF_CONFIG_CTL_U] = 0x18,
+		[PLL_OFF_TEST_CTL] = 0x1c,
+		[PLL_OFF_TEST_CTL_U] = 0x20,
+		[PLL_OFF_STATUS] = 0x24,
+		[PLL_OFF_OPMODE] = 0x2c,
+		[PLL_OFF_FRAC] = 0x38,
+	},
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
@@ -108,6 +122,12 @@
 #define PLL_HUAYRA_N_MASK		0xff
 #define PLL_HUAYRA_ALPHA_WIDTH		16
 
+#define FABIA_OPMODE_STANDBY	0x0
+#define FABIA_OPMODE_RUN	0x1
+
+#define FABIA_PLL_OUT_MASK	0x7
+#define FABIA_PLL_RATE_MARGIN	500
+
 #define pll_alpha_width(p)					\
 		((PLL_ALPHA_VAL_U(p) - PLL_ALPHA_VAL(p) == 4) ?	\
 				 ALPHA_REG_BITWIDTH : ALPHA_REG_16BIT_WIDTH)
@@ -441,16 +461,12 @@ static void clk_alpha_pll_disable(struct clk_hw *hw)
 	return alpha_pll_calc_rate(prate, l, a, alpha_width);
 }
 
-static int clk_alpha_pll_update_latch(struct clk_alpha_pll *pll,
-				      int (*is_enabled)(struct clk_hw *))
+
+static int __clk_alpha_pll_update_latch(struct clk_alpha_pll *pll)
 {
 	int ret;
 	u32 mode;
 
-	if (!is_enabled(&pll->clkr.hw) ||
-	    !(pll->flags & SUPPORTS_DYNAMIC_UPDATE))
-		return 0;
-
 	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &mode);
 
 	/* Latch the input to the PLL */
@@ -489,6 +505,16 @@ static int clk_alpha_pll_update_latch(struct clk_alpha_pll *pll,
 	return 0;
 }
 
+static int clk_alpha_pll_update_latch(struct clk_alpha_pll *pll,
+				      int (*is_enabled)(struct clk_hw *))
+{
+	if (!is_enabled(&pll->clkr.hw) ||
+	    !(pll->flags & SUPPORTS_DYNAMIC_UPDATE))
+		return 0;
+
+	return __clk_alpha_pll_update_latch(pll);
+}
+
 static int __clk_alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 				    unsigned long prate,
 				    int (*is_enabled)(struct clk_hw *))
@@ -832,3 +858,287 @@ static int clk_alpha_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 	.recalc_rate = clk_alpha_pll_postdiv_recalc_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_ro_ops);
+
+void clk_fabia_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			     const struct alpha_pll_config *config)
+{
+	u32 val, mask;
+
+	if (config->l)
+		regmap_write(regmap, PLL_L_VAL(pll), config->l);
+
+	if (config->alpha)
+		regmap_write(regmap, PLL_FRAC(pll), config->alpha);
+
+	if (config->config_ctl_val)
+		regmap_write(regmap, PLL_CONFIG_CTL(pll),
+						config->config_ctl_val);
+
+	if (config->post_div_mask) {
+		mask = config->post_div_mask;
+		val = config->post_div_val;
+		regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
+	}
+
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_UPDATE_BYPASS,
+							PLL_UPDATE_BYPASS);
+
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+}
+
+static int alpha_pll_fabia_enable(struct clk_hw *hw)
+{
+	int ret;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val, opmode_val;
+
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
+
+	/* If in FSM mode, just vote for it */
+	if (val & PLL_VOTE_FSM_ENA) {
+		ret = clk_enable_regmap(hw);
+		if (ret)
+			return ret;
+		return wait_for_pll_enable_active(pll);
+	}
+
+	/* Read opmode value */
+	ret = regmap_read(pll->clkr.regmap, PLL_OPMODE(pll), &opmode_val);
+	if (ret)
+		return ret;
+
+	/* Skip If PLL is already running */
+	if ((opmode_val & FABIA_OPMODE_RUN) && (val & PLL_OUTCTRL))
+		return 0;
+
+	/* Disable PLL output */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
+							PLL_OUTCTRL, 0);
+	if (ret)
+		return ret;
+
+	/* Set Operation mode to STANBY */
+	ret = regmap_write(pll->clkr.regmap, PLL_OPMODE(pll),
+							FABIA_OPMODE_STANDBY);
+	if (ret)
+		return ret;
+
+	/* PLL should be in STANDBY mode before continuing */
+	mb();
+
+	/* Bring PLL out of reset */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
+						PLL_RESET_N, PLL_RESET_N);
+	if (ret)
+		return ret;
+
+	/* Set Operation mode to RUN */
+	ret = regmap_write(pll->clkr.regmap, PLL_OPMODE(pll),
+							FABIA_OPMODE_RUN);
+	if (ret)
+		return ret;
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Enable the main PLL output */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+				FABIA_PLL_OUT_MASK, FABIA_PLL_OUT_MASK);
+	if (ret)
+		return ret;
+
+	/* Enable PLL outputs */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
+						PLL_OUTCTRL, PLL_OUTCTRL);
+	if (ret)
+		return ret;
+
+	/* Ensure that the write above goes through before returning. */
+	mb();
+
+	return ret;
+}
+
+static void alpha_pll_fabia_disable(struct clk_hw *hw)
+{
+	int ret;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val;
+
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return;
+
+	/* If in FSM mode, just unvote it */
+	if (val & PLL_FSM_ENA) {
+		clk_disable_regmap(hw);
+		return;
+	}
+
+	/* Disable PLL outputs */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
+							PLL_OUTCTRL, 0);
+	if (ret)
+		return;
+
+	/* Disable main outputs */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+							FABIA_PLL_OUT_MASK, 0);
+	if (ret)
+		return;
+
+	/* Place the PLL in STANDBY */
+	ret = regmap_write(pll->clkr.regmap, PLL_OPMODE(pll),
+							FABIA_OPMODE_STANDBY);
+	if (ret)
+		return;
+}
+
+static unsigned long alpha_pll_fabia_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l, frac, alpha_width = pll_alpha_width(pll);
+
+	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
+	regmap_read(pll->clkr.regmap, PLL_FRAC(pll), &frac);
+
+	return alpha_pll_calc_rate(parent_rate, l, frac, alpha_width);
+}
+
+static int alpha_pll_fabia_set_rate(struct clk_hw *hw, unsigned long rate,
+						unsigned long prate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val, l, alpha_width = pll_alpha_width(pll);
+	u64 a;
+	unsigned long rrate;
+	int ret = 0;
+
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
+
+	rrate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
+
+	/*
+	 * Due to limited number of bits for fractional rate programming, the
+	 * rounded up rate could be marginally higher than the requested rate.
+	 */
+	if (rrate > (rate + FABIA_PLL_RATE_MARGIN) || rrate < rate) {
+		pr_err("Call set rate on the PLL with rounded rates!\n");
+		return -EINVAL;
+	}
+
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_write(pll->clkr.regmap, PLL_FRAC(pll), a);
+
+	return __clk_alpha_pll_update_latch(pll);
+}
+
+const struct clk_ops clk_alpha_pll_fabia_ops = {
+	.enable = alpha_pll_fabia_enable,
+	.disable = alpha_pll_fabia_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.set_rate = alpha_pll_fabia_set_rate,
+	.recalc_rate = alpha_pll_fabia_recalc_rate,
+	.round_rate = clk_alpha_pll_round_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fabia_ops);
+
+const struct clk_ops clk_alpha_pll_fixed_fabia_ops = {
+	.enable = alpha_pll_fabia_enable,
+	.disable = alpha_pll_fabia_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = alpha_pll_fabia_recalc_rate,
+	.round_rate = clk_alpha_pll_round_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_fabia_ops);
+
+static unsigned long clk_alpha_pll_postdiv_fabia_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	u32 i, div = 1, val;
+	int ret;
+
+	if (!pll->post_div_table) {
+		pr_err("Missing the post_div_table for the PLL\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return ret;
+
+	val >>= pll->post_div_shift;
+	val &= BIT(pll->width) - 1;
+
+	for (i = 0; i < pll->num_post_div; i++) {
+		if (pll->post_div_table[i].val == val) {
+			div = pll->post_div_table[i].div;
+			break;
+		}
+	}
+
+	return (parent_rate / div);
+}
+
+static long clk_alpha_pll_postdiv_fabia_round_rate(struct clk_hw *hw,
+				unsigned long rate, unsigned long *prate)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+
+	if (!pll->post_div_table) {
+		pr_err("Missing the post_div_table for the PLL\n");
+		return -EINVAL;
+	}
+
+	return divider_round_rate(hw, rate, prate, pll->post_div_table,
+				pll->width, CLK_DIVIDER_ROUND_CLOSEST);
+}
+
+static int clk_alpha_pll_postdiv_fabia_set_rate(struct clk_hw *hw,
+				unsigned long rate, unsigned long parent_rate)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	int i, val = 0, div, ret;
+
+	/*
+	 * If the PLL is in FSM mode, then treat set_rate callback as a
+	 * no-operation.
+	 */
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
+
+	if (val & PLL_VOTE_FSM_ENA)
+		return 0;
+
+	if (!pll->post_div_table) {
+		pr_err("Missing the post_div_table for the PLL\n");
+		return -EINVAL;
+	}
+
+	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	for (i = 0; i < pll->num_post_div; i++) {
+		if (pll->post_div_table[i].div == div) {
+			val = pll->post_div_table[i].val;
+			break;
+		}
+	}
+
+	return regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+				(BIT(pll->width) - 1) << pll->post_div_shift,
+				val << pll->post_div_shift);
+}
+
+const struct clk_ops clk_alpha_pll_postdiv_fabia_ops = {
+	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
+	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_fabia_ops);
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 7593e8a..45d68b4 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -22,6 +22,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_DEFAULT,
 	CLK_ALPHA_PLL_TYPE_HUAYRA,
 	CLK_ALPHA_PLL_TYPE_BRAMMO,
+	CLK_ALPHA_PLL_TYPE_FABIA,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
@@ -36,6 +37,8 @@ enum {
 	PLL_OFF_TEST_CTL,
 	PLL_OFF_TEST_CTL_U,
 	PLL_OFF_STATUS,
+	PLL_OFF_OPMODE,
+	PLL_OFF_FRAC,
 	PLL_OFF_MAX_REGS
 };
 
@@ -73,6 +76,10 @@ struct clk_alpha_pll {
  * @offset: base address of registers
  * @regs: alpha pll register map (see @clk_alpha_pll_regs)
  * @width: width of post-divider
+ * @post_div_shift: shift to differentiate between odd & even post-divider
+ * @post_div_table: table with PLL odd and even post-divider settings
+ * @num_post_div: Number of PLL post-divider settings
+ *
  * @clkr: regmap clock handle
  */
 struct clk_alpha_pll_postdiv {
@@ -81,6 +88,9 @@ struct clk_alpha_pll_postdiv {
 	const u8 *regs;
 
 	struct clk_regmap clkr;
+	int post_div_shift;
+	const struct clk_div_table *post_div_table;
+	size_t num_post_div;
 };
 
 struct alpha_pll_config {
@@ -109,7 +119,13 @@ struct alpha_pll_config {
 extern const struct clk_ops clk_alpha_pll_huayra_ops;
 extern const struct clk_ops clk_alpha_pll_postdiv_ro_ops;
 
+extern const struct clk_ops clk_alpha_pll_fabia_ops;
+extern const struct clk_ops clk_alpha_pll_fixed_fabia_ops;
+extern const struct clk_ops clk_alpha_pll_postdiv_fabia_ops;
+
 void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 			     const struct alpha_pll_config *config);
+void clk_fabia_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				const struct alpha_pll_config *config);
 
 #endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
