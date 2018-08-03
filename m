Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CB4C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA032178D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mGzO3pMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA032178D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbeHCVsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:48:10 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39260 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeHCVsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:48:09 -0400
Received: by mail-yw1-f66.google.com with SMTP id r184-v6so1404335ywg.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/8eorP3SBVJgegrat/pBBkRyKnsxwNw2tVlTziNUwzA=;
        b=mGzO3pMriJtX+H4GhrFGf9l6KbVr6v4UcbosbBele8EsBgNBb/TpYoE5iQlzM2wBde
         +CIUSZxCPyQ8yBhCrRgHDuwqrZlI+oUlQKf/3n0d15JcoWB8JjjbvKKgn6aXdomGt6+X
         3H5kffqe4XBd8RUS/oRhKRwKOrMIfaljwqev4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/8eorP3SBVJgegrat/pBBkRyKnsxwNw2tVlTziNUwzA=;
        b=UwHoDzi+q/ejI5dFLg9eX6J18HZG5dtPBzLTJqtMTpcs5o0tFPR1uGi4a0g/0zaRM7
         hlGpfqgNQWP1xXJxfU/1m1NB6VrOtwiT4JqyKT6tOKTAvyy1jYz0hYxkyGFgK/9TLcy7
         4/4yB5MyYJSXw/JbD0EAkOJBSYqJOwSnY/9rbjdcPmJnBra+yrlShauKDbNohlFjr1g7
         j2wmmrrkk79RCLHetVf1Dvaf71qLw9USouFXQrsyehoPK8GHKbb0vbWoYLlfNnGTWE82
         Suuh9QzjlsITPTh6UO8qh5TsIV9ggdkuP/5wumXzn9ZKTX2uufjtx8rlFE4Ux50MKqgU
         Psdw==
X-Gm-Message-State: AOUpUlHzKfYTrwIeY2X2M1z8lcwJsApLO4wA1aUmQ44yOHN0Z7zK0956
        h6s9/pi5YJNYEf1VU14KZiW5xA==
X-Google-Smtp-Source: AAOMgpctwxkGGnbBivsMaKRgMt4XDVZlWUoOaHsvTYuMPpM0OUFR4Pl7k7IyOWMmAzgi9z4k7Vc9jg==
X-Received: by 2002:a0d:e044:: with SMTP id j65-v6mr841699ywe.202.1533325826432;
        Fri, 03 Aug 2018 12:50:26 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id r3-v6sm3547016ywr.80.2018.08.03.12.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 12:50:25 -0700 (PDT)
Date:   Fri, 3 Aug 2018 15:50:25 -0400
From:   Sean Paul <seanpaul@chromium.org>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Martin Fuzzey <martin.fuzzey@flowbird.group>,
        Robert Foss <robert.foss@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Brian Paul <brianp@vmware.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Eric Engestrom <eric.engestrom@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Nicolas Norvez <norvez@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [RFC] drm: Allow DRM_IOCTL_MODE_MAP_DUMB for render nodes
Message-ID: <20180803195025.GO20303@art_vandelay>
References: <20180724082213.25677-1-robert.foss@collabora.com>
 <f718f3ec-3726-3f51-6756-80b357fc23c9@flowbird.group>
 <CACvgo53h=8q-xuJBPP1T2JWkb7SffXas94=moS1x76=BejyVJA@mail.gmail.com>
 <c05f1d94-bf9e-cf9b-e575-dc220b9ca163@flowbird.group>
 <CACvgo50u--YAxwG-cEhgj5AagOcz9oyaX2YC52Gp6324c8mNEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACvgo50u--YAxwG-cEhgj5AagOcz9oyaX2YC52Gp6324c8mNEQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 06:03:50PM +0100, Emil Velikov wrote:
> On 3 August 2018 at 16:06, Martin Fuzzey <martin.fuzzey@flowbird.group> wrote:
> > Hi Emil,
> >
> > On 03/08/18 14:35, Emil Velikov wrote:
> >>
> >> Hi Martin,
> >>
> >> On 1 August 2018 at 15:24, Martin Fuzzey <martin.fuzzey@flowbird.group>
> >> wrote:
> >>
> >> Let's start with the not-so obvious question:
> >> Why does one open the imx as render node?
> >>
> >> Of the top of my head:
> >> There is nothing in egl/android that should require an authenticated
> >> device.
> >> Hence, using a card node should be fine - the etnaviv code opens the
> >> render node it needs.
> >
> >
> > Yes, the problem is not in egl/android but in the scanout buffer allocation
> > code.
> >
> > etnaviv opens the render node on the *GPU* (for submitting GPU commands),
> > that part is fine.
> >
> > But scanout buffers need to be allocated from imx-drm not etnaviv.
> >
> > This done by renderonly_create_kms_dumb_buffer_for_resource()
> > [src/gallium/auxiliary/renderonly/renderonly.c]
> > Which uses DRM_IOCTL_MODE_CREATE_DUMB followed by
> > DRM_IOCTL_PRIME_FD_TO_HANDLE
> > on the "kms_fd" (probably poorly named because it's not actually used for
> > modesetting)
> > see imx_drm_screen_create()[ src/gallium/winsys/imx/drm/imx_drm_winsys.c]
> >
> >
> > If the card node is used DRM_IOCTL_MODE_CREATE_DUMB works but
> > DRM_IOCTL_PRIME_FD_TO_HANDLE fails, because the permissions are
> > DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW
> >
> Right I missed the DRM_AUTH, in the fd <> handle IOCTLs.
> So in order for things to work, we'd need to either:
>  - allow dumb buffers for render nodes, or
>  - drop the DRM_AUTH for fd <> handle imports
> 
> Pointing an alternative solution, for kernel developers to analyse and
> make a decision.
> 
> >
> > In android 8.1 the hardware composer runs in a seperate process and it has
> > to use the card node and be drm master (to use the KMS API),
> > therefore, when the surface flinger calls
> > renderonly_create_kms_dumb_buffer_for_resource() it is not authenticated.
> >
> > Making surface flinger use a render node fixes the problem for
> > DRM_IOCTL_PRIME_FD_TO_HANDLE (because that already has DRM_RENDER_ALLOW),
> > but DRM_IOCTL_MODE_CREATE_DUMB now fails without the patch.
> >
> >
> > This probably worked in previous versions of Android where surface flinger
> > and hwc were all in the same process.
> >
> There has been varying hacks for Android through the years. Bringing
> details into the discussion will result in a significant diversion.
> Something we could avoid, for the time being ;-)

Did someone say diversion?!? The way this was handled prior to using
render/control nodes in drm_hwc/[drm/gbm]_gralloc is that all modesetting was
done via gralloc which was master. The hwc implementation was basically a proxy
backchanneling all of the work to gralloc. 

Anyways, we probably don't want to go back there.

Fwiw, I'd lean towards allowing DUMB allocation from the render nodes. I
understand it limits use cases that are undesirable, but it is also limiting
usecases that are desirable. So, given that people are going to get "creative"
regardless of how many safety railings we put up, we shouldn't make things
unnecessarily hard on other trying to Get Work Done.

Sean

[Disclaimer: I'm totally and completely biased on this issue]


> 
> Thanks
> Emil

-- 
Sean Paul, Software Engineer, Google / Chromium OS
