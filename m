Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333A3ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D698920882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JdreEapj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D698920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeINPML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:12:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeINPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zFJjatMqLsBLj+2I3RwKulh7mahvK4LzPodJJ5ggDjA=; b=JdreEapjn+o10u1aQ6hIw9nJl
        a1+ij2xxTtfym4b23cSVhjKb9OYX8u8m40kb4HDm+4JRXepNDo+I6HOj9H4H8o+OKRUq+AtoEy1IZ
        n3WqtJwWHe/f4Gxd6vpU+9YNsnlEID7/QFHKAtO8q1YbMo+zVgWkJcBErqVYz8aWeyd7SuL66Ui+w
        HNIkycvyk6vbwpevjtLrAPGn8UeogRkhiLM7CDYFKt8Nut0zmRUkzL+NGCZyQtdCC0S3jro/kuY88
        CGVHqQtmQ5mq+DvNQS4AXzWt9TVMDekCirDEh20fqdCH2P/0G7yp+l9B7Uw45GrKoHuBSaXHxit/J
        Nkqhp3lPg==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0krf-0000Qg-KS; Fri, 14 Sep 2018 09:58:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Date:   Fri, 14 Sep 2018 11:58:03 +0200
Message-Id: <20180914095808.22202-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914095808.22202-1-hch@lst.de>
References: <20180914095808.22202-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adding the infrastructure failed to actually add the symbol
declaration, oops..

Fixes: faef87723a ("dma-noncoherent: add a arch_sync_dma_for_cpu_all hook")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 9bd54304446f..1b1d63b3634b 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -23,6 +23,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
 	bool
 	select NEED_DMA_MAP_STATE
 
+config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
+	bool
+
 config DMA_DIRECT_OPS
 	bool
 	depends on HAS_DMA
-- 
2.18.0

