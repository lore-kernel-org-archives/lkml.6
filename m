Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947ABC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AF320811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gh51URr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbfBMHDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:03:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388857AbfBMHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZO7ODjgEVBzicieixhOkzkE9uGIDz4y4n3ZKz9DCd9Q=; b=Gh51URr47J+wSCaCCgG02m34ir
        kKYZcnR0x38gwgWF7xeokejMZBPuI90kEVt4zVbiZiWPoQbTLalnI9AwG15XcaS2scdHfK/QCzJTy
        GBCWyzJoU70qveCk9JjvBv7HjF86hY6Znq/Mx9cmMbOWknpaZ7MDMhSQTQFO4CvQcUXWt/hz+S3dM
        WldIV4VhxFn0FV8n8cfMjZgT+n5Gw3IpQn9a6FA6UhoTOLm9nnt018zp0K4qe9wA/zNi253UXBq91
        m6nBphswNZbUa8n8sljwKyvjx5h43BJzDaTKXNHWbp3ibih+XmJia/TxSKWHzgK1VcETjBQjknPto
        rEv8SPkw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoZ2-0000iP-Pu; Wed, 13 Feb 2019 07:02:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH 26/32] swiotlb: remove swiotlb_dma_supported
Date:   Wed, 13 Feb 2019 08:01:27 +0100
Message-Id: <20190213070133.11259-27-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only user left is powerpc, but even there the generic dma-direct
version works just as well, given that we guarantee that the swiotlb
buffer must always be addressable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/kernel/dma-swiotlb.c |  2 +-
 include/linux/swiotlb.h           |  3 ---
 kernel/dma/swiotlb.c              | 12 ------------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index d5950a0cb758..6d2677b2daa6 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -36,7 +36,7 @@ const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.free = __dma_nommu_free_coherent,
 	.map_sg = dma_direct_map_sg,
 	.unmap_sg = dma_direct_unmap_sg,
-	.dma_supported = swiotlb_dma_supported,
+	.dma_supported = dma_direct_supported,
 	.map_page = dma_direct_map_page,
 	.unmap_page = dma_direct_unmap_page,
 	.sync_single_for_cpu = dma_direct_sync_single_for_cpu,
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7c007ed7505f..54254388899e 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -60,9 +60,6 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 				    size_t size, enum dma_data_direction dir,
 				    enum dma_sync_target target);
 
-extern int
-swiotlb_dma_supported(struct device *hwdev, u64 mask);
-
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
 extern phys_addr_t io_tlb_start, io_tlb_end;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d6361776dc5c..cbf3498a46f9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -648,15 +648,3 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 
 	return true;
 }
-
-/*
- * Return whether the given device DMA address mask can be supported
- * properly.  For example, if your device can only drive the low 24-bits
- * during bus mastering, then you would pass 0x00ffffff as the mask to
- * this function.
- */
-int
-swiotlb_dma_supported(struct device *hwdev, u64 mask)
-{
-	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
-}
-- 
2.20.1

