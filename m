Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753768AbeDQNld (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:41:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11320 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753384AbeDQNjl (ORCPT
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
Subject: [PATCH v5 4/6] pwm: stm32: improve capture by tuning counter prescaler
Date: Tue, 17 Apr 2018 15:38:31 +0200
Message-ID: <1523972313-28765-5-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523972313-28765-1-git-send-email-fabrice.gasnier@st.com>
References: <1523972313-28765-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.121]
X-ClientProxiedBy: GPXDAG4NODE6.st.com (10.75.127.76) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, capture is based on timeout window to configure prescaler.
PWM capture framework provides 1s window at the time of writing.

There's place for improvement, after input signal has been captured once:
- Finer tune counter clock prescaler, by using 1st capture result (with
arbitrary margin).
- Do a 2nd capture, with scaled capture window.
This increases accuracy, especially at high rates.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---
Changes in v2:
- Adopt DMA read from MFD core.
---
 drivers/pwm/pwm-stm32.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index ed3961b..9a50acd 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -168,7 +168,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	unsigned long long prd, div, dty;
 	unsigned long rate;
-	unsigned int psc = 0;
+	unsigned int psc = 0, scale;
 	u32 raw_prd, raw_dty;
 	int ret = 0;
 
@@ -219,6 +219,28 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret)
 		goto stop;
 
+	/*
+	 * Got a capture. Try to improve accuracy at high rates:
+	 * - decrease counter clock prescaler, scale up to max rate.
+	 */
+	if (raw_prd) {
+		u32 max_arr = priv->max_arr - 0x1000; /* arbitrary margin */
+
+		scale = max_arr / min(max_arr, raw_prd);
+	} else {
+		scale = priv->max_arr; /* bellow resolution, use max scale */
+	}
+
+	if (psc && scale > 1) {
+		/* 2nd measure with new scale */
+		psc /= scale;
+		regmap_write(priv->regmap, TIM_PSC, psc);
+		ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd,
+					    &raw_dty);
+		if (ret)
+			goto stop;
+	}
+
 	prd = (unsigned long long)raw_prd * (psc + 1) * NSEC_PER_SEC;
 	result->period = DIV_ROUND_UP_ULL(prd, rate);
 	dty = (unsigned long long)raw_dty * (psc + 1) * NSEC_PER_SEC;
-- 
1.9.1
