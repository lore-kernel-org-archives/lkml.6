Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeFBQ4q (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 12:56:46 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38910 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeFBQ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 12:56:43 -0400
X-Google-Smtp-Source: ADUXVKKdpJozN/igKbC8iZAEfmfGO4+U5rrwiZPkwForkR2HoxJwIYDYzR4PZLRwrMTIzjFGuHcWCQ==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] pinctrl: actions: Add interrupt support for OWL S900 SoC
Date: Sat,  2 Jun 2018 22:24:15 +0530
Message-Id: <20180602165415.30956-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org>
References: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt support for Actions Semi OWL S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pinctrl/actions/Kconfig        |   1 +
 drivers/pinctrl/actions/pinctrl-owl.c  | 231 ++++++++++++++++++++++++-
 drivers/pinctrl/actions/pinctrl-owl.h  |  22 ++-
 drivers/pinctrl/actions/pinctrl-s900.c |  31 ++--
 4 files changed, 267 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/actions/Kconfig b/drivers/pinctrl/actions/Kconfig
index 490927b4ea76..2397cb0f6011 100644
--- a/drivers/pinctrl/actions/Kconfig
+++ b/drivers/pinctrl/actions/Kconfig
@@ -5,6 +5,7 @@ config PINCTRL_OWL
 	select PINCONF
 	select GENERIC_PINCONF
 	select GPIOLIB
+	select GPIOLIB_IRQCHIP
 	help
 	  Say Y here to enable Actions Semi OWL pinctrl driver
 
diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index 76243caa08c6..d40c61caeea3 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -45,6 +45,8 @@ struct owl_pinctrl {
 	struct clk *clk;
 	const struct owl_pinctrl_soc_data *soc;
 	void __iomem *base;
+	struct irq_domain *domain;
+	int *irq;
 };
 
 static void owl_update_bits(void __iomem *base, u32 mask, u32 val)
@@ -701,16 +703,193 @@ static int owl_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+static int owl_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct owl_pinctrl *pctrl = gpiochip_get_data(chip);
+
+	return irq_find_mapping(pctrl->domain, offset);
+}
+
+static void owl_gpio_irq_mask(struct irq_data *data)
+{
+	struct owl_pinctrl *pctrl = irq_data_get_irq_chip_data(data);
+	const struct owl_gpio_port *port;
+	void __iomem *gpio_base;
+	unsigned long flags;
+	unsigned int gpio = data->hwirq;
+	u32 val;
+
+	port = owl_gpio_get_port(pctrl, &gpio);
+	if (WARN_ON(port == NULL))
+		return;
+
+	gpio_base = pctrl->base + port->offset;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+
+	owl_gpio_update_reg(gpio_base + port->intc_msk, gpio, false);
+
+	/* disable port interrupt if no interrupt pending bit is active */
+	val = readl_relaxed(gpio_base + port->intc_msk);
+	if (val == 0)
+		owl_gpio_update_reg(gpio_base + port->intc_ctl,
+					OWL_GPIO_CTLR_ENABLE, false);
+
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+}
+
+static void owl_gpio_irq_unmask(struct irq_data *data)
+{
+	struct owl_pinctrl *pctrl = irq_data_get_irq_chip_data(data);
+	const struct owl_gpio_port *port;
+	void __iomem *gpio_base;
+	unsigned long flags;
+	unsigned int gpio = data->hwirq;
+	u32 value;
+
+	port = owl_gpio_get_port(pctrl, &gpio);
+	if (WARN_ON(port == NULL))
+		return;
+
+	gpio_base = pctrl->base + port->offset;
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+
+	/* enable port interrupt */
+	value = readl_relaxed(gpio_base + port->intc_ctl);
+	value |= BIT(OWL_GPIO_CTLR_ENABLE) | BIT(OWL_GPIO_CTLR_SAMPLE_CLK_24M);
+	writel_relaxed(value, gpio_base + port->intc_ctl);
+
+	/* enable GPIO interrupt */
+	owl_gpio_update_reg(gpio_base + port->intc_msk, gpio, true);
+
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+}
+
+static void owl_gpio_irq_ack(struct irq_data *data)
+{
+	struct owl_pinctrl *pctrl = irq_data_get_irq_chip_data(data);
+	const struct owl_gpio_port *port;
+	void __iomem *gpio_base;
+	unsigned long flags;
+	unsigned int gpio = data->hwirq;
+
+	port = owl_gpio_get_port(pctrl, &gpio);
+	if (WARN_ON(port == NULL))
+		return;
+
+	gpio_base = pctrl->base + port->offset;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+
+	owl_gpio_update_reg(gpio_base + port->intc_ctl,
+				OWL_GPIO_CTLR_PENDING, true);
+
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+}
+
+static int owl_gpio_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct owl_pinctrl *pctrl = irq_data_get_irq_chip_data(data);
+	const struct owl_gpio_port *port;
+	void __iomem *gpio_base;
+	unsigned long flags;
+	unsigned int gpio = data->hwirq;
+	unsigned int offset, value, irq_type = 0;
+
+	port = owl_gpio_get_port(pctrl, &gpio);
+	if (WARN_ON(port == NULL))
+		return -ENODEV;
+
+	gpio_base = pctrl->base + port->offset;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		irq_type = OWL_GPIO_INT_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_type = OWL_GPIO_INT_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_type = OWL_GPIO_INT_LEVEL_HIGH;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_type = OWL_GPIO_INT_LEVEL_LOW;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+
+	offset = gpio < 16 ? 4 : 0;
+	value = readl_relaxed(gpio_base + port->intc_type + offset);
+	value &= ~(OWL_GPIO_INT_MASK << ((gpio % 16) * 2));
+	value |= irq_type << ((gpio % 16) * 2);
+	writel_relaxed(value, gpio_base + port->intc_type + offset);
+
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		irq_set_handler_locked(data, handle_edge_irq);
+	else
+		irq_set_handler_locked(data, handle_level_irq);
+
+	return 0;
+}
+
+static void owl_gpio_irq_handler(struct irq_desc *desc)
+{
+	struct owl_pinctrl *pctrl = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	const struct owl_gpio_port *port;
+	void __iomem *base;
+	unsigned int pin, irq, offset = 0, i;
+	unsigned long pending_irq;
+
+	chained_irq_enter(chip, desc);
+
+	for (i = 0; i < pctrl->soc->nports; i++) {
+		port = &pctrl->soc->ports[i];
+		base = pctrl->base + port->offset;
+		pending_irq = readl_relaxed(base + port->intc_pd);
+
+		for_each_set_bit(pin, &pending_irq, port->pins) {
+			irq = irq_find_mapping(pctrl->domain, offset + pin);
+			generic_handle_irq(irq);
+
+			/* clear pending interrupt */
+			owl_gpio_update_reg(base + port->intc_pd, pin, true);
+		}
+
+		offset += port->pins;
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static struct irq_chip owl_gpio_irq_chip = {
+	.name           = "owlgpio",
+	.irq_mask       = owl_gpio_irq_mask,
+	.irq_unmask     = owl_gpio_irq_unmask,
+	.irq_ack        = owl_gpio_irq_ack,
+	.irq_set_type   = owl_gpio_irq_set_type,
+};
+
 static int owl_gpio_init(struct owl_pinctrl *pctrl)
 {
 	struct gpio_chip *chip;
-	int ret;
+	int irqno, ret, i;
 
 	chip = &pctrl->chip;
 	chip->base = -1;
 	chip->ngpio = pctrl->soc->ngpios;
 	chip->label = dev_name(pctrl->dev);
 	chip->parent = pctrl->dev;
+	chip->to_irq = owl_gpio_to_irq;
 	chip->owner = THIS_MODULE;
 	chip->of_node = pctrl->dev->of_node;
 
@@ -720,6 +899,29 @@ static int owl_gpio_init(struct owl_pinctrl *pctrl)
 		return ret;
 	}
 
+	pctrl->domain = irq_domain_add_linear(chip->of_node,
+					     chip->ngpio,
+					     &irq_domain_simple_ops,
+					     NULL);
+	if (!pctrl->domain) {
+		dev_err(pctrl->dev, "Couldn't register IRQ domain\n");
+		gpiochip_remove(&pctrl->chip);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < chip->ngpio; i++) {
+		irqno = irq_create_mapping(pctrl->domain, i);
+		irq_set_chip_and_handler(irqno, &owl_gpio_irq_chip,
+					 handle_edge_irq);
+		irq_set_chip_data(irqno, pctrl);
+	}
+
+	for (i = 0; i < pctrl->soc->nports; i++) {
+		irq_set_chained_handler_and_data(pctrl->irq[i],
+						owl_gpio_irq_handler,
+						pctrl);
+	}
+
 	return 0;
 }
 
@@ -728,7 +930,7 @@ int owl_pinctrl_probe(struct platform_device *pdev,
 {
 	struct resource *res;
 	struct owl_pinctrl *pctrl;
-	int ret;
+	int ret, i;
 
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
@@ -772,14 +974,35 @@ int owl_pinctrl_probe(struct platform_device *pdev,
 					&owl_pinctrl_desc, pctrl);
 	if (IS_ERR(pctrl->pctrldev)) {
 		dev_err(&pdev->dev, "could not register Actions OWL pinmux driver\n");
-		return PTR_ERR(pctrl->pctrldev);
+		ret = PTR_ERR(pctrl->pctrldev);
+		goto err_exit;
+	}
+
+	pctrl->irq = devm_kcalloc(&pdev->dev, pctrl->soc->nports,
+				  sizeof(*pctrl->irq), GFP_KERNEL);
+	if (!pctrl->irq) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	for (i = 0; i < pctrl->soc->nports ; i++) {
+		pctrl->irq[i] = platform_get_irq(pdev, i);
+		if (pctrl->irq[i] < 0) {
+			ret = pctrl->irq[i];
+			goto err_exit;
+		}
 	}
 
 	ret = owl_gpio_init(pctrl);
 	if (ret)
-		return ret;
+		goto err_exit;
 
 	platform_set_drvdata(pdev, pctrl);
 
 	return 0;
+
+err_exit:
+	clk_disable_unprepare(pctrl->clk);
+
+	return ret;
 }
diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
index 74342378937c..a724d1d406d4 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.h
+++ b/drivers/pinctrl/actions/pinctrl-owl.h
@@ -29,6 +29,18 @@ enum owl_pinconf_drv {
 	OWL_PINCONF_DRV_12MA,
 };
 
+/* GPIO CTRL Bit Definition */
+#define OWL_GPIO_CTLR_PENDING		0
+#define OWL_GPIO_CTLR_ENABLE		1
+#define OWL_GPIO_CTLR_SAMPLE_CLK_24M	2
+
+/* GPIO TYPE Bit Definition */
+#define OWL_GPIO_INT_LEVEL_HIGH		0
+#define OWL_GPIO_INT_LEVEL_LOW		1
+#define OWL_GPIO_INT_EDGE_RISING	2
+#define OWL_GPIO_INT_EDGE_FALLING	3
+#define OWL_GPIO_INT_MASK		3
+
 /**
  * struct owl_pullctl - Actions pad pull control register
  * @reg: offset to the pull control register
@@ -121,6 +133,10 @@ struct owl_pinmux_func {
  * @outen: offset of the output enable register.
  * @inen: offset of the input enable register.
  * @dat: offset of the data register.
+ * @intc_ctl: offset of the interrupt control register.
+ * @intc_pd: offset of the interrupt pending register.
+ * @intc_msk: offset of the interrupt mask register.
+ * @intc_type: offset of the interrupt type register.
  */
 struct owl_gpio_port {
 	unsigned int offset;
@@ -128,6 +144,10 @@ struct owl_gpio_port {
 	unsigned int outen;
 	unsigned int inen;
 	unsigned int dat;
+	unsigned int intc_ctl;
+	unsigned int intc_pd;
+	unsigned int intc_msk;
+	unsigned int intc_type;
 };
 
 /**
@@ -140,7 +160,7 @@ struct owl_gpio_port {
  * @ngroups: number of entries in @groups.
  * @padinfo: array describing the pad info of this SoC.
  * @ngpios: number of pingroups the driver should expose as GPIOs.
- * @port: array describing all GPIO ports of this SoC.
+ * @ports: array describing all GPIO ports of this SoC.
  * @nports: number of GPIO ports in this SoC.
  */
 struct owl_pinctrl_soc_data {
diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
index 5503c7945764..ea67b14ef93b 100644
--- a/drivers/pinctrl/actions/pinctrl-s900.c
+++ b/drivers/pinctrl/actions/pinctrl-s900.c
@@ -1821,22 +1821,27 @@ static struct owl_padinfo s900_padinfo[NUM_PADS] = {
 	[SGPIO3] = PAD_INFO_PULLCTL_ST(SGPIO3)
 };
 
-#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat)	\
-	[OWL_GPIO_PORT_##port] = {				\
-		.offset = base,					\
-		.pins = count,					\
-		.outen = _outen,				\
-		.inen = _inen,					\
-		.dat = _dat,					\
+#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat,		\
+			_intc_ctl, _intc_pd, _intc_msk, _intc_type)	\
+	[OWL_GPIO_PORT_##port] = {					\
+		.offset = base,						\
+		.pins = count,						\
+		.outen = _outen,					\
+		.inen = _inen,						\
+		.dat = _dat,						\
+		.intc_ctl = _intc_ctl,					\
+		.intc_pd = _intc_pd,					\
+		.intc_msk = _intc_msk,					\
+		.intc_type = _intc_type,				\
 	}
 
 static const struct owl_gpio_port s900_gpio_ports[] = {
-	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8),
-	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8),
-	OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8),
-	OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8),
-	OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8),
-	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8)
+	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8, 0x204, 0x208, 0x20C, 0x240),
+	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8, 0x534, 0x204, 0x208, 0x23C),
+	OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8, 0x52C, 0x200, 0x204, 0x238),
+	OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8, 0x524, 0x1FC, 0x200, 0x234),
+	OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8, 0x51C, 0x1F8, 0x1FC, 0x230),
+	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8, 0x460, 0x140, 0x144, 0x178)
 };
 
 static struct owl_pinctrl_soc_data s900_pinctrl_data = {
-- 
2.17.0
