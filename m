Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8CAC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52882145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n5su2fb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52882145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeLAAca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:32:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLAAc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uAVVZbZ4lOCyuUE6c3OSSVR5FUxUkQ0rwJ5NpEk5hIk=; b=n5su2fb/lbh7rccugjTnBESjHb
        e7pDDvbjoTtHRnlydrXmoI5jaYzjxZBFOuCtvxJbX/9KegeG+EnKnRqkMyevp5xgsaDDA1FIrLpi0
        lp4IUVk7/x61NlgXS9bohj3BZNnuw97xkwasa0TZQgwlq0MnmGAdZmuNy4fJTyt8PoqnDgAd70zp2
        3cvtJjYY+IP1mWWZhb0nzj2enVdGh171jyXEOzNDe6Bd1mO/JnljLRdsLhEgXWP0DNRO+Cue1aYya
        mYCeyTSv12WlmzG7orvm/usmsurjBbQ9ZpyqiJK8D/bJRfCf54Ns2CCHvbOwr8cySDck9RSfafNyX
        T9oDjsHg==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSil4-0004Gu-6E; Fri, 30 Nov 2018 13:23:02 +0000
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
Subject: [PATCH 01/23] dma-mapping: provide a generic DMA_MAPPING_ERROR
Date:   Fri, 30 Nov 2018 14:22:09 +0100
Message-Id: <20181130132231.16512-2-hch@lst.de>
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
index 0f81c713f6e9..46bd612d929e 100644
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

