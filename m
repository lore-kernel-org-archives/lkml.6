Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBC1C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7CC2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VcPAJWVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfBDVtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:49:17 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56038 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbfBDVtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:49:15 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so3547748ith.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 13:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXAUMtnDYUBudnjcNGW7zUt2M55yRTsdDm+yvgStc5o=;
        b=VcPAJWVZb3NWK1FmDe7fWtfE2UKtHd0EqHMpX2+/8RyPnfyy7VO3CSo+38I8/wh4gm
         netc5MV2ie3Jio9F+Oig+9kubg52amlBbYq+I5cO75+dwF0ogRFqKvoIHFAuKvhiOEJu
         3P8BXJHG2CFQz6Z/miGKHBSevdmyegmp5dL1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXAUMtnDYUBudnjcNGW7zUt2M55yRTsdDm+yvgStc5o=;
        b=p1tlHFy99UiDTiSU5b3Pgt4yunY9/WgNdctdiQuzlOWg/a8S2LrmyLraI7sn2D/LFZ
         yKW7HFG2yX1RfaEGqpMhyAPUpPiUDnGZBnBLN1IUAmOf7jgYU0n30ejpvnWdjjEgAdEm
         AmOR8GE7zrGKz7Bi72ykss+TyMofD3NuEkytFJt0bo9ccLejNip1Jk4HvrarjiHIn4Zc
         61+NTHt+7PMTALROTZQOzxaeeYUOi9OP2PetLM75vdsgov3e39/6o0Eu314G0RQQ0CeB
         eY9GtlrHxIYbS/eTrR0VAcscL4AiyZRLZQCJPrWIN+LEVzi2DKyrT1J9vi5tax5tMLE7
         JXoA==
X-Gm-Message-State: AHQUAuYjQXw6THp6TGsSLtl+Awxa82rQj2NgY08jp19d7YZGzJ03h073
        wAuoIi77aS2Z+gUaeBPgu8QlzhGCfZuxPjK//tfBng==
X-Google-Smtp-Source: AHgI3IYhxes8EcM5tcweGIQVeMJ4xzZ3SayKapWg/JgjaRHTjfX6oaDnDWFYj7UmZWfOG2Tbz/BmPuzMWKrIsqsED8U=
X-Received: by 2002:a02:781e:: with SMTP id p30mr937839jac.85.1549316954171;
 Mon, 04 Feb 2019 13:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20190204103114.30772-1-daniel.vetter@ffwll.ch> <20190204184911.GB2834@ravnborg.org>
In-Reply-To: <20190204184911.GB2834@ravnborg.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 4 Feb 2019 22:49:01 +0100
Message-ID: <CAKMK7uEO5b556+gKpw+WPuFVULB_-ii83gc207AYu5mEqUnacg@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging/vboxvideo: don't set dev_priv_size = 0
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Fabio Rafael da Rosa <fdr@pid42.net>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 7:49 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Daniel
>
> On Mon, Feb 04, 2019 at 11:31:13AM +0100, Daniel Vetter wrote:
> > The compiler already clears this for us.
> >
> > More important, someone might look what this is actually used for,
> > and freak out about the dragon staring back at them.
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Nicholas Mc Guire <der.herr@hofr.at>
> > Cc: Emil Velikov <emil.velikov@collabora.com>
> > Cc: Fabio Rafael da Rosa <fdr@pid42.net>
> > ---
> >  drivers/staging/vboxvideo/vbox_drv.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/staging/vboxvideo/vbox_drv.c b/drivers/staging/vboxvideo/vbox_drv.c
> > index b0d73d5fba5d..43c3d0a4fa1a 100644
> > --- a/drivers/staging/vboxvideo/vbox_drv.c
> > +++ b/drivers/staging/vboxvideo/vbox_drv.c
> > @@ -222,7 +222,6 @@ static void vbox_master_drop(struct drm_device *dev, struct drm_file *file_priv)
> >  static struct drm_driver driver = {
> >       .driver_features =
> >           DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME | DRIVER_ATOMIC,
> > -     .dev_priv_size = 0,
> >
> >       .lastclose = drm_fb_helper_lastclose,
> >       .master_set = vbox_master_set,
>
> I have stared at the file for a long time and so far no dragon
> was staring back at me. There was a few "#ifdef" that screamed
> at me, and a drm_fb_helper_fbdev_setup() that looked
> suspicious alas no dragon :-(

dev_priv_size is used by drm_bufs.c aka "you want a root-hole? have
it!" code from dri1 days. It's not running on any modern driver, at
least trinity/syzcaller stopped complaining (and I reviewed all the
entry points and made sure they go nowhere else than an immediate
return -errno). Except nouveau, for reasons (we accidentally made it
uapi there, but it's fixed, just need to wait for all those installs
to die so we can nuke it for good). The dragon was right there
breathing down your neck, and wouldn't have seen it coming  if it
decided to have a snack :-)

btw if you're bored, we should probably have a
CONFIG_FEWER_EXPLOITS_IN_DRM_NOUVEAU or so, default n, for the next
unaware traveller wandering into this dragon den.
-Daniel

> As for the change above, dragon or no dragon:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
>         Sam



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
