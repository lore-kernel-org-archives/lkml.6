Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935972AbeCHQzM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:55:12 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:5229 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932076AbeCHQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:55:09 -0500
From: <gabriel.fernandez@st.com>
To: <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <gabriel.fernandez.st@gmail.com>, <olivier.bideau@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: [PATCH v2 06/12] clk: stm32mp1: add Post-dividers for PLL
Date: Thu, 8 Mar 2018 17:53:59 +0100
Message-ID: <1520528045-18330-7-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_09:,,
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
 drivers/clk/clk-stm32mp1.c | 221 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index d62a3a9..3a99ad7 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -166,6 +166,23 @@ struct stm32_gate_cfg {
 	const struct clk_ops	*ops;
 };
 
+struct stm32_div_cfg {
+	struct div_cfg		*div;
+	const struct clk_ops	*ops;
+};
+
+struct stm32_mux_cfg {
+	struct mux_cfg		*mux;
+	const struct clk_ops	*ops;
+};
+
+/* STM32 Composite clock */
+struct stm32_composite_cfg {
+	const struct stm32_gate_cfg	*gate;
+	const struct stm32_div_cfg	*div;
+	const struct stm32_mux_cfg	*mux;
+};
+
 static struct clk_hw *
 _clk_hw_register_gate(struct device *dev,
 		      struct clk_hw_onecell_data *clk_data,
@@ -259,6 +276,51 @@ static void mp1_gate_clk_disable(struct clk_hw *hw)
 	.is_enabled	= clk_gate_is_enabled,
 };
 
+static struct clk_hw *_get_stm32_mux(void __iomem *base,
+				     const struct stm32_mux_cfg *cfg,
+				     spinlock_t *lock)
+{
+	struct clk_mux *mux;
+	struct clk_hw *mux_hw;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	mux->reg = cfg->mux->reg_off + base;
+	mux->shift = cfg->mux->shift;
+	mux->mask = (1 << cfg->mux->width) - 1;
+	mux->flags = cfg->mux->mux_flags;
+	mux->table = cfg->mux->table;
+
+	mux->lock = lock;
+
+	mux_hw = &mux->hw;
+
+	return mux_hw;
+}
+
+static struct clk_hw *_get_stm32_div(void __iomem *base,
+				     const struct stm32_div_cfg *cfg,
+				     spinlock_t *lock)
+{
+	struct clk_divider *div;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	div->reg = cfg->div->reg_off + base;
+	div->shift = cfg->div->shift;
+	div->width = cfg->div->width;
+	div->flags = cfg->div->div_flags;
+	div->table = cfg->div->table;
+	div->lock = lock;
+
+	return &div->hw;
+}
+
 static struct clk_hw *
 _get_stm32_gate(void __iomem *base,
 		const struct stm32_gate_cfg *cfg, spinlock_t *lock)
@@ -322,6 +384,61 @@ static void mp1_gate_clk_disable(struct clk_hw *hw)
 	return hw;
 }
 
+static struct clk_hw *
+clk_stm32_register_composite(struct device *dev,
+			     const char *name, const char * const *parent_names,
+			     int num_parents, void __iomem *base,
+			     const struct stm32_composite_cfg *cfg,
+			     unsigned long flags, spinlock_t *lock)
+{
+	const struct clk_ops *mux_ops, *div_ops, *gate_ops;
+	struct clk_hw *mux_hw, *div_hw, *gate_hw;
+
+	mux_hw = NULL;
+	div_hw = NULL;
+	gate_hw = NULL;
+	mux_ops = NULL;
+	div_ops = NULL;
+	gate_ops = NULL;
+
+	if (cfg->mux) {
+		mux_hw = _get_stm32_mux(base, cfg->mux, lock);
+
+		if (!IS_ERR(mux_hw)) {
+			mux_ops = &clk_mux_ops;
+
+			if (cfg->mux->ops)
+				mux_ops = cfg->mux->ops;
+		}
+	}
+
+	if (cfg->div) {
+		div_hw = _get_stm32_div(base, cfg->div, lock);
+
+		if (!IS_ERR(div_hw)) {
+			div_ops = &clk_divider_ops;
+
+			if (cfg->div->ops)
+				div_ops = cfg->div->ops;
+		}
+	}
+
+	if (cfg->gate) {
+		gate_hw = _get_stm32_gate(base, cfg->gate, lock);
+
+		if (!IS_ERR(gate_hw)) {
+			gate_ops = &clk_gate_ops;
+
+			if (cfg->gate->ops)
+				gate_ops = cfg->gate->ops;
+		}
+	}
+
+	return clk_hw_register_composite(dev, name, parent_names, num_parents,
+				       mux_hw, mux_ops, div_hw, div_ops,
+				       gate_hw, gate_ops, flags);
+}
+
 /* STM32 PLL */
 
 struct stm32_pll_obj {
@@ -527,6 +644,17 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 				    lock);
 }
 
+static struct clk_hw *
+_clk_stm32_register_composite(struct device *dev,
+			      struct clk_hw_onecell_data *clk_data,
+			      void __iomem *base, spinlock_t *lock,
+			      const struct clock_config *cfg)
+{
+	return clk_stm32_register_composite(dev, cfg->name, cfg->parent_names,
+					    cfg->num_parents, base, cfg->cfg,
+					    cfg->flags, lock);
+}
+
 #define GATE(_id, _name, _parent, _flags, _offset, _bit_idx, _gate_flags)\
 {\
 	.id		= _id,\
@@ -624,6 +752,10 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 		.ops		= _ops,\
 	})
 
+#define _GATE(_gate_offset, _gate_bit_idx, _gate_flags)\
+	_STM32_GATE(_gate_offset, _gate_bit_idx, _gate_flags,\
+		    NULL)\
+
 #define _GATE_MP1(_gate_offset, _gate_bit_idx, _gate_flags)\
 	_STM32_GATE(_gate_offset, _gate_bit_idx, _gate_flags,\
 		    &mp1_gate_clk_ops)\
@@ -632,6 +764,44 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 	STM32_GATE(_id, _name, _parent, _flags,\
 		   _GATE_MP1(_offset, _bit_idx, _gate_flags))
 
+#define _STM32_DIV(_div_offset, _div_shift, _div_width,\
+		   _div_flags, _div_table, _ops)\
+	.div = &(struct stm32_div_cfg) {\
+		&(struct div_cfg) {\
+			.reg_off	= _div_offset,\
+			.shift		= _div_shift,\
+			.width		= _div_width,\
+			.div_flags	= _div_flags,\
+			.table		= _div_table,\
+		},\
+		.ops		= _ops,\
+	}
+
+#define _DIV(_div_offset, _div_shift, _div_width, _div_flags, _div_table)\
+	_STM32_DIV(_div_offset, _div_shift, _div_width,\
+		   _div_flags, _div_table, NULL)\
+
+#define PARENT(_parent) ((const char *[]) { _parent})
+
+#define _NO_MUX .mux = NULL
+#define _NO_DIV .div = NULL
+#define _NO_GATE .gate = NULL
+
+#define COMPOSITE(_id, _name, _parents, _flags, _gate, _mux, _div)\
+{\
+	.id		= _id,\
+	.name		= _name,\
+	.parent_names	= _parents,\
+	.num_parents	= ARRAY_SIZE(_parents),\
+	.flags		= _flags,\
+	.cfg		= &(struct stm32_composite_cfg) {\
+		_gate,\
+		_mux,\
+		_div,\
+	},\
+	.func		= _clk_stm32_register_composite,\
+}
+
 static const struct clock_config stm32mp1_clock_cfg[] = {
 	/* Oscillator divider */
 	DIV(NO_ID, "clk-hsi-div", "clk-hsi", 0, RCC_HSICFGR, 0, 2,
@@ -661,6 +831,57 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 	PLL(PLL2, "pll2", "ref1", CLK_IGNORE_UNUSED, RCC_PLL2CR),
 	PLL(PLL3, "pll3", "ref3", CLK_IGNORE_UNUSED, RCC_PLL3CR),
 	PLL(PLL4, "pll4", "ref4", CLK_IGNORE_UNUSED, RCC_PLL4CR),
+
+	/* ODF */
+	COMPOSITE(PLL1_P, "pll1_p", PARENT("pll1"), 0,
+		  _GATE(RCC_PLL1CR, 4, 0),
+		  _NO_MUX,
+		  _DIV(RCC_PLL1CFGR2, 0, 7, 0, NULL)),
+
+	COMPOSITE(PLL2_P, "pll2_p", PARENT("pll2"), 0,
+		  _GATE(RCC_PLL2CR, 4, 0),
+		  _NO_MUX,
+		  _DIV(RCC_PLL2CFGR2, 0, 7, 0, NULL)),
+
+	COMPOSITE(PLL2_Q, "pll2_q", PARENT("pll2"), 0,
+		  _GATE(RCC_PLL2CR, 5, 0),
+		  _NO_MUX,
+		  _DIV(RCC_PLL2CFGR2, 8, 7, 0, NULL)),
+
+	COMPOSITE(PLL2_R, "pll2_r", PARENT("pll2"), CLK_IS_CRITICAL,
+		  _GATE(RCC_PLL2CR, 6, 0),
+		  _NO_MUX,
+		  _DIV(RCC_PLL2CFGR2, 16, 7, 0, NULL)),
+
+	COMPOSITE(PLL3_P, "pll3_p", PARENT("pll3"), 0,
+		  _GATE(RCC_PLL3CR, 4, 0),
+		  _NO_MUX,
+		  _DIV(RCC_PLL3CFGR2, 0, 7, 0, NULL)),
+
+	COMPOSITE(PLL3_Q, "pll3_q", PARENT("pll3"), 0,
+		  _GATE(RCC_PLL3CR, 5, 0),
+		  _NO_MUX,
+		  _DIV(RCC_PLL3CFGR2, 8, 7, 0, NULL)),
+
+	COMPOSITE(PLL3_R, "pll3_r", PARENT("pll3"), 0,
+		  _GATE(RCC_PLL3CR, 6, 0),
+		  _NO_MUX,
+		  _DIV(RCC_PLL3CFGR2, 16, 7, 0, NULL)),
+
+	COMPOSITE(PLL4_P, "pll4_p", PARENT("pll4"), 0,
+		  _GATE(RCC_PLL4CR, 4, 0),
+		  _NO_MUX,
+		  _DIV(RCC_PLL4CFGR2, 0, 7, 0, NULL)),
+
+	COMPOSITE(PLL4_Q, "pll4_q", PARENT("pll4"), 0,
+		  _GATE(RCC_PLL4CR, 5, 0),
+		  _NO_MUX,
+		  _DIV(RCC_PLL4CFGR2, 8, 7, 0, NULL)),
+
+	COMPOSITE(PLL4_R, "pll4_r", PARENT("pll4"), 0,
+		  _GATE(RCC_PLL4CR, 6, 0),
+		  _NO_MUX,
+		  _DIV(RCC_PLL4CFGR2, 16, 7, 0, NULL)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
