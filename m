Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D401C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951E5207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MFEPLOrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951E5207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeJXQoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:44:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43288 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeJXQoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:44:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so4145608eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 01:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Wxy5n5dyFft5HTQA9MfdyoBguXwPjLQF+reyYRBiaRI=;
        b=MFEPLOrLdY0YWZ30nvf8dsW8RohIyie+WFShD9zXguUG072YMhWUrjRq9sACDxK6k0
         QiRzJwbl5PGzwJkqW4Sn7ezmOLBlzeVNQWiY51bQ6bg6Dxv6AvTbeVeSOus9lLbaGDQm
         eLJjiqrYGRyDwOOh3oPsJ5bYeMcF7T7WuwmsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Wxy5n5dyFft5HTQA9MfdyoBguXwPjLQF+reyYRBiaRI=;
        b=sxRRIvBlUofm8BVIUu3JukC6uUqSKgCOp4Qc83LhZ/UMqjRg6iJy0nMSK9jrA9I2hx
         249B3JxpsiPg0rCig3vQ6laZ7S8X/OLGkYCMCHIwngk3az6OF0F4i1oKZuDu74q5wsgi
         RjVQgIbobMapFTuJPK9ch1DWB5PORIIc0QX+diuG+gwWVbpj9TLPHo8i2wcx4c5wtxVO
         mbnGommMvrYNVVLG2BbD8hXJAhL9qgc2NjOULTDAc8a7+Z+rh0G3k6tBbXcmeoJNgwdd
         aPj0xTm0yXcBHBNN/Sdvyoyac//zc2Ewguflm6txTScj47lI3ldf7zB6IiJLu64rIkV3
         k7HQ==
X-Gm-Message-State: ABuFfoiR7WYiEhz/X3de5C1MIM6TDHQEAv6ueV3mZQ839kEC0PiHWaYh
        XbcYdB+y2wa7xv6TsdzaOheHCA==
X-Google-Smtp-Source: ACcGV62+6hv9rJzlG/i4yJDLVja8YjhSFgp7qNmoWbVtUsu0pecgxCxK/kDWGQYvm9bNL2wmIPtO/g==
X-Received: by 2002:a05:6402:159a:: with SMTP id c26mr17529963edv.39.1540369021355;
        Wed, 24 Oct 2018 01:17:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a3-v6sm847384ejr.55.2018.10.24.01.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 01:17:00 -0700 (PDT)
Date:   Wed, 24 Oct 2018 10:16:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/2] drm: Add missing flags for pixel clock & data
 enable
Message-ID: <20181024081658.GD324@phenom.ffwll.local>
Mail-Followup-To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1537788981-21479-1-git-send-email-yannick.fertre@st.com>
 <1537788981-21479-2-git-send-email-yannick.fertre@st.com>
 <CA+M3ks4L_Cs_GB2sxg1XyygLz79eH7d+JcgLULM3fFN0U=YCZw@mail.gmail.com>
 <CA+M3ks5HWuUXHdKePT0MAU9G=4YkUdJZBXBasVW_X1A2YTSSoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks5HWuUXHdKePT0MAU9G=4YkUdJZBXBasVW_X1A2YTSSoA@mail.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 04:50:19PM +0200, Benjamin Gaignard wrote:
> Le lun. 15 oct. 2018 à 13:15, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> a écrit :
> >
> > Le lun. 24 sept. 2018 à 13:59, Yannick Fertré <yannick.fertre@st.com> a écrit :
> > >
> > > Add missing flags for pixel clock & data enable polarities.
> > > These flags are similar to other synchronization signals (hsync, vsync...).
> > >
> > > Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> >
> > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> 
> Dave or Daniel could you give us your PoV on this patch ?

Does it work? Iirc we had some userspace chocking on new mode flags, and
needed explicit opt-in. If that looks good (check weston, -modesetting and
drm_hwc, that should have you covered I hope) then has my ack.
-Daniel

> Thanks
> 
> >
> > > ---
> > >  drivers/gpu/drm/drm_modes.c | 19 ++++++++++++++++++-
> > >  include/uapi/drm/drm_mode.h |  6 ++++++
> > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > > index 02db9ac..596f8b3 100644
> > > --- a/drivers/gpu/drm/drm_modes.c
> > > +++ b/drivers/gpu/drm/drm_modes.c
> > > @@ -130,7 +130,7 @@ EXPORT_SYMBOL(drm_mode_probed_add);
> > >   * according to the hdisplay, vdisplay, vrefresh.
> > >   * It is based from the VESA(TM) Coordinated Video Timing Generator by
> > >   * Graham Loveridge April 9, 2003 available at
> > > - * http://www.elo.utfsm.cl/~elo212/docs/CVTd6r1.xls
> > > + * http://www.elo.utfsm.cl/~elo212/docs/CVTd6r1.xls
> > >   *
> > >   * And it is copied from xf86CVTmode in xserver/hw/xfree86/modes/xf86cvt.c.
> > >   * What I have done is to translate it by using integer calculation.
> > > @@ -611,6 +611,15 @@ void drm_display_mode_from_videomode(const struct videomode *vm,
> > >                 dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
> > >         if (vm->flags & DISPLAY_FLAGS_DOUBLECLK)
> > >                 dmode->flags |= DRM_MODE_FLAG_DBLCLK;
> > > +       if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> > > +               dmode->flags |= DRM_MODE_FLAG_PPIXCLK;
> > > +       else if (vm->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> > > +               dmode->flags |= DRM_MODE_FLAG_NPIXCLK;
> > > +       if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
> > > +               dmode->flags |= DRM_MODE_FLAG_PDATAEN;
> > > +       else if (vm->flags & DISPLAY_FLAGS_DE_LOW)
> > > +               dmode->flags |= DRM_MODE_FLAG_NDE;
> > > +
> > >         drm_mode_set_name(dmode);
> > >  }
> > >  EXPORT_SYMBOL_GPL(drm_display_mode_from_videomode);
> > > @@ -652,6 +661,14 @@ void drm_display_mode_to_videomode(const struct drm_display_mode *dmode,
> > >                 vm->flags |= DISPLAY_FLAGS_DOUBLESCAN;
> > >         if (dmode->flags & DRM_MODE_FLAG_DBLCLK)
> > >                 vm->flags |= DISPLAY_FLAGS_DOUBLECLK;
> > > +       if (dmode->flags & DRM_MODE_FLAG_PPIXDATA)
> > > +               vm->flags |= DISPLAY_FLAGS_PIXDATA_POSEDGE;
> > > +       else if (dmode->flags & DRM_MODE_FLAG_NPIXDATA)
> > > +               vm->flags |= DISPLAY_FLAGS_PIXDATA_NEGEDGE;
> > > +       if (dmode->flags & DRM_MODE_FLAG_PDE)
> > > +               vm->flags |= DISPLAY_FLAGS_DE_HIGH;
> > > +       else if (dmode->flags & DRM_MODE_FLAG_NDE)
> > > +               vm->flags |= DISPLAY_FLAGS_DE_LOW;
> > >  }
> > >  EXPORT_SYMBOL_GPL(drm_display_mode_to_videomode);
> > >
> > > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> > > index d3e0fe3..b335a17 100644
> > > --- a/include/uapi/drm/drm_mode.h
> > > +++ b/include/uapi/drm/drm_mode.h
> > > @@ -89,6 +89,12 @@ extern "C" {
> > >  #define  DRM_MODE_FLAG_3D_TOP_AND_BOTTOM       (7<<14)
> > >  #define  DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF    (8<<14)
> > >
> > > +/* flags for polarity clock & data enable polarities */
> > > +#define DRM_MODE_FLAG_PPIXDATA                 (1 << 19)
> > > +#define DRM_MODE_FLAG_NPIXDATA                 (1 << 20)
> > > +#define DRM_MODE_FLAG_PDE                      (1 << 21)
> > > +#define DRM_MODE_FLAG_NDE                      (1 << 22)
> > > +
> > >  /* Picture aspect ratio options */
> > >  #define DRM_MODE_PICTURE_ASPECT_NONE           0
> > >  #define DRM_MODE_PICTURE_ASPECT_4_3            1
> > > --
> > > 2.7.4
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
> -- 
> Benjamin Gaignard
> 
> Graphic Study Group
> 
> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro: Facebook | Twitter | Blog

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
