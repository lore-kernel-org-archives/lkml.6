Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1172BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D437A217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfBFG5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 01:57:52 -0500
Received: from verein.lst.de ([213.95.11.211]:58147 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfBFG5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 01:57:51 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 218227F1C3; Wed,  6 Feb 2019 07:57:50 +0100 (CET)
Date:   Wed, 6 Feb 2019 07:57:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Message-ID: <20190206065749.GA23392@lst.de>
References: <20190205110602.27717-1-thierry.reding@gmail.com> <20190205161036.GA782@lst.de> <20190205162057.GA29974@ulmo> <20190205163837.GA1222@lst.de> <20190205175611.GA7052@ulmo> <20190205180218.GB2882@lst.de> <20190205222912.GC1372@mithrandir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205222912.GC1372@mithrandir>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:29:12PM +0100, Thierry Reding wrote:
> > > 	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/host1x/cdma.c#n106
> > 
> > Yes, I think we I can come up with a nicer helper for that.
> 
> One thing I could also try is to remove direct IOMMU API usage at least
> from the host1x driver. I think this might work nowadays.
> 
> For Tegra DRM we still need direct IOMMU API usage because we need to be
> able to map into an IOMMU domain without knowing the struct device *
> that we're mapping for (it could be needed by any of up to four display
> controllers). For host1x we always only have one struct device *, so the
> DMA mapping API should be good enough.

If you can convert it to plain DMA API usage, please do.

I did look into an IOMMU API memory allocator, and while we can do it
easily for coherent devices, we need some arch hooks for non-coherent
device support.  With a pending series from me we have those for arm64,
but 32-bit arm support will require a lot more work first.
