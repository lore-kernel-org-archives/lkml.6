Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B45C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870E920684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dF7/b2YH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870E920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437203AbeKWAnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:43:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732590AbeKWAnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UlTvCVuSLDW9AZDoMxHDIcPbv1chhpRBuQVATQStN/w=; b=dF7/b2YHkz3jturI/C03fVlJvL
        uS6Yeyi2hkY3FlTKN25raYu639T9Mueyo11jDCroI/UZPTQbvjWGOrXTr88S7nJDezcQ9fEl6yGrD
        fwrVL6g0ZNITUNHwu8aMEJp8Ft7OfenRnu4vkzW9f4QqbGZHfz/udAol7SwEvTv+8o+d/SR3WPxh5
        ELndRVDQ4hua3i+QrHHLtWaREOrmrNy240aYlo1kBv0E97BbI77t4KFXztobu7pck5GGlDKzhv+Pw
        K05amyVbaaNgN3cPKzgCK7F+2RtZK58yXXQcl31/ipnq/g2KGaG/1gxrB6cdB0P1ooSSDGXbOOkyF
        YSe0L7Hw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpaE-0008Bm-GL; Thu, 22 Nov 2018 14:03:55 +0000
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
Subject: [PATCH 10/24] parisc/ccio: remove the mapping_error dma_map_ops method
Date:   Thu, 22 Nov 2018 15:03:06 +0100
Message-Id: <20181122140320.24080-11-hch@lst.de>
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

The CCIO iommu code already returns (~(dma_addr_t)0x0) on mapping
failures, so we can switch over to returning DMA_MAPPING_ERROR and let
the core dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/parisc/ccio-dma.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 701a7d6a74d5..714aac72df0e 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -110,8 +110,6 @@
 #define CMD_TLB_DIRECT_WRITE 35         /* IO_COMMAND for I/O TLB Writes     */
 #define CMD_TLB_PURGE        33         /* IO_COMMAND to Purge I/O TLB entry */
 
-#define CCIO_MAPPING_ERROR    (~(dma_addr_t)0)
-
 struct ioa_registers {
         /* Runway Supervisory Set */
         int32_t    unused1[12];
@@ -740,7 +738,7 @@ ccio_map_single(struct device *dev, void *addr, size_t size,
 	BUG_ON(!dev);
 	ioc = GET_IOC(dev);
 	if (!ioc)
-		return CCIO_MAPPING_ERROR;
+		return DMA_MAPPING_ERROR;
 
 	BUG_ON(size <= 0);
 
@@ -1021,11 +1019,6 @@ ccio_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	DBG_RUN_SG("%s() DONE (nents %d)\n", __func__, nents);
 }
 
-static int ccio_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == CCIO_MAPPING_ERROR;
-}
-
 static const struct dma_map_ops ccio_ops = {
 	.dma_supported =	ccio_dma_supported,
 	.alloc =		ccio_alloc,
@@ -1034,7 +1027,6 @@ static const struct dma_map_ops ccio_ops = {
 	.unmap_page =		ccio_unmap_page,
 	.map_sg = 		ccio_map_sg,
 	.unmap_sg = 		ccio_unmap_sg,
-	.mapping_error =	ccio_mapping_error,
 };
 
 #ifdef CONFIG_PROC_FS
-- 
2.19.1

