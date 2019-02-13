Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32A2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FBB2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IRSh4bg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405018AbfBMS3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:29:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405005AbfBMS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=izBxEX7uX0tI0a3ISTTIgzv1i/wBw69v32c+Qx9jKSk=; b=IRSh4bg+xO71fEgtmBprSise8K
        d1hiruHcOett1+Ud3fQCdJLlvrjG4rEegab3Q/PFomvMmRDBYBe/v76UdxWuZXlAagruCbW/lJkrj
        LqSbrKEe2do6R/535wQugPJ2JMjd4qzXABYdYmHjEAE/Ut/G9BEEciQ13bWrtWq2fPC4QAVB5FYwl
        3j/6F2eb3AGSIMAZ7SIF2erSL29rXOnXnuKOhDIzUdcPS+WyENieiGtiJ9fp9mVXxsPsuhMtn6YdT
        2wjsWs30D/8wxup/LJbYyKFaFonv11uU+1kz65EZ9cnevMxZF5Zp+tqQMuFvoUtrpG5g8Y1Z382CD
        bYRbuDqw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtzHn-0007sN-KX; Wed, 13 Feb 2019 18:29:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/21] dma-iommu: cleanup dma-iommu.h
Date:   Wed, 13 Feb 2019 19:29:03 +0100
Message-Id: <20190213182920.16764-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213182920.16764-1-hch@lst.de>
References: <20190213182920.16764-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for a __KERNEL__ guard outside uapi and add a missing comment
describing the #else cpp statement.  Last but not least include
<linux/errno.h> instead of the asm version, which is frowned upon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-iommu.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..3e206f4ee173 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -16,14 +16,14 @@
 #ifndef __DMA_IOMMU_H
 #define __DMA_IOMMU_H
 
-#ifdef __KERNEL__
+#include <linux/errno.h>
 #include <linux/types.h>
-#include <asm/errno.h>
 
 #ifdef CONFIG_IOMMU_DMA
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/msi.h>
+#include <linux/types.h>
 
 int iommu_dma_init(void);
 
@@ -74,7 +74,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
-#else
+#else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
 struct msi_msg;
@@ -108,5 +108,4 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 }
 
 #endif	/* CONFIG_IOMMU_DMA */
-#endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
2.20.1

