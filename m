Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D2AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0872075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GUY82KIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0872075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJZG7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:59:42 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40654 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJZG7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:59:42 -0400
Received: by mail-vk1-f195.google.com with SMTP id h20-v6so2606117vke.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1xIbpOMU7LHQcuX8kJL/KJMSfkwc40JGrEdZXg8oxs=;
        b=GUY82KISUs1ChkrcRhHo97JoWLjyjN/aRBd1sppLAqgKty+hhl8C5SSNCvU830JaR2
         rJkbhVcA1M7CGndh5BUDpvgRZiGDREb0QY8974l01TUpg973yWl1VDBcrUcoFrH+VaHB
         WIkSKqITkvxglX9flgYadt1jrXf4rfbOuf1NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1xIbpOMU7LHQcuX8kJL/KJMSfkwc40JGrEdZXg8oxs=;
        b=I8a5sOC+ypJ37WPLN2ilhLoDITPuQBkVEkDOXa8gwbV22jD1NZtEsYlDUjcQK/EaLi
         p74YszGG565+BR/dKZvwqNV4uvRM9L35ScsMevNdQKNm6kIuzIs34gFOGisojWxgBIds
         tNKwzrs6tMY0XBuwMEJKyQwBl2oT4BoC35MJlYxBb7kLGTWzkGqQMf92u/aq7kcljyQW
         64MTpE/a0amDesHfx5VfZqasMUQecYE5rnroDuTieIMv2Fhw3VMzPH/aDojaQa+uNVYh
         GIfTAmvqRgNUc6yJkw3XA4BdN5AGdtOVh7qYoDe7VXOgDWMbJAjmMkhJOPCKUNyhtKXk
         nixQ==
X-Gm-Message-State: AGRZ1gLZfvjEHEzRw79S9Nz2mzH/N6Mx+pZcqgwzjpRtv7OgT+oEKb//
        A+1e90kDKdFCJdbXp6jaLUYSik4JPBs=
X-Google-Smtp-Source: AJdET5cxqSx7D3ss60hyEw9XSkBR8/WHNiOc1fyGnwo0Cuvx+grh81gym88tm5tS/LQjnF6P7Dxy9A==
X-Received: by 2002:a1f:8011:: with SMTP id b17mr511113vkd.31.1540506313284;
        Thu, 25 Oct 2018 15:25:13 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id r64sm1984517vsc.33.2018.10.25.15.25.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 15:25:11 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id g10so3056697uak.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:25:11 -0700 (PDT)
X-Received: by 2002:ab0:132a:: with SMTP id g39mr532207uae.83.1540506310990;
 Thu, 25 Oct 2018 15:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181022204639.8558-1-dianders@chromium.org> <20181022204639.8558-5-dianders@chromium.org>
 <20181025181349.GM154160@art_vandelay>
In-Reply-To: <20181025181349.GM154160@art_vandelay>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Oct 2018 15:24:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XjxwmntWs7WRR=8fksdy72=4whVFqWnB4+vn1rp-LZXQ@mail.gmail.com>
Message-ID: <CAD=FV=XjxwmntWs7WRR=8fksdy72=4whVFqWnB4+vn1rp-LZXQ@mail.gmail.com>
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

Rob gave the bindings patch a Reviewed-by tag, so I'm assuming he's
cool with it.  v2 still doesn't keep the "innolux,tv123wam" around.
If you disagree then let me know and I'll do a v3.

-Doug
