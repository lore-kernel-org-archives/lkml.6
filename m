Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeBSPFq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:05:46 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752855AbeBSPFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:05:41 -0500
From: Olivier Moysan <olivier.moysan@st.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@stlinux.com>, <linux-kernel@vger.kernel.org>,
        <olivier.moysan@st.com>
CC: <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [RFC PATCH 2/3] ASoC: dmaengine_pcm: add processing support
Date: Mon, 19 Feb 2018 16:00:36 +0100
Message-ID: <1519052437-24011-3-git-send-email-olivier.moysan@st.com>
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

Allow dmaengine client to optionally register a processing callback.
This callback is intended to apply processing
on samples in buffer copied from/to user space, before/after DMA transfer.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 include/sound/dmaengine_pcm.h         |  3 ++
 sound/soc/soc-generic-dmaengine-pcm.c | 62 +++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 8a5a840..47ef486 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -140,6 +140,9 @@ struct snd_dmaengine_pcm_config {
 	struct dma_chan *(*compat_request_channel)(
 			struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_substream *substream);
+	int (*process)(struct snd_pcm_substream *substream,
+		       int channel, unsigned long hwoff,
+		       void *buf, unsigned long bytes);
 	dma_filter_fn compat_filter_fn;
 	struct device *dma_dev;
 	const char *chan_names[SNDRV_PCM_STREAM_LAST + 1];
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index c07d5c7..1c1d838 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -340,6 +340,41 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 		return snd_dmaengine_pcm_pointer(substream);
 }
 
+static int dmaengine_copy_user(struct snd_pcm_substream *substream,
+			       int channel, unsigned long hwoff,
+			       void *buf, unsigned long bytes)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, SND_DMAENGINE_PCM_DRV_NAME);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
+	int (*process)(struct snd_pcm_substream *substream,
+		       int channel, unsigned long hwoff,
+		       void *buf, unsigned long bytes) = pcm->config->process;
+	bool is_playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	void *dma_ptr = runtime->dma_area + hwoff +
+			channel * (runtime->dma_bytes / runtime->channels);
+	int ret;
+
+	if (is_playback)
+		if (copy_from_user(dma_ptr, (void __user *)buf, bytes))
+			return -EFAULT;
+
+	if (process) {
+		ret = process(substream, channel, hwoff,
+			      (void __user *)buf, bytes);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!is_playback)
+		if (copy_to_user((void __user *)buf, dma_ptr, bytes))
+			return -EFAULT;
+
+	return 0;
+}
+
 static const struct snd_pcm_ops dmaengine_pcm_ops = {
 	.open		= dmaengine_pcm_open,
 	.close		= snd_dmaengine_pcm_close,
@@ -350,6 +385,17 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 	.pointer	= dmaengine_pcm_pointer,
 };
 
+static const struct snd_pcm_ops dmaengine_pcm_process_ops = {
+	.open		= dmaengine_pcm_open,
+	.close		= snd_dmaengine_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= dmaengine_pcm_hw_params,
+	.hw_free	= snd_pcm_lib_free_pages,
+	.trigger	= snd_dmaengine_pcm_trigger,
+	.pointer	= dmaengine_pcm_pointer,
+	.copy_user	= dmaengine_copy_user,
+};
+
 static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.name		= SND_DMAENGINE_PCM_DRV_NAME,
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
@@ -357,6 +403,13 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 	.pcm_new	= dmaengine_pcm_new,
 };
 
+static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
+	.name		= SND_DMAENGINE_PCM_DRV_NAME,
+	.probe_order	= SND_SOC_COMP_ORDER_LATE,
+	.ops		= &dmaengine_pcm_process_ops,
+	.pcm_new	= dmaengine_pcm_new,
+};
+
 static const char * const dmaengine_pcm_dma_channel_names[] = {
 	[SNDRV_PCM_STREAM_PLAYBACK] = "tx",
 	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
@@ -449,8 +502,13 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	if (ret)
 		goto err_free_dma;
 
-	ret = snd_soc_add_component(dev, &pcm->component,
-				    &dmaengine_pcm_component, NULL, 0);
+	if (config && config->process)
+		ret = snd_soc_add_component(dev, &pcm->component,
+					    &dmaengine_pcm_component_process,
+					    NULL, 0);
+	else
+		ret = snd_soc_add_component(dev, &pcm->component,
+					    &dmaengine_pcm_component, NULL, 0);
 	if (ret)
 		goto err_free_dma;
 
-- 
1.9.1
