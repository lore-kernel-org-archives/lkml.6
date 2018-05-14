Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932231AbeENNMc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:12:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932123AbeENNM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:12:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 373296055C
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
Subject: [PATCH v6 03/14] clk: qcom: Add CPU clock driver for msm8996
Date: Mon, 14 May 2018 16:11:49 +0300
Message-Id: <1526303520-5843-4-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each of the CPU clusters (Power and Perf) on msm8996 are
clocked via 2 PLLs, a primary and alternate. There are also
2 Mux'es, a primary and secondary all connected together
as shown below

                             +-------+
              XO             |       |
          +------------------>0      |
                             |       |
                   PLL/2     | SMUX  +----+
                     +------->1      |    |
                     |       |       |    |
                     |       +-------+    |    +-------+
                     |                    +---->0      |
                     |                         |       |
+---------------+    |             +----------->1      | CPU clk
|Primary PLL    +----+ PLL_EARLY   |           |       +------>
|               +------+-----------+    +------>2 PMUX |
+---------------+      |                |      |       |
                       |   +------+     |   +-->3      |
                       +--^+  ACD +-----+   |  +-------+
+---------------+          +------+         |
|Alt PLL        |                           |
|               +---------------------------+
+---------------+         PLL_EARLY

The primary PLL is what drives the CPU clk, except for times
when we are reprogramming the PLL itself (for rate changes) when
we temporarily switch to an alternate PLL. A subsequent patch adds
support to switch between primary and alternate PLL during rate
changes.

The primary PLL operates on a single VCO range, between 600MHz
and 3GHz. However the CPUs do support OPPs with frequencies
between 300MHz and 600MHz. In order to support running the CPUs
at those frequencies we end up having to lock the PLL at twice
the rate and drive the CPU clk via the PLL/2 output and SMUX.

So for frequencies above 600MHz we follow the following path
 Primary PLL --> PLL_EARLY --> PMUX(1) --> CPU clk
and for frequencies between 300MHz and 600MHz we follow
 Primary PLL --> PLL/2 --> SMUX(1) --> PMUX(0) --> CPU clk
Support for this is added in a subsequent patch as well.

ACD stands for Adaptive Clock Distribution and is used to
detect voltage droops. We do not add support for ACD as yet.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/clk/clk-fixed-factor.c   |   2 +-
 drivers/clk/qcom/Kconfig         |   9 +
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clk-alpha-pll.h |   6 +
 drivers/clk/qcom/clk-cpu-8996.c  | 412 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 429 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/qcom/clk-cpu-8996.c

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index a5d402d..8e39bda 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -94,7 +94,7 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 	init.num_parents = 1;
 
 	hw = &fix->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret) {
 		kfree(fix);
 		hw = ERR_PTR(ret);
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index e42e1af..866ce1f 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -33,6 +33,15 @@ config QCOM_CLK_APCS_MSM8916
 	  Say Y if you want to support CPU frequency scaling on devices
 	  such as msm8916.
 
+config QCOM_CLK_APCC_MSM8996
+	tristate "MSM8996 CPU Clock Controller"
+	depends on COMMON_CLK_QCOM
+	select QCOM_KRYO_L2_ACCESSORS
+	help
+	  Support for the CPU clock controller on msm8996 devices.
+	  Say Y if you want to support CPU clock scaling using CPUfreq
+	  drivers for dyanmic power management.
+
 config QCOM_CLK_RPM
 	tristate "RPM based Clock Controller"
 	depends on COMMON_CLK_QCOM && MFD_QCOM_RPM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 7c09ab1..a822fc8 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_MSM_MMCC_8974) += mmcc-msm8974.o
 obj-$(CONFIG_MSM_MMCC_8996) += mmcc-msm8996.o
 obj-$(CONFIG_QCOM_A53PLL) += a53-pll.o
 obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
+obj-$(CONFIG_QCOM_CLK_APCC_MSM8996) += clk-cpu-8996.o
 obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
 obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index f981b48..9ce2a32 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -50,6 +50,12 @@ struct pll_vco {
 	u32 val;
 };
 
+#define VCO(a, b, c) { \
+	.val = a,\
+	.min_freq = b,\
+	.max_freq = c,\
+}
+
 /**
  * struct clk_alpha_pll - phase locked loop (PLL)
  * @offset: base address of registers
diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
new file mode 100644
index 0000000..beb97eb
--- /dev/null
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/*
+ * Each of the CPU clusters (Power and Perf) on msm8996 are
+ * clocked via 2 PLLs, a primary and alternate. There are also
+ * 2 Mux'es, a primary and secondary all connected together
+ * as shown below
+ *
+ *                              +-------+
+ *               XO             |       |
+ *           +------------------>0      |
+ *                              |       |
+ *                    PLL/2     | SMUX  +----+
+ *                      +------->1      |    |
+ *                      |       |       |    |
+ *                      |       +-------+    |    +-------+
+ *                      |                    +---->0      |
+ *                      |                         |       |
+ * +---------------+    |             +----------->1      | CPU clk
+ * |Primary PLL    +----+ PLL_EARLY   |           |       +------>
+ * |               +------+-----------+    +------>2 PMUX |
+ * +---------------+      |                |      |       |
+ *                        |   +------+     |   +-->3      |
+ *                        +--^+  ACD +-----+   |  +-------+
+ * +---------------+          +------+         |
+ * |Alt PLL        |                           |
+ * |               +---------------------------+
+ * +---------------+         PLL_EARLY
+ *
+ * The primary PLL is what drives the CPU clk, except for times
+ * when we are reprogramming the PLL itself (for rate changes) when
+ * we temporarily switch to an alternate PLL. A subsequent patch adds
+ * support to switch between primary and alternate PLL during rate
+ * changes.
+ *
+ * The primary PLL operates on a single VCO range, between 600MHz
+ * and 3GHz. However the CPUs do support OPPs with frequencies
+ * between 300MHz and 600MHz. In order to support running the CPUs
+ * at those frequencies we end up having to lock the PLL at twice
+ * the rate and drive the CPU clk via the PLL/2 output and SMUX.
+ *
+ * So for frequencies above 600MHz we follow the following path
+ *  Primary PLL --> PLL_EARLY --> PMUX(1) --> CPU clk
+ * and for frequencies between 300MHz and 600MHz we follow
+ *  Primary PLL --> PLL/2 --> SMUX(1) --> PMUX(0) --> CPU clk
+ * Support for this is added in a subsequent patch as well.
+ *
+ * ACD stands for Adaptive Clock Distribution and is used to
+ * detect voltage droops. We do not add support for ACD as yet.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-regmap.h"
+
+enum _pmux_input {
+	DIV_2_INDEX = 0,
+	PLL_INDEX,
+	ACD_INDEX,
+	ALT_INDEX,
+	NUM_OF_PMUX_INPUTS
+};
+
+static const u8 prim_pll_regs[PLL_OFF_MAX_REGS] = {
+       [PLL_OFF_L_VAL] = 0x04,
+       [PLL_OFF_ALPHA_VAL] = 0x08,
+       [PLL_OFF_USER_CTL] = 0x10,
+       [PLL_OFF_CONFIG_CTL] = 0x18,
+       [PLL_OFF_CONFIG_CTL_U] = 0x1c,
+       [PLL_OFF_TEST_CTL] = 0x20,
+       [PLL_OFF_TEST_CTL_U] = 0x24,
+       [PLL_OFF_STATUS] = 0x28,
+};
+
+static const u8 alt_pll_regs[PLL_OFF_MAX_REGS] = {
+       [PLL_OFF_L_VAL] = 0x04,
+       [PLL_OFF_ALPHA_VAL] = 0x08,
+       [PLL_OFF_ALPHA_VAL_U] = 0x0c,
+       [PLL_OFF_USER_CTL] = 0x10,
+       [PLL_OFF_USER_CTL_U] = 0x14,
+       [PLL_OFF_CONFIG_CTL] = 0x18,
+       [PLL_OFF_TEST_CTL] = 0x20,
+       [PLL_OFF_TEST_CTL_U] = 0x24,
+       [PLL_OFF_STATUS] = 0x28,
+};
+
+/* PLLs */
+
+static const struct alpha_pll_config hfpll_config = {
+	.l = 60,
+	.config_ctl_val = 0x200d4828,
+	.config_ctl_hi_val = 0x006,
+	.pre_div_mask = BIT(12),
+	.post_div_mask = 0x3 << 8,
+	.main_output_mask = BIT(0),
+	.early_output_mask = BIT(3),
+};
+
+static struct clk_alpha_pll perfcl_pll = {
+	.offset = 0x80000,
+	.regs = prim_pll_regs,
+	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "perfcl_pll",
+		.parent_names = (const char *[]){ "xo" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_huayra_ops,
+	},
+};
+
+static struct clk_alpha_pll pwrcl_pll = {
+	.offset = 0x0,
+	.regs = prim_pll_regs,
+	.flags = SUPPORTS_DYNAMIC_UPDATE | SUPPORTS_FSM_MODE,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pwrcl_pll",
+		.parent_names = (const char *[]){ "xo" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_huayra_ops,
+	},
+};
+
+static const struct pll_vco alt_pll_vco_modes[] = {
+	VCO(3,  250000000,  500000000),
+	VCO(2,  500000000,  750000000),
+	VCO(1,  750000000, 1000000000),
+	VCO(0, 1000000000, 2150400000),
+};
+
+static const struct alpha_pll_config altpll_config = {
+	.l = 16,
+	.vco_val = 0x3 << 20,
+	.vco_mask = 0x3 << 20,
+	.config_ctl_val = 0x4001051b,
+	.post_div_mask = 0x3 << 8,
+	.post_div_val = 0x1,
+	.main_output_mask = BIT(0),
+	.early_output_mask = BIT(3),
+};
+
+static struct clk_alpha_pll perfcl_alt_pll = {
+	.offset = 0x80100,
+	.regs = alt_pll_regs,
+	.vco_table = alt_pll_vco_modes,
+	.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
+	.flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "perfcl_alt_pll",
+		.parent_names = (const char *[]){ "xo" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_hwfsm_ops,
+	},
+};
+
+static struct clk_alpha_pll pwrcl_alt_pll = {
+	.offset = 0x100,
+	.regs = alt_pll_regs,
+	.vco_table = alt_pll_vco_modes,
+	.num_vco = ARRAY_SIZE(alt_pll_vco_modes),
+	.flags = SUPPORTS_OFFLINE_REQ | SUPPORTS_FSM_MODE,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "pwrcl_alt_pll",
+		.parent_names = (const char *[]){ "xo" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_hwfsm_ops,
+	},
+};
+
+/* Mux'es */
+
+struct clk_cpu_8996_mux {
+	u32	reg;
+	u8	shift;
+	u8	width;
+	struct clk_hw	*pll;
+	struct clk_regmap clkr;
+};
+
+static inline
+struct clk_cpu_8996_mux *to_clk_cpu_8996_mux_hw(struct clk_hw *hw)
+{
+	return container_of(to_clk_regmap(hw), struct clk_cpu_8996_mux, clkr);
+}
+
+static u8 clk_cpu_8996_mux_get_parent(struct clk_hw *hw)
+{
+	u32 val;
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
+	u32 mask = (u32)GENMASK(cpuclk->width - 1, 0);
+
+	regmap_read(clkr->regmap, cpuclk->reg, &val);
+	val >>= (u32)(cpuclk->shift);
+
+	return (u8)(val & mask);
+}
+
+static int clk_cpu_8996_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	u32 val;
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
+	unsigned int mask = GENMASK(cpuclk->width + cpuclk->shift - 1,
+				    cpuclk->shift);
+
+	val = (u32)index;
+	val <<= (u32)(cpuclk->shift);
+
+	return regmap_update_bits(clkr->regmap, cpuclk->reg, mask, val);
+}
+
+static int
+clk_cpu_8996_mux_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
+	struct clk_hw *parent = cpuclk->pll;
+
+	req->best_parent_rate = clk_hw_round_rate(parent, req->rate);
+	req->best_parent_hw = parent;
+
+	return 0;
+}
+
+const struct clk_ops clk_cpu_8996_mux_ops = {
+	.set_parent = clk_cpu_8996_mux_set_parent,
+	.get_parent = clk_cpu_8996_mux_get_parent,
+	.determine_rate = clk_cpu_8996_mux_determine_rate,
+};
+
+static struct clk_cpu_8996_mux pwrcl_smux = {
+	.reg = 0x40,
+	.shift = 2,
+	.width = 2,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "pwrcl_smux",
+		.parent_names = (const char *[]){
+			"xo",
+			"pwrcl_pll_main",
+		},
+		.num_parents = 2,
+		.ops = &clk_cpu_8996_mux_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_cpu_8996_mux perfcl_smux = {
+	.reg = 0x80040,
+	.shift = 2,
+	.width = 2,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "perfcl_smux",
+		.parent_names = (const char *[]){
+			"xo",
+			"perfcl_pll_main",
+		},
+		.num_parents = 2,
+		.ops = &clk_cpu_8996_mux_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_cpu_8996_mux pwrcl_pmux = {
+	.reg = 0x40,
+	.shift = 0,
+	.width = 2,
+	.pll = &pwrcl_pll.clkr.hw,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "pwrcl_pmux",
+		.parent_names = (const char *[]){
+			"pwrcl_smux",
+			"pwrcl_pll",
+			"pwrcl_pll_acd",
+			"pwrcl_alt_pll",
+		},
+		.num_parents = 4,
+		.ops = &clk_cpu_8996_mux_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_cpu_8996_mux perfcl_pmux = {
+	.reg = 0x80040,
+	.shift = 0,
+	.width = 2,
+	.pll = &perfcl_pll.clkr.hw,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "perfcl_pmux",
+		.parent_names = (const char *[]){
+			"perfcl_smux",
+			"perfcl_pll",
+			"perfcl_pll_acd",
+			"perfcl_alt_pll",
+		},
+		.num_parents = 4,
+		.ops = &clk_cpu_8996_mux_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static const struct regmap_config cpu_msm8996_regmap_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	.max_register		= 0x80210,
+	.fast_io		= true,
+	.val_format_endian	= REGMAP_ENDIAN_LITTLE,
+};
+
+struct clk_regmap *clks[] = {
+	&perfcl_pll.clkr,
+	&pwrcl_pll.clkr,
+	&perfcl_alt_pll.clkr,
+	&pwrcl_alt_pll.clkr,
+	&perfcl_smux.clkr,
+	&pwrcl_smux.clkr,
+	&perfcl_pmux.clkr,
+	&pwrcl_pmux.clkr,
+};
+
+static int
+qcom_cpu_clk_msm8996_register_clks(struct device *dev, struct regmap *regmap)
+{
+	int i, ret;
+
+	perfcl_smux.pll = clk_hw_register_fixed_factor(dev, "perfcl_pll_main",
+						       "perfcl_pll",
+						   CLK_SET_RATE_PARENT, 1, 2);
+
+	pwrcl_smux.pll = clk_hw_register_fixed_factor(dev, "pwrcl_pll_main",
+						      "pwrcl_pll",
+						   CLK_SET_RATE_PARENT, 1, 2);
+
+	for (i = 0; i < ARRAY_SIZE(clks); i++) {
+		ret = devm_clk_register_regmap(dev, clks[i]);
+		if (ret)
+			return ret;
+	}
+
+	clk_alpha_pll_configure(&perfcl_pll, regmap, &hfpll_config);
+	clk_alpha_pll_configure(&pwrcl_pll, regmap, &hfpll_config);
+	clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
+	clk_alpha_pll_configure(&pwrcl_alt_pll, regmap, &altpll_config);
+
+	return ret;
+}
+
+static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
+{
+	int ret;
+	void __iomem *base;
+	struct resource *res;
+	struct regmap *regmap;
+	struct clk_hw_onecell_data *data;
+	struct device *dev = &pdev->dev;
+
+	data = devm_kzalloc(dev, sizeof(*data) + 2 * sizeof(struct clk_hw *),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(dev, base, &cpu_msm8996_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = qcom_cpu_clk_msm8996_register_clks(dev, regmap);
+	if (ret)
+		return ret;
+
+	data->hws[0] = &pwrcl_pmux.clkr.hw;
+	data->hws[1] = &perfcl_pmux.clkr.hw;
+	data->num = 2;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, data);
+}
+
+static const struct of_device_id qcom_cpu_clk_msm8996_match_table[] = {
+	{ .compatible = "qcom,msm8996-apcc" },
+	{}
+};
+
+static struct platform_driver qcom_cpu_clk_msm8996_driver = {
+	.probe = qcom_cpu_clk_msm8996_driver_probe,
+	.driver = {
+		.name = "qcom-msm8996-apcc",
+		.of_match_table = qcom_cpu_clk_msm8996_match_table,
+	},
+};
+module_platform_driver(qcom_cpu_clk_msm8996_driver);
+
+MODULE_ALIAS("platform:msm8996-apcc");
+MODULE_DESCRIPTION("QCOM MSM8996 CPU Clock Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
