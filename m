Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE8BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1F020897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xw9/7nEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1F020897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeH2KTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:19:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeH2KTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WFuHpff7ifAeEmLpaCxMYYdOGJStFS2wfjqSeVyFvg0=; b=Xw9/7nEn+VOyNETEc2HeN7HfM
        dlsTUrwxCCMv8fLOvqhITvMQcAdYLNqudORM3jY43fImEGEZfekry+d8GJaAvfhyPHwEGDBaAZ2Mp
        gRIGtJOVcvcCvRosi4YAzFWXzGjX7xrPZR5i4qpouW2BbVeaGgZ06iO0l2j0Jz71J3yvH27uPEMHi
        oZGu38cY8WGrLTnlTSE7OE7OzqNdcgV3O6l758Um0rN+tW1InDJ6+GF9KDBq7pYDtDK3YH0G4awnX
        XFjYh5OlNuilF+KgvN/zFbPzeEjKW5s9TLGBfHpZj2NVwBn3Bfyd+jxU/Rxze1lmjjw7UAU6L9wt1
        rNmpg9Sww==;
Received: from 213-225-12-4.nat.highway.a1.net ([213.225.12.4] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1futtn-0002jM-1I; Wed, 29 Aug 2018 06:24:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, Meelis Roos <mroos@linux.ee>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] of/platform: initialise AMBA default DMA masks
Date:   Wed, 29 Aug 2018 08:24:01 +0200
Message-Id: <20180829062401.8701-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829062401.8701-1-hch@lst.de>
References: <20180829062401.8701-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

commit a5516219b102 ("of/platform: Initialise default DMA masks") sets up
the coherent_dma_mask of platform devices created from the device tree,
but fails to do the same for AMBA (PrimeCell) devices.

This leads to a regression in kernel v4.19-rc1 triggering the
WARN_ON_ONCE(dev && !dev->coherent_dma_mask) in dma_alloc_attrs().

This regresses the PL111 DRM driver in drivers/gpu/drm/pl111 that uses
the AMBA PrimeCell to instantiate the frame buffer device, as it cannot
allocate a chunk of coherent memory anymore due to the missing mask.

Fixes: a5516219b102 ("of/platform: Initialise default DMA masks")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[hch: added a comment, and droped a conditional that can't be true]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/of/platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 7ba90c290a42..6c59673933e9 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -241,6 +241,10 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	if (!dev)
 		goto err_clear_flag;
 
+	/* AMBA devices only support a single DMA mask */
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+
 	/* setup generic device info */
 	dev->dev.of_node = of_node_get(node);
 	dev->dev.fwnode = &node->fwnode;
-- 
2.18.0

