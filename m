Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B0DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D7320657
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="AFbU79q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfAMPsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 10:48:33 -0500
Received: from onstation.org ([52.200.56.107]:42726 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfAMPrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 10:47:45 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id BFC1A7EA;
        Sun, 13 Jan 2019 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547394464;
        bh=JSNhxglr6wT0DmWUTWxge7riMdgGy1fpqgSBQu7yCrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFbU79q03ghqp8aZUtSOXW4qmgYLTaagO6Xkysqp1ZM4g+u9iYhzLBK8oOkHK1f4O
         eCDFIQ57kbKH7pXqvJXoojaAdiho3WQ3CQeRyJK714f2MsvE4/6lWmIjBuAoFV9XlC
         R2EgIPl3YL73IVeK5pj8qrJHJau+hTLvdzhmyGQE=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 07/14] qcom: spmi-gpio: add support for hierarchical IRQ chip
Date:   Sun, 13 Jan 2019 10:47:09 -0500
Message-Id: <20190113154716.5145-8-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190113154716.5145-1-masneyb@onstation.org>
References: <20190113154716.5145-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spmi-gpio did not have any irqchip support so consumers of this in
device tree would need to call gpio[d]_to_irq() in order to get the
proper IRQ on the underlying PMIC. IRQ chips in device tree should
be usable from the start without the consumer having to make an
additional call to get the proper IRQ on the parent. This patch adds
hierarchical IRQ chip support to the spmi-gpio code to correct this
issue.

Driver was tested using the volume buttons (via gpio-keys) on the LG
Nexus 5 (hammerhead) phone with the following two configurations.

volume-up {
        interrupts-extended = <&pm8941_gpios 2 IRQ_TYPE_EDGE_BOTH>;
        ...
};

volume-up {
        gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
        ...
};

Both configurations now show that spmi-gpio is the IRQ domain and that
the IRQ is setup in a hierarchy.

$ grep volume_up /proc/interrupts
 72:          6          0  spmi-gpio   1 Edge      volume_up

$ cat /sys/kernel/debug/irq/irqs/72
handler:  handle_edge_irq
device:   (null)
status:   0x00000403
            _IRQ_NOPROBE
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x02400203
            IRQ_TYPE_EDGE_RISING
            IRQ_TYPE_EDGE_FALLING
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
node:     0
affinity: 0-3
effectiv:
domain:  :soc:spmi@fc4cf000:pm8941@0:gpios@c000
 hwirq:   0x1
 chip:    spmi-gpio
  flags:   0x4
             IRQCHIP_MASK_ON_SUSPEND
 parent:
    domain:  :soc:spmi@fc4cf000
     hwirq:   0xc100057
     chip:    pmic_arb
      flags:   0x4
                 IRQCHIP_MASK_ON_SUSPEND

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
Changes since v3:
- None

Changes since v2:
- Use PMIC_GPIO_PHYSICAL_OFFSET instead of the 1 constant
- Use gpiochip_irq_domain_{activate,deactivate}
- Changed 'fwspec->param[0] + 0xc0 - 1' to 'hwirq + c0' in call to
  irq_domain_alloc_irqs_parent

Changes since v1:
- Use two cells for interrupts instead of four.
- Pin numbers in interrupts-extended are now one based instead of zero
  based so that they match the GPIO pin number.
- Drop unnecessary parenthesis in pmic_gpio_domain_translate
- Add missing of_node_put()
- Remove irq field from pmic_gpio_pad struct that is no longer
  necessary.

 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 111 +++++++++++++++++++++--
 1 file changed, 101 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index b74c44357e8a..f7f677a2082e 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -136,7 +137,6 @@ enum pmic_gpio_func_index {
 /**
  * struct pmic_gpio_pad - keep current GPIO settings
  * @base: Address base in SPMI device.
- * @irq: IRQ number which this GPIO generate.
  * @is_enabled: Set to false when GPIO should be put in high Z state.
  * @out_value: Cached pin output value
  * @have_buffer: Set to true if GPIO output could be configured in push-pull,
@@ -156,7 +156,6 @@ enum pmic_gpio_func_index {
  */
 struct pmic_gpio_pad {
 	u16		base;
-	int		irq;
 	bool		is_enabled;
 	bool		out_value;
 	bool		have_buffer;
@@ -179,6 +178,8 @@ struct pmic_gpio_state {
 	struct regmap	*map;
 	struct pinctrl_dev *ctrl;
 	struct gpio_chip chip;
+	struct fwnode_handle *fwnode;
+	struct irq_domain *domain;
 };
 
 static const struct pinconf_generic_params pmic_gpio_bindings[] = {
@@ -761,11 +762,14 @@ static int pmic_gpio_of_xlate(struct gpio_chip *chip,
 static int pmic_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
 {
 	struct pmic_gpio_state *state = gpiochip_get_data(chip);
-	struct pmic_gpio_pad *pad;
+	struct irq_fwspec fwspec;
 
-	pad = state->ctrl->desc->pins[pin].drv_data;
+	fwspec.fwnode = state->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = pin + PMIC_GPIO_PHYSICAL_OFFSET;
+	fwspec.param[1] = IRQ_TYPE_NONE;
 
-	return pad->irq;
+	return irq_create_fwspec_mapping(&fwspec);
 }
 
 static void pmic_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
@@ -935,8 +939,78 @@ static int pmic_gpio_populate(struct pmic_gpio_state *state,
 	return 0;
 }
 
+static struct irq_chip pmic_gpio_irq_chip = {
+	.name = "spmi-gpio",
+	.irq_ack = irq_chip_ack_parent,
+	.irq_mask = irq_chip_mask_parent,
+	.irq_unmask = irq_chip_unmask_parent,
+	.irq_set_type = irq_chip_set_type_parent,
+	.irq_set_wake = irq_chip_set_wake_parent,
+	.flags = IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int pmic_gpio_domain_translate(struct irq_domain *domain,
+				      struct irq_fwspec *fwspec,
+				      unsigned long *hwirq,
+				      unsigned int *type)
+{
+	struct pmic_gpio_state *state = container_of(domain->host_data,
+						     struct pmic_gpio_state,
+						     chip);
+
+	if (fwspec->param_count != 2 || fwspec->param[0] >= state->chip.ngpio)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0] - PMIC_GPIO_PHYSICAL_OFFSET;
+	*type = fwspec->param[1];
+
+	return 0;
+}
+
+static int pmic_gpio_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *data)
+{
+	struct pmic_gpio_state *state = container_of(domain->host_data,
+						     struct pmic_gpio_state,
+						     chip);
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret, i;
+
+	ret = pmic_gpio_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &pmic_gpio_irq_chip, state,
+				    handle_level_irq, NULL, NULL);
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 4;
+	parent_fwspec.param[0] = 0;
+	parent_fwspec.param[1] = hwirq + 0xc0;
+	parent_fwspec.param[2] = 0;
+	parent_fwspec.param[3] = fwspec->param[1];
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static const struct irq_domain_ops pmic_gpio_domain_ops = {
+	.activate = gpiochip_irq_domain_activate,
+	.alloc = pmic_gpio_domain_alloc,
+	.deactivate = gpiochip_irq_domain_deactivate,
+	.free = irq_domain_free_irqs_common,
+	.translate = pmic_gpio_domain_translate,
+};
+
 static int pmic_gpio_probe(struct platform_device *pdev)
 {
+	struct irq_domain *parent_domain;
+	struct device_node *parent_node;
 	struct device *dev = &pdev->dev;
 	struct pinctrl_pin_desc *pindesc;
 	struct pinctrl_desc *pctrldesc;
@@ -993,10 +1067,6 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 		pindesc->number = i;
 		pindesc->name = pmic_gpio_groups[i];
 
-		pad->irq = platform_get_irq(pdev, i);
-		if (pad->irq < 0)
-			return pad->irq;
-
 		pad->base = reg + i * PMIC_GPIO_ADDRESS_RANGE;
 
 		ret = pmic_gpio_populate(state, pad);
@@ -1016,10 +1086,28 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(state->ctrl))
 		return PTR_ERR(state->ctrl);
 
+	parent_node = of_irq_find_parent(state->dev->of_node);
+	if (!parent_node)
+		return -ENXIO;
+
+	parent_domain = irq_find_host(parent_node);
+	of_node_put(parent_node);
+	if (!parent_domain)
+		return -ENXIO;
+
+	state->fwnode = of_node_to_fwnode(state->dev->of_node);
+	state->domain = irq_domain_create_hierarchy(parent_domain, 0,
+						    state->chip.ngpio,
+						    state->fwnode,
+						    &pmic_gpio_domain_ops,
+						    &state->chip);
+	if (!state->domain)
+		return -ENODEV;
+
 	ret = gpiochip_add_data(&state->chip, state);
 	if (ret) {
 		dev_err(state->dev, "can't add gpio chip\n");
-		return ret;
+		goto err_chip_add_data;
 	}
 
 	/*
@@ -1045,6 +1133,8 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 
 err_range:
 	gpiochip_remove(&state->chip);
+err_chip_add_data:
+	irq_domain_remove(state->domain);
 	return ret;
 }
 
@@ -1053,6 +1143,7 @@ static int pmic_gpio_remove(struct platform_device *pdev)
 	struct pmic_gpio_state *state = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&state->chip);
+	irq_domain_remove(state->domain);
 	return 0;
 }
 
-- 
2.17.2

