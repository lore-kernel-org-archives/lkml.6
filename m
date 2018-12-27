Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D991C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA9D206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ROSwoVLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeL0SOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 13:14:03 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:54144 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeL0SN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 13:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1545934433; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tvg5NYv2KfhsgpcwP73qCc6BGOXRB7OQU/Tcxbg/f7I=;
        b=ROSwoVLPbQafbEBT11URSUvMYbr22mTUASxngOSLSzkdTZgvFRwY6kmZvJfwOdWKFaYHzD
        t0W8bRV/uAbmco0QJuSpsbPPV0VHCG795zwBF8eerGrRuAfMXUCYWLmy6r1mPDaFuXZUC6
        XjQcAlBCy693PZS/YJx4BqrWCmTXqqQ=
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
Subject: [PATCH v9 13/27] pwm: jz4740: Use clocks from TCU driver
Date:   Thu, 27 Dec 2018 19:13:05 +0100
Message-Id: <20181227181319.31095-14-paul@crapouillou.net>
In-Reply-To: <20181227181319.31095-1-paul@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ingenic-timer "TCU" driver provides us with clocks, that can be
(un)gated, reparented or reclocked from devicetree, instead of having
these settings hardcoded in this driver.

While this driver is devicetree-compatible, it is never (as of now)
probed from devicetree, so this change does not introduce a ABI problem
with current devicetree files.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v9: New patch

 drivers/pwm/Kconfig      |  3 ++-
 drivers/pwm/pwm-jz4740.c | 39 ++++++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4ed003bc3d8d..0343f0c1238e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -202,7 +202,8 @@ config PWM_IMX
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
-	select REGMAP
+	depends on COMMON_CLK
+	select INGENIC_TIMER
 	help
 	  Generic PWM framework driver for Ingenic JZ47xx based
 	  machines.
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 8dfac5ffd71c..c6136bd4434b 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -28,7 +28,7 @@
 
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
-	struct clk *clk;
+	struct clk *clks[NUM_PWM];
 	struct regmap *map;
 };
 
@@ -40,6 +40,9 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+	struct clk *clk;
+	char clk_name[16];
+	int ret;
 
 	/*
 	 * Timers 0 and 1 are used for system tasks, so they are unavailable
@@ -48,16 +51,29 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (pwm->hwpwm < 2)
 		return -EBUSY;
 
-	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
+	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
 
+	clk = clk_get(chip->dev, clk_name);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		clk_put(clk);
+		return ret;
+	}
+
+	jz->clks[pwm->hwpwm] = clk;
 	return 0;
 }
 
 static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+	struct clk *clk = jz->clks[pwm->hwpwm];
 
-	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
+	clk_disable_unprepare(clk);
+	clk_put(clk);
 }
 
 static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -92,16 +108,20 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    struct pwm_state *state)
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
+	struct clk *clk = jz4740->clks[pwm->hwpwm],
+		   *parent_clk = clk_get_parent(clk);
+	unsigned long rate, period, duty;
 	unsigned long long tmp;
-	unsigned long period, duty;
 	unsigned int prescaler = 0;
 
-	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
+	rate = clk_get_rate(parent_clk);
+	tmp = (unsigned long long)rate * state->period;
 	do_div(tmp, 1000000000);
 	period = tmp;
 
 	while (period > 0xffff && prescaler < 6) {
 		period >>= 2;
+		rate >>= 2;
 		++prescaler;
 	}
 
@@ -121,10 +141,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
 
-	/* Set clock prescale */
-	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
-			   TCU_TCSR_PRESCALE_MASK,
-			   prescaler << TCU_TCSR_PRESCALE_LSB);
+	clk_set_rate(clk, rate);
 
 	/* Reset counter to 0 */
 	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
@@ -170,10 +187,6 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!jz4740)
 		return -ENOMEM;
 
-	jz4740->clk = devm_clk_get(&pdev->dev, "ext");
-	if (IS_ERR(jz4740->clk))
-		return PTR_ERR(jz4740->clk);
-
 	jz4740->map = dev_get_regmap(dev->parent, NULL);
 	if (!jz4740->map) {
 		dev_err(dev, "regmap not found\n");
-- 
2.11.0

