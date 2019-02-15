Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC525C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA84321A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JDNmphlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437215AbfBOOqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:46:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395160AbfBOOqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gRpyvzKY+i69CNAl/QWLFd4mkChnvpbe5xjE7SRKcBY=; b=JDNmphlGuTSPii7tD4NkZHytDv
        QPcOdCRN1MKb8WoYIg8Ta9kDAxUhzxAOAUSejGdSTVBxZRNUGSICYrs7KGReI7rEE5BrwtkD4XpVu
        XHMuxr9SjNDQTD5CLiwnEm+Uo9fRs3f5t6JOyO9LMMFT3HqvEIyRo+etErN/MITdFLD0jXUnzr8nm
        aMWgufM4iyWgp7HLwlmeN4+NJUgaVrzjR4/jfuMjGSQnQc9h2N97qR5SDd1KShBz/avHaCQo0BWe+
        ldmiecehiAxXpc4EUsd3w6cz6mThT9b1rlFF1nVjs5axjEUfLPp21cDZ0lEvMXxamphJWrbSx4d3c
        EOZYBA5Q==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guekl-0005Qv-Co; Fri, 15 Feb 2019 14:46:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] sparc64/pci_sun4v: allow large DMA masks
Date:   Fri, 15 Feb 2019 15:45:58 +0100
Message-Id: <20190215144559.8777-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215144559.8777-1-hch@lst.de>
References: <20190215144559.8777-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've been moving to a model where the device just sets the DMA mask
supported by it, instead of having to fallback to something it thinks
the platform might support.  Sparc64 is the remaining holdout forcing
drivers to supply a matching mask.  Change dma_4v_supported to just
check if the supplied dma mask is large enough. and adjust the mapping
code to check ATU presence in addition to the DMA mask to decice on
the mapping method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/pci_sun4v.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index d30eb22b6e11..a8af6023c126 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -92,7 +92,7 @@ static long iommu_batch_flush(struct iommu_batch *p, u64 mask)
 		prot &= (HV_PCI_MAP_ATTR_READ | HV_PCI_MAP_ATTR_WRITE);
 
 	while (npages != 0) {
-		if (mask <= DMA_BIT_MASK(32)) {
+		if (mask <= DMA_BIT_MASK(32) || !pbm->iommu->atu) {
 			num = pci_sun4v_iommu_map(devhandle,
 						  HV_PCI_TSBID(0, entry),
 						  npages,
@@ -208,7 +208,7 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	atu = iommu->atu;
 
 	mask = dev->coherent_dma_mask;
-	if (mask <= DMA_BIT_MASK(32))
+	if (mask <= DMA_BIT_MASK(32) || !atu)
 		tbl = &iommu->tbl;
 	else
 		tbl = &atu->tbl;
@@ -674,21 +674,12 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 static int dma_4v_supported(struct device *dev, u64 device_mask)
 {
 	struct iommu *iommu = dev->archdata.iommu;
-	u64 dma_addr_mask = iommu->dma_addr_mask;
 
 	if (ali_sound_dma_hack(dev, device_mask))
 		return 1;
-
-	if (device_mask > DMA_BIT_MASK(32)) {
-		if (iommu->atu)
-			dma_addr_mask = iommu->atu->dma_addr_mask;
-		else
-			return 0;
-	}
-
-	if ((device_mask & dma_addr_mask) == dma_addr_mask)
-		return 1;
-	return 0;
+	if (device_mask < iommu->dma_addr_mask)
+		return 0;
+	return 1;
 }
 
 static const struct dma_map_ops sun4v_dma_ops = {
-- 
2.20.1

