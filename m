Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbeDYEUU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:20:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16746 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751377AbeDYEUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:20:16 -0400
X-UUID: bf0919708a2d42bda7661fa5113521bb-20180425
From: Ryder Lee <ryder.lee@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: Garlic Tseng <garlic.tseng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/6] ASoC: mediatek: simplify the control logic of MT2701 I2S
Date: Wed, 25 Apr 2018 12:19:55 +0800
Message-ID: <95304d5edf6f6673dabbcd2da1d05c3c751a7e26.1524628914.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <07e845c2e7eb06c5f284d1bae3acbccba42e48fa.1524628914.git.ryder.lee@mediatek.com>
References: <07e845c2e7eb06c5f284d1bae3acbccba42e48fa.1524628914.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjusts the mt2701_afe_i2s_ops to simplify the control
logic of the I2S path.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c |  39 ++++----
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h |  13 ++-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c        | 114 +++++++---------------
 3 files changed, 66 insertions(+), 100 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
index 949fc3a..565005f 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
+ *	   Ryder Lee <ryder.lee@mediatek.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -102,10 +103,10 @@ int mt2701_init_clock(struct mtk_base_afe *afe)
 	return 0;
 }
 
-int mt2701_afe_enable_i2s(struct mtk_base_afe *afe, int id, int dir)
+int mt2701_afe_enable_i2s(struct mtk_base_afe *afe,
+			  struct mt2701_i2s_path *i2s_path,
+			  int dir)
 {
-	struct mt2701_afe_private *afe_priv = afe->platform_priv;
-	struct mt2701_i2s_path *i2s_path = &afe_priv->i2s_path[id];
 	int ret;
 
 	ret = clk_prepare_enable(i2s_path->asrco_ck);
@@ -128,11 +129,10 @@ int mt2701_afe_enable_i2s(struct mtk_base_afe *afe, int id, int dir)
 	return ret;
 }
 
-void mt2701_afe_disable_i2s(struct mtk_base_afe *afe, int id, int dir)
+void mt2701_afe_disable_i2s(struct mtk_base_afe *afe,
+			    struct mt2701_i2s_path *i2s_path,
+			    int dir)
 {
-	struct mt2701_afe_private *afe_priv = afe->platform_priv;
-	struct mt2701_i2s_path *i2s_path = &afe_priv->i2s_path[id];
-
 	clk_disable_unprepare(i2s_path->hop_ck[dir]);
 	clk_disable_unprepare(i2s_path->asrco_ck);
 }
@@ -272,27 +272,32 @@ int mt2701_afe_disable_clock(struct mtk_base_afe *afe)
 	return 0;
 }
 
-void mt2701_mclk_configuration(struct mtk_base_afe *afe, int id, int domain,
-			       int mclk)
+int mt2701_mclk_configuration(struct mtk_base_afe *afe, int id)
+
 {
 	struct mt2701_afe_private *priv = afe->platform_priv;
 	struct mt2701_i2s_path *i2s_path = &priv->i2s_path[id];
-	int ret;
+	int ret = -EINVAL;
 
 	/* Set mclk source */
-	if (domain == 0)
+	if (!(MT2701_PLL_DOMAIN_0_RATE % i2s_path->mclk_rate))
 		ret = clk_set_parent(i2s_path->sel_ck,
 				     priv->base_ck[MT2701_TOP_AUD_MCLK_SRC0]);
-	else
+	else if (!(MT2701_PLL_DOMAIN_1_RATE % i2s_path->mclk_rate))
 		ret = clk_set_parent(i2s_path->sel_ck,
 				     priv->base_ck[MT2701_TOP_AUD_MCLK_SRC1]);
 
-	if (ret)
-		dev_err(afe->dev, "failed to set domain%d mclk source %d\n",
-			domain, ret);
+	if (ret) {
+		dev_err(afe->dev, "failed to set mclk source\n");
+		return ret;
+	}
 
 	/* Set mclk divider */
-	ret = clk_set_rate(i2s_path->div_ck, mclk);
-	if (ret)
+	ret = clk_set_rate(i2s_path->div_ck, i2s_path->mclk_rate);
+	if (ret) {
 		dev_err(afe->dev, "failed to set mclk divider %d\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
index 15417d9..1957219 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
+ *	   Ryder Lee <ryder.lee@mediatek.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -18,20 +19,24 @@
 #define _MT2701_AFE_CLOCK_CTRL_H_
 
 struct mtk_base_afe;
+struct mt2701_i2s_path;
 
 int mt2701_init_clock(struct mtk_base_afe *afe);
 int mt2701_afe_enable_clock(struct mtk_base_afe *afe);
 int mt2701_afe_disable_clock(struct mtk_base_afe *afe);
 
-int mt2701_afe_enable_i2s(struct mtk_base_afe *afe, int id, int dir);
-void mt2701_afe_disable_i2s(struct mtk_base_afe *afe, int id, int dir);
+int mt2701_afe_enable_i2s(struct mtk_base_afe *afe,
+			  struct mt2701_i2s_path *path,
+			  int dir);
+void mt2701_afe_disable_i2s(struct mtk_base_afe *afe,
+			    struct mt2701_i2s_path *path,
+			    int dir);
 int mt2701_afe_enable_mclk(struct mtk_base_afe *afe, int id);
 void mt2701_afe_disable_mclk(struct mtk_base_afe *afe, int id);
 
 int mt2701_enable_btmrg_clk(struct mtk_base_afe *afe);
 void mt2701_disable_btmrg_clk(struct mtk_base_afe *afe);
 
-void mt2701_mclk_configuration(struct mtk_base_afe *afe, int id, int domain,
-			       int mclk);
+int mt2701_mclk_configuration(struct mtk_base_afe *afe, int id);
 
 #endif
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 8219f55..2a161f4 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -3,7 +3,8 @@
  *
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Garlic Tseng <garlic.tseng@mediatek.com>
- *             Ir Lian <ir.lian@mediatek.com>
+ *	   Ir Lian <ir.lian@mediatek.com>
+ *	   Ryder Lee <ryder.lee@mediatek.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -101,31 +102,15 @@ static int mt2701_afe_i2s_startup(struct snd_pcm_substream *substream,
 	return mt2701_afe_enable_mclk(afe, i2s_num);
 }
 
-static int mt2701_afe_i2s_path_shutdown(struct snd_pcm_substream *substream,
-					struct snd_soc_dai *dai,
-					int i2s_num,
-					int dir_invert)
+static int mt2701_afe_i2s_path_disable(struct mtk_base_afe *afe,
+				       struct mt2701_i2s_path *i2s_path,
+				       int stream_dir)
 {
-	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
-	struct mt2701_afe_private *afe_priv = afe->platform_priv;
-	struct mt2701_i2s_path *i2s_path = &afe_priv->i2s_path[i2s_num];
-	const struct mt2701_i2s_data *i2s_data;
-	int stream_dir = substream->stream;
-
-	if (dir_invert)	{
-		if (stream_dir == SNDRV_PCM_STREAM_PLAYBACK)
-			stream_dir = SNDRV_PCM_STREAM_CAPTURE;
-		else
-			stream_dir = SNDRV_PCM_STREAM_PLAYBACK;
-	}
-	i2s_data = i2s_path->i2s_data[stream_dir];
+	const struct mt2701_i2s_data *i2s_data = i2s_path->i2s_data[stream_dir];
 
-	i2s_path->on[stream_dir]--;
-	if (i2s_path->on[stream_dir] < 0) {
-		dev_warn(afe->dev, "i2s_path->on: %d, dir: %d\n",
-			 i2s_path->on[stream_dir], stream_dir);
+	if (--i2s_path->on[stream_dir] < 0)
 		i2s_path->on[stream_dir] = 0;
-	}
+
 	if (i2s_path->on[stream_dir])
 		return 0;
 
@@ -133,7 +118,7 @@ static int mt2701_afe_i2s_path_shutdown(struct snd_pcm_substream *substream,
 	regmap_update_bits(afe->regmap, i2s_data->i2s_ctrl_reg,
 			   ASYS_I2S_CON_I2S_EN, 0);
 
-	mt2701_afe_disable_i2s(afe, i2s_num, stream_dir);
+	mt2701_afe_disable_i2s(afe, i2s_path, stream_dir);
 
 	return 0;
 }
@@ -154,48 +139,32 @@ static void mt2701_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 	if (i2s_path->occupied[substream->stream])
 		i2s_path->occupied[substream->stream] = 0;
 	else
-		goto I2S_UNSTART;
+		goto exit;
 
-	mt2701_afe_i2s_path_shutdown(substream, dai, i2s_num, 0);
+	mt2701_afe_i2s_path_disable(afe, i2s_path, substream->stream);
 
 	/* need to disable i2s-out path when disable i2s-in */
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		mt2701_afe_i2s_path_shutdown(substream, dai, i2s_num, 1);
+		mt2701_afe_i2s_path_disable(afe, i2s_path, !substream->stream);
 
-I2S_UNSTART:
+exit:
 	/* disable mclk */
 	mt2701_afe_disable_mclk(afe, i2s_num);
 }
 
-static int mt2701_i2s_path_prepare_enable(struct snd_pcm_substream *substream,
-					  struct snd_soc_dai *dai,
-					  int i2s_num,
-					  int dir_invert)
+static int mt2701_i2s_path_enable(struct mtk_base_afe *afe,
+				  struct mt2701_i2s_path *i2s_path,
+				  int stream_dir, int rate)
 {
-	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
-	struct mt2701_afe_private *afe_priv = afe->platform_priv;
-	struct mt2701_i2s_path *i2s_path = &afe_priv->i2s_path[i2s_num];
-	const struct mt2701_i2s_data *i2s_data;
-	struct snd_pcm_runtime * const runtime = substream->runtime;
+	const struct mt2701_i2s_data *i2s_data = i2s_path->i2s_data[stream_dir];
 	int reg, fs, w_len = 1; /* now we support bck 64bits only */
-	int stream_dir = substream->stream;
 	unsigned int mask, val;
 
-	if (dir_invert) {
-		if (stream_dir == SNDRV_PCM_STREAM_PLAYBACK)
-			stream_dir = SNDRV_PCM_STREAM_CAPTURE;
-		else
-			stream_dir = SNDRV_PCM_STREAM_PLAYBACK;
-	}
-	i2s_data = i2s_path->i2s_data[stream_dir];
-
 	/* no need to enable if already done */
-	i2s_path->on[stream_dir]++;
-
-	if (i2s_path->on[stream_dir] != 1)
+	if (++i2s_path->on[stream_dir] != 1)
 		return 0;
 
-	fs = mt2701_afe_i2s_fs(runtime->rate);
+	fs = mt2701_afe_i2s_fs(rate);
 
 	mask = ASYS_I2S_CON_FS |
 	       ASYS_I2S_CON_I2S_COUPLE_MODE | /* 0 */
@@ -209,22 +178,20 @@ static int mt2701_i2s_path_prepare_enable(struct snd_pcm_substream *substream,
 	if (stream_dir == SNDRV_PCM_STREAM_CAPTURE) {
 		mask |= ASYS_I2S_IN_PHASE_FIX;
 		val |= ASYS_I2S_IN_PHASE_FIX;
+		reg = ASMI_TIMING_CON1;
+	} else {
+		reg = ASMO_TIMING_CON1;
 	}
 
 	regmap_update_bits(afe->regmap, i2s_data->i2s_ctrl_reg, mask, val);
 
-	if (stream_dir == SNDRV_PCM_STREAM_PLAYBACK)
-		reg = ASMO_TIMING_CON1;
-	else
-		reg = ASMI_TIMING_CON1;
-
 	regmap_update_bits(afe->regmap, reg,
 			   i2s_data->i2s_asrc_fs_mask
 			   << i2s_data->i2s_asrc_fs_shift,
 			   fs << i2s_data->i2s_asrc_fs_shift);
 
 	/* enable i2s */
-	mt2701_afe_enable_i2s(afe, i2s_num, stream_dir);
+	mt2701_afe_enable_i2s(afe, i2s_path, stream_dir);
 
 	/* reset i2s hw status before enable */
 	regmap_update_bits(afe->regmap, i2s_data->i2s_ctrl_reg,
@@ -241,43 +208,32 @@ static int mt2701_i2s_path_prepare_enable(struct snd_pcm_substream *substream,
 static int mt2701_afe_i2s_prepare(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
-	int clk_domain;
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
-	int i2s_num = mt2701_dai_num_to_i2s(afe, dai->id);
+	int ret, i2s_num = mt2701_dai_num_to_i2s(afe, dai->id);
 	struct mt2701_i2s_path *i2s_path;
-	int mclk_rate;
 
 	if (i2s_num < 0)
 		return i2s_num;
 
 	i2s_path = &afe_priv->i2s_path[i2s_num];
-	mclk_rate = i2s_path->mclk_rate;
 
 	if (i2s_path->occupied[substream->stream])
 		return -EBUSY;
+
+	ret = mt2701_mclk_configuration(afe, i2s_num);
+	if (ret)
+		return ret;
+
 	i2s_path->occupied[substream->stream] = 1;
 
-	if (MT2701_PLL_DOMAIN_0_RATE % mclk_rate == 0) {
-		clk_domain = 0;
-	} else if (MT2701_PLL_DOMAIN_1_RATE % mclk_rate == 0) {
-		clk_domain = 1;
-	} else {
-		dev_err(dai->dev, "%s() bad mclk rate %d\n",
-			__func__, mclk_rate);
-		return -EINVAL;
-	}
-	mt2701_mclk_configuration(afe, i2s_num, clk_domain, mclk_rate);
+	/* need to enable i2s-out path when enable i2s-in */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		mt2701_i2s_path_enable(afe, i2s_path, !substream->stream,
+				       substream->runtime->rate);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		mt2701_i2s_path_prepare_enable(substream, dai, i2s_num, 0);
-	} else {
-		/* need to enable i2s-out path when enable i2s-in */
-		/* prepare for another direction "out" */
-		mt2701_i2s_path_prepare_enable(substream, dai, i2s_num, 1);
-		/* prepare for "in" */
-		mt2701_i2s_path_prepare_enable(substream, dai, i2s_num, 0);
-	}
+	mt2701_i2s_path_enable(afe, i2s_path, substream->stream,
+			       substream->runtime->rate);
 
 	return 0;
 }
-- 
1.9.1
