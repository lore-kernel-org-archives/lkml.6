Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756376AbeDZLxy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:53:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50372 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755368AbeDZLxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:53:49 -0400
From: Mark Brown <broonie@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Garlic Tseng <garlic.tseng@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: mediatek: use snd_soc_dai_get_drvdata() to get the private data" to the asoc tree
In-Reply-To: <07e845c2e7eb06c5f284d1bae3acbccba42e48fa.1524628914.git.ryder.lee@mediatek.com>
Message-Id: <E1fBfT7-0007jR-Fn@debutante>
Date: Thu, 26 Apr 2018 12:53:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: use snd_soc_dai_get_drvdata() to get the private data

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

>From e4b31b816c472ba5907b01a6f6a1626c1e8d51ef Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Wed, 25 Apr 2018 12:19:54 +0800
Subject: [PATCH] ASoC: mediatek: use snd_soc_dai_get_drvdata() to get the
 private data

Reduce the boilerplate code to retrieve the private data.
No functional change intended.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Garlic Tseng <garlic.tseng@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 20 ++---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 86 ++++++++--------------
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 28 ++-----
 3 files changed, 46 insertions(+), 88 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index c91e5f4cd902..ac61ff3ccbe4 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -44,8 +44,7 @@ int mtk_afe_fe_startup(struct snd_pcm_substream *substream,
 		       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int memif_num = rtd->cpu_dai->id;
 	struct mtk_base_afe_memif *memif = &afe->memif[memif_num];
@@ -107,8 +106,7 @@ void mtk_afe_fe_shutdown(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mtk_base_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
 	int irq_id;
 
@@ -131,8 +129,7 @@ int mtk_afe_fe_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mtk_base_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
 	int msb_at_bit33 = 0;
 	int ret, fs = 0;
@@ -196,8 +193,7 @@ int mtk_afe_fe_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime * const runtime = substream->runtime;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mtk_base_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
 	struct mtk_base_afe_irq *irqs = &afe->irqs[memif->irq_usage];
 	const struct mtk_base_irq_data *irq_data = irqs->irq_data;
@@ -260,8 +256,7 @@ int mtk_afe_fe_prepare(struct snd_pcm_substream *substream,
 		       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd  = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mtk_base_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
 	int hd_audio = 0;
 
@@ -333,7 +328,7 @@ EXPORT_SYMBOL_GPL(mtk_dynamic_irq_release);
 
 int mtk_afe_dai_suspend(struct snd_soc_dai *dai)
 {
-	struct mtk_base_afe *afe = dev_get_drvdata(dai->dev);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct device *dev = afe->dev;
 	struct regmap *regmap = afe->regmap;
 	int i;
@@ -358,7 +353,7 @@ EXPORT_SYMBOL_GPL(mtk_afe_dai_suspend);
 
 int mtk_afe_dai_resume(struct snd_soc_dai *dai)
 {
-	struct mtk_base_afe *afe = dev_get_drvdata(dai->dev);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct device *dev = afe->dev;
 	struct regmap *regmap = afe->regmap;
 	int i = 0;
@@ -383,4 +378,3 @@ EXPORT_SYMBOL_GPL(mtk_afe_dai_resume);
 MODULE_DESCRIPTION("Mediatek simple fe dai operator");
 MODULE_AUTHOR("Garlic Tseng <garlic.tseng@mediatek.com>");
 MODULE_LICENSE("GPL v2");
-
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 73cce33fa439..8219f5534150 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -92,9 +92,7 @@ static int mt2701_afe_i2s_fs(unsigned int sample_rate)
 static int mt2701_afe_i2s_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int i2s_num = mt2701_dai_num_to_i2s(afe, dai->id);
 
 	if (i2s_num < 0)
@@ -108,9 +106,7 @@ static int mt2701_afe_i2s_path_shutdown(struct snd_pcm_substream *substream,
 					int i2s_num,
 					int dir_invert)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	struct mt2701_i2s_path *i2s_path = &afe_priv->i2s_path[i2s_num];
 	const struct mt2701_i2s_data *i2s_data;
@@ -145,9 +141,7 @@ static int mt2701_afe_i2s_path_shutdown(struct snd_pcm_substream *substream,
 static void mt2701_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	int i2s_num = mt2701_dai_num_to_i2s(afe, dai->id);
 	struct mt2701_i2s_path *i2s_path;
@@ -178,16 +172,14 @@ static int mt2701_i2s_path_prepare_enable(struct snd_pcm_substream *substream,
 					  int i2s_num,
 					  int dir_invert)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	struct mt2701_i2s_path *i2s_path = &afe_priv->i2s_path[i2s_num];
 	const struct mt2701_i2s_data *i2s_data;
 	struct snd_pcm_runtime * const runtime = substream->runtime;
 	int reg, fs, w_len = 1; /* now we support bck 64bits only */
 	int stream_dir = substream->stream;
-	unsigned int mask = 0, val = 0;
+	unsigned int mask, val;
 
 	if (dir_invert) {
 		if (stream_dir == SNDRV_PCM_STREAM_PLAYBACK)
@@ -250,9 +242,7 @@ static int mt2701_afe_i2s_prepare(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	int clk_domain;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	int i2s_num = mt2701_dai_num_to_i2s(afe, dai->id);
 	struct mt2701_i2s_path *i2s_path;
@@ -295,7 +285,7 @@ static int mt2701_afe_i2s_prepare(struct snd_pcm_substream *substream,
 static int mt2701_afe_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 				     unsigned int freq, int dir)
 {
-	struct mtk_base_afe *afe = dev_get_drvdata(dai->dev);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	int i2s_num = mt2701_dai_num_to_i2s(afe, dai->id);
 
@@ -309,16 +299,16 @@ static int mt2701_afe_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 			__func__);
 		return -EINVAL;
 	}
+
 	afe_priv->i2s_path[i2s_num].mclk_rate = freq;
+
 	return 0;
 }
 
 static int mt2701_btmrg_startup(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	int ret;
 
@@ -327,6 +317,7 @@ static int mt2701_btmrg_startup(struct snd_pcm_substream *substream,
 		return ret;
 
 	afe_priv->mrg_enable[substream->stream] = 1;
+
 	return 0;
 }
 
@@ -334,17 +325,14 @@ static int mt2701_btmrg_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int stream_fs;
 	u32 val, msk;
 
 	stream_fs = params_rate(params);
 
-	if ((stream_fs != 8000) && (stream_fs != 16000)) {
-		dev_err(afe->dev, "%s() btmgr not support this stream_fs %d\n",
-			__func__, stream_fs);
+	if (stream_fs != 8000 && stream_fs != 16000) {
+		dev_err(afe->dev, "unsupported rate %d\n", stream_fs);
 		return -EINVAL;
 	}
 
@@ -378,9 +366,7 @@ static int mt2701_btmrg_hw_params(struct snd_pcm_substream *substream,
 static void mt2701_btmrg_shutdown(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 
 	/* if the other direction stream is not occupied */
@@ -393,28 +379,26 @@ static void mt2701_btmrg_shutdown(struct snd_pcm_substream *substream,
 				   AFE_MRGIF_CON_MRG_I2S_EN, 0);
 		mt2701_disable_btmrg_clk(afe);
 	}
+
 	afe_priv->mrg_enable[substream->stream] = 0;
 }
 
 static int mt2701_simple_fe_startup(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
-	int stream_dir = substream->stream;
-	int memif_num = rtd->cpu_dai->id;
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mtk_base_afe_memif *memif_tmp;
+	int stream_dir = substream->stream;
 
 	/* can't run single DL & DLM at the same time */
 	if (stream_dir == SNDRV_PCM_STREAM_PLAYBACK) {
 		memif_tmp = &afe->memif[MT2701_MEMIF_DLM];
 		if (memif_tmp->substream) {
-			dev_warn(afe->dev, "%s memif is not available, stream_dir %d, memif_num %d\n",
-				 __func__, stream_dir, memif_num);
+			dev_warn(afe->dev, "memif is not available");
 			return -EBUSY;
 		}
 	}
+
 	return mtk_afe_fe_startup(substream, dai);
 }
 
@@ -422,27 +406,23 @@ static int mt2701_simple_fe_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *params,
 				      struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int stream_dir = substream->stream;
 
 	/* single DL use PAIR_INTERLEAVE */
-	if (stream_dir == SNDRV_PCM_STREAM_PLAYBACK) {
+	if (stream_dir == SNDRV_PCM_STREAM_PLAYBACK)
 		regmap_update_bits(afe->regmap,
 				   AFE_MEMIF_PBUF_SIZE,
 				   AFE_MEMIF_PBUF_SIZE_DLM_MASK,
 				   AFE_MEMIF_PBUF_SIZE_PAIR_INTERLEAVE);
-	}
+
 	return mtk_afe_fe_hw_params(substream, params, dai);
 }
 
 static int mt2701_dlm_fe_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mtk_base_afe_memif *memif_tmp;
 	const struct mtk_base_memif_data *memif_data;
 	int i;
@@ -468,9 +448,7 @@ static int mt2701_dlm_fe_startup(struct snd_pcm_substream *substream,
 static void mt2701_dlm_fe_shutdown(struct snd_pcm_substream *substream,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	const struct mtk_base_memif_data *memif_data;
 	int i;
 
@@ -481,6 +459,7 @@ static void mt2701_dlm_fe_shutdown(struct snd_pcm_substream *substream,
 				   1 << memif_data->agent_disable_shift,
 				   1 << memif_data->agent_disable_shift);
 	}
+
 	return mtk_afe_fe_shutdown(substream, dai);
 }
 
@@ -488,9 +467,7 @@ static int mt2701_dlm_fe_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int channels = params_channels(params);
 
 	regmap_update_bits(afe->regmap,
@@ -512,9 +489,7 @@ static int mt2701_dlm_fe_hw_params(struct snd_pcm_substream *substream,
 static int mt2701_dlm_fe_trigger(struct snd_pcm_substream *substream,
 				 int cmd, struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mtk_base_afe_memif *memif_tmp = &afe->memif[MT2701_MEMIF_DL1];
 
 	switch (cmd) {
@@ -547,6 +522,7 @@ static int mt2701_memif_fs(struct snd_pcm_substream *substream,
 		fs = mt2701_afe_i2s_fs(rate);
 	else
 		fs = (rate == 16000 ? 1 : 0);
+
 	return fs;
 }
 
@@ -1398,10 +1374,12 @@ static irqreturn_t mt2701_asys_isr(int irq_id, void *dev)
 		memif = &afe->memif[id];
 		if (memif->irq_usage < 0)
 			continue;
+
 		irq = &afe->irqs[memif->irq_usage];
-		if (status & 1 << (irq->irq_data->irq_clr_shift))
+		if (status & 1 << irq->irq_data->irq_clr_shift)
 			snd_pcm_period_elapsed(memif->substream);
 	}
+
 	return IRQ_HANDLED;
 }
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 65d1433a0944..22881a9e111e 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -303,9 +303,7 @@ static void mt8173_afe_dais_disable_clks(struct mtk_base_afe *afe,
 static int mt8173_afe_i2s_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 
 	if (dai->active)
 		return 0;
@@ -318,9 +316,7 @@ static int mt8173_afe_i2s_startup(struct snd_pcm_substream *substream,
 static void mt8173_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 
 	if (dai->active)
 		return;
@@ -334,10 +330,8 @@ static void mt8173_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 static int mt8173_afe_i2s_prepare(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime * const runtime = substream->runtime;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8173_afe_private *afe_priv = afe->platform_priv;
 	int ret;
 
@@ -358,9 +352,7 @@ static int mt8173_afe_i2s_prepare(struct snd_pcm_substream *substream,
 static int mt8173_afe_hdmi_startup(struct snd_pcm_substream *substream,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8173_afe_private *afe_priv = afe->platform_priv;
 
 	if (dai->active)
@@ -374,9 +366,7 @@ static int mt8173_afe_hdmi_startup(struct snd_pcm_substream *substream,
 static void mt8173_afe_hdmi_shutdown(struct snd_pcm_substream *substream,
 				     struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8173_afe_private *afe_priv = afe->platform_priv;
 
 	if (dai->active)
@@ -389,10 +379,8 @@ static void mt8173_afe_hdmi_shutdown(struct snd_pcm_substream *substream,
 static int mt8173_afe_hdmi_prepare(struct snd_pcm_substream *substream,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime * const runtime = substream->runtime;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8173_afe_private *afe_priv = afe->platform_priv;
 
 	unsigned int val;
@@ -454,9 +442,7 @@ static int mt8173_afe_hdmi_prepare(struct snd_pcm_substream *substream,
 static int mt8173_afe_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
-	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 
 	dev_info(afe->dev, "%s cmd=%d %s\n", __func__, cmd, dai->name);
 
-- 
2.17.0
