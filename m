Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBABC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A93320663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iQwqTJcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfANJmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EQZEX9xoCFQz29EUNJrvpUU7gXSIyB3VomK2z1k9loc=; b=iQwqTJcAvpuwWS7zHnCsx/kSA3
        e5sQSUTiAq/QBWzweAoklg1731j29gHcFV0q60jNCJ9J+z09Cz2YMzGgD11mBuxanWMJQ1o8ft54t
        0c+tzsPogMDPBlNHtqpa/7LMyUAmc96HeupKFEeH19vxrEaf4ZfqGef2BXetEX0qRgpTGfNX8PkKE
        JABlntDjl4hyo5d02zcGk0UE+PPkJikdZszNEBw9qMFis/adwTzZUqAKyMLsZTSozlzflu6rnyXlD
        Gdwb7YWW0M2ou1po3vGQKj3LuXL9mJBqA5GsryoBKYEIMcUzRgYxZWARiFfqNPuvkWpCMu5iXsJyB
        M6fsYGaA==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giykz-00067u-8K; Mon, 14 Jan 2019 09:42:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
Date:   Mon, 14 Jan 2019 10:41:42 +0100
Message-Id: <20190114094159.27326-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114094159.27326-1-hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for a __KERNEL__ guard outside uapi, make sure we pull in the
includes unconditionally so users can rely on it, and add a missing
comment describing the #else cpp statement.  Last but not least include
<linux/errno.h> instead of the asm version, which is frowned upon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-iommu.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..65aa888c2768 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -16,15 +16,13 @@
 #ifndef __DMA_IOMMU_H
 #define __DMA_IOMMU_H
 
-#ifdef __KERNEL__
-#include <linux/types.h>
-#include <asm/errno.h>
-
-#ifdef CONFIG_IOMMU_DMA
+#include <linux/errno.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/msi.h>
+#include <linux/types.h>
 
+#ifdef CONFIG_IOMMU_DMA
 int iommu_dma_init(void);
 
 /* Domain management interface for IOMMU drivers */
@@ -74,11 +72,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
-#else
-
-struct iommu_domain;
-struct msi_msg;
-struct device;
+#else /* CONFIG_IOMMU_DMA */
 
 static inline int iommu_dma_init(void)
 {
@@ -108,5 +102,4 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 }
 
 #endif	/* CONFIG_IOMMU_DMA */
-#endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
2.20.1

