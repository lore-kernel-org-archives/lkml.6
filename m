Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965099AbeE2O7x (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:59:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41762 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965048AbeE2O7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:59:45 -0400
From: Mark Brown <broonie@kernel.org>
To: Agrawal@sirena.org.uk, Akshu <Akshu.Agrawal@amd.com>
Cc: Akshu Agrawal <akshu.agrawal@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>, Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        djkurtz@chromium.org, Mark Brown <broonie@kernel.org>,
        "Mukunda,, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>, akshu.agrawal@amd.com,
        Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: make channel 1 dma as circular" to the asoc tree
In-Reply-To: <1527479306-12658-1-git-send-email-akshu.agrawal@amd.com>
Message-Id: <E1fNg6A-00069N-NV@debutante>
Date: Tue, 29 May 2018 15:59:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: make channel 1 dma as circular

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

>From 6b116dfb4633a7efce7f96355c2d272d8b16f0fb Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Mon, 28 May 2018 11:48:22 +0800
Subject: [PATCH] ASoC: AMD: make channel 1 dma as circular

channel 1: SYSMEM<->ACP
channel 2: ACP<->I2S
Instead of waiting on period interrupt of ch 2 and then starting
dma on ch1, we make ch1 dma as circular.
This removes dependency of period granularity on hw pointer.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Tested-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 74 +++++--------------------------------
 1 file changed, 10 insertions(+), 64 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index ac32deaa9541..77203841c535 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -337,8 +337,7 @@ static void config_acp_dma(void __iomem *acp_mmio,
 }
 
 /* Start a given DMA channel transfer */
-static void acp_dma_start(void __iomem *acp_mmio,
-			  u16 ch_num, bool is_circular)
+static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 {
 	u32 dma_ctrl;
 
@@ -369,11 +368,8 @@ static void acp_dma_start(void __iomem *acp_mmio,
 		break;
 	}
 
-	/* enable  for ACP SRAM to/from I2S DMA channel */
-	if (is_circular == true)
-		dma_ctrl |= ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
-	else
-		dma_ctrl &= ~ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
+	/* circular for both DMA channel */
+	dma_ctrl |= ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
 
 	acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
 }
@@ -617,7 +613,6 @@ static int acp_deinit(void __iomem *acp_mmio)
 /* ACP DMA irq handler routine for playback, capture usecases */
 static irqreturn_t dma_irq_handler(int irq, void *arg)
 {
-	u16 dscr_idx;
 	u32 intr_flag, ext_intr_status;
 	struct audio_drv_data *irq_data;
 	void __iomem *acp_mmio;
@@ -634,33 +629,13 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 	if ((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
-		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_13) ==
-				PLAYBACK_START_DMA_DESCR_CH13)
-			dscr_idx = PLAYBACK_END_DMA_DESCR_CH12;
-		else
-			dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
-		config_acp_dma_channel(acp_mmio, SYSRAM_TO_ACP_CH_NUM, dscr_idx,
-				       1, 0);
-		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_CH_NUM, false);
-
 		snd_pcm_period_elapsed(irq_data->play_i2ssp_stream);
-
 		acp_reg_write((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if ((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
-		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_9) ==
-			PLAYBACK_START_DMA_DESCR_CH9)
-			dscr_idx = PLAYBACK_END_DMA_DESCR_CH8;
-		else
-			dscr_idx = PLAYBACK_START_DMA_DESCR_CH8;
-		config_acp_dma_channel(acp_mmio,
-				       SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
-				       dscr_idx, 1, 0);
-		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
-			      false);
 		snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
 		acp_reg_write((intr_flag &
 			      BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) << 16,
@@ -669,38 +644,20 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
-		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_15) ==
-				CAPTURE_START_DMA_DESCR_CH15)
-			dscr_idx = CAPTURE_END_DMA_DESCR_CH14;
-		else
-			dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
-		config_acp_dma_channel(acp_mmio, ACP_TO_SYSRAM_CH_NUM, dscr_idx,
-				       1, 0);
-		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_CH_NUM, false);
-
+		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
 		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
 		valid_irq = true;
-		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
 		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
-		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_11) ==
-			CAPTURE_START_DMA_DESCR_CH11)
-			dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
-		else
-			dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
-		config_acp_dma_channel(acp_mmio,
-				       ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
-				       dscr_idx, 1, 0);
-		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
-			      false);
+		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
 			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
@@ -708,7 +665,6 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 
 	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
-		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
 			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
@@ -1015,14 +971,10 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	int ret;
-	u32 loops = 4000;
 	u64 bytescount = 0;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *prtd = substream->private_data;
 	struct audio_substream_data *rtd = runtime->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
-								    DRV_NAME);
 
 	if (!rtd)
 		return -EINVAL;
@@ -1034,18 +986,12 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (rtd->bytescount == 0)
 			rtd->bytescount = bytescount;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
-			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
-				BIT(rtd->ch1)) {
-				if (!loops--) {
-					dev_err(component->dev,
-						"acp dma start timeout\n");
-					return -ETIMEDOUT;
-				}
-				cpu_relax();
-			}
+			acp_dma_start(rtd->acp_mmio, rtd->ch1);
+			acp_dma_start(rtd->acp_mmio, rtd->ch2);
+		} else {
+			acp_dma_start(rtd->acp_mmio, rtd->ch2);
+			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 		}
-		acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
2.17.0
