Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeENNMs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:12:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeENNMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:12:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 684D66085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        rjw@rjwysocki.net, linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rnayak@codeaurora.org, ilialin@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: [PATCH v6 06/14] clk: qcom: cpu-8996: Add support to switch below 600Mhz
Date: Mon, 14 May 2018 16:11:52 +0300
Message-Id: <1526303520-5843-7-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

The CPU clock controller's primary PLL operates on a single VCO range,
between 600MHz and 3GHz. However the CPUs do support OPPs with
frequencies between 300MHz and 600MHz. In order to support running the
CPUs at those frequencies we end up having to lock the PLL at twice the
rate and drive the CPU clk via the PLL/2 output and SMUX.

So for frequencies above 600MHz we follow the following path
 Primary PLL --> PLL_EARLY --> PMUX(1) --> CPU clk
and for frequencies between 300MHz and 600MHz we follow
 Primary PLL --> PLL/2 --> SMUX(1) --> PMUX(0) --> CPU clk

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>

Conflicts:
	drivers/clk/qcom/clk-cpu-8996.c
---
 drivers/clk/qcom/clk-cpu-8996.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index 390b369..3ea0446 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -77,6 +77,8 @@ enum _pmux_input {
 	NUM_OF_PMUX_INPUTS
 };
 
+#define DIV_2_THRESHOLD		600000000
+
 static const u8 prim_pll_regs[PLL_OFF_MAX_REGS] = {
        [PLL_OFF_L_VAL] = 0x04,
        [PLL_OFF_ALPHA_VAL] = 0x08,
@@ -104,10 +106,11 @@ enum _pmux_input {
 
 static const struct alpha_pll_config hfpll_config = {
 	.l = 60,
-	.config_ctl_val = 0x200d4828,
+	.config_ctl_val = 0x200d4aa8,
 	.config_ctl_hi_val = 0x006,
 	.pre_div_mask = BIT(12),
 	.post_div_mask = 0x3 << 8,
+	.post_div_val = 0x1 << 8,
 	.main_output_mask = BIT(0),
 	.early_output_mask = BIT(3),
 };
@@ -149,7 +152,7 @@ enum _pmux_input {
 	.vco_mask = 0x3 << 20,
 	.config_ctl_val = 0x4001051b,
 	.post_div_mask = 0x3 << 8,
-	.post_div_val = 0x1,
+	.post_div_val = 0x1 << 8,
 	.main_output_mask = BIT(0),
 	.early_output_mask = BIT(3),
 };
@@ -190,6 +193,7 @@ struct clk_cpu_8996_mux {
 	u8	width;
 	struct notifier_block nb;
 	struct clk_hw	*pll;
+	struct clk_hw	*pll_div_2;
 	struct clk_regmap clkr;
 };
 
@@ -235,6 +239,13 @@ static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
 	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
 	struct clk_hw *parent = cpuclk->pll;
 
+	if (cpuclk->pll_div_2 && req->rate < DIV_2_THRESHOLD) {
+		if (req->rate < (DIV_2_THRESHOLD / 2))
+			return -EINVAL;
+
+		parent = cpuclk->pll_div_2;
+	}
+
 	req->best_parent_rate = clk_hw_round_rate(parent, req->rate);
 	req->best_parent_hw = parent;
 
@@ -246,13 +257,19 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 {
 	int ret;
 	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_nb(nb);
+	struct clk_notifier_data *cnd = data;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
 		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
 		break;
 	case POST_RATE_CHANGE:
-		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, PLL_INDEX);
+		if (cnd->new_rate < DIV_2_THRESHOLD)
+			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
+							  DIV_2_INDEX);
+		else
+			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
+							  PLL_INDEX);
 		break;
 	default:
 		ret = 0;
@@ -304,6 +321,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 	.shift = 0,
 	.width = 2,
 	.pll = &pwrcl_pll.clkr.hw,
+	.pll_div_2 = &pwrcl_smux.clkr.hw,
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "pwrcl_pmux",
@@ -324,6 +342,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 	.shift = 0,
 	.width = 2,
 	.pll = &perfcl_pll.clkr.hw,
+	.pll_div_2 = &perfcl_smux.clkr.hw,
 	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "perfcl_pmux",
-- 
1.9.1
