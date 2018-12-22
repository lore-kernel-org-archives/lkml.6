Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB3AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C02A2195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dBWSCG74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbeLVTDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:03:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732563AbeLVTDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=40ji/6+T9tny/xMb8Gbc+xghPpi0S+C7Cmxn4yGKgNQ=; b=dBWSCG74Lj7fDM0CUM5HzBkjOB
        ELZbOsHQ/zW2LlFThZxphioewSDYzKW0W4GO2wwvHU3ODPfZ0db7yXyvMpKL21qxAiLdg0zHxjrN6
        z80zVLd36fVDm8XSC9cJsCmsv1m4laTIz1OROS3AwnbBhqS+JkUGVNw/ApsKhYjSAUBdjSZ20Pn1c
        ZQJl0X/lQR1FFEqPxOGD0CyP5GCYDj72yIZ/0IkPa3clkqBK2hLiTZ/uyAdMWxQd0Bftu6qBR1feH
        4vWjAt5R7S46qSL8HGNMkE4WxEHtnkeJAXVrs81oKDaRxn5iL7oiJPFe69TbpbzrH9yqcqRthetIP
        GEene44Q==;
Received: from p4ff2ed53.dip0.t-ipconnect.de ([79.242.237.83] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gacX2-00033O-Pr; Sat, 22 Dec 2018 08:21:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: fix flags in dma_alloc_wc
Date:   Sat, 22 Dec 2018 09:21:08 +0100
Message-Id: <20181222082108.24496-2-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181222082108.24496-1-hch@lst.de>
References: <20181222082108.24496-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We really need the writecombine flag in dma_alloc_wc, fix a stupid
oversight.

Fixes: 7ed1d91a9e ("dma-mapping: translate __GFP_NOFAIL to DMA_ATTR_NO_WARN")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 15bd41447025..d327bdd53716 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -796,7 +796,7 @@ static inline void dmam_release_declared_memory(struct device *dev)
 static inline void *dma_alloc_wc(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t gfp)
 {
-	unsigned long attrs = DMA_ATTR_NO_WARN;
+	unsigned long attrs = DMA_ATTR_WRITE_COMBINE;
 
 	if (gfp & __GFP_NOWARN)
 		attrs |= DMA_ATTR_NO_WARN;
-- 
2.19.2

