Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A5FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175CC20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qfrmHcw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbfBMHCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:02:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfBMHCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SyCrC/DKeY+8w7bFKU1IF1vwF6AQyj8P9WfRTm5AAvE=; b=qfrmHcw3MUYo8nkv/ZeWVnn7AP
        +ZZobAHUlbf1wMgjLzD605oe4szYfA+yJ4F9PsO/YLK+597U1UG37st9M4uctxFcI8fZnngyBg1TO
        pIRhd5icGke8bDc0sTn0KVTVtBqUrxK/G159hdx8aSL5IupGFI0WhG6wGxOdZOecReDL40buAE0dD
        zDDZ3KH6meFTKzJPi257gcjyRzg6zy9qGzNHXyg5Mge9S1zcNWbipWldlS5j7dH5kiGpM+S76uPJF
        akVCWfKsSvAWHykY6aKAvO7E7y/wMCtYSRjR3Rpfp0eQMuovdaYF5L3LQA9AAln1nDCYHEZUsDgDm
        Ej8bU7QA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoY7-0000FR-8j; Wed, 13 Feb 2019 07:01:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH 02/32] dma-direct: we might need GFP_DMA for 32-bit dma masks
Date:   Wed, 13 Feb 2019 08:01:03 +0100
Message-Id: <20190213070133.11259-3-hch@lst.de>
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

If there is no ZONE_DMA32 we might need GFP_DMA to be able to
allocate memory that satisfies a 32-bit DMA mask.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 kernel/dma/direct.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 355d16acee6d..d5bb51cf27c6 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -132,8 +132,7 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 			goto again;
 		}
 
-		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
-		    phys_mask < DMA_BIT_MASK(32) && !(gfp & GFP_DMA)) {
+		if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA)) {
 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
 			goto again;
 		}
-- 
2.20.1

