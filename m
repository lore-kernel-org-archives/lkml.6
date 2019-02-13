Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC048C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0CE20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P2i8Izg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbfBMHCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:02:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388614AbfBMHCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ave9R4JqSgfJ1O28BXwhjR1N/4+/2O2q41XoX/ZRGwo=; b=P2i8Izg69f1cwMFd2PnjerWAb9
        QAMSkieGduBOG41Er9PLrUQiCXlM9XV8UzjL4ZVAP1h87P1XY+nOps7DAHgXZ0qgfZqexebm0dABq
        7qGSTHQSY+qUFiA25lQhp4vfNzA6o39HI+HfPxlW+aEJqgMG9GmyEIsB9khBQF0uALcs+3qmJy/LK
        bYVbYMv/HgcfInCE2X3NQS3GBpgzKhdMTDxfXqNNjrX69vqsRpI0t4hnXgQlIrSgaEwZHcWhj5TXZ
        vfr8VVRS8640oKXYyLly+zPiIDONGRVSwxVMpzEpMVRla5fRsuZ2ezn3IGZ+v715hUu+lTGwB+hGh
        LtFCYwtw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoYo-0000SG-Cw; Wed, 13 Feb 2019 07:02:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH 20/32] powerpc/dma: fix an off-by-one in dma_capable
Date:   Wed, 13 Feb 2019 08:01:21 +0100
Message-Id: <20190213070133.11259-21-hch@lst.de>
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

We need to compare the last byte in the dma range and not the one after it
for the bus_dma_mask, just like we do for the regular dma_mask.  Fix this
cleanly by merging the two comparisms into one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/dma-direct.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
index e00ab5d0612d..92d8aed86422 100644
--- a/arch/powerpc/include/asm/dma-direct.h
+++ b/arch/powerpc/include/asm/dma-direct.h
@@ -4,15 +4,11 @@
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
-#ifdef CONFIG_SWIOTLB
-	if (dev->bus_dma_mask && addr + size > dev->bus_dma_mask)
-		return false;
-#endif
-
 	if (!dev->dma_mask)
 		return false;
 
-	return addr + size - 1 <= *dev->dma_mask;
+	return addr + size - 1 <=
+		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
 }
 
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
-- 
2.20.1

