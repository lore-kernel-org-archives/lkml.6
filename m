Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeBBOHj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:07:39 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43714 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752150AbeBBOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:04:42 -0500
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
Subject: [PATCH 06/14] clk: stm32mp1: add PLL clocks
Date: Fri, 2 Feb 2018 15:03:34 +0100
Message-ID: <1517580222-23301-7-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

STMP32MP1 has 4 PLLs.
PLL supports integer and fractional mode.
Each PLL has 3 output dividers (p, q, r)

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 209 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 1c9a84a..33f0d09 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -7,6 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -506,6 +507,181 @@ static struct clk_hw *clk_register_mp1_gate(struct device *dev,
 	return hw;
 }
 
+/* STM32 PLL */
+
+struct stm32_pll_obj {
+	/* lock pll enable/disable registers */
+	spinlock_t *lock;
+	void __iomem *reg;
+	struct clk_hw hw;
+};
+
+#define to_pll(_hw) container_of(_hw, struct stm32_pll_obj, hw)
+
+#define PLL_ON		BIT(0)
+#define PLL_RDY		BIT(1)
+#define DIVN_MASK	0x1FF
+#define DIVM_MASK	0x3F
+#define DIVM_SHIFT	16
+#define DIVN_SHIFT	0
+#define FRAC_OFFSET	0xC
+#define FRAC_MASK	0x1FFF
+#define FRAC_SHIFT	3
+#define FRACLE		BIT(16)
+
+static int __pll_is_enabled(struct clk_hw *hw)
+{
+	struct stm32_pll_obj *clk_elem = to_pll(hw);
+
+	return readl_relaxed(clk_elem->reg) & PLL_ON;
+}
+
+#define TIMEOUT 5
+
+static int pll_enable(struct clk_hw *hw)
+{
+	struct stm32_pll_obj *clk_elem = to_pll(hw);
+	u32 reg;
+	unsigned long flags = 0;
+	unsigned int timeout = TIMEOUT;
+	int bit_status = 0;
+
+	spin_lock_irqsave(clk_elem->lock, flags);
+
+	if (__pll_is_enabled(hw))
+		goto unlock;
+
+	reg = readl_relaxed(clk_elem->reg);
+	reg |= PLL_ON;
+	writel_relaxed(reg, clk_elem->reg);
+
+	/* We can't use readl_poll_timeout() because we can be blocked if
+	 * someone enables this clock before clocksource changes.
+	 * Only jiffies counter is available. Jiffies are incremented by
+	 * interruptions and enable op does not allow to be interrupted.
+	 */
+	do {
+		bit_status = !(readl_relaxed(clk_elem->reg) & PLL_RDY);
+
+		if (bit_status)
+			udelay(120);
+
+	} while (bit_status && --timeout);
+
+unlock:
+	spin_unlock_irqrestore(clk_elem->lock, flags);
+
+	return bit_status;
+}
+
+static void pll_disable(struct clk_hw *hw)
+{
+	struct stm32_pll_obj *clk_elem = to_pll(hw);
+	u32 reg;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(clk_elem->lock, flags);
+
+	reg = readl_relaxed(clk_elem->reg);
+	reg &= ~PLL_ON;
+	writel_relaxed(reg, clk_elem->reg);
+
+	spin_unlock_irqrestore(clk_elem->lock, flags);
+}
+
+static u32 pll_frac_val(struct clk_hw *hw)
+{
+	struct stm32_pll_obj *clk_elem = to_pll(hw);
+	u32 reg, frac = 0;
+
+	reg = readl_relaxed(clk_elem->reg + FRAC_OFFSET);
+	if (reg & FRACLE)
+		frac = (reg >> FRAC_SHIFT) & FRAC_MASK;
+
+	return frac;
+}
+
+static unsigned long pll_recalc_rate(struct clk_hw *hw,
+				     unsigned long parent_rate)
+{
+	struct stm32_pll_obj *clk_elem = to_pll(hw);
+	u32 reg;
+	u32 frac, divm, divn;
+	u64 rate, rate_frac = 0;
+
+	reg = readl_relaxed(clk_elem->reg + 4);
+
+	divm = ((reg >> DIVM_SHIFT) & DIVM_MASK) + 1;
+	divn = ((reg >> DIVN_SHIFT) & DIVN_MASK) + 1;
+	rate = (u64)parent_rate * divn;
+
+	do_div(rate, divm);
+
+	frac = pll_frac_val(hw);
+	if (frac) {
+		rate_frac = (u64)parent_rate * (u64)frac;
+		do_div(rate_frac, (divm * 8192));
+	}
+
+	return rate + rate_frac;
+}
+
+static int pll_is_enabled(struct clk_hw *hw)
+{
+	struct stm32_pll_obj *clk_elem = to_pll(hw);
+	unsigned long flags = 0;
+	int ret;
+
+	spin_lock_irqsave(clk_elem->lock, flags);
+	ret = __pll_is_enabled(hw);
+	spin_unlock_irqrestore(clk_elem->lock, flags);
+
+	return ret;
+}
+
+static const struct clk_ops pll_ops = {
+	.enable = pll_enable,
+	.disable = pll_disable,
+	.recalc_rate = pll_recalc_rate,
+	.is_enabled = pll_is_enabled,
+};
+
+static struct clk_hw *clk_register_pll(struct device *dev, const char *name,
+				       const char *parent_name,
+				       void __iomem *reg,
+				       unsigned long flags,
+				       spinlock_t *lock)
+{
+	struct stm32_pll_obj *element;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int err;
+
+	element = kzalloc(sizeof(*element), GFP_KERNEL);
+	if (!element)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &pll_ops;
+	init.flags = flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	element->hw.init = &init;
+	element->reg = reg;
+	element->lock = lock;
+
+	hw = &element->hw;
+	err = clk_hw_register(dev, hw);
+
+	if (err) {
+		kfree(element);
+		return ERR_PTR(err);
+	}
+
+	return hw;
+}
+
 static struct clk_hw *
 _clk_register_mp1_gate(struct device *dev,
 		       struct clk_hw_onecell_data *clk_data,
@@ -524,6 +700,21 @@ static struct clk_hw *clk_register_mp1_gate(struct device *dev,
 				     lock);
 }
 
+struct stm32_pll_cfg {
+	u32 offset;
+};
+
+struct clk_hw *_clk_register_pll(struct device *dev,
+				 struct clk_hw_onecell_data *clk_data,
+				 void __iomem *base, spinlock_t *lock,
+				 const struct clock_config *cfg)
+{
+	struct stm32_pll_cfg *stm_pll_cfg = cfg->cfg;
+
+	return clk_register_pll(dev, cfg->name, cfg->parent_name,
+				base + stm_pll_cfg->offset, cfg->flags, lock);
+}
+
 #define GATE(_id, _name, _parent, _flags, _offset, _bit_idx, _gate_flags)\
 {\
 	.id		= _id,\
@@ -602,6 +793,18 @@ static struct clk_hw *clk_register_mp1_gate(struct device *dev,
 	.func		= _clk_register_mp1_gate,\
 }
 
+#define PLL(_id, _name, _parent, _flags, _offset)\
+{\
+	.id		= _id,\
+	.name		= _name,\
+	.parent_name	= _parent,\
+	.flags		= _flags,\
+	.cfg		=  &(struct stm32_pll_cfg) {\
+		.offset = _offset,\
+	},\
+	.func		= _clk_register_pll,\
+}
+
 static const struct clock_config stm32mp1_clock_cfg[] = {
 	/* Oscillator divider */
 	DIV(NO_ID, "clk-hsi-div", "clk-hsi", 0, RCC_HSICFGR, 0, 2,
@@ -625,6 +828,12 @@ static struct clk_hw *clk_register_mp1_gate(struct device *dev,
 
 	MUX(NO_ID, "ref4", ref4_parents, CLK_OPS_PARENT_ENABLE, RCC_RCK4SELR,
 	    0, 2, CLK_MUX_READ_ONLY),
+
+	/* PLLs */
+	PLL(PLL1, "pll1", "ref1", CLK_IGNORE_UNUSED, RCC_PLL1CR),
+	PLL(PLL2, "pll2", "ref1", CLK_IGNORE_UNUSED, RCC_PLL2CR),
+	PLL(PLL3, "pll3", "ref3", CLK_IGNORE_UNUSED, RCC_PLL3CR),
+	PLL(PLL4, "pll4", "ref4", CLK_IGNORE_UNUSED, RCC_PLL4CR),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
