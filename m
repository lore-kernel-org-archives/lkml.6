Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA91C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A949421A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="skapDPhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A949421A29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732808AbeHFVPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732394AbeHFVPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:15:46 -0400
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com [209.85.220.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A1E121A5D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Aug 2018 19:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533582317;
        bh=LSYwrDwf6K3+2HGSQ0Dc9tOBuAAWJEy4A5ViN/os+eQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=skapDPhEZxWKBykIGIgpjKZhFcQW0SYDtFZWUPSGAFgl+0bF3/0ZQeGrw7mdi9Lt4
         O2y1M9Ze18OufdOau3atswlz2omDRQmhqWioSuhoI1+D+7HYf0WGUivn1aexACs5MZ
         YQc9gD7x/kHFybUFXmUFpqPhT7m4DpiB1SIV1MsM=
Received: by mail-qk0-f169.google.com with SMTP id z74-v6so9692236qkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 12:05:17 -0700 (PDT)
X-Gm-Message-State: AOUpUlEYUO9JQ8Zshak/6ut7QU2bfB/vE9lWM3w58xC/b6T8SW1IN7ic
        ilF+MPtlLZEGh8ifK3SZdtPxC9ll0Jr7MaCvQQ==
X-Google-Smtp-Source: AAOMgpd+PQF3ROX7Yjs1jy69NqIgmULRqxfBE29DmRhn0qnG8R6lNmd2MCrOM3W2ctA5cdQo21i3yIQn2B9Tua3lMOA=
X-Received: by 2002:a37:ab14:: with SMTP id u20-v6mr14303409qke.120.1533582316717;
 Mon, 06 Aug 2018 12:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180724082213.25677-1-robert.foss@collabora.com>
 <f718f3ec-3726-3f51-6756-80b357fc23c9@flowbird.group> <CACvgo53h=8q-xuJBPP1T2JWkb7SffXas94=moS1x76=BejyVJA@mail.gmail.com>
 <c05f1d94-bf9e-cf9b-e575-dc220b9ca163@flowbird.group> <CACvgo50u--YAxwG-cEhgj5AagOcz9oyaX2YC52Gp6324c8mNEQ@mail.gmail.com>
 <20180803195025.GO20303@art_vandelay>
In-Reply-To: <20180803195025.GO20303@art_vandelay>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 6 Aug 2018 13:05:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJaciQ1297kT85c4EESFD=x-Se=fRxYcr3oZJ7xNaiGmg@mail.gmail.com>
Message-ID: <CAL_JsqJaciQ1297kT85c4EESFD=x-Se=fRxYcr3oZJ7xNaiGmg@mail.gmail.com>
Subject: Re: [RFC] drm: Allow DRM_IOCTL_MODE_MAP_DUMB for render nodes
To:     Sean Paul <seanpaul@chromium.org>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        martin.fuzzey@flowbird.group,
        Robert Foss <robert.foss@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Brian Paul <brianp@vmware.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        eric.engestrom@intel.com, Gustavo Padovan <gustavo@padovan.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        norvez@chromium.org, Tomasz Figa <tfiga@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 1:50 PM Sean Paul <seanpaul@chromium.org> wrote:
>
> On Fri, Aug 03, 2018 at 06:03:50PM +0100, Emil Velikov wrote:
> > On 3 August 2018 at 16:06, Martin Fuzzey <martin.fuzzey@flowbird.group> wrote:
> > > Hi Emil,
> > >
> > > On 03/08/18 14:35, Emil Velikov wrote:
> > >>
> > >> Hi Martin,
> > >>
> > >> On 1 August 2018 at 15:24, Martin Fuzzey <martin.fuzzey@flowbird.group>
> > >> wrote:
> > >>
> > >> Let's start with the not-so obvious question:
> > >> Why does one open the imx as render node?
> > >>
> > >> Of the top of my head:
> > >> There is nothing in egl/android that should require an authenticated
> > >> device.
> > >> Hence, using a card node should be fine - the etnaviv code opens the
> > >> render node it needs.
> > >
> > >
> > > Yes, the problem is not in egl/android but in the scanout buffer allocation
> > > code.
> > >
> > > etnaviv opens the render node on the *GPU* (for submitting GPU commands),
> > > that part is fine.
> > >
> > > But scanout buffers need to be allocated from imx-drm not etnaviv.
> > >
> > > This done by renderonly_create_kms_dumb_buffer_for_resource()
> > > [src/gallium/auxiliary/renderonly/renderonly.c]
> > > Which uses DRM_IOCTL_MODE_CREATE_DUMB followed by
> > > DRM_IOCTL_PRIME_FD_TO_HANDLE
> > > on the "kms_fd" (probably poorly named because it's not actually used for
> > > modesetting)
> > > see imx_drm_screen_create()[ src/gallium/winsys/imx/drm/imx_drm_winsys.c]
> > >
> > >
> > > If the card node is used DRM_IOCTL_MODE_CREATE_DUMB works but
> > > DRM_IOCTL_PRIME_FD_TO_HANDLE fails, because the permissions are
> > > DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW
> > >
> > Right I missed the DRM_AUTH, in the fd <> handle IOCTLs.
> > So in order for things to work, we'd need to either:
> >  - allow dumb buffers for render nodes, or
> >  - drop the DRM_AUTH for fd <> handle imports
> >
> > Pointing an alternative solution, for kernel developers to analyse and
> > make a decision.
> >
> > >
> > > In android 8.1 the hardware composer runs in a seperate process and it has
> > > to use the card node and be drm master (to use the KMS API),
> > > therefore, when the surface flinger calls
> > > renderonly_create_kms_dumb_buffer_for_resource() it is not authenticated.
> > >
> > > Making surface flinger use a render node fixes the problem for
> > > DRM_IOCTL_PRIME_FD_TO_HANDLE (because that already has DRM_RENDER_ALLOW),
> > > but DRM_IOCTL_MODE_CREATE_DUMB now fails without the patch.
> > >
> > >
> > > This probably worked in previous versions of Android where surface flinger
> > > and hwc were all in the same process.
> > >
> > There has been varying hacks for Android through the years. Bringing
> > details into the discussion will result in a significant diversion.
> > Something we could avoid, for the time being ;-)
>
> Did someone say diversion?!? The way this was handled prior to using
> render/control nodes in drm_hwc/[drm/gbm]_gralloc is that all modesetting was
> done via gralloc which was master. The hwc implementation was basically a proxy
> backchanneling all of the work to gralloc.
>
> Anyways, we probably don't want to go back there.
>
> Fwiw, I'd lean towards allowing DUMB allocation from the render nodes. I
> understand it limits use cases that are undesirable, but it is also limiting
> usecases that are desirable. So, given that people are going to get "creative"
> regardless of how many safety railings we put up, we shouldn't make things
> unnecessarily hard on other trying to Get Work Done.

The problem with using render nodes is what if there isn't one? We
require VGEM (and make VGEM allow dumb buffers) in that case?

Rob
