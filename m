Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44115C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 17:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC63208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 17:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC63208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936864AbeFQRFX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 13:05:23 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:57530 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934840AbeFQRDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 13:03:15 -0400
Received: from belgarion.home ([90.55.203.186])
        by mwinf5d83 with ME
        id zt2e1x00N41oiFu03t3BSr; Sun, 17 Jun 2018 19:03:13 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 17 Jun 2018 19:03:13 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Pitre <nico@fluxnic.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH v3 09/14] ASoC: pxa: remove the dmaengine compat need
Date:   Sun, 17 Jun 2018 19:02:12 +0200
Message-Id: <20180617170217.24177-10-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180617170217.24177-1-robert.jarzmik@free.fr>
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Reviewed-by: Daniel Mack <daniel@zonque.org>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/arm/pxa2xx-ac97.c     | 14 ++------------
 sound/arm/pxa2xx-pcm-lib.c  |  6 +++---
 sound/soc/pxa/pxa2xx-ac97.c | 32 +++++---------------------------
 sound/soc/pxa/pxa2xx-i2s.c  |  6 ++----
 4 files changed, 12 insertions(+), 46 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 4bc244c40f80..236a63cdaf9f 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -63,28 +63,18 @@ static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 	.reset	= pxa2xx_ac97_legacy_reset,
 };
 
-static struct pxad_param pxa2xx_ac97_pcm_out_req = {
-	.prio = PXAD_PRIO_LOWEST,
-	.drcmr = 12,
-};
-
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_out = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.chan_name	= "pcm_pcm_stereo_out",
 	.maxburst	= 32,
-	.filter_data	= &pxa2xx_ac97_pcm_out_req,
-};
-
-static struct pxad_param pxa2xx_ac97_pcm_in_req = {
-	.prio = PXAD_PRIO_LOWEST,
-	.drcmr = 11,
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_in = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.chan_name	= "pcm_pcm_stereo_in",
 	.maxburst	= 32,
-	.filter_data	= &pxa2xx_ac97_pcm_in_req,
 };
 
 static struct snd_pcm *pxa2xx_ac97_pcm;
diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index e8da3b8ee721..dcbe7ecc1835 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -125,9 +125,9 @@ int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		return ret;
 
-	return snd_dmaengine_pcm_open_request_chan(substream,
-					pxad_filter_fn,
-					dma_params->filter_data);
+	return snd_dmaengine_pcm_open(
+		substream, dma_request_slave_channel(rtd->cpu_dai->dev,
+						     dma_params->chan_name));
 }
 EXPORT_SYMBOL(__pxa2xx_pcm_open);
 
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 803818aabee9..1b41c0f2a8fb 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -68,61 +68,39 @@ static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
 	.reset	= pxa2xx_ac97_cold_reset,
 };
 
-static struct pxad_param pxa2xx_ac97_pcm_stereo_in_req = {
-	.prio = PXAD_PRIO_LOWEST,
-	.drcmr = 11,
-};
-
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_in = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.chan_name	= "pcm_pcm_stereo_in",
 	.maxburst	= 32,
-	.filter_data	= &pxa2xx_ac97_pcm_stereo_in_req,
-};
-
-static struct pxad_param pxa2xx_ac97_pcm_stereo_out_req = {
-	.prio = PXAD_PRIO_LOWEST,
-	.drcmr = 12,
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_out = {
 	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.chan_name	= "pcm_pcm_stereo_out",
 	.maxburst	= 32,
-	.filter_data	= &pxa2xx_ac97_pcm_stereo_out_req,
 };
 
-static struct pxad_param pxa2xx_ac97_pcm_aux_mono_out_req = {
-	.prio = PXAD_PRIO_LOWEST,
-	.drcmr = 10,
-};
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_out = {
 	.addr		= __PREG(MODR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
+	.chan_name	= "pcm_aux_mono_out",
 	.maxburst	= 16,
-	.filter_data	= &pxa2xx_ac97_pcm_aux_mono_out_req,
 };
 
-static struct pxad_param pxa2xx_ac97_pcm_aux_mono_in_req = {
-	.prio = PXAD_PRIO_LOWEST,
-	.drcmr = 9,
-};
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_in = {
 	.addr		= __PREG(MODR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
+	.chan_name	= "pcm_aux_mono_in",
 	.maxburst	= 16,
-	.filter_data	= &pxa2xx_ac97_pcm_aux_mono_in_req,
 };
 
-static struct pxad_param pxa2xx_ac97_pcm_aux_mic_mono_req = {
-	.prio = PXAD_PRIO_LOWEST,
-	.drcmr = 8,
-};
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_mic_mono_in = {
 	.addr		= __PREG(MCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
+	.chan_name	= "pcm_aux_mic_mono",
 	.maxburst	= 16,
-	.filter_data	= &pxa2xx_ac97_pcm_aux_mic_mono_req,
 };
 
 static int pxa2xx_ac97_hifi_startup(struct snd_pcm_substream *substream,
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 3fb60baf6eab..e7184de0de04 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -82,20 +82,18 @@ static struct pxa_i2s_port pxa_i2s;
 static struct clk *clk_i2s;
 static int clk_ena = 0;
 
-static unsigned long pxa2xx_i2s_pcm_stereo_out_req = 3;
 static struct snd_dmaengine_dai_dma_data pxa2xx_i2s_pcm_stereo_out = {
 	.addr		= __PREG(SADR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.chan_name	= "tx",
 	.maxburst	= 32,
-	.filter_data	= &pxa2xx_i2s_pcm_stereo_out_req,
 };
 
-static unsigned long pxa2xx_i2s_pcm_stereo_in_req = 2;
 static struct snd_dmaengine_dai_dma_data pxa2xx_i2s_pcm_stereo_in = {
 	.addr		= __PREG(SADR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.chan_name	= "rx",
 	.maxburst	= 32,
-	.filter_data	= &pxa2xx_i2s_pcm_stereo_in_req,
 };
 
 static int pxa2xx_i2s_startup(struct snd_pcm_substream *substream,
-- 
2.11.0

