Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA9C43613
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E410421871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gsrPuVE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfAEIB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 03:01:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfAEIBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 03:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oz/kstUMDjo2/7DezyE12VsuvnT5Qn/XHw8dHT4vIsY=; b=gsrPuVE7vngxfS0LtHc3LXLwmr
        sKJdoXUBVSqjqpqxWYKuWXxydwOCeIdTgFJA2CJ3NAu8T6zYH3zep6fH5gxkp9Ol5tuIfDKph2l54
        x1plOfl4IpxVpepqduxJsWM/k+4iiNwuMKfj8G3GZNhsKap8h4I9D2j7NBkKh5t4NLcpIQ1/nB8nM
        v/kMJQgMMl+qOqf3hR7sPK5AJbMYhhVqj4Y7I0GGkPAjRdIV2rGe3QAju3ku1Dq+NNOzO3Qqf8HO6
        VD/SHTJ/FnfoIRRgHwKdg/2QJkBWm3wPvI0TLsap3YZaNJxd/3sQfWDQNbD/Q0tXTR7E7LTM++1MD
        DuZjNFLQ==;
Received: from 089144213048.atnat0022.highway.a1.net ([89.144.213.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gfgtX-0000Jc-KT; Sat, 05 Jan 2019 08:01:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     thellstrom@vmware.com
Cc:     linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/vmwgfx: unwind spaghetti code in vmw_dma_select_mode
Date:   Sat,  5 Jan 2019 09:01:08 +0100
Message-Id: <20190105080108.14837-5-hch@lst.de>
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

Just use a simple if/else chain to select the DMA mode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index c2060f6cc9e8..86387735a90b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -566,34 +566,21 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		[vmw_dma_map_populate] = "Keeping DMA mappings.",
 		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
 
-	if (intel_iommu_enabled) {
+	if (vmw_force_coherent)
+		dev_priv->map_mode = vmw_dma_alloc_coherent;
+	else if (intel_iommu_enabled)
 		dev_priv->map_mode = vmw_dma_map_populate;
-		goto out_fixup;
-	}
-
-	if (!(vmw_force_iommu || vmw_force_coherent)) {
+	else if (!vmw_force_iommu)
 		dev_priv->map_mode = vmw_dma_phys;
-		DRM_INFO("DMA map mode: %s\n", names[dev_priv->map_mode]);
-		return 0;
-	}
-
-#ifdef CONFIG_SWIOTLB
-	if (swiotlb_nr_tbl())
+	else if (IS_ENABLED(CONFIG_SWIOTLB) && swiotlb_nr_tbl())
 		dev_priv->map_mode = vmw_dma_alloc_coherent;
 	else
-#endif
 		dev_priv->map_mode = vmw_dma_map_populate;
 
-out_fixup:
-	if (dev_priv->map_mode == vmw_dma_map_populate &&
-	    vmw_restrict_iommu)
+	if (dev_priv->map_mode == vmw_dma_map_populate && vmw_restrict_iommu)
 		dev_priv->map_mode = vmw_dma_map_bind;
 
-	if (vmw_force_coherent)
-		dev_priv->map_mode = vmw_dma_alloc_coherent;
-
 	DRM_INFO("DMA map mode: %s\n", names[dev_priv->map_mode]);
-
 	return 0;
 }
 
-- 
2.20.1

