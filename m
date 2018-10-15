Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2A3C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975A32083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Z6qaBA8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975A32083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeJOTGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:06:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37740 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeJOTGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uCMAcOkRIsElJa3yg0fHtOf0NE95quodMcAh2++lY1s=; b=Z6qaBA8gmgp7
        0B1WQurpstIfySuYip3YJuM1e6h3gl0YgruobZjoPXNkw1iH4iAaK+1coFDT0EGvZKko6UIaZtQtJ
        E1XuhjZCjG62QnO0PtcqtBtTOxbibJCW3mWnjV6sG2o2IYJ3B+6EKPTg/FO41WaHxvlEa1HknI04U
        DSmNw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gC0wh-000368-92; Mon, 15 Oct 2018 11:21:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 041F911224A9; Mon, 15 Oct 2018 12:21:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: Fetch enable gpiods nonexclusive" to the regulator tree
In-Reply-To: 
Message-Id: <20181015112159.041F911224A9@debutante.sirena.org.uk>
Date:   Mon, 15 Oct 2018 12:21:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Fetch enable gpiods nonexclusive

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

From 63239e4bf7eff394d2bcba95999d6e3eae2be6a6 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 15 Oct 2018 11:02:40 +0200
Subject: [PATCH] regulator: Fetch enable gpiods nonexclusive

Since the core regulator code is treating GPIO descriptors as
nonexclusive, i.e. it assumes that the enable GPIO line may be
shared with several regulators, let's add the flag introduced
for fixing this problem on fixed regulators to all drivers
fetching GPIO descriptors to avoid possible regressions.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-ldo1.c       |  2 +-
 drivers/regulator/da9211-regulator.c   | 10 +++++-----
 drivers/regulator/lm363x-regulator.c   |  6 ++++--
 drivers/regulator/lp8788-ldo.c         |  7 ++++---
 drivers/regulator/max8952.c            |  1 +
 drivers/regulator/max8973-regulator.c  |  1 +
 drivers/regulator/s5m8767.c            | 13 +++++++------
 drivers/regulator/tps65090-regulator.c |  1 +
 8 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index e976d073f28d..9a72eae4926d 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -260,7 +260,7 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
 	 * so clean up would happen at the wrong time
 	 */
 	config.ena_gpiod = gpiod_get_optional(parent_dev, "wlf,ldoena",
-					      GPIOD_OUT_LOW);
+				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(config.ena_gpiod))
 		return PTR_ERR(config.ena_gpiod);
 
diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 6c122b3df5d0..8f68c7a05d27 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -294,11 +294,11 @@ static struct da9211_pdata *da9211_parse_regulators_dt(
 		pdata->init_data[n] = da9211_matches[i].init_data;
 		pdata->reg_node[n] = da9211_matches[i].of_node;
 		pdata->gpiod_ren[n] = devm_gpiod_get_from_of_node(dev,
-								  da9211_matches[i].of_node,
-								  "enable",
-								  0,
-								  GPIOD_OUT_HIGH,
-								  "da9211-enable");
+				  da9211_matches[i].of_node,
+				  "enable",
+				  0,
+				  GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+				  "da9211-enable");
 		n++;
 	}
 
diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index b615a413ca9f..bbedb08d257b 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -227,9 +227,11 @@ static struct gpio_desc *lm363x_regulator_of_get_enable_gpio(struct device *dev,
 	 */
 	switch (id) {
 	case LM3632_LDO_POS:
-		return devm_gpiod_get_index_optional(dev, "enable", 0, GPIOD_OUT_LOW);
+		return devm_gpiod_get_index_optional(dev, "enable", 0,
+				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	case LM3632_LDO_NEG:
-		return devm_gpiod_get_index_optional(dev, "enable", 1, GPIOD_OUT_LOW);
+		return devm_gpiod_get_index_optional(dev, "enable", 1,
+				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	default:
 		return NULL;
 	}
diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index f2347474a106..553b4790050f 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -503,9 +503,10 @@ static int lp8788_config_ldo_enable_mode(struct platform_device *pdev,
 
 	/* FIXME: check default mode for GPIO here: high or low? */
 	ldo->ena_gpiod = devm_gpiod_get_index_optional(&pdev->dev,
-						       "enable",
-						       enable_id,
-						       GPIOD_OUT_HIGH);
+					       "enable",
+					       enable_id,
+					       GPIOD_OUT_HIGH |
+					       GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(ldo->ena_gpiod))
 		return PTR_ERR(ldo->ena_gpiod);
 
diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index f1e77ed5dfec..6c39fff73b8a 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -230,6 +230,7 @@ static int max8952_pmic_probe(struct i2c_client *client,
 		gflags = GPIOD_OUT_HIGH;
 	else
 		gflags = GPIOD_OUT_LOW;
+	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 	gpiod = devm_gpiod_get_optional(&client->dev,
 					"max8952,en",
 					gflags);
diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 7cd493ec6315..e7a58b509032 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -758,6 +758,7 @@ static int max8973_probe(struct i2c_client *client,
 			gflags = GPIOD_OUT_HIGH;
 		else
 			gflags = GPIOD_OUT_LOW;
+		gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 		gpiod = devm_gpiod_get_optional(&client->dev,
 						"maxim,enable",
 						gflags);
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 09a97a7093e8..219b9afda0cb 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -571,12 +571,13 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 			continue;
 		}
 
-		rdata->ext_control_gpiod = devm_gpiod_get_from_of_node(&pdev->dev,
-								       reg_np,
-								       "s5m8767,pmic-ext-control-gpios",
-								       0,
-								       GPIOD_OUT_HIGH,
-								       "s5m8767");
+		rdata->ext_control_gpiod = devm_gpiod_get_from_of_node(
+			&pdev->dev,
+			reg_np,
+			"s5m8767,pmic-ext-control-gpios",
+			0,
+			GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+			"s5m8767");
 		if (IS_ERR(rdata->ext_control_gpiod))
 			return PTR_ERR(rdata->ext_control_gpiod);
 
diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index edaef9e4dc74..db714d5edafc 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -374,6 +374,7 @@ static struct tps65090_platform_data *tps65090_parse_dt_reg_data(
 				gflags = GPIOD_OUT_HIGH;
 			else
 				gflags = GPIOD_OUT_LOW;
+			gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
 			rpdata->gpiod = devm_gpiod_get_from_of_node(&pdev->dev,
 								    tps65090_matches[idx].of_node,
-- 
2.19.0.rc2

