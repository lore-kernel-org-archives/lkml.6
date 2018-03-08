Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936052AbeCHQ5Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:57:24 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21754 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934062AbeCHQyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:54:47 -0500
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
Subject: [PATCH v2 08/12] clk: stm32mp1: add Kernel timers
Date: Thu, 8 Mar 2018 17:54:01 +0100
Message-ID: <1520528045-18330-9-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds Kernel timers.
This patch adds timers kernel clock.
Timers are gather into two groups corresponding to the APB bus
they are attached to.
Each group has its own prescaler, managed in this patch.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 185 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 77d96d9..0470a13 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -650,6 +650,138 @@ static struct clk_hw *clk_register_pll(struct device *dev, const char *name,
 	return hw;
 }
 
+/* Kernel Timer */
+struct timer_cker {
+	/* lock the kernel output divider register */
+	spinlock_t *lock;
+	void __iomem *apbdiv;
+	void __iomem *timpre;
+	struct clk_hw hw;
+};
+
+#define to_timer_cker(_hw) container_of(_hw, struct timer_cker, hw)
+
+#define APB_DIV_MASK 0x07
+#define TIM_PRE_MASK 0x01
+
+static unsigned long __bestmult(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct timer_cker *tim_ker = to_timer_cker(hw);
+	u32 prescaler;
+	unsigned int mult = 0;
+
+	prescaler = readl_relaxed(tim_ker->apbdiv) & APB_DIV_MASK;
+	if (prescaler < 2)
+		return 1;
+
+	mult = 2;
+
+	if (rate / parent_rate >= 4)
+		mult = 4;
+
+	return mult;
+}
+
+static long timer_ker_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *parent_rate)
+{
+	unsigned long factor = __bestmult(hw, rate, *parent_rate);
+
+	return *parent_rate * factor;
+}
+
+static int timer_ker_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct timer_cker *tim_ker = to_timer_cker(hw);
+	unsigned long flags = 0;
+	unsigned long factor = __bestmult(hw, rate, parent_rate);
+	int ret = 0;
+
+	spin_lock_irqsave(tim_ker->lock, flags);
+
+	switch (factor) {
+	case 1:
+		break;
+	case 2:
+		writel_relaxed(0, tim_ker->timpre);
+		break;
+	case 4:
+		writel_relaxed(1, tim_ker->timpre);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	spin_unlock_irqrestore(tim_ker->lock, flags);
+
+	return ret;
+}
+
+static unsigned long timer_ker_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct timer_cker *tim_ker = to_timer_cker(hw);
+	u32 prescaler, timpre;
+	u32 mul;
+
+	prescaler = readl_relaxed(tim_ker->apbdiv) & APB_DIV_MASK;
+
+	timpre = readl_relaxed(tim_ker->timpre) & TIM_PRE_MASK;
+
+	if (!prescaler)
+		return parent_rate;
+
+	mul = (timpre + 1) * 2;
+
+	return parent_rate * mul;
+}
+
+static const struct clk_ops timer_ker_ops = {
+	.recalc_rate	= timer_ker_recalc_rate,
+	.round_rate	= timer_ker_round_rate,
+	.set_rate	= timer_ker_set_rate,
+
+};
+
+static struct clk_hw *clk_register_cktim(struct device *dev, const char *name,
+					 const char *parent_name,
+					 unsigned long flags,
+					 void __iomem *apbdiv,
+					 void __iomem *timpre,
+					 spinlock_t *lock)
+{
+	struct timer_cker *tim_ker;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int err;
+
+	tim_ker = kzalloc(sizeof(*tim_ker), GFP_KERNEL);
+	if (!tim_ker)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &timer_ker_ops;
+	init.flags = flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	tim_ker->hw.init = &init;
+	tim_ker->lock = lock;
+	tim_ker->apbdiv = apbdiv;
+	tim_ker->timpre = timpre;
+
+	hw = &tim_ker->hw;
+	err = clk_hw_register(dev, hw);
+
+	if (err) {
+		kfree(tim_ker);
+		return ERR_PTR(err);
+	}
+
+	return hw;
+}
+
 struct stm32_pll_cfg {
 	u32 offset;
 };
@@ -665,6 +797,23 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 				base + stm_pll_cfg->offset, cfg->flags, lock);
 }
 
+struct stm32_cktim_cfg {
+	u32 offset_apbdiv;
+	u32 offset_timpre;
+};
+
+static struct clk_hw *_clk_register_cktim(struct device *dev,
+					  struct clk_hw_onecell_data *clk_data,
+					  void __iomem *base, spinlock_t *lock,
+					  const struct clock_config *cfg)
+{
+	struct stm32_cktim_cfg *cktim_cfg = cfg->cfg;
+
+	return clk_register_cktim(dev, cfg->name, cfg->parent_name, cfg->flags,
+				  cktim_cfg->offset_apbdiv + base,
+				  cktim_cfg->offset_timpre + base, lock);
+}
+
 static struct clk_hw *
 _clk_stm32_register_gate(struct device *dev,
 			 struct clk_hw_onecell_data *clk_data,
@@ -767,6 +916,23 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 	.func		= _clk_register_pll,\
 }
 
+#define STM32_CKTIM(_name, _parent, _flags, _offset_apbdiv, _offset_timpre)\
+{\
+	.id		= NO_ID,\
+	.name		= _name,\
+	.parent_name	= _parent,\
+	.flags		= _flags,\
+	.cfg		=  &(struct stm32_cktim_cfg) {\
+		.offset_apbdiv = _offset_apbdiv,\
+		.offset_timpre = _offset_timpre,\
+	},\
+	.func		= _clk_register_cktim,\
+}
+
+#define STM32_TIM(_id, _name, _parent, _offset_set, _bit_idx)\
+		  GATE_MP1(_id, _name, _parent, CLK_SET_RATE_PARENT,\
+			   _offset_set, _bit_idx, 0)
+
 /* STM32 GATE */
 #define STM32_GATE(_id, _name, _parent, _flags, _gate)\
 {\
@@ -967,6 +1133,25 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 
 	DIV_TABLE(NO_ID, "pclk5", "ck_axi", CLK_IGNORE_UNUSED, RCC_APB5DIVR, 0,
 		  3, CLK_DIVIDER_READ_ONLY, apb_div_table),
+
+	/* Kernel Timers */
+	STM32_CKTIM("ck1_tim", "pclk1", 0, RCC_APB1DIVR, RCC_TIMG1PRER),
+	STM32_CKTIM("ck2_tim", "pclk2", 0, RCC_APB2DIVR, RCC_TIMG2PRER),
+
+	STM32_TIM(TIM2_K, "tim2_k", "ck1_tim", RCC_APB1ENSETR, 0),
+	STM32_TIM(TIM3_K, "tim3_k", "ck1_tim", RCC_APB1ENSETR, 1),
+	STM32_TIM(TIM4_K, "tim4_k", "ck1_tim", RCC_APB1ENSETR, 2),
+	STM32_TIM(TIM5_K, "tim5_k", "ck1_tim", RCC_APB1ENSETR, 3),
+	STM32_TIM(TIM6_K, "tim6_k", "ck1_tim", RCC_APB1ENSETR, 4),
+	STM32_TIM(TIM7_K, "tim7_k", "ck1_tim", RCC_APB1ENSETR, 5),
+	STM32_TIM(TIM12_K, "tim12_k", "ck1_tim", RCC_APB1ENSETR, 6),
+	STM32_TIM(TIM13_K, "tim13_k", "ck1_tim", RCC_APB1ENSETR, 7),
+	STM32_TIM(TIM14_K, "tim14_k", "ck1_tim", RCC_APB1ENSETR, 8),
+	STM32_TIM(TIM1_K, "tim1_k", "ck2_tim", RCC_APB2ENSETR, 0),
+	STM32_TIM(TIM8_K, "tim8_k", "ck2_tim", RCC_APB2ENSETR, 1),
+	STM32_TIM(TIM15_K, "tim15_k", "ck2_tim", RCC_APB2ENSETR, 2),
+	STM32_TIM(TIM16_K, "tim16_k", "ck2_tim", RCC_APB2ENSETR, 3),
+	STM32_TIM(TIM17_K, "tim17_k", "ck2_tim", RCC_APB2ENSETR, 4),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
