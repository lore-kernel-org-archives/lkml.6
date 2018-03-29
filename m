Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeC2Va1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 17:30:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeC2V1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 17:27:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2CED610D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: rnayak@codeaurora.org, ilialin@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: [PATCH v4 07/14] clk: qcom: Add ACD path to CPU clock driver for msm8996
Date: Fri, 30 Mar 2018 00:26:40 +0300
Message-Id: <1522358807-10413-8-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMUX for each duplex allows for selection of ACD clock source.
The DVM (Dynamic Variation Monitor) will flag an error
when a voltage droop event is detected. This flagged error
enables ACD to provide a div-by-2 clock, sourced from the primary PLL.
The duplex will be provided the divided clock
until a pre-programmed delay has expired.

This change configures ACD during the probe and switches
the PMUXes to the ACD clock source.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/clk/qcom/clk-cpu-8996.c | 75 +++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index 064a3fe..9a43bdf 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -63,9 +63,11 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <soc/qcom/kryo-l2-accessors.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-regmap.h"
@@ -79,6 +81,11 @@ enum _pmux_input {
 };
 
 #define DIV_2_THRESHOLD		600000000
+#define PWRCL_REG_OFFSET 0x0
+#define PERFCL_REG_OFFSET 0x80000
+#define MUX_OFFSET	0x40
+#define ALT_PLL_OFFSET	0x100
+#define SSSCTL_OFFSET 0x160
 
 static const u8 prim_pll_regs[PLL_OFF_MAX_REGS] = {
        [PLL_OFF_L_VAL] = 0x04,
@@ -117,7 +124,7 @@ enum _pmux_input {
 };
 
 static struct clk_alpha_pll perfcl_pll = {
-	.offset = 0x80000,
+	.offset = PERFCL_REG_OFFSET,
 	.regs = prim_pll_regs,
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data){
@@ -129,7 +136,7 @@ enum _pmux_input {
 };
 
 static struct clk_alpha_pll pwrcl_pll = {
-	.offset = 0x0,
+	.offset = PWRCL_REG_OFFSET,
 	.regs = prim_pll_regs,
 	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
 	.clkr.hw.init = &(struct clk_init_data){
@@ -159,7 +166,7 @@ enum _pmux_input {
 };
 
 static struct clk_alpha_pll perfcl_alt_pll = {
-	.offset = 0x80100,
+	.offset = PERFCL_REG_OFFSET + ALT_PLL_OFFSET,
 	.regs = alt_pll_regs,
 	.vco_table = alt_pll_vco_modes,
 	.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
@@ -173,7 +180,7 @@ enum _pmux_input {
 };
 
 static struct clk_alpha_pll pwrcl_alt_pll = {
-	.offset = 0x100,
+	.offset = PWRCL_REG_OFFSET + ALT_PLL_OFFSET,
 	.regs = alt_pll_regs,
 	.vco_table = alt_pll_vco_modes,
 	.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
@@ -186,6 +193,9 @@ enum _pmux_input {
 	},
 };
 
+void __iomem *base;
+static void qcom_cpu_clk_msm8996_acd_init(void __iomem *base);
+
 /* Mux'es */
 
 struct clk_cpu_8996_mux {
@@ -263,6 +273,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 	switch (event) {
 	case PRE_RATE_CHANGE:
 		ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
+		qcom_cpu_clk_msm8996_acd_init(base);
 		break;
 	case POST_RATE_CHANGE:
 		if (cnd->new_rate < DIV_2_THRESHOLD)
@@ -270,7 +281,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 							  DIV_2_INDEX);
 		else
 			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
-							  PLL_INDEX);
+							  ACD_INDEX);
 		break;
 	default:
 		ret = 0;
@@ -286,7 +297,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 };
 
 static struct clk_cpu_8996_mux pwrcl_smux = {
-	.reg = 0x40,
+	.reg = PWRCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 2,
 	.width = 2,
 	.clkr.hw.init = &(struct clk_init_data) {
@@ -302,7 +313,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 };
 
 static struct clk_cpu_8996_mux perfcl_smux = {
-	.reg = 0x80040,
+	.reg = PERFCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 2,
 	.width = 2,
 	.clkr.hw.init = &(struct clk_init_data) {
@@ -318,7 +329,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 };
 
 static struct clk_cpu_8996_mux pwrcl_pmux = {
-	.reg = 0x40,
+	.reg = PWRCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 0,
 	.width = 2,
 	.pll = &pwrcl_pll.clkr.hw,
@@ -339,7 +350,7 @@ int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 };
 
 static struct clk_cpu_8996_mux perfcl_pmux = {
-	.reg = 0x80040,
+	.reg = PERFCL_REG_OFFSET + MUX_OFFSET,
 	.shift = 0,
 	.width = 2,
 	.pll = &perfcl_pll.clkr.hw,
@@ -403,6 +414,10 @@ struct clk_regmap *clks[] = {
 	clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
 	clk_alpha_pll_configure(&pwrcl_alt_pll, regmap, &altpll_config);
 
+	/* Enable alt PLLs */
+	clk_prepare_enable(pwrcl_alt_pll.clkr.hw.clk);
+	clk_prepare_enable(perfcl_alt_pll.clkr.hw.clk);
+
 	ret = clk_notifier_register(pwrcl_pmux.clkr.hw.clk, &pwrcl_pmux.nb);
 	if (ret)
 		return ret;
@@ -412,10 +427,48 @@ struct clk_regmap *clks[] = {
 	return ret;
 }
 
+#define CPU_AFINITY_MASK 0xFFF
+#define PWRCL_CPU_REG_MASK 0x3
+#define PERFCL_CPU_REG_MASK 0x103
+
+#define L2ACDCR_REG 0x580ULL
+#define L2ACDTD_REG 0x581ULL
+#define L2ACDDVMRC_REG 0x584ULL
+#define L2ACDSSCR_REG 0x589ULL
+
+static DEFINE_SPINLOCK(acd_lock);
+
+static void qcom_cpu_clk_msm8996_acd_init(void __iomem *base)
+{
+	u64 hwid;
+	unsigned long flags;
+
+	spin_lock_irqsave(&acd_lock, flags);
+
+	hwid = read_cpuid_mpidr() & CPU_AFINITY_MASK;
+
+	set_l2_indirect_reg(L2ACDTD_REG, 0x00006A11);
+	set_l2_indirect_reg(L2ACDDVMRC_REG, 0x000E0F0F);
+	set_l2_indirect_reg(L2ACDSSCR_REG, 0x00000601);
+
+	if (PWRCL_CPU_REG_MASK == (hwid | PWRCL_CPU_REG_MASK)) {
+		writel(0xF, base + PWRCL_REG_OFFSET + SSSCTL_OFFSET);
+		wmb();
+		set_l2_indirect_reg(L2ACDCR_REG, 0x002C5FFD);
+	}
+
+	if (PERFCL_CPU_REG_MASK == (hwid | PERFCL_CPU_REG_MASK)) {
+		set_l2_indirect_reg(L2ACDCR_REG, 0x002C5FFD);
+		writel(0xF, base + PERFCL_REG_OFFSET + SSSCTL_OFFSET);
+		wmb();
+	}
+
+	spin_unlock_irqrestore(&acd_lock, flags);
+}
+
 static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
 {
 	int ret;
-	void __iomem *base;
 	struct resource *res;
 	struct regmap *regmap;
 	struct clk_hw_onecell_data *data;
@@ -439,6 +492,8 @@ static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	qcom_cpu_clk_msm8996_acd_init(base);
+
 	data->hws[0] = &pwrcl_pmux.clkr.hw;
 	data->hws[1] = &perfcl_pmux.clkr.hw;
 	data->num = 2;
-- 
1.9.1
