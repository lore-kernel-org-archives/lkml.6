Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6C1C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E208420672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Eju2Hm1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E208420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeLMJBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:01:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41680 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeLMJBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:01:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id z28so1353508edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=k7jqSXyl0epgeHm/GfYZ/+xxR1QJOuX/FLgwINC/CiI=;
        b=Eju2Hm1yj+4LzrDcB6SKWZzVEnXZdz+3ITMDFWgKn/FGzuyfzxH2t8ZZUsTkLw5hMr
         5LTzU/XQ5HJNGrh6JdxdGFQxymVZfpleERxefwBm7b50msXS0EMQ5EQ/cpvQF8Pa4ucN
         6jr7rV4yVlXniqyVlXC8oeR2lqzsD3fMFC2Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=k7jqSXyl0epgeHm/GfYZ/+xxR1QJOuX/FLgwINC/CiI=;
        b=pI8LQW9r7kplv6w7kkUB42RQ/TcIM+mfdSzUhJPQn5shU5Bc8BLePC1jC5uYpHcSE2
         AjOBVQ/Y1IncDPk2l2kZZTeFWpf6cQV75KOmDfu1P/nlldLNmNKztoZA+NGEl7xqxxsv
         9tEKDs1rvGnVm5gmXXAuSJP5P+ErmPPWqFcOB9vgsxkR139mBhrAzYPd3ESjt2OzvDZ6
         KOcZL4zB/y5i3BJFIKr3qTqP4+S34BocisOz49Avu1hL+dqeRCixlOZDrQ/8PuhCstv9
         e5wCCpIkHRlJ2KNKfGAAf36GEtkVLlUIEko/XxYwN87keSWrGl/z5+pqJJ8Qy3p5owZ6
         fLNQ==
X-Gm-Message-State: AA+aEWbG1drPhCcHuQZchIVxvtV8nHlgHWToJ6I19iLeinSsd4IKOj20
        936XbdlCRUEMkM0EQEPEjvpnpeNILYQ=
X-Google-Smtp-Source: AFSGD/UKXlzdyyj3GyRSUT9JQydk2w2NBEcjTL0ewk/Jki53PQ3nGWMhisZHhWprxcK8bYdF2RymCw==
X-Received: by 2002:a17:906:6216:: with SMTP id s22-v6mr17231521ejk.18.1544691691609;
        Thu, 13 Dec 2018 01:01:31 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e26-v6sm231849ejb.29.2018.12.13.01.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 01:01:30 -0800 (PST)
Date:   Thu, 13 Dec 2018 10:01:28 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     helen.koike@collabora.com, dnicoara@chromium.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH v2] drm/atomic: add ATOMIC_AMEND flag to the Atomic IOCTL.
Message-ID: <20181213090128.GB21184@phenom.ffwll.local>
Mail-Followup-To: Tomasz Figa <tfiga@chromium.org>,
        helen.koike@collabora.com, dnicoara@chromium.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
References: <20181123215354.14540-1-helen.koike@collabora.com>
 <CAAFQd5BHPjode=KqEHs=eNqqCe-xvsqx1ko9hQn29djFxuSWUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5BHPjode=KqEHs=eNqqCe-xvsqx1ko9hQn29djFxuSWUA@mail.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 04:43:57PM +0900, Tomasz Figa wrote:
> Hi Helen,
> 
> On Sat, Nov 24, 2018 at 6:54 AM Helen Koike <helen.koike@collabora.com> wrote:
> >
> > This flag tells core to jump ahead the queued update if the conditions
> > in drm_atomic_async_check() are met. That means we are only able to do an
> > async update if no modeset is pending and update for the same plane is
> > not queued.
> 
> First of all, thanks for the patch. Please see my comments below.
> 
> If the description above applies (and AFAICT that's what the existing
> code does indeed), then this doesn't sound like "amend" to me. It
> sounds exactly as the kernel code calls it - "async update" or perhaps
> "instantaneous commit" could better describe it?
> 
> >
> > It uses the already in place infrastructure for async updates.
> >
> > It is useful for cursor updates and async PageFlips over the atomic
> > ioctl, otherwise in some cases updates may be delayed to the point the
> > user will notice it. Note that for now it's only enabled for cursor
> > planes.
> >
> > DRM_MODE_ATOMIC_AMEND should be passed to the Atomic IOCTL to use this
> > feature.
> >
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > [updated for upstream]
> > Signed-off-by: Helen Koike <helen.koike@collabora.com>
> > ---
> > Hi,
> >
> > This is the second attempt to introduce the new ATOMIC_AMEND flag for atomic
> > operations, see the commit message for a more detailed description.
> >
> > This was tested using a small program that exercises the uAPI for easy
> > sanity testing. The program was created by Alexandros and modified by
> > Enric to test the capability flag [2].
> >
> > To test, just build the program and use the --atomic flag to use the cursor
> > plane with the ATOMIC_AMEND flag. E.g.
> >
> >   drm_cursor --atomic
> >
> > The test worked on a rockchip Ficus v1.1 board on top of mainline plus
> > the patch to update cursors asynchronously through atomic for the
> > drm/rockchip driver plus the DRM_CAP_ASYNC_UPDATE patch.
> >
> > Alexandros also did a proof-of-concept to use this flag and draw cursors
> > using atomic if possible on ozone [1].
> >
> > Thanks
> > Helen
> >
> > [1] https://chromium-review.googlesource.com/c/chromium/src/+/1092711
> > [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/async-capability
> >
> >
> > Changes in v2:
> > - rebase tree
> > - do not fall back to a non-async update if if there isn't any
> > pending commit to amend
> >
> > Changes in v1:
> > - https://patchwork.freedesktop.org/patch/243088/
> > - Only enable it if userspace requests it.
> > - Only allow async update for cursor type planes.
> > - Rename ASYNC_UPDATE for ATOMIC_AMEND.
> >
> >  drivers/gpu/drm/drm_atomic_helper.c | 6 +++++-
> >  drivers/gpu/drm/drm_atomic_uapi.c   | 6 ++++++
> >  include/uapi/drm/drm_mode.h         | 4 +++-
> >  3 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 269f1a74de38..333190c6a0a4 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -934,7 +934,7 @@ int drm_atomic_helper_check(struct drm_device *dev,
> >         if (ret)
> >                 return ret;
> >
> > -       if (state->legacy_cursor_update)
> > +       if (state->async_update || state->legacy_cursor_update)
> >                 state->async_update = !drm_atomic_helper_async_check(dev, state);
> >
> >         return ret;
> > @@ -1602,6 +1602,10 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
> >         if (new_plane_state->fence)
> >                 return -EINVAL;
> >
> > +       /* Only allow async update for cursor type planes. */
> > +       if (plane->type != DRM_PLANE_TYPE_CURSOR)
> > +               return -EINVAL;
> > +
> 
> So the existing upstream code already allowed this for any planes and
> we're restricting this to cursor planes only. Is this expected? No
> potential users that already started using this for other plane types?

The backend supports it for anything right now (if the driver implements
it, that is). We do expose it through the legacy cursor api, and the
legacy page_flip api, but not through atomic itself. It also has the
problem that the not all drivers who support the async legacy cursor mode
in atomic use this new infrastructure, so there's a few problems. Plus
semantics are very ill-defined (we'd definitely need igt testcases for
this stuff, especially all the new combinations with events, fences, ...).

I think what we'd need here to make sure we're not digging an uapi hole:

1. Entirely remove the legacy_cursor_update hack. There's some patches
floating around, but would need to be polished.

2. Make sure all drivers supporting legacy async cursor updates do through
the async_plane update infrastructure.

3. Get the async plane update stuff merged for amdgpu. Iirc that's still
stuck somewhere (but I'm not 100% sure what exactly they're doing).

4. Pile of igt testcases for all the new corner cases exposing this in
atomic opens up. Many cases we might want to simply reject it.

5. Userspace. Big one I have is whether we need a flag like ALLOW_MODESET,
since the current code transparently falls back to vblank-synced updates
if async updates aren't available.

tldr; lots of work. Also maybe:

0. Dump this todo into Documentation/gpu/todo.rst so it won't get lost.

Cheers, Daniel


> 
> Best regards,
> Tomasz
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
