Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C30EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060D620665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gyLG8QLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060D620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeJZDTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:19:21 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42561 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJZDTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:19:20 -0400
Received: by mail-vs1-f68.google.com with SMTP id e126so6191158vsc.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVjRay9L5RYGKHqfRl6SjjXuqA1VHcELdesIXLSyj1s=;
        b=gyLG8QLyjcN2IDdDjTpcVY5emaM+wKnqaHFhwWlft3yj2AtaOQoV8Q3RdLZqkAcrRc
         060+VPsQZV0H8VIcMxXI9XAopk9Ir0/+kVjHvaF3IL1s2Q4qynN5bFnmbX5FesV/zZ+9
         25R56nove04bGXXx4Shz9hvtG1k82iPZZORDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVjRay9L5RYGKHqfRl6SjjXuqA1VHcELdesIXLSyj1s=;
        b=aRQYbHWQ2uewRAUu5WZ3ll6s7LG57+M6vQ0bvNOU/4zuoPmelENdEh/a3OeDiGcZ8P
         /s/QuszgRbatupKtndqwK2wNvn5jFrGIspYR3PoAAgme4S/jUofN8EIBgWSOdwBu8C3g
         GtkHj61wMLIfMeod6WcV+YLkJtXvHzw6kZGwf/htFlV+zlh3VK6BJU3ofwj179tL+eLr
         +Lv0pEm67+/3kCoBxqnErFS2N/5yeQWaf+lnvsgzknpUe5ts/ODSXKfAFQuQjiw+6xKs
         EGqRermU+bZ0pkpYQrh42pz6+XyPFBgQVOu8FW052huvPP5fX7+rcWPN2Sa7GhkHsoEN
         cWgQ==
X-Gm-Message-State: AGRZ1gL1jMwSafDk4BA7ALeNbCyIzc9dtfHttMhWXYOcYRaOrbT8oAs3
        XzfHs0EyfcM6ZKDjvRLZ2DBCh4D0Vcw=
X-Google-Smtp-Source: AJdET5c6+m/WXgyp/AtVp4MvQmLmEdc0VfDKPbaLIPGw6W9IXPV/FM8V5MhrM4+GcQEZt16aRus0BQ==
X-Received: by 2002:a67:1dc4:: with SMTP id d187mr169322vsd.187.1540493123400;
        Thu, 25 Oct 2018 11:45:23 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id m73sm1052308vsh.19.2018.10.25.11.45.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:45:21 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id m18so3655762uaq.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:45:21 -0700 (PDT)
X-Received: by 2002:ab0:3f7:: with SMTP id 110mr191186uau.27.1540493121260;
 Thu, 25 Oct 2018 11:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181022204639.8558-1-dianders@chromium.org> <20181022204639.8558-5-dianders@chromium.org>
 <20181025181349.GM154160@art_vandelay>
In-Reply-To: <20181025181349.GM154160@art_vandelay>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Oct 2018 11:45:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vs7V7zN8MoyPhjAWcszfWZ0xT50ELo-2gZ-iLmjr7s7w@mail.gmail.com>
Message-ID: <CAD=FV=Vs7V7zN8MoyPhjAWcszfWZ0xT50ELo-2gZ-iLmjr7s7w@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/panel: simple: Innolux TV123WAM is actually P120ZDG-BF1
To:     sean@poorly.run
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        ryandcase@chromium.org, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 25, 2018 at 11:13 AM Sean Paul <sean@poorly.run> wrote:
>
> On Mon, Oct 22, 2018 at 01:46:38PM -0700, Douglas Anderson wrote:
> > As far as I can tell the panel that was added in commit da50bd4258db
> > ("drm/panel: simple: Add Innolux TV123WAM panel driver support")
> > wasn't actually an Innolux TV123WAM but was actually an Innolux
> > P120ZDG-BF1.
> >
> > As far as I can tell the Innolux TV123WAM isn't a real panel and but
> > it's a mosh between the TI TV123WAM and the Innolux P120ZDG-BF1.
> > Let's unmosh.
> >
> > Here's my evidence:
> >
> > * Searching for TV123WAM on the Internet turns up a TI panel.  While
> >   it's possible that an Innolux panel has the same model number as the
> >   TI Panel, it seems a little doubtful.  Looking up the datasheet from
> >   the TI Panel shows that it's 1920 x 1280 and 259.2 mm x 172.8 mm.
> >
> > * As far as I know, the patch adding the Innolux Panel was supposed to
> >   be for the board that's sitting in front of me as I type this
> >   (support for that board is not yet upstream).  On the back of that
> >   panel I see Innolux P120ZDZ-EZ1 rev B1.
> >
> > * Someone pointed me at a datasheet that's supposed to be for the
> >   panel in front of me (sorry, I can't share the datasheet).  That
> >   datasheet has the string "p120zdg-bf1"
> >
> > * If I search for "P120ZDG-BF1" on the Internet I get hits for panels
> >   that are 2160x1440.  They don't have datasheets, but the fact that
> >   the resolution matches is a good sign.
> >
> > In any case, let's update the name and also the physical size to match
> > the correct panel.
> >
> > Fixes: da50bd4258db ("drm/panel: simple: Add Innolux TV123WAM panel driver support")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Cc: Sandeep Panda <spanda@codeaurora.org>
> > ---
> >
> >  drivers/gpu/drm/panel/panel-simple.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 937e97490c30..7ee1abc5d81b 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -1370,7 +1370,7 @@ static const struct panel_desc innolux_n156bge_l21 = {
> >       },
> >  };
> >
> > -static const struct drm_display_mode innolux_tv123wam_mode = {
> > +static const struct drm_display_mode innolux_p120zdg_bf1_mode = {
> >       .clock = 206016,
> >       .hdisplay = 2160,
> >       .hsync_start = 2160 + 48,
> > @@ -1384,13 +1384,13 @@ static const struct drm_display_mode innolux_tv123wam_mode = {
> >       .flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> >  };
> >
> > -static const struct panel_desc innolux_tv123wam = {
> > -     .modes = &innolux_tv123wam_mode,
> > +static const struct panel_desc innolux_p120zdg_bf1 = {
> > +     .modes = &innolux_p120zdg_bf1_mode,
> >       .num_modes = 1,
> >       .bpc = 8,
> >       .size = {
> > -             .width = 259,
> > -             .height = 173,
> > +             .width = 254,
> > +             .height = 169,
> >       },
> >       .delay = {
> >               .prepare = 200,
> > @@ -2454,8 +2454,8 @@ static const struct of_device_id platform_of_match[] = {
> >               .compatible = "innolux,n156bge-l21",
> >               .data = &innolux_n156bge_l21,
> >       }, {
> > -             .compatible = "innolux,tv123wam",
>
> I think we should update the struct, but we might want to keep this around.
> Given the tv123wam panel is TI, we're likely not going to have a collision on
> innolux,...
>
> That said, I'll defer to robh on this one, I'm not sure if changing names is
> cool once the bindings have hit mainline.

Whoops, I missed Rob on this patch--just had him on the bindings one.

...generally I believe Rob seems to be OK with wiping out backward
compatibility for things like this when the previous binding is super
new and there's no evidence that anyone ever used it (like if it was
added for a specific board and that board doesn't have a fully
functional DT anyway).

In this particular case I'm 99.9999% certain nobody is using the
existing binding.  If someone crawls out of the woodwork and says this
patch broke them, it would be trivially easy to add the backward
compatible string later.

Obviously Rob can feel free to correct me if I'm wrong.

I purposely put this patch at the end of the series so we can land the
earlier ones and we can sit on this one for a little while if desired.

-Doug
