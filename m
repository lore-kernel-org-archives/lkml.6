Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A98C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FD920663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M2E/EujQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfANJmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfANJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OYvO0kVUk+1T4Kb8r2dQlrZxIgRb9hf+/a3agIaqbn0=; b=M2E/EujQLWrcShcwwa1GtVJvN
        Ne4DGTarshD/9KgBGWx9nooQiS+lp/wDXxaFKf2up3svuFZQmBLLCNham92bgS3oNQxLr/gp7qf24
        3DvgfuXfOFTG2our99hxXniUwTdD4JVj7K20qzqvwPr2ZGMX/coGMhofd6NrUjOvWVuDbXSPSfEtA
        h7LLT/9gCChrZMjypY6xWTMjb7O7KY9LNhSclBqHbAI8Oz4rlTQyYIEYkjNsgDUVtjWZEINmfMBTk
        87FX6KczC/4eUjZRys33rDCFzEsk8Ld4OxHXBdZBdOs03WSfAQythS1FS2tzcRkTCyqBBYz+09izb
        Xon1+IcBw==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giykt-00067K-Jq; Mon, 14 Jan 2019 09:42:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: implement generic dma_map_ops for IOMMUs
Date:   Mon, 14 Jan 2019 10:41:40 +0100
Message-Id: <20190114094159.27326-1-hch@lst.de>
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

    git://git.infradead.org/users/hch/misc.git dma-iommu-ops

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops
