Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F86EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF25720811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y3NjE+8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbfBMHCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:02:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfBMHCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t3wdaF/GV1zdw+imZ6thmStPlhYryMbwMA50pdeDYZM=; b=Y3NjE+8J8M51oB79fH7DHAVXIP
        CVwAES1f4rlOacycwL020m/pTEGN2U1Mr5UHIKQh5g5FM/pUNPjEdxbAsL1BOBA1HhA+VM8rdyD+N
        cxAwPg500RzXuiIn/XxY46RHKSmMNN6LUIzLWQHkEFedvgV/KBFwtKS4NVxCC9Gw0iETtvGuIaxTi
        e/LkewM2juxtxLTHTSmDSspx6SegsjrtfryPNyKRspzeDAdcS7MMyPX9TM+eiiz+Q+tNkxNJBoDXw
        0vcdaOoIue6UUAsMvXmGM+Q7IAmGqjrMR+TW55AxVQSM6ITzYJMZrtJ3wDRGGmFkxp5RFUfDcH8CI
        x62Kvw1Q==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoYE-0000GP-FU; Wed, 13 Feb 2019 07:01:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/32] powerpc/pseries: unwind dma_get_required_mask_pSeriesLP a bit
Date:   Wed, 13 Feb 2019 08:01:06 +0100
Message-Id: <20190213070133.11259-6-hch@lst.de>
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

Call dma_get_required_mask_pSeriesLP directly instead of dma_iommu_ops
to simply the code a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/pseries/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 8fc8fe0b9848..9f7ac75c5687 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1278,7 +1278,7 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
 			return DMA_BIT_MASK(64);
 	}
 
-	return dma_iommu_ops.get_required_mask(dev);
+	return dma_iommu_get_required_mask(dev);
 }
 
 static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
-- 
2.20.1

