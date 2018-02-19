Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbeBSPFi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:05:38 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48991 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751353AbeBSPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:05:35 -0500
From: Olivier Moysan <olivier.moysan@st.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@stlinux.com>, <linux-kernel@vger.kernel.org>,
        <olivier.moysan@st.com>
CC: <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [RFC PATCH 3/3] ASoC: stm32: sai: Add support of S/PDIF playback
Date: Mon, 19 Feb 2018 16:00:37 +0100
Message-ID: <1519052437-24011-4-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519052437-24011-1-git-send-email-olivier.moysan@st.com>
References: <1519052437-24011-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of S/PDIF iec60958 playback on STM32 SAI.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.c     |   2 +
 sound/soc/stm/stm32_sai.h     |   2 +
 sound/soc/stm/stm32_sai_sub.c | 153 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 133 insertions(+), 24 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index d743b7d..f226542 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -30,10 +30,12 @@
 
 static const struct stm32_sai_conf stm32_sai_conf_f4 = {
 	.version = SAI_STM32F4,
+	.has_spdif = false,
 };
 
 static const struct stm32_sai_conf stm32_sai_conf_h7 = {
 	.version = SAI_STM32H7,
+	.has_spdif = true,
 };
 
 static const struct of_device_id stm32_sai_ids[] = {
diff --git a/sound/soc/stm/stm32_sai.h b/sound/soc/stm/stm32_sai.h
index bb062e7..f254221 100644
--- a/sound/soc/stm/stm32_sai.h
+++ b/sound/soc/stm/stm32_sai.h
@@ -248,9 +248,11 @@ enum stm32_sai_version {
 /**
  * struct stm32_sai_conf - SAI configuration
  * @version: SAI version
+ * @has_spdif: SAI S/PDIF support flag
  */
 struct stm32_sai_conf {
 	int version;
+	bool has_spdif;
 };
 
 /**
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 08583b9..cfeb219 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -23,6 +23,7 @@
 #include <linux/of_platform.h>
 #include <linux/regmap.h>
 
+#include <sound/asoundef.h>
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
@@ -30,6 +31,7 @@
 #include "stm32_sai.h"
 
 #define SAI_FREE_PROTOCOL	0x0
+#define SAI_SPDIF_PROTOCOL	0x1
 
 #define SAI_SLOT_SIZE_AUTO	0x0
 #define SAI_SLOT_SIZE_16	0x1
@@ -59,8 +61,13 @@
 #define SAI_SYNC_INTERNAL	0x1
 #define SAI_SYNC_EXTERNAL	0x2
 
+#define STM_SAI_PROTOCOL_IS_SPDIF(ip)	((ip)->spdif)
+#define STM_SAI_HAS_SPDIF(x)	((x)->pdata->conf->has_spdif)
 #define STM_SAI_HAS_EXT_SYNC(x) (!STM_SAI_IS_F4(sai->pdata))
 
+#define SAI_IEC60958_BLOCK_FRAMES	192
+#define SAI_IEC60958_STATUS_BYTES	24
+
 /**
  * struct stm32_sai_sub_data - private data of SAI sub block (block A or B)
  * @pdev: device data pointer
@@ -78,6 +85,7 @@
  * @id: SAI sub block id corresponding to sub-block A or B
  * @dir: SAI block direction (playback or capture). set at init
  * @master: SAI block mode flag. (true=master, false=slave) set at init
+ * @spdif: SAI S/PDIF iec60958 mode flag. set at init
  * @fmt: SAI block format. relevant only for custom protocols. set at init
  * @sync: SAI block synchronization mode. (none, internal or external)
  * @synco: SAI block ext sync source (provider setting). (none, sub-block A/B)
@@ -87,6 +95,8 @@
  * @slot_width: rx or tx slot width in bits
  * @slot_mask: rx or tx active slots mask. set at init or at runtime
  * @data_size: PCM data width. corresponds to PCM substream width.
+ * @spdif_frm_cnt: S/PDIF playback frame counter
+ * @spdif_status_bits: S/PDIF status bits
  */
 struct stm32_sai_sub_data {
 	struct platform_device *pdev;
@@ -104,6 +114,7 @@ struct stm32_sai_sub_data {
 	unsigned int id;
 	int dir;
 	bool master;
+	bool spdif;
 	int fmt;
 	int sync;
 	int synco;
@@ -113,6 +124,8 @@ struct stm32_sai_sub_data {
 	int slot_width;
 	int slot_mask;
 	int data_size;
+	unsigned int spdif_frm_cnt;
+	unsigned char spdif_status_bits[SAI_IEC60958_STATUS_BYTES];
 };
 
 enum stm32_sai_fifo_th {
@@ -171,6 +184,10 @@ static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static const unsigned char default_status_bits[SAI_IEC60958_STATUS_BYTES] = {
+	0, 0, 0, IEC958_AES3_CON_FS_48000,
+};
+
 static const struct regmap_config stm32_sai_sub_regmap_config_f4 = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -277,6 +294,11 @@ static int stm32_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	int slotr, slotr_mask, slot_size;
 
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		dev_warn(cpu_dai->dev, "Slot setting relevant only for TDM\n");
+		return 0;
+	}
+
 	dev_dbg(cpu_dai->dev, "Masks tx/rx:%#x/%#x, slots:%d, width:%d\n",
 		tx_mask, rx_mask, slots, slot_width);
 
@@ -326,8 +348,17 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 
 	dev_dbg(cpu_dai->dev, "fmt %x\n", fmt);
 
-	cr1_mask = SAI_XCR1_PRTCFG_MASK;
-	cr1 = SAI_XCR1_PRTCFG_SET(SAI_FREE_PROTOCOL);
+	/* Do not generate master by default */
+	cr1 = SAI_XCR1_NODIV;
+	cr1_mask = SAI_XCR1_NODIV;
+
+	cr1_mask |= SAI_XCR1_PRTCFG_MASK;
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		cr1 |= SAI_XCR1_PRTCFG_SET(SAI_SPDIF_PROTOCOL);
+		goto conf_update;
+	}
+
+	cr1 |= SAI_XCR1_PRTCFG_SET(SAI_FREE_PROTOCOL);
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	/* SCK active high for all protocols */
@@ -409,10 +440,7 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 
 	cr1_mask |= SAI_XCR1_SLAVE;
 
-	/* do not generate master by default */
-	cr1 |= SAI_XCR1_NODIV;
-	cr1_mask |= SAI_XCR1_NODIV;
-
+conf_update:
 	ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, cr1_mask, cr1);
 	if (ret < 0) {
 		dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
@@ -478,6 +506,12 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 			   SAI_XCR2_FFLUSH |
 			   SAI_XCR2_FTH_SET(STM_SAI_FIFO_TH_HALF));
 
+	/* DS bits in CR1 not set for SPDIF (size forced to 24 bits).*/
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		sai->spdif_frm_cnt = 0;
+		return 0;
+	}
+
 	/* Mode, data format and channel config */
 	cr1_mask = SAI_XCR1_DS_MASK;
 	switch (params_format(params)) {
@@ -592,13 +626,14 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 	int cr1, mask, div = 0;
 	int sai_clk_rate, mclk_ratio, den, ret;
 	int version = sai->pdata->conf->version;
+	unsigned int rate = params_rate(params);
 
 	if (!sai->mclk_rate) {
 		dev_err(cpu_dai->dev, "Mclk rate is null\n");
 		return -EINVAL;
 	}
 
-	if (!(params_rate(params) % 11025))
+	if (!(rate % 11025))
 		clk_set_parent(sai->sai_ck, sai->pdata->clk_x11k);
 	else
 		clk_set_parent(sai->sai_ck, sai->pdata->clk_x8k);
@@ -623,24 +658,28 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 		 *      MCKDIV = sai_ck / (frl x ws)	(NOMCK=1)
 		 * Note: NOMCK/NODIV correspond to same bit.
 		 */
-		if (sai->mclk_rate) {
-			mclk_ratio = sai->mclk_rate / params_rate(params);
-			if (mclk_ratio != 256) {
+		if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+			div = DIV_ROUND_CLOSEST(sai_clk_rate,
+						(params_rate(params) * 128));
+		} else {
+			if (sai->mclk_rate) {
+				mclk_ratio = sai->mclk_rate / rate;
 				if (mclk_ratio == 512) {
 					mask = SAI_XCR1_OSR;
 					cr1 = SAI_XCR1_OSR;
-				} else {
+				} else if (mclk_ratio != 256) {
 					dev_err(cpu_dai->dev,
 						"Wrong mclk ratio %d\n",
 						mclk_ratio);
 					return -EINVAL;
 				}
+				div = DIV_ROUND_CLOSEST(sai_clk_rate,
+							sai->mclk_rate);
+			} else {
+				/* mclk-fs not set, master clock not active */
+				den = sai->fs_length * params_rate(params);
+				div = DIV_ROUND_CLOSEST(sai_clk_rate, den);
 			}
-			div = DIV_ROUND_CLOSEST(sai_clk_rate, sai->mclk_rate);
-		} else {
-			/* mclk-fs not set, master clock not active. NOMCK=1 */
-			den = sai->fs_length * params_rate(params);
-			div = DIV_ROUND_CLOSEST(sai_clk_rate, den);
 		}
 	}
 
@@ -670,10 +709,12 @@ static int stm32_sai_hw_params(struct snd_pcm_substream *substream,
 
 	sai->data_size = params_width(params);
 
-	ret = stm32_sai_set_slots(cpu_dai);
-	if (ret < 0)
-		return ret;
-	stm32_sai_set_frame(cpu_dai);
+	if (!STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		ret = stm32_sai_set_slots(cpu_dai);
+		if (ret < 0)
+			return ret;
+		stm32_sai_set_frame(cpu_dai);
+	}
 
 	ret = stm32_sai_set_config(cpu_dai, substream, params);
 	if (ret)
@@ -723,6 +764,9 @@ static int stm32_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 					 (unsigned int)~SAI_XCR1_DMAEN);
 		if (ret < 0)
 			dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
+
+		if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
+			sai->spdif_frm_cnt = 0;
 		break;
 	default:
 		return -EINVAL;
@@ -776,6 +820,10 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 				     sai->synco, sai->synci);
 	}
 
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
+		memcpy(sai->spdif_status_bits, default_status_bits,
+		       sizeof(default_status_bits));
+
 	cr1_mask |= SAI_XCR1_SYNCEN_MASK;
 	cr1 |= SAI_XCR1_SYNCEN_SET(sai->sync);
 
@@ -792,6 +840,42 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	.shutdown	= stm32_sai_shutdown,
 };
 
+static int stm32_sai_pcm_process_spdif(struct snd_pcm_substream *substream,
+				       int channel, unsigned long hwoff,
+				       void *buf, unsigned long bytes)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
+	int *ptr = (int *)(runtime->dma_area + hwoff +
+			   channel * (runtime->dma_bytes / runtime->channels));
+	ssize_t cnt = bytes_to_samples(runtime, bytes);
+	unsigned int frm_cnt = sai->spdif_frm_cnt;
+	unsigned int byte;
+	unsigned int mask;
+
+	do {
+		*ptr = ((*ptr >> 8) & 0x00ffffff);
+
+		/* Set channel status bit */
+		byte = frm_cnt >> 3;
+		mask = 1 << (frm_cnt - (byte << 3));
+		if (sai->spdif_status_bits[byte] & mask)
+			*ptr |= 0x04000000;
+		ptr++;
+
+		if (!(cnt % 2))
+			frm_cnt++;
+
+		if (frm_cnt == SAI_IEC60958_BLOCK_FRAMES)
+			frm_cnt = 0;
+	} while (--cnt);
+	sai->spdif_frm_cnt = frm_cnt;
+
+	return 0;
+}
+
 static const struct snd_pcm_hardware stm32_sai_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP,
 	.buffer_bytes_max = 8 * PAGE_SIZE,
@@ -842,8 +926,14 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 };
 
 static const struct snd_dmaengine_pcm_config stm32_sai_pcm_config = {
-	.pcm_hardware	= &stm32_sai_pcm_hw,
-	.prepare_slave_config	= snd_dmaengine_pcm_prepare_slave_config,
+	.pcm_hardware = &stm32_sai_pcm_hw,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+};
+
+static const struct snd_dmaengine_pcm_config stm32_sai_pcm_config_spdif = {
+	.pcm_hardware = &stm32_sai_pcm_hw,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.process = stm32_sai_pcm_process_spdif,
 };
 
 static const struct snd_soc_component_driver stm32_component = {
@@ -900,6 +990,18 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	/* Get spdif iec60958 property */
+	sai->spdif = false;
+	if (of_get_property(np, "st,iec60958", NULL)) {
+		if (!STM_SAI_HAS_SPDIF(sai) ||
+		    sai->dir == SNDRV_PCM_STREAM_CAPTURE) {
+			dev_err(&pdev->dev, "S/PDIF IEC60958 not supported\n");
+			return -EINVAL;
+		}
+		sai->spdif = true;
+		sai->master = true;
+	}
+
 	/* Get synchronization property */
 	args.np = NULL;
 	ret = of_parse_phandle_with_fixed_args(np, "st,sync", 1, 0, &args);
@@ -999,6 +1101,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 {
 	struct stm32_sai_sub_data *sai;
 	const struct of_device_id *of_id;
+	const struct snd_dmaengine_pcm_config *conf = &stm32_sai_pcm_config;
 	int ret;
 
 	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
@@ -1039,8 +1142,10 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
-					      &stm32_sai_pcm_config, 0);
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
+		conf = &stm32_sai_pcm_config_spdif;
+
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, conf, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register pcm dma\n");
 		return ret;
-- 
1.9.1
