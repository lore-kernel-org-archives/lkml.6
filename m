Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B331C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51577205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="sqSmm5mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51577205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966585AbeFSPY7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:24:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39094 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965878AbeFSPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Syte+WlMlTsrX/qZ5pT7jrkwaHvyHFO02GBgVQPhjt8=; b=sqSmm5mpdUBT
        LYjMG82S42ekT2F5Y15l+c8eNn9NlN2ATxWaKUwy8UxNQI6oJ39PMDHZn6Ts+WtVANDZN0CDHLF7v
        /AXmdnaiXjKJEuEq5S4MWdPHBFKpptMP2GvIWhhphQdNvaIBkagqxgDP0yrRoiN/6d5BzNaZX0vpv
        StFwI=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVIV4-0001M9-9V; Tue, 19 Jun 2018 15:24:54 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVIV3-0002US-Qt; Tue, 19 Jun 2018 16:24:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, hias@horus.com, lgirdwood@gmail.com,
        linus.walleij@linaro.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: arizona-ldo1: Use correct device to get enable GPIO" to the regulator tree
In-Reply-To:  <20180619151000.21693-1-ckeepax@opensource.cirrus.com>
Message-Id: <E1fVIV3-0002US-Qt@debutante>
Date:   Tue, 19 Jun 2018 16:24:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: arizona-ldo1: Use correct device to get enable GPIO

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

From a9191579ba1086d91842199263e6fe6bb5eec1ba Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 19 Jun 2018 16:10:00 +0100
Subject: [PATCH] regulator: arizona-ldo1: Use correct device to get enable
 GPIO

Currently the enable GPIO is being looked up on the regulator
device itself but that does not have its own DT node, this causes
the lookup to fail and the regulator not to get its GPIO. The DT
node is shared across the whole MFD and as such the lookup needs
to happen on that parent device. Moving the lookup to the parent
device also means devres can no longer be used as the life time
would attach to the wrong device.

Additionally, the enable GPIO is active high so we should be passing
GPIOD_OUT_LOW to ensure the regulator starts in its off state allowing
the driver to enable it when it is ready.

Fixes: e1739e86f0cb ("regulator: arizona-ldo1: Look up a descriptor and pass to the core")
Reported-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-ldo1.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index f6d6a4ad9e8a..e976d073f28d 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -36,6 +36,8 @@ struct arizona_ldo1 {
 
 	struct regulator_consumer_supply supply;
 	struct regulator_init_data init_data;
+
+	struct gpio_desc *ena_gpiod;
 };
 
 static int arizona_ldo1_hc_list_voltage(struct regulator_dev *rdev,
@@ -253,12 +255,17 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
 		}
 	}
 
-	/* We assume that high output = regulator off */
-	config.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, "wlf,ldoena",
-						   GPIOD_OUT_HIGH);
+	/* We assume that high output = regulator off
+	 * Don't use devm, since we need to get against the parent device
+	 * so clean up would happen at the wrong time
+	 */
+	config.ena_gpiod = gpiod_get_optional(parent_dev, "wlf,ldoena",
+					      GPIOD_OUT_LOW);
 	if (IS_ERR(config.ena_gpiod))
 		return PTR_ERR(config.ena_gpiod);
 
+	ldo1->ena_gpiod = config.ena_gpiod;
+
 	if (pdata->init_data)
 		config.init_data = pdata->init_data;
 	else
@@ -276,6 +283,9 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
 	of_node_put(config.of_node);
 
 	if (IS_ERR(ldo1->regulator)) {
+		if (config.ena_gpiod)
+			gpiod_put(config.ena_gpiod);
+
 		ret = PTR_ERR(ldo1->regulator);
 		dev_err(&pdev->dev, "Failed to register LDO1 supply: %d\n",
 			ret);
@@ -334,8 +344,19 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int arizona_ldo1_remove(struct platform_device *pdev)
+{
+	struct arizona_ldo1 *ldo1 = platform_get_drvdata(pdev);
+
+	if (ldo1->ena_gpiod)
+		gpiod_put(ldo1->ena_gpiod);
+
+	return 0;
+}
+
 static struct platform_driver arizona_ldo1_driver = {
 	.probe = arizona_ldo1_probe,
+	.remove = arizona_ldo1_remove,
 	.driver		= {
 		.name	= "arizona-ldo1",
 	},
-- 
2.17.1

