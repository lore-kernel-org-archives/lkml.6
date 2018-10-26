Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB3BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EBE20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uQUHTe2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EBE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJZWBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:01:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7gR7fnQfIn9K/HJdlYo7ftrpyEmWXJi8Ne/9mhny4iI=; b=uQUHTe2UfTiP9W9cSs8FfnoTa
        WHhdXU4CYq8Dq2j+HUFZKb3OnSeHjteQD15jgS+GfIn8lZ+YyjPd2BLoIw+NqV9J21niEclZ5qDxH
        HWUAV8ObxBLIUpT9HUJTHq7vPz7YZll3s9UBNDW+ddZa71gyrni/zuTmfDM7vA/ArVwIrWVUS41VY
        yf9xi6Jj7LlkHXN25XIoQ33T31iK6tfOCi6KcJ5kl1mVDDYE04KISQeNxc6OwqSWgoKqOrODNCA/7
        CjFIj+Uol1yIufBwixToNJJwljW9GDWY1NtGDanbam1DmZou3Ttr33heoPLtOLmsTFVxW7E4Uv0Kv
        j3GCRG3dw==;
Received: from [188.21.3.0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gG25x-0001Hn-4H; Fri, 26 Oct 2018 13:24:09 +0000
Date:   Fri, 26 Oct 2018 15:24:03 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [GIT PULL] second round of dma mapping updates for 4.20
Message-ID: <20181026132403.GA23693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b9fd04262a8abc366f40a9e97598e94591352c26:

  dma-direct: respect DMA_ATTR_NO_WARN (2018-10-09 15:08:46 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.20-1

for you to fetch changes up to 886643b766321f15f63bd950be618cbb6dd22bbc:

  arm64: use the generic swiotlb_dma_ops (2018-10-19 08:53:24 +0200)

----------------------------------------------------------------
Second batch of dma-mapping updates for 4.20:

 - various swiotlb cleanups
 - do not dip into the ѕwiotlb pool for dma coherent allocations
 - add support for not cache coherent DMA to swiotlb
 - switch ARM64 to use the generic swiotlb_dma_ops

----------------------------------------------------------------
Christoph Hellwig (10):
      swiotlb: remove a pointless comment
      swiotlb: mark is_swiotlb_buffer static
      swiotlb: do not panic on mapping failures
      swiotlb: remove the overflow buffer
      swiotlb: merge swiotlb_unmap_page and unmap_single
      swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs
      swiotlb: refactor swiotlb_map_page
      swiotlb: don't dip into swiotlb pool for coherent allocations
      swiotlb: add support for non-coherent DMA
      arm64: use the generic swiotlb_dma_ops

 arch/arm64/Kconfig                   |   4 +
 arch/arm64/include/asm/device.h      |   1 -
 arch/arm64/include/asm/dma-mapping.h |   7 +-
 arch/arm64/mm/dma-mapping.c          | 257 ++++++---------------------
 arch/powerpc/kernel/dma-swiotlb.c    |   4 +-
 include/linux/dma-direct.h           |   2 +
 include/linux/swiotlb.h              |   9 -
 kernel/dma/direct.c                  |   2 -
 kernel/dma/swiotlb.c                 | 326 +++++++----------------------------
 9 files changed, 123 insertions(+), 489 deletions(-)
