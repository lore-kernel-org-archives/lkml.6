Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5B8C64EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA4C2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nOI0Boaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA4C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJBCwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:52:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJBCw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WnJ6NHu4nqp7TCuwHFmieUsAK1PZgHHpdvLQg/ehxJs=; b=nOI0BoafQyqAtsjj/K/UwlEXY4
        v/d26IzIPsWhz1NAnQ9B0zLNAFL8lFCS2OE3VbZ0TSPMj1YO8Qi3eli+7SBWF+dplJAw49zGxLPhP
        ZGCWNXW9vMMNK2NvE2vgHS2cTbABw4Fs2dlioPz4DnTRGWcdAZAC/Mim1NZTTjOWVLNr3UrEOCOyk
        9VbvQIRL2YzjhT3w2S1cEEZjFePlBn9KXG7vLJfwEzy6T7BC3CoCxc7tGIObUfoVGGpg53HTOuzqg
        +Qw3eAJGnK7oLTQc+KD9cguAkU3eYD74N2IZx6vmA9Wt5vLA7ocdmwGK87KzISvJNjAfNtxnqiTA5
        wt6HPJ9Q==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g74Ys-0006wC-BK; Mon, 01 Oct 2018 20:12:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dma-direct: respect DMA_ATTR_NO_WARN
Date:   Mon,  1 Oct 2018 13:12:57 -0700
Message-Id: <20181001201257.366-3-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001201257.366-1-hch@lst.de>
References: <20181001201257.366-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respect the DMA_ATTR_NO_WARN flags for allocations in dma-direct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 170bd322a94a..ba6f5956a291 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -107,6 +107,9 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	u64 phys_mask;
 	void *ret;
 
+	if (attrs & DMA_ATTR_NO_WARN)
+		gfp |= __GFP_NOWARN;
+
 	/* we always manually zero the memory once we are done: */
 	gfp &= ~__GFP_ZERO;
 	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-- 
2.19.0

