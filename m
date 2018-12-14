Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4250CC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3208214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789526;
	bh=Xn6/fW8xGdbFVdMAP91QURkQXJGbz5fAdZm8cZQoiqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ndXJRFVm8GQ4rQ2GMG136ihOnRdG339k22mqVD3DEkhsJUXdJO4urY4jJoHUYzBeR
	 lemcdqmfwV/bL6+P2lQAFn547jBgOEi6bjuEI4Uo/dbNifc40ZHMFvUGV9KGLuQqUL
	 E6L9LTHZetubm2payNcInIjFjVQFCcC0LW6+/Eno=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3208214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbeLNMME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731869AbeLNMMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:12:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B66621104;
        Fri, 14 Dec 2018 12:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789520;
        bh=Xn6/fW8xGdbFVdMAP91QURkQXJGbz5fAdZm8cZQoiqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axF9arEQJ8fY72vEf1kjCfsSlukgzPaa/KdPUqUsqK10YfQrhZReML4MXLcvP7TOc
         CevZbRSZmYVR+QP7nd/fX8EbeeyFrBaz9TodeSeO9BYXj2XIDeYUUHHmRmoMJ8Y7jC
         NWao4FyEBG8j0WV9IeYYaMsQ4bN8kD8Rt+GTjcwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 25/51] ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with CPU_IDLE
Date:   Fri, 14 Dec 2018 13:00:27 +0100
Message-Id: <20181214115715.647550208@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 64609c77a79d..44ffeb71cd1d 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -54,6 +54,8 @@ struct omap_mcpdm {
 	unsigned long phys_base;
 	void __iomem *io_base;
 	int irq;
+	struct pm_qos_request pm_qos_req;
+	int latency[2];
 
 	struct mutex mutex;
 
@@ -277,6 +279,9 @@ static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+	int tx = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	int stream1 = tx ? SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
+	int stream2 = tx ? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 
 	mutex_lock(&mcpdm->mutex);
 
@@ -289,6 +294,14 @@ static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
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
 
@@ -300,7 +313,7 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 	int stream = substream->stream;
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	u32 threshold;
-	int channels;
+	int channels, latency;
 	int link_mask = 0;
 
 	channels = params_channels(params);
@@ -340,14 +353,25 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 
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
@@ -362,6 +386,20 @@ static int omap_mcpdm_prepare(struct snd_pcm_substream *substream,
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
@@ -423,6 +461,9 @@ static int omap_mcpdm_remove(struct snd_soc_dai *dai)
 	free_irq(mcpdm->irq, (void *)mcpdm);
 	pm_runtime_disable(mcpdm->dev);
 
+	if (pm_qos_request_active(&mcpdm->pm_qos_req))
+		pm_qos_remove_request(&mcpdm->pm_qos_req);
+
 	return 0;
 }
 
-- 
2.19.1



