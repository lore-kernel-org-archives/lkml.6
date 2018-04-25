Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeDYEUM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:20:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40739 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750943AbeDYEUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:20:07 -0400
X-UUID: fd1a5749915b4dd095dffa8d304336c6-20180425
From: Ryder Lee <ryder.lee@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: Garlic Tseng <garlic.tseng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/6] ASoC: mediatek: Add MTK_STREAM_NUM to mtk-base-afe.h
Date: Wed, 25 Apr 2018 12:19:56 +0800
Message-ID: <3b7d64ba9a84651575f69de5bbcbecf42d157250.1524628914.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <07e845c2e7eb06c5f284d1bae3acbccba42e48fa.1524628914.git.ryder.lee@mediatek.com>
References: <07e845c2e7eb06c5f284d1bae3acbccba42e48fa.1524628914.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MTK_STREAM_NUM to common header and modify related stuff so that
the other SoCs can reuse it.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 sound/soc/mediatek/common/mtk-base-afe.h          |  2 +
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c | 15 +++--
 sound/soc/mediatek/mt2701/mt2701-afe-common.h     | 17 ++----
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c        | 67 +++++------------------
 4 files changed, 30 insertions(+), 71 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-base-afe.h b/sound/soc/mediatek/common/mtk-base-afe.h
index 3a78f6f..e50adc9 100644
--- a/sound/soc/mediatek/common/mtk-base-afe.h
+++ b/sound/soc/mediatek/common/mtk-base-afe.h
@@ -17,6 +17,8 @@
 #ifndef _MTK_BASE_AFE_H_
 #define _MTK_BASE_AFE_H_
 
+#define MTK_STREAM_NUM (SNDRV_PCM_STREAM_LAST + 1)
+
 struct mtk_base_memif_data {
 	int id;
 	const char *name;
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
index 565005f..d4e6a5e 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
@@ -46,6 +46,7 @@ int mt2701_init_clock(struct mtk_base_afe *afe)
 	/* Get I2S related clocks */
 	for (i = 0; i < MT2701_I2S_NUM; i++) {
 		struct mt2701_i2s_path *i2s_path = &afe_priv->i2s_path[i];
+		struct clk *i2s_ck;
 		char name[13];
 
 		snprintf(name, sizeof(name), "i2s%d_src_sel", i);
@@ -70,18 +71,20 @@ int mt2701_init_clock(struct mtk_base_afe *afe)
 		}
 
 		snprintf(name, sizeof(name), "i2so%d_hop_ck", i);
-		i2s_path->hop_ck[I2S_OUT] = devm_clk_get(afe->dev, name);
-		if (IS_ERR(i2s_path->hop_ck[I2S_OUT])) {
+		i2s_ck = devm_clk_get(afe->dev, name);
+		if (IS_ERR(i2s_ck)) {
 			dev_err(afe->dev, "failed to get %s\n", name);
-			return PTR_ERR(i2s_path->hop_ck[I2S_OUT]);
+			return PTR_ERR(i2s_ck);
 		}
+		i2s_path->hop_ck[SNDRV_PCM_STREAM_PLAYBACK] = i2s_ck;
 
 		snprintf(name, sizeof(name), "i2si%d_hop_ck", i);
-		i2s_path->hop_ck[I2S_IN] = devm_clk_get(afe->dev, name);
-		if (IS_ERR(i2s_path->hop_ck[I2S_IN])) {
+		i2s_ck = devm_clk_get(afe->dev, name);
+		if (IS_ERR(i2s_ck)) {
 			dev_err(afe->dev, "failed to get %s\n", name);
-			return PTR_ERR(i2s_path->hop_ck[I2S_IN]);
+			return PTR_ERR(i2s_ck);
 		}
+		i2s_path->hop_ck[SNDRV_PCM_STREAM_CAPTURE] = i2s_ck;
 
 		snprintf(name, sizeof(name), "asrc%d_out_ck", i);
 		i2s_path->asrco_ck = devm_clk_get(afe->dev, name);
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-common.h b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
index ae8ddea..8dabf19 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-common.h
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
@@ -23,7 +23,6 @@
 #include "mt2701-reg.h"
 #include "../common/mtk-base-afe.h"
 
-#define MT2701_STREAM_DIR_NUM (SNDRV_PCM_STREAM_LAST + 1)
 #define MT2701_PLL_DOMAIN_0_RATE	98304000
 #define MT2701_PLL_DOMAIN_1_RATE	90316800
 #define MT2701_I2S_NUM	4
@@ -100,19 +99,13 @@ struct mt2701_i2s_data {
 	int i2s_asrc_fs_mask;
 };
 
-enum mt2701_i2s_dir {
-	I2S_OUT,
-	I2S_IN,
-	I2S_DIR_NUM,
-};
-
 struct mt2701_i2s_path {
 	int dai_id;
 	int mclk_rate;
-	int on[I2S_DIR_NUM];
-	int occupied[I2S_DIR_NUM];
-	const struct mt2701_i2s_data *i2s_data[I2S_DIR_NUM];
-	struct clk *hop_ck[I2S_DIR_NUM];
+	int on[MTK_STREAM_NUM];
+	int occupied[MTK_STREAM_NUM];
+	const struct mt2701_i2s_data *i2s_data[MTK_STREAM_NUM];
+	struct clk *hop_ck[MTK_STREAM_NUM];
 	struct clk *sel_ck;
 	struct clk *div_ck;
 	struct clk *mclk_ck;
@@ -123,7 +116,7 @@ struct mt2701_afe_private {
 	struct mt2701_i2s_path i2s_path[MT2701_I2S_NUM];
 	struct clk *base_ck[MT2701_BASE_CLK_NUM];
 	struct clk *mrgif_ck;
-	bool mrg_enable[MT2701_STREAM_DIR_NUM];
+	bool mrg_enable[MTK_STREAM_NUM];
 };
 
 #endif
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 2a161f4..99094a57 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1256,63 +1256,24 @@ static int mt2701_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 	}
 };
 
-static const struct mt2701_i2s_data mt2701_i2s_data[MT2701_I2S_NUM][2] = {
+static const struct mt2701_i2s_data mt2701_i2s_data[][2] = {
 	{
-		{
-			.i2s_ctrl_reg = ASYS_I2SO1_CON,
-			.i2s_asrc_fs_shift = 0,
-			.i2s_asrc_fs_mask = 0x1f,
-
-		},
-		{
-			.i2s_ctrl_reg = ASYS_I2SIN1_CON,
-			.i2s_asrc_fs_shift = 0,
-			.i2s_asrc_fs_mask = 0x1f,
-
-		},
+		{ ASYS_I2SO1_CON, 0, 0x1f },
+		{ ASYS_I2SIN1_CON, 0, 0x1f },
 	},
 	{
-		{
-			.i2s_ctrl_reg = ASYS_I2SO2_CON,
-			.i2s_asrc_fs_shift = 5,
-			.i2s_asrc_fs_mask = 0x1f,
-
-		},
-		{
-			.i2s_ctrl_reg = ASYS_I2SIN2_CON,
-			.i2s_asrc_fs_shift = 5,
-			.i2s_asrc_fs_mask = 0x1f,
-
-		},
+		{ ASYS_I2SO2_CON, 5, 0x1f },
+		{ ASYS_I2SIN2_CON, 5, 0x1f },
 	},
 	{
-		{
-			.i2s_ctrl_reg = ASYS_I2SO3_CON,
-			.i2s_asrc_fs_shift = 10,
-			.i2s_asrc_fs_mask = 0x1f,
-
-		},
-		{
-			.i2s_ctrl_reg = ASYS_I2SIN3_CON,
-			.i2s_asrc_fs_shift = 10,
-			.i2s_asrc_fs_mask = 0x1f,
-
-		},
+		{ ASYS_I2SO3_CON, 10, 0x1f },
+		{ ASYS_I2SIN3_CON, 10, 0x1f },
 	},
 	{
-		{
-			.i2s_ctrl_reg = ASYS_I2SO4_CON,
-			.i2s_asrc_fs_shift = 15,
-			.i2s_asrc_fs_mask = 0x1f,
-
-		},
-		{
-			.i2s_ctrl_reg = ASYS_I2SIN4_CON,
-			.i2s_asrc_fs_shift = 15,
-			.i2s_asrc_fs_mask = 0x1f,
-
-		},
+		{ ASYS_I2SO4_CON, 15, 0x1f },
+		{ ASYS_I2SIN4_CON, 15, 0x1f },
 	},
+	/* TODO - extend control registers supported by newer SoCs */
 };
 
 static irqreturn_t mt2701_asys_isr(int irq_id, void *dev)
@@ -1434,10 +1395,10 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* I2S initialize */
 	for (i = 0; i < MT2701_I2S_NUM; i++) {
-		afe_priv->i2s_path[i].i2s_data[I2S_OUT]
-			= &mt2701_i2s_data[i][I2S_OUT];
-		afe_priv->i2s_path[i].i2s_data[I2S_IN]
-			= &mt2701_i2s_data[i][I2S_IN];
+		afe_priv->i2s_path[i].i2s_data[SNDRV_PCM_STREAM_PLAYBACK] =
+			&mt2701_i2s_data[i][SNDRV_PCM_STREAM_PLAYBACK];
+		afe_priv->i2s_path[i].i2s_data[SNDRV_PCM_STREAM_CAPTURE] =
+			&mt2701_i2s_data[i][SNDRV_PCM_STREAM_CAPTURE];
 	}
 
 	afe->mtk_afe_hardware = &mt2701_afe_hardware;
-- 
1.9.1
