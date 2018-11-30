Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15FCC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBD72080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YI7mlrYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBD72080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeLAAdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:33:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeLAAdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GpxuU5NMbQU4Wkc8ZKHKSzkrwQNnxYoYUsxGInbTqJI=; b=YI7mlrYCbVJ+jK6g2JY+SFG38O
        wWXh6AKYVzcAk3wLIXzDeUVeTZvdQLrU89XK77IpfyY/uWB791aoc5nSdSYK4fcXdca/hWYUUZ7Sx
        3wmcpgRtUw4zspgsHWm+5oamGkUWk6hxtxg8653SzEDMC2s3jhkV2+hAdsfupqmCfZcoe13Zh6dFo
        ycm+hg461cGsrcFrutKM69CLCy9KeuluYsukAS1VOy1+9MDnulKnuRtiHlHzx33DT/PVHRUXwRnft
        zLz7Ptub7hpCkQjDq+H3efciK0ye4KGAYAdGig+hSMsMaiy+cjUwnFE3ItFm3Xl5HPxfcJoaCfETz
        iaaWcHMw==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSim8-0005Bp-BI; Fri, 30 Nov 2018 13:24:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/23] dma-mapping: return an error code from dma_mapping_error
Date:   Fri, 30 Nov 2018 14:22:31 +0100
Message-Id: <20181130132231.16512-24-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
References: <20181130132231.16512-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently dma_mapping_error returns a boolean as int, with 1 meaning
error.  This is rather unusual and many callers have to convert it to
errno value.  The callers are highly inconsistent with error codes
ranging from -ENOMEM over -EIO, -EINVAL and -EFAULT ranging to -EAGAIN.
Return -ENOMEM which seems to be what the largest number of callers
convert it to, and which also matches the typical error case where
we are out of resources.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2adef56c6069..b5bd25fc1f81 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -576,7 +576,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	debug_dma_mapping_error(dev, dma_addr);
 	if (dma_addr == DMA_MAPPING_ERROR)
-		return 1;
+		return -ENOMEM;
 	return 0;
 }
 
-- 
2.19.1

