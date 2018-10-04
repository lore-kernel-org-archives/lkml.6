Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0542BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2582087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZcsAxnSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2582087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeJECad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:30:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33128 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJECad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:30:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id g26-v6so9647508edp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yDbfYw7wkzpkAyib8N58NEJFyOf7ZQ8jMXKdqpVd+uU=;
        b=ZcsAxnSLm7gQ9Ke4y2v3FcD3yTmVi/eL3LfTqa3QlEKHEtF0CeOk5hmWAdi1hcAk2h
         jurWeGJYKf+z+yINBnTixWXPpAQiO3vExiBuCY8LjLHCA7wFtU0zf2aoLdJzq8CNzYfx
         OLrInffaxp1yCRULrHqjJy4X0z8jxTRA7NuDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yDbfYw7wkzpkAyib8N58NEJFyOf7ZQ8jMXKdqpVd+uU=;
        b=dXNxKiCWlh8mpbQ2dX/Cj29T3Jqf2rIkhC9jnv6Ph5tKgDgTgxr1hDLvq7VBDNi9Ml
         D3Cjidh0JlXRBFlhvWA6z3SlYFN9aXXl+H/WSFlkaJsEfy5ADizvnItUlM/NV/dmpgwQ
         dUoydcmr2v4nHxznCzRtss524P64VV6r2C1ppXslRbCc/RClxbYUZKdflKoN9sZTl1IK
         +U3ochsDTWzQ1SQUgTVwR6zDRhQod4G/6Lr+qD0B8gCXfNXAXLLLXDApzlBZp28jbl7I
         arxPPOaecRGcdPI4NkW4ERZZS2gbHX5EhwmnmpJ7gdYxOKPaQXestfbor5aqhbNOpMps
         K9Lw==
X-Gm-Message-State: ABuFfoh6KfB734fFhFvRxm0jZcEy2jJbYqLLplC3iLNGT5egiWtHX584
        EMK7ZPvbRTrpJn05tPIAlxYRgQ==
X-Google-Smtp-Source: ACcGV63ax9GhFWGGDYPOhHXAgGxfmWH9xAged+IlKP0NqixbsJP5uMyoxaQaNWqTL+v9EqAcPb4NXQ==
X-Received: by 2002:aa7:c458:: with SMTP id n24-v6mr10162000edr.55.1538681749276;
        Thu, 04 Oct 2018 12:35:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id ha9-v6sm1021789ejb.77.2018.10.04.12.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 12:35:45 -0700 (PDT)
Date:   Thu, 4 Oct 2018 21:35:43 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     noralf@tronnes.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>, tzimmermann@suse.de,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/imx: move 'legacyfb_depth' definition out of #ifdef
Message-ID: <20181004193543.GQ31561@phenom.ffwll.local>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>, noralf@tronnes.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>, tzimmermann@suse.de,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181002205836.2323084-1-arnd@arndb.de>
 <123f7e1c-8f2b-5797-de16-650ec01d0b24@tronnes.org>
 <20181003161326.GD31561@phenom.ffwll.local>
 <CAK8P3a1gKxXEthLvUxSxOrt6+1qzZE9Jba+vH_qFepv3KXba9g@mail.gmail.com>
 <CAKMK7uFn=u+04=HQvzkSNdE8_9p=3eX14-h=0nOJ7QKPJSrdmw@mail.gmail.com>
 <af5994a3-5739-ed7f-4374-85e9d19d2408@tronnes.org>
 <CAK8P3a1fzr9kX4kNcAnM4ZPh_-Kp61326zrbhDjHyPJJrJq=OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1fzr9kX4kNcAnM4ZPh_-Kp61326zrbhDjHyPJJrJq=OQ@mail.gmail.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 05:04:21PM +0200, Arnd Bergmann wrote:
> On Thu, Oct 4, 2018 at 4:43 PM Noralf Trønnes <noralf@tronnes.org> wrote:
> > Den 04.10.2018 09.48, skrev Daniel Vetter:
> > > On Wed, Oct 3, 2018 at 9:51 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >> On Wed, Oct 3, 2018 at 6:13 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >>> On Wed, Oct 03, 2018 at 05:49:32PM +0200, Noralf Trønnes wrote:
> > >>>>
> > >>>> Den 02.10.2018 22.58, skrev Arnd Bergmann:
> > >>>>> The variable is now referenced unconditionally, but still
> > >>>>> declared in an #ifdef:
> > >>>>>
> > >>>>> drivers/gpu/drm/imx/imx-drm-core.c: In function 'imx_drm_bind':
> > >>>>> drivers/gpu/drm/imx/imx-drm-core.c:264:6: error: 'legacyfb_depth' undeclared (first use in this function); did you mean 'lockdep_depth'?
> > >>>>>
> > >>>>> Remove the #ifdef so it can always be accessed.
> > >>>>>
> > >>>>> Fixes: f53705fd9803 ("drm/imx: Use drm_fbdev_generic_setup()")
> > >>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >>>>> ---
> > >>>> I've already applied the previous one you sent:
> > >>>> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=064b06bbf117f8b5e64a5143e970d5a1cf602fd6
> > >>>>
> > >>>> Not sure when it reaches linux-next now that we are past rc6.
> > >>> Only once we're past -rc1.
> > >> Can we revert f53705fd9803 in linux-next then to prevent the regression from
> > >> making it into 4.20?
> > > Probably simpler to cherry pick the fix from drm-misc-next to
> > > drm-misc-next-fixes. Noralf, can you pls do that?
> >
> > Would this be the correct procudure:
> >
> >      dim update-branches
> >      dim create-workdir drm-misc-next-fixes
> >      <build>
> >      CONFIG_DRM_FBDEV_EMULATION=n
> >      <build will break>
> >      git cherry-pick 064b06bbf117f8b5e64a5143e970d5a1cf602fd6
> >      <build passes>
> >      dim push-branch drm-misc-next-fixes
> >
> > I read that cherry picking creates a new commit with a new hash.
> > But since you ask me to do this, I assume git will handle this when
> > branches are merged?
> 
> The git history will show both commit IDs, which is a bit ugly but
> ok if it's rare enough. There is a chance for creating a conflict if the
> backport changes context, or one branch contains extra changes
> that touch the same lines, but usually this is not a problem.

+1, and your recipe looks good too. drm-intel works entirely on these
cherry-picks, and we've done it a few times in drm-misc too. Having to
cherry-pick is one of the downsides of group maintainership, since you
really can't rebase trees at will. Definitely not the -next queue.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
