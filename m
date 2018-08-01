Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208C6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C3120841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fxtIQumO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C3120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390166AbeHARtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:49:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389550AbeHARtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v0iA6Xb7KXkPyLCSMMqskKzMKnFrFbLoUsyl4mEs5SI=; b=fxtIQumOaZWrXgxLH219d0V1v
        mFNxvY2DXEku+xswEUp/8J/Li0F7CWO/OECeA4X8j3lAlvrARH8r8ozlSDbETKkatDRfzZwJT6j1d
        rPYNe2UL5mUW/staqvh7g3CaHnlPiI4knSas2MhnImoDTwCdH5nO9VvCaDLjmGqSCrTFeQp8mnpEI
        QfJNO+dM+uNSsY8PK1TyS0EmbVLpL7tHoHjveijPzZ3JyME5qC94xL5ifDP63BF6P2tFwHDPRE/jw
        xBcqf53EtE1LcYQi/pUglvoUsEwDz1vmH1vS8ggMIzJ7xycH9c/VNh05ow02UI3s37ebWegHpa/jz
        zQOM5phWA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fktan-0007gR-22; Wed, 01 Aug 2018 16:03:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH 9/9] intel-iommu: mark intel_dma_ops static
Date:   Wed,  1 Aug 2018 18:02:52 +0200
Message-Id: <20180801160252.25629-10-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801160252.25629-1-hch@lst.de>
References: <20180801160252.25629-1-hch@lst.de>
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
index 1be2609bd094..2da100e042fb 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3889,7 +3889,7 @@ static int intel_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return !dma_addr;
 }
 
-const struct dma_map_ops intel_dma_ops = {
+static const struct dma_map_ops intel_dma_ops = {
 	.alloc = intel_alloc_coherent,
 	.free = intel_free_coherent,
 	.map_sg = intel_map_sg,
-- 
2.18.0

