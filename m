Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89BEC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773AE2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JvHYW2+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773AE2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJIUnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:43:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbeJIUnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VVrA3gX4S4aK9b26/sI5R8iiOEO8w46y03v4nt2GxbY=; b=JvHYW2+NRx9uTFwvGoZUB3K994
        Ltj4pFTEi1yyA7kwBwtmRHbedPTrG3gCPqY3wCtb3bZJEHjCU/sqzXnuLSNkRz+Gvu7vpO0Rls4T3
        CEuP5xLYrWxsf1knWSzpOzUEjS/OdZMAKeCH2kieVo4v18xgHP53xYO+2HBmp6cuRYbJiS6eSWB9t
        KdmnUzrgjecB0KlFQoVB+hDIWFA7Gby/cIUFD544mthDIRFUSigTLJw/Hmmc1Z5LdqBHR3DB+daMT
        GFAtYLTlaT7t9DmlVXFMS50N0RdDWG4thjLXBau8unoiIp7Q7coMJg57S/4wMHn4/1Iu1QPE9dC9G
        WbMOli/w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9s1T-0001Rf-QG; Tue, 09 Oct 2018 13:26:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/33] powerpc/dma: fix an off-by-one in dma_capable
Date:   Tue,  9 Oct 2018 15:24:51 +0200
Message-Id: <20181009132500.17643-25-hch@lst.de>
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

We need to compare the last byte in the dma range and not the one after it
for the bus_dma_mask, just like we do for the regular dma_mask.  Fix this
cleanly by merging the two comparisms into one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
2.19.0

