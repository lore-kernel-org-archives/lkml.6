Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BBCC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1042D21546
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="MMl7YSDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1042D21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHBSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:12:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39846 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeHBSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=97QsY1vM6zmvpQMZGW4h4JiEbHGlHNpXFdieZNFiNsI=; b=MMl7YSDQsk9O
        SY/Ty31ITJC24bt5+X7RsiWGxFSWfA/FTWSQjVr+iBX53hHP138y5ZWAzmOWpobFKxDq9+Uni0vaU
        YamE310am40toYMJvErc/3NK21/WTgh2+cUZBHJS8azf61fFqH4PyrjvZ71xSlSg7H2Y8DTS/vxQS
        dBiZ0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flGLR-0002B3-Fp; Thu, 02 Aug 2018 16:20:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3C32E1121BE5; Thu,  2 Aug 2018 17:20:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        stefan.wahren@i2se.com, bgoswami@codeaurora.org,
        guillaume.tucker@collabora.com, linux-kernel@vger.kernel.org,
        tiwai@suse.com, vkoul@kernel.org, rohitkr@codeaurora.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: smd845: remove auto rebinding" to the asoc tree
In-Reply-To:  <20180802150338.24538-3-srinivas.kandagatla@linaro.org>
Message-Id: <20180802162057.3C32E1121BE5@debutante.sirena.org.uk>
Date:   Thu,  2 Aug 2018 17:20:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: smd845: remove auto rebinding

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

From 62121debfb31a8700e387bd2987779b3a98bc520 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 2 Aug 2018 16:03:37 +0100
Subject: [PATCH] ASoC: smd845: remove auto rebinding

Remove auto rebinding support, as component framework can deadlock
in few usecases if we are trying to add new/remove component within
a bind/unbind callbacks.

Card rebinding is ASoC core feature so all the previous component
framework stuff in q6dsp remains removed.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index bf4ec4646906..be0cb1122036 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -226,7 +226,6 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card->dev = dev;
-	card->auto_bind = true;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
 	if (ret) {
@@ -258,7 +257,6 @@ static int sdm845_snd_platform_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = dev_get_drvdata(&pdev->dev);
 	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
 
-	card->auto_bind = false;
 	snd_soc_unregister_card(card);
 	kfree(card->dai_link);
 	kfree(data);
-- 
2.18.0

