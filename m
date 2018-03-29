Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeC2LLj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:11:39 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:42882 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeC2LL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:11:29 -0400
X-IronPort-AV: E=Sophos;i="5.48,376,1517900400";
   d="scan'208";a="13376170"
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <thierry.reding@gmail.com>, <shc_work@mail.ru>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <corbet@lwn.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>
CC: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 9/9] pwm: atmel: add push-pull mode support
Date: Thu, 29 Mar 2018 14:10:35 +0300
Message-ID: <1522321835-6460-10-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522321835-6460-1-git-send-email-claudiu.beznea@microchip.com>
References: <1522321835-6460-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PWM push-pull mode. This is only supported by SAMA5D2 SoCs.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 87ef54bd492c..aaafc4dd30f2 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -33,8 +33,11 @@
 
 #define PWM_CMR			0x0
 /* Bit field in CMR */
-#define PWM_CMR_CPOL		(1 << 9)
-#define PWM_CMR_UPD_CDTY	(1 << 10)
+#define PWM_CMR_CPOL		BIT(9)
+#define PWM_CMR_UPD_CDTY	BIT(10)
+#define PWM_CMR_DTHI		BIT(17)
+#define PWM_CMR_DTLI		BIT(18)
+#define PWM_CMR_PPM		BIT(19)
 #define PWM_CMR_CPRE_MSK	0xF
 
 /* The following registers for PWM v1 */
@@ -219,16 +222,19 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	struct pwm_state cstate;
+	struct pwm_caps caps;
 	unsigned long cprd, cdty;
 	u32 pres, val;
 	int ret;
 
 	pwm_get_state(pwm, &cstate);
+	pwm_get_caps(chip, pwm, &caps);
 
 	if (state->enabled) {
 		if (cstate.enabled &&
 		    cstate.polarity == state->polarity &&
-		    cstate.period == state->period) {
+		    cstate.period == state->period &&
+		    cstate.mode == state->mode) {
 			cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
 						  atmel_pwm->data->regs.period);
 			atmel_pwm_calculate_cdty(state, cprd, &cdty);
@@ -263,6 +269,18 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			val &= ~PWM_CMR_CPOL;
 		else
 			val |= PWM_CMR_CPOL;
+
+		/* PWM mode. */
+		if (caps.modes & PWMC_MODE(PUSH_PULL)) {
+			if (state->mode == PWMC_MODE(PUSH_PULL)) {
+				val |= PWM_CMR_PPM | PWM_CMR_DTLI;
+				val &= ~PWM_CMR_DTHI;
+			} else {
+				val &= ~(PWM_CMR_PPM | PWM_CMR_DTLI |
+					 PWM_CMR_DTHI);
+			}
+		}
+
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 		atmel_pwm_set_cprd_cdty(chip, pwm, cprd, cdty);
 		mutex_lock(&atmel_pwm->isr_lock);
@@ -315,6 +333,20 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 = {
 	},
 };
 
+static const struct atmel_pwm_data atmel_pwm_data_v3 = {
+	.regs = {
+		.period		= PWMV2_CPRD,
+		.period_upd	= PWMV2_CPRDUPD,
+		.duty		= PWMV2_CDTY,
+		.duty_upd	= PWMV2_CDTYUPD,
+	},
+	.caps = {
+		.modes = PWMC_MODE(NORMAL) |
+			 PWMC_MODE(COMPLEMENTARY) |
+			 PWMC_MODE(PUSH_PULL),
+	},
+};
+
 static const struct platform_device_id atmel_pwm_devtypes[] = {
 	{
 		.name = "at91sam9rl-pwm",
@@ -337,7 +369,7 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 		.data = &atmel_pwm_data_v2,
 	}, {
 		.compatible = "atmel,sama5d2-pwm",
-		.data = &atmel_pwm_data_v2,
+		.data = &atmel_pwm_data_v3,
 	}, {
 		/* sentinel */
 	},
-- 
2.7.4
