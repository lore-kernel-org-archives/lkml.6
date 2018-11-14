Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EEBC07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9252E21780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ck2crkxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9252E21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbeKNS0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:26:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeKNS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vO1AXWRry65fSmV2hiFEz4IJdhQJh8cqGPR7PM+xtEg=; b=ck2crkxJfGquKIGlFA8BjbnFCD
        tQsAQJRhiX6/YuIyStFiRR6hHTUTP47CG/vV/y8aJ2Wz2p+IT8qQIpDW1038JyUZxNzuM6eeRwZBr
        Wa2KwWsjRkO/KmwJ7Xsy97N89M3WQDX8BMRkrOv4Vb30rQW+N5I75qjJ+lriKAMddiKh8Q950SxJz
        e5/Ey/+zyv/SDWxpZZQFP6l+ecdgNP5f+DJ696B3lLF6InjexNhq5YkIPEAM5pL+lk/7sG7GpZGbx
        Gc8RZt3BC1T5M4wE+kwyh2xMAcLiTIkbH+cd7zzcuPCbws0KFPLjZkzZAYeZeAka3L0jYC8D+Zaez
        KzelDSjg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqSu-0004vj-EF; Wed, 14 Nov 2018 08:24:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/34] powerpc/powernv: remove pnv_pci_ioda_pe_single_vendor
Date:   Wed, 14 Nov 2018 09:22:56 +0100
Message-Id: <20181114082314.8965-17-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
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
index dd807446801e..afbb73cd3c5b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1745,31 +1745,6 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
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
@@ -1870,7 +1845,8 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
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
2.19.1

