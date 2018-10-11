Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1ADC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A48420644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QQWFsXqe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QQWFsXqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A48420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJKHyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:54:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeJKHyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:54:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B53FF60C67; Thu, 11 Oct 2018 00:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539217813;
        bh=sbZnPt7T1cXWMWA/XJDuCxCS9mza7CUN3fx53yjLqeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQWFsXqetHxIFm5o20gUOvUUEqbaZu5K/Z7oKJBTJ5gZhmetGQHBqalVTVL4q0lF7
         i96aTqnvJ0xQwX6nCrPk0DUPw6nseycjH8dSSvoQ0dsbHn83eow/y5wldocrtw9xrS
         SY3xujBFd4EInnDggJE238tkKhcZ1VYNj0vSA8fo=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C77BA60B0D;
        Thu, 11 Oct 2018 00:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539217813;
        bh=sbZnPt7T1cXWMWA/XJDuCxCS9mza7CUN3fx53yjLqeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQWFsXqetHxIFm5o20gUOvUUEqbaZu5K/Z7oKJBTJ5gZhmetGQHBqalVTVL4q0lF7
         i96aTqnvJ0xQwX6nCrPk0DUPw6nseycjH8dSSvoQ0dsbHn83eow/y5wldocrtw9xrS
         SY3xujBFd4EInnDggJE238tkKhcZ1VYNj0vSA8fo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C77BA60B0D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC 1/1] drivers: pinctrl: qcom: add wakeup capability to GPIO
Date:   Wed, 10 Oct 2018 18:29:58 -0600
Message-Id: <20181011002958.2597-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181011002958.2597-1-ilina@codeaurora.org>
References: <20181011002958.2597-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
domain can wakeup the SoC, when interrupts and GPIOs are routed to its
interrupt controller. Only select GPIOs that are deemed wakeup capable
are routed to specific PDC pins. During low power state, the pinmux
interrupt controller may be non-functional but the PDC would be. The PDC
can detect the wakeup GPIO is triggered and bring the TLMM to an
operational state.

Interrupts that are level triggered will be detected at the TLMM when
the controller becomes operational. Edge interrupts however need to be
replayed again.

Request the corresponding PDC IRQ, when the GPIO is requested as an IRQ,
but keep it disabled. During suspend, we can enable the PDC IRQ instead
of the GPIO IRQ, which may or not be detected.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v4:
	- Redesign to use PDC interrupts instead of TLMM interrupt
Changes in v3:
	- free action->name
Changes in v2:
	- Remove IRQF_NO_SUSPEND and IRQF_ONE_SHOT from PDC IRQ
Changes in v1:
	- Trigger GPIO in h/w from PDC IRQ handler
	- Avoid big tables for GPIO-PDC map, pick from DT instead
	- Use handler_data
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 91 +++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 5d72ffad32c2..70b9178eba30 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -719,6 +719,12 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	const struct msm_pingroup *g;
 	unsigned long flags;
 	u32 val;
+	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
+
+	if (pdc_irqd) {
+		irq_set_irq_type(pdc_irqd->irq, type);
+		goto handler;
+	}
 
 	g = &pctrl->soc->groups[d->hwirq];
 
@@ -798,6 +804,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
+handler:
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		irq_set_handler_locked(d, handle_level_irq);
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
@@ -811,9 +818,13 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	unsigned long flags;
+	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
+	if (pdc_irqd)
+		irq_set_irq_wake(pdc_irqd->irq, on);
+
 	irq_set_irq_wake(pctrl->irq, on);
 
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
@@ -895,6 +906,83 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
 	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
 }
 
+static irqreturn_t wake_irq_gpio_handler(int irq, void *data)
+{
+	struct irq_data *irqd = data;
+	struct irq_desc *desc = irq_to_desc(irqd->irq);
+
+	desc->handle_irq(desc);
+
+	return IRQ_HANDLED;
+}
+
+static int msm_gpio_pdc_pin_request(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	struct platform_device *pdev = to_platform_device(pctrl->dev);
+	const char *pin_name;
+	int irq;
+	int ret;
+
+	pin_name = kasprintf(GFP_KERNEL, "gpio%lu", d->hwirq);
+	if (!pin_name)
+		return -ENOMEM;
+
+	irq = platform_get_irq_byname(pdev, pin_name);
+	if (irq < 0) {
+		kfree(pin_name);
+		return 0;
+	}
+
+	ret = request_irq(irq, wake_irq_gpio_handler, irqd_get_trigger_type(d),
+			  pin_name, d);
+	if (ret) {
+		pr_warn("Error requesting PDC interrupt %d for %s\n",
+			irq, pin_name);
+		kfree(pin_name);
+		return ret;
+	}
+	irq_set_handler_data(d->irq, irq_get_irq_data(irq));
+
+	return 0;
+}
+
+static int msm_gpio_pdc_pin_release(struct irq_data *d)
+{
+	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
+	const void *name;
+
+	if (pdc_irqd) {
+		irq_set_handler_data(d->irq, NULL);
+		name = free_irq(pdc_irqd->irq, d);
+		kfree(name);
+	}
+
+	return 0;
+}
+
+static int msm_gpio_irq_reqres(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	if (gpiochip_lock_as_irq(gc, irqd_to_hwirq(d))) {
+		dev_err(gc->parent, "unable to lock HW IRQ %lu for IRQ\n",
+			irqd_to_hwirq(d));
+		return -EINVAL;
+	}
+
+	return msm_gpio_pdc_pin_request(d);
+}
+
+static void msm_gpio_irq_relres(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	msm_gpio_pdc_pin_release(d);
+	gpiochip_unlock_as_irq(gc, irqd_to_hwirq(d));
+}
+
 static int msm_gpio_init(struct msm_pinctrl *pctrl)
 {
 	struct gpio_chip *chip;
@@ -919,6 +1007,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
 	pctrl->irq_chip.irq_set_type = msm_gpio_irq_set_type;
 	pctrl->irq_chip.irq_set_wake = msm_gpio_irq_set_wake;
+	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
+	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
 
 	ret = gpiochip_add_data(&pctrl->chip, pctrl);
 	if (ret) {
@@ -1072,4 +1162,3 @@ int msm_pinctrl_remove(struct platform_device *pdev)
 	return 0;
 }
 EXPORT_SYMBOL(msm_pinctrl_remove);
-
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

