Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3E2C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34F5206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WK41U7fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34F5206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJMWy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:54:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbeJMWy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tcC8xrkkOdyIZRtHgdxxUrp01s1PVG+ePaNmiszFAyg=; b=WK41U7flCvW82MAelHWTtdPOtK
        /HtgvrAUFK+N6b+mfJLbtt0e9MZBPKUn7j7Eb6VE/fiLebtC9e+QInYd1Ef2nkEdCSydOIMdoljMV
        fQwH6k+VN4jr90d7r/sX7jk/YoRn4tVWGaZu8XBtMVx4OwTMaFyNwerxrC3ePqKmmzAv6zzkcuXzB
        r9wNsEe6zKuHptbYDhRF8lk8+5tVR97/WQmq2fBXe30FwoPt70tHPkwd06vxxsm3GKE9dNnOITA1A
        Nnzn75ruKFLYEnmLD6g0NbTl8qBp8B1kaCYOgZhdO742cBkN0Ixw82dXZTsJ50R4kEL0vjeflFp4P
        /1Lkh9Sg==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBLfP-00051u-5q; Sat, 13 Oct 2018 15:17:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] sound: intel/sst: don't pass GFP_DMA32 to dma_alloc_coherent
Date:   Sat, 13 Oct 2018 17:17:04 +0200
Message-Id: <20181013151707.32210-6-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181013151707.32210-1-hch@lst.de>
References: <20181013151707.32210-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA API does its own zone decisions based on the coherent_dma_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 sound/soc/intel/common/sst-firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 11041aedea31..1e067504b604 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -355,7 +355,7 @@ struct sst_fw *sst_fw_new(struct sst_dsp *dsp,
 
 	/* allocate DMA buffer to store FW data */
 	sst_fw->dma_buf = dma_alloc_coherent(dsp->dma_dev, sst_fw->size,
-				&sst_fw->dmable_fw_paddr, GFP_DMA | GFP_KERNEL);
+				&sst_fw->dmable_fw_paddr, GFP_KERNEL);
 	if (!sst_fw->dma_buf) {
 		dev_err(dsp->dev, "error: DMA alloc failed\n");
 		kfree(sst_fw);
-- 
2.19.1

