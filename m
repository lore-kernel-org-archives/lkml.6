Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52BDC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C2D20811
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rYp9fq00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfBAItF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:49:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfBAIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sDvNmJs8bLWN8SRNm+1jJVi3Azpnxg3FQ88vYOYjmqM=; b=rYp9fq00R2A5NFcaGo1WysE2b5
        z1oTMVXVCSJAWD1vXGa/IpeZ0g8OYNw/huozJPW+ERT1fx12038hUUyrUkVWuap733AD8BHQuq54k
        4odzkyshU4mcUJApZ/gFx85PvcmgLlAgG/vUCkqrh7EXL2c/vLcJ8f06QEXQpiiH93iRqPcgLu1qZ
        ERD/AAgqxENUCwVckMEKB1dWETayLfEgcEWtobHTN9MzcYO1hMt362gJgdJqmI1Gv6MgchY6rq31p
        oT56KGKMg+4XeY0gJdWaJmXFbjZUahXES5QdUL7s0PYcQa0ey7S2UliwVREZWs/1vjuV0TFMEkmnN
        E/WuDwaw==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUVD-0001Wd-DA; Fri, 01 Feb 2019 08:48:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     iommu@lists.linux-foundation.org
Subject: [PATCH 17/18] ALSA: hal2: pass struct device to DMA API functions
Date:   Fri,  1 Feb 2019 09:48:00 +0100
Message-Id: <20190201084801.10983-18-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 sound/mips/hal2.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index a4ed54aeaf1d..d63e1565b62b 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -454,21 +454,22 @@ static inline void hal2_stop_adc(struct snd_hal2 *hal2)
 	hal2->adc.pbus.pbus->pbdma_ctrl = HPC3_PDMACTRL_LD;
 }
 
-static int hal2_alloc_dmabuf(struct hal2_codec *codec)
+static int hal2_alloc_dmabuf(struct snd_hal2 *hal2, struct hal2_codec *codec)
 {
+	struct device *dev = hal2->card->dev;
 	struct hal2_desc *desc;
 	dma_addr_t desc_dma, buffer_dma;
 	int count = H2_BUF_SIZE / H2_BLOCK_SIZE;
 	int i;
 
-	codec->buffer = dma_alloc_attrs(NULL, H2_BUF_SIZE, &buffer_dma,
+	codec->buffer = dma_alloc_attrs(dev, H2_BUF_SIZE, &buffer_dma,
 					GFP_KERNEL, DMA_ATTR_NON_CONSISTENT);
 	if (!codec->buffer)
 		return -ENOMEM;
-	desc = dma_alloc_attrs(NULL, count * sizeof(struct hal2_desc),
+	desc = dma_alloc_attrs(dev, count * sizeof(struct hal2_desc),
 			       &desc_dma, GFP_KERNEL, DMA_ATTR_NON_CONSISTENT);
 	if (!desc) {
-		dma_free_attrs(NULL, H2_BUF_SIZE, codec->buffer, buffer_dma,
+		dma_free_attrs(dev, H2_BUF_SIZE, codec->buffer, buffer_dma,
 			       DMA_ATTR_NON_CONSISTENT);
 		return -ENOMEM;
 	}
@@ -482,17 +483,19 @@ static int hal2_alloc_dmabuf(struct hal2_codec *codec)
 		      desc_dma : desc_dma + (i + 1) * sizeof(struct hal2_desc);
 		desc++;
 	}
-	dma_cache_sync(NULL, codec->desc, count * sizeof(struct hal2_desc),
+	dma_cache_sync(dev, codec->desc, count * sizeof(struct hal2_desc),
 		       DMA_TO_DEVICE);
 	codec->desc_count = count;
 	return 0;
 }
 
-static void hal2_free_dmabuf(struct hal2_codec *codec)
+static void hal2_free_dmabuf(struct snd_hal2 *hal2, struct hal2_codec *codec)
 {
-	dma_free_attrs(NULL, codec->desc_count * sizeof(struct hal2_desc),
+	struct device *dev = hal2->card->dev;
+
+	dma_free_attrs(dev, codec->desc_count * sizeof(struct hal2_desc),
 		       codec->desc, codec->desc_dma, DMA_ATTR_NON_CONSISTENT);
-	dma_free_attrs(NULL, H2_BUF_SIZE, codec->buffer, codec->buffer_dma,
+	dma_free_attrs(dev, H2_BUF_SIZE, codec->buffer, codec->buffer_dma,
 		       DMA_ATTR_NON_CONSISTENT);
 }
 
@@ -540,7 +543,7 @@ static int hal2_playback_open(struct snd_pcm_substream *substream)
 
 	runtime->hw = hal2_pcm_hw;
 
-	err = hal2_alloc_dmabuf(&hal2->dac);
+	err = hal2_alloc_dmabuf(hal2, &hal2->dac);
 	if (err)
 		return err;
 	return 0;
@@ -550,7 +553,7 @@ static int hal2_playback_close(struct snd_pcm_substream *substream)
 {
 	struct snd_hal2 *hal2 = snd_pcm_substream_chip(substream);
 
-	hal2_free_dmabuf(&hal2->dac);
+	hal2_free_dmabuf(hal2, &hal2->dac);
 	return 0;
 }
 
@@ -606,7 +609,7 @@ static void hal2_playback_transfer(struct snd_pcm_substream *substream,
 	unsigned char *buf = hal2->dac.buffer + rec->hw_data;
 
 	memcpy(buf, substream->runtime->dma_area + rec->sw_data, bytes);
-	dma_cache_sync(NULL, buf, bytes, DMA_TO_DEVICE);
+	dma_cache_sync(hal2->card->dev, buf, bytes, DMA_TO_DEVICE);
 
 }
 
@@ -629,7 +632,7 @@ static int hal2_capture_open(struct snd_pcm_substream *substream)
 
 	runtime->hw = hal2_pcm_hw;
 
-	err = hal2_alloc_dmabuf(adc);
+	err = hal2_alloc_dmabuf(hal2, adc);
 	if (err)
 		return err;
 	return 0;
@@ -639,7 +642,7 @@ static int hal2_capture_close(struct snd_pcm_substream *substream)
 {
 	struct snd_hal2 *hal2 = snd_pcm_substream_chip(substream);
 
-	hal2_free_dmabuf(&hal2->adc);
+	hal2_free_dmabuf(hal2, &hal2->adc);
 	return 0;
 }
 
@@ -694,7 +697,7 @@ static void hal2_capture_transfer(struct snd_pcm_substream *substream,
 	struct snd_hal2 *hal2 = snd_pcm_substream_chip(substream);
 	unsigned char *buf = hal2->adc.buffer + rec->hw_data;
 
-	dma_cache_sync(NULL, buf, bytes, DMA_FROM_DEVICE);
+	dma_cache_sync(hal2->card->dev, buf, bytes, DMA_FROM_DEVICE);
 	memcpy(substream->runtime->dma_area + rec->sw_data, buf, bytes);
 }
 
-- 
2.20.1

