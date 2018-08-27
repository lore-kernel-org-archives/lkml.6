Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F329C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B54E208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oF7tPUql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B54E208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeH0Md0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:33:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0Md0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vLodKfKmtk+0/ezVvZa0F74BnyRDKoUYTwiBNsTrC4U=; b=oF7tPUqlzmS53T4ycSf8PXHH2
        S2Bo14VnNjlo/OfZ0pbqk9Aw53OkuzBjEtFaLRGi7GDOP4wsHfcIRrnTVLM6LPpnLDuvZaNUPK3KA
        xlKYpBbAbXJB3rnltMS1w/wY1UMi5ytXBGaiYdqflRnqTKhnTcGQZ6iAx6FA4e7nc+06ojXc/1fLt
        +MpS9Wx6WFVyBld0IELwvhvT2AsGktuP/izlfMDxR4LrYCojIV9fEXZfz/NHKtSDJ1rjU7moMfBWP
        zbgy+3dRweKaDYSjyEOQKPLjeDgq8XNcqZqx6d4rBW4zqeOom05T5ed7Kvbm6Y5hnOFdHTzlQEwH3
        Ubs6Q2rLg==;
Received: from 213-225-1-219.nat.highway.a1.net ([213.225.1.219] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuDBI-0002Of-DO; Mon, 27 Aug 2018 08:47:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dma-mapping: clear dev->dma_ops in arch_teardown_dma_ops
Date:   Mon, 27 Aug 2018 10:47:11 +0200
Message-Id: <20180827084711.23407-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827084711.23407-1-hch@lst.de>
References: <20180827084711.23407-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to leave the per-device dma_ops around when
deconfiguring a device, so move this code from arm64 into the
common code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/dma-mapping.h | 5 -----
 arch/arm64/mm/dma-mapping.c          | 5 -----
 include/linux/dma-mapping.h          | 5 ++++-
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index b7847eb8a7bb..0a2d13332545 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -39,11 +39,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent);
 #define arch_setup_dma_ops	arch_setup_dma_ops
 
-#ifdef CONFIG_IOMMU_DMA
-void arch_teardown_dma_ops(struct device *dev);
-#define arch_teardown_dma_ops	arch_teardown_dma_ops
-#endif
-
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 072c51fb07d7..cdcb73db9ea2 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -862,11 +862,6 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		 dev_name(dev));
 }
 
-void arch_teardown_dma_ops(struct device *dev)
-{
-	dev->dma_ops = NULL;
-}
-
 #else
 
 static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 1423b69f3cc9..eafd6f318e78 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -664,7 +664,10 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 #endif
 
 #ifndef arch_teardown_dma_ops
-static inline void arch_teardown_dma_ops(struct device *dev) { }
+static inline void arch_teardown_dma_ops(struct device *dev)
+{
+	dev->dma_ops = NULL;
+}
 #endif
 
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
-- 
2.18.0

