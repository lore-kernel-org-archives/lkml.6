Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC04C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC732087A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UK/JftDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC732087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeKSRgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 12:36:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36059 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeKSRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 12:36:42 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so1748248lfg.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 23:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+3HHA2utaAOxxvaeBViU6uUuc9KWnMizwi/QFCDndE=;
        b=UK/JftDz+v2wFpUjHxntmp6dYZ7V7+B+3gDnJjFatuJdvxvVbVz/4tv19pshN8Jd/z
         mAeBfhfBDlSJK5jMC4xVAUyuKXZg1HoPARR6/ZSbEI79iljdL7U+EGp3YhN8u/RS069O
         fMx2JJXwkmLbKF2CbLv8xo+HBbFnS511AqvSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+3HHA2utaAOxxvaeBViU6uUuc9KWnMizwi/QFCDndE=;
        b=bM0PbJtZUp9lmc3eBo5qoJPi6pDQjK+evK5HIPXtHpPpkCF/2LrftXPIAPAnJEiMG3
         FUazHvzRokeRtxRHbt7/PmgVJ3Ek59E1X8Ho2gWk3P0uguu1xSi5t8tLF8QHdUbCmyWV
         rQtmjvewRO0bp16YsL0mhlwS8/uU2C0s0qCsceZQDpjWj33i3mSlK6iw8P9yyXn2zecJ
         PTtnBPM/EihMrWj6o1gHyRabOhsolB1WEfBnyXxVB1U8ZZWQ0q92b4cZfIZ+RlxYEbGb
         jh0bR3R6gY0dlBFd/n34ZJYKbdvfUbAMJCetUZVE3IH/uhh3uoCyUPaRGuv/S0BF0H65
         c48w==
X-Gm-Message-State: AGRZ1gIB9E5CTaFf6twmZyA4MvjRr1aXoZN19j1xO7mizi0zrg2pRICV
        pSIce1AjIEldpT0/kyuLsA5Geg==
X-Google-Smtp-Source: AJdET5cOV/Nk+falAMofSpukBrLmQA9rXMlL60EXp1AiBbb4dj6xx+m9wWAQhI6qshhXy5uR9IpuUw==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr9603189lfe.154.1542611635934;
        Sun, 18 Nov 2018 23:13:55 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 10sm5531584lff.62.2018.11.18.23.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 23:13:54 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5 v7] regulator: gpio: Simplify probe path
Date:   Mon, 19 Nov 2018 08:11:25 +0100
Message-Id: <20181119071126.8889-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119071126.8889-1-linus.walleij@linaro.org>
References: <20181119071126.8889-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_* managed device resources and create a local
struct device *dev variable to simplify the code inside
probe().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- Resend with the rest.
ChangeLog v3->v6:
- Rebase on top of the other changes.
- Change numbering to fit the rest of the series.
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
---
 drivers/regulator/gpio-regulator.c | 55 +++++++++++++-----------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 68a6c861bcad..62ddea4a5255 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -228,31 +228,33 @@ static struct regulator_ops gpio_regulator_current_ops = {
 
 static int gpio_regulator_probe(struct platform_device *pdev)
 {
-	struct gpio_regulator_config *config = dev_get_platdata(&pdev->dev);
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct gpio_regulator_config *config = dev_get_platdata(dev);
+	struct device_node *np = dev->of_node;
 	struct gpio_regulator_data *drvdata;
 	struct regulator_config cfg = { };
 	enum gpiod_flags gflags;
 	int ptr, ret, state, i;
 
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gpio_regulator_data),
+	drvdata = devm_kzalloc(dev, sizeof(struct gpio_regulator_data),
 			       GFP_KERNEL);
 	if (drvdata == NULL)
 		return -ENOMEM;
 
 	if (np) {
-		config = of_get_gpio_regulator_config(&pdev->dev, np,
+		config = of_get_gpio_regulator_config(dev, np,
 						      &drvdata->desc);
 		if (IS_ERR(config))
 			return PTR_ERR(config);
 	}
 
-	drvdata->desc.name = kstrdup(config->supply_name, GFP_KERNEL);
+	drvdata->desc.name = devm_kstrdup(dev, config->supply_name, GFP_KERNEL);
 	if (drvdata->desc.name == NULL) {
-		dev_err(&pdev->dev, "Failed to allocate supply name\n");
+		dev_err(dev, "Failed to allocate supply name\n");
 		return -ENOMEM;
 	}
 
+
 	for (i = 0; i < config->ngpios; i++) {
 		drvdata->gpiods[i] = devm_gpiod_get_index(&pdev->dev,
 							  NULL,
@@ -265,14 +267,14 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	}
 	drvdata->nr_gpios = config->ngpios;
 
-	drvdata->states = kmemdup(config->states,
-				  config->nr_states *
-					 sizeof(struct gpio_regulator_state),
-				  GFP_KERNEL);
+	drvdata->states = devm_kmemdup(dev,
+				       config->states,
+				       config->nr_states *
+				       sizeof(struct gpio_regulator_state),
+				       GFP_KERNEL);
 	if (drvdata->states == NULL) {
-		dev_err(&pdev->dev, "Failed to allocate state data\n");
-		ret = -ENOMEM;
-		goto err_name;
+		dev_err(dev, "Failed to allocate state data\n");
+		return -ENOMEM;
 	}
 	drvdata->nr_states = config->nr_states;
 
@@ -291,9 +293,8 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 		drvdata->desc.ops = &gpio_regulator_current_ops;
 		break;
 	default:
-		dev_err(&pdev->dev, "No regulator type set\n");
-		ret = -EINVAL;
-		goto err_memstate;
+		dev_err(dev, "No regulator type set\n");
+		return -EINVAL;
 	}
 
 	/* build initial state from gpio init data. */
@@ -304,7 +305,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	}
 	drvdata->state = state;
 
-	cfg.dev = &pdev->dev;
+	cfg.dev = dev;
 	cfg.init_data = config->init_data;
 	cfg.driver_data = drvdata;
 	cfg.of_node = np;
@@ -318,28 +319,20 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	else
 		gflags = GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, "enable", gflags);
-	if (IS_ERR(cfg.ena_gpiod)) {
-		ret = PTR_ERR(cfg.ena_gpiod);
-		goto err_memstate;
-	}
+	cfg.ena_gpiod = devm_gpiod_get_optional(dev, "enable", gflags);
+	if (IS_ERR(cfg.ena_gpiod))
+		return PTR_ERR(cfg.ena_gpiod);
 
 	drvdata->dev = regulator_register(&drvdata->desc, &cfg);
 	if (IS_ERR(drvdata->dev)) {
 		ret = PTR_ERR(drvdata->dev);
-		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
-		goto err_memstate;
+		dev_err(dev, "Failed to register regulator: %d\n", ret);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, drvdata);
 
 	return 0;
-
-err_memstate:
-	kfree(drvdata->states);
-err_name:
-	kfree(drvdata->desc.name);
-	return ret;
 }
 
 static int gpio_regulator_remove(struct platform_device *pdev)
@@ -347,8 +340,6 @@ static int gpio_regulator_remove(struct platform_device *pdev)
 	struct gpio_regulator_data *drvdata = platform_get_drvdata(pdev);
 
 	regulator_unregister(drvdata->dev);
-	kfree(drvdata->states);
-	kfree(drvdata->desc.name);
 
 	return 0;
 }
-- 
2.19.1

