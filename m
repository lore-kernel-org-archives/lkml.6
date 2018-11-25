Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23D6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 08:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6485720865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 08:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdFKzie1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6485720865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeKYT0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 14:26:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeKYT0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 14:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZCV3IVAezFjL7cWy/tt9D2Dpg8IbVXXtaAK2o3r1MTs=; b=gdFKzie1BAEOcT5xGmQu0f31Fk
        fRPV2icQAbqA3PzPkxaFpCS3j1KM9XJEGRIgKzDh2S/G/L/lGoPhvGC1nz66EfZq6cIUvY8v+xRTQ
        l1LmWkcBHfMOAANdibZvrZ9JUW77/gbwe2asmSgRPZ+k3nhdjGuXGlCTDssKR3/cUJeyAq872gebj
        OS1SqQOHox0M++kl7iBryuGqdRm7adFkUeajdGMuMdaC/XeaOAULjw0tr0wPgXykv1eIzoCFgUJHJ
        dw8ACkfExLxm5qRDAUt5NcNhMC9n7MkTRII/NwfLCys13gdb6GivwXvfEC/PQDvS2vI6gwTiB8TNT
        IhFrHWkw==;
Received: from 213-225-33-236.nat.highway.a1.net ([213.225.33.236] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gQptT-0002zV-AB; Sun, 25 Nov 2018 08:35:55 +0000
Date:   Sun, 25 Nov 2018 09:35:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping fixes for 4.20
Message-ID: <20181125083552.GA15060@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c8ce94b8fe5324aca4c10baeb53dea2d5775a170:

  Merge tag 'mips_fixes_4.20_3' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux (2018-11-20 14:31:00 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.20-3

for you to fetch changes up to cb216b84d6ea24fa10f1e7aac35de77246841041:

  swiotlb: Skip cache maintenance on map error (2018-11-21 18:47:58 +0100)

----------------------------------------------------------------
Two dma-direct / swiotlb regressions fixes

 - 0 is a valid physical address on some arm boards, we can't use
   0 as the error value
 - don't try to cache flush the error return value (no matter what it is)

----------------------------------------------------------------
Robin Murphy (2):
      dma-direct: Make DIRECT_MAPPING_ERROR viable for SWIOTLB
      swiotlb: Skip cache maintenance on map error

 include/linux/dma-direct.h | 2 +-
 kernel/dma/swiotlb.c       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)
