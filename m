Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeC3HDM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:03:12 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38680 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeC3HDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:03:10 -0400
X-Google-Smtp-Source: AIpwx4/ns0BpEMTuSqbbmlAmIHZn1UE+pelgg//URE/8XiL4k3BOSLMBYUFkwTs9y//5Ofuujpcf+w==
From: Baolin Wang <baolin.wang@linaro.org>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH 1/2] gpio: eic: Add edge trigger emulation for EIC
Date: Fri, 30 Mar 2018 15:02:37 +0800
Message-Id: <bdaaa8823cc3aef44352ee867fb6274278f2a2a9.1522392153.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum debounce EIC and latch EIC can not support edge trigger,
but most GPIO users (like gpio-key driver) only use the edge trigger,
thus the EIC driver need add some support to emulate the edge trigger
to satisfy this requirement.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/gpio/gpio-eic-sprd.c |   73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index de7dd93..e0d6a0a 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -300,6 +300,7 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
 	u32 offset = irqd_to_hwirq(data);
+	int state;
 
 	switch (sprd_eic->type) {
 	case SPRD_EIC_DEBOUNCE:
@@ -310,6 +311,17 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 0);
 			break;
+		case IRQ_TYPE_EDGE_RISING:
+		case IRQ_TYPE_EDGE_FALLING:
+		case IRQ_TYPE_EDGE_BOTH:
+			state = sprd_eic_get(chip, offset);
+			if (state)
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_DBNC_IEV, 0);
+			else
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_DBNC_IEV, 1);
+			break;
 		default:
 			return -ENOTSUPP;
 		}
@@ -324,6 +336,17 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 1);
 			break;
+		case IRQ_TYPE_EDGE_RISING:
+		case IRQ_TYPE_EDGE_FALLING:
+		case IRQ_TYPE_EDGE_BOTH:
+			state = sprd_eic_get(chip, offset);
+			if (state)
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_LATCH_INTPOL, 0);
+			else
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_LATCH_INTPOL, 1);
+			break;
 		default:
 			return -ENOTSUPP;
 		}
@@ -405,6 +428,55 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	return 0;
 }
 
+static void sprd_eic_toggle_trigger(struct gpio_chip *chip, unsigned int irq,
+				    unsigned int offset)
+{
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+	struct irq_data *data = irq_get_irq_data(irq);
+	u32 trigger = irqd_get_trigger_type(data);
+	int state, post_state;
+
+	/*
+	 * The debounce EIC and latch EIC can only support level trigger, so we
+	 * can toggle the level trigger to emulate the edge trigger.
+	 */
+	if ((sprd_eic->type != SPRD_EIC_DEBOUNCE &&
+	     sprd_eic->type != SPRD_EIC_LATCH) ||
+	    !(trigger & IRQ_TYPE_EDGE_BOTH))
+		return;
+
+	sprd_eic_irq_mask(data);
+	state = sprd_eic_get(chip, offset);
+
+retry:
+	switch (sprd_eic->type) {
+	case SPRD_EIC_DEBOUNCE:
+		if (state)
+			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 0);
+		else
+			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 1);
+		break;
+	case SPRD_EIC_LATCH:
+		if (state)
+			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 0);
+		else
+			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 1);
+		break;
+	default:
+		sprd_eic_irq_unmask(data);
+		return;
+	}
+
+	post_state = sprd_eic_get(chip, offset);
+	if (state != post_state) {
+		dev_warn(chip->parent, "EIC level was changed.\n");
+		state = post_state;
+		goto retry;
+	}
+
+	sprd_eic_irq_unmask(data);
+}
+
 static int sprd_eic_match_chip_by_type(struct gpio_chip *chip, void *data)
 {
 	enum sprd_eic_type type = *(enum sprd_eic_type *)data;
@@ -448,6 +520,7 @@ static void sprd_eic_handle_one_type(struct gpio_chip *chip)
 					bank * SPRD_EIC_PER_BANK_NR + n);
 
 			generic_handle_irq(girq);
+			sprd_eic_toggle_trigger(chip, girq, n);
 		}
 	}
 }
-- 
1.7.9.5
