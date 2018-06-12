Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 85174C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2075820693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2075820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933246AbeFLFlT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:41:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:41743 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932619AbeFLFlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:41:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 22:41:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="48616021"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga008.jf.intel.com with ESMTP; 11 Jun 2018 22:41:09 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com
Cc:     linux-mips@linux-mips.org, qi-ming.wu@intel.com,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/7] clk: intel: Add clock driver for GRX500 SoC
Date:   Tue, 12 Jun 2018 13:40:29 +0800
Message-Id: <20180612054034.4969-3-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180612054034.4969-1-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yixin Zhu <yixin.zhu@linux.intel.com>

PLL of GRX500 provide clock to DDR, CPU, and peripherals as show below

                 +---------+
	    |--->| LCPLL3 0|--PCIe clk-->
   XO       |    +---------+
+-----------|
            |    +---------+
            |    |        3|--PAE clk-->
            |--->| PLL0B  2|--GSWIP clk-->
            |    |        1|--DDR clk-->DDR PHY clk-->
            |    |        0|--CPU1 clk--+   +-----+
            |    +---------+            |--->0    |
            |                               | MUX |--CPU clk-->
            |    +---------+            |--->1    |
            |    |        0|--CPU0 clk--+   +-----+
            |--->| PLLOA  1|--SSX4 clk-->
                 |        2|--NGI clk-->
                 |        3|--CBM clk-->
                 +---------+

VCO of all PLLs of GRX500 is not supposed to be reprogrammed.
DDR PHY clock is created to show correct clock rate in software
point of view.
CPU clock of 1Ghz from PLL0B otherwise from PLL0A.
Signed-off-by: Yixin Zhu <yixin.zhu@linux.intel.com>

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 .../devicetree/bindings/clock/intel,grx500-clk.txt |  46 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/intel/Kconfig                          |  21 +
 drivers/clk/intel/Makefile                         |   7 +
 drivers/clk/intel/clk-cgu-api.c                    | 676 +++++++++++++++++++++
 drivers/clk/intel/clk-cgu-api.h                    | 120 ++++
 drivers/clk/intel/clk-grx500.c                     | 236 +++++++
 include/dt-bindings/clock/intel,grx500-clk.h       |  61 ++
 9 files changed, 1169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
 create mode 100644 drivers/clk/intel/Kconfig
 create mode 100644 drivers/clk/intel/Makefile
 create mode 100644 drivers/clk/intel/clk-cgu-api.c
 create mode 100644 drivers/clk/intel/clk-cgu-api.h
 create mode 100644 drivers/clk/intel/clk-grx500.c
 create mode 100644 include/dt-bindings/clock/intel,grx500-clk.h

diff --git a/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
new file mode 100644
index 000000000000..dd761d900dc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
@@ -0,0 +1,46 @@
+Device Tree Clock bindings for GRX500 PLL controller.
+
+This binding uses the common clock binding:
+	Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+This GRX500 PLL controller provides the 5 main clock domain of the SoC: CPU/DDR, XBAR,
+Voice, WLAN, PCIe and gate clocks for HW modules.
+
+Required properties for osc clock node
+- compatible: Should be intel,grx500-xxx-clk
+- reg: offset address of the controller memory area.
+- clocks: phandle of the external reference clock
+- #clock-cells: can be one or zero.
+- clock-output-names: Names of the output clocks.
+
+Example:
+	pll0aclk: pll0aclk {
+		#clock-cells = <1>;
+		compatible = "intel,grx500-pll0a-clk";
+		clocks = <&pll0a>;
+		reg = <0x8>;
+		clock-output-names = "cbmclk", "ngiclk", "ssx4clk", "cpu0clk";
+	};
+
+	cpuclk: cpuclk {
+		#clock-cells = <0>;
+		compatible = "intel,grx500-cpu-clk";
+		clocks = <&pll0aclk CPU0_CLK>, <&pll0bclk CPU1_CLK>;
+		reg = <0x8>;
+		clock-output-names = "cpu";
+	};
+
+Required properties for gate node:
+- compatible: Should be intel,grx500-gatex-clk
+- reg: offset address of the controller memory area.
+- #clock-cells: Should be <1>
+- clock-output-names: Names of the output clocks.
+
+Example:
+	clkgate0: clkgate0 {
+		#clock-cells = <1>;
+		compatible = "intel,grx500-gate0-clk";
+		reg = <0x114>;
+		clock-output-names = "gate_xbar0", "gate_xbar1", "gate_xbar2",
+		"gate_xbar3", "gate_xbar6", "gate_xbar7";
+	};
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 34968a381d0f..9e2e19a1170a 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -280,6 +280,7 @@ config COMMON_CLK_STM32H7
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
+source "drivers/clk/intel/Kconfig"
 source "drivers/clk/keystone/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
 source "drivers/clk/meson/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index de6d06ac790b..ef3e270005a1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -105,3 +105,4 @@ obj-$(CONFIG_X86)			+= x86/
 endif
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
+obj-$(CONFIG_COMMON_CLK_INTEL)		+= intel/
diff --git a/drivers/clk/intel/Kconfig b/drivers/clk/intel/Kconfig
new file mode 100644
index 000000000000..d40a92ae7462
--- /dev/null
+++ b/drivers/clk/intel/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+config COMMON_CLK_INTEL
+	depends on COMMON_CLK
+	depends on INTEL_MIPS || COMPILE_TEST
+	select MFD_SYSCON
+	bool "Intel clock controller support"
+	help
+	  This driver support Intel GRX500 crystal oscillator clock
+	  using common clock framework.
+
+choice
+	prompt "SoC platform selection"
+	depends on COMMON_CLK_INTEL
+	default INTEL_GRX500_CLK
+
+config INTEL_GRX500_CLK
+	bool "GRX500 CLK"
+	help
+	  Clock driver of GRX500 platform.
+
+endchoice
diff --git a/drivers/clk/intel/Makefile b/drivers/clk/intel/Makefile
new file mode 100644
index 000000000000..1eaa37f797ea
--- /dev/null
+++ b/drivers/clk/intel/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for intel specific clk
+
+obj-y += clk-cgu-api.o
+ifneq ($(CONFIG_INTEL_GRX500_CLK),)
+	obj-y += clk-grx500.o
+endif
diff --git a/drivers/clk/intel/clk-cgu-api.c b/drivers/clk/intel/clk-cgu-api.c
new file mode 100644
index 000000000000..ab0590cb8b60
--- /dev/null
+++ b/drivers/clk/intel/clk-cgu-api.c
@@ -0,0 +1,676 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2016 Intel Corporation.
+ *  Zhu YiXin <Yixin.zhu@intel.com>
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#include "clk-cgu-api.h"
+
+#define to_gate_clk(_hw) container_of(_hw, struct gate_clk, hw)
+#define to_clk_gate_dummy(_hw) container_of(_hw, struct gate_dummy_clk, hw)
+#define to_div_clk(_hw) container_of(_hw, struct div_clk, hw)
+#define to_mux_clk(_hw) container_of(_hw, struct mux_clk, hw)
+
+static void set_clk_val(struct regmap *map, u32 reg, u8 shift,
+			u8 width, u32 set_val)
+{
+	u32 mask = GENMASK(width + shift, shift);
+
+	regmap_update_bits(map, reg, mask,
+			   (set_val << shift));
+}
+
+static u32 get_clk_val(struct regmap *map, u32 reg, u8 shift,
+		       u8 width)
+{
+	u32 val;
+
+	regmap_read(map, reg, &val);
+	val >>= shift;
+	val &= (BIT(width) - 1);
+
+	return val;
+}
+
+static struct regmap *regmap_from_node(struct device_node *np)
+{
+	struct regmap *map;
+
+	for ( ; np; ) {
+		np = of_get_parent(np);
+		if (!np)
+			return ERR_PTR(-EINVAL);
+
+		map = syscon_node_to_regmap(np);
+		if (!IS_ERR(map))
+			return map;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+#define GATE_STAT_REG(reg)	(reg)
+#define GATE_EN_REG(reg)	((reg) + 0x4)
+#define GATE_DIS_REG(reg)	((reg) + 0x8)
+
+static int get_gate(struct regmap *map, u32 reg, u8 shift)
+{
+	unsigned int val;
+
+	regmap_read(map, GATE_STAT_REG(reg), &val);
+
+	return !!(val & BIT(shift));
+}
+
+static void set_gate(struct regmap *map, u32 reg, u8 shift, int enable)
+{
+	if (enable)
+		regmap_write(map, GATE_EN_REG(reg), BIT(shift));
+	else
+		regmap_write(map, GATE_DIS_REG(reg), BIT(shift));
+}
+
+void
+intel_fixed_rate_clk_setup(struct device_node *node,
+			   const struct fixed_rate_clk_data *data)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	unsigned long rate;
+	struct regmap *regmap;
+	u32 reg;
+
+	if (!data)
+		return;
+
+	if (of_property_read_string(node, "clock-output-names", &clk_name))
+		return;
+
+	if (of_property_read_u32(node, "clock-frequency", (u32 *)&rate))
+		rate = data->fixed_rate;
+	if (!rate) {
+		pr_err("clk(%s): Could not get fixed rate\n", clk_name);
+		return;
+	}
+
+	regmap = regmap_from_node(node);
+	if (IS_ERR(regmap))
+		return;
+
+	/* Register the fixed rate clock */
+	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, rate);
+	if (IS_ERR(clk))
+		return;
+
+	/* Clock init */
+	if (of_property_read_u32(node, "reg", &reg)) {
+		pr_err("%s no reg definition\n", node->name);
+		return;
+	}
+
+	set_clk_val(regmap, reg, data->shift, data->width, data->setval);
+
+	/* Register clock provider */
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+
+static int gate_clk_enable(struct clk_hw *hw)
+{
+	struct gate_clk *clk;
+
+	clk = to_gate_clk(hw);
+	set_gate(clk->map, clk->reg, clk->bit_idx, 1);
+	return 0;
+}
+
+static void gate_clk_disable(struct clk_hw *hw)
+{
+	struct gate_clk *clk;
+
+	clk = to_gate_clk(hw);
+	set_gate(clk->map, clk->reg, clk->bit_idx, 0);
+}
+
+static int gate_clk_is_enabled(struct clk_hw *hw)
+{
+	struct gate_clk *clk;
+
+	clk = to_gate_clk(hw);
+	return get_gate(clk->map, clk->reg, clk->bit_idx);
+}
+
+static const struct clk_ops gate_clk_ops = {
+	.enable = gate_clk_enable,
+	.disable = gate_clk_disable,
+	.is_enabled = gate_clk_is_enabled,
+};
+
+static struct clk *gate_clk_register(struct device *dev, const char *name,
+				     const char *parent_name,
+				     unsigned long flags,
+				     struct regmap *map, unsigned int reg,
+				     u8 bit_idx, unsigned int clk_gate_flags)
+{
+	struct gate_clk *gate;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* Allocate the gate */
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &gate_clk_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	/* Struct gate_clk assignments */
+	gate->map = map;
+	gate->reg = reg;
+	gate->bit_idx = bit_idx;
+	gate->flags = clk_gate_flags;
+	gate->hw.init = &init;
+
+	clk = clk_register(dev, &gate->hw);
+	if (IS_ERR(clk)) {
+		pr_err("0x%4x %d %s %d %d %s\n", (u32)reg, init.num_parents,
+		       parent_name, bit_idx, clk_gate_flags, name);
+		kfree(gate);
+	}
+
+	return clk;
+}
+
+void
+intel_gate_clk_setup(struct device_node *node, const struct gate_clk_data *data)
+{
+	struct clk_onecell_data *clk_data;
+	const char *clk_parent;
+	const char *clk_name = node->name;
+	struct regmap *regmap;
+	unsigned int reg;
+	int i, j, num;
+	unsigned int val;
+
+	if (!data || !data->reg_size) {
+		pr_err("%s: register bit size cannot be 0!\n", __func__);
+		return;
+	}
+
+	regmap = regmap_from_node(node);
+	if (IS_ERR(regmap))
+		return;
+
+	if (of_property_read_u32(node, "reg", &reg)) {
+		pr_err("%s no reg definition\n", node->name);
+		return;
+	}
+
+	clk_parent = of_clk_get_parent_name(node, 0);
+
+	/* Size probe and memory allocation */
+	num = find_last_bit(&data->mask, data->reg_size);
+	clk_data = kmalloc(sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->clks = kcalloc(num + 1, sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_data->clks)
+		goto __clkarr_alloc_fail;
+
+	i = 0;
+	j = 0;
+	for_each_set_bit(i, &data->mask, data->reg_size) {
+		of_property_read_string_index(node, "clock-output-names",
+					      j, &clk_name);
+
+		clk_data->clks[j] = gate_clk_register(NULL, clk_name,
+						      clk_parent, 0, regmap,
+						      reg, i, 0);
+		WARN_ON(IS_ERR(clk_data->clks[j]));
+
+		j++;
+	}
+
+	/* Adjust to the real max */
+	clk_data->clk_num = num + 1;
+
+	/* Initial gate default setting */
+	if (data->flags & CLK_INIT_DEF_CFG_REQ) {
+		val = (unsigned int)data->def_onoff;
+		if (val)
+			regmap_write(regmap, GATE_EN_REG(reg), val);
+		val = (((unsigned int)(~data->def_onoff)) & data->mask);
+		if (val)
+			regmap_write(regmap, GATE_DIS_REG(reg), val);
+	}
+
+	/* Register to clock provider */
+	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return;
+
+__clkarr_alloc_fail:
+	kfree(clk_data);
+}
+
+static unsigned long div_recalc_rate(struct div_clk *div,
+				     unsigned long parent_rate,
+				     unsigned int val)
+{
+	return divider_recalc_rate(&div->hw, parent_rate,
+			val, div->div_table, div->flags, div->width);
+}
+
+static unsigned long div_clk_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct div_clk *div = to_div_clk(hw);
+	unsigned int val;
+
+	val = get_clk_val(div->map, div->reg, div->shift, div->width);
+
+	return div_recalc_rate(div, parent_rate, val);
+}
+
+static long div_clk_round_rate(struct clk_hw *hw,
+			       unsigned long rate, unsigned long *prate)
+{
+	struct div_clk *div = to_div_clk(hw);
+
+	return divider_round_rate(hw, rate, prate,
+				  div->div_table, div->width, div->flags);
+}
+
+static int div_set_rate(struct div_clk *div, unsigned long rate,
+			unsigned long parent_rate)
+{
+	unsigned int val;
+
+	val = divider_get_val(rate, parent_rate, div->div_table,
+			      div->width, div->flags);
+	set_clk_val(div->map, div->reg, div->shift, div->width, val);
+
+	return 0;
+}
+
+static int div_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct div_clk *div = to_div_clk(hw);
+
+	return div_set_rate(div, rate, parent_rate);
+}
+
+static const struct clk_ops clk_div_ops = {
+	.recalc_rate = div_clk_recalc_rate,
+	.round_rate = div_clk_round_rate,
+	.set_rate = div_clk_set_rate,
+};
+
+static struct clk *div_clk_register(struct device *dev, const char *name,
+				    const char *parent_name,
+				    unsigned long flags,
+				    struct regmap *map, unsigned int reg,
+				    const struct div_clk_data *data)
+{
+	struct div_clk *div;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* Allocate the divider clock*/
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_div_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	/* Struct clk_divider assignments */
+	div->map = map;
+	div->reg = reg;
+	div->shift = data->shift;
+	div->width = data->width;
+	div->flags = data->flags;
+	div->div_table = data->div_table;
+	div->hw.init = &init;
+	div->tbl_sz = data->tbl_sz;
+
+	/* Register the clock */
+	clk = clk_register(dev, &div->hw);
+	if (IS_ERR(clk))
+		kfree(div);
+
+	return clk;
+}
+
+void
+intel_div_clk_setup(struct device_node *node, const struct div_clk_data *data)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *clk_parent;
+	struct regmap *map;
+	unsigned int reg;
+
+	if (!data)
+		return;
+
+	map = regmap_from_node(node);
+	if (IS_ERR(map))
+		return;
+
+	if (of_property_read_u32(node, "reg", &reg)) {
+		pr_err("%s no reg definition\n", node->name);
+		return;
+	}
+
+	if (of_property_read_string(node, "clock-output-names", &clk_name))
+		return;
+	clk_parent = of_clk_get_parent_name(node, 0);
+
+	clk = div_clk_register(NULL, clk_name, clk_parent, 0, map, reg, data);
+	if (IS_ERR(clk))
+		return;
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+
+void
+intel_cluster_div_clk_setup(struct device_node *node,
+			    const struct div_clk_data *data, u32 num)
+{
+	struct clk_onecell_data *clk_data;
+	const char *clk_name;
+	const char *clk_parent;
+	struct regmap *regmap;
+	unsigned int reg;
+	int i;
+
+	if (!data || !num) {
+		pr_err("%s: invalid array or array size!\n", __func__);
+		return;
+	}
+
+	regmap = regmap_from_node(node);
+	if (IS_ERR(regmap))
+		return;
+
+	if (of_property_read_u32(node, "reg", &reg)) {
+		pr_err("%s no reg definition\n", node->name);
+		return;
+	}
+
+	clk_data = kmalloc(sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return;
+	clk_data->clks = kcalloc(num, sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_data->clks)
+		goto __clkarr_alloc_fail;
+
+	clk_parent = of_clk_get_parent_name(node, 0);
+
+	for (i = 0; i < num; i++) {
+		of_property_read_string_index(node, "clock-output-names",
+					      i, &clk_name);
+		clk_data->clks[i] = div_clk_register(NULL, clk_name, clk_parent,
+						     0, regmap, reg, &data[i]);
+		WARN_ON(IS_ERR(clk_data->clks[i]));
+	}
+	clk_data->clk_num = num + 1;
+
+	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return;
+
+__clkarr_alloc_fail:
+	kfree(clk_data);
+}
+
+static unsigned int mux_parent_from_table(const u32 *table,
+					  unsigned int val, unsigned int num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++)
+		if (table[i] == val)
+			return i;
+
+	return -EINVAL;
+}
+
+static u8 mux_clk_get_parent(struct clk_hw *hw)
+{
+	struct mux_clk *mux = to_mux_clk(hw);
+	int num_parents = clk_hw_get_num_parents(hw);
+	unsigned int val;
+
+	val = get_clk_val(mux->map, mux->reg, mux->shift, mux->width);
+	if (mux->table)
+		return mux_parent_from_table(mux->table, val, num_parents);
+
+	if (val && (mux->flags & CLK_MUX_INDEX_BIT))
+		val = ffs(val) - 1;
+	if (val && (mux->flags & CLK_MUX_INDEX_ONE))
+		val -= 1;
+	if (val >= num_parents)
+		return -EINVAL;
+
+	return val;
+}
+
+static int mux_clk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct mux_clk *mux = to_mux_clk(hw);
+
+	if (mux->table) {
+		index = mux->table[index];
+	} else {
+		if (mux->flags & CLK_MUX_INDEX_BIT)
+			index = BIT(index);
+		if (mux->flags & CLK_MUX_INDEX_ONE)
+			index += 1;
+	}
+
+	set_clk_val(mux->map, mux->reg, mux->shift, mux->width, index);
+
+	return 0;
+}
+
+static const struct clk_ops mux_clk_ops = {
+	.get_parent = mux_clk_get_parent,
+	.set_parent = mux_clk_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+
+static struct clk *mux_clk_register(struct device *dev, const char *name,
+				    const char * const *parent_names,
+				    u8 num_parents, unsigned long flags,
+				    struct regmap *map, unsigned int reg,
+				    const struct mux_clk_data *data)
+{
+	struct mux_clk *mux;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	/* allocate mux clk */
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	/* struct init assignments */
+	init.name = name;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.ops = &mux_clk_ops;
+
+	/* struct mux_clk assignments */
+	mux->map = map;
+	mux->reg = reg;
+	mux->shift = data->shift;
+	mux->width = data->width;
+	mux->flags = data->clk_flags;
+	mux->table = data->table;
+	mux->hw.init = &init;
+
+	clk = clk_register(dev, &mux->hw);
+	if (IS_ERR(clk))
+		kfree(mux);
+
+	return clk;
+}
+
+void
+intel_mux_clk_setup(struct device_node *node, const struct mux_clk_data *data)
+{
+	struct clk *clk;
+	const char *clk_name;
+	const char **parents;
+	unsigned int num_parents;
+	struct regmap *map;
+	unsigned int reg;
+
+	if (!data)
+		return;
+
+	map = regmap_from_node(node);
+	if (IS_ERR(map))
+		return;
+
+	if (of_property_read_string(node, "clock-output-names", &clk_name)) {
+		pr_err("%s: no output clock name!\n", node->name);
+		return;
+	}
+
+	if (of_property_read_u32(node, "reg", &reg)) {
+		pr_err("%s no reg definition\n", node->name);
+		return;
+	}
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents) {
+		parents = kmalloc_array(num_parents,
+					sizeof(char *), GFP_KERNEL);
+		if (!parents)
+			return;
+		of_clk_parent_fill(node, parents, num_parents);
+	} else {
+		pr_err("%s: mux clk no parent!\n", __func__);
+		return;
+	}
+
+	clk = mux_clk_register(NULL, clk_name, parents, num_parents,
+			       data->flags, map, reg, data);
+	if (IS_ERR(clk))
+		goto __mux_clk_fail;
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return;
+
+__mux_clk_fail:
+	kfree(parents);
+}
+
+static int gate_clk_dummy_enable(struct clk_hw *hw)
+{
+	struct gate_dummy_clk *clk;
+
+	clk = to_clk_gate_dummy(hw);
+	clk->clk_status = 1;
+
+	return 0;
+}
+
+static void gate_clk_dummy_disable(struct clk_hw *hw)
+{
+	struct gate_dummy_clk *clk;
+
+	clk = to_clk_gate_dummy(hw);
+	clk->clk_status = 0;
+}
+
+static int gate_clk_dummy_is_enabled(struct clk_hw *hw)
+{
+	struct gate_dummy_clk *clk;
+
+	clk = to_clk_gate_dummy(hw);
+	return clk->clk_status;
+}
+
+static const struct clk_ops clk_gate_dummy_ops = {
+	.enable = gate_clk_dummy_enable,
+	.disable = gate_clk_dummy_disable,
+	.is_enabled = gate_clk_dummy_is_enabled,
+};
+
+static struct clk
+*clk_register_gate_dummy(struct device *dev,
+			 const char *name,
+			 const char *parent_name,
+			 unsigned long flags,
+			 const struct gate_dummy_clk_data *data)
+{
+	struct gate_dummy_clk *gate_clk;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* Allocate the gate_dummy clock*/
+	gate_clk = kzalloc(sizeof(*gate_clk), GFP_KERNEL);
+	if (!gate_clk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_gate_dummy_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+	gate_clk->hw.init = &init;
+
+	/* Struct gate_clk assignments */
+	if (data->flags & CLK_INIT_DEF_CFG_REQ)
+		gate_clk->clk_status = data->def_val & 0x1;
+
+	/* Register the clock */
+	clk = clk_register(dev, &gate_clk->hw);
+	if (IS_ERR(clk))
+		kfree(gate_clk);
+
+	return clk;
+}
+
+void
+intel_gate_dummy_clk_setup(struct device_node *node,
+			   const struct gate_dummy_clk_data *data)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+
+	if (!data)
+		return;
+
+	if (of_property_read_string(node, "clock-output-names", &clk_name))
+		return;
+
+	clk = clk_register_gate_dummy(NULL, clk_name, NULL, 0, data);
+	if (IS_ERR(clk)) {
+		pr_err("%s: dummy gate clock register fail!\n", __func__);
+		return;
+	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
diff --git a/drivers/clk/intel/clk-cgu-api.h b/drivers/clk/intel/clk-cgu-api.h
new file mode 100644
index 000000000000..3a8d7e47ba58
--- /dev/null
+++ b/drivers/clk/intel/clk-cgu-api.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __INTEL_CLK_API_H
+#define __INTEL_CLK_API_H
+
+/*
+ *  Copyright(c) 2016 Intel Corporation.
+ *  Zhu YiXin <Yixin.zhu@intel.com>
+ *
+ */
+
+struct div_clk_data {
+	u8 shift;
+	u8 width;
+	const unsigned int tbl_sz;
+	const struct clk_div_table *div_table;
+	unsigned long flags;
+};
+
+struct mux_clk_data {
+	u8 shift;
+	u8 width;
+	const u32 *table;
+	unsigned long flags;
+	unsigned long clk_flags;
+};
+
+struct gate_clk_data {
+	unsigned long mask;
+	unsigned long def_onoff;
+	u8 reg_size;
+	unsigned long flags;
+};
+
+struct gate_dummy_clk_data {
+	unsigned int def_val;
+	unsigned long flags;
+};
+
+struct fixed_rate_clk_data {
+	u8 shift;
+	u8 width;
+	unsigned long fixed_rate;
+	unsigned int setval;
+};
+
+struct gate_dummy_clk {
+	struct clk_hw hw;
+	unsigned int clk_status;
+};
+
+struct div_clk {
+	struct clk_hw hw;
+	struct regmap *map;
+	unsigned int reg;
+	u8 shift;
+	u8 width;
+	unsigned int flags;
+	const struct clk_div_table *div_table;
+	unsigned int tbl_sz;
+};
+
+struct gate_clk {
+	struct clk_hw hw;
+	struct regmap *map;
+	unsigned int reg;
+	u8 bit_idx;
+	unsigned int flags;
+};
+
+struct mux_clk {
+	struct clk_hw hw;
+	struct regmap *map;
+	unsigned int reg;
+	const u32 *table;
+	u8 shift;
+	u8 width;
+	unsigned int flags;
+};
+
+/**
+ * struct clk_fixed_factor_frac - fixed multiplier/divider/fraction clock
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @mult:	multiplier(N)
+ * @div:	divider(M)
+ * @frac:	fraction(K)
+ * @frac_div:	fraction divider(D)
+ *
+ * Clock with a fixed multiplier, divider and fraction.
+ * The output frequency formula is clk = parent clk * (N+K/D)/M.
+ * Implements .recalc_rate, .set_rate and .round_rate
+ */
+
+struct clk_fixed_factor_frac {
+	struct clk_hw	hw;
+	unsigned int	mult;
+	unsigned int	div;
+	unsigned int	frac;
+	unsigned int	frac_div;
+};
+
+#define INTEL_FIXED_FACTOR_PLLCLK	"intel,fixed-factor-pllclk"
+#define INTEL_FIXED_FACTOR_FRAC_PLLCLK	"intel,fixed-factor-frac-pllclk"
+
+#define CLK_INIT_DEF_CFG_REQ		BIT(0)
+
+void intel_gate_clk_setup(struct device_node *np,
+			  const struct gate_clk_data *data);
+void intel_mux_clk_setup(struct device_node *np,
+			 const struct mux_clk_data *data);
+void intel_fixed_rate_clk_setup(struct device_node *np,
+				const struct fixed_rate_clk_data *data);
+void intel_div_clk_setup(struct device_node *np,
+			 const struct div_clk_data *data);
+void intel_gate_dummy_clk_setup(struct device_node *np,
+				const struct gate_dummy_clk_data *data);
+void intel_cluster_div_clk_setup(struct device_node *np,
+				 const struct div_clk_data *data, u32 num);
+
+#endif /* __INTEL_CLK_API_H */
diff --git a/drivers/clk/intel/clk-grx500.c b/drivers/clk/intel/clk-grx500.c
new file mode 100644
index 000000000000..c61b7ba06758
--- /dev/null
+++ b/drivers/clk/intel/clk-grx500.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2016 Intel Corporation.
+ *  Zhu YiXin <Yixin.zhu@intel.com>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/spinlock.h>
+#include <dt-bindings/clock/intel,grx500-clk.h>
+#include "clk-cgu-api.h"
+
+/* Intel GRX500 CGU device tree "compatible" strings */
+#define INTEL_GRX500_DT_PLL0A_CLK	"intel,grx500-pll0a-clk"
+#define INTEL_GRX500_DT_PLL0B_CLK	"intel,grx500-pll0b-clk"
+#define INTEL_GRX500_DT_PCIE_CLK	"intel,grx500-pcie-clk"
+#define INTEL_GRX500_DT_CPU_CLK		"intel,grx500-cpu-clk"
+#define INTEL_GRX500_DT_GATE0_CLK	"intel,grx500-gate0-clk"
+#define INTEL_GRX500_DT_GATE1_CLK	"intel,grx500-gate1-clk"
+#define INTEL_GRX500_DT_GATE2_CLK	"intel,grx500-gate2-clk"
+#define INTEL_GRX500_DT_VOICE_CLK	"intel,grx500-voice-clk"
+#define INTEL_GRX500_DT_GATE_I2C_CLK	"intel,grx500-gate-dummy-clk"
+
+/* clock shift and width */
+#define CBM_CLK_SHIFT		0
+#define CBM_CLK_WIDTH		4
+#define NGI_CLK_SHIFT		4
+#define NGI_CLK_WIDTH		4
+#define SSX4_CLK_SHIFT		8
+#define SSX4_CLK_WIDTH		4
+#define CPU0_CLK_SHIFT		12
+#define CPU0_CLK_WIDTH		4
+
+#define PAE_CLK_SHIFT		0
+#define PAE_CLK_WIDTH		4
+#define GSWIP_CLK_SHIFT		4
+#define GSWIP_CLK_WIDTH		4
+#define DDR_CLK_SHIFT		8
+#define DDR_CLK_WIDTH		4
+#define CPU1_CLK_SHIFT		12
+#define CPU1_CLK_WIDTH		4
+
+#define PCIE_CLK_SHIFT		12
+#define PCIE_CLK_WIDTH		2
+
+#define CPU_CLK_SHIFT		29
+#define CPU_CLK_WIDTH		1
+
+#define VOICE_CLK_SHIFT		14
+#define VOICE_CLK_WIDTH		2
+
+/* Gate clock mask */
+#define GATE0_CLK_MASK		0xCF
+#define GATE1_CLK_MASK		0x1EF27FE4
+#define GATE2_CLK_MASK		0x2020002
+
+static const struct clk_div_table pll_div[] = {
+	{1,	2},
+	{2,	3},
+	{3,	4},
+	{4,	5},
+	{5,	6},
+	{6,	8},
+	{7,	10},
+	{8,	12},
+	{9,	16},
+	{10,	20},
+	{11,	24},
+	{12,	32},
+	{13,	40},
+	{14,	48},
+	{15,	64}
+};
+
+static const struct gate_dummy_clk_data grx500_clk_gate_i2c_data __initconst = {
+	0
+};
+
+static void __init grx500_clk_gate_i2c_setup(struct device_node *node)
+{
+	intel_gate_dummy_clk_setup(node, &grx500_clk_gate_i2c_data);
+}
+
+CLK_OF_DECLARE(grx500_gatei2cclk, INTEL_GRX500_DT_GATE_I2C_CLK,
+	       grx500_clk_gate_i2c_setup);
+
+static const struct fixed_rate_clk_data grx500_clk_voice_data __initconst = {
+	.shift = VOICE_CLK_SHIFT,
+	.width = VOICE_CLK_WIDTH,
+	.setval = 0x2,
+};
+
+static void __init grx500_clk_voice_setup(struct device_node *node)
+{
+	intel_fixed_rate_clk_setup(node, &grx500_clk_voice_data);
+}
+
+CLK_OF_DECLARE(grx500_voiceclk, INTEL_GRX500_DT_VOICE_CLK,
+	       grx500_clk_voice_setup);
+
+static const struct gate_clk_data grx500_clk_gate2_data __initconst = {
+	.mask = GATE2_CLK_MASK,
+	.reg_size = 32,
+};
+
+static void __init grx500_clk_gate2_setup(struct device_node *node)
+{
+	intel_gate_clk_setup(node, &grx500_clk_gate2_data);
+}
+
+CLK_OF_DECLARE(grx500_gate2clk, INTEL_GRX500_DT_GATE2_CLK,
+	       grx500_clk_gate2_setup);
+
+static const struct gate_clk_data grx500_clk_gate1_data __initconst = {
+	.mask = GATE1_CLK_MASK,
+	.def_onoff = 0x14000600,
+	.reg_size = 32,
+	.flags = CLK_INIT_DEF_CFG_REQ,
+};
+
+static void __init grx500_clk_gate1_setup(struct device_node *node)
+{
+	intel_gate_clk_setup(node, &grx500_clk_gate1_data);
+}
+
+CLK_OF_DECLARE(grx500_gate1clk, INTEL_GRX500_DT_GATE1_CLK,
+	       grx500_clk_gate1_setup);
+
+static const struct gate_clk_data grx500_clk_gate0_data __initconst = {
+	.mask = GATE0_CLK_MASK,
+	.def_onoff = GATE0_CLK_MASK,
+	.reg_size = 32,
+	.flags = CLK_INIT_DEF_CFG_REQ,
+};
+
+static void __init grx500_clk_gate0_setup(struct device_node *node)
+{
+	intel_gate_clk_setup(node, &grx500_clk_gate0_data);
+}
+
+CLK_OF_DECLARE(grx500_gate0clk, INTEL_GRX500_DT_GATE0_CLK,
+	       grx500_clk_gate0_setup);
+
+static const struct mux_clk_data grx500_clk_cpu_data __initconst = {
+	.shift = CPU_CLK_SHIFT,
+	.width = CPU_CLK_WIDTH,
+	.flags = CLK_SET_RATE_PARENT,
+};
+
+static void __init grx500_clk_cpu_setup(struct device_node *node)
+{
+	intel_mux_clk_setup(node, &grx500_clk_cpu_data);
+}
+
+CLK_OF_DECLARE(grx500_cpuclk, INTEL_GRX500_DT_CPU_CLK,
+	       grx500_clk_cpu_setup);
+
+static const struct div_clk_data grx500_clk_pcie_data __initconst = {
+	.shift = PCIE_CLK_SHIFT,
+	.width = PCIE_CLK_WIDTH,
+	.div_table = pll_div,
+};
+
+static void __init grx500_clk_pcie_setup(struct device_node *node)
+{
+	intel_div_clk_setup(node, &grx500_clk_pcie_data);
+}
+
+CLK_OF_DECLARE(grx500_pcieclk, INTEL_GRX500_DT_PCIE_CLK,
+	       grx500_clk_pcie_setup);
+
+static const struct div_clk_data grx500_clk_pll0b[] __initconst = {
+	{
+		.shift = PAE_CLK_SHIFT,
+		.width = PAE_CLK_WIDTH,
+		.div_table = pll_div,
+	},
+	{
+		.shift = GSWIP_CLK_SHIFT,
+		.width = GSWIP_CLK_WIDTH,
+		.div_table = pll_div,
+	},
+	{
+		.shift = DDR_CLK_SHIFT,
+		.width = DDR_CLK_WIDTH,
+		.div_table = pll_div,
+	},
+	{
+		.shift = CPU1_CLK_SHIFT,
+		.width = CPU1_CLK_WIDTH,
+		.div_table = pll_div,
+	},
+};
+
+static void __init grx500_clk_pll0b_setup(struct device_node *node)
+{
+	intel_cluster_div_clk_setup(node, grx500_clk_pll0b,
+				    ARRAY_SIZE(grx500_clk_pll0b));
+}
+
+CLK_OF_DECLARE(grx500_pll0bclk, INTEL_GRX500_DT_PLL0B_CLK,
+	       grx500_clk_pll0b_setup);
+
+static const struct div_clk_data grx500_clk_pll0a[] __initconst = {
+	{
+		.shift = CBM_CLK_SHIFT,
+		.width = CBM_CLK_WIDTH,
+		.div_table = pll_div,
+	},
+	{
+		.shift = NGI_CLK_SHIFT,
+		.width = NGI_CLK_WIDTH,
+		.div_table = pll_div,
+	},
+	{
+		.shift = SSX4_CLK_SHIFT,
+		.width = SSX4_CLK_WIDTH,
+		.div_table = pll_div,
+	},
+	{
+		.shift = CPU0_CLK_SHIFT,
+		.width = CPU0_CLK_WIDTH,
+		.div_table = pll_div,
+	},
+};
+
+static void __init grx500_clk_pll0a_setup(struct device_node *node)
+{
+	intel_cluster_div_clk_setup(node, grx500_clk_pll0a,
+				    ARRAY_SIZE(grx500_clk_pll0a));
+}
+
+CLK_OF_DECLARE(grx500_pll0aclk, INTEL_GRX500_DT_PLL0A_CLK,
+	       grx500_clk_pll0a_setup);
diff --git a/include/dt-bindings/clock/intel,grx500-clk.h b/include/dt-bindings/clock/intel,grx500-clk.h
new file mode 100644
index 000000000000..eb1114636504
--- /dev/null
+++ b/include/dt-bindings/clock/intel,grx500-clk.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2016 Intel Corporation.
+ *  Zhu YiXin <Yixin.zhu@intel.com>
+ *
+ */
+
+#ifndef __INTEL_GRX500_CLK_H
+#define __INTEL_GRX500_CLK_H
+
+/* clocks under pll0a-clk */
+#define CBM_CLK			0
+#define NGI_CLK			1
+#define SSX4_CLK		2
+#define CPU0_CLK		3
+
+/* clocks under pll0b-clk */
+#define PAE_CLK			0
+#define GSWIP_CLK		1
+#define DDR_CLK			2
+#define CPU1_CLK		3
+
+/* clocks under lcpll-clk */
+#define GRX500_PCIE_CLK		0
+
+/* clocks under gate0-clk */
+#define GATE_XBAR0_CLK		0
+#define GATE_XBAR1_CLK		1
+#define GATE_XBAR2_CLK		2
+#define GATE_XBAR3_CLK		3
+#define GATE_XBAR6_CLK		4
+#define GATE_XBAR7_CLK		5
+
+/* clocks under gate1-clk */
+#define GATE_V_CODEC_CLK	0
+#define GATE_DMA0_CLK		1
+#define GATE_USB0_CLK		2
+#define GATE_SPI1_CLK		3
+#define GATE_SPI0_CLK		4
+#define GATE_CBM_CLK		5
+#define GATE_EBU_CLK		6
+#define GATE_SSO_CLK		7
+#define GATE_GPTC0_CLK		8
+#define GATE_GPTC1_CLK		9
+#define GATE_GPTC2_CLK		10
+#define GATE_URT_CLK		11
+#define GATE_EIP97_CLK		12
+#define GATE_EIP123_CLK		13
+#define GATE_TOE_CLK		14
+#define GATE_MPE_CLK		15
+#define GATE_TDM_CLK		16
+#define GATE_PAE_CLK		17
+#define GATE_USB1_CLK		18
+#define GATE_GSWIP_CLK		19
+
+/* clocks under gate2-clk */
+#define GATE_PCIE0_CLK		0
+#define GATE_PCIE1_CLK		1
+#define GATE_PCIE2_CLK		2
+
+#endif /* __INTEL_GRX500_CLK_H */
-- 
2.11.0

