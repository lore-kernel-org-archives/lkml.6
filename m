Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98302C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A18F20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gd3tcy2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbfBMHCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:02:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfBMHCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BwvNPx1nbCxxl00TZ+tlGve53HbJ277SuN/3ICIDGTE=; b=gd3tcy2jYkn0mcg8NOwdCPfMad
        f1dWfb+/ccNK50NTO+19wpLYH2ICvugvXG6mrFreyop5PjozNTEZowrJN7Tspr02+IDXauHao7AHk
        PbPx7W/8UOSLmahlDFQna8bWo8c6fZHY34vtCxOHpxwZhhTB5G+M2dBL/RRjvYBClmpnCWg4C/pU9
        uEqouSq/i/7HnWLqK7OG/2KH8r8kmpxiIeB5SLr1+7mgSPlF4f1Wk2SANkaA7eU7Nt8d/UXSvezCw
        7G9guUBuF483VxRFM7o4bzImsepb33hRbnmbiWo1yNMNV4rBqOuZ9BRq9Myd+9Kyu0bNewI13lhto
        uf4wwQmA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoY4-0000F8-Qe; Wed, 13 Feb 2019 07:01:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH 01/32] net: pasemi: set a 64-bit DMA mask on the DMA device
Date:   Wed, 13 Feb 2019 08:01:02 +0100
Message-Id: <20190213070133.11259-2-hch@lst.de>
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

The pasemi driver never set a DMA mask, and given that the powerpc
DMA mapping routines never check it this worked ok so far.  But the
generic dma-direct code which I plan to switch on for powerpc checks
the DMA mask and fails unsupported mapping requests, so we need to
make sure the proper 64-bit mask is set.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 drivers/net/ethernet/pasemi/pasemi_mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index d21041554507..a5bf46310f60 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1716,6 +1716,7 @@ pasemi_mac_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = -ENODEV;
 		goto out;
 	}
+	dma_set_mask(&mac->dma_pdev->dev, DMA_BIT_MASK(64));
 
 	mac->iob_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa001, NULL);
 	if (!mac->iob_pdev) {
-- 
2.20.1

