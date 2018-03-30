Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeC3HDQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:03:16 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45093 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeC3HDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:03:13 -0400
X-Google-Smtp-Source: AIpwx4/yjzwV76oIEaKZWZvnPNGr5MsHvgEll7L4e/3JfjyIQCqeeNMeDB3md2Sc6BBMtdQYbopTKw==
From: Baolin Wang <baolin.wang@linaro.org>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH 2/2] gpio: pmic_eic: Add edge trigger emulation for PMIC EIC
Date: Fri, 30 Mar 2018 15:02:38 +0800
Message-Id: <7bac44aef748c61863fd9651ef3c52b4e51c511a.1522392153.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <bdaaa8823cc3aef44352ee867fb6274278f2a2a9.1522392153.git.baolin.wang@linaro.org>
References: <bdaaa8823cc3aef44352ee867fb6274278f2a2a9.1522392153.git.baolin.wang@linaro.org>
In-Reply-To: <bdaaa8823cc3aef44352ee867fb6274278f2a2a9.1522392153.git.baolin.wang@linaro.org>
References: <bdaaa8823cc3aef44352ee867fb6274278f2a2a9.1522392153.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will toggle the EIC level to emulate the edge trigger to
support PMIC EIC egdge trigger function, which is required by gpio-keys
driver.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/gpio/gpio-pmic-eic-sprd.c |   58 +++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 66d68d9..29e044f 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -178,6 +178,14 @@ static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
 	case IRQ_TYPE_LEVEL_LOW:
 		pmic_eic->reg[REG_IEV] = 0;
 		break;
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_EDGE_BOTH:
+		/*
+		 * Will set the trigger level according to current EIC level
+		 * in irq_bus_sync_unlock() interface, so here nothing to do.
+		 */
+		break;
 	default:
 		return -ENOTSUPP;
 	}
@@ -197,11 +205,22 @@ static void sprd_pmic_eic_bus_sync_unlock(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
+	u32 trigger = irqd_get_trigger_type(data);
 	u32 offset = irqd_to_hwirq(data);
+	int state;
 
 	/* Set irq type */
-	sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV,
-			     pmic_eic->reg[REG_IEV]);
+	if (trigger & IRQ_TYPE_EDGE_BOTH) {
+		state = sprd_pmic_eic_get(chip, offset);
+		if (state)
+			sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV, 0);
+		else
+			sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV, 1);
+	} else {
+		sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV,
+				     pmic_eic->reg[REG_IEV]);
+	}
+
 	/* Set irq unmask */
 	sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IE,
 			     pmic_eic->reg[REG_IE]);
@@ -212,6 +231,35 @@ static void sprd_pmic_eic_bus_sync_unlock(struct irq_data *data)
 	mutex_unlock(&pmic_eic->buslock);
 }
 
+static void sprd_pmic_eic_toggle_trigger(struct gpio_chip *chip,
+					 unsigned int irq, unsigned int offset)
+{
+	u32 trigger = irq_get_trigger_type(irq);
+	int state, post_state;
+
+	if (!(trigger & IRQ_TYPE_EDGE_BOTH))
+		return;
+
+	state = sprd_pmic_eic_get(chip, offset);
+retry:
+	if (state)
+		sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV, 0);
+	else
+		sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV, 1);
+
+	post_state = sprd_pmic_eic_get(chip, offset);
+	if (state != post_state) {
+		dev_warn(chip->parent, "PMIC EIC level was changed.\n");
+		state = post_state;
+		goto retry;
+	}
+
+	/* Set irq unmask */
+	sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IE, 1);
+	/* Generate trigger start pulse for debounce EIC */
+	sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_TRIG, 1);
+}
+
 static irqreturn_t sprd_pmic_eic_irq_handler(int irq, void *data)
 {
 	struct sprd_pmic_eic *pmic_eic = data;
@@ -233,6 +281,12 @@ static irqreturn_t sprd_pmic_eic_irq_handler(int irq, void *data)
 
 		girq = irq_find_mapping(chip->irq.domain, n);
 		handle_nested_irq(girq);
+
+		/*
+		 * The PMIC EIC can only support level trigger, so we can
+		 * toggle the level trigger to emulate the edge trigger.
+		 */
+		sprd_pmic_eic_toggle_trigger(chip, girq, n);
 	}
 
 	return IRQ_HANDLED;
-- 
1.7.9.5
