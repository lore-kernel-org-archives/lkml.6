Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DA8C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B6F21871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CSq9IoeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfAEIBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 03:01:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfAEIBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 03:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pdY7+J1zFjVI4F5NLSq2Xse777ie57ZXMaqkc6dWXhY=; b=CSq9IoeTI/9V3DjENlmz/TXZri
        GV0BSCbACPV2zuwuHTmvCvR9u2XOw+mOL9UpksvbjpSbxllj/WNa9pFWZrshmi3twf73jDSrDKSkr
        R6X4emLmuDnqQLlIq6Wz94jhVJC76t+kqWXfBPlAHvkNLHTKv/QaHB8QsovBAMwT1Qp+qPM5YEyCq
        2SGmCmNs9nAcf8fQ8et6OB1+RNTKbdatMG5toa1Suxro1yVCLW/A+kN4j0pXvBF9mxOX4YVHXVX1e
        REkPxCbjpu111cjIH7UOqKF/uj6yh3LWcGr7DyoWQuoxxltoEEMi3mLdx4tqYzol84GoiqAyHTsQe
        tRs/KvXQ==;
Received: from 089144213048.atnat0022.highway.a1.net ([89.144.213.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gfgtS-0000JI-2t; Sat, 05 Jan 2019 08:01:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     thellstrom@vmware.com
Cc:     linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs
Date:   Sat,  5 Jan 2019 09:01:06 +0100
Message-Id: <20190105080108.14837-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105080108.14837-1-hch@lst.de>
References: <20190105080108.14837-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_iommu_enabled is defined as always false for !CONFIG_INTEL_IOMMU,
so remove the ifdefs around it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 69e325b2d954..236052ad233c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -567,12 +567,10 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
 	const struct dma_map_ops *dma_ops = get_dma_ops(dev_priv->dev->dev);
 
-#ifdef CONFIG_INTEL_IOMMU
 	if (intel_iommu_enabled) {
 		dev_priv->map_mode = vmw_dma_map_populate;
 		goto out_fixup;
 	}
-#endif
 
 	if (!(vmw_force_iommu || vmw_force_coherent)) {
 		dev_priv->map_mode = vmw_dma_phys;
@@ -589,9 +587,7 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		dev_priv->map_mode = vmw_dma_map_populate;
 #endif
 
-#ifdef CONFIG_INTEL_IOMMU
 out_fixup:
-#endif
 	if (dev_priv->map_mode == vmw_dma_map_populate &&
 	    vmw_restrict_iommu)
 		dev_priv->map_mode = vmw_dma_map_bind;
@@ -599,13 +595,6 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 	if (vmw_force_coherent)
 		dev_priv->map_mode = vmw_dma_alloc_coherent;
 
-#if !defined(CONFIG_SWIOTLB) && !defined(CONFIG_INTEL_IOMMU)
-	/*
-	 * No coherent page pool
-	 */
-	if (dev_priv->map_mode == vmw_dma_alloc_coherent)
-		return -EINVAL;
-#endif
 	DRM_INFO("DMA map mode: %s\n", names[dev_priv->map_mode]);
 
 	return 0;
@@ -619,7 +608,6 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
  * With 32-bit we can only handle 32 bit PFNs. Optionally set that
  * restriction also for 64-bit systems.
  */
-#ifdef CONFIG_INTEL_IOMMU
 static int vmw_dma_masks(struct vmw_private *dev_priv)
 {
 	struct drm_device *dev = dev_priv->dev;
@@ -631,12 +619,6 @@ static int vmw_dma_masks(struct vmw_private *dev_priv)
 	}
 	return 0;
 }
-#else
-static int vmw_dma_masks(struct vmw_private *dev_priv)
-{
-	return 0;
-}
-#endif
 
 static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 {
-- 
2.20.1

