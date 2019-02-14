Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB5CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920FC2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="S3OZ08Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437395AbfBNITi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:19:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44972 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392164AbfBNITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:19:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id b20so4241097edw.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNCQPjLdnIhBqXhhWA6K8lHhO+0Ze/ew6QQmXMGPiB4=;
        b=S3OZ08GcrT20JgYbs/tu4oAuBBE7vGL9TneJ3vEqHyuZaSo48ifqaGWumalxZ3M3pu
         kG2+g6D57XMEr0Vfv96SugwpcjGWsU3ShoM44Ll4NBjNXJH5jVsF8sgve9bADuD2d4Ah
         B/wmgRqXr+Y98oy4aDTuUBTukNK9aB/6LsHww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xNCQPjLdnIhBqXhhWA6K8lHhO+0Ze/ew6QQmXMGPiB4=;
        b=pXjp8NmZ0lkvM32+iS8BLixQv5g7GUNKKUlOokKbn5Qc4XKmTPd/XocgWqX8DP2pTy
         DCpRctx4i8wbWK/AzElRRd02UsN/28WFJc144FBVdvPf5s3qMoF+Fr+qZWSDRC3MhobV
         Es9Fo5qaulCQbNpIparRt5ItbHiswDIGxqreqZIgD8f7s1Ut6nS7skC1+gjuQUqyic/m
         nooeBN07GsF3+NQnD1VAA3/p1LfaESjkd0ede+1q9TpuTzPSppvU09rj7Bd0xenSdWqQ
         ZngQZHZ/z/tsNL6/zF7UZMi++M1MX4dWmXeXQb0KSpPWlr6Hgw7dgO20Hv78uGKIVGNc
         D9BA==
X-Gm-Message-State: AHQUAubh/HS65scbbVnH99MzE5ds4p/aWtk9+1bnlX7IGykooKpJDFQC
        uh6n1cuo/UivCjrgYY/fF4LZfQ==
X-Google-Smtp-Source: AHgI3Ib5/vHjr8GMjPzgKDT61CNXkbh8vrZbbuQuhaCXwY0TD3ZUJQgT7NnVKfmJofWYhwDacDWzBA==
X-Received: by 2002:a17:906:d18f:: with SMTP id c15-v6mr1840955ejz.140.1550132375049;
        Thu, 14 Feb 2019 00:19:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c12sm474623edi.52.2019.02.14.00.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 00:19:34 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:19:31 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sean Paul <sean@poorly.run>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] MAINTAINERS: update entry for drm/msm
Message-ID: <20190214081931.GO23159@phenom.ffwll.local>
Mail-Followup-To: Sean Paul <sean@poorly.run>,
        Rob Clark <robdclark@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20190213151107.14833-1-robdclark@gmail.com>
 <20190213152802.GK23159@phenom.ffwll.local>
 <CAF6AEGvMTQD3Yusp+qSLkSAM7=T+4q6kvJJtEAOd+9UsvrxMnA@mail.gmail.com>
 <CAKMK7uHxS8XhpuRe-s7vFxBWc7WH8wiPZskDrW0QmXSg-dKDhA@mail.gmail.com>
 <20190213162307.GL114153@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213162307.GL114153@art_vandelay>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:23:07AM -0500, Sean Paul wrote:
> On Wed, Feb 13, 2019 at 05:04:59PM +0100, Daniel Vetter wrote:
> > On Wed, Feb 13, 2019 at 4:43 PM Rob Clark via dri-devel
> > <dri-devel@lists.freedesktop.org> wrote:
> > >
> > > On Wed, Feb 13, 2019 at 10:28 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > >
> > > > On Wed, Feb 13, 2019 at 10:10:44AM -0500, Rob Clark via dri-devel wrote:
> > > > > We've moved the tree to a shared gitlab tree, so that Sean can help out
> > > > > with maintainer duties.
> > > > >
> > > > > Cc: Sean Paul <seanpaul@chromium.org>
> > > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > > > ---
> > > > > I can include this patch in msm-next for v5.1, but wanted to get it
> > > > > ack'd on list
> > > >
> > > > Is the plan to also add this to dim, for full group maintainership fun?
> > > > It's more or less adding a few lines to nightly.conf and done (plus
> > > > everyone being ok with using the dim tooling).
> > >
> > > I think drm/msm is big enough, that it wouldn't make sense to move to
> > > drm-misc..  but possibly using the dim tooling could make sense.
> > 
> > This was about using the dim tooling, not about moving msm to
> > drm-misc. That indeed doesn't make much sense. And Sean already knows
> > that tooling. Plus you pretty much need a big script if you want to
> > add more committers (which imo you guys totally should), since
> > otherwise you spend up endless amounts of time training people on
> > trivial hiccups.
> 
> Yeah, we've talked about switching to dim a few times already. IMO, the big win
> for msm would be inclusion in drm-tip to catch integration issues early, and
> dim's sanity checks around tags. Selfishly, this would also reduce dim's
> complaints when backmerging drm into drm-misc  :-).
> 
> That said, would the committers we'd want to add to msm (Qualcomm employees) be
> receptive to (or even able to install/download) dim? I'm not sure on this one.
> 
> At any rate, last time we discussed dim, we agreed the first step was to get
> msm on gitlab so we can easily add commit access and go from there. I think
> we're probably just at the end of that transition period, so everything is on
> track!

If you folks want I can add msm-next and msm-fixes (that one doesn't exist
yet) to the dim branches. That way you don't have to reinvent wheels
anymore (you can use dim) and Rob can look into it whenever (dim only
checks stuff you're doing, and doesn't care what other people push).

Oh and ocd me noticed you have some branch chaos :-)
-Daniel

> 
> Sean
> 
> 
> > -Daniel
> > 
> > > BR,
> > > -R
> > >
> > > > -Daniel
> > > >
> > > > >
> > > > >  MAINTAINERS | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 9919840d54cd..2141a1b6653d 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -4838,10 +4838,11 @@ F:    Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
> > > > >
> > > > >  DRM DRIVER FOR MSM ADRENO GPU
> > > > >  M:   Rob Clark <robdclark@gmail.com>
> > > > > +M:   Sean Paul <sean@poorly.run>
> > > > >  L:   linux-arm-msm@vger.kernel.org
> > > > >  L:   dri-devel@lists.freedesktop.org
> > > > >  L:   freedreno@lists.freedesktop.org
> > > > > -T:   git git://people.freedesktop.org/~robclark/linux
> > > > > +T:   git https://gitlab.freedesktop.org/drm/msm.git
> > > > >  S:   Maintained
> > > > >  F:   drivers/gpu/drm/msm/
> > > > >  F:   include/uapi/drm/msm_drm.h
> > > > > --
> > > > > A
> > > > > 2.20.1
> > > > >
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
