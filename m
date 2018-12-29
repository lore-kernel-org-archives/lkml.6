Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86518C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7AD217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="EDIpo6mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeL2LsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 06:48:06 -0500
Received: from onstation.org ([52.200.56.107]:46196 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbeL2LsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 06:48:05 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id DEE7519A;
        Sat, 29 Dec 2018 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546084084;
        bh=hBla6dKC07b/E4ySBq3NHkoVUQf2A6Ny0h8Sw7VrNoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDIpo6mEKzQxkgoGLIVwWTOPaxbChY0PaWWWN8CrCqx2tLpFfgW5upjqGK8KmmXCk
         kdumKa/U1JDQSroEbEbUhkf7YGAsHTNa4vULlRg/PEwRcp749mglgK6YjzErz+3Q2U
         NdcbK+LFXa7OcNqmogVlpiZ/BkQ00llSVyXWHIaA=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/3] qcom: spmi-gpio: add support for hierarchical IRQ chip
Date:   Sat, 29 Dec 2018 06:47:54 -0500
Message-Id: <20181229114755.8711-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181229114755.8711-1-masneyb@onstation.org>
References: <20181229114755.8711-1-masneyb@onstation.org>
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
	interrupts-extended = <&pm8941_gpios 0 1 0 IRQ_TYPE_EDGE_BOTH>;
	...
};

volume-up {
	gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
	...
};

Both configurations now show that spmi-gpio is the IRQ domain and that
the IRQ is setup in a hierarchy.

$ grep volume_up /proc/interrupts
110:          0          0  spmi-gpio   1 Edge      volume_up

$ cat /sys/kernel/debug/irq/irqs/110
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
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 119 ++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 4458d44dfcf6..0b46e24d0f8a 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -179,6 +180,8 @@ struct pmic_gpio_state {
 	struct regmap	*map;
 	struct pinctrl_dev *ctrl;
 	struct gpio_chip chip;
+	struct fwnode_handle *fwnode;
+	struct irq_domain *domain;
 };
 
 static const struct pinconf_generic_params pmic_gpio_bindings[] = {
@@ -761,11 +764,16 @@ static int pmic_gpio_of_xlate(struct gpio_chip *chip,
 static int pmic_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
 {
 	struct pmic_gpio_state *state = gpiochip_get_data(chip);
-	struct pmic_gpio_pad *pad;
+	struct irq_fwspec fwspec;
 
-	pad = state->ctrl->desc->pins[pin].drv_data;
+	fwspec.fwnode = state->fwnode;
+	fwspec.param_count = 4;
+	fwspec.param[0] = 0;
+	fwspec.param[1] = pin;
+	fwspec.param[2] = 0;
+	fwspec.param[3] = IRQ_TYPE_NONE;
 
-	return pad->irq;
+	return irq_create_fwspec_mapping(&fwspec);
 }
 
 static void pmic_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
@@ -935,8 +943,91 @@ static int pmic_gpio_populate(struct pmic_gpio_state *state,
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
+static int pmic_gpio_irq_activate(struct irq_domain *domain,
+				  struct irq_data *data, bool reserve)
+{
+	struct pmic_gpio_state *state = domain->host_data;
+
+	return gpiochip_lock_as_irq(&state->chip, data->hwirq);
+}
+
+static void pmic_gpio_irq_deactivate(struct irq_domain *domain,
+				     struct irq_data *data)
+{
+	struct pmic_gpio_state *state = domain->host_data;
+
+	gpiochip_unlock_as_irq(&state->chip, data->hwirq);
+}
+
+static int pmic_gpio_domain_translate(struct irq_domain *domain,
+				      struct irq_fwspec *fwspec,
+				      unsigned long *hwirq,
+				      unsigned int *type)
+{
+	struct pmic_gpio_state *state = domain->host_data;
+
+	if ((fwspec->param_count != 4) ||
+	    (fwspec->param[1] >= state->chip.ngpio))
+		return -EINVAL;
+
+	*hwirq = fwspec->param[1];
+	*type = fwspec->param[3];
+
+	return 0;
+}
+
+static int pmic_gpio_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *data)
+{
+	struct pmic_gpio_state *state = domain->host_data;
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
+	parent_fwspec.param[0] = fwspec->param[0];
+	parent_fwspec.param[1] = fwspec->param[1] + 0xc0;
+	parent_fwspec.param[2] = fwspec->param[2];
+	parent_fwspec.param[3] = fwspec->param[3];
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static const struct irq_domain_ops pmic_gpio_domain_ops = {
+	.activate = pmic_gpio_irq_activate,
+	.alloc = pmic_gpio_domain_alloc,
+	.deactivate = pmic_gpio_irq_deactivate,
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
@@ -1022,10 +1113,27 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(state->ctrl))
 		return PTR_ERR(state->ctrl);
 
+	parent_node = of_irq_find_parent(state->dev->of_node);
+	if (!parent_node)
+		return -ENXIO;
+
+	parent_domain = irq_find_host(parent_node);
+	if (!parent_domain)
+		return -ENXIO;
+
+	state->fwnode = of_node_to_fwnode(state->dev->of_node);
+	state->domain = irq_domain_create_hierarchy(parent_domain, 0,
+						    state->chip.ngpio,
+						    state->fwnode,
+						    &pmic_gpio_domain_ops,
+						    state);
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
@@ -1051,6 +1159,8 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 
 err_range:
 	gpiochip_remove(&state->chip);
+err_chip_add_data:
+	irq_domain_remove(state->domain);
 	return ret;
 }
 
@@ -1059,6 +1169,7 @@ static int pmic_gpio_remove(struct platform_device *pdev)
 	struct pmic_gpio_state *state = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&state->chip);
+	irq_domain_remove(state->domain);
 	return 0;
 }
 
-- 
2.17.2

