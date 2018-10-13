Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5240C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCDC21477
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hRd0LCPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCDC21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJMWzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:55:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbeJMWzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IVkBQvsZS3TE4cW5kvh+t4tiXvMmm+B1CJIcTNKU7uY=; b=hRd0LCPM/yewkRw5sWfXut1ZOo
        BWPFBKYDBcBjojSOcWY+qjGc66wMuNMA4zXuF11YN64RF8MXLpUoPZJR/OhztT5TzR3HFKFt4MZUZ
        UIMZVtluMQMJ62R9KLbFri0Dp+LIGKGoUCJadztJjBh48NIVG9Mu0ZDNtKllF1SxBlFQwJj5SQnE6
        HAcKdRJHPjZ/+jOnp9GfOx/cu8x71vPP2PPrz/OZiPnxtu+JXvC2b68GRujibBKquViCZ+bYEQyXL
        D+OddSB2tXxBqZREZq3wqPE+p55zCor4j8AiYbX25YXiA/iqvIVCMoS5Vr6DOkRDIsaVqj1e3SdYP
        Ir7CzJqQ==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBLfU-00053L-M9; Sat, 13 Oct 2018 15:17:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] media: sti/bdisp: don't pass GFP_DMA32 to dma_alloc_attrs
Date:   Sat, 13 Oct 2018 17:17:06 +0200
Message-Id: <20181013151707.32210-8-hch@lst.de>
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
 drivers/media/platform/sti/bdisp/bdisp-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sti/bdisp/bdisp-hw.c b/drivers/media/platform/sti/bdisp/bdisp-hw.c
index 26d9fa7aeb5f..4372abbb5950 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-hw.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-hw.c
@@ -510,7 +510,7 @@ int bdisp_hw_alloc_filters(struct device *dev)
 
 	/* Allocate all the filters within a single memory page */
 	size = (BDISP_HF_NB * NB_H_FILTER) + (BDISP_VF_NB * NB_V_FILTER);
-	base = dma_alloc_attrs(dev, size, &paddr, GFP_KERNEL | GFP_DMA,
+	base = dma_alloc_attrs(dev, size, &paddr, GFP_KERNEL,
 			       DMA_ATTR_WRITE_COMBINE);
 	if (!base)
 		return -ENOMEM;
-- 
2.19.1

