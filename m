Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE82C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CAE20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="liIeK+xP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CAE20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395383AbeKWAnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:43:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395350AbeKWAnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b0mTsSZ7pnWLHYe0tv9bLnm4xmcVv2T1rI2O6B8DMzE=; b=liIeK+xPUei0lEBxStOyanHUYE
        TaRXiwE03YnksJRiqDK9vKDV0SuL4zjUX6vtvXUyKf2Clftum0N/fnxl/Oe8pOV+Akw9rlRSWvkqV
        aGExKqG9sfG4gtPUI3AQwCBME9IiGpDRKV8OXZnOGLK4Wv1FogJk5gIf6KvRKBv+y68w2c7duGRuW
        RDCyJ9OSOUrTIiuD/Ene81oeB8JyQkj3/5ZhOzfm+H+i41NDb8yMqO0uByUhv0zLzfniM4aXrblwG
        WkBlTS/mukROY3vYG1mu8DnONxaPTdKme6tU17Sr5ceVtJaJRdhp5oeUzyznkpu3l8215voWO/ArI
        n2K8GzGA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpZt-0007eI-0G; Thu, 22 Nov 2018 14:03:33 +0000
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
Subject: [PATCH 03/24] dma-mapping: provide a generic DMA_MAPPING_ERROR
Date:   Thu, 22 Nov 2018 15:02:59 +0100
Message-Id: <20181122140320.24080-4-hch@lst.de>
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

Error handling of the dma_map_single and dma_map_page APIs is a little
problematic at the moment, in that we use different encodings in the
returned dma_addr_t to indicate an error.  That means we require an
additional indirect call to figure out if a dma mapping call returned
an error, and a lot of boilerplate code to implement these semantics.

Instead return the maximum addressable value as the error.  As long
as we don't allow mapping single-byte ranges with single-byte alignment
this value can never be a valid return.  Additionaly if drivers do
not check the return value from the dma_map* routines this values means
they will generally not be pointed to actual memory.

Once the default value is added here we can start removing the
various mapping_error methods and just rely on this generic check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 15bd41447025..c323c539b7cb 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -133,6 +133,8 @@ struct dma_map_ops {
 	u64 (*get_required_mask)(struct device *dev);
 };
 
+#define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
+
 extern const struct dma_map_ops dma_direct_ops;
 extern const struct dma_map_ops dma_virt_ops;
 
@@ -576,6 +578,10 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	debug_dma_mapping_error(dev, dma_addr);
+
+	if (dma_addr == DMA_MAPPING_ERROR)
+		return 1;
+
 	if (ops->mapping_error)
 		return ops->mapping_error(dev, dma_addr);
 	return 0;
-- 
2.19.1

