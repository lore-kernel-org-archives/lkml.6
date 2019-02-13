Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A20EC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A2D20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q1QN/jmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbfBMHCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:02:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfBMHCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qvacg34R4QSfJy2fSIHwPKooA/OChUbKig8mFMRtmvo=; b=q1QN/jmYZ3Rz2o29pUExYtppXD
        WglzRLTuHySrTzd8kZDL7iT9wREl+8u6rZ6ZjQZzZKX/WZJGXvyh+zlSlR98F3DuVLBP7ICCk82ol
        KM9sFHfTD7E1QGbQklXt4ns2staajHLtBaOor3wIpE9QCbjCiA7omhrTUT+TkepOS9A9XKIDxEbkE
        loyb2ix+ICAdYszjFCKcaf9WrIfqnozDeI4f/H/qSCQ3sAvL1tlcQDD5n909bXt2FKxYkL2eL6RYl
        olvZtOVmckSxg5tWJY7fF89hzNBoJGnbIK5/m6R4Pymq6g4DZDu//OJ943o2w7kLtSo58ibr8NBRT
        VTyKWMnA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoYJ-0000Gx-8Y; Wed, 13 Feb 2019 07:01:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/32] powerpc/cell: move dma direct window setup out of dma_configure
Date:   Wed, 13 Feb 2019 08:01:08 +0100
Message-Id: <20190213070133.11259-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the dma settings at device setup time, and stop playing games
with get_pci_dma_ops.  This prepares for using the common dma_configure
code later on.

Includes fixes from Michael Ellerman.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/cell/iommu.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index af2a3c15e0ec..4c609c0db5af 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -656,14 +656,21 @@ static const struct dma_map_ops dma_iommu_fixed_ops = {
 	.unmap_page     = dma_fixed_unmap_page,
 };
 
+static u64 cell_iommu_get_fixed_address(struct device *dev);
+
 static void cell_dma_dev_setup(struct device *dev)
 {
-	if (get_pci_dma_ops() == &dma_iommu_ops)
+	if (get_pci_dma_ops() == &dma_iommu_ops) {
+		u64 addr = cell_iommu_get_fixed_address(dev);
+
+		if (addr != OF_BAD_ADDR)
+			set_dma_offset(dev, addr + dma_iommu_fixed_base);
 		set_iommu_table_base(dev, cell_get_iommu_table(dev));
-	else if (get_pci_dma_ops() == &dma_nommu_ops)
+	} else if (get_pci_dma_ops() == &dma_nommu_ops) {
 		set_dma_offset(dev, cell_dma_nommu_offset);
-	else
+	} else {
 		BUG();
+	}
 }
 
 static void cell_pci_dma_dev_setup(struct pci_dev *dev)
@@ -894,7 +901,11 @@ static u64 cell_iommu_get_fixed_address(struct device *dev)
 	const u32 *ranges = NULL;
 	int i, len, best, naddr, nsize, pna, range_size;
 
+	/* We can be called for platform devices that have no of_node */
 	np = of_node_get(dev->of_node);
+	if (!np)
+		goto out;
+
 	while (1) {
 		naddr = of_n_addr_cells(np);
 		nsize = of_n_size_cells(np);
@@ -949,19 +960,14 @@ static int dma_suported_and_switch(struct device *dev, u64 dma_mask)
 {
 	if (dma_mask == DMA_BIT_MASK(64) &&
 	    cell_iommu_get_fixed_address(dev) != OF_BAD_ADDR) {
-		u64 addr = cell_iommu_get_fixed_address(dev) +
-			dma_iommu_fixed_base;
 		dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
-		dev_dbg(dev, "iommu: fixed addr = %llx\n", addr);
 		set_dma_ops(dev, &dma_iommu_fixed_ops);
-		set_dma_offset(dev, addr);
 		return 1;
 	}
 
 	if (dma_iommu_dma_supported(dev, dma_mask)) {
 		dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
-		set_dma_ops(dev, get_pci_dma_ops());
-		cell_dma_dev_setup(dev);
+		set_dma_ops(dev, &dma_iommu_ops);
 		return 1;
 	}
 
-- 
2.20.1

