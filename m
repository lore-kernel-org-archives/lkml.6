Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C113DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BBB2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BOZVE+ER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbfAHNHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:07:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfAHNHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oDIyJ5FefG6R1fN38eBo9LpvUQ1jztrlRndw4KaE+es=; b=BOZVE+ERASGKKtiuuCUBcJ59y
        j6XobSKAcBI30kR93gM1UoMSnDnFicQkXPX/1EfLE9TxpUaQvp+BuoqhuAF5PHYTJAVPx1beUIqy5
        sq8N7iG3BERI44DweOX2nyi+xl3XURPObIKkPFTtQazE+WMQZPwALAmuluILX9QMp3AOahRBRQAII
        m2vGXmM1grsFSh1IYR7dphagzb0FjVIaotgMdyqdVs930d/JMJRM2ijepfSovv0CdcgTXLHYVCYMZ
        qAsgR1fI2B053+SbyUwDlIVOXPWN6rPhl/vg9YlKtE/828dRgOIYtDut1SmopDfYj19xNMA0DCUoJ
        q4Z+3zWMQ==;
Received: from rrcs-24-103-175-221.nys.biz.rr.com ([24.103.175.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggr5z-0005bG-HT; Tue, 08 Jan 2019 13:07:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: remove dma_zalloc_coherent
Date:   Tue,  8 Jan 2019 08:06:58 -0500
Message-Id: <20190108130701.14161-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and world,

We've always had a weird situation around dma_zalloc_coherent.  To
safely support mapping the allocations to userspace major architectures
like x86 and arm have always zeroed allocations from dma_alloc_coherent,
but a couple other architectures were missing that zeroing either always
or in corner cases.  Then later we grew anothe dma_zalloc_coherent
interface to explicitly request zeroing, but that just added __GFP_ZERO
to the allocation flags, which for some allocators that didn't end
up using the page allocator ended up being a no-op and still not
zeroing the allocations.

So for this merge window I fixed up all remaining architectures to zero
the memory in dma_alloc_coherent, and made dma_zalloc_coherent a no-op
wrapper around dma_alloc_coherent, which fixes all of the above issues.

dma_zalloc_coherent is now pointless and can go away, and Luis helped
me writing a cocchinelle script and patch series to kill it, which I
think we should apply now just after -rc1 to finally settle these
issue.

The script that generated the first patch is included here:

@ replace_dma_zalloc_coherent @
expression dev, size, data, handle, flags;
@@

-dma_zalloc_coherent(dev, size, handle, flags)
+dma_alloc_coherent(dev, size, handle, flags)
