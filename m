Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC9EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DA7214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMdY1p4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DA7214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeIZQiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:38:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34377 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeIZQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:38:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3-v6so657096wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 03:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaAY04PJJzszAqazH0nKlHWHeHF7Lsvg/lVMk+d0uuo=;
        b=MMdY1p4aRRlpPergKXpCQtyo3QjscAiX27AqcuFbaESV/mFiSICsGyiQZUYXU0MkNQ
         5P9X85GjHSO+Fh24gejCz7KlPohE2m1SSeOVkSG7GhEqflXc0O5Dn9+VY5n/M8tc14OF
         fQQmLc4I7EwwDv+QO8rla2BxRUuIVWtkt+lyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaAY04PJJzszAqazH0nKlHWHeHF7Lsvg/lVMk+d0uuo=;
        b=OfEhoB4p6ZI9+1Y3dJe4kKeZL8R6mbVZSKzC81/g+Qzl/mRI6UKY8YaHUn4GIQL11V
         rZOirN0XmTvQX6k9JbY6oy3Pg5DMQtxqiodc0h1YOVBeuIiNavpuo/8h4JJ9tlOp/ySe
         41Jv70fA76pBDQXPxaSRPAZHeZsgY+GIMNJAiBi0Yi0W789zTxOuHd81esgsK/kE4Dag
         rkapKTxG78/iOg4cm49ABvbfSe5Jz4rxV+Ui6VsxU8chkQE8htfRNxdVEK1ANggZr8VK
         R8g+Sz9heB5aFY2iX+vobdHQOxSfuJegZwOTAyaHL8N0gBt3XxdnJ9xdvon1psTqrwZl
         lnlg==
X-Gm-Message-State: ABuFfogYdLVJ6K/xGDWGZ25MCmNVBJsDcqiBKRRkpja6uZ/hMrQ7o/jm
        oI3u/RTo7gULWeq1R8dIhFcHUg==
X-Google-Smtp-Source: ACcGV60WGuY0P5+dyGZ+gqanYjbofoU4ZXsvu0SXpTwLuuGBF5EhYOF/ILYMYvTLSfpILcyhYLHnLQ==
X-Received: by 2002:a1c:7704:: with SMTP id t4-v6mr3769955wmi.136.1537957562211;
        Wed, 26 Sep 2018 03:26:02 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b12sm4442648wrx.11.2018.09.26.03.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 03:26:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 5/5] ASoC: qdsp6: q6asm-dai: Add support to compress offload
Date:   Wed, 26 Sep 2018 11:23:49 +0100
Message-Id: <20180926102349.23481-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds MP3 playback support in q6asm dais, adding other codec
support should be pretty trivial.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig           |   1 +
 sound/soc/qcom/qdsp6/q6asm-dai.c | 377 ++++++++++++++++++++++++++++++-
 2 files changed, 377 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 2a4c912d1e48..ebf991bb546c 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -66,6 +66,7 @@ config SND_SOC_QDSP6_ASM
 	tristate
 
 config SND_SOC_QDSP6_ASM_DAI
+	select SND_SOC_COMPRESS
 	tristate
 
 config SND_SOC_QDSP6
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 9db9a2944ef2..57b8abcbebcd 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -11,6 +11,8 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
+#include <linux/spinlock.h>
+#include <sound/compress_driver.h>
 #include <asm/dma.h>
 #include <linux/dma-mapping.h>
 #include <linux/of_device.h>
@@ -31,6 +33,16 @@
 #define CAPTURE_MIN_PERIOD_SIZE     320
 #define SID_MASK_DEFAULT	0xF
 
+/* Default values used if user space does not set */
+#define COMPR_PLAYBACK_MIN_FRAGMENT_SIZE (8 * 1024)
+#define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
+#define COMPR_PLAYBACK_MIN_NUM_FRAGMENTS (4)
+#define COMPR_PLAYBACK_MAX_NUM_FRAGMENTS (16 * 4)
+#define Q6ASM_DAI_TX_RX	0
+#define Q6ASM_DAI_TX	1
+#define Q6ASM_DAI_RX	2
+
+
 enum stream_state {
 	Q6ASM_STREAM_IDLE = 0,
 	Q6ASM_STREAM_STOPPED,
@@ -39,11 +51,22 @@ enum stream_state {
 
 struct q6asm_dai_rtd {
 	struct snd_pcm_substream *substream;
+	struct snd_compr_stream *cstream;
+	struct snd_compr_params codec_param;
+	struct snd_dma_buffer dma_buffer;
+
 	phys_addr_t phys;
+	spinlock_t lock;
+
 	unsigned int pcm_size;
 	unsigned int pcm_count;
 	unsigned int pcm_irq_pos;       /* IRQ position */
 	unsigned int periods;
+
+	unsigned int bytes_sent;
+	unsigned int bytes_received;
+	unsigned int copied_total;
+
 	uint16_t bits_per_sample;
 	uint16_t source; /* Encoding source bit mask */
 	struct audio_client *audio_client;
@@ -139,6 +162,21 @@ static struct snd_pcm_hw_constraint_list constraints_sample_rates = {
 	.mask = 0,
 };
 
+static const struct snd_compr_codec_caps q6asm_compr_caps = {
+	.num_descriptors = 1,
+	.descriptor[0].max_ch = 2,
+	.descriptor[0].sample_rates = {	8000, 11025, 12000, 16000, 22050,
+					24000, 32000, 44100, 48000, 88200,
+					96000, 176400, 192000 },
+	.descriptor[0].num_sample_rates = 13,
+	.descriptor[0].bit_rate[0] = 320,
+	.descriptor[0].bit_rate[1] = 128,
+	.descriptor[0].num_bitrates = 2,
+	.descriptor[0].profiles = 0,
+	.descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO,
+	.descriptor[0].formats = 0,
+};
+
 static void event_handler(uint32_t opcode, uint32_t token,
 			  uint32_t *payload, void *priv)
 {
@@ -461,6 +499,306 @@ static struct snd_pcm_ops q6asm_dai_ops = {
 	.mmap		= q6asm_dai_mmap,
 };
 
+static void compress_event_handler(uint32_t opcode, uint32_t token,
+				   uint32_t *payload, void *priv)
+{
+	struct q6asm_dai_rtd *prtd = priv;
+	struct snd_compr_stream *substream = prtd->cstream;
+	unsigned long flags;
+	uint64_t avail;
+
+	switch (opcode) {
+	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
+		spin_lock_irqsave(&prtd->lock, flags);
+		if (!prtd->bytes_sent) {
+			q6asm_write_async(prtd->audio_client, prtd->pcm_count,
+					  0, 0, NO_TIMESTAMP);
+			prtd->bytes_sent += prtd->pcm_count;
+		}
+
+		spin_unlock_irqrestore(&prtd->lock, flags);
+		break;
+
+	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
+		prtd->state = Q6ASM_STREAM_STOPPED;
+		break;
+
+	case ASM_CLIENT_EVENT_DATA_WRITE_DONE:
+		spin_lock_irqsave(&prtd->lock, flags);
+
+		prtd->copied_total += prtd->pcm_count;
+		snd_compr_fragment_elapsed(substream);
+
+		if (prtd->state != Q6ASM_STREAM_RUNNING) {
+			spin_unlock_irqrestore(&prtd->lock, flags);
+			break;
+		}
+
+		avail = prtd->bytes_received - prtd->bytes_sent;
+
+		if (avail >= prtd->pcm_count) {
+			q6asm_write_async(prtd->audio_client,
+					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+			prtd->bytes_sent += prtd->pcm_count;
+		}
+
+		spin_unlock_irqrestore(&prtd->lock, flags);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int q6asm_dai_compr_open(struct snd_compr_stream *stream)
+{
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct snd_soc_component *c = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct q6asm_dai_data *pdata;
+	struct device *dev = c->dev;
+	struct q6asm_dai_rtd *prtd;
+	int stream_id, size, ret;
+
+	stream_id = cpu_dai->driver->id;
+	pdata = snd_soc_component_get_drvdata(c);
+	if (!pdata) {
+		dev_err(dev, "Drv data not found ..\n");
+		return -EINVAL;
+	}
+
+	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
+	if (!prtd)
+		return -ENOMEM;
+
+	prtd->cstream = stream;
+	prtd->audio_client = q6asm_audio_client_alloc(dev,
+					(q6asm_cb)compress_event_handler,
+					prtd, stream_id, LEGACY_PCM_MODE);
+	if (!prtd->audio_client) {
+		dev_err(dev, "Could not allocate memory\n");
+		kfree(prtd);
+		return -ENOMEM;
+	}
+
+	size = COMPR_PLAYBACK_MAX_FRAGMENT_SIZE *
+			COMPR_PLAYBACK_MAX_NUM_FRAGMENTS;
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
+				  &prtd->dma_buffer);
+	if (ret) {
+		dev_err(dev, "Cannot allocate buffer(s)\n");
+		return ret;
+	}
+
+	if (pdata->sid < 0)
+		prtd->phys = prtd->dma_buffer.addr;
+	else
+		prtd->phys = prtd->dma_buffer.addr | (pdata->sid << 32);
+
+	snd_compr_set_runtime_buffer(stream, &prtd->dma_buffer);
+	spin_lock_init(&prtd->lock);
+	runtime->private_data = prtd;
+
+	return 0;
+}
+
+static int q6asm_dai_compr_free(struct snd_compr_stream *stream)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+
+	if (prtd->audio_client) {
+		if (prtd->state)
+			q6asm_cmd(prtd->audio_client, CMD_CLOSE);
+
+		snd_dma_free_pages(&prtd->dma_buffer);
+		q6asm_unmap_memory_regions(stream->direction,
+					   prtd->audio_client);
+		q6asm_audio_client_free(prtd->audio_client);
+		prtd->audio_client = NULL;
+	}
+	q6routing_stream_close(rtd->dai_link->id, stream->direction);
+	kfree(prtd);
+
+	return 0;
+}
+
+static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
+				      struct snd_compr_params *params)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct snd_soc_component *c = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	int dir = stream->direction;
+	struct q6asm_dai_data *pdata;
+	struct device *dev = c->dev;
+	int ret;
+
+	memcpy(&prtd->codec_param, params, sizeof(*params));
+
+	pdata = snd_soc_component_get_drvdata(c);
+	if (!pdata)
+		return -EINVAL;
+
+	if (!prtd || !prtd->audio_client) {
+		dev_err(dev, "private data null or audio client freed\n");
+		return -EINVAL;
+	}
+
+	prtd->periods = runtime->fragments;
+	prtd->pcm_count = runtime->fragment_size;
+	prtd->pcm_size = runtime->fragments * runtime->fragment_size;
+	prtd->bits_per_sample = 16;
+	if (dir == SND_COMPRESS_PLAYBACK) {
+		ret = q6asm_open_write(prtd->audio_client, params->codec.id,
+					prtd->bits_per_sample);
+
+		if (ret < 0) {
+			dev_err(dev, "q6asm_open_write failed\n");
+			q6asm_audio_client_free(prtd->audio_client);
+			prtd->audio_client = NULL;
+			return ret;
+		}
+	}
+
+	prtd->session_id = q6asm_get_session_id(prtd->audio_client);
+	ret = q6routing_stream_open(rtd->dai_link->id, LEGACY_PCM_MODE,
+			      prtd->session_id, dir);
+	if (ret) {
+		dev_err(dev, "Stream reg failed ret:%d\n", ret);
+		return ret;
+	}
+
+	ret = q6asm_map_memory_regions(dir, prtd->audio_client, prtd->phys,
+				       (prtd->pcm_size / prtd->periods),
+				       prtd->periods);
+
+	if (ret < 0) {
+		dev_err(dev, "Buffer Mapping failed ret:%d\n", ret);
+		return -ENOMEM;
+	}
+
+	prtd->state = Q6ASM_STREAM_RUNNING;
+
+	return 0;
+}
+
+static int q6asm_dai_compr_trigger(struct snd_compr_stream *stream, int cmd)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		prtd->state = Q6ASM_STREAM_STOPPED;
+		ret = q6asm_cmd_nowait(prtd->audio_client, CMD_EOS);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ret = q6asm_cmd_nowait(prtd->audio_client, CMD_PAUSE);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int q6asm_dai_compr_pointer(struct snd_compr_stream *stream,
+		struct snd_compr_tstamp *tstamp)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&prtd->lock, flags);
+
+	tstamp->copied_total = prtd->copied_total;
+	tstamp->byte_offset = prtd->copied_total % prtd->pcm_size;
+
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return 0;
+}
+
+static int q6asm_dai_compr_ack(struct snd_compr_stream *stream,
+				size_t count)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&prtd->lock, flags);
+	prtd->bytes_received += count;
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return count;
+}
+
+static int q6asm_dai_compr_mmap(struct snd_compr_stream *stream,
+		struct vm_area_struct *vma)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct snd_soc_component *c = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = c->dev;
+
+	return dma_mmap_coherent(dev, vma,
+			prtd->dma_buffer.area, prtd->dma_buffer.addr,
+			prtd->dma_buffer.bytes);
+}
+
+static int q6asm_dai_compr_get_caps(struct snd_compr_stream *stream,
+				    struct snd_compr_caps *caps)
+{
+	caps->direction = SND_COMPRESS_PLAYBACK;
+	caps->min_fragment_size = COMPR_PLAYBACK_MIN_FRAGMENT_SIZE;
+	caps->max_fragment_size = COMPR_PLAYBACK_MAX_FRAGMENT_SIZE;
+	caps->min_fragments = COMPR_PLAYBACK_MIN_NUM_FRAGMENTS;
+	caps->max_fragments = COMPR_PLAYBACK_MAX_NUM_FRAGMENTS;
+	caps->num_codecs = 1;
+	caps->codecs[0] = SND_AUDIOCODEC_MP3;
+
+	return 0;
+}
+
+static int q6asm_dai_compr_get_codec_caps(struct snd_compr_stream *stream,
+					  struct snd_compr_codec_caps *codec)
+{
+	switch (codec->codec) {
+	case SND_AUDIOCODEC_MP3:
+		*codec = q6asm_compr_caps;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct snd_compr_ops q6asm_dai_compr_ops = {
+	.open		= q6asm_dai_compr_open,
+	.free		= q6asm_dai_compr_free,
+	.set_params	= q6asm_dai_compr_set_params,
+	.pointer	= q6asm_dai_compr_pointer,
+	.trigger	= q6asm_dai_compr_trigger,
+	.get_caps	= q6asm_dai_compr_get_caps,
+	.get_codec_caps	= q6asm_dai_compr_get_codec_caps,
+	.mmap		= q6asm_dai_compr_mmap,
+	.ack		= q6asm_dai_compr_ack,
+};
+
 static int q6asm_dai_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm_substream *psubstream, *csubstream;
@@ -548,7 +886,7 @@ static const struct snd_soc_component_driver q6asm_fe_dai_component = {
 	.ops		= &q6asm_dai_ops,
 	.pcm_new	= q6asm_dai_pcm_new,
 	.pcm_free	= q6asm_dai_pcm_free,
-
+	.compr_ops	= &q6asm_dai_compr_ops,
 };
 
 static struct snd_soc_dai_driver q6asm_fe_dais[] = {
@@ -562,6 +900,41 @@ static struct snd_soc_dai_driver q6asm_fe_dais[] = {
 	Q6ASM_FEDAI_DRIVER(8),
 };
 
+static int of_q6asm_parse_dai_data(struct device *dev,
+				    struct q6asm_dai_data *pdata)
+{
+	static struct snd_soc_dai_driver *dai_drv;
+	struct snd_soc_pcm_stream empty_stream;
+	struct device_node *node;
+	int ret, id, dir;
+
+	memset(&empty_stream, 0, sizeof(empty_stream));
+
+	for_each_child_of_node(dev->of_node, node) {
+		ret = of_property_read_u32(node, "reg", &id);
+		if (ret || id > MAX_SESSIONS || id < 0) {
+			dev_err(dev, "valid dai id not found:%d\n", ret);
+			continue;
+		}
+
+		dai_drv = &q6asm_fe_dais[id];
+
+		ret = of_property_read_u32(node, "direction", &dir);
+		if (ret)
+			continue;
+
+		if (dir == Q6ASM_DAI_RX)
+			dai_drv->capture = empty_stream;
+		else if (dir == Q6ASM_DAI_TX)
+			dai_drv->playback = empty_stream;
+
+		if (of_property_read_bool(node, "is-compress-dai"))
+			dai_drv->compress_new = snd_soc_new_compress;
+	}
+
+	return 0;
+}
+
 static int q6asm_dai_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -582,6 +955,8 @@ static int q6asm_dai_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, pdata);
 
+	of_q6asm_parse_dai_data(dev, pdata);
+
 	return devm_snd_soc_register_component(dev, &q6asm_fe_dai_component,
 					q6asm_fe_dais,
 					ARRAY_SIZE(q6asm_fe_dais));
-- 
2.19.0

