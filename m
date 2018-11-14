Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70654C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3980721780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CusMZCxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3980721780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbeKNS0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:26:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731357AbeKNS0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NBkFYJGKKcrI5DQk0s6JVvJBqVHO59rIQyipdUjAnUk=; b=CusMZCxSeFVIO1ZaEvdv+uooHo
        hFAHBWGuK9HBfjXPmDqyfkQhNgi1gNgwgVsUyJlkL2NnqvhrQyyFcLYtaLq27l8cU2OSTwGOnZWk0
        kopJtbSk0VFh2EXS3izk1PhAp2lzbrhlpofZ65Cztl5kj2B5YeJbzN9PsXWXvXwqDoYC30in/Qd1y
        eC8tchaYitVMx2mY/tKlK/3kLmgYkMMSqzT7HYT5tingkR/e/0kOqBYDL0loW9BxTb+gVTmmxuatV
        N/w1MHAFLUzg9LDTl5L7PSkeFj6z0FO+3t6vQUgocFDvXKFw+pQCbqalGatFby4tGvAbAT4EGtD4U
        LEUFyRLg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqSV-0004ok-Le; Wed, 14 Nov 2018 08:23:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/34] powerpc/dma: remove the no-op dma_nommu_unmap_{page,sg} routines
Date:   Wed, 14 Nov 2018 09:22:47 +0100
Message-Id: <20181114082314.8965-8-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These methods are optional, no need to implement no-op versions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/dma.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index d6deb458bb91..7078d72baec2 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -197,12 +197,6 @@ static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction,
-				unsigned long attrs)
-{
-}
-
 static u64 dma_nommu_get_required_mask(struct device *dev)
 {
 	u64 end, mask;
@@ -228,14 +222,6 @@ static inline dma_addr_t dma_nommu_map_page(struct device *dev,
 	return page_to_phys(page) + offset + get_dma_offset(dev);
 }
 
-static inline void dma_nommu_unmap_page(struct device *dev,
-					 dma_addr_t dma_address,
-					 size_t size,
-					 enum dma_data_direction direction,
-					 unsigned long attrs)
-{
-}
-
 #ifdef CONFIG_NOT_COHERENT_CACHE
 static inline void dma_nommu_sync_sg(struct device *dev,
 		struct scatterlist *sgl, int nents,
@@ -261,10 +247,8 @@ const struct dma_map_ops dma_nommu_ops = {
 	.free				= dma_nommu_free_coherent,
 	.mmap				= dma_nommu_mmap_coherent,
 	.map_sg				= dma_nommu_map_sg,
-	.unmap_sg			= dma_nommu_unmap_sg,
 	.dma_supported			= dma_nommu_dma_supported,
 	.map_page			= dma_nommu_map_page,
-	.unmap_page			= dma_nommu_unmap_page,
 	.get_required_mask		= dma_nommu_get_required_mask,
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	.sync_single_for_cpu 		= dma_nommu_sync_single,
-- 
2.19.1

