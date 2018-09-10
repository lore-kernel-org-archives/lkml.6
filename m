Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB9DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0E32086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cbivtimP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0E32086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeIJLGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:06:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJLGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lP/JhLpsmRplE0vYuF60p7HNq85+66zIA3PSpDF3N40=; b=cbivtimPGLfIs2v9iwstvl1zI
        /OQBke1tWMf5sM3oOHpzyc1xHrqdkXzmtX3w5tRJkHx4Tn1ZWeJSvt08yLngwR4etK1+66dEMMpOx
        CdcehD6NCqVktbWIWp8Vu/cgFQ9cSVEMsLAdbaLsV1o9qtcuOXtJ5vlbjhCvxsYVoRGM3rlVeVCeP
        1/EsZdokrRCvKJKf3DARcVNOTwN0Kz9CE7lLnWzKSOyNb6YYxx3OyGDYqt0HCUbnoOMZUvU/qMYS4
        bFBucSGvsEvu7ZQQE7zZYK2meAjhLVogoMheONk66f0HjBGgM66XtcrsDH7RnrQicbCqbcSlrsdcD
        R1BwD4eNQ==;
Received: from 213-225-3-213.nat.highway.a1.net ([213.225.3.213] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzFS8-00022O-LC; Mon, 10 Sep 2018 06:13:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dma-mapping: simplify dma_direct get_required_mask
Date:   Mon, 10 Sep 2018 08:13:31 +0200
Message-Id: <20180910061332.28187-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180910061332.28187-1-hch@lst.de>
References: <20180910061332.28187-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we use fls64 we don't need to divide the max address into lower
and upper halves.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/platform.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index a255fc8aa483..7812b861b6da 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1185,21 +1185,9 @@ int __init platform_bus_init(void)
  */
 u64 dma_direct_get_required_mask(struct device *dev)
 {
-	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
-	u32 high_totalram = ((max_pfn - 1) >> (32 - PAGE_SHIFT));
-	u64 mask;
-
-	if (!high_totalram) {
-		/* convert to mask just covering totalram */
-		low_totalram = (1 << (fls(low_totalram) - 1));
-		low_totalram += low_totalram - 1;
-		mask = low_totalram;
-	} else {
-		high_totalram = (1 << (fls(high_totalram) - 1));
-		high_totalram += high_totalram - 1;
-		mask = (((u64)high_totalram) << 32) + 0xffffffff;
-	}
-	return mask;
+	u64 end = ((max_pfn - 1) << PAGE_SHIFT);
+
+	return (1 << (fls64(end) - 1)) * 2 - 1;
 }
 
 #ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
-- 
2.18.0

