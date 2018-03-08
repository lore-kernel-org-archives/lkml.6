Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754671AbeCHQz7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:55:59 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:12982 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935911AbeCHQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:55:01 -0500
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
Subject: [PATCH v2 03/12] clk: stm32mp1: add MP1 gate for hse/hsi/csi oscillators
Date: Thu, 8 Mar 2018 17:53:56 +0100
Message-ID: <1520528045-18330-4-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

MP1 Gate is a gate with a set and a clear register.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 143 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 6261a92..56b738e 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -140,6 +140,11 @@ struct div_cfg {
 	const struct clk_div_table *table;
 };
 
+struct stm32_gate_cfg {
+	struct gate_cfg		*gate;
+	const struct clk_ops	*ops;
+};
+
 static struct clk_hw *
 _clk_hw_register_gate(struct device *dev,
 		      struct clk_hw_onecell_data *clk_data,
@@ -191,6 +196,112 @@ struct div_cfg {
 					     lock);
 }
 
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
+static struct clk_hw *
+_get_stm32_gate(void __iomem *base,
+		const struct stm32_gate_cfg *cfg, spinlock_t *lock)
+{
+	struct clk_gate *gate;
+	struct clk_hw *gate_hw;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	gate->reg = cfg->gate->reg_off + base;
+	gate->bit_idx = cfg->gate->bit_idx;
+	gate->flags = cfg->gate->gate_flags;
+	gate->lock = lock;
+	gate_hw = &gate->hw;
+
+	return gate_hw;
+}
+
+static struct clk_hw *
+clk_stm32_register_gate_ops(struct device *dev,
+			    const char *name,
+			    const char *parent_name,
+			    unsigned long flags,
+			    void __iomem *base,
+			    const struct stm32_gate_cfg *cfg,
+			    spinlock_t *lock)
+{
+	struct clk_init_data init = { NULL };
+	struct clk_gate *gate;
+	struct clk_hw *hw;
+	int ret;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = flags;
+
+	init.ops = &clk_gate_ops;
+
+	if (cfg->ops)
+		init.ops = cfg->ops;
+
+	hw = _get_stm32_gate(base, cfg, lock);
+	if (IS_ERR(hw))
+		return ERR_PTR(-ENOMEM);
+
+	hw->init = &init;
+
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+static struct clk_hw *
+_clk_stm32_register_gate(struct device *dev,
+			 struct clk_hw_onecell_data *clk_data,
+			 void __iomem *base, spinlock_t *lock,
+			 const struct clock_config *cfg)
+{
+	return clk_stm32_register_gate_ops(dev,
+				    cfg->name,
+				    cfg->parent_name,
+				    cfg->flags,
+				    base,
+				    cfg->cfg,
+				    lock);
+}
+
 #define GATE(_id, _name, _parent, _flags, _offset, _bit_idx, _gate_flags)\
 {\
 	.id		= _id,\
@@ -239,12 +350,44 @@ struct div_cfg {
 	DIV_TABLE(_id, _name, _parent, _flags, _offset, _shift, _width,\
 		  _div_flags, NULL)
 
+/* STM32 GATE */
+#define STM32_GATE(_id, _name, _parent, _flags, _gate)\
+{\
+	.id		= _id,\
+	.name		= _name,\
+	.parent_name	= _parent,\
+	.flags		= _flags,\
+	.cfg		= (struct stm32_gate_cfg *) {_gate},\
+	.func		= _clk_stm32_register_gate,\
+}
+
+#define _STM32_GATE(_gate_offset, _gate_bit_idx, _gate_flags, _ops)\
+	(&(struct stm32_gate_cfg) {\
+		&(struct gate_cfg) {\
+			.reg_off	= _gate_offset,\
+			.bit_idx	= _gate_bit_idx,\
+			.gate_flags	= _gate_flags,\
+		},\
+		.ops		= _ops,\
+	})
+
+#define _GATE_MP1(_gate_offset, _gate_bit_idx, _gate_flags)\
+	_STM32_GATE(_gate_offset, _gate_bit_idx, _gate_flags,\
+		    &mp1_gate_clk_ops)\
+
+#define GATE_MP1(_id, _name, _parent, _flags, _offset, _bit_idx, _gate_flags)\
+	STM32_GATE(_id, _name, _parent, _flags,\
+		   _GATE_MP1(_offset, _bit_idx, _gate_flags))
+
 static const struct clock_config stm32mp1_clock_cfg[] = {
 	/* Oscillator divider */
 	DIV(NO_ID, "clk-hsi-div", "clk-hsi", 0, RCC_HSICFGR, 0, 2,
 	    CLK_DIVIDER_READ_ONLY),
 
 	/*  External / Internal Oscillators */
+	GATE_MP1(CK_HSE, "ck_hse", "clk-hse", 0, RCC_OCENSETR, 8, 0),
+	GATE_MP1(CK_CSI, "ck_csi", "clk-csi", 0, RCC_OCENSETR, 4, 0),
+	GATE_MP1(CK_HSI, "ck_hsi", "clk-hsi-div", 0, RCC_OCENSETR, 0, 0),
 	GATE(CK_LSI, "ck_lsi", "clk-lsi", 0, RCC_RDLSICR, 0, 0),
 	GATE(CK_LSE, "ck_lse", "clk-lse", 0, RCC_BDCR, 0, 0),
 
-- 
1.9.1
