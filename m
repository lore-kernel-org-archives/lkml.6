Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeBYB4I (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 20:56:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51497 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbeBYB4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 20:56:06 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] pwm: sun4i: properly check current state
Date: Sun, 25 Feb 2018 02:55:58 +0100
Message-Id: <20180225015558.4843-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correctly extract the prescaler value from CTRL_REG before comparing it to
PWM_PRESCAL_MASK.

Also, check that both PWM_CLK_GATING and PWM_EN to ensure the PWM is
enabled instead of relying on only one of those.

Fixes: 93e0dfb2c52f ("pwm: sun4i: Improve hardware read out")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/pwm/pwm-sun4i.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 334199c58f1d..42e6f0873d1c 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -117,7 +117,8 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
-	if ((val == PWM_PRESCAL_MASK) && sun4i_pwm->data->has_prescaler_bypass)
+	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) == PWM_PRESCAL_MASK) &&
+	    sun4i_pwm->data->has_prescaler_bypass)
 		prescaler = 1;
 	else
 		prescaler = prescaler_table[PWM_REG_PRESCAL(val, pwm->hwpwm)];
@@ -130,7 +131,8 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 	else
 		state->polarity = PWM_POLARITY_INVERSED;
 
-	if (val & BIT_CH(PWM_CLK_GATING | PWM_EN, pwm->hwpwm))
+	if ((val & BIT_CH(PWM_CLK_GATING | PWM_EN, pwm->hwpwm)) ==
+	    BIT_CH(PWM_CLK_GATING | PWM_EN, pwm->hwpwm))
 		state->enabled = true;
 	else
 		state->enabled = false;
-- 
2.16.1
