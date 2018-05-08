Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753605AbeEHBLi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753505AbeEHBLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:11:36 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525690220-26525-2-git-send-email-anischal@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1525690220-26525-1-git-send-email-anischal@codeaurora.org>
 <1525690220-26525-2-git-send-email-anischal@codeaurora.org>
Message-ID: <152574189516.138124.5711696582182066656@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 1/3] clk: qcom: Configure the RCGs to a safe source as needed
Date: Mon, 07 May 2018 18:11:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w481BhT7003030

Quoting Amit Nischal (2018-05-07 03:50:18)
> For some root clock generators, there could be child branches which are
> controlled by an entity other than application processor subsystem. For
> such RCGs, as per application processor subsystem clock driver, all of
> its downstream clocks are disabled and RCG is in disabled state but in
> reality downstream clocks can be left enabled before.
> 
> So in this scenario, when RCG is disabled as per clock driver's point of
> view and when rate scaling request comes before downstream clock enable
> request, then RCG fails to update its configuration because in reality
> RCG is on and it expects its new source to already be in enable state but
> in reality new source is off. In order to avoid having the RCG to go into
> an invalid state, add support to update the CFG, M, N and D registers
> during set_rate() without configuration update and defer the actual RCG
> configuration update to be done during clk_enable() as at this point of
> time, both its new parent and safe source will be already enabled and RCG
> can safely switch to new parent.
> 
> During clk_disable() request, configure it to safe source as both its
> parents, safe source and current parent will be enabled and RCG can
> safely execute a switch.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---

Applied to clk-next. I squashed some style fixups and logic
simplifications in too.


diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 6827ab32c82c..e63911cbfef9 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -797,7 +797,6 @@ static int clk_rcg2_set_force_enable(struct clk_hw *hw)
 	const char *name = clk_hw_get_name(hw);
 	int ret, count;
 
-	/* Force enable bit */
 	ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
 				 CMD_ROOT_EN, CMD_ROOT_EN);
 	if (ret)
@@ -808,12 +807,10 @@ static int clk_rcg2_set_force_enable(struct clk_hw *hw)
 		if (clk_rcg2_is_enabled(hw))
 			return 0;
 
-		/* Delay for 1usec and retry polling the status bit */
 		udelay(1);
 	}
-	if (!count)
-		pr_err("%s: RCG did not turn on\n", name);
 
+	pr_err("%s: RCG did not turn on\n", name);
 	return -ETIMEDOUT;
 }
 
@@ -821,7 +818,6 @@ static int clk_rcg2_clear_force_enable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 
-	/* Clear force enable bit */
 	return regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
 					CMD_ROOT_EN, 0);
 }
@@ -832,9 +828,6 @@ clk_rcg2_shared_force_enable_clear(struct clk_hw *hw, const struct freq_tbl *f)
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	int ret;
 
-	if (!f)
-		return -EINVAL;
-
 	ret = clk_rcg2_set_force_enable(hw);
 	if (ret)
 		return ret;
@@ -858,10 +851,9 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	/*
 	 * In case clock is disabled, update the CFG, M, N and D registers
-	 * and do not hit the update bit of CMD register.
+	 * and don't hit the update bit of CMD register.
 	 */
 	if (!__clk_is_enabled(hw->clk))
-		/* Skip the configuration update */
 		return __clk_rcg2_configure(rcg, f);
 
 	return clk_rcg2_shared_force_enable_clear(hw, f);
@@ -879,8 +871,8 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
 	int ret;
 
 	/*
-	 * Set the update bit only.
-	 * As required configuration has been already written in set_rate() op.
+	 * Set the update bit because required configuration has already
+	 * been written in set_rate() op.
 	 */
 	ret = clk_rcg2_set_force_enable(hw);
 	if (ret)
@@ -899,8 +891,8 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 	u32 cfg;
 
 	/*
-	 * Store current configuration as switching to safe source
-	 * would clear the SRC and DIV of CFG register.
+	 * Store current configuration as switching to safe source would clear
+	 * the SRC and DIV of CFG register.
 	 */
 	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
 
@@ -915,7 +907,7 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 	clk_rcg2_set_force_enable(hw);
 
 	regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
-				rcg->safe_src_index << CFG_SRC_SEL_SHIFT);
+		     rcg->safe_src_index << CFG_SRC_SEL_SHIFT);
 
 	update_config(rcg);
 
