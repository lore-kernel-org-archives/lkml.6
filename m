Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeCNQkG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:40:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41020 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeCNQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:40:02 -0400
From: Mark Brown <broonie@kernel.org>
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, rf@opensource.wolfsonmicro.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: gpio: Fix some error handling paths in 'gpio_regulator_probe()'" to the regulator tree
In-Reply-To: <20180313203311.11378-1-christophe.jaillet@wanadoo.fr>
Message-Id: <20180314163956.4981B440079@finisterre.ee.mobilebroadband>
Date: Wed, 14 Mar 2018 16:39:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: gpio: Fix some error handling paths in 'gpio_regulator_probe()'

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

>From ed8cffda27dea6fd3dafb3ee881c5a786edac9ca Mon Sep 17 00:00:00 2001
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Date: Tue, 13 Mar 2018 21:33:11 +0100
Subject: [PATCH] regulator: gpio: Fix some error handling paths in
 'gpio_regulator_probe()'

Re-order error handling code and gotos to avoid leaks in error handling
paths.

Fixes: 9f946099fe19 ("regulator: gpio: fix parsing of gpio list")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/gpio-regulator.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 0fce06acfaec..a2eb50719c7b 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -271,8 +271,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	drvdata->desc.name = kstrdup(config->supply_name, GFP_KERNEL);
 	if (drvdata->desc.name == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate supply name\n");
-		ret = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}
 
 	if (config->nr_gpios != 0) {
@@ -292,7 +291,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 				dev_err(&pdev->dev,
 					"Could not obtain regulator setting GPIOs: %d\n",
 					ret);
-			goto err_memstate;
+			goto err_memgpio;
 		}
 	}
 
@@ -303,7 +302,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	if (drvdata->states == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate state data\n");
 		ret = -ENOMEM;
-		goto err_memgpio;
+		goto err_stategpio;
 	}
 	drvdata->nr_states = config->nr_states;
 
@@ -324,7 +323,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	default:
 		dev_err(&pdev->dev, "No regulator type set\n");
 		ret = -EINVAL;
-		goto err_memgpio;
+		goto err_memstate;
 	}
 
 	/* build initial state from gpio init data. */
@@ -361,22 +360,21 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	if (IS_ERR(drvdata->dev)) {
 		ret = PTR_ERR(drvdata->dev);
 		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
-		goto err_stategpio;
+		goto err_memstate;
 	}
 
 	platform_set_drvdata(pdev, drvdata);
 
 	return 0;
 
-err_stategpio:
-	gpio_free_array(drvdata->gpios, drvdata->nr_gpios);
 err_memstate:
 	kfree(drvdata->states);
+err_stategpio:
+	gpio_free_array(drvdata->gpios, drvdata->nr_gpios);
 err_memgpio:
 	kfree(drvdata->gpios);
 err_name:
 	kfree(drvdata->desc.name);
-err:
 	return ret;
 }
 
-- 
2.16.2
