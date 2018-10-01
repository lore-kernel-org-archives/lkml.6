Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13B5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4852084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lBKdETJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4852084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeJBCw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:52:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeJBCw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zl9yeUUgznn3W8fD/3AKggny2EqQ7ojkGMtLGayS1jg=; b=lBKdETJcbp7mIwYyYDxjedCVt7
        6L+pY/m64XEU7YeoMArQAS45l9qJl37b86vGuIpISfykR/Jh2kll9RhCpsbH4XRWgqFeM4H4ySc6i
        ci+JDBSp6MOH4ttOMo6ueDg+FDujoek3LEjgF+XYOKQTOfmc3ukRb5kFMNKt1rlhRBR+oA0L1gPkz
        O+83LD3FVVHjEQlHtCrX0cBPByyPEjdv/NC9zmCA+kQthqtsI/3vXwmAR0xNPJYfP9mhFikKTpdN7
        TB80w7YyjqGlmdqCO+sVmQLsjmBgSuJ3jvbhWZEGVFS4lmaxmYBbZ9qLW3jwtKS45G+XhZzo5TMTe
        mf8wkrnw==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g74Ys-0006w8-5P; Mon, 01 Oct 2018 20:12:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dma-mapping: translate __GFP_NOFAIL to DMA_ATTR_NO_WARN
Date:   Mon,  1 Oct 2018 13:12:56 -0700
Message-Id: <20181001201257.366-2-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001201257.366-1-hch@lst.de>
References: <20181001201257.366-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows all dma_map_ops instances to entirely rely on
DMA_ATTR_NO_WARN going forward.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 562af6b45f23..02ecd4679e47 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -557,9 +557,11 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 }
 
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t flag)
+		dma_addr_t *dma_handle, gfp_t gfp)
 {
-	return dma_alloc_attrs(dev, size, dma_handle, flag, 0);
+
+	return dma_alloc_attrs(dev, size, dma_handle, gfp,
+			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
 }
 
 static inline void dma_free_coherent(struct device *dev, size_t size,
@@ -793,8 +795,12 @@ static inline void dmam_release_declared_memory(struct device *dev)
 static inline void *dma_alloc_wc(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t gfp)
 {
-	return dma_alloc_attrs(dev, size, dma_addr, gfp,
-			       DMA_ATTR_WRITE_COMBINE);
+	unsigned long attrs = DMA_ATTR_NO_WARN;
+
+	if (gfp & __GFP_NOWARN)
+		attrs |= DMA_ATTR_NO_WARN;
+
+	return dma_alloc_attrs(dev, size, dma_addr, gfp, attrs);
 }
 #ifndef dma_alloc_writecombine
 #define dma_alloc_writecombine dma_alloc_wc
-- 
2.19.0

