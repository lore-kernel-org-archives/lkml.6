Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C00D0C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7560B208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fOpJfY6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7560B208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936019AbeFNMAk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:00:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935648AbeFNMAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ckwFWwvkrWYoyXwRCWsB3dVVujFNWtgGb0PVZJpy/b4=; b=fOpJfY6Omxa2NDAgN7gqISH3v
        p53y63zHoGtAqeGpcxuzpipjSxSHj8lbizwrQHTuOtZiS6AxoQc7wKPf2uJiy8yyaZjHaYeKQ0NdO
        7iOCswBnntd09BSW44xac7Y+/M52D/qK5clO2Lp5nkkwkTmVEiVjiC7k3rcWGgUSUjVKsnfc3LPL0
        mthS210OqfT8mGyIFAW4aO+2efvOngSK8m4OMxqclctInD3nzaSDivgHUk8z4ZDpi9tnNYqWqSAyY
        q1XxUh4x2HlFH31bmKqt11r35FrT2gUzbYUwD7M8uKq0RhPMNFjpUXmc5zYwBMH3eIEJIp3oohG3f
        JYs5QVpPA==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTQva-0002wv-6o; Thu, 14 Jun 2018 12:00:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dma-mapping: use obj-y instead of lib-y for generic dma ops
Date:   Thu, 14 Jun 2018 14:00:28 +0200
Message-Id: <20180614120029.27315-2-hch@lst.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614120029.27315-1-hch@lst.de>
References: <20180614120029.27315-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have exact config symbols to select the direct, non-coherent,
or virt dma ops.  So use the normal obj- scheme to select them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 956b320292fe..5e0e160c9242 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -29,9 +29,9 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
-lib-$(CONFIG_DMA_DIRECT_OPS) += dma-direct.o
-lib-$(CONFIG_DMA_NONCOHERENT_OPS) += dma-noncoherent.o
-lib-$(CONFIG_DMA_VIRT_OPS) += dma-virt.o
+obj-$(CONFIG_DMA_DIRECT_OPS) += dma-direct.o
+obj-$(CONFIG_DMA_NONCOHERENT_OPS) += dma-noncoherent.o
+obj-$(CONFIG_DMA_VIRT_OPS) += dma-virt.o
 
 lib-y	+= kobject.o klist.o
 obj-y	+= lockref.o
-- 
2.17.1

