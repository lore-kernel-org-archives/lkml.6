Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFB0C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23089214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789399;
	bh=E6OkSgdvKY5ApcDBkLGyR6tT7OxnK6iFa3kuEj27NcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LcrEDgOl7OAJqGHX+/TOs6nMwyR2FX6Eqvs8zq6IGaUsUjkJ0CsL5ZDi41fP1DadY
	 WG1Sere9iU1YGCsQnJ+5RGA90mqckbcrakqXNThI3n0cUkf9JfITDkFmdi6jx0dx2Q
	 +ykg+jj/kbK6Ghg+gUhSfADXSsNmJxP89oNB9pl0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23089214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbeLNMJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731522AbeLNMJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D899214DB;
        Fri, 14 Dec 2018 12:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789392;
        bh=E6OkSgdvKY5ApcDBkLGyR6tT7OxnK6iFa3kuEj27NcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RgmuTT5dh6u1mRSoBKnhHKQJH1n5dxWpVIA7qq6wzbEtq5EocUrhVHwlC008FB8kb
         YReFTl+T6g8U/U+gabqkoY/uwSTHE9WoOnodtuE4ixna2Uc9stv1TmCrJc/2b3hILh
         d43n++eCWmN4n+ywny5Ybpx8NF2M+VO77o4gDPm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 42/89] ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with CPU_IDLE
Date:   Fri, 14 Dec 2018 12:59:55 +0100
Message-Id: <20181214115731.750514335@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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



