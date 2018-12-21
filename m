Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4657AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED205218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Rhbr70Jy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403767AbeLUNmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:42:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32771 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390631AbeLUNmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:42:36 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so4726676eds.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 05:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=adAhgycUHNcX6/W1mLmmQebe7QFLxZ14+DeaE0A1acg=;
        b=Rhbr70JyJhHooM2t0s6n9os/o0L0QFB3wWCabWrIjJgslE9H52eG6Rwfez431oRihu
         u4VxLp0aCnvBAqgthsQkZyIFrX6ZCW35T+aL8wnT2MJ7zglx1QiRuA6WpAOoeigs5T47
         wQRHjwSwvcAVNXQ7l5a2X4T59FcJUlzdFWIMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=adAhgycUHNcX6/W1mLmmQebe7QFLxZ14+DeaE0A1acg=;
        b=nfvGb/HU9rHoKyX/hcBUR9KbCHsKaOmEqcncjmWBh9Viu1p66snLt4sTnYpHjEOP/Q
         CfhZAoOPb61LWWT4kgl/DID3BkeM6uhfsgtXgCw01pdiKHNpRxYu67BRPbEgUCxyzMCX
         Ii9Bvw1BeA3q3uTHu8IesjBxbbb6GBeXYYyz6ijgDxU7zPxdXkVtGK0jhhd5OjKsBY6f
         1Y2UfvEvVkFo9HY8T+KVMjPXGHsQKHyePlxiJunIqLRge5a09ED3/orKf+ipza4bFQQA
         MU90m0svjgWSblhGzC17oonHXAmSMVfmQgmdL6Tmgub1lNgcI/mjDu0arkrVGkl6RH4X
         +kGw==
X-Gm-Message-State: AA+aEWZ/e5Zlcp8RN4uE4D1JI3d5L+iowVX0TBQ+4UkOWybPFfRjYkAl
        WLbVLczf1oSViTb1l6AUUuUrOA==
X-Google-Smtp-Source: AFSGD/WhdPk780WNBymd7QUnYcreMGwPYbOL6FLAHFCpGB5UyJ3bDGkuVFyNYout/VwoZr3ItTrEhg==
X-Received: by 2002:a17:906:3548:: with SMTP id s8-v6mr2123933eja.161.1545399753726;
        Fri, 21 Dec 2018 05:42:33 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f20sm6795895edf.19.2018.12.21.05.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 05:42:32 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:42:30 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        dnicoara@chromium.org, Sean Paul <seanpaul@google.com>,
        dcastagna@chromium.org, helen.koike@collabora.com,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
Message-ID: <20181221134230.GS21184@phenom.ffwll.local>
Mail-Followup-To: Tomasz Figa <tfiga@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        dnicoara@chromium.org, Sean Paul <seanpaul@google.com>,
        dcastagna@chromium.org, helen.koike@collabora.com,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
References: <20181123215326.14274-1-helen.koike@collabora.com>
 <20181127133418.GT9144@intel.com>
 <6aa39654-6949-88b3-b949-b338d915ffd2@collabora.com>
 <CAAFQd5BczTNdwUNcx42hC=OKkgZTV9JevHetYOjfDCnEz29LpA@mail.gmail.com>
 <0a0a35bf-69e4-8dcd-46fc-7053081480d5@collabora.com>
 <CAAFQd5C15yF4TwOLu4JsFGMSzLp8isV89WOZyRfv9wCcGfFRtg@mail.gmail.com>
 <CAKMK7uG=vdaTo25b3gSaD4T2naA51VeaVL0+5YAJ9HMrBziTWQ@mail.gmail.com>
 <CAAFQd5Aj=UZXqB+M=5+7N8RvT=aoSombHLf203yb7XM-UQhoQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFQd5Aj=UZXqB+M=5+7N8RvT=aoSombHLf203yb7XM-UQhoQQ@mail.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 12:51:05PM +0900, Tomasz Figa wrote:
> On Thu, Dec 20, 2018 at 7:47 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Dec 20, 2018 at 10:07 AM Tomasz Figa <tfiga@chromium.org> wrote:
> > >
> > > Hi Helen,
> > >
> > > On Fri, Dec 14, 2018 at 10:35 AM Helen Koike <helen.koike@collabora.com> wrote:
> > > >
> > > > Hi Tomasz,
> > > >
> > > > On 12/13/18 2:02 AM, Tomasz Figa wrote:
> > > > > On Thu, Dec 6, 2018 at 1:12 AM Helen Koike <helen.koike@collabora.com> wrote:
> > > > >>
> > > > >> Hi Ville
> > > > >>
> > > > >> On 11/27/18 11:34 AM, Ville Syrjälä wrote:
> > > > >>> On Fri, Nov 23, 2018 at 07:53:26PM -0200, Helen Koike wrote:
> > > > >>>> Allow userspace to identify if the driver supports async update.
> > > > >>>
> > > > >>> And what exactly is an "async update"?
> > > > >>
> > > > >> I agree we are lacking docs on this, I'll send in the next version as
> > > > >> soon as we agree on a name (please see below).
> > > > >>
> > > > >> For reference:
> > > > >> https://lists.freedesktop.org/archives/dri-devel/2017-April/138586.html
> > > > >>
> > > > >>>
> > > > >>> I keep asking people to come up with the a better name for this, and to
> > > > >>> document what it actually means. Recently I've been think we should
> > > > >>> maybe just adopt the vulkan terminology (immediate/fifo/mailbox) to
> > > > >>> avoid introducing yet another set of names for the same thing. We'd
> > > > >>> still want to document things properly though.
> > > > >>
> > > > >> Another name it was suggested was "atomic amend", this feature basically
> > > > >> allows userspace to complement an update previously sent (i.e. its in
> > > > >> the queue and wasn't commited yet), it allows adding a plane update to
> > > > >> the next commit. So what do you think in renaming it to "atomic amend"?
> > > > >
> > > > > Note that it doesn't seem to be what the code currently is doing. For
> > > > > example, for cursor updates, it doesn't seem to be working on the
> > > > > currently pending commit, but just directly issues an atomic async
> > > > > update call to the planes. The code actually seems to fall back to a
> > > > > normal sync commit, if there is an already pending commit touching the
> > > > > same plane or including a modeset.
> > > >
> > > > It should fail as discussed at:
> > > > https://patchwork.freedesktop.org/patch/243088/
> > > >
> > > > There was the following code inside the drm_atomic_helper_async_check()
> > > > in the previous patch which would fallback to a normal commit if there
> > > > isn't any pending commit to amend:
> > > >
> > > > +       if (!old_plane_state->commit)
> > > > +               return -EINVAL;
> > > >
> > > > In the v2 of the patch https://patchwork.freedesktop.org/patch/263712/
> > > > this got removed, but which means that async update will be enabled
> > > > anyway. So the following code is wrong:
> > > >
> > > > -       if (state->legacy_cursor_update)
> > > > +       if (state->async_update || state->legacy_cursor_update)
> > > >                 state->async_update = !drm_atomic_helper_async_check(dev, state);
> > > >
> > > > Does it make sense? If yes I'll fix this in the next version of the
> > > > Atomic IOCTL patch (and also those two patches should be in the same
> > > > series, I'll send them together next time).
> > > >
> > > > Thanks for pointing this out.
> > > >
> > > > Please let me know if you still don't agree on the name "atomic amend",
> > > > or if I am missing something.
> > >
> > > I'll defer it to the DRM maintainers. From Chrome OS perspective, we
> > > need a way to commit the cursor plane asynchronously from other
> > > commits any time the cursor changes its position or framebuffer. As
> > > long as the new API allows that and the maintainers are fine with it,
> > > I think I should be okay with it too.
> >
> > If this is just about the cursor, why is the current legacy cursor
> > ioctl not good enough? It's 2 ioctls instead of one, but I'm not sure
> > if we want to support having a normal atomic commit and a cursor
> > update in the same atomic ioctl, coming up with reasonable semantics
> > for that will be complicated.
> >
> > Pointer to code that uses this would be better ofc.
> 
> Sorry, let me clarify that I was mostly referring to the respective
> kernel functionality here, not the userspace extension.
> 
> As far as I know, Chromium still uses the legacy cursor ioctls and we
> have our drivers implement them directly, bypassing the atomic commit
> mechanism. However, it sounds like this async commit could let us
> remove the custom implementations from the drivers and have a common
> helper for it, which would be a good step forward.

Yup, that was at least the motivation for merging it. Unfortunately that
upstream effort got stalled, and there's still a few custom
implementations, and not many drivers using the async plane update stuff
yet.

> Daniel, Daniele, Sean, Stephane, could you clarify what are our needs
> for this userspace interface?

At xdc17 we also discussed that something like this could be useful for
overlay planes (for e.g. video), to avoid video stuttering when the main
compositor is having a hard time. But I have no idea whether that idea
went anywhere.
-Daniel

> 
> > -Daniel
> >
> > > Best regards,
> > > Tomasz
> > >
> > > >
> > > > Helen
> > > >
> > > > >
> > > > > Best regards,
> > > > > Tomasz
> > > > >
> > > > >> Or do you suggest another name? I am not familiar with vulkan terminology.
> > > > >>
> > > > >>
> > > > >> Thanks
> > > > >> Helen
> > > > >>
> > > > >>>
> > > > >>>>
> > > > >>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > >>>> [prepared for upstream]
> > > > >>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> > > > >>>>
> > > > >>>> ---
> > > > >>>> Hi,
> > > > >>>>
> > > > >>>> This patch introduces the ASYNC_UPDATE cap, which originated from the
> > > > >>>> discussion regarding DRM_MODE_ATOMIC_AMEND on [1], to allow user to
> > > > >>>> figure that async_update exists.
> > > > >>>>
> > > > >>>> This was tested using a small program that exercises the uAPI for easy
> > > > >>>> sanity testing. The program was created by Alexandros and modified by
> > > > >>>> Enric to test the capability flag [2].
> > > > >>>>
> > > > >>>> The test worked on a rockchip Ficus v1.1 board on top of mainline plus
> > > > >>>> the patch to update cursors asynchronously through atomic plus the patch
> > > > >>>> that introduces the ATOMIC_AMEND flag for the drm/rockchip driver.
> > > > >>>>
> > > > >>>> To test, just build the program and use the --atomic flag to use the cursor
> > > > >>>> plane with the ATOMIC_AMEND flag. E.g.
> > > > >>>>
> > > > >>>>   drm_cursor --atomic
> > > > >>>>
> > > > >>>> [1] https://patchwork.freedesktop.org/patch/243088/
> > > > >>>> [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/async-capability
> > > > >>>>
> > > > >>>> Thanks
> > > > >>>> Helen
> > > > >>>>
> > > > >>>>
> > > > >>>>  drivers/gpu/drm/drm_ioctl.c | 11 +++++++++++
> > > > >>>>  include/uapi/drm/drm.h      |  1 +
> > > > >>>>  2 files changed, 12 insertions(+)
> > > > >>>>
> > > > >>>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> > > > >>>> index 94bd872d56c4..4a7e0f874171 100644
> > > > >>>> --- a/drivers/gpu/drm/drm_ioctl.c
> > > > >>>> +++ b/drivers/gpu/drm/drm_ioctl.c
> > > > >>>> @@ -31,6 +31,7 @@
> > > > >>>>  #include <drm/drm_ioctl.h>
> > > > >>>>  #include <drm/drmP.h>
> > > > >>>>  #include <drm/drm_auth.h>
> > > > >>>> +#include <drm/drm_modeset_helper_vtables.h>
> > > > >>>>  #include "drm_legacy.h"
> > > > >>>>  #include "drm_internal.h"
> > > > >>>>  #include "drm_crtc_internal.h"
> > > > >>>> @@ -229,6 +230,7 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
> > > > >>>>  {
> > > > >>>>      struct drm_get_cap *req = data;
> > > > >>>>      struct drm_crtc *crtc;
> > > > >>>> +    struct drm_plane *plane;
> > > > >>>>
> > > > >>>>      req->value = 0;
> > > > >>>>
> > > > >>>> @@ -292,6 +294,15 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
> > > > >>>>      case DRM_CAP_CRTC_IN_VBLANK_EVENT:
> > > > >>>>              req->value = 1;
> > > > >>>>              break;
> > > > >>>> +    case DRM_CAP_ASYNC_UPDATE:
> > > > >>>> +            req->value = 1;
> > > > >>>> +            list_for_each_entry(plane, &dev->mode_config.plane_list, head) {
> > > > >>>> +                    if (!plane->helper_private->atomic_async_update) {
> > > > >>>> +                            req->value = 0;
> > > > >>>> +                            break;
> > > > >>>> +                    }
> > > > >>>> +            }
> > > > >>>> +            break;
> > > > >>>>      default:
> > > > >>>>              return -EINVAL;
> > > > >>>>      }
> > > > >>>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > > > >>>> index 300f336633f2..ff01540cbb1d 100644
> > > > >>>> --- a/include/uapi/drm/drm.h
> > > > >>>> +++ b/include/uapi/drm/drm.h
> > > > >>>> @@ -649,6 +649,7 @@ struct drm_gem_open {
> > > > >>>>  #define DRM_CAP_PAGE_FLIP_TARGET    0x11
> > > > >>>>  #define DRM_CAP_CRTC_IN_VBLANK_EVENT        0x12
> > > > >>>>  #define DRM_CAP_SYNCOBJ             0x13
> > > > >>>> +#define DRM_CAP_ASYNC_UPDATE                0x14
> > > > >>>>
> > > > >>>>  /** DRM_IOCTL_GET_CAP ioctl argument type */
> > > > >>>>  struct drm_get_cap {
> > > > >>>> --
> > > > >>>> 2.19.1
> > > > >>>>
> > > > >>>> _______________________________________________
> > > > >>>> dri-devel mailing list
> > > > >>>> dri-devel@lists.freedesktop.org
> > > > >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > >>>
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

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
