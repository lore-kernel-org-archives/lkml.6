Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1031C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B847920672
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AYdjpxw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B847920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeLNIZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:25:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbeLNIZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aSOprGgEoMD+dgL3ebwfPKycVJcnWaVThtUGdRq18Y8=; b=AYdjpxw1TG7hT4vxJUWXrP8O/L
        m7Oc9/dVgOdvt3+Orvs809nulka8Yh5LmBKCqRRFUv4H9aY50KJVd3NWs3B9gbQMVsjj6j7nJG1GF
        +/uaHSeFXbH+ui0HIbRXiDBVyMyphUQl4flLmDgUIEyJRYckQN39cEDo++LPYyGDRa94Pj1jeHLjW
        IizfyQeUn5yaQffBPO9Wnta7SC+s7ipAjPzA2zudfuzVRoIzajT7mXDVAphK64mrRRfiTb6RUy83D
        HMEcXkaJaUrA5t3fGNnhUHDvwHbZZsckuIn3CsIZJZGclWE8YWiICbdjSyXdJPKnF2Z6VaEMjyYb/
        nqHcJNpw==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXimh-0004m4-MY; Fri, 14 Dec 2018 08:25:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Michal Simek <monstr@monstr.eu>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dma-mapping: deprecate dma_zalloc_coherent
Date:   Fri, 14 Dec 2018 09:25:15 +0100
Message-Id: <20181214082515.14835-3-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214082515.14835-1-hch@lst.de>
References: <20181214082515.14835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now always return zeroed memory from dma_alloc_coherent.  Note that
simply passing GFP_ZERO to dma_alloc_coherent wasn't always doing the
right thing to start with given that various allocators are not backed
by the page allocator and thus would ignore GFP_ZERO.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API.txt   | 9 ---------
 include/linux/dma-mapping.h | 7 ++++---
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 016eb6909b8a..e133ccd60228 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -58,15 +58,6 @@ specify the ``GFP_`` flags (see kmalloc()) for the allocation (the
 implementation may choose to ignore flags that affect the location of
 the returned memory, like GFP_DMA).
 
-::
-
-	void *
-	dma_zalloc_coherent(struct device *dev, size_t size,
-			    dma_addr_t *dma_handle, gfp_t flag)
-
-Wraps dma_alloc_coherent() and also zeroes the returned memory if the
-allocation attempt succeeded.
-
 ::
 
 	void
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f422aec0f53c..a52c6409bdc2 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -644,12 +644,13 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 }
 #endif
 
+/*
+ * Please always use dma_alloc_coherent instead as it already zeroes the memory!
+ */
 static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flag)
 {
-	void *ret = dma_alloc_coherent(dev, size, dma_handle,
-				       flag | __GFP_ZERO);
-	return ret;
+	return dma_alloc_coherent(dev, size, dma_handle, flag);
 }
 
 static inline int dma_get_cache_alignment(void)
-- 
2.19.2

