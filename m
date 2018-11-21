Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820CBC04EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D5D20870
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RpMUejOg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mDpNIA+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D5D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeKUKjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:39:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48134 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeKUKjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:39:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E048601D1; Wed, 21 Nov 2018 00:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542758842;
        bh=Knfrzm8RgcOWll7kftiNIAOLc4SHxZJ2nQ94bcERF0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpMUejOgoEI/7KrXadiy1wYkTyhqCbcq1XcrmRQScOzfZrPgaF3reuUi6nC35ibtO
         +60MdUDU5Td09K35c6CzqwJiqeP7HQkEs8Wi8/me7i+vKcgEvIOjaqTHdtESi0IYu6
         n/JWmhQDrpT15TXpyeLkzeTYi6EKqR3hA5ru2WgY=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD3E3601D1;
        Wed, 21 Nov 2018 00:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542758841;
        bh=Knfrzm8RgcOWll7kftiNIAOLc4SHxZJ2nQ94bcERF0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDpNIA+L/bgDRcAnUGuRJQYWrmMMCRHIRs9I3GKyFoNf/kjx+w0DFUkTbtriOoJaG
         g8iX3uNP3Y2FWs1EucYGRw48FWrsP3ZjVxdNXN9122dq6d0aKW+TbTDG/BSe7S9a2S
         0TUVtoIQ+9IdXGvhOX/BReYKbngj1YEzXKq8bXFA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD3E3601D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, Lina Iyer <ilina@codeaurora.org>
Subject: [RFC v3 1/3] drivers: pinctrl: msm: setup gpio irqchip in hierarchy with pdc irqchip
Date:   Tue, 20 Nov 2018 17:06:46 -0700
Message-Id: <20181121000648.29262-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121000648.29262-1-ilina@codeaurora.org>
References: <20181121000648.29262-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 125 ++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 7c7d083e2c0d..3857aa5539e0 100644
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
@@ -735,6 +736,9 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 	clear_bit(d->hwirq, pctrl->enabled_irqs);
 
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	if (d->parent_data)
+		irq_chip_mask_parent(d);
 }
 
 static void msm_gpio_irq_unmask(struct irq_data *d)
@@ -757,6 +761,9 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
 	set_bit(d->hwirq, pctrl->enabled_irqs);
 
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	if (d->parent_data)
+		irq_chip_unmask_parent(d);
 }
 
 static void msm_gpio_irq_ack(struct irq_data *d)
@@ -875,6 +882,9 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		irq_set_handler_locked(d, handle_edge_irq);
 
+	if (d->parent_data)
+		irq_chip_set_type_parent(d, type);
+
 	return 0;
 }
 
@@ -890,6 +900,9 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
+	if (d->parent_data)
+		irq_chip_set_wake_parent(d, on);
+
 	return 0;
 }
 
@@ -967,11 +980,103 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
 	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
 }
 
+static int get_parent_hwirq(struct msm_pinctrl *pctrl, unsigned int hwirq)
+{
+	int i, n, ret;
+	int gpio, pdc = -EINVAL;
+	struct device_node *np = pctrl->dev->of_node;
+
+	n = of_property_count_elems_of_size(np, "wake-irq", sizeof(u32));
+	if (n <= 0 || n % 2)
+		return -EINVAL;
+
+	for (i = 0; i < n / 2; i++) {
+		ret = of_property_read_u32_index(np, "wake-irq", 2 * i, &gpio);
+		if (ret)
+			return ret;
+		if (gpio != hwirq)
+			continue;
+		ret = of_property_read_u32_index(np, "wake-irq", 2 * i + 1,
+						 &pdc);
+		if (ret)
+			return ret;
+	}
+
+	return pdc;
+}
+
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
+	int ret = 0;
+	irq_hw_number_t hwirq;
+	int parent_hwirq;
+	struct gpio_chip *gc = domain->host_data;
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	struct irq_fwspec parent_fwspec, *fwspec = arg;
+	unsigned int type;
+
+	ret = msm_gpio_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	parent_hwirq = get_parent_hwirq(pctrl, hwirq);
+	if (parent_hwirq < 0)
+		return 0;
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					    &pctrl->irq_chip, gc);
+	if (ret < 0)
+		return ret;
+
+	parent_fwspec.fwnode      = domain->parent->fwnode;
+	parent_fwspec.param_count = 2;
+	parent_fwspec.param[0]    = parent_hwirq;
+	parent_fwspec.param[1]    = type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
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
+static const struct irq_domain_ops msm_gpiod_ops = {
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
@@ -1015,9 +1120,19 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 			dev_name(pctrl->dev), 0, 0, chip->ngpio);
 		if (ret) {
 			dev_err(pctrl->dev, "Failed to add pin range\n");
-			gpiochip_remove(&pctrl->chip);
-			return ret;
+			goto fail;
+		}
+	}
+
+	dn = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
+	if (dn) {
+		chip->irq.parent_domain = irq_find_host(dn);
+		of_node_put(dn);
+		if (!chip->irq.parent_domain) {
+			ret = -EPROBE_DEFER;
+			goto fail;
 		}
+		chip->to_irq = msm_gpio_to_irq;
 	}
 
 	ret = gpiochip_irqchip_add(chip,
@@ -1027,14 +1142,16 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 				   IRQ_TYPE_NONE);
 	if (ret) {
 		dev_err(pctrl->dev, "Failed to add irqchip to gpiochip\n");
-		gpiochip_remove(&pctrl->chip);
-		return -ENOSYS;
+		goto fail;
 	}
 
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

