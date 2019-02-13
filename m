Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61665C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6512086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rj3v6aHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405118AbfBMSaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:30:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405101AbfBMSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=631cUqKtStgDYfQN0nabVc3vT6A+Fx8k4tLo1gvPANg=; b=rj3v6aHsoo9NhXXGWu9Tus/ygs
        x7cYtGRO+ZksNxIpsc6FTgIFWyRIQ5oryrI3WWbJJ2DBd/WleMN1oMPAZLADMktGafM+z4a85KBDR
        Nc//jQAi2xR2fWod9eSMgLXWWjcq5AxQT8I5vE2S4Eu2m6TE2qlH2vVjIjJSU8TY14krEcPVMgJd2
        eKHlg01IYZYdC0DFCqQkVcZMoP4lwTr16pP3VOdqlFIiMMxEXdFw9wKEkh3Z2G+XO/VLLHBVE+sHt
        R5AZ3wz4d5yF84NeYqe9XnY0kDn9e7qWDUkaqC4OSpouos+VpkchmNjR9mfg26FMlcnk9UPkH6VLd
        A7Vjxe2A==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtzIH-0000EO-3U; Wed, 13 Feb 2019 18:30:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/21] dma-iommu: don't remap contiguous allocations for coherent devices
Date:   Wed, 13 Feb 2019 19:29:14 +0100
Message-Id: <20190213182920.16764-16-hch@lst.de>
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

There is no need to remap for pte attributes, or for a virtually
contiguous address, so just don't do it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ff6c6bf30c90..3199c9c81294 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1049,10 +1049,10 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
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
@@ -1060,8 +1060,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
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

