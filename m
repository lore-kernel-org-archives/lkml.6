Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB0C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8461821907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="piiyiXtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfBHCRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:17:22 -0500
Received: from onstation.org ([52.200.56.107]:34968 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfBHCQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:16:54 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 107C9D83;
        Fri,  8 Feb 2019 02:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549592212;
        bh=BoCDcHIUugQrPop/XwredqNBgCkLtJVEywqzHkUp/sA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piiyiXtuBiQl+nMsNAF8OgO79fZ8YJETUzcO5qS4J8CWO5tCzu7Ad+y8PoAJO5HAg
         5cD7klK3jDGGA5BNe2WovvVKXkwqx9e1UnEnnjpZoAT9UDg8OTwm/+t4R5YMsX90gg
         YfQ3fPUP1pTGitinxebHoNV5v1YAxQsumEMDXMMU=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, lee.jones@linaro.org
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 06/11] qcom: ssbi-gpio: add support for hierarchical IRQ chip
Date:   Thu,  7 Feb 2019 21:16:26 -0500
Message-Id: <20190208021631.30252-7-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190208021631.30252-1-masneyb@onstation.org>
References: <20190208021631.30252-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ssbi-gpio did not have any irqchip support so consumers of this in
device tree would need to call gpio[d]_to_irq() in order to get the
proper IRQ on the underlying PMIC. IRQ chips in device tree should
be usable from the start without the consumer having to make an
additional call to get the proper IRQ on the parent. This patch adds
hierarchical IRQ chip support to the ssbi-gpio code to correct this
issue.

The constant PM8XXX_GPIO_PHYSICAL_OFFSET is introduced to replace the
hardcoded '1' that previously existed in two places in this driver to
improve code readability.

This change was tested on an APQ8060 DragonBoard.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes since v1:
- Change irq_ack / irq_mask with irq_mask_ack to match what is on the
  parent interrupt controller.
- Select IRQ_DOMAIN_HIERARCHY in Kconfig
- Hardcode the IRQ handler as handle_level_irq since this is what the
  parent expects. Linus: This is different than what you tested but this
  *should* be fine.

 drivers/pinctrl/qcom/Kconfig             |   1 +
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 135 +++++++++++++++++++++--
 2 files changed, 124 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 93efbffcd3a4..2e66ab72c10b 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -150,6 +150,7 @@ config PINCTRL_QCOM_SSBI_PMIC
        select PINMUX
        select PINCONF
        select GENERIC_PINCONF
+       select IRQ_DOMAIN_HIERARCHY
        help
          This is the pinctrl, pinmux, pinconf and gpiolib driver for the
          Qualcomm GPIO and MPP blocks found in the Qualcomm PMIC's chips,
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index 23641e4d4521..84a232450000 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -55,6 +55,8 @@
 
 #define PM8XXX_MAX_GPIOS               44
 
+#define PM8XXX_GPIO_PHYSICAL_OFFSET	1
+
 /* custom pinconf parameters */
 #define PM8XXX_QCOM_DRIVE_STRENGH      (PIN_CONFIG_END + 1)
 #define PM8XXX_QCOM_PULL_UP_STRENGTH   (PIN_CONFIG_END + 2)
@@ -99,6 +101,9 @@ struct pm8xxx_gpio {
 
 	struct pinctrl_desc desc;
 	unsigned npins;
+
+	struct fwnode_handle *fwnode;
+	struct irq_domain *domain;
 };
 
 static const struct pinconf_generic_params pm8xxx_gpio_bindings[] = {
@@ -499,11 +504,12 @@ static int pm8xxx_gpio_get(struct gpio_chip *chip, unsigned offset)
 
 	if (pin->mode == PM8XXX_GPIO_MODE_OUTPUT) {
 		ret = pin->output_value;
-	} else {
+	} else if (pin->irq >= 0) {
 		ret = irq_get_irqchip_state(pin->irq, IRQCHIP_STATE_LINE_LEVEL, &state);
 		if (!ret)
 			ret = !!state;
-	}
+	} else
+		ret = -EINVAL;
 
 	return ret;
 }
@@ -533,16 +539,39 @@ static int pm8xxx_gpio_of_xlate(struct gpio_chip *chip,
 	if (flags)
 		*flags = gpio_desc->args[1];
 
-	return gpio_desc->args[0] - 1;
+	return gpio_desc->args[0] - PM8XXX_GPIO_PHYSICAL_OFFSET;
 }
 
 
 static int pm8xxx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct pm8xxx_gpio *pctrl = gpiochip_get_data(chip);
+	struct pm8xxx_pin_data *pin = pctrl->desc.pins[offset].drv_data;
+	struct irq_fwspec fwspec;
+	int ret;
+
+	fwspec.fwnode = pctrl->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = offset + PM8XXX_GPIO_PHYSICAL_OFFSET;
+	fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
+
+	ret = irq_create_fwspec_mapping(&fwspec);
+
+	/*
+	 * Cache the IRQ since pm8xxx_gpio_get() needs this to get determine the
+	 * line level.
+	 */
+	pin->irq = ret;
+
+	return ret;
+}
+
+static void pm8xxx_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
 	struct pm8xxx_gpio *pctrl = gpiochip_get_data(chip);
 	struct pm8xxx_pin_data *pin = pctrl->desc.pins[offset].drv_data;
 
-	return pin->irq;
+	pin->irq = -1;
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -571,7 +600,7 @@ static void pm8xxx_gpio_dbg_show_one(struct seq_file *s,
 		"no", "high", "medium", "low"
 	};
 
-	seq_printf(s, " gpio%-2d:", offset + 1);
+	seq_printf(s, " gpio%-2d:", offset + PM8XXX_GPIO_PHYSICAL_OFFSET);
 	if (pin->disable) {
 		seq_puts(s, " ---");
 	} else {
@@ -603,6 +632,7 @@ static void pm8xxx_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 #endif
 
 static const struct gpio_chip pm8xxx_gpio_template = {
+	.free = pm8xxx_gpio_free,
 	.direction_input = pm8xxx_gpio_direction_input,
 	.direction_output = pm8xxx_gpio_direction_output,
 	.get = pm8xxx_gpio_get,
@@ -664,6 +694,68 @@ static int pm8xxx_pin_populate(struct pm8xxx_gpio *pctrl,
 	return 0;
 }
 
+static struct irq_chip pm8xxx_irq_chip = {
+	.name = "ssbi-gpio",
+	.irq_mask_ack = irq_chip_mask_ack_parent,
+	.irq_unmask = irq_chip_unmask_parent,
+	.irq_set_type = irq_chip_set_type_parent,
+	.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int pm8xxx_domain_translate(struct irq_domain *domain,
+				   struct irq_fwspec *fwspec,
+				   unsigned long *hwirq,
+				   unsigned int *type)
+{
+	struct pm8xxx_gpio *pctrl = container_of(domain->host_data,
+						 struct pm8xxx_gpio, chip);
+
+	if (fwspec->param_count != 2 || fwspec->param[0] >= pctrl->chip.ngpio)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0] - PM8XXX_GPIO_PHYSICAL_OFFSET;
+	*type = fwspec->param[1];
+
+	return 0;
+}
+
+static int pm8xxx_domain_alloc(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs, void *data)
+{
+	struct pm8xxx_gpio *pctrl = container_of(domain->host_data,
+						 struct pm8xxx_gpio, chip);
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret, i;
+
+	ret = pm8xxx_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &pm8xxx_irq_chip, pctrl, handle_level_irq,
+				    NULL, NULL);
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 2;
+	parent_fwspec.param[0] = hwirq + 0xc0;
+	parent_fwspec.param[1] = fwspec->param[1];
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static const struct irq_domain_ops pm8xxx_domain_ops = {
+	.activate = gpiochip_irq_domain_activate,
+	.alloc = pm8xxx_domain_alloc,
+	.deactivate = gpiochip_irq_domain_deactivate,
+	.free = irq_domain_free_irqs_common,
+	.translate = pm8xxx_domain_translate,
+};
+
 static const struct of_device_id pm8xxx_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8018-gpio", .data = (void *) 6 },
 	{ .compatible = "qcom,pm8038-gpio", .data = (void *) 12 },
@@ -677,6 +769,8 @@ MODULE_DEVICE_TABLE(of, pm8xxx_gpio_of_match);
 static int pm8xxx_gpio_probe(struct platform_device *pdev)
 {
 	struct pm8xxx_pin_data *pin_data;
+	struct irq_domain *parent_domain;
+	struct device_node *parent_node;
 	struct pinctrl_pin_desc *pins;
 	struct pm8xxx_gpio *pctrl;
 	int ret, i;
@@ -713,12 +807,7 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
 
 	for (i = 0; i < pctrl->desc.npins; i++) {
 		pin_data[i].reg = SSBI_REG_ADDR_GPIO(i);
-		pin_data[i].irq = platform_get_irq(pdev, i);
-		if (pin_data[i].irq < 0) {
-			dev_err(&pdev->dev,
-				"missing interrupts for pin %d\n", i);
-			return pin_data[i].irq;
-		}
+		pin_data[i].irq = -1;
 
 		ret = pm8xxx_pin_populate(pctrl, &pin_data[i]);
 		if (ret)
@@ -749,10 +838,29 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
 	pctrl->chip.of_gpio_n_cells = 2;
 	pctrl->chip.label = dev_name(pctrl->dev);
 	pctrl->chip.ngpio = pctrl->npins;
+
+	parent_node = of_irq_find_parent(pctrl->dev->of_node);
+	if (!parent_node)
+		return -ENXIO;
+
+	parent_domain = irq_find_host(parent_node);
+	of_node_put(parent_node);
+	if (!parent_domain)
+		return -ENXIO;
+
+	pctrl->fwnode = of_node_to_fwnode(pctrl->dev->of_node);
+	pctrl->domain = irq_domain_create_hierarchy(parent_domain, 0,
+						    pctrl->chip.ngpio,
+						    pctrl->fwnode,
+						    &pm8xxx_domain_ops,
+						    &pctrl->chip);
+	if (!pctrl->domain)
+		return -ENODEV;
+
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "failed register gpiochip\n");
-		return ret;
+		goto err_chip_add_data;
 	}
 
 	/*
@@ -782,6 +890,8 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
 
 unregister_gpiochip:
 	gpiochip_remove(&pctrl->chip);
+err_chip_add_data:
+	irq_domain_remove(pctrl->domain);
 
 	return ret;
 }
@@ -791,6 +901,7 @@ static int pm8xxx_gpio_remove(struct platform_device *pdev)
 	struct pm8xxx_gpio *pctrl = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&pctrl->chip);
+	irq_domain_remove(pctrl->domain);
 
 	return 0;
 }
-- 
2.17.2

