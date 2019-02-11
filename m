Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677CAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E3221B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dJ/PrqXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfBKNha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:37:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfBKNgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=osmIJoXiUZp9XJcZizxuGo/+RE8ol/LbGBZU4vh7E70=; b=dJ/PrqXk/B2cjxdsJ7fpgwn2b4
        YUcJTjxRcL7gin9f4dpYvs97V7LKTaEaxBGUOslOeP7FJ2CzV+AdtfDSgJjh8yxXGqdrC44uRo/Fd
        4Drvb+/dX+Xrf2Oz9d3GFC3VQw1dcn0lrOAuDguf/PTQWMwCUB3XqtjzlMwx/sa2kQhK4CyBCLOh1
        26lN71SRZu0Ng/gr/+YTaLpwryn5f9is/a2J6KC0sfcKpnL704R9geNBgx3gqIKNGpOy/6dihu79Z
        4IMSjAKBo1sL1JQjoOW4SXkbsaip3Xq6uJce2RSAOPRkW1Oefu2grVBNqIEfr+OWaAksbHe46xbuG
        94DTNHgw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBkq-00006S-UG; Mon, 11 Feb 2019 13:36:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] dma-mapping: remove an incorrect __iommem annotation
Date:   Mon, 11 Feb 2019 14:35:47 +0100
Message-Id: <20190211133554.30055-6-hch@lst.de>
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

memmap return a regular void pointer, not and __iomem one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/coherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 66f0fb7e9a3a..4b76aba574c2 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -43,7 +43,7 @@ static int dma_init_coherent_memory(
 	struct dma_coherent_mem **mem)
 {
 	struct dma_coherent_mem *dma_mem = NULL;
-	void __iomem *mem_base = NULL;
+	void *mem_base = NULL;
 	int pages = size >> PAGE_SHIFT;
 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 	int ret;
-- 
2.20.1

