Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0CFC5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF12220850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UA9K1lqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfARRQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:16:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51258 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfARRP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:15:59 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so7761045ite.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nUCOgtt7/vbtqHr/0zJnpySnEDUiBMATX3kTSQXyjf4=;
        b=UA9K1lquEZpgdzlBK3d0M/kozgnnR06AdhbASj7N7Sm6XiqVlNyCD6RqA+1LxExaR7
         fy9YQ/C7b59nVUQKAxBFrlEwkE+4tZ63pEjxRFlcWAlqvyy8kndAptFfahM+EktMQgrn
         34dfrvVLe+vJuDzN22B0HOWjX1iBX7h/hqT38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nUCOgtt7/vbtqHr/0zJnpySnEDUiBMATX3kTSQXyjf4=;
        b=nU91wHV9rybxmSwlEFRi/WXIbNKf3HNLs/2hG4T9VHOwJ5UoQ9hfKRE/d4IhS/kGyq
         JoGX5WTkqzPSXvXZWSgGvEFpot2XlO5cEzDiUIQTs5Xz9mMB9N8gMQ0bjpZCylYwLY7Q
         DkW4UpaHylhFb/KXCiWbm3LnScEYK70oICuSH30UVZ6WMzUi7LszOrg84wXNiWCGoMAY
         V0jsSB5A+gSglMInkLb3NfD7veOqqrASPUCL197wqN0iUnhIye0HrM3v3YN4A3v6NU+w
         t1N+HJgREiJqwf9aNfcq3ZZL+HPYNrppSgvfqx2rnDxah0TOilvdeX9lfxCOy+HfWh9u
         +1tA==
X-Gm-Message-State: AJcUukcRn9hQPcO4/KN5EAbc9YSqEUkAid0rFYs1L16GPg5cliecgFKC
        Bz8v1Q66k0XoEgO0+zeGXm8rbA8tRwMrXV2dneZJjw==
X-Google-Smtp-Source: ALg8bN4vQ0C5lKRqwbB1sar2HSYh+0HDzlEgNk28BjMZA88g1xqVPdu4MaEBoLzTIv5gBRzaRbwxj22eZG2NbTQjHlQ=
X-Received: by 2002:a24:94cb:: with SMTP id j194mr11418526ite.117.1547831755480;
 Fri, 18 Jan 2019 09:15:55 -0800 (PST)
MIME-Version: 1.0
References: <20190118122020.27596-1-kraxel@redhat.com> <20190118122020.27596-24-kraxel@redhat.com>
 <20190118154944.GH3271@phenom.ffwll.local> <20190118163233.GM20097@intel.com>
In-Reply-To: <20190118163233.GM20097@intel.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 18 Jan 2019 18:15:44 +0100
Message-ID: <CAKMK7uF0e+cTXv-TyRDrqFUSKQCtnB99V3jRtrLbmPcptkEs+Q@mail.gmail.com>
Subject: Re: [PATCH v3 23/23] drm/qxl: add overflow checks to qxl_mode_dumb_create()
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:32 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Jan 18, 2019 at 04:49:44PM +0100, Daniel Vetter wrote:
> > On Fri, Jan 18, 2019 at 01:20:20PM +0100, Gerd Hoffmann wrote:
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > We already do all reasonable overflow checks in drm_mode_create_dumb().=
 If
> > you don't trust them I think would be better time spent typing an igt t=
o
> > test this than adding redundant check in all drivers.
> >
> > You're also missing one check for bpp underflows :-)
>
> BTW I just noticed that we don't seem to validating
> create_dumb->flags at all. Someone should probably add some
> checks for that, or mark it as deprecated in case we already
> lost the battle with userspace stack garbage.

Given that every kms client/compositor under the sun uses this (or
well, all the generic ones at least) I think we can safely assume to
have lost that battle :-/
-Daniel

>
> > -Daniel
> >
> > > ---
> > >  drivers/gpu/drm/qxl/qxl_dumb.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl=
_dumb.c
> > > index 272d19b677..bed6d06ee4 100644
> > > --- a/drivers/gpu/drm/qxl/qxl_dumb.c
> > > +++ b/drivers/gpu/drm/qxl/qxl_dumb.c
> > > @@ -37,11 +37,13 @@ int qxl_mode_dumb_create(struct drm_file *file_pr=
iv,
> > >     uint32_t handle;
> > >     int r;
> > >     struct qxl_surface surf;
> > > -   uint32_t pitch, format;
> > > +   uint32_t pitch, size, format;
> > >
> > > -   pitch =3D args->width * ((args->bpp + 1) / 8);
> > > -   args->size =3D pitch * args->height;
> > > -   args->size =3D ALIGN(args->size, PAGE_SIZE);
> > > +   if (check_mul_overflow(args->width, ((args->bpp + 1) / 8), &pitch=
))
> > > +           return -EINVAL;
> > > +   if (check_mul_overflow(pitch, args->height, &size))
> > > +           return -EINVAL;
> > > +   args->size =3D ALIGN(size, PAGE_SIZE);
> > >
> > >     switch (args->bpp) {
> > >     case 16:
> > > --
> > > 2.9.3
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
