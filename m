Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A7221524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uDWEtKEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A7221524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbeITNJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:09:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbeITNJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qh38dSOFjZskxprx4IK2IpOxs4n4nGSAQXmhdnmEtU0=; b=uDWEtKEpt1c3hkPEXP6VWGqxR
        jmeSKx/+WNLqXUwX4AxvWM4s7IsiUfiCP5M1ZXC2/95nguaQGJ7bSZWuP4GXBR7s2T+LZAkdFEMpE
        wHaPUzJMBTDbXQpfauMmTT1u2onWN4VUC1DCTumN2yh3aNcVrPKgaiqilss0/KvlNe+2eGJfkUHX5
        UOowXmtYT4jMx8+9L3bRbltMPjxMw4yro9UJX9vNnWqYvWaUafWI3qadiWF+soegRSc11upqFX2dV
        hkr6YryKmJ38egQe6vPLoWCVji4GlmbbQ+ggo4mUM8ZBds90CXP3ygY11kL8ckT9d0m/PH3Z550M5
        /AjMp5Swg==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2tN1-0002kD-RV; Thu, 20 Sep 2018 07:27:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] ia64/sn2: remove no-ops dma sync methods
Date:   Thu, 20 Sep 2018 09:26:58 +0200
Message-Id: <20180920072700.22396-8-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920072700.22396-1-hch@lst.de>
References: <20180920072700.22396-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These do nothing but duplicating an assert that would have triggered
earlier on setting the dma mask, so remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/sn/pci/pci_dma.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/ia64/sn/pci/pci_dma.c b/arch/ia64/sn/pci/pci_dma.c
index 74c934a997bb..3b944fba0a3e 100644
--- a/arch/ia64/sn/pci/pci_dma.c
+++ b/arch/ia64/sn/pci/pci_dma.c
@@ -314,31 +314,6 @@ static int sn_dma_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nhwentries;
 }
 
-static void sn_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
-				       size_t size, enum dma_data_direction dir)
-{
-	BUG_ON(!dev_is_pci(dev));
-}
-
-static void sn_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
-					  size_t size,
-					  enum dma_data_direction dir)
-{
-	BUG_ON(!dev_is_pci(dev));
-}
-
-static void sn_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-				   int nelems, enum dma_data_direction dir)
-{
-	BUG_ON(!dev_is_pci(dev));
-}
-
-static void sn_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-				      int nelems, enum dma_data_direction dir)
-{
-	BUG_ON(!dev_is_pci(dev));
-}
-
 static int sn_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return 0;
@@ -467,10 +442,6 @@ static struct dma_map_ops sn_dma_ops = {
 	.unmap_page		= sn_dma_unmap_page,
 	.map_sg			= sn_dma_map_sg,
 	.unmap_sg		= sn_dma_unmap_sg,
-	.sync_single_for_cpu 	= sn_dma_sync_single_for_cpu,
-	.sync_sg_for_cpu	= sn_dma_sync_sg_for_cpu,
-	.sync_single_for_device = sn_dma_sync_single_for_device,
-	.sync_sg_for_device	= sn_dma_sync_sg_for_device,
 	.mapping_error		= sn_dma_mapping_error,
 	.dma_supported		= sn_dma_supported,
 };
-- 
2.18.0

