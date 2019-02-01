Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA87C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9C420811
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K5Dp0HKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfBAIs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:48:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfBAIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ofvy4DRKRwc1p2ccQlAyvHR+GYcYUgIMlkL4GALDEIQ=; b=K5Dp0HKkDpQQOoGsgqpd9hQw+W
        1cI2Wt5fC71ayCrmx6kBB8zKXuHn0jZ/85yb6b6Czia33X7bUa0Nx+vAP6k6Z6hAzSB16fxeLh0mg
        i49iM5GoqYTTmqR3pSJbLLsDofyY18N9erRCzVWpU/4rT/jgwrUgbu++7P1XSGpw6UcEBqJyqURSi
        y0CmJ7H4ZGiiXyRLLZtK79VInnWw6BTlKPO2z5kCrPQkFnJ2qiX2SutshUBubwY7rHYhowTMRtI33
        HXQ50m3pId7P4/vnJzMH9FkjyjjmfolqglbxmlY3MbWKUkHKWZhMOU1NXmafmOyoMSKsn11BKNmOf
        oscjPN3A==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUVG-0001XC-4S; Fri, 01 Feb 2019 08:48:50 +0000
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
Subject: [PATCH 18/18] ALSA: pass struct device to DMA API functions
Date:   Fri,  1 Feb 2019 09:48:01 +0100
Message-Id: <20190201084801.10983-19-hch@lst.de>
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

Also use GFP_KERNEL instead of GFP_USER as the gfp_t for the memory
allocation, as we should treat this allocation as a normal kernel one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 sound/mips/sgio2audio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 3ec9391a4736..53a4ee01c522 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -805,7 +805,7 @@ static int snd_sgio2audio_free(struct snd_sgio2audio *chip)
 		free_irq(snd_sgio2_isr_table[i].irq,
 			 &chip->channel[snd_sgio2_isr_table[i].idx]);
 
-	dma_free_coherent(NULL, MACEISA_RINGBUFFERS_SIZE,
+	dma_free_coherent(chip->card->dev, MACEISA_RINGBUFFERS_SIZE,
 			  chip->ring_base, chip->ring_base_dma);
 
 	/* release card data */
@@ -843,8 +843,9 @@ static int snd_sgio2audio_create(struct snd_card *card,
 
 	chip->card = card;
 
-	chip->ring_base = dma_alloc_coherent(NULL, MACEISA_RINGBUFFERS_SIZE,
-					     &chip->ring_base_dma, GFP_USER);
+	chip->ring_base = dma_alloc_coherent(card->dev,
+					     MACEISA_RINGBUFFERS_SIZE,
+					     &chip->ring_base_dma, GFP_KERNEL);
 	if (chip->ring_base == NULL) {
 		printk(KERN_ERR
 		       "sgio2audio: could not allocate ring buffers\n");
-- 
2.20.1

