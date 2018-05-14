Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeENNMm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:12:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44562 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeENNMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:12:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8212B60AF9
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
Subject: [PATCH v6 05/14] clk: qcom: cpu-8996: Add support to switch to alternate PLL
Date: Mon, 14 May 2018 16:11:51 +0300
Message-Id: <1526303520-5843-6-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Each of the CPU clusters on msm8996 are powered via a primary
PLL and a secondary PLL. The primary PLL is what drives the
CPU clk, except for times when we are reprogramming the PLL
itself, when we temporarily switch to an alternate PLL.
Use clock rate change notifiers to support this.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/clk/qcom/clk-cpu-8996.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index beb97eb..390b369 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -61,6 +61,7 @@
  * detect voltage droops. We do not add support for ACD as yet.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -187,10 +188,14 @@ struct clk_cpu_8996_mux {
 	u32	reg;
 	u8	shift;
 	u8	width;
+	struct notifier_block nb;
 	struct clk_hw	*pll;
 	struct clk_regmap clkr;
 };
 
+#define to_clk_cpu_8996_mux_nb(_nb) \
+	container_of(_nb, struct clk_cpu_8996_mux, nb)
+
 static inline
 struct clk_cpu_8996_mux *to_clk_cpu_8996_mux_hw(struct clk_hw *hw)
 {
@@ -236,6 +241,26 @@ static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
+int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
+			void *data)
+{
+	int ret;
+	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_nb(nb);
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
+		break;
+	case POST_RATE_CHANGE:
+		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, PLL_INDEX);
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	return notifier_from_errno(ret);
+};
 const struct clk_ops clk_cpu_8996_mux_ops = {
 	.set_parent = clk_cpu_8996_mux_set_parent,
 	.get_parent = clk_cpu_8996_mux_get_parent,
@@ -279,6 +304,7 @@ static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
 	.shift = 0,
 	.width = 2,
 	.pll = &pwrcl_pll.clkr.hw,
+	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "pwrcl_pmux",
 		.parent_names = (const char *[]){
@@ -298,6 +324,7 @@ static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
 	.shift = 0,
 	.width = 2,
 	.pll = &perfcl_pll.clkr.hw,
+	.nb.notifier_call = cpu_clk_notifier_cb,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "perfcl_pmux",
 		.parent_names = (const char *[]){
@@ -356,6 +383,12 @@ struct clk_regmap *clks[] = {
 	clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
 	clk_alpha_pll_configure(&pwrcl_alt_pll, regmap, &altpll_config);
 
+	ret = clk_notifier_register(pwrcl_pmux.clkr.hw.clk, &pwrcl_pmux.nb);
+	if (ret)
+		return ret;
+
+	ret = clk_notifier_register(perfcl_pmux.clkr.hw.clk, &perfcl_pmux.nb);
+
 	return ret;
 }
 
-- 
1.9.1
