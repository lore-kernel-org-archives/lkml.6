Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeAaSKK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:10:10 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35229 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbeAaSJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:09:56 -0500
X-Google-Smtp-Source: AH8x226+BmcMUb7zsBy8ZDqNbM5f9LNRRKXDsvQBlZS54R6u/ntlCoQFaErP0ulGZ/vN4ewno0UnuQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/19] clk: meson: add regmap clocks
Date: Wed, 31 Jan 2018 19:09:31 +0100
Message-Id: <20180131180945.18025-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson clock controllers needs to move the classical iomem registers to
regmap. This is triggered because the HHI controllers found on the GXBB
and GXL host more than just clocks. To properly handle this, we would
like to migrate HHI to syscon. Also GXBB AO clock controller already use
regmap, AXG AO and Audio clock controllers will as well.

The purpose of this change is to provide a common structure to these
meson controllers (and possibly others) for regmap based clocks.

This change provides the basic gate, mux and divider, based on the
helpers provided by the related generic clocks

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig      |   4 +
 drivers/clk/meson/Makefile     |   1 +
 drivers/clk/meson/clk-regmap.c | 166 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/clk-regmap.h | 111 +++++++++++++++++++++++++++
 4 files changed, 282 insertions(+)
 create mode 100644 drivers/clk/meson/clk-regmap.c
 create mode 100644 drivers/clk/meson/clk-regmap.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 7694302c70a4..e97e85077da1 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -3,6 +3,10 @@ config COMMON_CLK_AMLOGIC
 	depends on OF
 	depends on ARCH_MESON || COMPILE_TEST
 
+config COMMON_CLK_REGMAP_MESON
+	bool
+	select REGMAP
+
 config COMMON_CLK_MESON8B
 	bool
 	depends on COMMON_CLK_AMLOGIC
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 3c03ce583798..11a50586666a 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-cpu.o clk-mpll.o clk-audio-div
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-regmap.o gxbb-aoclk-32k.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
+obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
new file mode 100644
index 000000000000..3645fdb62343
--- /dev/null
+++ b/drivers/clk/meson/clk-regmap.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include "clk-regmap.h"
+
+static int clk_regmap_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_gate_data *gate = clk_get_regmap_gate_data(clk);
+	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+
+	set ^= enable;
+
+	return regmap_update_bits(clk->map, gate->offset, BIT(gate->bit_idx),
+				  set ? BIT(gate->bit_idx) : 0);
+}
+
+static int clk_regmap_gate_enable(struct clk_hw *hw)
+{
+	return clk_regmap_gate_endisable(hw, 1);
+}
+
+static void clk_regmap_gate_disable(struct clk_hw *hw)
+{
+	clk_regmap_gate_endisable(hw, 0);
+}
+
+static int clk_regmap_gate_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_gate_data *gate = clk_get_regmap_gate_data(clk);
+	unsigned int val;
+
+	regmap_read(clk->map, gate->offset, &val);
+	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
+		val ^= BIT(gate->bit_idx);
+
+	val &= BIT(gate->bit_idx);
+
+	return val ? 1 : 0;
+}
+
+const struct clk_ops clk_regmap_gate_ops = {
+	.enable = clk_regmap_gate_enable,
+	.disable = clk_regmap_gate_disable,
+	.is_enabled = clk_regmap_gate_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_gate_ops);
+
+static unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
+						unsigned long prate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(clk->map, div->offset, &val);
+	if (ret)
+		/* Gives a hint that something is wrong */
+		return 0;
+
+	val >>= div->shift;
+	val &= clk_div_mask(div->width);
+	return divider_recalc_rate(hw, prate, val, div->table, div->flags,
+				   div->width);
+}
+
+static long clk_regmap_div_round_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long *prate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
+	unsigned int val;
+	int ret;
+
+	/* if read only, just return current value */
+	if (div->flags & CLK_DIVIDER_READ_ONLY) {
+		ret = regmap_read(clk->map, div->offset, &val);
+		if (ret)
+			/* Gives a hint that something is wrong */
+			return 0;
+
+		val >>= div->shift;
+		val &= clk_div_mask(div->width);
+
+		return divider_ro_round_rate(hw, rate, prate, div->table,
+					     div->width, div->flags, val);
+	}
+
+	return divider_round_rate(hw, rate, prate, div->table, div->width,
+				  div->flags);
+}
+
+static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
+	unsigned int val;
+	int ret;
+
+	ret = divider_get_val(rate, parent_rate, div->table, div->width,
+			      div->flags);
+	if (ret < 0)
+		return ret;
+
+	val = (unsigned int)ret << div->shift;
+	return regmap_update_bits(clk->map, div->offset,
+				  clk_div_mask(div->width) << div->shift, val);
+};
+
+/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
+
+const struct clk_ops clk_regmap_divider_ops = {
+	.recalc_rate = clk_regmap_div_recalc_rate,
+	.round_rate = clk_regmap_div_round_rate,
+	.set_rate = clk_regmap_div_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_divider_ops);
+
+const struct clk_ops clk_regmap_divider_ro_ops = {
+	.recalc_rate = clk_regmap_div_recalc_rate,
+	.round_rate = clk_regmap_div_round_rate,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_divider_ro_ops);
+
+static u8 clk_regmap_mux_get_parent(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_mux_data *mux = clk_get_regmap_mux_data(clk);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(clk->map, mux->offset, &val);
+	if (ret)
+		return ret;
+
+	val >>= mux->shift;
+	val &= mux->mask;
+	return clk_mux_val_to_index(hw, mux->table, mux->flags, val);
+}
+
+static int clk_regmap_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_mux_data *mux = clk_get_regmap_mux_data(clk);
+	unsigned int val = clk_mux_index_to_val(mux->table, mux->flags, index);
+
+	return regmap_update_bits(clk->map, mux->offset,
+				  mux->mask << mux->shift,
+				  val << mux->shift);
+}
+
+const struct clk_ops clk_regmap_mux_ops = {
+	.get_parent = clk_regmap_mux_get_parent,
+	.set_parent = clk_regmap_mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_mux_ops);
+
+const struct clk_ops clk_regmap_mux_ro_ops = {
+	.get_parent = clk_regmap_mux_get_parent,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_mux_ro_ops);
diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
new file mode 100644
index 000000000000..ab00a0578edf
--- /dev/null
+++ b/drivers/clk/meson/clk-regmap.h
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#ifndef __CLK_REGMAP_H
+#define __CLK_REGMAP_H
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+/**
+ * struct clk_regmap - regmap backed clock
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @map:	pointer to the regmap structure controlling the clock
+ * @data:	data specific to the clock type
+ *
+ * Clock which is controlled by regmap backed registers. The actual type of
+ * of the clock is controlled by the clock_ops and data.
+ */
+struct clk_regmap {
+	struct clk_hw	hw;
+	struct regmap	*map;
+	void		*data;
+};
+
+#define to_clk_regmap(_hw) container_of(_hw, struct clk_regmap, hw)
+
+/**
+ * struct clk_regmap_gate_data - regmap backed gate specific data
+ *
+ * @offset:	offset of the register controlling gate
+ * @bit_idx:	single bit controlling gate
+ * @flags:	hardware-specific flags
+ *
+ * Flags:
+ * Same as clk_gate except CLK_GATE_HIWORD_MASK which is ignored
+ */
+struct clk_regmap_gate_data {
+	unsigned int	offset;
+	u8		bit_idx;
+	u8		flags;
+};
+
+static inline struct clk_regmap_gate_data *
+clk_get_regmap_gate_data(struct clk_regmap *clk)
+{
+	return (struct clk_regmap_gate_data *)clk->data;
+}
+
+extern const struct clk_ops clk_regmap_gate_ops;
+
+/**
+ * struct clk_regmap_div_data - regmap backed adjustable divider specific data
+ *
+ * @offset:	offset of the register controlling the divider
+ * @shift:	shift to the divider bit field
+ * @width:	width of the divider bit field
+ * @table:	array of value/divider pairs, last entry should have div = 0
+ *
+ * Flags:
+ * Same as clk_divider except CLK_DIVIDER_HIWORD_MASK which is ignored
+ */
+struct clk_regmap_div_data {
+	unsigned int	offset;
+	u8		shift;
+	u8		width;
+	u8		flags;
+	const struct clk_div_table	*table;
+};
+
+static inline struct clk_regmap_div_data *
+clk_get_regmap_div_data(struct clk_regmap *clk)
+{
+	return (struct clk_regmap_div_data *)clk->data;
+}
+
+extern const struct clk_ops clk_regmap_divider_ops;
+extern const struct clk_ops clk_regmap_divider_ro_ops;
+
+/**
+ * struct clk_regmap_mux_data - regmap backed multiplexer clock specific data
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @offset:	offset of theregister controlling multiplexer
+ * @table:	array of parent indexed register values
+ * @shift:	shift to multiplexer bit field
+ * @width:	width of mutliplexer bit field
+ * @flags:	hardware-specific flags
+ *
+ * Flags:
+ * Same as clk_divider except CLK_MUX_HIWORD_MASK which is ignored
+ */
+struct clk_regmap_mux_data {
+	unsigned int	offset;
+	u32		*table;
+	u32		mask;
+	u8		shift;
+	u8		flags;
+};
+
+static inline struct clk_regmap_mux_data *
+clk_get_regmap_mux_data(struct clk_regmap *clk)
+{
+	return (struct clk_regmap_mux_data *)clk->data;
+}
+
+extern const struct clk_ops clk_regmap_mux_ops;
+extern const struct clk_ops clk_regmap_mux_ro_ops;
+
+#endif /* __CLK_REGMAP_H */
-- 
2.14.3
