Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753911AbeDQNkx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:40:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22711 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753562AbeDQNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:39:42 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <alexandre.torgue@st.com>
CC: <dan.carpenter@oracle.com>, <thierry.reding@gmail.com>,
        <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH v5 3/6] pwm: stm32: add capture support
Date: Tue, 17 Apr 2018 15:38:30 +0200
Message-ID: <1523972313-28765-4-git-send-email-fabrice.gasnier@st.com>
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

Add support for PMW input mode on pwm-stm32. STM32 timers support
period and duty cycle capture as long as they have at least two PWM
channels. One capture channel is used for period (rising-edge), one
for duty-cycle (falling-edge).
When there's only one channel available, only period can be captured.
Duty-cycle is simply zero'ed in such a case.

Capture requires exclusive access (e.g. no pwm output running at the
same time, to protect common prescaler).
Timer DMA burst mode (from MFD core) is being used, to take two
snapshots of capture registers (upon each period rising edge).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---
Changes in v3:
- update stm32_timers_dma_burst_read() call: don't pass ddata structure,
  use MFD parent device structure instead since MFD core update.

Changes in v2:
- DMA handling has been moved to MFD core. Rework capture routines to
  use it.
---
 drivers/pwm/pwm-stm32.c          | 176 +++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/stm32-timers.h |  11 +++
 2 files changed, 187 insertions(+)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 2708212..ed3961b 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -25,6 +25,7 @@ struct stm32_pwm {
 	struct regmap *regmap;
 	u32 max_arr;
 	bool have_complementary_output;
+	u32 capture[4] ____cacheline_aligned; /* DMA'able buffer */
 };
 
 struct stm32_breakinput {
@@ -62,6 +63,178 @@ static int write_ccrx(struct stm32_pwm *dev, int ch, u32 value)
 	return -EINVAL;
 }
 
+#define TIM_CCER_CC12P (TIM_CCER_CC1P | TIM_CCER_CC2P)
+#define TIM_CCER_CC12E (TIM_CCER_CC1E | TIM_CCER_CC2E)
+#define TIM_CCER_CC34P (TIM_CCER_CC3P | TIM_CCER_CC4P)
+#define TIM_CCER_CC34E (TIM_CCER_CC3E | TIM_CCER_CC4E)
+
+/*
+ * Capture using PWM input mode:
+ *                              ___          ___
+ * TI[1, 2, 3 or 4]: ........._|   |________|
+ *                             ^0  ^1       ^2
+ *                              .   .        .
+ *                              .   .        XXXXX
+ *                              .   .   XXXXX     |
+ *                              .  XXXXX     .    |
+ *                            XXXXX .        .    |
+ * COUNTER:        ______XXXXX  .   .        .    |_XXX
+ *                 start^       .   .        .        ^stop
+ *                      .       .   .        .
+ *                      v       v   .        v
+ *                                  v
+ * CCR1/CCR3:       tx..........t0...........t2
+ * CCR2/CCR4:       tx..............t1.........
+ *
+ * DMA burst transfer:          |            |
+ *                              v            v
+ * DMA buffer:                  { t0, tx }   { t2, t1 }
+ * DMA done:                                 ^
+ *
+ * 0: IC1/3 snapchot on rising edge: counter value -> CCR1/CCR3
+ *    + DMA transfer CCR[1/3] & CCR[2/4] values (t0, tx: doesn't care)
+ * 1: IC2/4 snapchot on falling edge: counter value -> CCR2/CCR4
+ * 2: IC1/3 snapchot on rising edge: counter value -> CCR1/CCR3
+ *    + DMA transfer CCR[1/3] & CCR[2/4] values (t2, t1)
+ *
+ * DMA done, compute:
+ * - Period     = t2 - t0
+ * - Duty cycle = t1 - t0
+ */
+static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
+				 unsigned long tmo_ms, u32 *raw_prd,
+				 u32 *raw_dty)
+{
+	struct device *parent = priv->chip.dev->parent;
+	enum stm32_timers_dmas dma_id;
+	u32 ccen, ccr;
+	int ret;
+
+	/* Ensure registers have been updated, enable counter and capture */
+	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
+
+	/* Use cc1 or cc3 DMA resp for PWM input channels 1 & 2 or 3 & 4 */
+	dma_id = pwm->hwpwm < 2 ? STM32_TIMERS_DMA_CH1 : STM32_TIMERS_DMA_CH3;
+	ccen = pwm->hwpwm < 2 ? TIM_CCER_CC12E : TIM_CCER_CC34E;
+	ccr = pwm->hwpwm < 2 ? TIM_CCR1 : TIM_CCR3;
+	regmap_update_bits(priv->regmap, TIM_CCER, ccen, ccen);
+
+	/*
+	 * Timer DMA burst mode. Request 2 registers, 2 bursts, to get both
+	 * CCR1 & CCR2 (or CCR3 & CCR4) on each capture event.
+	 * We'll get two capture snapchots: { CCR1, CCR2 }, { CCR1, CCR2 }
+	 * or { CCR3, CCR4 }, { CCR3, CCR4 }
+	 */
+	ret = stm32_timers_dma_burst_read(parent, priv->capture, dma_id, ccr, 2,
+					  2, tmo_ms);
+	if (ret)
+		goto stop;
+
+	/* Period: t2 - t0 (take care of counter overflow) */
+	if (priv->capture[0] <= priv->capture[2])
+		*raw_prd = priv->capture[2] - priv->capture[0];
+	else
+		*raw_prd = priv->max_arr - priv->capture[0] + priv->capture[2];
+
+	/* Duty cycle capture requires at least two capture units */
+	if (pwm->chip->npwm < 2)
+		*raw_dty = 0;
+	else if (priv->capture[0] <= priv->capture[3])
+		*raw_dty = priv->capture[3] - priv->capture[0];
+	else
+		*raw_dty = priv->max_arr - priv->capture[0] + priv->capture[3];
+
+	if (*raw_dty > *raw_prd) {
+		/*
+		 * Race beetween PWM input and DMA: it may happen
+		 * falling edge triggers new capture on TI2/4 before DMA
+		 * had a chance to read CCR2/4. It means capture[1]
+		 * contains period + duty_cycle. So, subtract period.
+		 */
+		*raw_dty -= *raw_prd;
+	}
+
+stop:
+	regmap_update_bits(priv->regmap, TIM_CCER, ccen, 0);
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+
+	return ret;
+}
+
+static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
+			     struct pwm_capture *result, unsigned long tmo_ms)
+{
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	unsigned long long prd, div, dty;
+	unsigned long rate;
+	unsigned int psc = 0;
+	u32 raw_prd, raw_dty;
+	int ret = 0;
+
+	mutex_lock(&priv->lock);
+
+	if (active_channels(priv)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = clk_enable(priv->clk);
+	if (ret) {
+		dev_err(priv->chip.dev, "failed to enable counter clock\n");
+		goto unlock;
+	}
+
+	rate = clk_get_rate(priv->clk);
+	if (!rate) {
+		ret = -EINVAL;
+		goto clk_dis;
+	}
+
+	/* prescaler: fit timeout window provided by upper layer */
+	div = (unsigned long long)rate * (unsigned long long)tmo_ms;
+	do_div(div, MSEC_PER_SEC);
+	prd = div;
+	while ((div > priv->max_arr) && (psc < MAX_TIM_PSC)) {
+		psc++;
+		div = prd;
+		do_div(div, psc + 1);
+	}
+	regmap_write(priv->regmap, TIM_ARR, priv->max_arr);
+	regmap_write(priv->regmap, TIM_PSC, psc);
+
+	/* Map TI1 or TI2 PWM input to IC1 & IC2 (or TI3/4 to IC3 & IC4) */
+	regmap_update_bits(priv->regmap,
+			   pwm->hwpwm < 2 ? TIM_CCMR1 : TIM_CCMR2,
+			   TIM_CCMR_CC1S | TIM_CCMR_CC2S, pwm->hwpwm & 0x1 ?
+			   TIM_CCMR_CC1S_TI2 | TIM_CCMR_CC2S_TI2 :
+			   TIM_CCMR_CC1S_TI1 | TIM_CCMR_CC2S_TI1);
+
+	/* Capture period on IC1/3 rising edge, duty cycle on IC2/4 falling. */
+	regmap_update_bits(priv->regmap, TIM_CCER, pwm->hwpwm < 2 ?
+			   TIM_CCER_CC12P : TIM_CCER_CC34P, pwm->hwpwm < 2 ?
+			   TIM_CCER_CC2P : TIM_CCER_CC4P);
+
+	ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd, &raw_dty);
+	if (ret)
+		goto stop;
+
+	prd = (unsigned long long)raw_prd * (psc + 1) * NSEC_PER_SEC;
+	result->period = DIV_ROUND_UP_ULL(prd, rate);
+	dty = (unsigned long long)raw_dty * (psc + 1) * NSEC_PER_SEC;
+	result->duty_cycle = DIV_ROUND_UP_ULL(dty, rate);
+stop:
+	regmap_write(priv->regmap, TIM_CCER, 0);
+	regmap_write(priv->regmap, pwm->hwpwm < 2 ? TIM_CCMR1 : TIM_CCMR2, 0);
+	regmap_write(priv->regmap, TIM_PSC, 0);
+clk_dis:
+	clk_disable(priv->clk);
+unlock:
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
 static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 			    int duty_ns, int period_ns)
 {
@@ -230,6 +403,9 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
 static const struct pwm_ops stm32pwm_ops = {
 	.owner = THIS_MODULE,
 	.apply = stm32_pwm_apply_locked,
+#if IS_ENABLED(CONFIG_DMA_ENGINE)
+	.capture = stm32_pwm_capture,
+#endif
 };
 
 static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 9596d5c..d46f550 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -51,13 +51,24 @@
 #define TIM_EGR_UG	BIT(0)	/* Update Generation       */
 #define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
 #define TIM_CCMR_M1	(BIT(6) | BIT(5))  /* Channel PWM Mode 1 */
+#define TIM_CCMR_CC1S		(BIT(0) | BIT(1)) /* Capture/compare 1 sel */
+#define TIM_CCMR_IC1PSC		GENMASK(3, 2)	/* Input capture 1 prescaler */
+#define TIM_CCMR_CC2S		(BIT(8) | BIT(9)) /* Capture/compare 2 sel */
+#define TIM_CCMR_IC2PSC		GENMASK(11, 10)	/* Input capture 2 prescaler */
+#define TIM_CCMR_CC1S_TI1	BIT(0)	/* IC1/IC3 selects TI1/TI3 */
+#define TIM_CCMR_CC1S_TI2	BIT(1)	/* IC1/IC3 selects TI2/TI4 */
+#define TIM_CCMR_CC2S_TI2	BIT(8)	/* IC2/IC4 selects TI2/TI4 */
+#define TIM_CCMR_CC2S_TI1	BIT(9)	/* IC2/IC4 selects TI1/TI3 */
 #define TIM_CCER_CC1E	BIT(0)	/* Capt/Comp 1  out Ena    */
 #define TIM_CCER_CC1P	BIT(1)	/* Capt/Comp 1  Polarity   */
 #define TIM_CCER_CC1NE	BIT(2)	/* Capt/Comp 1N out Ena    */
 #define TIM_CCER_CC1NP	BIT(3)	/* Capt/Comp 1N Polarity   */
 #define TIM_CCER_CC2E	BIT(4)	/* Capt/Comp 2  out Ena    */
+#define TIM_CCER_CC2P	BIT(5)	/* Capt/Comp 2  Polarity   */
 #define TIM_CCER_CC3E	BIT(8)	/* Capt/Comp 3  out Ena    */
+#define TIM_CCER_CC3P	BIT(9)	/* Capt/Comp 3  Polarity   */
 #define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
+#define TIM_CCER_CC4P	BIT(13)	/* Capt/Comp 4  Polarity   */
 #define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
 #define TIM_BDTR_BKE	BIT(12) /* Break input enable	   */
 #define TIM_BDTR_BKP	BIT(13) /* Break input polarity	   */
-- 
1.9.1
