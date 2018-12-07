Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C851C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0FE208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0FE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLGBim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:38:42 -0500
Received: from verein.lst.de ([213.95.11.211]:60775 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGBim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:38:42 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 303C168AA6; Fri,  7 Dec 2018 02:38:41 +0100 (CET)
Date:   Fri, 7 Dec 2018 02:38:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>, "Clark, Rob" <robdclark@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@chromium.org>, vivek.gautam@codeaurora.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181207013841.GA4530@lst.de>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org> <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com> <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com> <20181129155758.GC26537@lst.de> <20181129162807.GL21184@phenom.ffwll.local> <20181129165715.GA27786@lst.de> <CAKMK7uECLeTbEjG6=unWZSKakpiYkmBVbCEKKY2xv=vVjF-pBQ@mail.gmail.com> <20181129183334.GB30281@lst.de> <20181130094604.GV21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130094604.GV21184@phenom.ffwll.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 10:46:04AM +0100, Daniel Vetter wrote:
> > Being able to dip into CMA and maybe iommu coalescing if we want to
> > get fancy is indeed the only reason for this API.  If we just wanted
> > to map pages we could already do that now with just a little bit
> > of boilerplate code (and quite a few drivers do - just adding this
> > new API will remove tons of code).
> 
> Sounds like the future is very bright indeed \o/

So, I spent some time with this and instead of a new API I think
it makes sure we have DMA_ATTR_NON_CONSISTENT consistently available
and with well defined semantics, that is virt_to_page on the return
value works, it is contiguos and we can use dma_sync_single_for_cpu
and dma_sync_single_for_device for ownership tranfers.

Can you graphics folks check if this:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-noncoherent-allocator

is something to work with?  Especially to get rid of the horrible
dma_get_sgtable hacks?
