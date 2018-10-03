Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA34C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273A82082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="axRPMGtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273A82082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJCWSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:18:39 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34575 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCWSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:18:39 -0400
Received: by mail-it1-f193.google.com with SMTP id l127-v6so10080272ith.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z4PJHKEwmLIt4+uHeuUGyaq6idRQbatKGZl4eAqUpQY=;
        b=axRPMGtJ1BebstQf6vtaI3oDyVGKVbt13pyYKBks+hcbouLSTbtcdX0SogtVsqMQSJ
         bn7TLrVmjcglqgTnAMpLM/BO6GQWYfGk4jvUJX33fGoDG8YBa8UIk1NOggVAW3KSufvX
         QBhvEUsGQAoXv2midbYGfwD1v0t+AnzfjwkIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z4PJHKEwmLIt4+uHeuUGyaq6idRQbatKGZl4eAqUpQY=;
        b=tmmQc700ULXfYPjq1H8icNgAz+YaCAiq7bSyDrr9t6wEOgMRqm9tv8/3k0HcJHQP1q
         q6WCAFtfQ7NrD+HW0m0dNooZOjyjucFelsE++wtmhRdlu7bRNdpWhGAYD7dlNbr+BsR9
         i7Pi7ivUs/7JHpvikBdxLYvId+HCa5+U6nHWn4Thrxxwc2olijTro+257THz0JfNMqHL
         S3GEzgEFIXs7kILuHZqV/F6Pxwy5fy3sD7aC+qBIN3mA0ZgnQaF4B1DWoylqrrMfNJUW
         nTfL+TOKHEx2uUgq1djctZmmOk8uRnRYrkGsFMk7k/Na/c/oQUTu8cOkmaf9wjwj/KCb
         AvlA==
X-Gm-Message-State: ABuFfohQFgsMNXiKrP5GHnHWLTNl/TWdk8PDujzYwsRwpkDQNtMHkDfL
        irsFuJApNiBGXtrv+biLS9+DAOAJYybi7ThPIug/lw==
X-Google-Smtp-Source: ACcGV60PIE+jhaR1pRJOci3ppmTFz9xcIynFSIRYFTeS3fxNXCBkeg3CWbpI5oia/TgALBfE2GSGNEgC6OnNVu0ZnXM=
X-Received: by 2002:a24:d857:: with SMTP id b84-v6mr1857489itg.77.1538580586125;
 Wed, 03 Oct 2018 08:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181003110457.9318-1-Eugeniy.Paltsev@synopsys.com>
 <CAKMK7uFP3bMcNSY2L9ZmvFPz6KB51_gMnZ-b7FPCz3NEOafi=w@mail.gmail.com>
 <20181003123047.GK9144@intel.com> <1538577004.11140.5.camel@synopsys.com>
In-Reply-To: <1538577004.11140.5.camel@synopsys.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 3 Oct 2018 17:29:34 +0200
Message-ID: <CAKMK7uGEGQbg=Us3_C25JXvKR084fP0qLif1hHttMYq=xNAZ7g@mail.gmail.com>
Subject: Re: [PATCH] drm: fb-helper: Validate requested pixel format against bpp
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Cc:     "Syrjala, Ville" <ville.syrjala@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        stable <stable@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 4:30 PM Eugeniy Paltsev
<eugeniy.paltsev@synopsys.com> wrote:
>
> On Wed, 2018-10-03 at 15:30 +0300, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Wed, Oct 03, 2018 at 01:36:00PM +0200, Daniel Vetter wrote:
> > > On Wed, Oct 3, 2018 at 1:05 PM Eugeniy Paltsev
> > > <Eugeniy.Paltsev@synopsys.com> wrote:
> > > >
> > > > Validate requested pixel format against bits_per_pixel to reject
> > > > invalid formats with subcomponents length sum is greater than reque=
sted
> > > > bits_per_pixel.
> > > >
> > > > weston 5.0.0 with fbdev backend tries to set up an ARGB x8r8g8b8 pi=
xel
> > > > format without bits_per_pixel updating. So it can request
> > > > x8r8g8b8 with 16 bpp which is obviously incorrect and should be
> > > > rejected.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > >
> > > drm fbdev emulation doesn't support changing the pixel format at all.
> > > I think we should reject all such request, not just the invalid ones.
> > > Can you pls respin?
> >
> > FYI I once posted a patch to tighten up the fb-helper pixel format
> > stuff:
> > https://patchwork.freedesktop.org/patch/203189/
>
>
> Hi Daniel,
>
> will you take Ville's patch or should I create the new one which is only =
related
> to new pixel format validation in drm_fb_helper_check_var() ?

Ville's patch isn't the bugfix we're looking for, but a draft version
of what adding proper format support in drm's fbdev emulation could
look like. With lots&lots of open questions. Not anywhere near ready
for merging, and definitely not stable backport material.

So yes, still want the minimal bugfix.
-Daniel

>
>
> > > Thanks, Daniel
> > >
> > > > ---
> > > >  drivers/gpu/drm/drm_fb_helper.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_=
fb_helper.c
> > > > index 16ec93b75dbf..4f39da07f053 100644
> > > > --- a/drivers/gpu/drm/drm_fb_helper.c
> > > > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > > > @@ -1610,6 +1610,13 @@ int drm_fb_helper_check_var(struct fb_var_sc=
reeninfo *var,
> > > >                 return -EINVAL;
> > > >         }
> > > >
> > > > +       if ((var->green.length + var->blue.length + var->red.length=
 +
> > > > +           var->transp.length) > var->bits_per_pixel) {
> > > > +               DRM_DEBUG("fb requested pixel format can't fit in %=
d bpp\n",
> > > > +                         var->bits_per_pixel);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > >         switch (var->bits_per_pixel) {
> > > >         case 16:
> > > >                 depth =3D (var->green.length =3D=3D 6) ? 16 : 15;
> > > > --
> > > > 2.14.4
> > > >
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.freede=
sktop.org_mailman_listinfo_dri-2Ddevel&d=3DDwIDAw&c=3DDPL6_X_6JkXFx7AXWqB0t=
g&r=3DZlJN
> > > > 1MriPUTkBKCrPSx67GmaplEUGcAEk9yPtCLdUXI&m=3Df12ZyEESIeavtqCUKutiZ9F=
6xtRFC2UUvdqnM4ywBx8&s=3DCPS8taMiYbIgXo-fxhqErOJXvO6PMTzmr-BNnGJIoy0&e=3D
> > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - https://urldefense.proofpoint.com/v2/url?u=3Dh=
ttp-3A__blog.ffwll.ch&d=3DDwIDAw&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DZlJN1MriPUT=
kBKCrPSx67
> > > GmaplEUGcAEk9yPtCLdUXI&m=3Df12ZyEESIeavtqCUKutiZ9F6xtRFC2UUvdqnM4ywBx=
8&s=3DVt8OX9s9ljSK6GDgbnwsF-Yd35fbBUfe8SBV2jPnVaQ&e=3D
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.freedesk=
top.org_mailman_listinfo_dri-2Ddevel&d=3DDwIDAw&c=3DDPL6_X_6JkXFx7AXWqB0tg&=
r=3DZlJN1M
> > > riPUTkBKCrPSx67GmaplEUGcAEk9yPtCLdUXI&m=3Df12ZyEESIeavtqCUKutiZ9F6xtR=
FC2UUvdqnM4ywBx8&s=3DCPS8taMiYbIgXo-fxhqErOJXvO6PMTzmr-BNnGJIoy0&e=3D
> >
> >
> --
>  Eugeniy Paltsev



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
