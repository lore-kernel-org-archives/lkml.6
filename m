Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63908C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FD8208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OvSEFes3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FD8208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH0Tf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:35:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeH0Tf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uhSfLm9Yl5QGeLGzANiItpcn+o00tIdXF7yPm+JhtTY=; b=OvSEFes3qqkfQuy3eAtOXWBs3
        X7mDmX3nowzyrtEt7T+MBMI9Z7NcQ5f8t3I2SkcqCGrpJkfQGYJhgNBJ06XxwUezo3VFTxstX4V2j
        jsVCk6wEjsftz5vY2yhoYOniaNqDG5AY215C+eG3skHF5vWYI3cQJAk69KIdetLgdXGakwyCW36sV
        p39m+wBwX2gjF1KcC1g4kTjFHPABhO0J2ucIth57TPPmAA+DfyMz5NW8ErOVUzzZNE5+kMnPm9all
        8vR+LBS6hPCr2p5dQuYww5Z4PK1CbCRbEUnYWY9daa5jK6LFsl0yX0LxbE/8EDDapVwQsqJPiF0ea
        wIq/y86Rg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuJkx-0006ra-L9; Mon, 27 Aug 2018 15:48:43 +0000
Date:   Mon, 27 Aug 2018 08:48:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Brooks <brian.brooks@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Miller <davem@davemloft.net>, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, ymarkman@marvell.com,
        stefanc@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.topel@intel.com,
        brian.brooks@arm.com
Subject: Re: [PATCH] net: mvpp2: avoid bouncing buffers
Message-ID: <20180827154843.GA25821@infradead.org>
References: <20180820024730.9147-1-brian.brooks@linaro.org>
 <20180819.195505.1988137313680465320.davem@davemloft.net>
 <20180820062326.GA22222@infradead.org>
 <20180827135524.fv4mxkwjn5bv7p5e@di3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827135524.fv4mxkwjn5bv7p5e@di3>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WE should basically never have dev->dma_mask = &dev->coherent_dma_mask,
so until that is the case you are doctoring around the symptoms and
not the problem.

Does the patch below help your case?

----
From 6294e0e330851ee06e66ab85b348f1d92d375d7a Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 27 Aug 2018 17:23:24 +0200
Subject: driver core: initialize a default DMA mask for platform device

We still treat devices without a DMA mask as defaulting to 32-bits for
both mask, but a few releases ago we've started warning about such
cases, as they require special cases to work around this sloppyness.
Add a dma_mask field to struct platform_object so that we can initialize
the dma_mask pointer in struct device and initialize both masks to
32-bits by default.  Architectures can still override this in
arch_setup_pdev_archdata if needed.

Note that the code looks a little odd with the various conditionals
because we have to support platform_device structures that are
statically allocated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/platform.c         | 15 +++++++++++++--
 include/linux/platform_device.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dff82a3c2caa..baf4b06cf2d9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -225,6 +225,17 @@ struct platform_object {
 	char name[];
 };
 
+static void setup_pdev_archdata(struct platform_device *pdev)
+{
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	if (!pdev->dma_mask)
+		pdev->dma_mask = DMA_BIT_MASK(32);
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &pdev->dma_mask;
+	arch_setup_pdev_archdata(pdev);
+};
+
 /**
  * platform_device_put - destroy a platform device
  * @pdev: platform device to free
@@ -271,7 +282,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
 		pa->pdev.id = id;
 		device_initialize(&pa->pdev.dev);
 		pa->pdev.dev.release = platform_device_release;
-		arch_setup_pdev_archdata(&pa->pdev);
+		setup_pdev_archdata(&pa->pdev);
 	}
 
 	return pa ? &pa->pdev : NULL;
@@ -472,7 +483,7 @@ EXPORT_SYMBOL_GPL(platform_device_del);
 int platform_device_register(struct platform_device *pdev)
 {
 	device_initialize(&pdev->dev);
-	arch_setup_pdev_archdata(pdev);
+	setup_pdev_archdata(pdev);
 	return platform_device_add(pdev);
 }
 EXPORT_SYMBOL_GPL(platform_device_register);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 1a9f38f27f65..d84ec1de6022 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -25,6 +25,7 @@ struct platform_device {
 	int		id;
 	bool		id_auto;
 	struct device	dev;
+	dma_addr_t	dma_mask;
 	u32		num_resources;
 	struct resource	*resource;
 
-- 
2.18.0

