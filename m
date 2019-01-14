Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB14AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3D32087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547467664;
	bh=gAFWsG90prNcNsCnlL7V6W+9p1ZGhWyxTI2Nq/ePFxM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zAFcIIjC4maYOhwmSDDfN5UAsD14Iyt91grkS7jfzNo5IWN7Wk6uKcfJxI/5Vkzdk
	 CmZRgc4r3at4AUlwLLhBw31wP2lDxB83GnM6RsCSjMSADxOzfe726a6F00MUTr1MEs
	 QkyOV9H1mLLpsnKg9qYzi1OgYbUvpY8bfEEOW1OQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfANMHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:07:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39254 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANMHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=FuHEKoBycQlAgOHmqMUX8GfxCmMjfcT8CSl7LVKewYs=; b=eKe1j+OhGqr6
        mlrMzZw0+nWNoqRaHXkAiFibBZv4PmtQE/Y54cIYNquBnrF6VTcBln0V0ZwYEmqGDdywOHhMF5y6u
        2HAERZqu1ReSk5fLqVb0y7hPqsNmbWgqXDJ0kL+GG8S6XLkwzvG7wclNoUQjAxpKm0k1ND3Ws4GJt
        qACpk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj11n-0004ud-Nk; Mon, 14 Jan 2019 12:07:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 54D7D1127AD2; Mon, 14 Jan 2019 12:07:39 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: gpio: Simplify probe path" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190114120739.54D7D1127AD2@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 12:07:39 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: gpio: Simplify probe path

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b2a49e03cca82a6becf9b6c28eb89b1104456282 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Jan 2019 17:27:45 +0100
Subject: [PATCH] regulator: gpio: Simplify probe path

Use devm_* managed device resources and create a local
struct device *dev variable to simplify the code inside
probe().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/gpio-regulator.c | 55 +++++++++++++-----------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 0cec163200c8..2d4459d747aa 100644
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
@@ -347,8 +340,6 @@ static int gpio_regulator_remove(struct platform_device *pdev)
 	struct gpio_regulator_data *drvdata = platform_get_drvdata(pdev);
 
 	regulator_unregister(drvdata->dev);
-	kfree(drvdata->states);
-	kfree(drvdata->desc.name);
 
 	return 0;
 }
-- 
2.20.1

