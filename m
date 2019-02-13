Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD882C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A93920811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZERCb4YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbfBMHDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:03:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51462 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387679AbfBMHDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zEnuJrKzAO7zmJ6S3mp5Gpyn5uYilMkl93RzC10BH5c=; b=ZERCb4YQyrI4EfUbz0I+zAmCYN
        7ljFDoxRfoRsRe5E7p+9pFNwUUOrmba+FRsOE4OPelMgqblmX/lE3Yd80Y4RXP9fTvvFVxttwTf3g
        Fr8YC6OGO/Wu0IqbEzet534SuufZKUj+Zdal6e6UQB3yP9Gdt4yCQQ3EtRDS1eND8mHhx42GtiU4c
        OhBEvgCoDFazq2gTk0ou0fT8tEup/xGdSrvdEb02oxk0TwUvzvzek6a3enl7RKr9rdl2zmScFVaKx
        OSyYgP4Rt2Q24zXgG1kdukyXReNpSH+VH1O4Eg54JBpYoWp/uKP5YDltTK1ZgFy+prB8rrff4s6/O
        9DntsTBA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoZC-0000l8-F5; Wed, 13 Feb 2019 07:02:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH 30/32] powerpc/dma: remove get_dma_offset
Date:   Wed, 13 Feb 2019 08:01:31 +0100
Message-Id: <20190213070133.11259-31-hch@lst.de>
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

Just fold the calculation into __phys_to_dma/__dma_to_phys as those are
the only places that should know about it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/dma-direct.h  |  8 ++++++--
 arch/powerpc/include/asm/dma-mapping.h | 16 ----------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
index 92d8aed86422..a2912b47102c 100644
--- a/arch/powerpc/include/asm/dma-direct.h
+++ b/arch/powerpc/include/asm/dma-direct.h
@@ -13,11 +13,15 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return paddr + get_dma_offset(dev);
+	if (!dev)
+		return paddr + PCI_DRAM_OFFSET;
+	return paddr + dev->archdata.dma_offset;
 }
 
 static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
-	return daddr - get_dma_offset(dev);
+	if (!dev)
+		return daddr - PCI_DRAM_OFFSET;
+	return daddr - dev->archdata.dma_offset;
 }
 #endif /* ASM_POWERPC_DMA_DIRECT_H */
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 93e57e28be28..c70f55d2f5e0 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -43,22 +43,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-/*
- * get_dma_offset()
- *
- * Get the dma offset on configurations where the dma address can be determined
- * from the physical address by looking at a simple offset.  Direct dma and
- * swiotlb use this function, but it is typically not used by implementations
- * with an iommu.
- */
-static inline dma_addr_t get_dma_offset(struct device *dev)
-{
-	if (dev)
-		return dev->archdata.dma_offset;
-
-	return PCI_DRAM_OFFSET;
-}
-
 static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 {
 	if (dev)
-- 
2.20.1

