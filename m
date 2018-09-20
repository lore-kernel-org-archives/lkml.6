Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0AAC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A3121524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JoaZWB3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A3121524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbeITNJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:09:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387572AbeITNJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jw3yhSmOOgqEWfXaEUyIZ0xoh9XHnYvq9OTSjgJl+f0=; b=JoaZWB3tIy+FL6clKqEe4PNay
        12dVLq1NXvwE4JuWgKKSSqgHGC5odCSinpJheX3TXIBHgNbLgi7iD2UwrIKUlAR+DuOAcVry3RwX9
        4ejEkfDJTghPeTIusTZmABDOZs6jsMl21Ah1to5Sm3OzCRnED4sbAzyzhXJvCjT+4Y4FSNopxMvb2
        yavfsibPN6CpHlfQzXAdsIlAWA2BtM6PLEvkVQIvJ+cD9fyY1lcEkTKSbQC2a2HJ/Sh++cvL9sy4o
        zsgZfARtufynnCi6DrOewFrbzqo+dnA6wiuSS+wISJRDQropHabTXVYs07RnbMnlDmcbQipqQt0G9
        zzN47+8Cw==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2tN8-0002ns-QX; Thu, 20 Sep 2018 07:27:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] intel-iommu: mark intel_dma_ops static
Date:   Thu, 20 Sep 2018 09:27:00 +0200
Message-Id: <20180920072700.22396-10-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920072700.22396-1-hch@lst.de>
References: <20180920072700.22396-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 currently explicitly assigns it to dma_ops, but that same work is
already done by intel_iommu_init a little later, so we can remove the
duplicate assignment and mark the variable static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/pci-dma.c  | 4 ----
 drivers/iommu/intel-iommu.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 5a5bf5a82ac2..fe988c49f01c 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -24,8 +24,6 @@ int force_iommu __read_mostly;
 
 int iommu_pass_through;
 
-extern struct dma_map_ops intel_dma_ops;
-
 static int __init pci_iommu_init(void)
 {
 	if (iommu_detected)
@@ -39,8 +37,6 @@ fs_initcall(pci_iommu_init);
 
 void __init pci_iommu_alloc(void)
 {
-	dma_ops = &intel_dma_ops;
-
 	/*
 	 * The order of these functions is important for
 	 * fall-back/fail-over reasons
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e72efef97924..0ee6516de41a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3895,7 +3895,7 @@ static int intel_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return !dma_addr;
 }
 
-const struct dma_map_ops intel_dma_ops = {
+static const struct dma_map_ops intel_dma_ops = {
 	.alloc = intel_alloc_coherent,
 	.free = intel_free_coherent,
 	.map_sg = intel_map_sg,
-- 
2.18.0

