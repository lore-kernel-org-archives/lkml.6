Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B67C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2077C222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tmiq2Erq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbfBMHEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:04:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387584AbfBMHCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oftqg/DLnlA4XOQDc02Y6qXG24fb6uUpb//RA0foQtI=; b=tmiq2Erql840y6jWpuiCtwJ5l/
        9KYy8hJZZR47nCaUAldopA4uOgw5koo/sMGnt+yyGvvfiyccbUc5OqEywjKRKCPLcc0kBx7iQK5VH
        RXJzk2dWMyXOmEvZQIcdq/u2eKVtY43cLPrTLKNvMF38iK8d0M/aAKxEuPB+GjTa1h94/QO58HJtG
        PSyr8ywq56Cq8zPkphAY9h22CJ9fpv76N3encArGpl37j0M3TQsRFr6+Ut5zId18GQsB/UpuokzC/
        XlE93qfoNCom58JvVNQ6gPBhLwH4grGWvSss59ESbg2r436Kp9t0/C6X9w8ZV0MQpkSNeo2AnrnUL
        /AQGEnOw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoYS-0000IR-Oz; Wed, 13 Feb 2019 07:02:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/32] powerpc/powernv: remove pnv_pci_ioda_pe_single_vendor
Date:   Wed, 13 Feb 2019 08:01:12 +0100
Message-Id: <20190213070133.11259-12-hch@lst.de>
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

This function is completely bogus - the fact that two PCIe devices come
from the same vendor has absolutely nothing to say about the DMA
capabilities and characteristics.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 28 ++---------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 53982f887a7f..d9060a0f4c8e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1756,31 +1756,6 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
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
@@ -1881,7 +1856,8 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
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
2.20.1

