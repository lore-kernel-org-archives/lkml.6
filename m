Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ABDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B5020684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VBeO4MUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B5020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395333AbeKWAnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:43:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388851AbeKWAnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MtJ8xWA9qUHloLCvIEk/FO/K2KiiWlRZFAUGaRfluEU=; b=VBeO4MUyZpT6Uz3BAJpXDOk8Uo
        /FRVCIk1A14IplUDrLhOK/gb7SBRYL4RerbmU9plQ3LHIcmmN4tyiGNuJbB9rz7dJKxSpUS0GHIN1
        Kphn/TXjf55Olgpc9jNDFR+ufftxyVdLXH7aygV7C9ZJ4ZQcFpK8RXniWYx/H/Gw74hoXFLadGVJi
        kPk3z49co61r2z/69Xf+Kwnt0CCYu8afTmAvS2HCKXnUfGAMsWPWbfq1SlkVW17aNYEFT2KzbIysg
        iKoBMFEDulX4iK3g+vTgOhytNYv72XKVdeSZZYSb9qDXmS/znUupeKXJbpLTBYBVKsmSqsvvdz1pu
        1U2moY4Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpZn-0007Wm-1w; Thu, 22 Nov 2018 14:03:27 +0000
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
Subject: [PATCH 01/24] dma-direct: Make DIRECT_MAPPING_ERROR viable for SWIOTLB
Date:   Thu, 22 Nov 2018 15:02:57 +0100
Message-Id: <20181122140320.24080-2-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122140320.24080-1-hch@lst.de>
References: <20181122140320.24080-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

With the overflow buffer removed, we no longer have a unique address
which is guaranteed not to be a valid DMA target to use as an error
token. The DIRECT_MAPPING_ERROR value of 0 tries to at least represent
an unlikely DMA target, but unfortunately there are already SWIOTLB
users with DMA-able memory at physical address 0 which now gets falsely
treated as a mapping failure and leads to all manner of misbehaviour.

The best we can do to mitigate that is flip DIRECT_MAPPING_ERROR to the
other commonly-used error value of all-bits-set, since the last single
byte of memory is by far the least-likely-valid DMA target.

Fixes: dff8d6c1ed58 ("swiotlb: remove the overflow buffer")
Reported-by: John Stultz <john.stultz@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index bd73e7a91410..9e66bfe369aa 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -5,7 +5,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mem_encrypt.h>
 
-#define DIRECT_MAPPING_ERROR		0
+#define DIRECT_MAPPING_ERROR		(~(dma_addr_t)0)
 
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
-- 
2.19.1

