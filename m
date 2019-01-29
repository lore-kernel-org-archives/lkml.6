Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9582DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0C7214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnOwqNX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfA2IGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:06:04 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35903 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfA2IGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:06:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so9019004plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1RHsO+ahj5vEQSwAL8dZDjQNelkN0VISShU3r9A/xGc=;
        b=WnOwqNX9US4BPX9/qlvhRJM/N+Nq7WVyRI1RF8GFS168/rUCUZASxA8mlXlu1p9p6A
         cVn1Ky61MVM5c3qt7fGJzSvSxjeMMuG6u9jWGm7MKj1lYt29yol+VCZh9HIwCmO9UIoO
         vzHOcyh06Q/8pP0W24bBN/UeIXCAEjNl5xxQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1RHsO+ahj5vEQSwAL8dZDjQNelkN0VISShU3r9A/xGc=;
        b=NF6Oo/0a5JdblNdoml43spOMx9KJ0NBWiW9JtIfaZBRsJ2cn0//08oWwYJdI6GxrCG
         9BzyXaQ8JU1Ab6QMO+pSrWxCL7vRG4QR9sdKIGyivJEQv6iVBAP5LNsAltizsWCQbswW
         p8OdRN2SO4S+79HrWBvG+7IxomJSr9ttaisvqfAoSGKw6W4Gkgvqa8Q/zmBhkdW8Rg02
         gm+vq90MZvQZnE0GO3RvYVR3Ao/9stJMkLtYjX7D+f90ltXN9lgP+cPUgEDfZrf4XXbt
         QlFrheW390nUeI/NIQT9XuWKXQTF59pRjE+FsmOeknxlFmvg9IP1q7n+Sq3g3x7I3F9R
         PgUA==
X-Gm-Message-State: AJcUukdjcTpaeGoeN2S9EqzpswvHUMBFEeUdgA9uAM2eikuiSU9Hm+bb
        ckScWPUCngIiElaNKvOIhEIwIw==
X-Google-Smtp-Source: ALg8bN7cboS15xV8h013XCYgRkWjH10y/Z+TTAfKavJwmkkNofKRDh8SeQc3EzTYN3HTIbqSqoXRxA==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr25425697pll.280.1548749162202;
        Tue, 29 Jan 2019 00:06:02 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v14sm40926177pgf.3.2019.01.29.00.05.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 00:06:01 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 2/2] ASoC: sprd: Add Spreadtrum audio DMA platfrom driver
Date:   Tue, 29 Jan 2019 16:04:45 +0800
Message-Id: <d02bf3a04f6bfcd28f9689cbb6b4dff0132b71da.1548747137.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <15c562bcfd488fbf1979a69f96ddbd8df57f7e69.1548747137.git.baolin.wang@linaro.org>
References: <15c562bcfd488fbf1979a69f96ddbd8df57f7e69.1548747137.git.baolin.wang@linaro.org>
In-Reply-To: <15c562bcfd488fbf1979a69f96ddbd8df57f7e69.1548747137.git.baolin.wang@linaro.org>
References: <15c562bcfd488fbf1979a69f96ddbd8df57f7e69.1548747137.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum DMA engine uses the link-list mode to support audio playback
or capture, thus this patch adds audio DMA platform support for CPU DAI to
trigger DMA link-list transfer.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 sound/soc/Kconfig             |    1 +
 sound/soc/Makefile            |    1 +
 sound/soc/sprd/Kconfig        |    6 +
 sound/soc/sprd/Makefile       |    4 +
 sound/soc/sprd/sprd-pcm-dma.c |  562 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/sprd/sprd-pcm-dma.h |   15 ++
 6 files changed, 589 insertions(+)
 create mode 100644 sound/soc/sprd/Kconfig
 create mode 100644 sound/soc/sprd/Makefile
 create mode 100644 sound/soc/sprd/sprd-pcm-dma.c
 create mode 100644 sound/soc/sprd/sprd-pcm-dma.h

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 6592a42..aa35940 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -64,6 +64,7 @@ source "sound/soc/samsung/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/sirf/Kconfig"
 source "sound/soc/spear/Kconfig"
+source "sound/soc/sprd/Kconfig"
 source "sound/soc/sti/Kconfig"
 source "sound/soc/stm/Kconfig"
 source "sound/soc/sunxi/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 48c48c1..974fb98 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= sirf/
 obj-$(CONFIG_SND_SOC)	+= spear/
+obj-$(CONFIG_SND_SOC)	+= sprd/
 obj-$(CONFIG_SND_SOC)	+= sti/
 obj-$(CONFIG_SND_SOC)	+= stm/
 obj-$(CONFIG_SND_SOC)	+= sunxi/
diff --git a/sound/soc/sprd/Kconfig b/sound/soc/sprd/Kconfig
new file mode 100644
index 0000000..43ece7d
--- /dev/null
+++ b/sound/soc/sprd/Kconfig
@@ -0,0 +1,6 @@
+config SND_SOC_SPRD
+	tristate "SoC Audio for the Spreadtrum SoC chips"
+	depends on ARCH_SPRD || COMPILE_TEST
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the Spreadtrum SoCs' Audio interfaces.
diff --git a/sound/soc/sprd/Makefile b/sound/soc/sprd/Makefile
new file mode 100644
index 0000000..47620e5
--- /dev/null
+++ b/sound/soc/sprd/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Spreadtrum Audio Support
+
+obj-$(CONFIG_SND_SOC_SPRD)	+= sprd-pcm-dma.o
diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
new file mode 100644
index 0000000..cbb27c4
--- /dev/null
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Spreadtrum Communications Inc.
+
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/dma/sprd-dma.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "sprd-pcm-dma.h"
+
+#define DRV_NAME			"sprd_pcm_dma"
+#define SPRD_PCM_DMA_LINKLIST_SIZE	64
+#define SPRD_PCM_DMA_BRUST_LEN		640
+
+struct sprd_pcm_dma_data {
+	struct dma_chan *chan;
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+	dma_addr_t phys;
+	void *virt;
+	int pre_pointer;
+};
+
+struct sprd_pcm_dma_private {
+	struct snd_pcm_substream *substream;
+	struct sprd_pcm_dma_params *params;
+	struct sprd_pcm_dma_data data[SPRD_PCM_CHANNEL_MAX];
+	int hw_chan;
+	int dma_addr_offset;
+};
+
+static const struct snd_pcm_hardware sprd_pcm_hardware = {
+	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_RESUME | SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	.period_bytes_min = 1,
+	.period_bytes_max = 64 * 1024,
+	.periods_min = 1,
+	.periods_max = PAGE_SIZE / SPRD_PCM_DMA_LINKLIST_SIZE,
+	.buffer_bytes_max = 64 * 1024,
+};
+
+static int sprd_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
+	struct sprd_pcm_dma_private *dma_private;
+	int hw_chan = SPRD_PCM_CHANNEL_MAX;
+	int size, ret, i;
+
+	snd_soc_set_runtime_hwparams(substream, &sprd_pcm_hardware);
+
+	ret = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+					 SPRD_PCM_DMA_BRUST_LEN);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+					 SPRD_PCM_DMA_BRUST_LEN);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	dma_private = devm_kzalloc(dev, sizeof(*dma_private), GFP_KERNEL);
+	if (!dma_private)
+		return -ENOMEM;
+
+	size = runtime->hw.periods_max * SPRD_PCM_DMA_LINKLIST_SIZE;
+
+	for (i = 0; i < hw_chan; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		data->virt = dmam_alloc_coherent(dev, size, &data->phys,
+						 GFP_KERNEL);
+		if (!data->virt) {
+			ret = -ENOMEM;
+			goto error;
+		}
+	}
+
+	dma_private->hw_chan = hw_chan;
+	runtime->private_data = dma_private;
+	dma_private->substream = substream;
+
+	return 0;
+
+error:
+	for (i = 0; i < hw_chan; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		if (data->virt)
+			dmam_free_coherent(dev, size, data->virt, data->phys);
+	}
+
+	devm_kfree(dev, dma_private);
+	return ret;
+}
+
+static int sprd_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sprd_pcm_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
+	int size = runtime->hw.periods_max * SPRD_PCM_DMA_LINKLIST_SIZE;
+	int i;
+
+	for (i = 0; i < dma_private->hw_chan; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		dmam_free_coherent(dev, size, data->virt, data->phys);
+	}
+
+	devm_kfree(dev, dma_private);
+
+	return 0;
+}
+
+static void sprd_pcm_dma_complete(void *data)
+{
+	struct sprd_pcm_dma_private *dma_private = data;
+	struct snd_pcm_substream *substream = dma_private->substream;
+
+	snd_pcm_period_elapsed(substream);
+}
+
+static void sprd_pcm_release_dma_channel(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sprd_pcm_dma_private *dma_private = runtime->private_data;
+	int i;
+
+	for (i = 0; i < SPRD_PCM_CHANNEL_MAX; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		if (data->chan) {
+			dma_release_channel(data->chan);
+			data->chan = NULL;
+		}
+	}
+}
+
+static int sprd_pcm_request_dma_channel(struct snd_pcm_substream *substream,
+					int channels)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sprd_pcm_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
+	struct sprd_pcm_dma_params *dma_params = dma_private->params;
+	int i;
+
+	if (channels > SPRD_PCM_CHANNEL_MAX) {
+		dev_err(dev, "invalid dma channel number:%d\n", channels);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < channels; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		data->chan = dma_request_slave_channel(dev,
+						       dma_params->chan_name[i]);
+		if (!data->chan) {
+			dev_err(dev, "failed to request dma channel:%s\n",
+				dma_params->chan_name[i]);
+			sprd_pcm_release_dma_channel(substream);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+static int sprd_pcm_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sprd_pcm_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct sprd_pcm_dma_params *dma_params;
+	size_t totsize = params_buffer_bytes(params);
+	size_t period = params_period_bytes(params);
+	int channels = params_channels(params);
+	int is_playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	struct scatterlist *sg;
+	unsigned long flags;
+	int ret, i, j, sg_num;
+
+	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+	if (!dma_params) {
+		dev_warn(component->dev, "no dma parameters setting\n");
+		dma_private->params = NULL;
+		snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+		runtime->dma_bytes = totsize;
+		return 0;
+	}
+
+	if (!dma_private->params) {
+		dma_private->params = dma_params;
+		ret = sprd_pcm_request_dma_channel(substream, channels);
+		if (ret)
+			return ret;
+	}
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+
+	runtime->dma_bytes = totsize;
+	sg_num = totsize / period;
+	dma_private->dma_addr_offset = totsize / channels;
+
+	sg = devm_kcalloc(component->dev, sg_num, sizeof(*sg), GFP_KERNEL);
+	if (!sg) {
+		ret = -ENOMEM;
+		goto sg_err;
+	}
+
+	for (i = 0; i < channels; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+		struct dma_chan *chan = data->chan;
+		struct dma_slave_config config = { };
+		struct sprd_dma_linklist link = { };
+		enum dma_transfer_direction dir;
+		struct scatterlist *sgt = sg;
+
+		config.src_maxburst = dma_params->fragment_len[i];
+		config.src_addr_width = dma_params->datawidth[i];
+		config.dst_addr_width = dma_params->datawidth[i];
+		if (is_playback) {
+			config.src_addr = runtime->dma_addr +
+				i * dma_private->dma_addr_offset;
+			config.dst_addr = dma_params->dev_phys[i];
+			dir = DMA_MEM_TO_DEV;
+		} else {
+			config.src_addr = dma_params->dev_phys[i];
+			config.dst_addr = runtime->dma_addr +
+				i * dma_private->dma_addr_offset;
+			dir = DMA_DEV_TO_MEM;
+		}
+
+		sg_init_table(sgt, sg_num);
+		for (j = 0; j < sg_num; j++, sgt++) {
+			u32 sg_len = period / channels;
+
+			sg_dma_len(sgt) = sg_len;
+			sg_dma_address(sgt) = runtime->dma_addr +
+				i * dma_private->dma_addr_offset + sg_len * j;
+		}
+
+		/*
+		 * Configure the link-list address for the DMA engine link-list
+		 * mode.
+		 */
+		link.virt_addr = (unsigned long)data->virt;
+		link.phy_addr = data->phys;
+
+		ret = dmaengine_slave_config(chan, &config);
+		if (ret) {
+			dev_err(component->dev,
+				"failed to set slave configuration: %d\n", ret);
+			goto config_err;
+		}
+
+		/*
+		 * We configure the DMA request mode, interrupt mode, channel
+		 * mode and channel trigger mode by the flags.
+		 */
+		flags = SPRD_DMA_FLAGS(SPRD_DMA_CHN_MODE_NONE, SPRD_DMA_NO_TRG,
+				       SPRD_DMA_FRAG_REQ, SPRD_DMA_TRANS_INT);
+		data->desc = chan->device->device_prep_slave_sg(chan, sg,
+								sg_num, dir,
+								flags, &link);
+		if (!data->desc) {
+			dev_err(component->dev, "failed to prepare slave sg\n");
+			ret = -ENOMEM;
+			goto config_err;
+		}
+
+		if (!runtime->no_period_wakeup) {
+			data->desc->callback = sprd_pcm_dma_complete;
+			data->desc->callback_param = dma_private;
+		}
+	}
+
+	devm_kfree(component->dev, sg);
+
+	return 0;
+
+config_err:
+	devm_kfree(component->dev, sg);
+sg_err:
+	sprd_pcm_release_dma_channel(substream);
+	return ret;
+}
+
+static int sprd_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	sprd_pcm_release_dma_channel(substream);
+
+	return 0;
+}
+
+static int sprd_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct sprd_pcm_dma_private *dma_private =
+		substream->runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	int ret = 0, i;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		for (i = 0; i < dma_private->hw_chan; i++) {
+			struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+			if (!data->desc)
+				continue;
+
+			data->cookie = dmaengine_submit(data->desc);
+			ret = dma_submit_error(data->cookie);
+			if (ret) {
+				dev_err(component->dev,
+					"failed to submit dma request: %d\n",
+					ret);
+				return ret;
+			}
+
+			dma_async_issue_pending(data->chan);
+		}
+
+		break;
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		for (i = 0; i < dma_private->hw_chan; i++) {
+			struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+			if (data->chan)
+				dmaengine_resume(data->chan);
+		}
+
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		for (i = 0; i < dma_private->hw_chan; i++) {
+			struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+			if (data->chan)
+				dmaengine_terminate_async(data->chan);
+		}
+
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		for (i = 0; i < dma_private->hw_chan; i++) {
+			struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+			if (data->chan)
+				dmaengine_pause(data->chan);
+		}
+
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t sprd_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sprd_pcm_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	int pointer[SPRD_PCM_CHANNEL_MAX];
+	int bytes_of_pointer = 0, sel_max = 0, i;
+	snd_pcm_uframes_t x;
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	for (i = 0; i < dma_private->hw_chan; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		if (!data->chan)
+			continue;
+
+		status = dmaengine_tx_status(data->chan, data->cookie, &state);
+		if (status == DMA_ERROR) {
+			dev_err(component->dev,
+				"failed to get dma channel %d status\n", i);
+			return 0;
+		}
+
+		/*
+		 * We just get current transfer address from the DMA engine, so
+		 * we need convert to current pointer.
+		 */
+		pointer[i] = state.residue - runtime->dma_addr -
+			i * dma_private->dma_addr_offset;
+
+		if (i == 0) {
+			bytes_of_pointer = pointer[i];
+			sel_max = pointer[i] < data->pre_pointer ? 1 : 0;
+		} else {
+			sel_max ^= pointer[i] < data->pre_pointer ? 1 : 0;
+
+			if (sel_max)
+				bytes_of_pointer =
+					max(pointer[i], pointer[i - 1]) << 1;
+			else
+				bytes_of_pointer =
+					min(pointer[i], pointer[i - 1]) << 1;
+		}
+
+		data->pre_pointer = pointer[i];
+	}
+
+	x = bytes_to_frames(runtime, bytes_of_pointer);
+	if (x == runtime->buffer_size)
+		x = 0;
+
+	return x;
+}
+
+static int sprd_pcm_mmap(struct snd_pcm_substream *substream,
+			 struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	return remap_pfn_range(vma, vma->vm_start,
+			       runtime->dma_addr >> PAGE_SHIFT,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot);
+}
+
+static struct snd_pcm_ops sprd_pcm_ops = {
+	.open = sprd_pcm_open,
+	.close = sprd_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = sprd_pcm_hw_params,
+	.hw_free = sprd_pcm_hw_free,
+	.trigger = sprd_pcm_trigger,
+	.pointer = sprd_pcm_pointer,
+	.mmap = sprd_pcm_mmap,
+};
+
+static int sprd_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_card *card = rtd->card->snd_card;
+	struct snd_pcm *pcm = rtd->pcm;
+	struct snd_pcm_substream *substream;
+	int ret;
+
+	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	if (substream) {
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
+					  sprd_pcm_hardware.buffer_bytes_max,
+					  &substream->dma_buffer);
+		if (ret) {
+			dev_err(card->dev,
+				"can't alloc playback dma buffer: %d\n", ret);
+			return ret;
+		}
+	}
+
+	substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
+	if (substream) {
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
+					  sprd_pcm_hardware.buffer_bytes_max,
+					  &substream->dma_buffer);
+		if (ret) {
+			dev_err(card->dev,
+				"can't alloc capture dma buffer: %d\n", ret);
+			snd_dma_free_pages(&pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->dma_buffer);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void sprd_pcm_free(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcm->streams); i++) {
+		substream = pcm->streams[i].substream;
+		if (substream) {
+			snd_dma_free_pages(&substream->dma_buffer);
+			substream->dma_buffer.area = NULL;
+			substream->dma_buffer.addr = 0;
+		}
+	}
+}
+
+static const struct snd_soc_component_driver sprd_soc_component = {
+	.name		= DRV_NAME,
+	.ops		= &sprd_pcm_ops,
+	.pcm_new	= sprd_pcm_new,
+	.pcm_free	= sprd_pcm_free,
+};
+
+static int sprd_soc_platform_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &sprd_soc_component,
+					      NULL, 0);
+	if (ret)
+		dev_err(&pdev->dev, "could not register platform:%d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id sprd_pcm_of_match[] = {
+	{ .compatible = "sprd,pcm-platform", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sprd_pcm_of_match);
+
+static struct platform_driver sprd_pcm_driver = {
+	.driver = {
+		.name = "sprd-pcm-audio",
+		.of_match_table = sprd_pcm_of_match,
+	},
+
+	.probe = sprd_soc_platform_probe,
+};
+
+module_platform_driver(sprd_pcm_driver);
+
+MODULE_DESCRIPTION("Spreadtrum ASoC PCM DMA");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:sprd-audio");
diff --git a/sound/soc/sprd/sprd-pcm-dma.h b/sound/soc/sprd/sprd-pcm-dma.h
new file mode 100644
index 0000000..d85a34f
--- /dev/null
+++ b/sound/soc/sprd/sprd-pcm-dma.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __SPRD_PCM_DMA_H
+#define __SPRD_PCM_DMA_H
+
+#define SPRD_PCM_CHANNEL_MAX	2
+
+struct sprd_pcm_dma_params {
+	dma_addr_t dev_phys[SPRD_PCM_CHANNEL_MAX];
+	u32 datawidth[SPRD_PCM_CHANNEL_MAX];
+	u32 fragment_len[SPRD_PCM_CHANNEL_MAX];
+	const char *chan_name[SPRD_PCM_CHANNEL_MAX];
+};
+
+#endif /* __SPRD_PCM_DMA_H */
-- 
1.7.9.5

