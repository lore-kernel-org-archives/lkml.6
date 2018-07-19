Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA166C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879432086B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="msoGHII5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879432086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeGSNjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:39:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbeGSNjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gav4/C9vSOOXI2qu0UcM2ChCacoDHQJI2xirMnrvTFg=; b=msoGHII5gxr+bblRF00h2piVo
        PIQkk2uvFrXxPwahC8iO85E7mMy4jELkNRwBlg3xFQA9JiUdp6/IC4kAw5mB7PpOmcGW+Y2DQkXRP
        MLRdpI1hv6CD4oydgAmc75iBhyAdWfh4kK1HQtef+Yyi/oPteFsHCxbpnX7dEeFj5mgZEwMTQatjb
        LeMl2ZCrOX8sSMn0nwKr7wP+/O7tTY228PsenYQc2CYWf0M8TbRqRNaFL6H+K1y9l8uvVz08DalC/
        I6RzxJpnHn8DvUAjBuzLq+qTBTIEppJDBfPdYhyVICRFiMmRxJadrIDirxeOITMEwUMZM8D+8rR+i
        meJYAyufA==;
Received: from [96.72.186.57] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8Tz-0006Qz-UZ; Thu, 19 Jul 2018 12:56:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hexagon: implement the sync_sg_for_device DMA operation
Date:   Thu, 19 Jul 2018 05:56:34 -0700
Message-Id: <20180719125635.824-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719125635.824-1-hch@lst.de>
References: <20180719125635.824-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This methods needs to provide the equivalent of sync_single_for_device
for each S/G list element, but was missing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/kernel/dma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index d2b717f352f4..9e46556a227d 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -188,6 +188,18 @@ static void hexagon_sync_single_for_device(struct device *dev,
 	dma_sync(dma_addr_to_virt(dma_handle), size, dir);
 }
 
+static void hexagon_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		hexagon_sync_single_for_device(dev, sg_dma_address(sg),
+				sg->length, dir);
+}
+
+
 static int hexagon_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr == HEXAGON_MAPPING_ERROR;
@@ -199,6 +211,7 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.map_sg		= hexagon_map_sg,
 	.map_page	= hexagon_map_page,
 	.sync_single_for_device = hexagon_sync_single_for_device,
+	.sync_sg_for_device = hexagon_sync_sg_for_device,
 	.mapping_error	= hexagon_mapping_error,
 };
 
-- 
2.18.0

