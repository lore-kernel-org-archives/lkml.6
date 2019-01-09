Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D732FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881E5206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WmjYXUvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfAIUeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:34:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42702 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfAIUeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:34:06 -0500
Received: by mail-ed1-f68.google.com with SMTP id y20so8376727edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 12:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YgKRR1D1tYkpogqQUK3FI3RnSQF7qjkbjbOQxHli6UU=;
        b=WmjYXUvITu8blJdPzdEEFpus/W5LZwJ1n3JyE+nagcn0AcOdGP0kvDvglcQVwhn5oz
         eIO5aZoolUwzd98uzNURqOnmpU8qlFdqdo5bgsCjvP7mtvziz3QEwfOzbSDJFkdM/zbt
         mBqYerV7n3ZLJSQdag2V+YlQ/Y0PcBQBZ9Ml8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YgKRR1D1tYkpogqQUK3FI3RnSQF7qjkbjbOQxHli6UU=;
        b=M1KEK7c7lhgMkI1FHj4e+IdiT+qCD4pZWll1e8qCkzM4hp/0Jv/gloTbBG4oko72da
         y1tMJS/zgGqOPsRQLqImKbhn0cyAV8IjQZjZkUO42lHwlbWKWHKQx4K4qSxC0FAURWk2
         I/2FCPnwqCX+rVkhim2kHBBihAZRJJnbSjNZU6DwefiA1BFjRMAXBJSMGhHHPNcyg5MX
         DDdhAwhXxCVstvSjCNl1L7lcDcW293nKDyGm/otu7QnZyUI938ROqRQ1CxGNaunYwU59
         c2fV5HB2ZTso6JawWbFUubvmBz+kpkoixBo6q7dUV71KyB6khOLYfV/SMfZOFEmc9vhp
         bgoQ==
X-Gm-Message-State: AJcUukfEaF0VasK/0bHsjK6O/8jMKMM9OMmGKaoDeV5gUImWLT9TtAjb
        fKSHVeo5WPHCYQiqI5pL/XytD20oIMk=
X-Google-Smtp-Source: ALg8bN6iSU8ZlbiSO/cpMTXNPSIaRZxmKjRSyV4HFLQ8c1/WPvrWuTBTi68byE+y4PnJ1hy114t76g==
X-Received: by 2002:a50:d002:: with SMTP id j2mr7205356edf.123.1547066043595;
        Wed, 09 Jan 2019 12:34:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w31sm1371835edw.82.2019.01.09.12.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 12:34:02 -0800 (PST)
Date:   Wed, 9 Jan 2019 21:34:00 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 1/4] drm/vc4: Wait for display list synchronization
 when completing commit
Message-ID: <20190109203400.GU21184@phenom.ffwll.local>
Mail-Followup-To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
References: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
 <20190108145056.2276-2-paul.kocialkowski@bootlin.com>
 <CAKMK7uE+=00wayXr4hUDiSj+s0PJbCEe9xqS1FFwd2cp3Om+ng@mail.gmail.com>
 <e918403362bc6e47fd4fce2c108ec3515c5e857a.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e918403362bc6e47fd4fce2c108ec3515c5e857a.camel@bootlin.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 05:52:20PM +0100, Paul Kocialkowski wrote:
> Hi Daniel,
> 
> On Tue, 2019-01-08 at 19:21 +0100, Daniel Vetter wrote:
> > On Tue, Jan 8, 2019 at 3:51 PM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > > During an atomic commit, the HVS is configured with a display list
> > > for the channel matching the associated CRTC. The Pixel Valve (CRTC)
> > > and encoder are also configured for the new setup at that time.
> > > While the Pixel Valve and encoder are reconfigured synchronously, the
> > > HVS is only reconfigured after the display list address (DISPLIST) has
> > > been updated to the current display list address (DISPLACTX), which is
> > > the responsibility of the hardware.
> > > 
> > > The time frame during which the HVS is still running on its previous
> > > configuration but the CRTC and encoder have been reconfigured already
> > > can lead to a number of synchronization issues. They will eventually
> > > cause errors reported on the FIFOs, such as underruns.
> > > 
> > > With underrun detection enabled (from Boris Brezillon's series), this
> > > leads to unreliable underrun detection with random false positives.
> > > 
> > > To ensure a coherent state, wait for each enabled channel of the HVS
> > > to synchronize its current display list address. This fixes the issue
> > > of random underrun reporting on commits.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/vc4/vc4_drv.h  |  1 +
> > >  drivers/gpu/drm/vc4/vc4_hvs.c  | 17 +++++++++++++++++
> > >  drivers/gpu/drm/vc4/vc4_kms.c  |  2 ++
> > >  drivers/gpu/drm/vc4/vc4_regs.h |  2 ++
> > >  4 files changed, 22 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> > > index c24b078f0593..955f157f5ad0 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_drv.h
> > > +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> > > @@ -772,6 +772,7 @@ void vc4_irq_reset(struct drm_device *dev);
> > >  extern struct platform_driver vc4_hvs_driver;
> > >  void vc4_hvs_dump_state(struct drm_device *dev);
> > >  int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
> > > +void vc4_hvs_sync_dlist(struct drm_device *dev);
> > > 
> > >  /* vc4_kms.c */
> > >  int vc4_kms_load(struct drm_device *dev);
> > > diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> > > index 5d8c749c9749..1ba60b8e0c2d 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> > > @@ -166,6 +166,23 @@ static int vc4_hvs_upload_linear_kernel(struct vc4_hvs *hvs,
> > >         return 0;
> > >  }
> > > 
> > > +void vc4_hvs_sync_dlist(struct drm_device *dev)
> > > +{
> > > +       struct vc4_dev *vc4 = to_vc4_dev(dev);
> > > +       unsigned int i;
> > > +       int ret;
> > > +
> > > +       for (i = 0; i < SCALER_CHANNELS_COUNT; i++) {
> > > +               if (!(HVS_READ(SCALER_DISPCTRLX(i)) & SCALER_DISPCTRLX_ENABLE))
> > > +                       continue;
> > > +
> > > +               ret = wait_for(HVS_READ(SCALER_DISPLACTX(i)) ==
> > > +                              HVS_READ(SCALER_DISPLISTX(i)), 1000);
> > > +               WARN(ret, "Timeout waiting for channel %d display list sync\n",
> > > +                    i);
> > > +       }
> > > +}
> > > +
> > >  static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
> > >  {
> > >         struct platform_device *pdev = to_platform_device(dev);
> > > diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> > > index 0490edb192a1..2d66a2b57a91 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_kms.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> > > @@ -155,6 +155,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
> > > 
> > >         drm_atomic_helper_commit_hw_done(state);
> > > 
> > > +       vc4_hvs_sync_dlist(dev);
> > 
> > From your description I'd have guessed you want this between when you
> > update the planes and the crtc, so somewhere between commit_planes()
> > and commit_modeset_enables(). At least I have no idea how waiting here
> > can prevent underruns, by this point there's no further hw programming
> > happening.
> 
> One thing that I did not mention is that the display list (that
> configures the planes) is only set at crtc_enable time (and taken into
> account by the hardware later).
> 
> However, even calling vc4_hvs_sync_dlist right at the end of
> crtc_enable doesn't do either (the old display list just sticks). It
> only seems to work after the HDMI encoder enable step and I don't know
> any good reason why.
> 
> I didn't find any description of when that dlist sync mechanism is
> supposed to take place and what particular event triggers it. Perhaps
> it is triggered by a signal originating from the encoder? If anyone has
> insight on the hardware, feel free to shed some light here :)

Maybe my concern wasn't clear: I have no idea why you need this exactly
and how your hw works. Only thing I meant to highlight is that since all
you're doing is wait a bit, then the only reason I can come up with why
that wait does anything is cleanup_planes() later on. And if that's the
case, then you also need to sufficiently delay the flip_done signalling to
userspace (i.e. sending out the crtc_state->event vblank event).

But I'm really not understanding what the hw does and how your patch here
helps at all. It just looked really strange from a atomic kms pov.
-Daniel

> 
> Cheers and thanks for the review,
> 
> Paul
> 
> > Only exception is if you have an IOMMU which can fault, in
> > which case the cleanup_planes might remove the buffers prematurely.
> > But if that's the problem, then your semantics of the flip_done event
> > are wrong - when flip_done is signalled, the hw must have stopped
> > scanning out the old planes, since userspace expects to be able to
> > start overwriting/reusing them.
> > -Daniel
> > 
> > > +
> > >         drm_atomic_helper_wait_for_flip_done(dev, state);
> > > 
> > >         drm_atomic_helper_cleanup_planes(dev, state);
> > > diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
> > > index 931088014272..50c653309aec 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_regs.h
> > > +++ b/drivers/gpu/drm/vc4/vc4_regs.h
> > > @@ -212,6 +212,8 @@
> > > 
> > >  #define PV_HACT_ACT                            0x30
> > > 
> > > +#define SCALER_CHANNELS_COUNT                  3
> > > +
> > >  #define SCALER_DISPCTRL                         0x00000000
> > >  /* Global register for clock gating the HVS */
> > >  # define SCALER_DISPCTRL_ENABLE                        BIT(31)
> > > --
> > > 2.20.1
> > > 
> > 
> > 
> -- 
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
