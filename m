Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933785AbeCMQal (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:30:41 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58672 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753125AbeCMQaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:30:35 -0400
From: Olivier Moysan <olivier.moysan@st.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@stlinux.com>, <linux-kernel@vger.kernel.org>,
        <olivier.moysan@st.com>
CC: <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>,
        <rmk@arm.linux.org.uk>, <jsarha@ti.com>
Subject: [PATCH 2/3] ASoC: stm32: sai: add iec958 controls support
Date: Tue, 13 Mar 2018 17:27:07 +0100
Message-ID: <1520958428-10930-3-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of iec958 controls for STM32 SAI.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/core/pcm_iec958.c       |   1 +
 sound/soc/stm/Kconfig         |   1 +
 sound/soc/stm/stm32_sai_sub.c | 101 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
index aba1f522e98a..c34735ac3c48 100644
--- a/sound/core/pcm_iec958.c
+++ b/sound/core/pcm_iec958.c
@@ -19,6 +19,7 @@ static int snd_pcm_iec958_info(struct snd_kcontrol *kcontrol,
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
+
 	return 0;
 }
 
diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index 48f9ddd94016..9b2681397dba 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -6,6 +6,7 @@ config SND_SOC_STM32_SAI
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
+	select SND_PCM_IEC958
 	help
 	  Say Y if you want to enable SAI for STM32
 
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index cfeb219e1d78..c2e487e133aa 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -26,6 +26,7 @@
 #include <sound/asoundef.h>
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
+#include <sound/pcm_iec958.h>
 #include <sound/pcm_params.h>
 
 #include "stm32_sai.h"
@@ -96,7 +97,7 @@
  * @slot_mask: rx or tx active slots mask. set at init or at runtime
  * @data_size: PCM data width. corresponds to PCM substream width.
  * @spdif_frm_cnt: S/PDIF playback frame counter
- * @spdif_status_bits: S/PDIF status bits
+ * @snd_aes_iec958: iec958 data
  */
 struct stm32_sai_sub_data {
 	struct platform_device *pdev;
@@ -125,7 +126,7 @@ struct stm32_sai_sub_data {
 	int slot_mask;
 	int data_size;
 	unsigned int spdif_frm_cnt;
-	unsigned char spdif_status_bits[SAI_IEC60958_STATUS_BYTES];
+	struct snd_aes_iec958 iec958;
 };
 
 enum stm32_sai_fifo_th {
@@ -184,10 +185,6 @@ static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static const unsigned char default_status_bits[SAI_IEC60958_STATUS_BYTES] = {
-	0, 0, 0, IEC958_AES3_CON_FS_48000,
-};
-
 static const struct regmap_config stm32_sai_sub_regmap_config_f4 = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -619,6 +616,59 @@ static void stm32_sai_set_frame(struct snd_soc_dai *cpu_dai)
 	}
 }
 
+static void stm32_sai_set_channel_status(struct stm32_sai_sub_data *sai,
+					 struct snd_pcm_runtime *runtime)
+{
+	if (!runtime)
+		return;
+
+	/* Force the sample rate according to runtime rate */
+	switch (runtime->rate) {
+	case 22050:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_22050;
+		break;
+	case 44100:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_44100;
+		break;
+	case 88200:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_88200;
+		break;
+	case 176400:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_176400;
+		break;
+	case 24000:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_24000;
+		break;
+	case 48000:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_48000;
+		break;
+	case 96000:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_96000;
+		break;
+	case 192000:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_192000;
+		break;
+	case 32000:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_32000;
+		break;
+	default:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_NOTID;
+		break;
+	}
+}
+
+static int stm32_sai_iec958_set(struct snd_pcm_iec958_params *iec_param)
+{
+	struct stm32_sai_sub_data *sai = iec_param->private_data;
+
+	if (!sai->substream)
+		return 0;
+
+	stm32_sai_set_channel_status(sai, sai->substream->runtime);
+
+	return 0;
+}
+
 static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 				     struct snd_pcm_hw_params *params)
 {
@@ -709,7 +759,11 @@ static int stm32_sai_hw_params(struct snd_pcm_substream *substream,
 
 	sai->data_size = params_width(params);
 
-	if (!STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		/* Rate not already set in runtime structure */
+		substream->runtime->rate = params_rate(params);
+		stm32_sai_set_channel_status(sai, substream->runtime);
+	} else {
 		ret = stm32_sai_set_slots(cpu_dai);
 		if (ret < 0)
 			return ret;
@@ -789,6 +843,28 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 	sai->substream = NULL;
 }
 
+static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			     struct snd_soc_dai *cpu_dai)
+{
+	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
+	struct snd_pcm_iec958_params *iec_param;
+
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		dev_dbg(&sai->pdev->dev, "%s: register iec controls", __func__);
+		iec_param = devm_kzalloc(&sai->pdev->dev, sizeof(*iec_param),
+					 GFP_KERNEL);
+		iec_param->ctrl_set = stm32_sai_iec958_set;
+		iec_param->private_data = sai;
+		iec_param->cs = sai->iec958.status;
+		iec_param->cs_len = 5;
+		return snd_pcm_add_iec958_ctl(rtd->pcm, 0,
+					      SNDRV_PCM_STREAM_PLAYBACK,
+					      iec_param);
+	}
+
+	return 0;
+}
+
 static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
@@ -809,6 +885,10 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	else
 		snd_soc_dai_init_dma_data(cpu_dai, NULL, &sai->dma_params);
 
+	/* Next settings are not relevant for spdif mode */
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
+		return 0;
+
 	cr1_mask = SAI_XCR1_RX_TX;
 	if (STM_SAI_IS_CAPTURE(sai))
 		cr1 |= SAI_XCR1_RX_TX;
@@ -820,10 +900,6 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 				     sai->synco, sai->synci);
 	}
 
-	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
-		memcpy(sai->spdif_status_bits, default_status_bits,
-		       sizeof(default_status_bits));
-
 	cr1_mask |= SAI_XCR1_SYNCEN_MASK;
 	cr1 |= SAI_XCR1_SYNCEN_SET(sai->sync);
 
@@ -861,7 +937,7 @@ static int stm32_sai_pcm_process_spdif(struct snd_pcm_substream *substream,
 		/* Set channel status bit */
 		byte = frm_cnt >> 3;
 		mask = 1 << (frm_cnt - (byte << 3));
-		if (sai->spdif_status_bits[byte] & mask)
+		if (sai->iec958.status[byte] & mask)
 			*ptr |= 0x04000000;
 		ptr++;
 
@@ -888,6 +964,7 @@ static int stm32_sai_pcm_process_spdif(struct snd_pcm_substream *substream,
 static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
 {
 		.probe = stm32_sai_dai_probe,
+		.pcm_new = stm32_sai_pcm_new,
 		.id = 1, /* avoid call to fmt_single_name() */
 		.playback = {
 			.channels_min = 1,
-- 
1.9.1
