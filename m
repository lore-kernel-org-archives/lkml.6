Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51231C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96792080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sV59/y1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96792080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeLAAe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:34:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeLAAc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NRkfp6v/tyUENHy0v3FTFCa7RE2ArNmx9O95c3iBPt0=; b=sV59/y1/uSNMWMkubtCTim30ZE
        SJvdc0okxTDV6DPg8ZqKx3OvSOuWyLxTYpGUgsnWZPGEdu6dHuHIs3R4m0LaVbXmVjLN493dOom9t
        +Xk635MBbpXUSsBoEVIexzTSdScPUWlr3wQVJSzd9x9z+fvQ9AVmavo5zGuzulGZ0YwgEVwpHOrR6
        4CJWO7xjQhx8POLemFHhgxOG9A2AbhLj5d36xH9BTWcALMq/eo4894IYUpAzTR/piJnvxji83BIKK
        D9ui4xgBQU65mBNht8uhi4LOu4JqX7V0r8qDiE324Hbvg8Qa2IDN/rxSAjcsTa89ZT4Ftg1fmFGB4
        pcgWnU7A==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSilV-0004dI-EZ; Fri, 30 Nov 2018 13:23:30 +0000
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
Subject: [PATCH 10/23] arm64: remove the dummy_dma_ops mapping_error method
Date:   Fri, 30 Nov 2018 14:22:18 +0100
Message-Id: <20181130132231.16512-11-hch@lst.de>
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

Just return DMA_MAPPING_ERROR from __dummy_map_page and let the core
dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a3ac26284845..fdc26ea5036c 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -282,7 +282,7 @@ static dma_addr_t __dummy_map_page(struct device *dev, struct page *page,
 				   enum dma_data_direction dir,
 				   unsigned long attrs)
 {
-	return 0;
+	return DMA_MAPPING_ERROR;
 }
 
 static void __dummy_unmap_page(struct device *dev, dma_addr_t dev_addr,
@@ -317,11 +317,6 @@ static void __dummy_sync_sg(struct device *dev,
 {
 }
 
-static int __dummy_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
-{
-	return 1;
-}
-
 static int __dummy_dma_supported(struct device *hwdev, u64 mask)
 {
 	return 0;
@@ -339,7 +334,6 @@ const struct dma_map_ops dummy_dma_ops = {
 	.sync_single_for_device = __dummy_sync_single,
 	.sync_sg_for_cpu        = __dummy_sync_sg,
 	.sync_sg_for_device     = __dummy_sync_sg,
-	.mapping_error          = __dummy_mapping_error,
 	.dma_supported          = __dummy_dma_supported,
 };
 EXPORT_SYMBOL(dummy_dma_ops);
-- 
2.19.1

