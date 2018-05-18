Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbeERCcs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:32:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43209 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbeERCcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:32:43 -0400
X-Google-Smtp-Source: AB8JxZoOuspZcCRDqmxrxlvQtkDTeDMCCqpBi10kbnbiOoSaXp9jN62lZJPg1/+Qi7hPk/pKKMBTeQ==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/5] pinctrl: actions: Add gpio support for Actions S900 SoC
Date: Fri, 18 May 2018 08:00:55 +0530
Message-Id: <20180518023056.7869-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
References: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio support to pinctrl driver for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pinctrl/actions/Kconfig        |   1 +
 drivers/pinctrl/actions/pinctrl-owl.c  | 206 +++++++++++++++++++++++++++++++++
 drivers/pinctrl/actions/pinctrl-owl.h  |  20 ++++
 drivers/pinctrl/actions/pinctrl-s900.c |  29 ++++-
 4 files changed, 255 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/actions/Kconfig b/drivers/pinctrl/actions/Kconfig
index ede97cdbbc12..490927b4ea76 100644
--- a/drivers/pinctrl/actions/Kconfig
+++ b/drivers/pinctrl/actions/Kconfig
@@ -4,6 +4,7 @@ config PINCTRL_OWL
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
+	select GPIOLIB
 	help
 	  Say Y here to enable Actions Semi OWL pinctrl driver
 
diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index ee090697b1e9..4942e34c8b76 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -11,6 +11,7 @@
 
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -31,6 +32,7 @@
  * struct owl_pinctrl - pinctrl state of the device
  * @dev: device handle
  * @pctrldev: pinctrl handle
+ * @chip: gpio chip
  * @lock: spinlock to protect registers
  * @soc: reference to soc_data
  * @base: pinctrl register base address
@@ -38,6 +40,7 @@
 struct owl_pinctrl {
 	struct device *dev;
 	struct pinctrl_dev *pctrldev;
+	struct gpio_chip chip;
 	raw_spinlock_t lock;
 	struct clk *clk;
 	const struct owl_pinctrl_soc_data *soc;
@@ -536,6 +539,198 @@ static struct pinctrl_desc owl_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
+static const struct owl_gpio_port *
+owl_gpio_get_port(struct owl_pinctrl *pctrl, unsigned int *pin)
+{
+	unsigned int start = 0, i;
+
+	for (i = 0; i < pctrl->soc->nports; i++) {
+		const struct owl_gpio_port *port = &pctrl->soc->ports[i];
+
+		if (*pin >= start && *pin < start + port->pins) {
+			*pin -= start;
+			return port;
+		}
+
+		start += port->pins;
+	}
+
+	return NULL;
+}
+
+static void owl_gpio_update_reg(void __iomem *base, unsigned int pin, int flag)
+{
+	u32 val;
+
+	val = readl_relaxed(base);
+
+	if (flag)
+		val |= BIT(pin);
+	else
+		val &= ~BIT(pin);
+
+	writel_relaxed(val, base);
+}
+
+static int owl_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct owl_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port;
+	void __iomem *gpio_base;
+	unsigned long flags;
+
+	port = owl_gpio_get_port(pctrl, &offset);
+	if (WARN_ON(port == NULL))
+		return -ENODEV;
+
+	gpio_base = pctrl->base + port->offset;
+
+	/*
+	 * GPIOs have higher priority over other modules, so either setting
+	 * them as OUT or IN is sufficient
+	 */
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	owl_gpio_update_reg(gpio_base + port->outen, offset, true);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return 0;
+}
+
+static void owl_gpio_free(struct gpio_chip *chip, unsigned int offset)
+{
+	struct owl_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port;
+	void __iomem *gpio_base;
+	unsigned long flags;
+
+	port = owl_gpio_get_port(pctrl, &offset);
+	if (WARN_ON(port == NULL))
+		return;
+
+	gpio_base = pctrl->base + port->offset;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	/* disable gpio output */
+	owl_gpio_update_reg(gpio_base + port->outen, offset, false);
+
+	/* disable gpio input */
+	owl_gpio_update_reg(gpio_base + port->inen, offset, false);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+}
+
+static int owl_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct owl_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port;
+	void __iomem *gpio_base;
+	unsigned long flags;
+	u32 val;
+
+	port = owl_gpio_get_port(pctrl, &offset);
+	if (WARN_ON(port == NULL))
+		return -ENODEV;
+
+	gpio_base = pctrl->base + port->offset;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	val = readl_relaxed(gpio_base + port->dat);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return !!(val & BIT(offset));
+}
+
+static void owl_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct owl_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port;
+	void __iomem *gpio_base;
+	unsigned long flags;
+
+	port = owl_gpio_get_port(pctrl, &offset);
+	if (WARN_ON(port == NULL))
+		return;
+
+	gpio_base = pctrl->base + port->offset;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	owl_gpio_update_reg(gpio_base + port->dat, offset, value);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+}
+
+static int owl_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct owl_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port;
+	void __iomem *gpio_base;
+	unsigned long flags;
+
+	port = owl_gpio_get_port(pctrl, &offset);
+	if (WARN_ON(port == NULL))
+		return -ENODEV;
+
+	gpio_base = pctrl->base + port->offset;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	owl_gpio_update_reg(gpio_base + port->outen, offset, false);
+	owl_gpio_update_reg(gpio_base + port->inen, offset, true);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return 0;
+}
+
+static int owl_gpio_direction_output(struct gpio_chip *chip,
+				unsigned int offset, int value)
+{
+	struct owl_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct owl_gpio_port *port;
+	void __iomem *gpio_base;
+	unsigned long flags;
+
+	port = owl_gpio_get_port(pctrl, &offset);
+	if (WARN_ON(port == NULL))
+		return -ENODEV;
+
+	gpio_base = pctrl->base + port->offset;
+
+	raw_spin_lock_irqsave(&pctrl->lock, flags);
+	owl_gpio_update_reg(gpio_base + port->inen, offset, false);
+	owl_gpio_update_reg(gpio_base + port->outen, offset, true);
+	owl_gpio_update_reg(gpio_base + port->dat, offset, value);
+	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return 0;
+}
+
+static int owl_gpio_init(struct owl_pinctrl *pctrl)
+{
+	struct gpio_chip *chip;
+	int ret;
+
+	chip = &pctrl->chip;
+	chip->base = -1;
+	chip->ngpio = pctrl->soc->ngpios;
+	chip->label = dev_name(pctrl->dev);
+	chip->parent = pctrl->dev;
+	chip->owner = THIS_MODULE;
+	chip->of_node = pctrl->dev->of_node;
+
+	ret = gpiochip_add_data(&pctrl->chip, pctrl);
+	if (ret) {
+		dev_err(pctrl->dev, "failed to register gpiochip\n");
+		return ret;
+	}
+
+	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev),
+							0, 0, chip->ngpio);
+	if (ret) {
+		dev_err(pctrl->dev, "failed to add pin range\n");
+		gpiochip_remove(&pctrl->chip);
+		return ret;
+	}
+
+	return 0;
+}
+
 int owl_pinctrl_probe(struct platform_device *pdev,
 				struct owl_pinctrl_soc_data *soc_data)
 {
@@ -571,6 +766,13 @@ int owl_pinctrl_probe(struct platform_device *pdev,
 	owl_pinctrl_desc.pins = soc_data->pins;
 	owl_pinctrl_desc.npins = soc_data->npins;
 
+	pctrl->chip.direction_input  = owl_gpio_direction_input;
+	pctrl->chip.direction_output = owl_gpio_direction_output;
+	pctrl->chip.get = owl_gpio_get;
+	pctrl->chip.set = owl_gpio_set;
+	pctrl->chip.request = owl_gpio_request;
+	pctrl->chip.free = owl_gpio_free;
+
 	pctrl->soc = soc_data;
 	pctrl->dev = &pdev->dev;
 
@@ -581,6 +783,10 @@ int owl_pinctrl_probe(struct platform_device *pdev,
 		return PTR_ERR(pctrl->pctrldev);
 	}
 
+	ret = owl_gpio_init(pctrl);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, pctrl);
 
 	return 0;
diff --git a/drivers/pinctrl/actions/pinctrl-owl.h b/drivers/pinctrl/actions/pinctrl-owl.h
index 448f81a6db3b..74342378937c 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.h
+++ b/drivers/pinctrl/actions/pinctrl-owl.h
@@ -114,6 +114,22 @@ struct owl_pinmux_func {
 	unsigned int ngroups;
 };
 
+/**
+ * struct owl_gpio_port - Actions GPIO port info
+ * @offset: offset of the GPIO port.
+ * @pins: number of pins belongs to the GPIO port.
+ * @outen: offset of the output enable register.
+ * @inen: offset of the input enable register.
+ * @dat: offset of the data register.
+ */
+struct owl_gpio_port {
+	unsigned int offset;
+	unsigned int pins;
+	unsigned int outen;
+	unsigned int inen;
+	unsigned int dat;
+};
+
 /**
  * struct owl_pinctrl_soc_data - Actions pin controller driver configuration
  * @pins: array describing all pins of the pin controller.
@@ -124,6 +140,8 @@ struct owl_pinmux_func {
  * @ngroups: number of entries in @groups.
  * @padinfo: array describing the pad info of this SoC.
  * @ngpios: number of pingroups the driver should expose as GPIOs.
+ * @port: array describing all GPIO ports of this SoC.
+ * @nports: number of GPIO ports in this SoC.
  */
 struct owl_pinctrl_soc_data {
 	const struct pinctrl_pin_desc *pins;
@@ -134,6 +152,8 @@ struct owl_pinctrl_soc_data {
 	unsigned int ngroups;
 	const struct owl_padinfo *padinfo;
 	unsigned int ngpios;
+	const struct owl_gpio_port *ports;
+	unsigned int nports;
 };
 
 int owl_pinctrl_probe(struct platform_device *pdev,
diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
index 08d93f8fc086..5503c7945764 100644
--- a/drivers/pinctrl/actions/pinctrl-s900.c
+++ b/drivers/pinctrl/actions/pinctrl-s900.c
@@ -33,6 +33,13 @@
 #define PAD_SR1			(0x0274)
 #define PAD_SR2			(0x0278)
 
+#define OWL_GPIO_PORT_A		0
+#define OWL_GPIO_PORT_B		1
+#define OWL_GPIO_PORT_C		2
+#define OWL_GPIO_PORT_D		3
+#define OWL_GPIO_PORT_E		4
+#define OWL_GPIO_PORT_F		5
+
 #define _GPIOA(offset)		(offset)
 #define _GPIOB(offset)		(32 + (offset))
 #define _GPIOC(offset)		(64 + (offset))
@@ -1814,6 +1821,24 @@ static struct owl_padinfo s900_padinfo[NUM_PADS] = {
 	[SGPIO3] = PAD_INFO_PULLCTL_ST(SGPIO3)
 };
 
+#define OWL_GPIO_PORT(port, base, count, _outen, _inen, _dat)	\
+	[OWL_GPIO_PORT_##port] = {				\
+		.offset = base,					\
+		.pins = count,					\
+		.outen = _outen,				\
+		.inen = _inen,					\
+		.dat = _dat,					\
+	}
+
+static const struct owl_gpio_port s900_gpio_ports[] = {
+	OWL_GPIO_PORT(A, 0x0000, 32, 0x0, 0x4, 0x8),
+	OWL_GPIO_PORT(B, 0x000C, 32, 0x0, 0x4, 0x8),
+	OWL_GPIO_PORT(C, 0x0018, 12, 0x0, 0x4, 0x8),
+	OWL_GPIO_PORT(D, 0x0024, 30, 0x0, 0x4, 0x8),
+	OWL_GPIO_PORT(E, 0x0030, 32, 0x0, 0x4, 0x8),
+	OWL_GPIO_PORT(F, 0x00F0, 8, 0x0, 0x4, 0x8)
+};
+
 static struct owl_pinctrl_soc_data s900_pinctrl_data = {
 	.padinfo = s900_padinfo,
 	.pins = (const struct pinctrl_pin_desc *)s900_pads,
@@ -1822,7 +1847,9 @@ static struct owl_pinctrl_soc_data s900_pinctrl_data = {
 	.nfunctions = ARRAY_SIZE(s900_functions),
 	.groups = s900_groups,
 	.ngroups = ARRAY_SIZE(s900_groups),
-	.ngpios = NUM_GPIOS
+	.ngpios = NUM_GPIOS,
+	.ports = s900_gpio_ports,
+	.nports = ARRAY_SIZE(s900_gpio_ports)
 };
 
 static int s900_pinctrl_probe(struct platform_device *pdev)
-- 
2.14.1
