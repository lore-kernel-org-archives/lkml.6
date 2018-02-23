Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeBWM1b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:27:31 -0500
Received: from hermes.aosc.io ([199.195.250.187]:51087 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeBWM13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:27:29 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3 2/7] pinctrl: sunxi: support pin controllers with holes among IRQ banks
Date: Fri, 23 Feb 2018 20:25:47 +0800
Message-Id: <20180223122552.58049-3-icenowy@aosc.io>
In-Reply-To: <20180223122552.58049-1-icenowy@aosc.io>
References: <20180223122552.58049-1-icenowy@aosc.io>
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
Changes in v3:
- change for the refactor in the new PATCH 1.

No changes in v2.

 drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c |  4 +++-
 drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c |  4 +++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h     | 29 +++++++++++++++++------------
 3 files changed, 23 insertions(+), 14 deletions(-)

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
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 909ca1504b61..36502cbef6c2 100644
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
@@ -263,14 +263,23 @@ static inline u32 sunxi_pull_offset(u16 pin)
 	return pin_num * PULL_PINS_BITS;
 }
 
+static inline u32 sunxi_irq_hw_bank_num(u8 bank,
+					const struct sunxi_pinctrl_desc *desc)
+{
+	if (!desc->irq_bank_map)
+		return bank;
+	else
+		return desc->irq_bank_map[bank];
+}
+
 static inline u32 sunxi_irq_cfg_reg(u16 irq,
 				    const struct sunxi_pinctrl_desc *desc)
 {
-	unsigned bank_base = desc->irq_bank_base;
 	u8 bank = irq / IRQ_PER_BANK;
 	u8 reg = (irq % IRQ_PER_BANK) / IRQ_CFG_IRQ_PER_REG * 0x04;
 
-	return IRQ_CFG_REG + (bank_base + bank) * IRQ_MEM_SIZE + reg;
+	return IRQ_CFG_REG +
+	       sunxi_irq_hw_bank_num(bank, desc) * IRQ_MEM_SIZE + reg;
 }
 
 static inline u32 sunxi_irq_cfg_offset(u16 irq)
@@ -282,9 +291,7 @@ static inline u32 sunxi_irq_cfg_offset(u16 irq)
 static inline u32 sunxi_irq_ctrl_reg_from_bank(u8 bank,
 					       const struct sunxi_pinctrl_desc *desc)
 {
-	unsigned bank_base = desc->irq_bank_base;
-
-	return IRQ_CTRL_REG + (bank_base + bank) * IRQ_MEM_SIZE;
+	return IRQ_CTRL_REG + sunxi_irq_hw_bank_num(bank, desc) * IRQ_MEM_SIZE;
 }
 
 static inline u32 sunxi_irq_ctrl_reg(u16 irq,
@@ -304,17 +311,15 @@ static inline u32 sunxi_irq_ctrl_offset(u16 irq)
 static inline u32 sunxi_irq_debounce_reg_from_bank(u8 bank,
 						   const struct sunxi_pinctrl_desc *desc)
 {
-	unsigned bank_base = desc->irq_bank_base;
-
-	return IRQ_DEBOUNCE_REG + (bank_base + bank) * IRQ_MEM_SIZE;
+	return IRQ_DEBOUNCE_REG +
+	       sunxi_irq_hw_bank_num(bank, desc) * IRQ_MEM_SIZE;
 }
 
 static inline u32 sunxi_irq_status_reg_from_bank(u8 bank,
 						 const struct sunxi_pinctrl_desc *desc)
 {
-	unsigned bank_base = desc->irq_bank_base;
-
-	return IRQ_STATUS_REG + (bank_base + bank) * IRQ_MEM_SIZE;
+	return IRQ_STATUS_REG +
+	       sunxi_irq_hw_bank_num(bank, desc) * IRQ_MEM_SIZE;
 }
 
 static inline u32 sunxi_irq_status_reg(u16 irq,
-- 
2.15.1
