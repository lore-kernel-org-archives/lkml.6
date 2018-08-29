Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF4FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D712086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iveZZyAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D712086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeH2KTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:19:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeH2KTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ayvyKu3tEtH3Z8Gl+/7iuP1CuWNf6LQuQiSUUchnGWs=; b=iveZZyAZu9GG3c+MN76cJNjsI
        LXVNtWnn28GNvJ+9LiIQMGvIRtNkJoqP00e8hVv9G4PYIXRrHyrQyLWT9HIUaPhNcO2VN71asCqgr
        d970Fn4lOY/vMHdNUGWe34SlPWo+6l0hvsOSpPeKRd4KTvjj7A3yx7FcY7GMxwIH7wq+LoLcBdg+P
        H0mjCXYuhPeKvQNr0b4ZzMAbWd7DoCaG6ktTVChkaiqrN88/n3otvhp8GxcgLCaXPBmV4abDQYtqd
        mShIoU7NDGwZKbi6mshlFZev7yI2BBxAVBHCfiztOcME28yz6tAw9DS7tX3ZnBpxyvsrd3mjoyvd8
        hixR4WCYg==;
Received: from 213-225-12-4.nat.highway.a1.net ([213.225.12.4] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1futtg-0002iu-LI; Wed, 29 Aug 2018 06:24:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, Meelis Roos <mroos@linux.ee>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] driver core: initialize a default DMA mask for platform device
Date:   Wed, 29 Aug 2018 08:23:59 +0200
Message-Id: <20180829062401.8701-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829062401.8701-1-hch@lst.de>
References: <20180829062401.8701-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: Guenter Roeck <linux@roeck-us.net>
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
index 1a9f38f27f65..d9dc4883d5fb 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -25,6 +25,7 @@ struct platform_device {
 	int		id;
 	bool		id_auto;
 	struct device	dev;
+	u64		dma_mask;
 	u32		num_resources;
 	struct resource	*resource;
 
-- 
2.18.0

