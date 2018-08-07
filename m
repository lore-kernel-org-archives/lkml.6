Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430BDC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D5721884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="juiKmwqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D5721884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbeHGOmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:42:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45724 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389077AbeHGOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:42:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id s16-v6so6814333edq.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TfLyyM4JSyMqFAXogxmvNIdKkbaHaoV/MhekAmxiXx0=;
        b=juiKmwqyBqjdO0gGcIPhFNx46jeU5qk3pyl4X9vOlz3Y3WPsn93uIL4YilZr+pb86Y
         lgJAnO2OJQZTvl//FG7sQjJc0d9PWQSxx3bnF6XlepkSRjffqp3CZDL4scLHOLaOhyFf
         yDEZSp1LbNE27fUtQIZ+N/jlpcLvaHTIS1Dd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TfLyyM4JSyMqFAXogxmvNIdKkbaHaoV/MhekAmxiXx0=;
        b=S8ai8bOuBBFSWCp2A9RFfnj97YBXULXO/eQ2XZQyR+64XMgPbbweqbfcW83El8spoR
         Cwn8jVULvATWg3jo3Enl0dJZGz4ffDBXwMb5Q2MB3VPJKZXXz7dHAPD0w3vpTZtDkquT
         cR8y7FNIK91HTd7O1hkJr0D0dG6hBWrD3UWCqcsx78T4ejsZj/ytMHtfEq1Jj62ysfta
         c8haS0zOH0kzp+GdUGbt3Q83o6gSkZObbkekr4tNriWgm5bUtz14ljscMtNyzpuBo0hx
         az9NR7KozEi5BsRbUTWytZnRaUpDUDksy1fihkVW43h7abz3nGrsgr8jtxY1T6zuS+nR
         6tmQ==
X-Gm-Message-State: AOUpUlFqQAn02LVrPlaYwc6rGsIPLfTZoh4CjhW0ZuNqwJ17VH505bAS
        lYlaGdDjvfTOoCCTdtP4vIz8pg==
X-Google-Smtp-Source: AAOMgpet3ycqHykCCnkb2I3ooKUAB8UFoCDk1AR2wgn7oos1oWOBFEk2uRn1cfurt+MRcBMNNgp05g==
X-Received: by 2002:a50:fb91:: with SMTP id e17-v6mr23236474edq.308.1533644909737;
        Tue, 07 Aug 2018 05:28:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:56fc:0:d707:d7d8:b180:96e5])
        by smtp.gmail.com with ESMTPSA id g9-v6sm625868edq.34.2018.08.07.05.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 05:28:28 -0700 (PDT)
Date:   Tue, 7 Aug 2018 14:28:26 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Nicolas Norvez <norvez@chromium.org>,
        Robert Foss <robert.foss@collabora.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Eric Engestrom <eric.engestrom@intel.com>,
        David Airlie <airlied@linux.ie>,
        Brian Paul <brianp@vmware.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: Re: [RFC] drm: Allow DRM_IOCTL_MODE_MAP_DUMB for render nodes
Message-ID: <20180807122826.GU3008@phenom.ffwll.local>
Mail-Followup-To: Emil Velikov <emil.l.velikov@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Nicolas Norvez <norvez@chromium.org>,
        Robert Foss <robert.foss@collabora.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Eric Engestrom <eric.engestrom@intel.com>,
        David Airlie <airlied@linux.ie>, Brian Paul <brianp@vmware.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
References: <20180724082213.25677-1-robert.foss@collabora.com>
 <f718f3ec-3726-3f51-6756-80b357fc23c9@flowbird.group>
 <CACvgo53h=8q-xuJBPP1T2JWkb7SffXas94=moS1x76=BejyVJA@mail.gmail.com>
 <c05f1d94-bf9e-cf9b-e575-dc220b9ca163@flowbird.group>
 <CACvgo50u--YAxwG-cEhgj5AagOcz9oyaX2YC52Gp6324c8mNEQ@mail.gmail.com>
 <20180803195025.GO20303@art_vandelay>
 <CACvgo50Pk_FduWG5nev0W1pxqNfg3uMo0-7TuDPAckcBv=cHhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACvgo50Pk_FduWG5nev0W1pxqNfg3uMo0-7TuDPAckcBv=cHhA@mail.gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 12:01:50PM +0100, Emil Velikov wrote:
> On 3 August 2018 at 20:50, Sean Paul <seanpaul@chromium.org> wrote:
> > On Fri, Aug 03, 2018 at 06:03:50PM +0100, Emil Velikov wrote:
> >> On 3 August 2018 at 16:06, Martin Fuzzey <martin.fuzzey@flowbird.group> wrote:
> >> > Hi Emil,
> >> >
> >> > On 03/08/18 14:35, Emil Velikov wrote:
> >> >>
> >> >> Hi Martin,
> >> >>
> >> >> On 1 August 2018 at 15:24, Martin Fuzzey <martin.fuzzey@flowbird.group>
> >> >> wrote:
> >> >>
> >> >> Let's start with the not-so obvious question:
> >> >> Why does one open the imx as render node?
> >> >>
> >> >> Of the top of my head:
> >> >> There is nothing in egl/android that should require an authenticated
> >> >> device.
> >> >> Hence, using a card node should be fine - the etnaviv code opens the
> >> >> render node it needs.
> >> >
> >> >
> >> > Yes, the problem is not in egl/android but in the scanout buffer allocation
> >> > code.
> >> >
> >> > etnaviv opens the render node on the *GPU* (for submitting GPU commands),
> >> > that part is fine.
> >> >
> >> > But scanout buffers need to be allocated from imx-drm not etnaviv.
> >> >
> >> > This done by renderonly_create_kms_dumb_buffer_for_resource()
> >> > [src/gallium/auxiliary/renderonly/renderonly.c]
> >> > Which uses DRM_IOCTL_MODE_CREATE_DUMB followed by
> >> > DRM_IOCTL_PRIME_FD_TO_HANDLE
> >> > on the "kms_fd" (probably poorly named because it's not actually used for
> >> > modesetting)
> >> > see imx_drm_screen_create()[ src/gallium/winsys/imx/drm/imx_drm_winsys.c]
> >> >
> >> >
> >> > If the card node is used DRM_IOCTL_MODE_CREATE_DUMB works but
> >> > DRM_IOCTL_PRIME_FD_TO_HANDLE fails, because the permissions are
> >> > DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW
> >> >
> >> Right I missed the DRM_AUTH, in the fd <> handle IOCTLs.
> >> So in order for things to work, we'd need to either:
> >>  - allow dumb buffers for render nodes, or
> >>  - drop the DRM_AUTH for fd <> handle imports
> >>
> >> Pointing an alternative solution, for kernel developers to analyse and
> >> make a decision.
> >>
> >> >
> >> > In android 8.1 the hardware composer runs in a seperate process and it has
> >> > to use the card node and be drm master (to use the KMS API),
> >> > therefore, when the surface flinger calls
> >> > renderonly_create_kms_dumb_buffer_for_resource() it is not authenticated.
> >> >
> >> > Making surface flinger use a render node fixes the problem for
> >> > DRM_IOCTL_PRIME_FD_TO_HANDLE (because that already has DRM_RENDER_ALLOW),
> >> > but DRM_IOCTL_MODE_CREATE_DUMB now fails without the patch.
> >> >
> >> >
> >> > This probably worked in previous versions of Android where surface flinger
> >> > and hwc were all in the same process.
> >> >
> >> There has been varying hacks for Android through the years. Bringing
> >> details into the discussion will result in a significant diversion.
> >> Something we could avoid, for the time being ;-)
> >
> > Did someone say diversion?!? The way this was handled prior to using
> > render/control nodes in drm_hwc/[drm/gbm]_gralloc is that all modesetting was
> > done via gralloc which was master. The hwc implementation was basically a proxy
> > backchanneling all of the work to gralloc.
> >
> > Anyways, we probably don't want to go back there.
> >
> Now that we got the diversion out of the way, any input on my proposal
> to drop the DRM_AUTH for fd <> imports.
> Am I missing something pretty obvious that makes the idea a no-go?

Dropping DRM_AUTH is only relevant for the card node. And a card node
might not be sufficiently isolated against concurrent other clients, which
is why we don't allow it.

What we could do is essentially check whether your driver supports render
nodes (indicating sufficient amounts of separation), and then allow
anything for unauthenicated clients if DRM_RENDER_ALLOW is set on the
ioctl.

But that's just reinventing render nodes on top of legacy card nodes, and
I'm not clear on what that exactly gains us.

I think the proposal for dumb render nodes (for drivers which only do dumb
kms buffers and no rendering at all) that's been discusson on irc a bit
makes a lot more sense.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
