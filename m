Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756602AbeDZOUH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:20:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41952 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756431AbeDZOUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:20:01 -0400
From: Mark Brown <broonie@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Jia Zeng <jia.zeng@mediatek.com>, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Garlic Tseng <garlic.tseng@mediatek.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Jia Zeng <jia.zeng@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: mediatek: add MT7622 AFE support" to the asoc tree
In-Reply-To: <b33ca3ff5775cceb4d0c1795914c359c20f2f6c5.1524628914.git.ryder.lee@mediatek.com>
Message-Id: <E1fBhkd-000456-4S@debutante>
Date: Thu, 26 Apr 2018 15:19:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: add MT7622 AFE support

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

>From bfdc56e54890fd6be05f14c9441c540e649468f7 Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Wed, 25 Apr 2018 12:19:57 +0800
Subject: [PATCH] ASoC: mediatek: add MT7622 AFE support

This patch adds support for the MT7622 AFE which reuses MT2701 driver.

We also introduce the 'struct mt2701_soc_variants' to differentiate
between the SoC generations as there might be other (existing or future)
chips that use the same binding and driver, then being a little more
abstract could help in the long run.

Cc: Jia Zeng <jia.zeng@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Garlic Tseng <garlic.tseng@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../mediatek/mt2701/mt2701-afe-clock-ctrl.c   |  2 +-
 sound/soc/mediatek/mt2701/mt2701-afe-common.h | 11 +++--
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c    | 49 ++++++++++++++-----
 sound/soc/mediatek/mt2701/mt2701-reg.h        |  1 +
 4 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
index d4e6a5ea63f4..1793c8da521f 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
@@ -44,7 +44,7 @@ int mt2701_init_clock(struct mtk_base_afe *afe)
 	}
 
 	/* Get I2S related clocks */
-	for (i = 0; i < MT2701_I2S_NUM; i++) {
+	for (i = 0; i < afe_priv->soc->i2s_num; i++) {
 		struct mt2701_i2s_path *i2s_path = &afe_priv->i2s_path[i];
 		struct clk *i2s_ck;
 		char name[13];
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-common.h b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
index 8dabf1913533..1ebac4bcf767 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-common.h
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
@@ -25,7 +25,6 @@
 
 #define MT2701_PLL_DOMAIN_0_RATE	98304000
 #define MT2701_PLL_DOMAIN_1_RATE	90316800
-#define MT2701_I2S_NUM	4
 
 enum {
 	MT2701_MEMIF_DL1,
@@ -100,7 +99,6 @@ struct mt2701_i2s_data {
 };
 
 struct mt2701_i2s_path {
-	int dai_id;
 	int mclk_rate;
 	int on[MTK_STREAM_NUM];
 	int occupied[MTK_STREAM_NUM];
@@ -112,11 +110,18 @@ struct mt2701_i2s_path {
 	struct clk *asrco_ck;
 };
 
+struct mt2701_soc_variants {
+	bool has_one_heart_mode;
+	int i2s_num;
+};
+
 struct mt2701_afe_private {
-	struct mt2701_i2s_path i2s_path[MT2701_I2S_NUM];
+	struct mt2701_i2s_path *i2s_path;
 	struct clk *base_ck[MT2701_BASE_CLK_NUM];
 	struct clk *mrgif_ck;
 	bool mrg_enable[MTK_STREAM_NUM];
+
+	const struct mt2701_soc_variants *soc;
 };
 
 #endif
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 99094a574213..21652db6e6a3 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -21,6 +21,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 
 #include "mt2701-afe-common.h"
@@ -37,7 +38,7 @@ static const struct snd_pcm_hardware mt2701_afe_hardware = {
 	.period_bytes_max = 1024 * 256,
 	.periods_min = 4,
 	.periods_max = 1024,
-	.buffer_bytes_max = 1024 * 1024 * 16,
+	.buffer_bytes_max = 1024 * 1024,
 	.fifo_size = 0,
 };
 
@@ -69,9 +70,10 @@ static const struct mt2701_afe_rate mt2701_afe_i2s_rates[] = {
 
 static int mt2701_dai_num_to_i2s(struct mtk_base_afe *afe, int num)
 {
+	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	int val = num - MT2701_IO_I2S;
 
-	if (val < 0 || val >= MT2701_I2S_NUM) {
+	if (val < 0 || val >= afe_priv->soc->i2s_num) {
 		dev_err(afe->dev, "%s, num not available, num %d, val %d\n",
 			__func__, num, val);
 		return -EINVAL;
@@ -94,12 +96,14 @@ static int mt2701_afe_i2s_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	int i2s_num = mt2701_dai_num_to_i2s(afe, dai->id);
+	bool mode = afe_priv->soc->has_one_heart_mode;
 
 	if (i2s_num < 0)
 		return i2s_num;
 
-	return mt2701_afe_enable_mclk(afe, i2s_num);
+	return mt2701_afe_enable_mclk(afe, mode ? 1 : i2s_num);
 }
 
 static int mt2701_afe_i2s_path_disable(struct mtk_base_afe *afe,
@@ -130,6 +134,7 @@ static void mt2701_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	int i2s_num = mt2701_dai_num_to_i2s(afe, dai->id);
 	struct mt2701_i2s_path *i2s_path;
+	bool mode = afe_priv->soc->has_one_heart_mode;
 
 	if (i2s_num < 0)
 		return;
@@ -149,7 +154,7 @@ static void mt2701_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 
 exit:
 	/* disable mclk */
-	mt2701_afe_disable_mclk(afe, i2s_num);
+	mt2701_afe_disable_mclk(afe, mode ? 1 : i2s_num);
 }
 
 static int mt2701_i2s_path_enable(struct mtk_base_afe *afe,
@@ -157,6 +162,7 @@ static int mt2701_i2s_path_enable(struct mtk_base_afe *afe,
 				  int stream_dir, int rate)
 {
 	const struct mt2701_i2s_data *i2s_data = i2s_path->i2s_data[stream_dir];
+	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	int reg, fs, w_len = 1; /* now we support bck 64bits only */
 	unsigned int mask, val;
 
@@ -180,6 +186,10 @@ static int mt2701_i2s_path_enable(struct mtk_base_afe *afe,
 		val |= ASYS_I2S_IN_PHASE_FIX;
 		reg = ASMI_TIMING_CON1;
 	} else {
+		if (afe_priv->soc->has_one_heart_mode) {
+			mask |= ASYS_I2S_CON_ONE_HEART_MODE;
+			val |= ASYS_I2S_CON_ONE_HEART_MODE;
+		}
 		reg = ASMO_TIMING_CON1;
 	}
 
@@ -212,6 +222,7 @@ static int mt2701_afe_i2s_prepare(struct snd_pcm_substream *substream,
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	int ret, i2s_num = mt2701_dai_num_to_i2s(afe, dai->id);
 	struct mt2701_i2s_path *i2s_path;
+	bool mode = afe_priv->soc->has_one_heart_mode;
 
 	if (i2s_num < 0)
 		return i2s_num;
@@ -221,7 +232,7 @@ static int mt2701_afe_i2s_prepare(struct snd_pcm_substream *substream,
 	if (i2s_path->occupied[substream->stream])
 		return -EBUSY;
 
-	ret = mt2701_mclk_configuration(afe, i2s_num);
+	ret = mt2701_mclk_configuration(afe, mode ? 1 : i2s_num);
 	if (ret)
 		return ret;
 
@@ -244,19 +255,18 @@ static int mt2701_afe_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	int i2s_num = mt2701_dai_num_to_i2s(afe, dai->id);
+	bool mode = afe_priv->soc->has_one_heart_mode;
 
 	if (i2s_num < 0)
 		return i2s_num;
 
 	/* mclk */
 	if (dir == SND_SOC_CLOCK_IN) {
-		dev_warn(dai->dev,
-			 "%s() warning: mt2701 doesn't support mclk input\n",
-			__func__);
+		dev_warn(dai->dev, "The SoCs doesn't support mclk input\n");
 		return -EINVAL;
 	}
 
-	afe_priv->i2s_path[i2s_num].mclk_rate = freq;
+	afe_priv->i2s_path[mode ? 1 : i2s_num].mclk_rate = freq;
 
 	return 0;
 }
@@ -1347,9 +1357,16 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	afe_priv = afe->platform_priv;
+	afe_priv->soc = of_device_get_match_data(&pdev->dev);
 	afe->dev = &pdev->dev;
 	dev = afe->dev;
 
+	afe_priv->i2s_path = devm_kzalloc(dev, afe_priv->soc->i2s_num *
+					  sizeof(struct mt2701_i2s_path),
+					  GFP_KERNEL);
+	if (!afe_priv->i2s_path)
+		return -ENOMEM;
+
 	irq_id = platform_get_irq_byname(pdev, "asys");
 	if (irq_id < 0) {
 		dev_err(dev, "unable to get ASYS IRQ\n");
@@ -1394,7 +1411,7 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		afe->irqs[i].irq_data = &irq_data[i];
 
 	/* I2S initialize */
-	for (i = 0; i < MT2701_I2S_NUM; i++) {
+	for (i = 0; i < afe_priv->soc->i2s_num; i++) {
 		afe_priv->i2s_path[i].i2s_data[SNDRV_PCM_STREAM_PLAYBACK] =
 			&mt2701_i2s_data[i][SNDRV_PCM_STREAM_PLAYBACK];
 		afe_priv->i2s_path[i].i2s_data[SNDRV_PCM_STREAM_CAPTURE] =
@@ -1459,8 +1476,18 @@ static int mt2701_afe_pcm_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mt2701_soc_variants mt2701_soc_v1 = {
+	.i2s_num = 4,
+};
+
+static const struct mt2701_soc_variants mt2701_soc_v2 = {
+	.has_one_heart_mode = true,
+	.i2s_num = 4,
+};
+
 static const struct of_device_id mt2701_afe_pcm_dt_match[] = {
-	{ .compatible = "mediatek,mt2701-audio", },
+	{ .compatible = "mediatek,mt2701-audio", .data = &mt2701_soc_v1 },
+	{ .compatible = "mediatek,mt7622-audio", .data = &mt2701_soc_v2 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mt2701_afe_pcm_dt_match);
diff --git a/sound/soc/mediatek/mt2701/mt2701-reg.h b/sound/soc/mediatek/mt2701/mt2701-reg.h
index 18e676974f22..dbe7d607c566 100644
--- a/sound/soc/mediatek/mt2701/mt2701-reg.h
+++ b/sound/soc/mediatek/mt2701/mt2701-reg.h
@@ -138,6 +138,7 @@
 #define ASYS_I2S_CON_FS_SET(x)		((x) << 8)
 #define ASYS_I2S_CON_RESET		(0x1 << 30)
 #define ASYS_I2S_CON_I2S_EN		(0x1 << 0)
+#define ASYS_I2S_CON_ONE_HEART_MODE	(0x1 << 16)
 #define ASYS_I2S_CON_I2S_COUPLE_MODE	(0x1 << 17)
 /* 0:EIAJ 1:I2S */
 #define ASYS_I2S_CON_I2S_MODE		(0x1 << 3)
-- 
2.17.0
