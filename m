Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB15DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB44C2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UJUvzdgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfANJmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfANJmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R/s9EJiwTJNepM4up7eBOd1B3bS1VpCDgWuWuUkA+N8=; b=UJUvzdgG9sNAPEeUB/AiVlf1vO
        fkIrSnfvksYy0777SPHNJfvtE+jm309Pl33I3E2SAcPqkK/jzuNZzVGDKdMJlbaeLR8x3P8ppQ8pH
        OGAuSF6uWw2d/RZm1gyjW+X0634ENvQS5AGmWp1pK7S58B7O16v0LiYMKwjrGjgxBYLMUa2AHBozl
        bDKO6iBF93mo4rrkhJjEKEqMIOqVQ4Woopa3cmMK3xojqj7lqG6zmTDP3LZIHFjxPM6u0CRjMiy4F
        nUd8JD/ApsE14vDgId+BPekUcmmRrTO25Ckf0m9QtU4LeWUucuPOvbGh2MyOmz2ckzf3ReoRoL3XL
        Euiu8Awg==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giylZ-0006hK-9V; Mon, 14 Jan 2019 09:42:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] dma-iommu: don't remap contiguous allocations for coherent devices
Date:   Mon, 14 Jan 2019 10:41:53 +0100
Message-Id: <20190114094159.27326-14-hch@lst.de>
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

There is no need to remap for pte attributes, or for a virtually
contiguous address, so just don't do it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c9788e0c1d5d..710814a370b9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1041,10 +1041,10 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 		addr = iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
 				attrs);
-		if (!addr)
-			return NULL;
-		page = virt_to_page(addr);
+		if (coherent || !addr)
+			return addr;
 
+		page = virt_to_page(addr);
 		addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
 				__builtin_return_address(0));
 		if (!addr) {
@@ -1052,8 +1052,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 			return NULL;
 		}
 
-		if (!coherent)
-			arch_dma_prep_coherent(page, iosize);
+		arch_dma_prep_coherent(page, iosize);
 	} else {
 		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
 	}
-- 
2.20.1

