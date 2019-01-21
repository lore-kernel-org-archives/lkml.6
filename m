Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF4EC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F364621738
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ML0xuO/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfAUJMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:12:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33080 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfAUJMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:12:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so16891295ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tj5Zx2n3TTtSndEoPHrOd/3BWc5mj7qVROmZh++CMwo=;
        b=ML0xuO/8ptyO2ZPo/yG8Nz3nvJ9LSsDScDmCkXzQee/YVnpXNECirx+d1ixFuTwYDp
         lw8OzvHHJ3Szh1YgvrLwyjj1IyE0iXmduNbFhK2BFXkYrsfpJf0eyEgHiAt9nnnBzt65
         E73f+T5B/lu1U6JENvqi07nXhG24oSed7Y86A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tj5Zx2n3TTtSndEoPHrOd/3BWc5mj7qVROmZh++CMwo=;
        b=GSZIYcU6l7jj31ugjcUX8r9md83s2wutVTh0kVzTxUKV12YhAnYvslnBwz1n8vn1P0
         r2purC81FOyvTVZQ404iyqojqR4YfC0CWI7fuKUgBGX1O0awosxS66jckpdSqsSwyZWQ
         rC2rRegWvi7reuWQCfviuXhdTXiNiJOUqgcH9K7djnAI5ZM62LxAL2OJJsTW/VbUpNhj
         rlx8UmwnPhvaPkV2ybqcNnqU56dPuC79ny6yyVQG/x/vD2Ha5yylhlxt88770Qyi84ic
         6XHvMn9OigLwRKRwuZu3HBk3vovV50nZ+I22rIrzEhtdNdCiKgl1wGFRHbVp8CtfpZZQ
         apWA==
X-Gm-Message-State: AJcUukdS4ge6Ru1gX0MzxvEwOyVboqdMfGp3jVoXaKBhfJxol+onZlhv
        0NuZjTGtNPzZ1u9ZpQVZjPAJcw==
X-Google-Smtp-Source: ALg8bN6Ex65e3IFBVc1G1H30ODylUd8oB8b4LgmshMqB/7ur9edXkEqzpiMQ+tGbGN4szdei3q4iVA==
X-Received: by 2002:a2e:5816:: with SMTP id m22-v6mr16720446ljb.177.1548061938888;
        Mon, 21 Jan 2019 01:12:18 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j18-v6sm2131789ljc.52.2019.01.21.01.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 01:12:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5 v9] regulator: gpio: Simplify probe path
Date:   Mon, 21 Jan 2019 10:12:05 +0100
Message-Id: <20190121091206.18239-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121091206.18239-1-linus.walleij@linaro.org>
References: <20190121091206.18239-1-linus.walleij@linaro.org>
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
 drivers/regulator/gpio-regulator.c | 54 ++++++++++++------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 43735704bb87..d1a9f71087da 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -228,28 +228,29 @@ static struct regulator_ops gpio_regulator_current_ops = {
 
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

