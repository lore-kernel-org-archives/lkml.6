Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9495FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBEC208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBEC208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeK0Igo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:36:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43500 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeK0Igo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:36:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8EC15207BB; Mon, 26 Nov 2018 22:41:13 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2B17E206D8;
        Mon, 26 Nov 2018 22:41:03 +0100 (CET)
Date:   Mon, 26 Nov 2018 22:41:02 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     Michael Zoran <mzoran@crowfest.net>,
        Tomasz Figa <tfiga@chromium.org>, helen.koike@collabora.com,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        "list\@263.net\:IOMMU DRIVERS \<iommu\@lists.linux-foundation.org\>\,
        Joerg Roedel \<joro\@8bytes.org\>\," 
        <iommu@lists.linux-foundation.org>,
        "list\@263.net\:IOMMU DRIVERS \<iommu\@lists.linux-foundation.org\>\,
        Joerg Roedel \<joro\@8bytes.org\>\," <joro@8bytes.org>,
        "list\@263.net\:IOMMU DRIVERS \<iommu\@lists.linux-foundation.org\>\,
        Joerg Roedel \<joro\@8bytes.org\>\," 
        <linux-arm-kernel@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list\:ARM\/Rockchip SoC..." 
        <linux-rockchip@lists.infradead.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@google.com>
Subject: Re: [PATCH v3] drm/rockchip: update cursors asynchronously through
 atomic.
Message-ID: <20181126224102.1efbf2d1@bbrezillon>
In-Reply-To: <87o9abbmq4.fsf@anholt.net>
References: <20181119190805.19139-1-helen.koike@collabora.com>
        <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
        <d3fb3b21-6c3d-6b01-727b-dbd66540ce92@collabora.com>
        <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com>
        <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
        <87o9abbmq4.fsf@anholt.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 12:36:03 -0800
Eric Anholt <eric@anholt.net> wrote:

> Michael Zoran <mzoran@crowfest.net> writes:
> 
> > On Fri, 2018-11-23 at 11:27 +0900, Tomasz Figa wrote:  
> >> 
> >> The point here is not about setting and resetting the plane->fb
> >> pointer. It's about what happens inside
> >> drm_atomic_set_fb_for_plane().
> >> 
> >> It calls drm_framebuffer_get() for the new fb and
> >> drm_framebuffer_put() for the old fb. In result, if the fb changes,
> >> the old fb, which had its reference count incremented in the atomic
> >> commit that set it to the plane before, has its reference count
> >> decremented. Moreover, if the new reference count becomes 0,
> >> drm_framebuffer_put() will immediately free the buffer.
> >> 
> >> Freeing a buffer when the hardware is still scanning out of it isn't
> >> a
> >> good idea, is it?  
> >
> > No, it's not.  But the board I submitted the patch for doesn't have
> > anything like hot swapable ram.  The ram access is still going to work,
> > just it might display something it shouldn't. Say for example if that
> > frame buffer got reused by somethig else and filled with new data in
> > the very small window.
> >
> > But yes, I agree the best solution would be to not release the buffer
> > until the next vblank.
> >
> > Perhaps a good solution would be for the DRM api to have the concept of
> > a deferred release?  Meaning if the put() call just added the frame
> > buffer to a list that DRM core could walk during the vblank.  That
> > might be better then every single driver trying to work up a custom
> > solution.
> >  
> >> The vc4 driver seems to be able to program the hardware to switch the
> >> scanout to the new buffer immediately:
> >> 
> >> https://elixir.bootlin.com/linux/v4.20-rc3/source/drivers/gpu/drm/vc4/vc4_plane.c#L794
> >> 
> >> Although I wonder if there isn't still a tiny race there - the
> >> hardware may have just started refilling the FIFO from the old
> >> address. Still, if the FIFO is small, the FIFO refill operation may
> >> be
> >> much shorter than it takes for the kernel code to actually free the
> >> buffer. Eric and Michael, could you confirm?
> >>   
> >
> > I don't have those boards anymore, and I don't have access to any
> > technical documentation on the GPU so I can't really add much here.  
> > Eric can probably provide the best information.  
> 
> I don't think I understood my scanout hardware well enough when I
> started on the async update stuff for rpi.  vc4 probably needs to wait
> until the HW starts scanning out a new line before letting the old BO
> get freed.

That's also my understanding. Note that even if the BO is freed before
the HVS has finished generating a line it shouldn't crash, because
accesses are done through DMA. Might be a security issue though if we
start re-using the memory for something else while it's still being
accessed.

The solution would be to wait for the EOL (End Of Line) interrupt in
the async update path, but I'm not sure this is allowed.
