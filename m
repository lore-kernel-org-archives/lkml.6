Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7F2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AE120684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lbiaCexD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AE120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437427AbeKWAoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:44:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbeKWAoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TrgfIZ3bNF2OWBcL9hBTfrjl2zokhuvB9kcwcuNtjSE=; b=lbiaCexDwg942lJgx2kPd6fWEU
        pyoDesvbsbbIA2Cc0yKOlIHrpyH1ILGXWsDwpkthE/gCcUQUc4R+B2HCO53sUogUkMjNQBi91srE+
        YCVIYi7A3qTbGr2/yvKcWPXVbuy+kYkFDV0xfvxMaFdzxGUq34YQxKydNChjd0cmoEtZmttdQfobC
        HCFod8U6lWc1SB8kh1Qg4YEFWxHhgzsYvXQ6MKNHBD9aU8ebFgdzWA3t43pJxsq/7M7pafE/KfdON
        meJ8x16mN2P5rs9KqZf4c8+oCU252cwFJD+cb9LDppKfcDUEddRHwhjJJ5mWbq1Pt1tHNNZQxM/cX
        I2sH4W/A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpat-0000TT-H1; Thu, 22 Nov 2018 14:04:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/24] dma-mapping: remove the mapping_error dma_map_ops method
Date:   Thu, 22 Nov 2018 15:03:20 +0100
Message-Id: <20181122140320.24080-25-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122140320.24080-1-hch@lst.de>
References: <20181122140320.24080-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users left except for vmd which just forwards it.  Also switch
dma_mapping_error to an explicit bool return value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/controller/vmd.c |  6 ------
 include/linux/dma-mapping.h  | 13 ++-----------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e50b0b5815ff..98ce79eac128 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -394,11 +394,6 @@ static void vmd_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	vmd_dma_ops(dev)->sync_sg_for_device(to_vmd_dev(dev), sg, nents, dir);
 }
 
-static int vmd_mapping_error(struct device *dev, dma_addr_t addr)
-{
-	return vmd_dma_ops(dev)->mapping_error(to_vmd_dev(dev), addr);
-}
-
 static int vmd_dma_supported(struct device *dev, u64 mask)
 {
 	return vmd_dma_ops(dev)->dma_supported(to_vmd_dev(dev), mask);
@@ -446,7 +441,6 @@ static void vmd_setup_dma_ops(struct vmd_dev *vmd)
 	ASSIGN_VMD_DMA_OPS(source, dest, sync_single_for_device);
 	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_cpu);
 	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_device);
-	ASSIGN_VMD_DMA_OPS(source, dest, mapping_error);
 	ASSIGN_VMD_DMA_OPS(source, dest, dma_supported);
 	ASSIGN_VMD_DMA_OPS(source, dest, get_required_mask);
 	add_dma_domain(domain);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c323c539b7cb..c250e2ca6dfc 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -128,7 +128,6 @@ struct dma_map_ops {
 				   enum dma_data_direction dir);
 	void (*cache_sync)(struct device *dev, void *vaddr, size_t size,
 			enum dma_data_direction direction);
-	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
 	int (*dma_supported)(struct device *dev, u64 mask);
 	u64 (*get_required_mask)(struct device *dev);
 };
@@ -573,18 +572,10 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 	return dma_free_attrs(dev, size, cpu_addr, dma_handle, 0);
 }
 
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+static inline bool dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
 	debug_dma_mapping_error(dev, dma_addr);
-
-	if (dma_addr == DMA_MAPPING_ERROR)
-		return 1;
-
-	if (ops->mapping_error)
-		return ops->mapping_error(dev, dma_addr);
-	return 0;
+	return dma_addr == DMA_MAPPING_ERROR;
 }
 
 static inline void dma_check_mask(struct device *dev, u64 mask)
-- 
2.19.1

