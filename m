Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeEAVIy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:08:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49942 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeEAVIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:08:52 -0400
From: Mark Brown <broonie@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Garlic Tseng <garlic.tseng@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: mediatek: add the .probe() callback in mt2701_afe_pcm_dai_component" to the asoc tree
In-Reply-To: <2bcfa1a389ff00a00204c2ddf3a94882195fd19d.1525090110.git.ryder.lee@mediatek.com>
Message-Id: <20180501210836.ED3D144007A@finisterre.ee.mobilebroadband>
Date: Tue,  1 May 2018 22:08:36 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: add the .probe() callback in mt2701_afe_pcm_dai_component

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

>From 10abdc7c149a058c74be803f33c9ffb1080ad07e Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Mon, 30 Apr 2018 20:15:31 +0800
Subject: [PATCH] ASoC: mediatek: add the .probe() callback in
 mt2701_afe_pcm_dai_component

For the sake of uniformity, this patch adds a callback mt2701_afe_pcm_probe()
in mt2701_afe_pcm_dai_component to retrieve the regmap - the canonical way to
obtain the pointer..

Doing so, we could switch to use devm_snd_soc_register_component() to register
the component driver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 31 ++++++++++------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index d6eeb4c36fcc..828d11c30c6a 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -958,7 +958,17 @@ static const struct snd_soc_dapm_route mt2701_afe_pcm_routes[] = {
 	{ "O31", "I35 Switch", "I35" },
 };
 
+static int mt2701_afe_pcm_probe(struct snd_soc_component *component)
+{
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+
+	snd_soc_component_init_regmap(component, afe->regmap);
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver mt2701_afe_pcm_dai_component = {
+	.probe = mt2701_afe_pcm_probe,
 	.name = "mt2701-afe-pcm-dai",
 	.dapm_widgets = mt2701_afe_pcm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(mt2701_afe_pcm_widgets),
@@ -1316,22 +1326,6 @@ static int mt2701_afe_runtime_resume(struct device *dev)
 	return mt2701_afe_enable_clock(afe);
 }
 
-static int mt2701_afe_add_component(struct mtk_base_afe *afe)
-{
-	struct snd_soc_component *component;
-
-	component = kzalloc(sizeof(*component), GFP_KERNEL);
-	if (!component)
-		return -ENOMEM;
-
-	component->regmap = afe->regmap;
-
-	return snd_soc_add_component(afe->dev, component,
-				     &mt2701_afe_pcm_dai_component,
-				     mt2701_afe_pcm_dais,
-				     ARRAY_SIZE(mt2701_afe_pcm_dais));
-}
-
 static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct mtk_base_afe *afe;
@@ -1442,7 +1436,10 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		goto err_platform;
 	}
 
-	ret = mt2701_afe_add_component(afe);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					 &mt2701_afe_pcm_dai_component,
+					 mt2701_afe_pcm_dais,
+					 ARRAY_SIZE(mt2701_afe_pcm_dais));
 	if (ret) {
 		dev_warn(dev, "err_dai_component\n");
 		goto err_platform;
-- 
2.17.0
