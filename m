Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC2AC43612
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BDE2063F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OIBdm2x6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfAEIBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 03:01:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfAEIBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 03:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z+dLqQnDzg6pSFWK9vinzCeDwTmAztAiAzF/q1mSZ1I=; b=OIBdm2x6r/i8+DQChQidTW9iWB
        BupcQoFn6o0UwyH4JVnJMq/Ew/KLQW0QQvWlXHOVwhRmwXSlo6UfPSBFsveNCr7WYTIqc7EM1OrHD
        PIsWKHiOeo09lOVzv+KBTKYpNvVDBb7CQPf3aCt4evnTWcUjIZcAxht1ESAn1AYIe4sLwmKnvb7+N
        IlJdaGM2LTENkzwoMHwo5LAeZgM05a19LhYISaubEUNfz9vyAwGOVMMClKrQY++HqPcYkqjz/YK/H
        XjdWDyEUJRaksUOpi2YdQVSjzaC/nk558Jb45locJ16e6hN9fc0IijwOBJrthhzj2hp1SC9N0CE1E
        JoJjXMoA==;
Received: from 089144213048.atnat0022.highway.a1.net ([89.144.213.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gfgtU-0000JS-Ok; Sat, 05 Jan 2019 08:01:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     thellstrom@vmware.com
Cc:     linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/vmwgfx: fix the check when to use dma_alloc_coherent
Date:   Sat,  5 Jan 2019 09:01:07 +0100
Message-Id: <20190105080108.14837-4-hch@lst.de>
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

Since Linux 4.21 we merged the swiotlb ops into the DMA direct ops,
so they would always have a the sync_single methods.  But late in
the cicle we also removed the direct ops entirely, so we'd see NULL
DMA ops.  Switch vmw_dma_select_mode to only detect swiotlb presence
using swiotlb_nr_tbl() instead.

Fixes: 55897af630 ("dma-direct: merge swiotlb_dma_ops into the dma_direct code")
Fixes: 356da6d0cd ("dma-mapping: bypass indirect calls for dma-direct")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 236052ad233c..c2060f6cc9e8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -565,7 +565,6 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		[vmw_dma_alloc_coherent] = "Using coherent TTM pages.",
 		[vmw_dma_map_populate] = "Keeping DMA mappings.",
 		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
-	const struct dma_map_ops *dma_ops = get_dma_ops(dev_priv->dev->dev);
 
 	if (intel_iommu_enabled) {
 		dev_priv->map_mode = vmw_dma_map_populate;
@@ -578,14 +577,12 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		return 0;
 	}
 
-	dev_priv->map_mode = vmw_dma_map_populate;
-
-	if (dma_ops && dma_ops->sync_single_for_cpu)
-		dev_priv->map_mode = vmw_dma_alloc_coherent;
 #ifdef CONFIG_SWIOTLB
-	if (swiotlb_nr_tbl() == 0)
-		dev_priv->map_mode = vmw_dma_map_populate;
+	if (swiotlb_nr_tbl())
+		dev_priv->map_mode = vmw_dma_alloc_coherent;
+	else
 #endif
+		dev_priv->map_mode = vmw_dma_map_populate;
 
 out_fixup:
 	if (dev_priv->map_mode == vmw_dma_map_populate &&
-- 
2.20.1

