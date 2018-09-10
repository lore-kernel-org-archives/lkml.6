Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A9AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E77420854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SzPhrtCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E77420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIJK6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:58:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJK6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aYDMexnkrCtlRs/Rk2EfhjL4KIhddofkXoarJAzdIfI=; b=SzPhrtCwIxGa6amU5ArmZYmfz
        LCMJuaEzsdsUebz5SrILLrCjWx9mzWHjRY3oqIOurUw4+i1Nr1Ni0ZfUJe+gl6lTU5L1fgxUZAMk4
        R/bGdOoBJrdT5AXbvdxj2ninshmkbiTIqGMXoh+qxy2fhYGYhKQT7DVrJvUtdYMj9P10HcFBr4Yj4
        ZiNxd7XoDyiHkkEQe74GxG1OmonU45i+1SaIMVg5A1RoZdH8kSPy2Abgzi8X5cfO5DcLx1d1wn/WW
        lFnOEOglAhFTEab1HYcMHZfRrWlufwpkgeYqExACg9FY2ia54Kf+9um24DfFOIjec8k2YZNPO3ngS
        DwIdy2VlQ==;
Received: from 213-225-3-213.nat.highway.a1.net ([213.225.3.213] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzFKN-0007yz-4q; Mon, 10 Sep 2018 06:05:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] MIPS: don't select DMA_MAYBE_COHERENT from DMA_PERDEV_COHERENT
Date:   Mon, 10 Sep 2018 08:05:29 +0200
Message-Id: <20180910060533.27172-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180910060533.27172-1-hch@lst.de>
References: <20180910060533.27172-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While both option select a form of conditional dma coherence they don't
actually share any code in the implementation, so untangle them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/Kconfig        |  2 +-
 arch/mips/kernel/setup.c |  2 +-
 arch/mips/mm/c-r4k.c     | 17 ++++++++---------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35511999156a..0b25180028b8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1111,7 +1111,7 @@ config DMA_MAYBE_COHERENT
 
 config DMA_PERDEV_COHERENT
 	bool
-	select DMA_MAYBE_COHERENT
+	select DMA_NONCOHERENT
 
 config DMA_NONCOHERENT
 	bool
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c71d1eb7da59..6d840a44fa36 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -1067,7 +1067,7 @@ static int __init debugfs_mips(void)
 arch_initcall(debugfs_mips);
 #endif
 
-#if defined(CONFIG_DMA_MAYBE_COHERENT) && !defined(CONFIG_DMA_PERDEV_COHERENT)
+#ifdef CONFIG_DMA_MAYBE_COHERENT
 /* User defined DMA coherency from command line. */
 enum coherent_io_user_state coherentio = IO_COHERENCE_DEFAULT;
 EXPORT_SYMBOL_GPL(coherentio);
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index a9ef057c79fe..05bd77727fb9 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1955,22 +1955,21 @@ void r4k_cache_init(void)
 	__flush_icache_user_range	= r4k_flush_icache_user_range;
 	__local_flush_icache_user_range	= local_r4k_flush_icache_user_range;
 
-#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
-# if defined(CONFIG_DMA_PERDEV_COHERENT)
-	if (0) {
-# else
-	if ((coherentio == IO_COHERENCE_ENABLED) ||
-	    ((coherentio == IO_COHERENCE_DEFAULT) && hw_coherentio)) {
-# endif
+#ifdef CONFIG_DMA_NONCOHERENT
+#ifdef CONFIG_DMA_MAYBE_COHERENT
+	if (coherentio == IO_COHERENCE_ENABLED ||
+	    (coherentio == IO_COHERENCE_DEFAULT && hw_coherentio)) {
 		_dma_cache_wback_inv	= (void *)cache_noop;
 		_dma_cache_wback	= (void *)cache_noop;
 		_dma_cache_inv		= (void *)cache_noop;
-	} else {
+	} else
+#endif /* CONFIG_DMA_MAYBE_COHERENT */
+	{
 		_dma_cache_wback_inv	= r4k_dma_cache_wback_inv;
 		_dma_cache_wback	= r4k_dma_cache_wback_inv;
 		_dma_cache_inv		= r4k_dma_cache_inv;
 	}
-#endif
+#endif /* CONFIG_DMA_NONCOHERENT */
 
 	build_clear_page();
 	build_copy_page();
-- 
2.18.0

