Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DAAC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE81D2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE81D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeK3Uo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:44:26 -0500
Received: from verein.lst.de ([213.95.11.211]:49168 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeK3UoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:44:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0B40F68BDF; Fri, 30 Nov 2018 10:35:42 +0100 (CET)
Date:   Fri, 30 Nov 2018 10:35:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Clark <robdclark@gmail.com>
Cc:     hch@lst.de, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181130093541.GA21436@lst.de>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org> <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com> <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com> <20181129155758.GC26537@lst.de> <CAF6AEGsS6LnuoL9+_LsKLOWxKF6P0nTrxs7b0j0Kqnqz6tmocw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGsS6LnuoL9+_LsKLOWxKF6P0nTrxs7b0j0Kqnqz6tmocw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 08:15:23PM -0500, Rob Clark wrote:
> As far as hiding cache ops behind iommu layer, I guess I'd been
> thinking more of just letting the drivers that want to bypass dma
> layer take things into their own hands.. tbh I think/assume/hope
> drm/msm is more the exception than the rule as far as needing to
> bypass the dma layer.  Or at least I guess the # of drivers having
> problems w/ the dma layer is less than the # of iommu drivers.

So the whole bypass thing has already been a contentious discussion
in the past.  One thing that the API aready enforces is that we pass
a DMA direction, which I want to keep.  The other is that we need
a struct device (or something similiar) that is used to check if the
device is cache coherent or not.  In your MSM case you might know that,
but in general it really is a platform issue that I don't want every
driver to know about.

> (Not sure if that changes my thoughts on this patch, it isn't like
> what this patch replaces isn't also a problematic hack around the
> inability to bypass the dma layer.  In the short term I just want
> *something* that works, I'm totally happy to refactor later when there
> are better options.)

The current patch is simply broken.  You can't just construct your
own S/G list and pass it to the DMA API, and we enforce that very
strictly with dma debug enabled.

So your only options are: a) actually use the DMA API for creating
the mapping, by e.g. using dma_direct_ops ontop of an actual IOMMU
managed in the background, or b) figure out a way to do cache
maintainance for raw IOMMU API drivers.
