Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA40CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7829D2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H8Dv7D1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfBUOYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:24:23 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37553 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:24:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id m12so23271159edv.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZQAFUDUjwfCpg7XfgJQwpJJFuZFeiMRAsGcLm7XG51c=;
        b=H8Dv7D1OwmAC25lxy94ihuw+uGssAnZYN59GjrvaKDEZubnUvYWc5lTvmsv4zt9gmM
         WTF+Oesa5l6K8AGURTWwZYcPUf4DC0AhmP5CFp8PrRH0rA7nIZv9MFiH38PO80Fv74hX
         uTCYAYv6bCVaWiKh+B8yqxHtqAPcEo8AFQdHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZQAFUDUjwfCpg7XfgJQwpJJFuZFeiMRAsGcLm7XG51c=;
        b=Xuom3q0FOvZ20lHwMZvhfQDKfA8L03vjTXkNKNFKD2DnQ1bfIh8RLf1kLsjAas9Jru
         3It4PdQjdM94OJxSGF0mGJ55cFtn6YC0FUpDk65ewj0r/CAcKY2/gNI2WCmzEEhKB0kb
         qD7BJFp66HiBlt+V1sG70I0j0xVZAY2uSyQZJL9S8BbwyOvncB4N6XjjpDvc0+QWbNEl
         0i/izpTlq3tCTr2Xwh/mzNgpL21hewHqntzVBFhGlaT0ALZR4p0TBbjeSS3szygoxMsY
         9edyeVDUhnA4vuM8Px6u9Vgkfahi8InFayL/U7hEZse9ieupnIlhzqLWcqs0yVqWS0ML
         Ga/Q==
X-Gm-Message-State: AHQUAuaftbjAty+MhPVesOxRlDgqAEbhICaWI8xWPhkRSqe4cGRNc6D9
        KdT5CGvRaqpvwqpZhdWVBl69Uw==
X-Google-Smtp-Source: AHgI3IZvufaZbwwVo5eiM09ZrsqguDhPastE6Rr2nxrBs9vV5Vmbd2/SQ68zjdeb/ELp68YfBlpUmA==
X-Received: by 2002:a17:906:2643:: with SMTP id i3mr27696587ejc.157.1550759060531;
        Thu, 21 Feb 2019 06:24:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s3sm5432079edm.78.2019.02.21.06.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 06:24:19 -0800 (PST)
Date:   Thu, 21 Feb 2019 15:24:17 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drm/qxl: kick out vgacon
Message-ID: <20190221142417.GT2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190221113534.20764-1-kraxel@redhat.com>
 <20190221113534.20764-3-kraxel@redhat.com>
 <20190221122011.GP2665@phenom.ffwll.local>
 <20190221130623.rjtmtoe2qf7dgy2t@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221130623.rjtmtoe2qf7dgy2t@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:06:23PM +0100, Gerd Hoffmann wrote:
> On Thu, Feb 21, 2019 at 01:20:11PM +0100, Daniel Vetter wrote:
> > On Thu, Feb 21, 2019 at 12:35:34PM +0100, Gerd Hoffmann wrote:
> > > Problem:  qxl switches from native mode back into vga compatibility mode
> > > when it notices someone is accessing vga registers.  And vgacon does
> > > exactly that before fbcon takes over.  So make sure we kick out vgacon
> > > early enough that it wouldn't disturb us.
> > > 
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >  drivers/gpu/drm/qxl/qxl_drv.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > > index bb81e310eb..08446561aa 100644
> > > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > > @@ -95,6 +95,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> > >  		goto modeset_cleanup;
> > >  
> > >  	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
> > > +	drm_fb_helper_kick_out_vgacon();
> > 
> > I was thinking of checking whether pdev is a VGA class device and whether
> > it decodes vga access, and in that case automatically calling
> > kick_out_vgacon from remove_conflicting_pci_framebuffer. Since that's what
> > drivers want anyway, and those who don't can open code it.
> > 
> > Or is there an issue with that?
> 
> It'll need more careful testing to make sure we don't have unwanted side
> effects when just doing it for everyone.  And I guess most drivers don't
> care much because their hardware ignores vga port writes once they are
> switched out of vga text mode.
> 
> Dunno why i915 needs this.

The problem isn't loading, it's unloading again. If you boot with vgacon,
but no fbdev driver (which iirc also has magic code to throw out the vga
console), then when you unload your kms driver vgacon kicks back in. And a
pile of things go really sideways when that happens.

I have no idea whether it's just intel hw or maybe pci decoding or
something else, but seems like good practice to kick out all existing
drivers, to make sure they can never get at the hw again.

So don't think it'll hurt to do this for everyone. But yeah maybe we can
do that as a follow-up (and convert i915 over), dunno.
-Daniel


> In case of qxl it is more a historical leftover.  The very first qxl
> device revision had no explicit qxl command to switch from qxl native
> mode back to vga compatibility mode, vga port access was used for that
> instead.  It's long fixed, but the qxl device still has that quirk for
> compatibility with very old guest drivers.
> 
> cheers,
>   Gerd
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
