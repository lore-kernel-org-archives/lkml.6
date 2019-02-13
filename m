Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B341CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8447E2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uCxTgPpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393668AbfBMS33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:29:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389830AbfBMS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YTimLkmVGcosS08x++tA4YThRjiAJsplcLRxVuPtfT0=; b=uCxTgPpIu/7cIPh7f3bAHO6Lf
        9t+vN5p4KFFPDdQvRBRAhnshS7XdimWMGn6WbdsTY8cVZVJONWidWrRc5q3l8hOeN9TlFO1Ec3u0W
        RiyDCoyGWxCmFvoUyY7xqK4/2fzKntu+BZc/zjSxrKBD3g+gWtvSbg5tbsTlk/kVNiVv5v7lyGm97
        w6HPp4XbXcga2trkQ4dgQhskEsI9uE6FKTXfP/KTxVEPqDEKfW5wNoIyhDVzBHLUcUIUlwUCaTz1Y
        zstUhvBwhnGf18onUC7vsOzugtYWakLSGszu4P/R8UdPWOXLLyGLFouloBeQQtZXO46K9NcnxX4fe
        Jfo4iOarg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtzHc-0007a5-N4; Wed, 13 Feb 2019 18:29:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: implement generic dma_map_ops for IOMMUs v2
Date:   Wed, 13 Feb 2019 19:28:59 +0100
Message-Id: <20190213182920.16764-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

please take a look at this series, which implements a completely generic
set of dma_map_ops for IOMMU drivers.  This is done by taking the
existing arm64 code, moving it to drivers/iommu and then massaging it
so that it can also work for architectures with DMA remapping.  This
should help future ports to support IOMMUs more easily, and also allow
to remove various custom IOMMU dma_map_ops implementations, like Tom
was planning to for the AMD one.

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git dma-iommu-ops.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.2

Changes since v1:
 - only include other headers in dma-iommu.h if CONFIG_DMA_IOMMU is enabled
 - keep using a scatterlist in iommu_dma_alloc
 - split out mmap/sgtable fixes and move them early in the series
 - updated a few commit logs
