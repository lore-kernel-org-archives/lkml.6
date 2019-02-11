Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E4CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D67218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="acIvOZoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfBKNgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:36:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfBKNgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W9FJcTHMzF5rFxf5wloOxdXDIN4eS7UeMrDr1N/9VIE=; b=acIvOZoyjIOlcdNN91jqtE2VHc
        wyTYQROu3gLMmWo3Llh/eckVIVQm5Xt55KzQZfFMLel4VoUVuWlr1v5SonbkTOUEPWUvhTXcA7hYd
        lT5AXgX/b5gf82nr3ng5X9UmWXgSdMirDGqaThQnzOocIRI7j9I3WrXMQklDT6O3E14yDsyUGrCQi
        q2k0wcqTmDHkShP7DmXZ0cirIN4lCYNZAOJNq6BehdZQ5PhMRxg7yWI8tkdtW+hoDhdvhR2Upb4iK
        pBDjvo/tgt6m0sZLAMv7bz3CKa3ThF7l/+JGpHIlgSDsH9apGIDX37PVkBdn/6kBGgAOBXZaLrEbu
        OYsacSpg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBlA-0000WC-MV; Mon, 11 Feb 2019 13:36:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] dma-mapping: remove dma_assign_coherent_memory
Date:   Mon, 11 Feb 2019 14:35:54 +0100
Message-Id: <20190211133554.30055-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only useful bit in this function was the already assigned check.
Once that is moved to dma_init_coherent_memory thee rest can easily
be handled in the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/coherent.c | 47 +++++++++++++------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index d7a27008f228..1e3ce71cd993 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -41,6 +41,9 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr,
 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 	int ret;
 
+	if (*mem)
+		return -EBUSY;
+
 	if (!size) {
 		ret = -EINVAL;
 		goto out;
@@ -88,33 +91,11 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
 	kfree(mem);
 }
 
-static int dma_assign_coherent_memory(struct device *dev,
-				      struct dma_coherent_mem *mem)
-{
-	if (!dev)
-		return -ENODEV;
-
-	if (dev->dma_mem)
-		return -EBUSY;
-
-	dev->dma_mem = mem;
-	return 0;
-}
-
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size)
 {
-	struct dma_coherent_mem *mem;
-	int ret;
-
-	ret = dma_init_coherent_memory(phys_addr, device_addr, size, &mem);
-	if (ret)
-		return ret;
-
-	ret = dma_assign_coherent_memory(dev, mem);
-	if (ret)
-		dma_release_coherent_memory(mem);
-	return ret;
+	return dma_init_coherent_memory(phys_addr, device_addr, size,
+					&dev->dma_mem);
 }
 EXPORT_SYMBOL(dma_declare_coherent_memory);
 
@@ -238,18 +219,18 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 	struct dma_coherent_mem *mem = rmem->priv;
 	int ret;
 
-	if (!mem) {
-		ret = dma_init_coherent_memory(rmem->base, rmem->base,
-					       rmem->size, &mem);
-		if (ret) {
-			pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
-				&rmem->base, (unsigned long)rmem->size / SZ_1M);
-			return ret;
-		}
+	ret = dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
+			&mem);
+	if (ret && ret != -EBUSY) {
+		pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
+			&rmem->base, (unsigned long)rmem->size / SZ_1M);
+		return ret;
 	}
+
 	mem->use_dev_dma_pfn_offset = true;
+	if (dev)
+		dev->dma_mem = mem;
 	rmem->priv = mem;
-	dma_assign_coherent_memory(dev, mem);
 	return 0;
 }
 
-- 
2.20.1

