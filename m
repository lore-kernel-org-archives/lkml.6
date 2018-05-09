Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934451AbeEIJMT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:12:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38068 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934085AbeEIJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:12:18 -0400
From: Mark Brown <broonie@kernel.org>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kai Chieh Chuang <kaichieh.chuang@mediatek.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fix return value check in mt6351_codec_driver_probe()" to the asoc tree
In-Reply-To: <1525657185-73163-1-git-send-email-weiyongjun1@huawei.com>
Message-Id: <20180509091150.77D5C44007A@finisterre.ee.mobilebroadband>
Date: Wed,  9 May 2018 10:11:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fix return value check in mt6351_codec_driver_probe()

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

>From aaa730ca3f88f535dc12e2f0ff575f70f516841b Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 7 May 2018 01:39:45 +0000
Subject: [PATCH] ASoC: fix return value check in mt6351_codec_driver_probe()

In case of error, the function dev_get_regmap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/mt6351.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/mt6351.c b/sound/soc/codecs/mt6351.c
index e739f078fec5..f73dcd753584 100644
--- a/sound/soc/codecs/mt6351.c
+++ b/sound/soc/codecs/mt6351.c
@@ -1472,8 +1472,8 @@ static int mt6351_codec_driver_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 
 	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (IS_ERR(priv->regmap))
-		return PTR_ERR(priv->regmap);
+	if (!priv->regmap)
+		return -ENODEV;
 
 	dev_dbg(priv->dev, "%s(), dev name %s\n",
 		__func__, dev_name(&pdev->dev));
-- 
2.17.0
