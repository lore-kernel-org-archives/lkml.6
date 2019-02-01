Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF93C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AFF218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TVx7AHJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfBAIsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:48:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbfBAIsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s9q5FJ99lWpVCtL740s0cfRjj+9qxL33pzPFuAa0dhI=; b=TVx7AHJnZp4D4jDgaeH2wts1lf
        hWXJLVSGVMRIBFNF8T5bpx5xFkhVyaOona7K1kE99gv0ONochH/zxmiV92aFNp3SCXGGW/zNZTiUV
        g3RHlxoxURDuNPDY9GoSQISMtJz4RVw5Yz8PadhkAL4T4aK85MlCpmRbWpRgkovB9UfNVhRe63r9w
        8Vd3bKWGyGRBk3T5WOnoZrvpeHgfMBF1XVeEerthTM/iSRhSwZg/d4z2sFKmTz9WNwfd4Y8/XjsiT
        qw3XPx0S7rBs4aozfzt6BsKH5BrPbVNi7Siw5ostFr6GkQWx0a8TbgipNtgGouliqFXH+NAANmAP1
        26xQ25vg==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUV5-0001Ts-I0; Fri, 01 Feb 2019 08:48:39 +0000
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
Subject: [PATCH 14/18] da8xx-fb: pass struct device to DMA API functions
Date:   Fri,  1 Feb 2019 09:47:57 +0100
Message-Id: <20190201084801.10983-15-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/da8xx-fb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 43f2a4816860..ec62274b914b 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1097,9 +1097,9 @@ static int fb_remove(struct platform_device *dev)
 
 		unregister_framebuffer(info);
 		fb_dealloc_cmap(&info->cmap);
-		dma_free_coherent(NULL, PALETTE_SIZE, par->v_palette_base,
+		dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
 				  par->p_palette_base);
-		dma_free_coherent(NULL, par->vram_size, par->vram_virt,
+		dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
 				  par->vram_phys);
 		pm_runtime_put_sync(&dev->dev);
 		pm_runtime_disable(&dev->dev);
@@ -1425,7 +1425,7 @@ static int fb_probe(struct platform_device *device)
 	par->vram_size = roundup(par->vram_size/8, ulcm);
 	par->vram_size = par->vram_size * LCD_NUM_BUFFERS;
 
-	par->vram_virt = dma_alloc_coherent(NULL,
+	par->vram_virt = dma_alloc_coherent(par->dev,
 					    par->vram_size,
 					    &par->vram_phys,
 					    GFP_KERNEL | GFP_DMA);
@@ -1446,7 +1446,7 @@ static int fb_probe(struct platform_device *device)
 		da8xx_fb_fix.line_length - 1;
 
 	/* allocate palette buffer */
-	par->v_palette_base = dma_alloc_coherent(NULL, PALETTE_SIZE,
+	par->v_palette_base = dma_alloc_coherent(par->dev, PALETTE_SIZE,
 						 &par->p_palette_base,
 						 GFP_KERNEL | GFP_DMA);
 	if (!par->v_palette_base) {
@@ -1532,11 +1532,12 @@ static int fb_probe(struct platform_device *device)
 	fb_dealloc_cmap(&da8xx_fb_info->cmap);
 
 err_release_pl_mem:
-	dma_free_coherent(NULL, PALETTE_SIZE, par->v_palette_base,
+	dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
 			  par->p_palette_base);
 
 err_release_fb_mem:
-	dma_free_coherent(NULL, par->vram_size, par->vram_virt, par->vram_phys);
+	dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
+		          par->vram_phys);
 
 err_release_fb:
 	framebuffer_release(da8xx_fb_info);
-- 
2.20.1

