Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeD3MPm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 08:15:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20383 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752768AbeD3MPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 08:15:41 -0400
X-UUID: 45ba2f19fa4447f9ae14e61203fe40b3-20180430
From: Ryder Lee <ryder.lee@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: Garlic Tseng <garlic.tseng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] ASoC: mediatek: add the .probe() callback in mt2701_afe_pcm_dai_component
Date: Mon, 30 Apr 2018 20:15:31 +0800
Message-ID: <2bcfa1a389ff00a00204c2ddf3a94882195fd19d.1525090110.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of uniformity, this patch adds a callback mt2701_afe_pcm_probe()
in mt2701_afe_pcm_dai_component to retrieve the regmap - the canonical way to 
obtain the pointer..

Doing so, we could switch to use devm_snd_soc_register_component() to register
the component driver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 31 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index d6eeb4c..828d11c 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -958,7 +958,17 @@ static int mt2701_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
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
1.9.1
