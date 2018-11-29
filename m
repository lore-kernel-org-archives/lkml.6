Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C00AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E6A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E6A21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeK3FmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:42:12 -0500
Received: from verein.lst.de ([213.95.11.211]:45515 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeK3FmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:42:10 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B7BB268BDF; Thu, 29 Nov 2018 19:35:50 +0100 (CET)
Date:   Thu, 29 Nov 2018 19:35:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, "Clark, Rob" <robdclark@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <Robin.Murphy@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181129183550.GD30281@lst.de>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org> <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com> <CAKMK7uHOKtX2a12itSA0sDg=b77F+0vnLAdEvc_aNGRJTh85=Q@mail.gmail.com> <20181129155758.GC26537@lst.de> <20181129162807.GL21184@phenom.ffwll.local> <20181129165715.GA27786@lst.de> <20181129173301.rye77slpy27regi5@DESKTOP-E1NTVVP.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129173301.rye77slpy27regi5@DESKTOP-E1NTVVP.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 05:33:03PM +0000, Brian Starkey wrote:
> This sounds very useful for ion, to avoid CPU cache maintenance as
> long as the buffer stays in device-land.
> 
> One question though: How would you determine "the last user to unmap"
> to know when to do the final "make visible to CPU" step?

I'd assume the user of the DMA API keeps track of it.  E.g. dmabuf
would be a pretty natural layer to implement common logic for this.
