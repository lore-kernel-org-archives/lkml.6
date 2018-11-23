Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7803AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E5C20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 05:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E5C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=crowfest.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408197AbeKWPr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 10:47:29 -0500
Received: from gw2.crowfest.net ([52.54.242.193]:47952 "EHLO gw2.crowfest.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbeKWPr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 10:47:28 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Nov 2018 10:47:28 EST
Received: from debian-server.privh2.crowfest.net (debian-server.privh2.crowfest.net [10.2.1.4])
        by gw2.crowfest.net (Postfix) with ESMTP id DB4453F342;
        Thu, 22 Nov 2018 20:58:10 -0800 (PST)
Received: from nuc-8i7.privh2.crowfest.net (nuc-8i7.privh2.crowfest.net [10.2.1.32])
        by debian-server.privh2.crowfest.net (Postfix) with ESMTP id 9A2EE2600B1;
        Thu, 22 Nov 2018 22:58:10 -0600 (CST)
Message-ID: <1d10a4323a49ca09bbb7dc865aaaf5b8c5e3b3d5.camel@crowfest.net>
Subject: Re: [PATCH v3] drm/rockchip: update cursors asynchronously through
 atomic.
From:   Michael Zoran <mzoran@crowfest.net>
To:     Tomasz Figa <tfiga@chromium.org>, helen.koike@collabora.com,
        Eric Anholt <eric@anholt.net>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg "
         "Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg "
         "Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg "
         "Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>
Date:   Thu, 22 Nov 2018 22:58:10 -0600
In-Reply-To: <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com>
References: <20181119190805.19139-1-helen.koike@collabora.com>
         <CAAFQd5DDZwhdMDbrHthQwm2bQ3+NoZNcemAktVTxkR3=LfnnTg@mail.gmail.com>
         <d3fb3b21-6c3d-6b01-727b-dbd66540ce92@collabora.com>
         <CAAFQd5Afa9ndmU0=q5Kjv-BY+0qpvOdq2+eOTO6OebX4-2NENA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-23 at 11:27 +0900, Tomasz Figa wrote:
> 
> The point here is not about setting and resetting the plane->fb
> pointer. It's about what happens inside
> drm_atomic_set_fb_for_plane().
> 
> It calls drm_framebuffer_get() for the new fb and
> drm_framebuffer_put() for the old fb. In result, if the fb changes,
> the old fb, which had its reference count incremented in the atomic
> commit that set it to the plane before, has its reference count
> decremented. Moreover, if the new reference count becomes 0,
> drm_framebuffer_put() will immediately free the buffer.
> 
> Freeing a buffer when the hardware is still scanning out of it isn't
> a
> good idea, is it?

No, it's not.  But the board I submitted the patch for doesn't have
anything like hot swapable ram.  The ram access is still going to work,
just it might display something it shouldn't. Say for example if that
frame buffer got reused by somethig else and filled with new data in
the very small window.

But yes, I agree the best solution would be to not release the buffer
until the next vblank.

Perhaps a good solution would be for the DRM api to have the concept of
a deferred release?  Meaning if the put() call just added the frame
buffer to a list that DRM core could walk during the vblank.  That
might be better then every single driver trying to work up a custom
solution.

> The vc4 driver seems to be able to program the hardware to switch the
> scanout to the new buffer immediately:
> 
> https://elixir.bootlin.com/linux/v4.20-rc3/source/drivers/gpu/drm/vc4/vc4_plane.c#L794
> 
> Although I wonder if there isn't still a tiny race there - the
> hardware may have just started refilling the FIFO from the old
> address. Still, if the FIFO is small, the FIFO refill operation may
> be
> much shorter than it takes for the kernel code to actually free the
> buffer. Eric and Michael, could you confirm?
> 

I don't have those boards anymore, and I don't have access to any
technical documentation on the GPU so I can't really add much here.  
Eric can probably provide the best information.

I submitted the patch because I was working on arm64 support for fun
and was becomming very annoyed by desktop lockups for long periods of
time on the desktop enviroment of my choice due to the driver being
flooded with curser animation updates.  I sent the patch to Eric who
was kind enough to review it and suggest some improvements.  


