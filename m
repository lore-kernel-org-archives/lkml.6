Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1858BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FE2218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfAVJnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:43:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35640 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfAVJnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:43:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so20029856ljb.2;
        Tue, 22 Jan 2019 01:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJCiTSKlgWA1NZxb4a4B3GlN22qRc+LSKl/cTO9RMBU=;
        b=L+wF0C1Ct6bqv25PaqC5i2dSrpI5h2cKJvUgTJA2ZWpZ1flQAGR5TLL8QNqhaxbIS3
         UsT8RQ/P5Rk76NSUnJrufULGBYxLw2dnN23LLdGYJhkEh+LjiZdnq0QkgeWKrX0XCMaw
         c39/Yp0wYxA7WZ/fpRTgXPO1JnJKh77ZxYRv7R9X4zPJYnp6hKgWuJvdwact2/sht0ay
         bKX91E5Fgk3H1r4ZQHK36HPMDtZHJzLyGEbBJDxilbBSev7khi00M8Fqmy/50EXAT6y5
         Q+3coXnZIOR0TFDLsNvxtZO4YRQ2Dnb68ccK/FH/pKrmN1TZInBKMJUCcO0GG1Pu/pGB
         1XFA==
X-Gm-Message-State: AJcUukfWK3TGVJ80luNLcmeJPgldKVqpjx6eRr51JIrPxY/0WYNadJE8
        Uswacg6NluWGdzqlokRSoTU=
X-Google-Smtp-Source: ALg8bN5mzBhiQ6Oy58cerDMQCaUrX1IhfroskbNHC/lTkBD+0E4pCZTXfloWIT4UWPMsXQ3hzkQXvw==
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr19644390lji.30.1548150222375;
        Tue, 22 Jan 2019 01:43:42 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p23sm2714799lfh.47.2019.01.22.01.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 01:43:41 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:43:28 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [RFC PATCH v1 03/13] regulator: bd718x7 use chip specific and
 generic data structs
Message-ID: <3fb3eab3a8a2767404588d0a0a531273fddfc659.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Header rohm-bd718x7.h was split to generic and component specific
parts. This changed the struct bd718x7. Adapt the regulator driver to
these changes.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index b8dcdc21dc22..dc56ca06ace2 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1018,11 +1018,11 @@ static int bd718xx_probe(struct platform_device *pdev)
 	struct bd718xx *mfd;
 	struct regulator_config config = { 0 };
 	struct bd718xx_pmic_inits pmic_regulators[] = {
-		[BD718XX_TYPE_BD71837] = {
+		[ROHM_CHIP_TYPE_BD71837] = {
 			.r_datas = bd71837_regulators,
 			.r_amount = ARRAY_SIZE(bd71837_regulators),
 		},
-		[BD718XX_TYPE_BD71847] = {
+		[ROHM_CHIP_TYPE_BD71847] = {
 			.r_datas = bd71847_regulators,
 			.r_amount = ARRAY_SIZE(bd71847_regulators),
 		},
@@ -1037,15 +1037,15 @@ static int bd718xx_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	if (mfd->chip_type >= BD718XX_TYPE_AMOUNT ||
-	    !pmic_regulators[mfd->chip_type].r_datas) {
+	if (mfd->chip.chip_type >= ROHM_CHIP_TYPE_AMOUNT ||
+	    !pmic_regulators[mfd->chip.chip_type].r_datas) {
 		dev_err(&pdev->dev, "Unsupported chip type\n");
 		err = -EINVAL;
 		goto err;
 	}
 
 	/* Register LOCK release */
-	err = regmap_update_bits(mfd->regmap, BD718XX_REG_REGLOCK,
+	err = regmap_update_bits(mfd->chip.regmap, BD718XX_REG_REGLOCK,
 				 (REGLOCK_PWRSEQ | REGLOCK_VREG), 0);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to unlock PMIC (%d)\n", err);
@@ -1065,7 +1065,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 	 * for all reset types because OTP loading at READY will clear SEL
 	 * bit allowing HW defaults for power rails to be used
 	 */
-	err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
+	err = regmap_update_bits(mfd->chip.regmap, BD718XX_REG_TRANS_COND1,
 				 BD718XX_ON_REQ_POWEROFF_MASK |
 				 BD718XX_SWRESET_POWEROFF_MASK |
 				 BD718XX_WDOG_POWEROFF_MASK |
@@ -1078,17 +1078,17 @@ static int bd718xx_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "Changed all resets from SVNS to READY\n");
 	}
 
-	for (i = 0; i < pmic_regulators[mfd->chip_type].r_amount; i++) {
+	for (i = 0; i < pmic_regulators[mfd->chip.chip_type].r_amount; i++) {
 
 		const struct regulator_desc *desc;
 		struct regulator_dev *rdev;
 		const struct bd718xx_regulator_data *r;
 
-		r = &pmic_regulators[mfd->chip_type].r_datas[i];
+		r = &pmic_regulators[mfd->chip.chip_type].r_datas[i];
 		desc = &r->desc;
 
 		config.dev = pdev->dev.parent;
-		config.regmap = mfd->regmap;
+		config.regmap = mfd->chip.regmap;
 
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
@@ -1104,7 +1104,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 		 * can now switch the control from PMIC state machine to the
 		 * register interface
 		 */
-		err = regmap_update_bits(mfd->regmap, r->init.reg,
+		err = regmap_update_bits(mfd->chip.regmap, r->init.reg,
 					 r->init.mask, r->init.val);
 		if (err) {
 			dev_err(&pdev->dev,
@@ -1113,7 +1113,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 			goto err;
 		}
 		for (j = 0; j < r->additional_init_amnt; j++) {
-			err = regmap_update_bits(mfd->regmap,
+			err = regmap_update_bits(mfd->chip.regmap,
 						 r->additional_inits[j].reg,
 						 r->additional_inits[j].mask,
 						 r->additional_inits[j].val);
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
