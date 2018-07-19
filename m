Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D3AECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BA42084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eln+POS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BA42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeGSNji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:39:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbeGSNjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aqD8eDnO2LcHaLjon8E2opomA3Ye3ujWt8xxAKkGCT0=; b=eln+POS1V/c2QXRI8XjOmLnXZ
        XIaGRGTrFhLLdnXyWsAHJ4oE3BC/FFHjgheSni7qkYDkjfFxw+VwXQzNKVsTr8/l3RKwdE0m87xOA
        uk28zpqxNIpaS3PnoCCcXU85RomOLl5YlBPetvmF3VerULuP439zKP2aHJbSbgNf/Gt+5WX42kifM
        QHoMkH96a2LPA+em4c0faVrHJMtITgzrh20GIwos4F5OK3nn/f3/MuotXajs6mZrVSrZMwIZTw7JR
        Ig+xRuF0tpQZY+gHirDIAIeYZKV6olM59qfyBxwl1k6xZqcNVlJw0Z/pHPEDPyK1LfAYwmzbxMthV
        Rso4in/6Q==;
Received: from [96.72.186.57] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8Tz-0006Qu-JO; Thu, 19 Jul 2018 12:56:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA operation
Date:   Thu, 19 Jul 2018 05:56:33 -0700
Message-Id: <20180719125635.824-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719125635.824-1-hch@lst.de>
References: <20180719125635.824-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hexagon does all the required cache maintainance at dma map time, and none
at unmap time.  It thus has to implement sync_single_for_device to match
the map cace for buffer reuse, but there is no point in doing another
invalidation in the sync_single_cpu_case, which in terms of cache
maintainance is equivalent to the unmap case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/kernel/dma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 77459df34e2e..d2b717f352f4 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -181,13 +181,6 @@ static dma_addr_t hexagon_map_page(struct device *dev, struct page *page,
 	return bus;
 }
 
-static void hexagon_sync_single_for_cpu(struct device *dev,
-					dma_addr_t dma_handle, size_t size,
-					enum dma_data_direction dir)
-{
-	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
-}
-
 static void hexagon_sync_single_for_device(struct device *dev,
 					dma_addr_t dma_handle, size_t size,
 					enum dma_data_direction dir)
@@ -205,7 +198,6 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.free		= hexagon_free_coherent,
 	.map_sg		= hexagon_map_sg,
 	.map_page	= hexagon_map_page,
-	.sync_single_for_cpu = hexagon_sync_single_for_cpu,
 	.sync_single_for_device = hexagon_sync_single_for_device,
 	.mapping_error	= hexagon_mapping_error,
 };
-- 
2.18.0

