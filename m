Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1FDC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721E920844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/04jqni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfBAIsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:48:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbfBAIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=it7hgDmLzWc1k/Yz2n7HKXPwU9eNC/NoGZJD3EXx09o=; b=I/04jqniu/vhIQMDD+8JWURNDw
        QlxyZD+viw/vFPhVRvjZ379SnTKnbe9vSFvvQp04872xAVvrLXXQMX4FWVNM2xo6c0HQn8LfLTeNF
        xZayuaNfqA5CgPy9RW/wmCo8scUvrucocBrt1DrwQD0rcLFRK7a3JWw2SIrExF1uhBGfuhTWwZM93
        K3XMWpe7iTBeRaIvz4PZCEBRNTUDQRMPaEqEKkVZA9W0PTgWgwxo/jzQ0AxGcQFlbUtL5QslqyAG2
        bpa8SW4zP6Jf3BbzUsR/EqZf4eoxS8HI6sBudOEX8lRWpAs6pM7BscZCnO5sHRfDv/0mL+lsUCLMm
        gjsxH36A==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUVA-0001Vl-SH; Fri, 01 Feb 2019 08:48:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     iommu@lists.linux-foundation.org
Subject: [PATCH 16/18] pxa3xx-gcu: pass struct device to dma_mmap_coherent
Date:   Fri,  1 Feb 2019 09:47:59 +0100
Message-Id: <20190201084801.10983-17-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like we do for all other DMA operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 69cfb337c857..047a2fa4b87e 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -96,6 +96,7 @@ struct pxa3xx_gcu_batch {
 };
 
 struct pxa3xx_gcu_priv {
+	struct device		 *dev;
 	void __iomem		 *mmio_base;
 	struct clk		 *clk;
 	struct pxa3xx_gcu_shared *shared;
@@ -493,7 +494,7 @@ pxa3xx_gcu_mmap(struct file *file, struct vm_area_struct *vma)
 		if (size != SHARED_SIZE)
 			return -EINVAL;
 
-		return dma_mmap_coherent(NULL, vma,
+		return dma_mmap_coherent(priv->dev, vma,
 			priv->shared, priv->shared_phys, size);
 
 	case SHARED_SIZE >> PAGE_SHIFT:
@@ -670,6 +671,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 	priv->resource_mem = r;
+	priv->dev = dev;
 	pxa3xx_gcu_reset(priv);
 	pxa3xx_gcu_init_debug_timer(priv);
 
-- 
2.20.1

