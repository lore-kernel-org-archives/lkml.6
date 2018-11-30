Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D8EC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEB82082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OuuN1jG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEB82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeLAAeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:34:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeLAAdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F/g9IT8mKldWBhvGFGdXmQbWlqrXVOVdWlS2DFfwxqU=; b=OuuN1jG3F/iWqiNu60z8USQXZd
        psvfIKdIzoTxcdckmtDQ3+hzlnWHrQE2/9Pp8LrUeKhRJ5zLe78PWl1yQ8DmxNpAQXl67TC0ZACFe
        felG8mEseFbU27MSCjah8uJTWyvZxzNzao+7chsrlY36n+bNUlCVUY1atej+0slY8aBSlMacNLo4J
        RGUZ5UKUPjQUc6t5pODuEgbBtTI5msN5YS2mdcARDPUTnwhLeqWu1/cJkhhbLGsIe4sx+Fe26S2Qo
        VH9cJQAlv0Q9pUs6GQkITU1Dh4lj/+B09XvDVTngGzUSuDKZ8nnzcddUgWHzN2fB9uR16r3BKy6Zo
        txiJO3og==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSile-0004nT-Jf; Fri, 30 Nov 2018 13:23:39 +0000
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
Subject: [PATCH 13/23] ia64/sba_iommu: remove the mapping_error dma_map_ops method
Date:   Fri, 30 Nov 2018 14:22:21 +0100
Message-Id: <20181130132231.16512-14-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
References: <20181130132231.16512-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return DMA_MAPPING_ERROR instead of 0 on a dma mapping failure and let
the core dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/hp/common/sba_iommu.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index c56f28c98102..0d21c0b5b23d 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -974,7 +974,7 @@ static dma_addr_t sba_map_page(struct device *dev, struct page *page,
 
 	pide = sba_alloc_range(ioc, dev, size);
 	if (pide < 0)
-		return 0;
+		return DMA_MAPPING_ERROR;
 
 	iovp = (dma_addr_t) pide << iovp_shift;
 
@@ -2155,11 +2155,6 @@ static int sba_dma_supported (struct device *dev, u64 mask)
 	return ((mask & 0xFFFFFFFFUL) == 0xFFFFFFFFUL);
 }
 
-static int sba_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
 __setup("nosbagart", nosbagart);
 
 static int __init
@@ -2193,7 +2188,6 @@ const struct dma_map_ops sba_dma_ops = {
 	.map_sg			= sba_map_sg_attrs,
 	.unmap_sg		= sba_unmap_sg_attrs,
 	.dma_supported		= sba_dma_supported,
-	.mapping_error		= sba_dma_mapping_error,
 };
 
 void sba_dma_init(void)
-- 
2.19.1

