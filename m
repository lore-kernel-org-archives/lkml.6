Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751144AbeDMPPE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:15:04 -0400
Received: from foss.arm.com ([217.140.101.70]:43386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750837AbeDMPPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:15:02 -0400
From: Robin Murphy <robin.murphy@arm.com>
To: linux-graphics-maintainer@vmware.com, syeh@vmware.com,
        thellstrom@vmware.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Fix scatterlist unmapping
Date: Fri, 13 Apr 2018 16:14:57 +0100
Message-Id: <3a08f0343cb4e7a767601c59a381884121f9b751.1523632202.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.16.1.dirty
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_unmap_sg() should be called with the same number of entries
originally passed to dma_map_sg(), not the number it returned, which may
be fewer. Admittedly this driver probably never runs on non-coherent
architectures where getting that wrong could lead to data loss, but it's
always good to be correct, and it's trivially easy to fix by just
restoring the SG table state before the call instead of afterwards.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Found by inspection while poking around TTM users.

 drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
index 21111fd091f9..971223d39469 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
@@ -369,9 +369,9 @@ static void vmw_ttm_unmap_from_dma(struct vmw_ttm_tt *vmw_tt)
 {
 	struct device *dev = vmw_tt->dev_priv->dev->dev;
 
+	vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
 	dma_unmap_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.nents,
 		DMA_BIDIRECTIONAL);
-	vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
 }
 
 /**
-- 
2.16.1.dirty
