Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeBCPv5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 10:51:57 -0500
Received: from hermes.aosc.io ([199.195.250.187]:56478 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752103AbeBCPvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 10:51:00 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 1/6] pinctrl: sunxi: support pin controllers with holes among IRQ banks
Date: Sat,  3 Feb 2018 23:49:37 +0800
Message-Id: <20180203154942.63566-2-icenowy@aosc.io>
In-Reply-To: <20180203154942.63566-1-icenowy@aosc.io>
References: <20180203154942.63566-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5. This
situation cannot be processed with the current pinctrl IRQ code, as it
only expects a offset to all IRQ banks.

Update the code to use a logical IRQ bank to hardware IRQ bank map, so
the new situation in H6 main pin controller can be processed. The old
special situation which uses a constant offset (on A33 and V3s, both
with a offset of 1) can be also processed with the new code.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
No changes in v2.

 drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c |  4 ++-
 drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c |  4 ++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c     | 16 ++++++------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h     | 41 +++++++++++++++++++++----------
 4 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
index da387211a75e..f043afa1aac5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
@@ -481,11 +481,13 @@ static const struct sunxi_desc_pin sun8i_a33_pins[] = {
 		  SUNXI_FUNCTION(0x3, "uart3")),	/* CTS */
 };
 
+static const unsigned int sun8i_a33_pinctrl_irq_bank_map[] = { 1, 2 };
+
 static const struct sunxi_pinctrl_desc sun8i_a33_pinctrl_data = {
 	.pins = sun8i_a33_pins,
 	.npins = ARRAY_SIZE(sun8i_a33_pins),
 	.irq_banks = 2,
-	.irq_bank_base = 1,
+	.irq_bank_map = sun8i_a33_pinctrl_irq_bank_map,
 	.disable_strict_mode = true,
 };
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
index 496ba34e1f5f..6704ce8e5e3d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
@@ -293,11 +293,13 @@ static const struct sunxi_desc_pin sun8i_v3s_pins[] = {
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PG_EINT5 */
 };
 
+static const unsigned int sun8i_v3s_pinctrl_irq_bank_map[] = { 1, 2 };
+
 static const struct sunxi_pinctrl_desc sun8i_v3s_pinctrl_data = {
 	.pins = sun8i_v3s_pins,
 	.npins = ARRAY_SIZE(sun8i_v3s_pins),
 	.irq_banks = 2,
-	.irq_bank_base = 1,
+	.irq_bank_map = sun8i_v3s_pinctrl_irq_bank_map,
 	.irq_read_needs_mux = true
 };
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 341312d66512..9d65b3bf7644 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -835,7 +835,7 @@ static void sunxi_pinctrl_irq_release_resources(struct irq_data *d)
 static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	u32 reg = sunxi_irq_cfg_reg(d->hwirq, pctl->desc->irq_bank_base);
+	u32 reg = sunxi_irq_cfg_reg(d->hwirq, pctl->desc->irq_bank_map);
 	u8 index = sunxi_irq_cfg_offset(d->hwirq);
 	unsigned long flags;
 	u32 regval;
@@ -883,7 +883,7 @@ static void sunxi_pinctrl_irq_ack(struct irq_data *d)
 {
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
 	u32 status_reg = sunxi_irq_status_reg(d->hwirq,
-					      pctl->desc->irq_bank_base);
+					      pctl->desc->irq_bank_map);
 	u8 status_idx = sunxi_irq_status_offset(d->hwirq);
 
 	/* Clear the IRQ */
@@ -893,7 +893,7 @@ static void sunxi_pinctrl_irq_ack(struct irq_data *d)
 static void sunxi_pinctrl_irq_mask(struct irq_data *d)
 {
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	u32 reg = sunxi_irq_ctrl_reg(d->hwirq, pctl->desc->irq_bank_base);
+	u32 reg = sunxi_irq_ctrl_reg(d->hwirq, pctl->desc->irq_bank_map);
 	u8 idx = sunxi_irq_ctrl_offset(d->hwirq);
 	unsigned long flags;
 	u32 val;
@@ -910,7 +910,7 @@ static void sunxi_pinctrl_irq_mask(struct irq_data *d)
 static void sunxi_pinctrl_irq_unmask(struct irq_data *d)
 {
 	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
-	u32 reg = sunxi_irq_ctrl_reg(d->hwirq, pctl->desc->irq_bank_base);
+	u32 reg = sunxi_irq_ctrl_reg(d->hwirq, pctl->desc->irq_bank_map);
 	u8 idx = sunxi_irq_ctrl_offset(d->hwirq);
 	unsigned long flags;
 	u32 val;
@@ -1002,7 +1002,7 @@ static void sunxi_pinctrl_irq_handler(struct irq_desc *desc)
 	if (bank == pctl->desc->irq_banks)
 		return;
 
-	reg = sunxi_irq_status_reg_from_bank(bank, pctl->desc->irq_bank_base);
+	reg = sunxi_irq_status_reg_from_bank(bank, pctl->desc->irq_bank_map);
 	val = readl(pctl->membase + reg);
 
 	if (val) {
@@ -1235,7 +1235,7 @@ static int sunxi_pinctrl_setup_debounce(struct sunxi_pinctrl *pctl,
 		writel(src | div << 4,
 		       pctl->membase +
 		       sunxi_irq_debounce_reg_from_bank(i,
-							pctl->desc->irq_bank_base));
+							pctl->desc->irq_bank_map));
 	}
 
 	return 0;
@@ -1411,10 +1411,10 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	for (i = 0; i < pctl->desc->irq_banks; i++) {
 		/* Mask and clear all IRQs before registering a handler */
 		writel(0, pctl->membase + sunxi_irq_ctrl_reg_from_bank(i,
-						pctl->desc->irq_bank_base));
+						pctl->desc->irq_bank_map));
 		writel(0xffffffff,
 		       pctl->membase + sunxi_irq_status_reg_from_bank(i,
-						pctl->desc->irq_bank_base));
+						pctl->desc->irq_bank_map));
 
 		irq_set_chained_handler_and_data(pctl->irq[i],
 						 sunxi_pinctrl_irq_handler,
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 11b128f54ed2..fae732c8c548 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -110,7 +110,7 @@ struct sunxi_pinctrl_desc {
 	int				npins;
 	unsigned			pin_base;
 	unsigned			irq_banks;
-	unsigned			irq_bank_base;
+	const unsigned int		*irq_bank_map;
 	bool				irq_read_needs_mux;
 	bool				disable_strict_mode;
 };
@@ -263,12 +263,21 @@ static inline u32 sunxi_pull_offset(u16 pin)
 	return pin_num * PULL_PINS_BITS;
 }
 
-static inline u32 sunxi_irq_cfg_reg(u16 irq, unsigned bank_base)
+static inline u32 sunxi_irq_hw_bank_num(u8 bank, const unsigned int *bank_map)
+{
+	if (!bank_map)
+		return bank;
+	else
+		return bank_map[bank];
+}
+
+static inline u32 sunxi_irq_cfg_reg(u16 irq, const unsigned int *bank_map)
 {
 	u8 bank = irq / IRQ_PER_BANK;
 	u8 reg = (irq % IRQ_PER_BANK) / IRQ_CFG_IRQ_PER_REG * 0x04;
 
-	return IRQ_CFG_REG + (bank_base + bank) * IRQ_MEM_SIZE + reg;
+	return IRQ_CFG_REG +
+	       sunxi_irq_hw_bank_num(bank, bank_map) * IRQ_MEM_SIZE + reg;
 }
 
 static inline u32 sunxi_irq_cfg_offset(u16 irq)
@@ -277,16 +286,18 @@ static inline u32 sunxi_irq_cfg_offset(u16 irq)
 	return irq_num * IRQ_CFG_IRQ_BITS;
 }
 
-static inline u32 sunxi_irq_ctrl_reg_from_bank(u8 bank, unsigned bank_base)
+static inline u32 sunxi_irq_ctrl_reg_from_bank(u8 bank,
+					       const unsigned int *bank_map)
 {
-	return IRQ_CTRL_REG + (bank_base + bank) * IRQ_MEM_SIZE;
+	return IRQ_CTRL_REG +
+	       sunxi_irq_hw_bank_num(bank, bank_map) * IRQ_MEM_SIZE;
 }
 
-static inline u32 sunxi_irq_ctrl_reg(u16 irq, unsigned bank_base)
+static inline u32 sunxi_irq_ctrl_reg(u16 irq, const unsigned int *bank_map)
 {
 	u8 bank = irq / IRQ_PER_BANK;
 
-	return sunxi_irq_ctrl_reg_from_bank(bank, bank_base);
+	return sunxi_irq_ctrl_reg_from_bank(bank, bank_map);
 }
 
 static inline u32 sunxi_irq_ctrl_offset(u16 irq)
@@ -295,21 +306,25 @@ static inline u32 sunxi_irq_ctrl_offset(u16 irq)
 	return irq_num * IRQ_CTRL_IRQ_BITS;
 }
 
-static inline u32 sunxi_irq_debounce_reg_from_bank(u8 bank, unsigned bank_base)
+static inline u32 sunxi_irq_debounce_reg_from_bank(u8 bank,
+						   const unsigned int *bank_map)
 {
-	return IRQ_DEBOUNCE_REG + (bank_base + bank) * IRQ_MEM_SIZE;
+	return IRQ_DEBOUNCE_REG +
+	       sunxi_irq_hw_bank_num(bank, bank_map) * IRQ_MEM_SIZE;
 }
 
-static inline u32 sunxi_irq_status_reg_from_bank(u8 bank, unsigned bank_base)
+static inline u32 sunxi_irq_status_reg_from_bank(u8 bank,
+						 const unsigned int *bank_map)
 {
-	return IRQ_STATUS_REG + (bank_base + bank) * IRQ_MEM_SIZE;
+	return IRQ_STATUS_REG +
+	       sunxi_irq_hw_bank_num(bank, bank_map) * IRQ_MEM_SIZE;
 }
 
-static inline u32 sunxi_irq_status_reg(u16 irq, unsigned bank_base)
+static inline u32 sunxi_irq_status_reg(u16 irq, const unsigned int *bank_map)
 {
 	u8 bank = irq / IRQ_PER_BANK;
 
-	return sunxi_irq_status_reg_from_bank(bank, bank_base);
+	return sunxi_irq_status_reg_from_bank(bank, bank_map);
 }
 
 static inline u32 sunxi_irq_status_offset(u16 irq)
-- 
2.15.1
