Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeBBOGJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:06:09 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35343 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752178AbeBBOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:04:46 -0500
From: <gabriel.fernandez@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <gabriel.fernandez.st@gmail.com>, <olivier.bideau@st.com>
Subject: [PATCH 07/14] clk: stm32mp1: add Post-dividers for PLL
Date: Fri, 2 Feb 2018 15:03:35 +0100
Message-ID: <1517580222-23301-8-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Each PLL has 3 outputs with post-dividers.

pll1_p is dedicated for Cortex-A7
pll1_q is not connected
pll1_r is not connected

pll2_p is dedicated for AXI
pll2_q is dedicated for GPU
pll2_r is dedicated for DDR

pll3_p is dedicated for mcu
pll3_q is for Peripheral Kernel Clock
pll3_r is for Peripheral Kernel Clock

pll4_p is for Peripheral Kernel Clock
pll4_q is for Peripheral Kernel Clock
pll4_r is for Peripheral Kernel Clock

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 257 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 257 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 33f0d09..15cd488 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -377,6 +377,147 @@ struct mux_cfg {
 	u32 *table;
 };
 
+/* STM32 Composite clock */
+struct composite_cfg {
+	struct gate_cfg	*gate;
+	struct mux_cfg	*mux;
+	struct div_cfg	*div;
+	const struct clk_ops *mux_ops;
+	const struct clk_ops *div_ops;
+	const struct clk_ops *gate_ops;
+};
+
+static struct clk_mux *_get_cmux(void __iomem *reg, u8 shift, u8 width,
+				 u32 flags, u32 *table, spinlock_t *lock)
+{
+	struct clk_mux *mux;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	mux->reg = reg;
+	mux->shift = shift;
+	mux->mask = (1 << width) - 1;
+	mux->flags = flags;
+	mux->lock = lock;
+	mux->table = table;
+
+	return mux;
+}
+
+static struct clk_divider *_get_cdiv(void __iomem *reg, u8 shift, u8 width,
+				     u32 flags,
+				     const struct clk_div_table *table,
+				     spinlock_t *lock)
+{
+	struct clk_divider *div;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	div->reg = reg;
+	div->shift = shift;
+	div->width = width;
+	div->flags = flags;
+	div->lock = lock;
+	div->table = table;
+
+	return div;
+}
+
+static struct clk_gate *_get_cgate(void __iomem *reg, u8 bit_idx, u32 flags,
+				   spinlock_t *lock)
+{
+	struct  clk_gate *gate;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	gate->reg = reg;
+	gate->bit_idx = bit_idx;
+	gate->flags = flags;
+	gate->lock = lock;
+
+	return gate;
+}
+
+static struct clk_hw *
+clk_stm_register_composite(struct device *dev,
+			   const char *name, const char * const *parent_names,
+			   int num_parents, void __iomem *base,
+			   const struct composite_cfg *cfg,
+			   unsigned long flags, spinlock_t *lock)
+{
+	struct clk_mux *mux = NULL;
+	struct clk_divider *div = NULL;
+	struct clk_gate *gate = NULL;
+	const struct clk_ops *mux_ops, *div_ops, *gate_ops;
+	struct clk_hw *hw;
+	struct clk_hw *mux_hw;
+	struct clk_hw *div_hw;
+	struct clk_hw *gate_hw;
+
+	mux_hw = NULL;
+	div_hw = NULL;
+	gate_hw = NULL;
+	mux_ops = NULL;
+	div_ops = NULL;
+	gate_ops = NULL;
+
+	if (cfg->mux) {
+		mux = _get_cmux(base + cfg->mux->reg_off,
+				cfg->mux->shift,
+				cfg->mux->width,
+				cfg->mux->mux_flags,
+				cfg->mux->table,
+				lock);
+
+		if (!IS_ERR(mux)) {
+			mux_hw = &mux->hw;
+			mux_ops = cfg->mux_ops ?
+				  cfg->mux_ops : &clk_mux_ops;
+		}
+	}
+
+	if (cfg->div) {
+		div = _get_cdiv(base + cfg->div->reg_off,
+				cfg->div->shift,
+				cfg->div->width,
+				cfg->div->div_flags,
+				cfg->div->table,
+				lock);
+
+		if (!IS_ERR(div)) {
+			div_hw = &div->hw;
+			div_ops = cfg->div_ops ?
+				  cfg->div_ops : &clk_divider_ops;
+		}
+	}
+
+	if (cfg->gate) {
+		gate = _get_cgate(base + cfg->gate->reg_off,
+				  cfg->gate->bit_idx,
+				  cfg->gate->gate_flags,
+				  lock);
+
+		if (!IS_ERR(gate)) {
+			gate_hw = &gate->hw;
+			gate_ops = cfg->gate_ops ?
+				   cfg->gate_ops : &clk_gate_ops;
+		}
+	}
+
+	hw = clk_hw_register_composite(dev, name, parent_names, num_parents,
+				       mux_hw, mux_ops, div_hw, div_ops,
+				       gate_hw, gate_ops, flags);
+
+	return hw;
+}
+
 static struct clk_hw *
 _clk_hw_register_gate(struct device *dev,
 		      struct clk_hw_onecell_data *clk_data,
@@ -442,6 +583,17 @@ struct mux_cfg {
 				   mux_cfg->width, mux_cfg->mux_flags, lock);
 }
 
+static struct clk_hw *
+_clk_stm_register_composite(struct device *dev,
+			    struct clk_hw_onecell_data *clk_data,
+			    void __iomem *base, spinlock_t *lock,
+			    const struct clock_config *cfg)
+{
+	return clk_stm_register_composite(dev, cfg->name, cfg->parent_names,
+					  cfg->num_parents, base, cfg->cfg,
+					  cfg->flags, lock);
+}
+
 /* MP1 Gate clock with set & clear registers */
 
 static int mp1_gate_clk_enable(struct clk_hw *hw)
@@ -779,6 +931,76 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 	.func		= _clk_hw_register_mux,\
 }
 
+#define COMPOSITE(_id, _name, _parents, _flags, _cfg)\
+{\
+	.id		= _id,\
+	.name		= _name,\
+	.parent_names	= _parents,\
+	.num_parents	= ARRAY_SIZE(_parents),\
+	.flags		= _flags,\
+	.cfg		= &(struct composite_cfg)_cfg,\
+	.func		= _clk_stm_register_composite,\
+}
+
+#define PARENT(_parent) ((const char *[]) { _parent})
+
+#define _NO_MUX .mux = NULL, .mux_ops = NULL
+#define _NO_DIV .div = NULL, .div_ops = NULL
+#define _NO_GATE .gate = NULL, .gate_ops = NULL
+
+#define _GATE_OPS(_offset, _bit_idx, _gate_flags, _gate_ops) \
+		  .gate = &(struct gate_cfg) {\
+			.reg_off	= _offset,\
+			.bit_idx	= _bit_idx,\
+		 },\
+		 .gate_ops = _gate_ops
+
+#define _GATE(_offset, _bit_idx, _gate_flags)\
+	_GATE_OPS(_offset, _bit_idx, _gate_flags, NULL)
+
+#define _DIV_TABLE_OPS(_offset, _shift, _width, _div_flags, _div_table,\
+		       _div_ops)\
+	.div = &(struct div_cfg) {\
+		.reg_off	= _offset,\
+		.shift		= _shift,\
+		.width		= _width,\
+		.div_flags	= _div_flags,\
+		.table		= _div_table,\
+	},\
+	.div_ops = _div_ops
+
+#define _DIV_TABLE(_offset, _shift, _width, _div_flags, _div_table)\
+		   _DIV_TABLE_OPS(_offset, _shift, _width, _div_flags,\
+				  _div_table, NULL)
+
+#define _DIV_OPS(_offset, _shift, _width, _div_flags, _div_ops)\
+	_DIV_TABLE_OPS(_offset, _shift, _width, _div_flags, NULL, _div_ops)
+
+#define _DIV(_offset, _shift, _width, _div_flags)\
+	_DIV_OPS(_offset, _shift, _width, _div_flags, NULL)
+
+#define _MUX(_offset, _shift, _width, _mux_flags)\
+	.mux = &(struct mux_cfg) {\
+		.reg_off	= _offset,\
+		.shift		= _shift,\
+		.width		= _width,\
+		.mux_flags	= _mux_flags,\
+		.table		= NULL,\
+	},\
+	.mux_ops = NULL
+
+#define _GATEDIV(_gate_offset,\
+		 _bit_idx,\
+		 _div_offset,\
+		 _div_shift,\
+		 _div_width,\
+		 _div_table)\
+{\
+	_DIV_TABLE(_div_offset, _div_shift, _div_width, 0, _div_table),\
+	_GATE(_gate_offset, _bit_idx, 0),\
+	_NO_MUX,\
+}
+
 #define MP1_GATE(_id, _name, _parent, _flags, _offset, _bit_idx, _gate_flags)\
 {\
 	.id		= _id,\
@@ -834,6 +1056,41 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 	PLL(PLL2, "pll2", "ref1", CLK_IGNORE_UNUSED, RCC_PLL2CR),
 	PLL(PLL3, "pll3", "ref3", CLK_IGNORE_UNUSED, RCC_PLL3CR),
 	PLL(PLL4, "pll4", "ref4", CLK_IGNORE_UNUSED, RCC_PLL4CR),
+
+	/* ODF */
+	COMPOSITE(PLL1_P, "pll1_p", PARENT("pll1"), 0,
+		  _GATEDIV(RCC_PLL1CR, 4,
+			   RCC_PLL1CFGR2, 0, 7, NULL)),
+
+	COMPOSITE(PLL2_P, "pll2_p", PARENT("pll2"), 0,
+		  _GATEDIV(RCC_PLL2CR, 4,
+			   RCC_PLL2CFGR2, 0, 7, NULL)),
+	COMPOSITE(PLL2_Q, "pll2_q", PARENT("pll2"), 0,
+		  _GATEDIV(RCC_PLL2CR, 5,
+			   RCC_PLL2CFGR2, 8, 7, NULL)),
+	COMPOSITE(PLL2_R, "pll2_r", PARENT("pll2"), CLK_IS_CRITICAL,
+		  _GATEDIV(RCC_PLL2CR, 6,
+			   RCC_PLL2CFGR2, 16, 7, NULL)),
+
+	COMPOSITE(PLL3_P, "pll3_p", PARENT("pll3"), 0,
+		  _GATEDIV(RCC_PLL3CR, 4,
+			   RCC_PLL3CFGR2, 0, 7, NULL)),
+	COMPOSITE(PLL3_Q, "pll3_q", PARENT("pll3"), 0,
+		  _GATEDIV(RCC_PLL3CR, 5,
+			   RCC_PLL3CFGR2, 8, 7, NULL)),
+	COMPOSITE(PLL3_R, "pll3_r", PARENT("pll3"), 0,
+		  _GATEDIV(RCC_PLL3CR, 6,
+			   RCC_PLL3CFGR2, 16, 7, NULL)),
+
+	COMPOSITE(PLL4_P, "pll4_p", PARENT("pll4"), 0,
+		  _GATEDIV(RCC_PLL4CR, 4,
+			   RCC_PLL4CFGR2, 0, 7, NULL)),
+	COMPOSITE(PLL4_Q, "pll4_q", PARENT("pll4"), 0,
+		  _GATEDIV(RCC_PLL4CR, 5,
+			   RCC_PLL4CFGR2, 8, 7, NULL)),
+	COMPOSITE(PLL4_R, "pll4_r", PARENT("pll4"), 0,
+		  _GATEDIV(RCC_PLL4CR, 6,
+			   RCC_PLL4CFGR2, 16, 7, NULL)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
