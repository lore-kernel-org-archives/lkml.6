Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03713C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60B6222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lYpiZO2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbfBMHC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:02:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbfBMHCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xLC6A0GrP+mudRIo1Vz0KcRL3Hvqy94qgs3UZ9hBhEE=; b=lYpiZO2ThMo8YjSu9PihVgEjPi
        ntW+wsewFOI0MMmvyJc5IFPEvFtoJnH8NCEwGFDSPGhNMDYNrkwxQlKKnfAZC2iCmxp+c3IZ7Rlzb
        pfDGtcKziZxtkZthXXTi/sBYKCNMQ1mbup8LYyCb8Eoy0GHdZRLwU23TH9x5DpuFZBlHTdAGpAQva
        sn/RGWImX2VTgbmkUyNiMLs+sM6rfVD0Sxwx65KXOm3gkMJupEAo/tva9MalAZooMZijjpKn/+/wd
        cJu5+k1e5+cBEHrfHeO3UNO2ZaFPppfKy/Tz6D9pzAtLoowaBs10IQla/ioa5YD8x3L4VQjeTCxYa
        HBnztlxA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoYQ-0000I8-D6; Wed, 13 Feb 2019 07:01:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/32] powerpc/dart: use the generic iommu bypass code
Date:   Wed, 13 Feb 2019 08:01:11 +0100
Message-Id: <20190213070133.11259-11-hch@lst.de>
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

Use the generic iommu bypass code instead of overriding set_dma_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/sysdev/dart_iommu.c | 47 ++++++++++++--------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 283ce04c5844..d42ba645d51d 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -360,13 +360,6 @@ static void iommu_table_dart_setup(void)
 	set_bit(iommu_table_dart.it_size - 1, iommu_table_dart.it_map);
 }
 
-static void pci_dma_dev_setup_dart(struct pci_dev *dev)
-{
-	if (dart_is_u4)
-		set_dma_offset(&dev->dev, DART_U4_BYPASS_BASE);
-	set_iommu_table_base(&dev->dev, &iommu_table_dart);
-}
-
 static void pci_dma_bus_setup_dart(struct pci_bus *bus)
 {
 	if (!iommu_table_dart_inited) {
@@ -390,27 +383,18 @@ static bool dart_device_on_pcie(struct device *dev)
 	return false;
 }
 
-static int dart_dma_set_mask(struct device *dev, u64 dma_mask)
+static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 {
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-
-	/* U4 supports a DART bypass, we use it for 64-bit capable
-	 * devices to improve performances. However, that only works
-	 * for devices connected to U4 own PCIe interface, not bridged
-	 * through hypertransport. We need the device to support at
-	 * least 40 bits of addresses.
-	 */
-	if (dart_device_on_pcie(dev) && dma_mask >= DMA_BIT_MASK(40)) {
-		dev_info(dev, "Using 64-bit DMA iommu bypass\n");
-		set_dma_ops(dev, &dma_nommu_ops);
-	} else {
-		dev_info(dev, "Using 32-bit DMA via iommu\n");
-		set_dma_ops(dev, &dma_iommu_ops);
-	}
+	if (dart_is_u4 && dart_device_on_pcie(&dev->dev))
+		set_dma_offset(&dev->dev, DART_U4_BYPASS_BASE);
+	set_iommu_table_base(&dev->dev, &iommu_table_dart);
+}
 
-	*dev->dma_mask = dma_mask;
-	return 0;
+static bool iommu_bypass_supported_dart(struct pci_dev *dev, u64 mask)
+{
+	return dart_is_u4 &&
+		dart_device_on_pcie(&dev->dev) &&
+		mask >= DMA_BIT_MASK(40);
 }
 
 void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
@@ -430,12 +414,15 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 	if (dart_init(dn) != 0)
 		return;
 
-	/* Setup bypass if supported */
-	if (dart_is_u4)
-		ppc_md.dma_set_mask = dart_dma_set_mask;
-
+	/*
+	 * U4 supports a DART bypass, we use it for 64-bit capable devices to
+	 * improve performance.  However, that only works for devices connected
+	 * to the U4 own PCIe interface, not bridged through hypertransport.
+	 * We need the device to support at least 40 bits of addresses.
+	 */
 	controller_ops->dma_dev_setup = pci_dma_dev_setup_dart;
 	controller_ops->dma_bus_setup = pci_dma_bus_setup_dart;
+	controller_ops->iommu_bypass_supported = iommu_bypass_supported_dart;
 
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_iommu_ops);
-- 
2.20.1

