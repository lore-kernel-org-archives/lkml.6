Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5BAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3C82192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dqPnss6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395166AbfBOOqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:46:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395136AbfBOOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vWBg3JgcaBfg1pycBuwVJLdLYWOrWYb8fSLJb2JWrbw=; b=dqPnss6bDOC+lOREHVQtyFpKE+
        atVsWDKV6aifHeGSqhsjlWy+VkpBmUHAUyQP7PjtapP8NUfmKOaoVS1nlChGl6BIV5sVuaE2Wh+Ox
        JGKuGmFXHHKeD5xXMUbR/JRq/iW+LNPQvZO1xm8VpFdzAXHBR0vAWYTuQYrRMBB+0d7MKs/4yNzmZ
        WOs00rBrAA8NuR6jrT0tEjYV8sqA2A6hDTazgD44ZgMjmY+G44RwonX5ZS+YmUDuMg1zu6s5mmoU0
        AIhQ1kXpYD15OG9kNN2rKdXzfxgtKrTm7pbldjSoRqeXNUMY67ywB0L62QRTnkpVWF5Y1OtdEsR3e
        2E6+d2Yg==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guekj-0005QK-2h; Fri, 15 Feb 2019 14:46:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] sparc64/iommu: allow large DMA masks
Date:   Fri, 15 Feb 2019 15:45:57 +0100
Message-Id: <20190215144559.8777-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215144559.8777-1-hch@lst.de>
References: <20190215144559.8777-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've been moving to a model where the device just sets the DMA mask
supported by it, instead of having to fallback to something it thinks
the platform might support.  Sparc64 is the remaining holdout forcing
drivers to supply a matching mask.  Change dma_4u_supported to just
check if the supplied dma mask is large enough as nothing in the
iommu.c code (or the core DMA code) actually looks at the DMA mask
later on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 0c253f1c852e..4ae7388b1bff 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -748,11 +748,9 @@ static int dma_4u_supported(struct device *dev, u64 device_mask)
 	if (ali_sound_dma_hack(dev, device_mask))
 		return 1;
 
-	if (device_mask > DMA_BIT_MASK(32))
+	if (device_mask < iommu->dma_addr_mask)
 		return 0;
-	if ((device_mask & iommu->dma_addr_mask) == iommu->dma_addr_mask)
-		return 1;
-	return 0;
+	return 1;
 }
 
 static const struct dma_map_ops sun4u_dma_ops = {
-- 
2.20.1

