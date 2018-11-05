Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568C3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A4420862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jeB+l7G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A4420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeKEVjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:39:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GNP3QZkUtNcfG6I6CHAZQC0h4FOvkNK1Ksbhy3qHmcM=; b=jeB+l7G/6ip1HZNL1sKvnMPx4r
        ksqXpZ4rivKTnarU9bCs7EHdITGaaXLJduPYCqmNtNa6A55DEvp3n+6aOrUGwp1v+wUZLpQZ7IjpQ
        +OvFYGfun+y8cyGS0sFfJVrMlbn6duito58l3QUejVnpWkDoIW6G+uD1HPB3QoYONb9pLyryj3+VG
        Tq1o/oFBe4hAmS4BeNM8HuJSAOZTW8YHA2qetvMPQLRFEpiOWMOAQWXYDwXZU1aO6eM81QPzucEmI
        THLTmlpRXojvItxDRc1zQzyF2O+wUW0EBOs9m1iSIHyx7oXgzMyg856/MENjj9TFyJwff2ZPbHpXS
        cKclyz7g==;
Received: from 213-225-37-95.nat.highway.a1.net ([213.225.37.95] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJdrK-0003nt-3c; Mon, 05 Nov 2018 12:19:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] csky: don't use GFP_DMA in atomic_pool_init
Date:   Mon,  5 Nov 2018 13:19:30 +0100
Message-Id: <20181105121931.13481-9-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csky does not implement ZONE_DMA, which means passing GFP_DMA is a no-op.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/csky/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 85437b21e045..ad4046939713 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -35,7 +35,7 @@ static int __init atomic_pool_init(void)
 	if (!atomic_pool)
 		BUG();
 
-	page = alloc_pages(GFP_KERNEL | GFP_DMA, get_order(size));
+	page = alloc_pages(GFP_KERNEL, get_order(size));
 	if (!page)
 		BUG();
 
-- 
2.19.1

