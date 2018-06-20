Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD82C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54B820872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54B820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeFTJZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:25:33 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:50439 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeFTJZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:25:29 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1fVZMj-0000QQ-RG from Jiada_Wang@mentor.com ; Wed, 20 Jun 2018 02:25:25 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 20 Jun 2018 02:25:22 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH 1/1] ASoC: soc-pcm: DPCM cares BE channel constraint
Date:   Wed, 20 Jun 2018 18:25:20 +0900
Message-ID: <20180620092520.14101-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

Current DPCM is caring only FE channel configuration. Sometimes
it will be trouble if user selects channel which isn't supported
by BE.

This patch adds new .dpcm_merged_chan on struct snd_soc_dai_link.
DPCM will use FE / BE merged channel if struct snd_soc_dai_link
has it.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 include/sound/soc.h |  2 ++
 sound/soc/soc-pcm.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1378dcd2128a..f7579f82cc00 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -957,6 +957,8 @@ struct snd_soc_dai_link {
 
 	/* DPCM used FE & BE merged format */
 	unsigned int dpcm_merged_format:1;
+	/* DPCM used FE & BE merged channel */
+	unsigned int dpcm_merged_chan:1;
 
 	/* pmdown_time is ignored at stop */
 	unsigned int ignore_pmdown_time:1;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 45b52f7b9690..19ebfc958b9d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1715,6 +1715,46 @@ static u64 dpcm_runtime_base_format(struct snd_pcm_substream *substream)
 	return formats;
 }
 
+static void dpcm_runtime_base_chan(struct snd_pcm_substream *substream,
+				   unsigned int *channels_min,
+				   unsigned int *channels_max)
+{
+	struct snd_soc_pcm_runtime *fe = substream->private_data;
+	struct snd_soc_dpcm *dpcm;
+	int stream = substream->stream;
+
+	if (!fe->dai_link->dpcm_merged_chan)
+		return;
+
+	*channels_min = 0;
+	*channels_max = UINT_MAX;
+
+	/*
+	 * It returns merged BE codec channel;
+	 * if FE want to use it (= dpcm_merged_chan)
+	 */
+
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_soc_dai_driver *codec_dai_drv;
+		struct snd_soc_pcm_stream *codec_stream;
+		int i;
+
+		for (i = 0; i < be->num_codecs; i++) {
+			codec_dai_drv = be->codec_dais[i]->driver;
+			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+				codec_stream = &codec_dai_drv->playback;
+			else
+				codec_stream = &codec_dai_drv->capture;
+
+			*channels_min = max(*channels_min,
+					    codec_stream->channels_min);
+			*channels_max = min(*channels_max,
+					    codec_stream->channels_max);
+		}
+	}
+}
+
 static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1722,11 +1762,17 @@ static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai_driver *cpu_dai_drv = cpu_dai->driver;
 	u64 format = dpcm_runtime_base_format(substream);
+	unsigned int channels_min = 0, channels_max = UINT_MAX;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->playback, format);
 	else
 		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->capture, format);
+
+	dpcm_runtime_base_chan(substream, &channels_min, &channels_max);
+
+	runtime->hw.channels_min = max(channels_min, runtime->hw.channels_min);
+	runtime->hw.channels_max = min(channels_max, runtime->hw.channels_max);
 }
 
 static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd);
-- 
2.17.0

