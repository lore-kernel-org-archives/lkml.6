Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeBBOIK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:08:10 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48208 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752140AbeBBOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:04:41 -0500
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
Subject: [PATCH 04/14] clk: stm32mp1: add MP1 gate for osc hse/hsi/csi oscillators
Date: Fri, 2 Feb 2018 15:03:32 +0100
Message-ID: <1517580222-23301-5-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

MP1 Gate is a gate with a set and a clear register.
This patch also introduces divider and fixed factor clocks.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 186 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 6e39e85..be5a4e5 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -355,6 +355,19 @@ struct gate_cfg {
 	u8 gate_flags;
 };
 
+struct fixed_factor_cfg {
+	unsigned int mult;
+	unsigned int div;
+};
+
+struct div_cfg {
+	u32 reg_off;
+	u8 shift;
+	u8 width;
+	u8 div_flags;
+	const struct clk_div_table *table;
+};
+
 static struct clk_hw *
 _clk_hw_register_gate(struct device *dev,
 		      struct clk_hw_onecell_data *clk_data,
@@ -373,6 +386,122 @@ struct gate_cfg {
 				    lock);
 }
 
+static struct clk_hw *
+_clk_hw_register_fixed_factor(struct device *dev,
+			      struct clk_hw_onecell_data *clk_data,
+			      void __iomem *base, spinlock_t *lock,
+			      const struct clock_config *cfg)
+{
+	struct fixed_factor_cfg *ff_cfg = cfg->cfg;
+
+	return clk_hw_register_fixed_factor(dev, cfg->name, cfg->parent_name,
+					    cfg->flags, ff_cfg->mult,
+					    ff_cfg->div);
+}
+
+static struct clk_hw *
+_clk_hw_register_divider_table(struct device *dev,
+			       struct clk_hw_onecell_data *clk_data,
+			       void __iomem *base, spinlock_t *lock,
+			       const struct clock_config *cfg)
+{
+	struct div_cfg *div_cfg = cfg->cfg;
+
+	return clk_hw_register_divider_table(dev,
+					     cfg->name,
+					     cfg->parent_name,
+					     cfg->flags,
+					     div_cfg->reg_off + base,
+					     div_cfg->shift,
+					     div_cfg->width,
+					     div_cfg->div_flags,
+					     div_cfg->table,
+					     lock);
+}
+
+/* MP1 Gate clock with set & clear registers */
+
+static int mp1_gate_clk_enable(struct clk_hw *hw)
+{
+	if (!clk_gate_ops.is_enabled(hw))
+		clk_gate_ops.enable(hw);
+
+	return 0;
+}
+
+static void mp1_gate_clk_disable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	unsigned long flags = 0;
+
+	if (clk_gate_ops.is_enabled(hw)) {
+		spin_lock_irqsave(gate->lock, flags);
+		writel_relaxed(BIT(gate->bit_idx), gate->reg + RCC_CLR);
+		spin_unlock_irqrestore(gate->lock, flags);
+	}
+}
+
+const struct clk_ops mp1_gate_clk_ops = {
+	.enable		= mp1_gate_clk_enable,
+	.disable	= mp1_gate_clk_disable,
+	.is_enabled	= clk_gate_is_enabled,
+};
+
+static struct clk_hw *clk_register_mp1_gate(struct device *dev,
+					    const char *name,
+					    const char *parent_name,
+					    unsigned long flags,
+					    void __iomem *reg, u8 bit_idx,
+					    u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clk_init_data init = { NULL };
+	struct clk_gate *gate;
+	int ret;
+	struct clk_hw *hw;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &mp1_gate_clk_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = flags;
+
+	gate->reg = reg;
+	gate->bit_idx = bit_idx;
+	gate->lock = lock;
+
+	gate->hw.init = &init;
+	hw = &gate->hw;
+
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
+	return hw;
+}
+
+static struct clk_hw *
+_clk_register_mp1_gate(struct device *dev,
+		       struct clk_hw_onecell_data *clk_data,
+		       void __iomem *base, spinlock_t *lock,
+		       const struct clock_config *cfg)
+{
+	struct gate_cfg *gate_cfg = cfg->cfg;
+
+	return clk_register_mp1_gate(dev,
+				     cfg->name,
+				     cfg->parent_name,
+				     cfg->flags,
+				     gate_cfg->reg_off + base,
+				     gate_cfg->bit_idx,
+				     gate_cfg->gate_flags,
+				     lock);
+}
+
 #define GATE(_id, _name, _parent, _flags, _offset, _bit_idx, _gate_flags)\
 {\
 	.id		= _id,\
@@ -387,10 +516,67 @@ struct gate_cfg {
 	.func		= _clk_hw_register_gate,\
 }
 
+#define FIXED_FACTOR(_id, _name, _parent, _flags, _mult, _div)\
+{\
+	.id		= _id,\
+	.name		= _name,\
+	.parent_name	= _parent,\
+	.flags		= _flags,\
+	.cfg		=  &(struct fixed_factor_cfg) {\
+		.mult = _mult,\
+		.div = _div,\
+	},\
+	.func		= _clk_hw_register_fixed_factor,\
+}
+
+#define DIV_TABLE(_id, _name, _parent, _flags, _offset, _shift, _width,\
+		  _div_flags, _div_table)\
+{\
+	.id		= _id,\
+	.name		= _name,\
+	.parent_name	= _parent,\
+	.flags		= _flags,\
+	.cfg		=  &(struct div_cfg) {\
+		.reg_off	= _offset,\
+		.shift		= _shift,\
+		.width		= _width,\
+		.div_flags	= _div_flags,\
+		.table		= _div_table,\
+	},\
+	.func		= _clk_hw_register_divider_table,\
+}
+
+#define DIV(_id, _name, _parent, _flags, _offset, _shift, _width, _div_flags)\
+	DIV_TABLE(_id, _name, _parent, _flags, _offset, _shift, _width,\
+		  _div_flags, NULL)
+
+#define MP1_GATE(_id, _name, _parent, _flags, _offset, _bit_idx, _gate_flags)\
+{\
+	.id		= _id,\
+	.name		= _name,\
+	.parent_name	= _parent,\
+	.flags		= _flags,\
+	.cfg		=  &(struct gate_cfg) {\
+		.reg_off	= _offset,\
+		.bit_idx	= _bit_idx,\
+		.gate_flags	= _gate_flags,\
+	},\
+	.func		= _clk_register_mp1_gate,\
+}
+
 static const struct clock_config stm32mp1_clock_cfg[] = {
+	/* Oscillator divider */
+	DIV(NO_ID, "clk-hsi-div", "clk-hsi", 0, RCC_HSICFGR, 0, 2,
+	    CLK_DIVIDER_READ_ONLY),
+
 	/*  External / Internal Oscillators */
+	MP1_GATE(CK_HSE, "ck_hse", "clk-hse", 0, RCC_OCENSETR, 8, 0),
+	MP1_GATE(CK_CSI, "ck_csi", "clk-csi", 0, RCC_OCENSETR, 4, 0),
+	MP1_GATE(CK_HSI, "ck_hsi", "clk-hsi-div", 0, RCC_OCENSETR, 0, 0),
 	GATE(CK_LSI, "ck_lsi", "clk-lsi", 0, RCC_RDLSICR, 0, 0),
 	GATE(CK_LSE, "ck_lse", "clk-lse", 0, RCC_BDCR, 0, 0),
+
+	FIXED_FACTOR(CK_HSE_DIV2, "clk-hse-div2", "ck_hse", 0, 1, 2),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
