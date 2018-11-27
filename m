Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947BDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4C02133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E7qfJwCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4C02133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbeK0SxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:53:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45925 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbeK0SxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:53:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so18132199edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 23:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DO/QdORUV6GcvyHJ+4q6a8+und2kGMWyqSETaGIku6Y=;
        b=E7qfJwCFbpzQH6baP1IZgIZ8gMWd/hRW74HEDpO01TdqZVEjk+C/HjY68eapttRPOp
         xNm/Gvnzgzcv+c9v242IRdb42QuNFD6bI8BD/3sdYelV7NfM2oDxlxb4LhvG6Yqv7F/u
         4L1Ah+gy5e5424shNfu8D/xBUnCnwEXkhkO88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DO/QdORUV6GcvyHJ+4q6a8+und2kGMWyqSETaGIku6Y=;
        b=OolS//I8aiymj/Tk8jEDAp6y0oQeJTeHduqP67MJiQsWlGsXE0Zpr580MdiK9wSTMg
         5rM/JduUuBai1VjtavUvdB32nY82wqonFn9EDHnEcgqcsuOIw56UH1voV6cQ+xHbYXel
         XE6cS+dh+ByILng1AgTmNosdkloupPdXtbyfy+5gUXGLzjmdU1YS3eQVMtxKHzFgVLn9
         crfhUvcuvZ2prdGTf4oqnTFOjTtCUzy/+R3Quqrhn80ZSWbvFa9B9tgTPHEBY7+ntfEn
         HVBHC7P5Ht4Eop953IaJUvnTjbaHhWya/nnJV7VuaLC/b0BIRRe0z4ERWo/e7BDhJ8Kt
         jwYA==
X-Gm-Message-State: AA+aEWYQ+ykleTsD8/3k1y6lzAlVQROt80VEhIaFGsUVfui/wm9oPnrY
        CyhL3QCnJiZQsFbNwgyCkTcxfw==
X-Google-Smtp-Source: AFSGD/VBrgT/WfzeY6lRKhswhsMxNulpcM0CHnEf4jEic+DTWoJG/X2m6Mazqlid8ZGMws/JtRZFGg==
X-Received: by 2002:aa7:c0d0:: with SMTP id j16mr25254356edp.173.1543305365183;
        Mon, 26 Nov 2018 23:56:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s12sm797511edb.43.2018.11.26.23.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 23:56:04 -0800 (PST)
Date:   Tue, 27 Nov 2018 08:56:02 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Eric Anholt <eric@anholt.net>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        helen.koike@collabora.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg 
        Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
        Tomasz Figa <tfiga@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Zoran <mzoran@crowfest.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        kernel@collabora.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg 
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] drm/rockchip: update cursors asynchronously through
 atomic.
Message-ID: <20181127075602.GV4266@phenom.ffwll.local>
Mail-Followup-To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Eric Anholt <eric@anholt.net>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        helen.koike@collabora.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg  Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
        Tomasz Figa <tfiga@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Zoran <mzoran@crowfest.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        kernel@collabora.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg  Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
References: <20181119190805.19139-1-helen.koike@collabora.com>
 <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
 <d3fb3b21-6c3d-6b01-727b-dbd66540ce92@collabora.com>
 <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com>
 <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
 <87o9abbmq4.fsf@anholt.net>
 <20181126224102.1efbf2d1@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126224102.1efbf2d1@bbrezillon>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:41:02PM +0100, Boris Brezillon wrote:
> On Mon, 26 Nov 2018 12:36:03 -0800
> Eric Anholt <eric@anholt.net> wrote:
> 
> > Michael Zoran <mzoran@crowfest.net> writes:
> > 
> > > On Fri, 2018-11-23 at 11:27 +0900, Tomasz Figa wrote:  
> > >> 
> > >> The point here is not about setting and resetting the plane->fb
> > >> pointer. It's about what happens inside
> > >> drm_atomic_set_fb_for_plane().
> > >> 
> > >> It calls drm_framebuffer_get() for the new fb and
> > >> drm_framebuffer_put() for the old fb. In result, if the fb changes,
> > >> the old fb, which had its reference count incremented in the atomic
> > >> commit that set it to the plane before, has its reference count
> > >> decremented. Moreover, if the new reference count becomes 0,
> > >> drm_framebuffer_put() will immediately free the buffer.
> > >> 
> > >> Freeing a buffer when the hardware is still scanning out of it isn't
> > >> a
> > >> good idea, is it?  
> > >
> > > No, it's not.  But the board I submitted the patch for doesn't have
> > > anything like hot swapable ram.  The ram access is still going to work,
> > > just it might display something it shouldn't. Say for example if that
> > > frame buffer got reused by somethig else and filled with new data in
> > > the very small window.
> > >
> > > But yes, I agree the best solution would be to not release the buffer
> > > until the next vblank.
> > >
> > > Perhaps a good solution would be for the DRM api to have the concept of
> > > a deferred release?  Meaning if the put() call just added the frame
> > > buffer to a list that DRM core could walk during the vblank.  That
> > > might be better then every single driver trying to work up a custom
> > > solution.
> > >  
> > >> The vc4 driver seems to be able to program the hardware to switch the
> > >> scanout to the new buffer immediately:
> > >> 
> > >> https://elixir.bootlin.com/linux/v4.20-rc3/source/drivers/gpu/drm/vc4/vc4_plane.c#L794
> > >> 
> > >> Although I wonder if there isn't still a tiny race there - the
> > >> hardware may have just started refilling the FIFO from the old
> > >> address. Still, if the FIFO is small, the FIFO refill operation may
> > >> be
> > >> much shorter than it takes for the kernel code to actually free the
> > >> buffer. Eric and Michael, could you confirm?
> > >>   
> > >
> > > I don't have those boards anymore, and I don't have access to any
> > > technical documentation on the GPU so I can't really add much here.  
> > > Eric can probably provide the best information.  
> > 
> > I don't think I understood my scanout hardware well enough when I
> > started on the async update stuff for rpi.  vc4 probably needs to wait
> > until the HW starts scanning out a new line before letting the old BO
> > get freed.
> 
> That's also my understanding. Note that even if the BO is freed before
> the HVS has finished generating a line it shouldn't crash, because
> accesses are done through DMA. Might be a security issue though if we
> start re-using the memory for something else while it's still being
> accessed.
> 
> The solution would be to wait for the EOL (End Of Line) interrupt in
> the async update path, but I'm not sure this is allowed.

For subsuming async page_flip into the async atomic commit stuff we need
completion events anyway. Firing those from the EOL (or some other
hw-dependent interrupt, could also be the next vblank) should be hard to
arrange for drivers. And the heleprs could then easily offload the
cleanup_planes work to a worker and delay it until after the event has
fired. Like it already does for normal atomic commits.

But yeah right now that's all missing. The biggest issue here is figuring
out what these events should look like, and how generic userspace needs to
use them.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
