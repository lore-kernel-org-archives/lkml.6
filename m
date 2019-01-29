Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4F6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E9020869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cu6xwnVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfA2KcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:32:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38002 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfA2KcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:32:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so14222418lfk.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 02:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V5UvtJ3mX5DrioHKtn7NF8k5S+MYyfiW4iemDDngUmk=;
        b=cu6xwnVBbn4OCRaoVmoASeOMq9tuDYqYMI12GrfgklfPYjxz4r/arJ1X/Ndm3JI52A
         SavJr5iJpKgy8zIaVtLZb5t3Q+F85O7W5qyr/nBeYV2zmFO3poZP5h6I9Qd55rdB0J+r
         inJvZAWGbvmJkNmLvAtl5RkD3+1oqKGPWDAVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V5UvtJ3mX5DrioHKtn7NF8k5S+MYyfiW4iemDDngUmk=;
        b=MFec7UL/xMu0UCVBV2UQje0332uRB4OOrBybha3tTn3mm3b06NniPF9CEq4MVPlIWc
         KMfnV0rWkdnHW6fMPxt+r6r0iT1bDJyIiO0C3B8e32Vvkgak/34n60WXh3jD5JJA9EmT
         KxgLne/iPctpH5ry4Auq2J7hOyxdRaljgg7/fEPbSuCTPqAuQ4LyEPkROVmN0cprCeU6
         8bNsghBwrwv7Xuvkwj6YA9yuuoXtNxcVX4/0Q0TojSuKgFiipT3WRAy0NEzxtRnlVMG4
         vE73fyn/RPpvCtW06Hup7K0AC+OsLSujRT+Q05EZ9J7OfHB3NhSoBv5lDi6QEVvy3LTo
         c3CQ==
X-Gm-Message-State: AJcUukd+tRMl6P8hxFhWrtmSka19yeLjDomW5Lxk6c+rDL+lVPt3LGDG
        tbhlb9XbFZ6YX0CB4/L7Xv7nsw==
X-Google-Smtp-Source: ALg8bN7WxmQHYIEJMmaOLwmsVYwt+36N0cxYrLzGmWd5bP+LlAk2F6+MFNPNT+Ieq9GEuvQqmCGLlQ==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr20829827lfg.13.1548757931492;
        Tue, 29 Jan 2019 02:32:11 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id y9sm3471540lfe.75.2019.01.29.02.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 02:32:10 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5 v10] regulator: gpio: Simplify probe path
Date:   Tue, 29 Jan 2019 11:31:55 +0100
Message-Id: <20190129103156.10139-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129103156.10139-1-linus.walleij@linaro.org>
References: <20190129103156.10139-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_* managed device resources and create a local
struct device *dev variable to simplify the code inside
probe().

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v9->v10:
- Properly change &pdev->dev to local dev pointer in this patch,
  this was acccidentally exploited in patch 1.
- Rebase on other changes.
ChangeLog v8->v9:
- Rebased on other changes.
- Collected Marek's Tested-by.
ChangeLog v7->v8:
- Rebase on v5.0-rc1.
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
 drivers/regulator/gpio-regulator.c | 58 +++++++++++++-----------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 07fb41abd4e8..6157001df0a4 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -228,37 +228,38 @@ static struct regulator_ops gpio_regulator_current_ops = {
 
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
 
-	drvdata->gpiods = devm_kzalloc(&pdev->dev, sizeof(struct gpio_desc *),
+	drvdata->gpiods = devm_kzalloc(dev, sizeof(struct gpio_desc *),
 				       GFP_KERNEL);
 	if (!drvdata->gpiods)
 		return -ENOMEM;
 	for (i = 0; i < config->ngpios; i++) {
-		drvdata->gpiods[i] = devm_gpiod_get_index(&pdev->dev,
+		drvdata->gpiods[i] = devm_gpiod_get_index(dev,
 							  NULL,
 							  i,
 							  config->gflags[i]);
@@ -269,14 +270,14 @@ static int gpio_regulator_probe(struct platform_device *pdev)
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
 
@@ -295,9 +296,8 @@ static int gpio_regulator_probe(struct platform_device *pdev)
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
@@ -308,7 +308,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	}
 	drvdata->state = state;
 
-	cfg.dev = &pdev->dev;
+	cfg.dev = dev;
 	cfg.init_data = config->init_data;
 	cfg.driver_data = drvdata;
 	cfg.of_node = np;
@@ -322,28 +322,20 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	else
 		gflags = GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-	cfg.ena_gpiod = gpiod_get_optional(&pdev->dev, "enable", gflags);
-	if (IS_ERR(cfg.ena_gpiod)) {
-		ret = PTR_ERR(cfg.ena_gpiod);
-		goto err_memstate;
-	}
+	cfg.ena_gpiod = gpiod_get_optional(dev, "enable", gflags);
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
@@ -351,8 +343,6 @@ static int gpio_regulator_remove(struct platform_device *pdev)
 	struct gpio_regulator_data *drvdata = platform_get_drvdata(pdev);
 
 	regulator_unregister(drvdata->dev);
-	kfree(drvdata->states);
-	kfree(drvdata->desc.name);
 
 	return 0;
 }
-- 
2.20.1

