Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1335214C4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1335214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbeK3DDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:03:50 -0500
Received: from verein.lst.de ([213.95.11.211]:44335 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbeK3DDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:03:49 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C519168B02; Thu, 29 Nov 2018 16:57:58 +0100 (CET)
Date:   Thu, 29 Nov 2018 16:57:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     "Clark, Rob" <robdclark@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Dave Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@chromium.org>, vivek.gautam@codeaurora.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181129155758.GC26537@lst.de>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org> <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com> <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:43:50PM +0100, Daniel Vetter wrote:
> Yeah we had patches to add manual cache management code to drm, so we
> don't have to abuse the dma streaming api anymore. Got shouted down.
> Abusing the dma streaming api also gets shouted down. It's a gpu, any
> idea of these drivers actually being platform independent is out of
> the window from the start anyway, so we're ok with tying this to
> platforms.

Manual or not the iommu API is missing APIs for cache management,
which makes it kinda surprising it actually ever worked for non-coherent
devices.

And fortunately while some people spent the last year ot two bickering
about the situation others actually did work, and we now have a
generic arch_sync_dma_for_device/arch_sync_dma_for_cpu kernel-internal
API.  This is only used for DMA API internals so far, and explicitly
not intended for direct driver use, but it would be perfect as the
backend for iommu API cache maintainance functions.  It exists on all
but two architectures on mainline.  Out of those powerpc is in the works,
only arm32 will need some major help.
