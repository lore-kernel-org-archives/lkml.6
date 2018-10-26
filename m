Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D080CC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3EF20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="IGHP73pE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3EF20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJZXP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:15:26 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44093 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJZXP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:15:26 -0400
Received: by mail-yw1-f66.google.com with SMTP id t78-v6so531269ywg.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/2z/mEgjYhyqRstHTZxN5Uc03DlP8LkFiul3rPe3GI4=;
        b=IGHP73pE3Zu8/Y/gmlFfccdcZQ4sgxS/WIe5itMZv+5LNTVjqrcChZCKR8K7qstgp2
         U0DmsHOV2ClULvISjFci1z+7aummHMPmbZ8K7KIkOyTMzQnoLamxwwXqvyF28Bxmc96j
         2eUy8OvMmW+vXlEqQ2NIj69D7DOZtiQEa3ucVPGdufBDAa6bvoxSXWvfAS5xvVv7OOSj
         AZ+gdXlBGauMhW7xfvLagdxKNCweTOZV2vgMhiEj0bmVMimEPe5pQQ8k3+aCEF9iOG8a
         wSobKIaj0pw73P7pFUuz8F/c47O/HH3afsyXtdITBMD3UTFkP06v93wgKCOvgWk8P38C
         qZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2z/mEgjYhyqRstHTZxN5Uc03DlP8LkFiul3rPe3GI4=;
        b=oBqKLpvWMvecLOgNOBdAp5ixnx0YS99lBUlPUsGTKCThfrA8heizwEyKsvEeqiVjNi
         xoLp87u3Wlcptrh4n0zwn6ktUCMeFvEAqhfhxUznh9jyEG5upFfor+bCDjmLjiE9dENY
         yWyyr7vR/xo3cWXoMjgCL1tuypD8l0+fwXTQj8g1rYrbjBlMkQOqGLQ7IbJGAu9QyYW9
         NPqEbbiPLTvkEDIRHRxOMEMQYXDncA8134S1wnuJw0B7APA+ysb2MMIsav2gN31TEVSP
         SieU+FJkgr0hIBNtDJ5+JDvp59YkI60fVdK5RFc1FjSyLKBvJ0W3eAg/DqBz9v2Thki/
         9rew==
X-Gm-Message-State: AGRZ1gI0CznqWWIAuxtPsObd/aUONpKEZL3OFktdN2JnkVLEWxdCidzF
        Iqe0i3+uoTDrxu0eyWlaNTRDqg==
X-Google-Smtp-Source: AJdET5fRyh1lKFN/QDeJs7aB6PG9oFU6U2u6Qo4NMOZupcpCNQDVZdoT5kILnsFzY5zSbzA15eJQTA==
X-Received: by 2002:a0d:f847:: with SMTP id i68-v6mr3836139ywf.160.1540564687042;
        Fri, 26 Oct 2018 07:38:07 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id y206-v6sm2756532ywg.57.2018.10.26.07.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 07:38:06 -0700 (PDT)
Date:   Fri, 26 Oct 2018 10:38:05 -0400
From:   Sean Paul <sean@poorly.run>
To:     Doug Anderson <dianders@chromium.org>
Cc:     sean@poorly.run, Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        ryandcase@chromium.org, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 5/6] drm/panel: simple: Innolux TV123WAM is actually
 P120ZDG-BF1
Message-ID: <20181026143805.GP154160@art_vandelay>
References: <20181022204639.8558-1-dianders@chromium.org>
 <20181022204639.8558-5-dianders@chromium.org>
 <20181025181349.GM154160@art_vandelay>
 <CAD=FV=XjxwmntWs7WRR=8fksdy72=4whVFqWnB4+vn1rp-LZXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XjxwmntWs7WRR=8fksdy72=4whVFqWnB4+vn1rp-LZXQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 03:24:58PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Oct 25, 2018 at 11:13 AM Sean Paul <sean@poorly.run> wrote:
> >
> > On Mon, Oct 22, 2018 at 01:46:38PM -0700, Douglas Anderson wrote:
> > > As far as I can tell the panel that was added in commit da50bd4258db
> > > ("drm/panel: simple: Add Innolux TV123WAM panel driver support")
> > > wasn't actually an Innolux TV123WAM but was actually an Innolux
> > > P120ZDG-BF1.
> > >
> > > As far as I can tell the Innolux TV123WAM isn't a real panel and but
> > > it's a mosh between the TI TV123WAM and the Innolux P120ZDG-BF1.
> > > Let's unmosh.
> > >
> > > Here's my evidence:
> > >
> > > * Searching for TV123WAM on the Internet turns up a TI panel.  While
> > >   it's possible that an Innolux panel has the same model number as the
> > >   TI Panel, it seems a little doubtful.  Looking up the datasheet from
> > >   the TI Panel shows that it's 1920 x 1280 and 259.2 mm x 172.8 mm.
> > >
> > > * As far as I know, the patch adding the Innolux Panel was supposed to
> > >   be for the board that's sitting in front of me as I type this
> > >   (support for that board is not yet upstream).  On the back of that
> > >   panel I see Innolux P120ZDZ-EZ1 rev B1.
> > >
> > > * Someone pointed me at a datasheet that's supposed to be for the
> > >   panel in front of me (sorry, I can't share the datasheet).  That
> > >   datasheet has the string "p120zdg-bf1"
> > >
> > > * If I search for "P120ZDG-BF1" on the Internet I get hits for panels
> > >   that are 2160x1440.  They don't have datasheets, but the fact that
> > >   the resolution matches is a good sign.
> > >
> > > In any case, let's update the name and also the physical size to match
> > > the correct panel.
> > >
> > > Fixes: da50bd4258db ("drm/panel: simple: Add Innolux TV123WAM panel driver support")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > Cc: Sandeep Panda <spanda@codeaurora.org>
> > > ---
> > >
> > >  drivers/gpu/drm/panel/panel-simple.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > > index 937e97490c30..7ee1abc5d81b 100644
> > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > @@ -1370,7 +1370,7 @@ static const struct panel_desc innolux_n156bge_l21 = {
> > >       },
> > >  };
> > >
> > > -static const struct drm_display_mode innolux_tv123wam_mode = {
> > > +static const struct drm_display_mode innolux_p120zdg_bf1_mode = {
> > >       .clock = 206016,
> > >       .hdisplay = 2160,
> > >       .hsync_start = 2160 + 48,
> > > @@ -1384,13 +1384,13 @@ static const struct drm_display_mode innolux_tv123wam_mode = {
> > >       .flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> > >  };
> > >
> > > -static const struct panel_desc innolux_tv123wam = {
> > > -     .modes = &innolux_tv123wam_mode,
> > > +static const struct panel_desc innolux_p120zdg_bf1 = {
> > > +     .modes = &innolux_p120zdg_bf1_mode,
> > >       .num_modes = 1,
> > >       .bpc = 8,
> > >       .size = {
> > > -             .width = 259,
> > > -             .height = 173,
> > > +             .width = 254,
> > > +             .height = 169,
> > >       },
> > >       .delay = {
> > >               .prepare = 200,
> > > @@ -2454,8 +2454,8 @@ static const struct of_device_id platform_of_match[] = {
> > >               .compatible = "innolux,n156bge-l21",
> > >               .data = &innolux_n156bge_l21,
> > >       }, {
> > > -             .compatible = "innolux,tv123wam",
> >
> > I think we should update the struct, but we might want to keep this around.
> > Given the tv123wam panel is TI, we're likely not going to have a collision on
> > innolux,...
> >
> > That said, I'll defer to robh on this one, I'm not sure if changing names is
> > cool once the bindings have hit mainline.
> 
> Rob gave the bindings patch a Reviewed-by tag, so I'm assuming he's
> cool with it.  v2 still doesn't keep the "innolux,tv123wam" around.
> If you disagree then let me know and I'll do a v3.

I happily defer to Rob on all things dt. So,

Reviewed-by: Sean Paul <sean@poorly.run>


> 
> -Doug

-- 
Sean Paul, Software Engineer, Google / Chromium OS
