Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B904AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCA1206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FC/btq9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeL0SPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 13:15:40 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53792 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeL0SN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 13:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1545934435; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=97gZpq5eTpivMWrRpp/HIsXxIT7K2juYtyAs2Sp2NwA=;
        b=FC/btq9jSV6KkMmNyJ3xGzr9nJedrWec15hCHTkfInSksDQ0cCJLdsp5rBqG9OU3QHptA3
        woyKahjJ4cKDHIaO7uDpwNtojEkAE5TTGUxnBnOllPabjcBsOIrdPkSqccfGD+stESJAJd
        p4rQO4Plhq8iJ51WqRV5IkKpcEmImC8=
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
Subject: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock calculation
Date:   Thu, 27 Dec 2018 19:13:06 +0100
Message-Id: <20181227181319.31095-15-paul@crapouillou.net>
In-Reply-To: <20181227181319.31095-1-paul@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous algorithm hardcoded details about how the TCU clocks work.
The new algorithm will use clk_round_rate to find the perfect clock rate
for the PWM channel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v9: New patch

 drivers/pwm/pwm-jz4740.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index c6136bd4434b..dd80a2cf6528 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -110,23 +110,27 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	struct clk *clk = jz4740->clks[pwm->hwpwm],
 		   *parent_clk = clk_get_parent(clk);
-	unsigned long rate, period, duty;
+	unsigned long rate, new_rate, period, duty;
 	unsigned long long tmp;
-	unsigned int prescaler = 0;
 
 	rate = clk_get_rate(parent_clk);
-	tmp = (unsigned long long)rate * state->period;
-	do_div(tmp, 1000000000);
-	period = tmp;
 
-	while (period > 0xffff && prescaler < 6) {
-		period >>= 2;
-		rate >>= 2;
-		++prescaler;
+	for (;;) {
+		tmp = (unsigned long long)rate * state->period;
+		do_div(tmp, 1000000000);
+
+		if (tmp <= 0xffff)
+			break;
+
+		new_rate = clk_round_rate(clk, rate - 1);
+
+		if (new_rate < rate)
+			rate = new_rate;
+		else
+			return -EINVAL;
 	}
 
-	if (prescaler == 6)
-		return -EINVAL;
+	period = tmp;
 
 	tmp = (unsigned long long)period * state->duty_cycle;
 	do_div(tmp, state->period);
-- 
2.11.0

