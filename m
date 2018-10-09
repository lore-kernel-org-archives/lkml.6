Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F563C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2388E214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rpyLZ6Yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2388E214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJIUnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:43:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeJIUnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+X8AkMvhaCh2A6t5uXBVRn35aMYZZ+/hh9Cwb5Qv+ts=; b=rpyLZ6YvZXHfiGUtIIrCY/qTI3
        NbJFMlXogf9f9yqOcfRPbnZhcyu0MzTVOzBxq/9rnc7ArXxSu6Zjv07gqCTZS+pfOi3a5opVFMut5
        R2HBm6b201wRWNUTC/xmvVRZLqZanoVvu5VbAmOgb8s2QERa9LBR0qTpEVBJmXTgNrXAQNae3/2tQ
        QUYwo68x4wPzlMOkbR4ukjwJN3SxuJTFdTQ1ocfY6d6tZW+P21kFrBQIGH1LyUXROGkqLNTpap1ga
        kZakTm2C41zhMHGd23oBHeyEWYzDYMFKao3HxrDenHxHyF0mXxB7f24YLHII5yKeTzYi96i2xHobh
        smXPsyoQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9s13-0001CT-Uu; Tue, 09 Oct 2018 13:25:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/33] powerpc/powernv: remove pnv_pci_ioda_pe_single_vendor
Date:   Tue,  9 Oct 2018 15:24:42 +0200
Message-Id: <20181009132500.17643-16-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is completely bogus - the fact that two PCIe devices come
from the same vendor has absolutely nothing to say about the DMA
capabilities and characteristics.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 28 ++---------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index cde710297a4e..913175ba1c10 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1746,31 +1746,6 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 	 */
 }
 
-static bool pnv_pci_ioda_pe_single_vendor(struct pnv_ioda_pe *pe)
-{
-	unsigned short vendor = 0;
-	struct pci_dev *pdev;
-
-	if (pe->device_count == 1)
-		return true;
-
-	/* pe->pdev should be set if it's a single device, pe->pbus if not */
-	if (!pe->pbus)
-		return true;
-
-	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
-		if (!vendor) {
-			vendor = pdev->vendor;
-			continue;
-		}
-
-		if (pdev->vendor != vendor)
-			return false;
-	}
-
-	return true;
-}
-
 /*
  * Reconfigure TVE#0 to be usable as 64-bit DMA space.
  *
@@ -1871,7 +1846,8 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 		 */
 		if (dma_mask >> 32 &&
 		    dma_mask > (memory_hotplug_max() + (1ULL << 32)) &&
-		    pnv_pci_ioda_pe_single_vendor(pe) &&
+		    /* pe->pdev should be set if it's a single device, pe->pbus if not */
+		    (pe->device_count == 1 || !pe->pbus) &&
 		    phb->model == PNV_PHB_MODEL_PHB3) {
 			/* Configure the bypass mode */
 			rc = pnv_pci_ioda_dma_64bit_bypass(pe);
-- 
2.19.0

