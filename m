Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299DCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4101208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nqUlVJNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4101208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbeH0MdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:33:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QB2nKWrGzUL/OrIe0DygrB4+3NzZfY8/MFfXL059fHs=; b=nqUlVJNO6SdXUBoqOKi/fGB4l
        FD3oEpDrpcy33+nEu+shoAd8KduvrgVLS7F/s27c5OGMSF35iIRb9yeEx+t6t9C+P5OQrPmMMN585
        ZZLN4V80YRZmqDNAlly9XoKYgcAdiaPnPgiV85TIxGbIKqhpR5rwVOaZC6Ly6Qa77DLUkBk+nTX2y
        FsJ4IFc+EUCAH1y3fdm8KEiz5y7B/V5uAW0nyPd4+cgcJvD/1RU5zIFhU+O4q7cQp3YjTg9CR6nkY
        ye+P+eA24bQGVX2/yu7mtU4UYq7aJxEaWKAk1yO0AP1eCmtgmdfz7nPT+hDB5H1haJww6liDTKJ6+
        e3yW68nHg==;
Received: from 213-225-1-219.nat.highway.a1.net ([213.225.1.219] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuDB7-0002Kv-Sc; Mon, 27 Aug 2018 08:47:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm-nommu: don't define arch_teardown_dma_ops
Date:   Mon, 27 Aug 2018 10:47:08 +0200
Message-Id: <20180827084711.23407-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827084711.23407-1-hch@lst.de>
References: <20180827084711.23407-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can just use the default implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h | 2 ++
 arch/arm/mm/dma-mapping-nommu.c    | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 8436f6ade57d..965b7c846ecb 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -100,8 +100,10 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			       const struct iommu_ops *iommu, bool coherent);
 
+#ifdef CONFIG_MMU
 #define arch_teardown_dma_ops arch_teardown_dma_ops
 extern void arch_teardown_dma_ops(struct device *dev);
+#endif
 
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index f448a0663b10..aa7aba302e76 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -237,7 +237,3 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 	set_dma_ops(dev, dma_ops);
 }
-
-void arch_teardown_dma_ops(struct device *dev)
-{
-}
-- 
2.18.0

