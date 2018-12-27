Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C587C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144A1206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="LHbg0ZPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeL0SQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 13:16:23 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53846 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeL0SNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 13:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1545934430; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zzVSREocJDt2hrM0Cz3swPJ0WiClEOM0ePMHXEtGm24=;
        b=LHbg0ZPx2usY6X9JUIGjn+vFseuv5e1P5rDeBUKwSeG8luOAon7DjEstXU2VBU5qoswFiU
        KiTZcBrobuFumoYJFh6Nsj8a/bTfaLcPPv6A8C/X874Kw+N6EDaMIxLyL0HIEDsr6nH3pH
        ukhIilr1hPWn9fZbs6Oo4PTxRN3M1SM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v9 11/27] pwm: jz4740: Apply configuration atomically
Date:   Thu, 27 Dec 2018 19:13:03 +0100
Message-Id: <20181227181319.31095-12-paul@crapouillou.net>
In-Reply-To: <20181227181319.31095-1-paul@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is cleaner, more future-proof, and incidentally it also fixes the
PWM resetting its config when stopped/started several times.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v9: New patch

 drivers/pwm/pwm-jz4740.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index a7b134af5e04..b2f910413f81 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -83,17 +83,16 @@ static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	jz4740_timer_disable(pwm->hwpwm);
 }
 
-static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			     int duty_ns, int period_ns)
+static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    struct pwm_state *state)
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	unsigned long long tmp;
 	unsigned long period, duty;
 	unsigned int prescaler = 0;
 	uint16_t ctrl;
-	bool is_enabled;
 
-	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * period_ns;
+	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
 	do_div(tmp, 1000000000);
 	period = tmp;
 
@@ -105,16 +104,14 @@ static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (prescaler == 6)
 		return -EINVAL;
 
-	tmp = (unsigned long long)period * duty_ns;
-	do_div(tmp, period_ns);
+	tmp = (unsigned long long)period * state->duty_cycle;
+	do_div(tmp, state->period);
 	duty = period - tmp;
 
 	if (duty >= period)
 		duty = period - 1;
 
-	is_enabled = jz4740_timer_is_enabled(pwm->hwpwm);
-	if (is_enabled)
-		jz4740_pwm_disable(chip, pwm);
+	jz4740_pwm_disable(chip, pwm);
 
 	jz4740_timer_set_count(pwm->hwpwm, 0);
 	jz4740_timer_set_duty(pwm->hwpwm, duty);
@@ -125,18 +122,7 @@ static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
 
-	if (is_enabled)
-		jz4740_pwm_enable(chip, pwm);
-
-	return 0;
-}
-
-static int jz4740_pwm_set_polarity(struct pwm_chip *chip,
-		struct pwm_device *pwm, enum pwm_polarity polarity)
-{
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->pwm);
-
-	switch (polarity) {
+	switch (state->polarity) {
 	case PWM_POLARITY_NORMAL:
 		ctrl &= ~JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
 		break;
@@ -146,16 +132,17 @@ static int jz4740_pwm_set_polarity(struct pwm_chip *chip,
 	}
 
 	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+
+	if (state->enabled)
+		jz4740_pwm_enable(chip, pwm);
+
 	return 0;
 }
 
 static const struct pwm_ops jz4740_pwm_ops = {
 	.request = jz4740_pwm_request,
 	.free = jz4740_pwm_free,
-	.config = jz4740_pwm_config,
-	.set_polarity = jz4740_pwm_set_polarity,
-	.enable = jz4740_pwm_enable,
-	.disable = jz4740_pwm_disable,
+	.apply = jz4740_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.11.0

