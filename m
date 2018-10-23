Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A57C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E30420671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BTyjdP2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E30420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeJWWjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:39:06 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37084 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWWjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 18:39:06 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:c7d:2fcf:3a00:2a36:be27:bdf2:394a])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5302D113E;
        Tue, 23 Oct 2018 16:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1540304125;
        bh=dRHFkmtbZvQfLvopc0gs2hYWY7+aJ1CJ/9VWstvNZIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTyjdP2b8M2BKSXIfDHu8amscYqdVceFH308aDTQsa4LMvog+Xg3x5z7JZzPme8ok
         1xGdcjHTQJAmqnv9LkwECxc6KCJX7EV9Ookn/iqlMQYG+k4TmVBCaJxJOMILFsjoRr
         8TrS6MyNgmXDzR08K5qL/B9m1oS9KmBeQL0gB0sQ=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, noralf@tronnes.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
Date:   Tue, 23 Oct 2018 17:15:27 +0300
Message-ID: <2275810.TWHE3rLQ5u@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181023134041.GO324@phenom.ffwll.local>
References: <20180918163903.GA11172@jordon-HP-15-Notebook-PC> <CAFqt6zaaEWb-vQ6BVhYg1GgsxwKX=4H661OHU3Qfbk0FD3Cz9g@mail.gmail.com> <20181023134041.GO324@phenom.ffwll.local>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tuesday, 23 October 2018 16:40:41 EEST Daniel Vetter wrote:
> On Mon, Oct 22, 2018 at 01:51:35PM +0530, Souptick Joarder wrote:
> > On Thu, Oct 11, 2018 at 1:48 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >> On Mon, Oct 08, 2018 at 09:57:52PM +0530, Souptick Joarder wrote:
> >>> On Mon, Oct 1, 2018 at 6:12 PM Noralf Tr=F8nnes wrote:
> >>>> Den 01.10.2018 13.56, skrev Laurent Pinchart:
> >>>>> On Monday, 1 October 2018 09:52:20 EEST Daniel Vetter wrote:
> >>>>>> On Fri, Sep 28, 2018 at 06:30:35PM +0300, Laurent Pinchart wrote:
> >>>>>>> On Friday, 28 September 2018 18:05:18 EEST Laurent Pinchart wrote:
> >>>>>>>> On Thursday, 27 September 2018 09:34:18 EEST Souptick Joarder=20
wrote:
> >>>>>>>>> On Tue, Sep 18, 2018 at 10:05 PM Souptick Joarder wrote:
> >>>>>>>>>> convert drm_atomic_helper_suspend/resume() to use
> >>>>>>>>>> drm_mode_config_helper_suspend/resume().
> >>>>>>>>>>=20
> >>>>>>>>>> remove suspend_state field from the rcar_du_device
> >>>>>>>>>> structure as it is no more required.
> >>>>>>>>>>=20
> >>>>>>>>>> With this conversion, also
> >>>>>>>>>> drm_fbdev_cma_set_suspend_unlocked()
> >>>>>>>>>> will left with no consumer. So this function can be removed.
> >>>>>>>>>>=20
> >>>>>>>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>>>>>>>>=20
> >>>>>>>>> Laurent, any comment on this patch ??
> >>>>>>>>=20
> >>>>>>>> Sorry for the delay, and thanks for pinging me.
> >>>>>>>>=20
> >>>>>>>> Reviewed-by: Laurent Pinchart
> >>>>>>>> <laurent.pinchart@ideasonboard.com>
> >>>>>>>>=20
> >>>>>>>> Should I apply this to my tree or do you plan to merge it
> >>>>>>>> through drm-misc as it touches drm_fb_cma_helper.c ?
> >>>>>>>=20
> >>>>>>> I just realized that the same patch got supplied by Noralf
> >>>>>>> Tr=F8nnes nearly a year ago, and was later superseded by
> >>>>>>> https://patchwork.freedesktop.org/patch/247861/. I think we
> >>>>>>> should thus apply Noralf's patches instead (once he sends v4
> >>>>>>> out).
> >>>>>>=20
> >>>>>> I don't think Noralf is still actively working on this, he's busy
> >>>>>> with the fbdev emulation stuff. Probably better if you pick up
> >>>>>> one of the existing ones, than waiting another year or so :-)
> >>>>>=20
> >>>>> Isn't https://patchwork.freedesktop.org/patch/247861/ part of the
> >>>>> fbdev emulation stuff ? That patch series is from less than a
> >>>>> month ago, so I thought it was actively developed.
> >>>>>=20
> >>>>> Let's ask him. Noralf, any comment ? :-)
> >>>>=20
> >>>> I see now that I've caused some confusion here.
> >>>>=20
> >>>> I did some refactoring of the fbdev stuff in the CMA helper last
> >>>> year. In the last series of that work there is this patch:
> >>>>=20
> >>>> [v3,07/11] drm/rcar-du: Use drm_mode_config_helper_suspend/resume()
> >>>> https://patchwork.freedesktop.org/patch/192414/
> >>>>=20
> >>>> During Christmas I got the idea that maybe it was possible to use a
> >>>> dumb buffer to do generic fbdev emulation. That work took me 6
> >>>> months before a solution using a general internal DRM client was
> >>>> hammered out. By the time I started to convert drivers I had
> >>>> forgotten about that patch.
> >>>>=20
> >>>> When I wrote the patch (#247861) to convert rcar to the generic
> >>>> fbdev, I just bundled up the suspend/resume change with the fbdev
> >>>> conversion. Laurent and Sam commented on that bundling, so I said
> >>>> that I would split it up in the next version.
> >>>>=20
> >>>> All that being said, I think that this patch should be applied and
> >>>> I'll just rebase the rcar fbdev conversion patch on top of that.
> >>>> It's the easiest for me at least :-)
> >>>=20
> >>> Any conclusion on this patch ? :-)
> >>=20
> >> Laurent should pick it up and apply to his rcar-du tree I think. We can
> >> also stuff it into drm-misc as a fallback.
> >=20
> > Can we get this patch in queue for 4.20 ?
>=20
> 5.1, 4.20 is already done.
>=20
> But yes, I pulled this into drm-misc-next. Thanks for your patch.

I would have preferred applying this through my tree. I'm currently at ELCE=
=20
and had to prepare for the conference, hence the delay.

> >>>>>>>>>>   drivers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
> >>>>>>>>>>   drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++---------------=
=2D-
> >>>>>>>>>>   drivers/gpu/drm/rcar-du/rcar_du_drv.h |  1 -
> >>>>>>>>>>   include/drm/drm_fb_cma_helper.h       |  2 --
> >>>>>>>>>>   4 files changed, 2 insertions(+), 40 deletions(-)

=2D-=20
Regards,

Laurent Pinchart



