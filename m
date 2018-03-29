Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeC2LLX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:11:23 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:37631 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752555AbeC2LLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:11:20 -0400
X-IronPort-AV: E=Sophos;i="5.48,376,1517900400";
   d="scan'208";a="10628989"
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <thierry.reding@gmail.com>, <shc_work@mail.ru>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <corbet@lwn.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>
CC: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 6/9] pwm: atmel: add pwm capabilities
Date: Thu, 29 Mar 2018 14:10:32 +0300
Message-ID: <1522321835-6460-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522321835-6460-1-git-send-email-claudiu.beznea@microchip.com>
References: <1522321835-6460-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pwm capabilities for Atmel/Microchip PWM controllers.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 80 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 530d7dc5f1b5..87ef54bd492c 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -65,11 +65,16 @@ struct atmel_pwm_registers {
 	u8 duty_upd;
 };
 
+struct atmel_pwm_data {
+	struct atmel_pwm_registers regs;
+	struct pwm_caps caps;
+};
+
 struct atmel_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
-	const struct atmel_pwm_registers *regs;
+	const struct atmel_pwm_data *data;
 
 	unsigned int updated_pwms;
 	/* ISR is cleared when read, ensure only one thread does that */
@@ -150,15 +155,15 @@ static void atmel_pwm_update_cdty(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	u32 val;
 
-	if (atmel_pwm->regs->duty_upd ==
-	    atmel_pwm->regs->period_upd) {
+	if (atmel_pwm->data->regs.duty_upd ==
+	    atmel_pwm->data->regs.period_upd) {
 		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
 		val &= ~PWM_CMR_UPD_CDTY;
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 	}
 
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->duty_upd, cdty);
+			    atmel_pwm->data->regs.duty_upd, cdty);
 }
 
 static void atmel_pwm_set_cprd_cdty(struct pwm_chip *chip,
@@ -168,9 +173,9 @@ static void atmel_pwm_set_cprd_cdty(struct pwm_chip *chip,
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->duty, cdty);
+			    atmel_pwm->data->regs.duty, cdty);
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
-			    atmel_pwm->regs->period, cprd);
+			    atmel_pwm->data->regs.period, cprd);
 }
 
 static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -225,7 +230,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		    cstate.polarity == state->polarity &&
 		    cstate.period == state->period) {
 			cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
-						  atmel_pwm->regs->period);
+						  atmel_pwm->data->regs.period);
 			atmel_pwm_calculate_cdty(state, cprd, &cdty);
 			atmel_pwm_update_cdty(chip, pwm, cdty);
 			return 0;
@@ -272,32 +277,51 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static void atmel_pwm_get_caps(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_caps *caps)
+{
+	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
+
+	*caps = atmel_pwm->data->caps;
+}
+
 static const struct pwm_ops atmel_pwm_ops = {
 	.apply = atmel_pwm_apply,
+	.get_caps = atmel_pwm_get_caps,
 	.owner = THIS_MODULE,
 };
 
-static const struct atmel_pwm_registers atmel_pwm_regs_v1 = {
-	.period		= PWMV1_CPRD,
-	.period_upd	= PWMV1_CUPD,
-	.duty		= PWMV1_CDTY,
-	.duty_upd	= PWMV1_CUPD,
+static const struct atmel_pwm_data atmel_pwm_data_v1 = {
+	.regs = {
+		.period		= PWMV1_CPRD,
+		.period_upd	= PWMV1_CUPD,
+		.duty		= PWMV1_CDTY,
+		.duty_upd	= PWMV1_CUPD,
+	},
+	.caps = {
+		.modes = PWMC_MODE(NORMAL),
+	},
 };
 
-static const struct atmel_pwm_registers atmel_pwm_regs_v2 = {
-	.period		= PWMV2_CPRD,
-	.period_upd	= PWMV2_CPRDUPD,
-	.duty		= PWMV2_CDTY,
-	.duty_upd	= PWMV2_CDTYUPD,
+static const struct atmel_pwm_data atmel_pwm_data_v2 = {
+	.regs = {
+		.period		= PWMV2_CPRD,
+		.period_upd	= PWMV2_CPRDUPD,
+		.duty		= PWMV2_CDTY,
+		.duty_upd	= PWMV2_CDTYUPD,
+	},
+	.caps = {
+		.modes = PWMC_MODE(NORMAL) | PWMC_MODE(COMPLEMENTARY),
+	},
 };
 
 static const struct platform_device_id atmel_pwm_devtypes[] = {
 	{
 		.name = "at91sam9rl-pwm",
-		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v1,
+		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v1,
 	}, {
 		.name = "sama5d3-pwm",
-		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v2,
+		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v2,
 	}, {
 		/* sentinel */
 	},
@@ -307,20 +331,20 @@ MODULE_DEVICE_TABLE(platform, atmel_pwm_devtypes);
 static const struct of_device_id atmel_pwm_dt_ids[] = {
 	{
 		.compatible = "atmel,at91sam9rl-pwm",
-		.data = &atmel_pwm_regs_v1,
+		.data = &atmel_pwm_data_v1,
 	}, {
 		.compatible = "atmel,sama5d3-pwm",
-		.data = &atmel_pwm_regs_v2,
+		.data = &atmel_pwm_data_v2,
 	}, {
 		.compatible = "atmel,sama5d2-pwm",
-		.data = &atmel_pwm_regs_v2,
+		.data = &atmel_pwm_data_v2,
 	}, {
 		/* sentinel */
 	},
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
-static inline const struct atmel_pwm_registers *
+static inline const struct atmel_pwm_data *
 atmel_pwm_get_driver_data(struct platform_device *pdev)
 {
 	const struct platform_device_id *id;
@@ -330,18 +354,18 @@ atmel_pwm_get_driver_data(struct platform_device *pdev)
 
 	id = platform_get_device_id(pdev);
 
-	return (struct atmel_pwm_registers *)id->driver_data;
+	return (struct atmel_pwm_data *)id->driver_data;
 }
 
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
-	const struct atmel_pwm_registers *regs;
+	const struct atmel_pwm_data *data;
 	struct atmel_pwm_chip *atmel_pwm;
 	struct resource *res;
 	int ret;
 
-	regs = atmel_pwm_get_driver_data(pdev);
-	if (!regs)
+	data = atmel_pwm_get_driver_data(pdev);
+	if (!data)
 		return -ENODEV;
 
 	atmel_pwm = devm_kzalloc(&pdev->dev, sizeof(*atmel_pwm), GFP_KERNEL);
@@ -373,7 +397,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	atmel_pwm->chip.base = -1;
 	atmel_pwm->chip.npwm = 4;
-	atmel_pwm->regs = regs;
+	atmel_pwm->data = data;
 	atmel_pwm->updated_pwms = 0;
 	mutex_init(&atmel_pwm->isr_lock);
 
-- 
2.7.4
