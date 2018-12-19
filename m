Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4DBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9614E20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N+h1z8vd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E5ObJLXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeLSWLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:11:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45024 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbeLSWLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:11:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 82BF460986; Wed, 19 Dec 2018 22:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257496;
        bh=0tPVXmy4dPah913YpK0HJvCL8//hC8OT6YzVMKweJ30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+h1z8vdVAK9Z0GWt1V3z++uUHe1S8f/eZyzzAVyYzTrHVKkUGBjEB0VDxsA7dL64
         jJ6GY5rRl2Dm6Vh2n/py+8wukG26+whKzV91kW/aFzPC7IaiT0pMjxBflIGyjkCOp7
         ktUA2O5CPNx1iJwVgdjyN/5S6vkRCwcUKLKlPsgQ=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C410960907;
        Wed, 19 Dec 2018 22:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545257493;
        bh=0tPVXmy4dPah913YpK0HJvCL8//hC8OT6YzVMKweJ30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5ObJLXpLTOmLW0nByFa7alo7ZGVy/SrQn4Di4eIADm18bqFL0WgnvHtN1i4kcPSw
         K9a63sEUxtRTDqOXJ0S3k9MP57roJpB2u2ukBHQQrKzIMOzNZV137GVeOLFjVxEtuh
         nIhKUvwyahIQ/VsfqUFcPDxUPVR+uhFRhf0LW1oA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C410960907
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 5/7] drivers: pinctrl: msm: setup GPIO irqchip hierarchy
Date:   Wed, 19 Dec 2018 15:11:03 -0700
Message-Id: <20181219221105.3004-6-ilina@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181219221105.3004-1-ilina@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow GPIOs to wakeup the system from suspend or deep idle, the
wakeup capable GPIOs are setup in hierarchy with interrupts from the
wakeup-parent irqchip.

In older SoC's, the TLMM will handover detection to the parent irqchip
and in newer SoC's, the parent irqchip may also be active as well as the
TLMM and therefore the GPIOs need to be masked at TLMM to avoid
duplicate interrupts. To enable both these configurations to exist,
allow the parent irqchip to dictate the TLMM irqchip's behavior when
masking/unmasking the interrupt.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 136 ++++++++++++++++++++++++++---
 1 file changed, 123 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 7c7d083e2c0d..c86117c981e3 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -27,6 +28,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/soc/qcom/irq.h>
 #include <linux/reboot.h>
 #include <linux/pm.h>
 #include <linux/log2.h>
@@ -69,6 +71,7 @@ struct msm_pinctrl {
 
 	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
 	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
+	DECLARE_BITMAP(wakeup_masked_irqs, MAX_NR_GPIO);
 
 	const struct msm_pinctrl_soc_data *soc;
 	void __iomem *regs[MAX_NR_TILES];
@@ -703,6 +706,13 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
+	if (d->parent_data)
+		irq_chip_unmask_parent(d);
+
+	/* Monitored by parent wakeup controller? Keep masked */
+	if (test_bit(d->hwirq, pctrl->wakeup_masked_irqs))
+		return;
+
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	val = msm_readl_intr_cfg(pctrl, g);
@@ -735,6 +745,9 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 	clear_bit(d->hwirq, pctrl->enabled_irqs);
 
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	if (d->parent_data)
+		irq_chip_mask_parent(d);
 }
 
 static void msm_gpio_irq_unmask(struct irq_data *d)
@@ -767,6 +780,10 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	unsigned long flags;
 	u32 val;
 
+	/* Handled by parent wakeup controller? Do nothing */
+	if (test_bit(d->hwirq, pctrl->wakeup_masked_irqs))
+		return;
+
 	g = &pctrl->soc->groups[d->hwirq];
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
@@ -794,6 +811,13 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 
 	g = &pctrl->soc->groups[d->hwirq];
 
+	if (d->parent_data)
+		irq_chip_set_type_parent(d, type);
+
+	/* Monitored by parent wakeup controller? Keep masked */
+	if (test_bit(d->hwirq, pctrl->wakeup_masked_irqs))
+		return 0;
+
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	/*
@@ -890,6 +914,9 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
+	if (d->parent_data)
+		irq_chip_set_wake_parent(d, on);
+
 	return 0;
 }
 
@@ -967,11 +994,86 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
 	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
 }
 
+static int msm_gpio_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq, unsigned int *type)
+{
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count < 2)
+			return -EINVAL;
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int msm_gpio_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *arg)
+{
+	int ret;
+	irq_hw_number_t hwirq;
+	struct gpio_chip *gc = domain->host_data;
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	struct irq_fwspec *fwspec = arg;
+	struct qcom_irq_fwspec parent = { };
+	unsigned int type;
+
+	ret = msm_gpio_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					    &pctrl->irq_chip, gc);
+	if (ret < 0)
+		return ret;
+
+	if (!domain->parent)
+		return 0;
+
+	parent.fwspec.fwnode      = domain->parent->fwnode;
+	parent.fwspec.param_count = 2;
+	parent.fwspec.param[0]    = hwirq;
+	parent.fwspec.param[1]    = type;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent);
+	if (ret)
+		return ret;
+
+	if (parent.mask)
+		set_bit(hwirq, pctrl->wakeup_masked_irqs);
+
+	return 0;
+}
+
+/*
+ * TODO: Get rid of this and push it into gpiochip_to_irq()
+ */
+static int msm_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct irq_fwspec fwspec;
+
+	fwspec.fwnode = of_node_to_fwnode(chip->of_node);
+	fwspec.param[0] = offset;
+	fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
+	fwspec.param_count = 2;
+
+	return irq_create_fwspec_mapping(&fwspec);
+}
+
+static const struct irq_domain_ops msm_gpio_domain_ops = {
+	.translate = msm_gpio_domain_translate,
+	.alloc     = msm_gpio_domain_alloc,
+	.free      = irq_domain_free_irqs_top,
+};
+
 static int msm_gpio_init(struct msm_pinctrl *pctrl)
 {
 	struct gpio_chip *chip;
 	int ret;
 	unsigned ngpio = pctrl->soc->ngpios;
+	struct device_node *dn;
 
 	if (WARN_ON(ngpio > MAX_NR_GPIO))
 		return -EINVAL;
@@ -986,6 +1088,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	chip->need_valid_mask = msm_gpio_needs_valid_mask(pctrl);
 
 	pctrl->irq_chip.name = "msmgpio";
+	pctrl->irq_chip.irq_eoi	= irq_chip_eoi_parent;
 	pctrl->irq_chip.irq_mask = msm_gpio_irq_mask;
 	pctrl->irq_chip.irq_unmask = msm_gpio_irq_unmask;
 	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
@@ -994,6 +1097,22 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
 	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
 
+	chip->irq.chip = &pctrl->irq_chip;
+	chip->irq.domain_ops = &msm_gpio_domain_ops;
+	chip->irq.handler = handle_edge_irq;
+	chip->irq.default_type = IRQ_TYPE_NONE;
+
+	dn = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
+	if (dn) {
+		chip->irq.parent_domain = irq_find_matching_host(dn,
+						 DOMAIN_BUS_WAKEUP);
+		of_node_put(dn);
+		if (!chip->irq.parent_domain)
+			return -EPROBE_DEFER;
+
+		chip->to_irq = msm_gpio_to_irq;
+	}
+
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
 		dev_err(pctrl->dev, "Failed register gpiochip\n");
@@ -1015,26 +1134,17 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 			dev_name(pctrl->dev), 0, 0, chip->ngpio);
 		if (ret) {
 			dev_err(pctrl->dev, "Failed to add pin range\n");
-			gpiochip_remove(&pctrl->chip);
-			return ret;
+			goto fail;
 		}
 	}
 
-	ret = gpiochip_irqchip_add(chip,
-				   &pctrl->irq_chip,
-				   0,
-				   handle_edge_irq,
-				   IRQ_TYPE_NONE);
-	if (ret) {
-		dev_err(pctrl->dev, "Failed to add irqchip to gpiochip\n");
-		gpiochip_remove(&pctrl->chip);
-		return -ENOSYS;
-	}
-
 	gpiochip_set_chained_irqchip(chip, &pctrl->irq_chip, pctrl->irq,
 				     msm_gpio_irq_handler);
 
 	return 0;
+fail:
+	gpiochip_remove(&pctrl->chip);
+	return ret;
 }
 
 static int msm_ps_hold_restart(struct notifier_block *nb, unsigned long action,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

