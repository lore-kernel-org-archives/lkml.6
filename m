Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424177AbeE1LoD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423188AbeE1LL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:11:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 164/272] regulator: gpio: Fix some error handling paths in gpio_regulator_probe()
Date: Mon, 28 May 2018 12:03:17 +0200
Message-Id: <20180528100254.594185441@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

[ Upstream commit ed8cffda27dea6fd3dafb3ee881c5a786edac9ca ]

Re-order error handling code and gotos to avoid leaks in error handling
paths.

Fixes: 9f946099fe19 ("regulator: gpio: fix parsing of gpio list")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/gpio-regulator.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -271,8 +271,7 @@ static int gpio_regulator_probe(struct p
 	drvdata->desc.name = kstrdup(config->supply_name, GFP_KERNEL);
 	if (drvdata->desc.name == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate supply name\n");
-		ret = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}
 
 	if (config->nr_gpios != 0) {
@@ -292,7 +291,7 @@ static int gpio_regulator_probe(struct p
 				dev_err(&pdev->dev,
 					"Could not obtain regulator setting GPIOs: %d\n",
 					ret);
-			goto err_memstate;
+			goto err_memgpio;
 		}
 	}
 
@@ -303,7 +302,7 @@ static int gpio_regulator_probe(struct p
 	if (drvdata->states == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate state data\n");
 		ret = -ENOMEM;
-		goto err_memgpio;
+		goto err_stategpio;
 	}
 	drvdata->nr_states = config->nr_states;
 
@@ -324,7 +323,7 @@ static int gpio_regulator_probe(struct p
 	default:
 		dev_err(&pdev->dev, "No regulator type set\n");
 		ret = -EINVAL;
-		goto err_memgpio;
+		goto err_memstate;
 	}
 
 	/* build initial state from gpio init data. */
@@ -361,22 +360,21 @@ static int gpio_regulator_probe(struct p
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
 
