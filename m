Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbeDQNk4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:40:56 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47299 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753537AbeDQNjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:39:41 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <alexandre.torgue@st.com>
CC: <dan.carpenter@oracle.com>, <thierry.reding@gmail.com>,
        <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH v5 5/6] pwm: stm32: use input prescaler to improve period capture
Date: Tue, 17 Apr 2018 15:38:32 +0200
Message-ID: <1523972313-28765-6-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523972313-28765-1-git-send-email-fabrice.gasnier@st.com>
References: <1523972313-28765-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.121]
X-ClientProxiedBy: GPXDAG1NODE5.st.com (10.75.127.66) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using input prescaler, capture unit will trigger DMA once every
configurable /2, /4 or /8 events (rising edge). This helps improve
period (only) capture accuracy at high rates.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---
Changes in v2:
- Adopt DMA read from MFD core.
---
 drivers/pwm/pwm-stm32.c          | 63 ++++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/stm32-timers.h |  1 +
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 9a50acd..60bfc07 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -8,6 +8,7 @@
  *             pwm-atmel.c from Bo Shen
  */
 
+#include <linux/bitfield.h>
 #include <linux/mfd/stm32-timers.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -168,7 +169,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	unsigned long long prd, div, dty;
 	unsigned long rate;
-	unsigned int psc = 0, scale;
+	unsigned int psc = 0, icpsc, scale;
 	u32 raw_prd, raw_dty;
 	int ret = 0;
 
@@ -222,6 +223,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	/*
 	 * Got a capture. Try to improve accuracy at high rates:
 	 * - decrease counter clock prescaler, scale up to max rate.
+	 * - use input prescaler, capture once every /2 /4 or /8 edges.
 	 */
 	if (raw_prd) {
 		u32 max_arr = priv->max_arr - 0x1000; /* arbitrary margin */
@@ -241,8 +243,65 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 			goto stop;
 	}
 
+	/* Compute intermediate period not to exceed timeout at low rates */
 	prd = (unsigned long long)raw_prd * (psc + 1) * NSEC_PER_SEC;
-	result->period = DIV_ROUND_UP_ULL(prd, rate);
+	do_div(prd, rate);
+
+	for (icpsc = 0; icpsc < MAX_TIM_ICPSC ; icpsc++) {
+		/* input prescaler: also keep arbitrary margin */
+		if (raw_prd >= (priv->max_arr - 0x1000) >> (icpsc + 1))
+			break;
+		if (prd >= (tmo_ms * NSEC_PER_MSEC) >> (icpsc + 2))
+			break;
+	}
+
+	if (!icpsc)
+		goto done;
+
+	/* Last chance to improve period accuracy, using input prescaler */
+	regmap_update_bits(priv->regmap,
+			   pwm->hwpwm < 2 ? TIM_CCMR1 : TIM_CCMR2,
+			   TIM_CCMR_IC1PSC | TIM_CCMR_IC2PSC,
+			   FIELD_PREP(TIM_CCMR_IC1PSC, icpsc) |
+			   FIELD_PREP(TIM_CCMR_IC2PSC, icpsc));
+
+	ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd, &raw_dty);
+	if (ret)
+		goto stop;
+
+	if (raw_dty >= (raw_prd >> icpsc)) {
+		/*
+		 * We may fall here using input prescaler, when input
+		 * capture starts on high side (before falling edge).
+		 * Example with icpsc to capture on each 4 events:
+		 *
+		 *       start   1st capture                     2nd capture
+		 *         v     v                               v
+		 *         ___   _____   _____   _____   _____   ____
+		 * TI1..4     |__|    |__|    |__|    |__|    |__|
+		 *            v  v    .  .    .  .    .       v  v
+		 * icpsc1/3:  .  0    .  1    .  2    .  3    .  0
+		 * icpsc2/4:  0       1       2       3       0
+		 *            v  v                            v  v
+		 * CCR1/3  ......t0..............................t2
+		 * CCR2/4  ..t1..............................t1'...
+		 *               .                            .  .
+		 * Capture0:     .<----------------------------->.
+		 * Capture1:     .<-------------------------->.  .
+		 *               .                            .  .
+		 * Period:       .<------>                    .  .
+		 * Low side:                                  .<>.
+		 *
+		 * Result:
+		 * - Period = Capture0 / icpsc
+		 * - Duty = Period - Low side = Period - (Capture0 - Capture1)
+		 */
+		raw_dty = (raw_prd >> icpsc) - (raw_prd - raw_dty);
+	}
+
+done:
+	prd = (unsigned long long)raw_prd * (psc + 1) * NSEC_PER_SEC;
+	result->period = DIV_ROUND_UP_ULL(prd, rate << icpsc);
 	dty = (unsigned long long)raw_dty * (psc + 1) * NSEC_PER_SEC;
 	result->duty_cycle = DIV_ROUND_UP_ULL(dty, rate);
 stop:
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index d46f550..9da1d7e 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -82,6 +82,7 @@
 #define TIM_DCR_DBL	GENMASK(12, 8)	/* DMA burst len */
 
 #define MAX_TIM_PSC		0xFFFF
+#define MAX_TIM_ICPSC		0x3
 #define TIM_CR2_MMS_SHIFT	4
 #define TIM_CR2_MMS2_SHIFT	20
 #define TIM_SMCR_TS_SHIFT	4
-- 
1.9.1
