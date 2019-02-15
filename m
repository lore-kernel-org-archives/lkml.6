Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94DEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD8C2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kf1WYNyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395130AbfBOOqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:46:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbfBOOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3Z8IK9ObumLKlQEoOhPYkD5tqWFaSaaGvy74lBW38/o=; b=Kf1WYNyx8+s3FJ6Ck3PvKF9cdl
        e6EC7WxxODy2u7hHPGnK6S2S9m3XG1pAZE263aswnHhatPe2IyhPhf0oF1xufDjfmkrU37+476jtD
        vFhy9UNqy25mG8RP1DyVhlfKgTgTp5zGwa9JrmYCU1oyzb+Qp1FsjnuMhnFfaC9PuNpsouIkbRBft
        1IR4PkSkMB02h4kk30XqtrR1lPbxgRRmQeWKAh8HDed1y8NwwA25cLZTMPJxaIasWAJ1Kk7U4PVx3
        c74spC/CTmyEqKaNkbDaXXmPci+1esyb50q2dGOfyPaG2ssEpRIoJjrwsAiQPQDyv4Cfi8EkLSbRs
        s6bflFpA==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guekg-0005PX-Cg; Fri, 15 Feb 2019 14:46:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] sparc64: refactor the ali DMA quirk
Date:   Fri, 15 Feb 2019 15:45:56 +0100
Message-Id: <20190215144559.8777-3-hch@lst.de>
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

Do the quirk first in the dma_supported routines, as we don't need
any of the other checks for it, and remove the duplicate mask checking
that is already done by the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/iommu.c     |  7 +++---
 arch/sparc/kernel/kernel.h    |  6 ++++-
 arch/sparc/kernel/pci.c       | 46 ++++++++++++-----------------------
 arch/sparc/kernel/pci_sun4v.c |  5 +++-
 4 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index b1a09080e8da..0c253f1c852e 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -745,14 +745,13 @@ static int dma_4u_supported(struct device *dev, u64 device_mask)
 {
 	struct iommu *iommu = dev->archdata.iommu;
 
+	if (ali_sound_dma_hack(dev, device_mask))
+		return 1;
+
 	if (device_mask > DMA_BIT_MASK(32))
 		return 0;
 	if ((device_mask & iommu->dma_addr_mask) == iommu->dma_addr_mask)
 		return 1;
-#ifdef CONFIG_PCI
-	if (dev_is_pci(dev))
-		return pci64_dma_supported(to_pci_dev(dev), device_mask);
-#endif
 	return 0;
 }
 
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index ddffd368e057..f6f498ba3198 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -45,7 +45,11 @@ void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs);
 void __irq_entry smp_kgdb_capture_client(int irq, struct pt_regs *regs);
 
 /* pci.c */
-int pci64_dma_supported(struct pci_dev *pdev, u64 device_mask);
+#ifdef CONFIG_PCI
+int ali_sound_dma_hack(struct device *dev, u64 device_mask);
+#else
+#define ali_sound_dma_hack(dev, mask)	(0)
+#endif
 
 /* signal32.c */
 void do_sigreturn32(struct pt_regs *regs);
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index bcfec6a85d23..5ed43828e078 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -956,51 +956,35 @@ void arch_teardown_msi_irq(unsigned int irq)
 }
 #endif /* !(CONFIG_PCI_MSI) */
 
-static void ali_sound_dma_hack(struct pci_dev *pdev, int set_bit)
+/* ALI sound chips generate 31-bits of DMA, a special register
+ * determines what bit 31 is emitted as.
+ */
+int ali_sound_dma_hack(struct device *dev, u64 device_mask)
 {
+	struct iommu *iommu = dev->archdata.iommu;
 	struct pci_dev *ali_isa_bridge;
 	u8 val;
 
-	/* ALI sound chips generate 31-bits of DMA, a special register
-	 * determines what bit 31 is emitted as.
-	 */
+	if (!dev_is_pci(dev))
+		return 0;
+
+	if (to_pci_dev(dev)->vendor != PCI_VENDOR_ID_AL ||
+	    to_pci_dev(dev)->device != PCI_DEVICE_ID_AL_M5451 ||
+	    device_mask != 0x7fffffff)
+		return 0;
+
 	ali_isa_bridge = pci_get_device(PCI_VENDOR_ID_AL,
 					 PCI_DEVICE_ID_AL_M1533,
 					 NULL);
 
 	pci_read_config_byte(ali_isa_bridge, 0x7e, &val);
-	if (set_bit)
+	if (iommu->dma_addr_mask & 0x80000000)
 		val |= 0x01;
 	else
 		val &= ~0x01;
 	pci_write_config_byte(ali_isa_bridge, 0x7e, val);
 	pci_dev_put(ali_isa_bridge);
-}
-
-int pci64_dma_supported(struct pci_dev *pdev, u64 device_mask)
-{
-	u64 dma_addr_mask;
-
-	if (pdev == NULL) {
-		dma_addr_mask = 0xffffffff;
-	} else {
-		struct iommu *iommu = pdev->dev.archdata.iommu;
-
-		dma_addr_mask = iommu->dma_addr_mask;
-
-		if (pdev->vendor == PCI_VENDOR_ID_AL &&
-		    pdev->device == PCI_DEVICE_ID_AL_M5451 &&
-		    device_mask == 0x7fffffff) {
-			ali_sound_dma_hack(pdev,
-					   (dma_addr_mask & 0x80000000) != 0);
-			return 1;
-		}
-	}
-
-	if (device_mask >= (1UL << 32UL))
-		return 0;
-
-	return (device_mask & dma_addr_mask) == dma_addr_mask;
+	return 1;
 }
 
 void pci_resource_to_user(const struct pci_dev *pdev, int bar,
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index fa0e42b4cbfb..d30eb22b6e11 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -676,6 +676,9 @@ static int dma_4v_supported(struct device *dev, u64 device_mask)
 	struct iommu *iommu = dev->archdata.iommu;
 	u64 dma_addr_mask = iommu->dma_addr_mask;
 
+	if (ali_sound_dma_hack(dev, device_mask))
+		return 1;
+
 	if (device_mask > DMA_BIT_MASK(32)) {
 		if (iommu->atu)
 			dma_addr_mask = iommu->atu->dma_addr_mask;
@@ -685,7 +688,7 @@ static int dma_4v_supported(struct device *dev, u64 device_mask)
 
 	if ((device_mask & dma_addr_mask) == dma_addr_mask)
 		return 1;
-	return pci64_dma_supported(to_pci_dev(dev), device_mask);
+	return 0;
 }
 
 static const struct dma_map_ops sun4v_dma_ops = {
-- 
2.20.1

