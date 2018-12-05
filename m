Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EE9C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA50521508
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="al2AiV1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA50521508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeLEJxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbeLEJw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:52:58 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D1E92151B;
        Wed,  5 Dec 2018 09:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003577;
        bh=bacdV9haAtLmafIS6DvI8f1QbHJ0tfE6AC73ZXSeUl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=al2AiV1RA77LstPDUJHQchqJLlfllp7nEX1hvUjFDZ9Ng/sjCd+nXVTAJJ7bSgdq7
         WhTi32uGbDSvbcwur2B+nmRIe2oV5z+7jBdQiduarGWW5EV2xxwoyFr0QFUlyHSfb0
         Ngm1kNjVXkFaDkluttjN4WUrw6+KrVK0oG0U23eQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 10/33] ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with CPU_IDLE
Date:   Wed,  5 Dec 2018 04:51:08 -0500
Message-Id: <20181205095131.7685-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095131.7685-1-sashal@kernel.org>
References: <20181205095131.7685-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 373a500e34aea97971c9d71e45edad458d3da98f ]

We need to block sleep states which would require longer time to leave than
the time the DMA must react to the DMA request in order to keep the FIFO
serviced without under of overrun.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/omap/omap-mcpdm.c | 43 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 8d0d45d330e7..8eb2d12b6a34 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -54,6 +54,8 @@ struct omap_mcpdm {
 	unsigned long phys_base;
 	void __iomem *io_base;
 	int irq;
+	struct pm_qos_request pm_qos_req;
+	int latency[2];
 
 	struct mutex mutex;
 
@@ -273,6 +275,9 @@ static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+	int tx = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	int stream1 = tx ? SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
+	int stream2 = tx ? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 
 	mutex_lock(&mcpdm->mutex);
 
@@ -285,6 +290,14 @@ static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
 		}
 	}
 
+	if (mcpdm->latency[stream2])
+		pm_qos_update_request(&mcpdm->pm_qos_req,
+				      mcpdm->latency[stream2]);
+	else if (mcpdm->latency[stream1])
+		pm_qos_remove_request(&mcpdm->pm_qos_req);
+
+	mcpdm->latency[stream1] = 0;
+
 	mutex_unlock(&mcpdm->mutex);
 }
 
@@ -296,7 +309,7 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 	int stream = substream->stream;
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	u32 threshold;
-	int channels;
+	int channels, latency;
 	int link_mask = 0;
 
 	channels = params_channels(params);
@@ -336,14 +349,25 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 
 		dma_data->maxburst =
 				(MCPDM_DN_THRES_MAX - threshold) * channels;
+		latency = threshold;
 	} else {
 		/* If playback is not running assume a stereo stream to come */
 		if (!mcpdm->config[!stream].link_mask)
 			mcpdm->config[!stream].link_mask = (0x3 << 3);
 
 		dma_data->maxburst = threshold * channels;
+		latency = (MCPDM_DN_THRES_MAX - threshold);
 	}
 
+	/*
+	 * The DMA must act to a DMA request within latency time (usec) to avoid
+	 * under/overflow
+	 */
+	mcpdm->latency[stream] = latency * USEC_PER_SEC / params_rate(params);
+
+	if (!mcpdm->latency[stream])
+		mcpdm->latency[stream] = 10;
+
 	/* Check if we need to restart McPDM with this stream */
 	if (mcpdm->config[stream].link_mask &&
 	    mcpdm->config[stream].link_mask != link_mask)
@@ -358,6 +382,20 @@ static int omap_mcpdm_prepare(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+	struct pm_qos_request *pm_qos_req = &mcpdm->pm_qos_req;
+	int tx = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	int stream1 = tx ? SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
+	int stream2 = tx ? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+	int latency = mcpdm->latency[stream2];
+
+	/* Prevent omap hardware from hitting off between FIFO fills */
+	if (!latency || mcpdm->latency[stream1] < latency)
+		latency = mcpdm->latency[stream1];
+
+	if (pm_qos_request_active(pm_qos_req))
+		pm_qos_update_request(pm_qos_req, latency);
+	else if (latency)
+		pm_qos_add_request(pm_qos_req, PM_QOS_CPU_DMA_LATENCY, latency);
 
 	if (!omap_mcpdm_active(mcpdm)) {
 		omap_mcpdm_start(mcpdm);
@@ -419,6 +457,9 @@ static int omap_mcpdm_remove(struct snd_soc_dai *dai)
 	free_irq(mcpdm->irq, (void *)mcpdm);
 	pm_runtime_disable(mcpdm->dev);
 
+	if (pm_qos_request_active(&mcpdm->pm_qos_req))
+		pm_qos_remove_request(&mcpdm->pm_qos_req);
+
 	return 0;
 }
 
-- 
2.17.1

