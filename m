Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EDDC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6C3206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mtMca+Vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6C3206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbeKQNnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:43:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YmXw+5qwOFfrhZuADUXlvCfW+pUDcTW1/SiYg65hgFg=; b=mtMca+VtSBIl
        Q/PoEjSB9H4oY2PxJQ480a60Qcx1qxR3QNZ5JTkiZapBprdP8sEHUrXkxvHsask24RaAuPuGind1J
        gElyzkUGceYSKYaIQqU5flfVq7JVkXnePOa0QQdajDHEoxo4xztopXSb9IkC9WbMsCEI7rPnIcLY4
        8fx5w=;
Received: from [204.239.253.216] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNrGs-0008Ly-0e; Sat, 17 Nov 2018 03:27:46 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1D7A4440078; Sat, 17 Nov 2018 03:27:39 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        oder_chiou@realtek.com, alsa-devel@alsa-project.org,
        tzungbi@chromium.org, Mark Brown <broonie@kernel.org>,
        dgreid@chromium.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt5663: Fix error handling of regulator_set_load" to the asoc tree
In-Reply-To:  <20181116092856.47815-1-cychiang@chromium.org>
Message-Id: <20181117032739.1D7A4440078@finisterre.ee.mobilebroadband>
Date:   Sat, 17 Nov 2018 03:27:39 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5663: Fix error handling of regulator_set_load

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 746dca0aebd4d77adccb76c500a60028a900dabb Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Fri, 16 Nov 2018 17:28:56 +0800
Subject: [PATCH] ASoC: rt5663: Fix error handling of regulator_set_load

The default implementation of regulator_set_load returns
REGULATOR_MODE_NORMAL, which is positive.  [This was a bug which is
being fixed but the change is valid anyway -- bronie]

rt5663_i2c_probe should only do error handling when return value of
regulator_set_load is negative.
In this case, rt5663_i2c_probe should return error.

Also, consolidate err_irq into err_enable.

Fix the missing goto for temporary regmap and rt5663->regmap.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 29c059ed0682..da6647015708 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3525,10 +3525,11 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 	for (i = 0; i < ARRAY_SIZE(rt5663->supplies); i++) {
 		ret = regulator_set_load(rt5663->supplies[i].consumer,
 					 RT5663_SUPPLY_CURRENT_UA);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(&i2c->dev,
-				"Failed to set regulator %s, ret: %d\n",
+				"Failed to set regulator load on %s, ret: %d\n",
 				rt5663->supplies[i].supply, ret);
+			return ret;
 		}
 	}
 
@@ -3546,7 +3547,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(regmap);
 		dev_err(&i2c->dev, "Failed to allocate temp register map: %d\n",
 			ret);
-		return ret;
+		goto err_enable;
 	}
 
 	ret = regmap_read(regmap, RT5663_VENDOR_ID_2, &val);
@@ -3579,7 +3580,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(rt5663->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		return ret;
+		goto err_enable;
 	}
 
 	/* reset and calibrate */
@@ -3689,17 +3690,19 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 			rt5663_dai, ARRAY_SIZE(rt5663_dai));
 
 	if (ret)
-		goto err_irq;
+		goto err_enable;
 
 	return 0;
 
-err_irq:
+
+	/*
+	 * Error after enabling regulators should goto err_enable
+	 * to disable regulators.
+	 */
+err_enable:
 	if (i2c->irq)
 		free_irq(i2c->irq, rt5663);
 
-err_enable:
-	dev_err(&i2c->dev,
-		"%s: Disable regulator after probe error\n", __func__);
 	regulator_bulk_disable(ARRAY_SIZE(rt5663->supplies), rt5663->supplies);
 	return ret;
 }
-- 
2.19.1

