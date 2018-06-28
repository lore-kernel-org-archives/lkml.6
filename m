Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF64C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0568A215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0568A215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935412AbeF1Mb5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:31:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59698 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932371AbeF1Mb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:31:56 -0400
Received: from juma (unknown [IPv6:2804:14c:181:9195:9419:3bed:192:1e62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: padovan)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C817C261420;
        Thu, 28 Jun 2018 13:31:51 +0100 (BST)
Message-ID: <06736479f36918a58d6b4986b697ddb7569c920e.camel@collabora.com>
Subject: Re: [RFC PATCH] drm/atomic: add ASYNC_UPDATE flag to the Atomic
 IOCTL.
From:   Gustavo Padovan <gustavo.padovan@collabora.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        David Airlie <airlied@linux.ie>
Cc:     dnicoara@chromium.org, alexandros.frantzis@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@chromium.org>
Date:   Thu, 28 Jun 2018 09:31:46 -0300
In-Reply-To: <b8fda72a-1ec6-4d47-ea5a-22f03802f4f3@linux.intel.com>
References: <20180627212506.24061-1-enric.balletbo@collabora.com>
         <b8fda72a-1ec6-4d47-ea5a-22f03802f4f3@linux.intel.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maarten,

On Thu, 2018-06-28 at 10:31 +0200, Maarten Lankhorst wrote:
> Op 27-06-18 om 23:25 schreef Enric Balletbo i Serra:
> > From: Gustavo Padovan <gustavo.padovan@collabora.com>
> > 
> > This flag tells core to jump ahead the queued update if the
> > conditions
> > in drm_atomic_async_check() are met. That means we are only able to
> > do an
> > async update if no modeset is pending and update for the same plane
> > is
> > not queued.
> > 
> > It uses the already in place infrastructure for async updates.
> > 
> > It is useful for cursor updates and async PageFlips over the atomic
> > ioctl, otherwise in some cases updates may be delayed to the point
> > the
> > user will notice it.
> > 
> > DRM_MODE_ATOMIC_ASYNC_UPDATE should be passed to the Atomic IOCTL
> > to use
> > this feature.
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com
> > >
> > ---
> > Hi,
> > 
> > This is an attempt to introduce the new ASYNC_UPDATE flag for
> > atomic
> > operations, see the commit message for a more detailed description.
> > 
> > To test this patch we have created an IGT test that we plan to send
> > to
> > the ML but also was tested using a small program that exercises the
> > uAPI
> > for easy sanity testing. The program created by Alexandros can be
> > found here
> > [2]. To test, just build the program and use the --atomic flag to
> > use the
> > cursor plane in normal (blocking mode), and --atomic-async to use
> > the cursor
> > plane with the ASYNC_UPDATE flag.E.g.
> > 
> >   drm_cursor --atomic
> > 
> > or
> > 
> >   drm_cursor --atomic-async
> > 
> > The test worked on a Samsung Chromebook Plus on top of mainline
> > plus
> > the patch to update cursors asynchronously through atomic for the
> > drm/rockchip driver [3].
> > 
> > Alexandros also did a proof-of-concept to use this flag and draw
> > cursors
> > using atomic if possible on ozone [1].
> > 
> > Best regards,
> >  Enric
> > 
> > [1] https://chromium-review.googlesource.com/c/chromium/src/+/10927
> > 11
> > [2] https://gitlab.collabora.com/alf/drm-cursor
> > [3] https://patchwork.kernel.org/patch/10492693/
> > 
> > 
> >  drivers/gpu/drm/drm_atomic.c        | 6 ++++++
> >  drivers/gpu/drm/drm_atomic_helper.c | 9 ++++++---
> >  include/uapi/drm/drm_mode.h         | 4 +++-
> >  3 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic.c
> > b/drivers/gpu/drm/drm_atomic.c
> > index c825c76edc1d..15b799f46982 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -80,6 +80,7 @@ drm_atomic_state_init(struct drm_device *dev,
> > struct drm_atomic_state *state)
> >  	 * setting this appropriately?
> >  	 */
> >  	state->allow_modeset = true;
> > +	state->async_update = true;
> 
> Do we really want this by default?
> 
> Wouldn't it make more sense to only enable it if userspace requests
> it?

This value is rewritten when we check for the ASYNC_UPDATE flag, so it 
disable by default. I guess this line could be removed then.

> >  
> >  	state->crtcs = kcalloc(dev->mode_config.num_crtc,
> >  			       sizeof(*state->crtcs), GFP_KERNEL);
> > @@ -2320,6 +2321,10 @@ int drm_mode_atomic_ioctl(struct drm_device
> > *dev,
> >  			(arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
> >  		return -EINVAL;
> >  
> > +	if ((arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET) &&
> > +			(arg->flags &
> > DRM_MODE_ATOMIC_ASYNC_UPDATE))
> > +		return -EINVAL;
> > +
> >  	drm_modeset_acquire_init(&ctx,
> > DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
> >  
> >  	state = drm_atomic_state_alloc(dev);
> 
> We should probably move it to be a flag only enabled when requested,
> and reject with the error returned by drm_atomic_helper_async_check()
> when things fail.
> 
> ~Maarten
> > @@ -2328,6 +2333,7 @@ int drm_mode_atomic_ioctl(struct drm_device
> > *dev,
> >  
> >  	state->acquire_ctx = &ctx;
> >  	state->allow_modeset = !!(arg->flags &
> > DRM_MODE_ATOMIC_ALLOW_MODESET);
> > +	state->async_update = !!(arg->flags &
> > DRM_MODE_ATOMIC_ASYNC_UPDATE);
> >  
> >  retry:
> >  	plane_mask = 0;
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> > b/drivers/gpu/drm/drm_atomic_helper.c
> > index c35654591c12..aeb0523d3bcf 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -891,7 +891,7 @@ int drm_atomic_helper_check(struct drm_device
> > *dev,
> >  	if (ret)
> >  		return ret;
> >  
> > -	if (state->legacy_cursor_update)
> > +	if (state->async_update || state->legacy_cursor_update)
> >  		state->async_update =
> > !drm_atomic_helper_async_check(dev, state);
> >  
> >  	return ret;
> > @@ -1526,13 +1526,16 @@ int drm_atomic_helper_async_check(struct
> > drm_device *dev,
> >  	if (new_plane_state->fence)
> >  		return -EINVAL;
> >  
> > +	/* Only do an async update if there is a pending commit.
> > */
> > +	if (!old_plane_state->commit)
> > +		return -EINVAL;
> > +
> >  	/*
> >  	 * Don't do an async update if there is an outstanding
> > commit modifying
> >  	 * the plane.  This prevents our async update's changes
> > from getting
> >  	 * overridden by a previous synchronous update's state.
> >  	 */
> > -	if (old_plane_state->commit &&
> > -	    !try_wait_for_completion(&old_plane_state->commit-
> > >hw_done))
> > +	if (!try_wait_for_completion(&old_plane_state->commit-
> > >hw_done))
> >  		return -EBUSY;
> >  
> >  	return funcs->atomic_async_check(plane, new_plane_state);
> > diff --git a/include/uapi/drm/drm_mode.h
> > b/include/uapi/drm/drm_mode.h
> > index 50bcf4214ff9..772e84f0edeb 100644
> > --- a/include/uapi/drm/drm_mode.h
> > +++ b/include/uapi/drm/drm_mode.h
> > @@ -718,13 +718,15 @@ struct drm_mode_destroy_dumb {
> >  #define DRM_MODE_ATOMIC_TEST_ONLY 0x0100
> >  #define DRM_MODE_ATOMIC_NONBLOCK  0x0200
> >  #define DRM_MODE_ATOMIC_ALLOW_MODESET 0x0400
> > +#define DRM_MODE_ATOMIC_ASYNC_UPDATE  0x0800
> >  
> >  #define DRM_MODE_ATOMIC_FLAGS (\
> >  		DRM_MODE_PAGE_FLIP_EVENT |\
> >  		DRM_MODE_PAGE_FLIP_ASYNC |\
> >  		DRM_MODE_ATOMIC_TEST_ONLY |\
> >  		DRM_MODE_ATOMIC_NONBLOCK |\
> > -		DRM_MODE_ATOMIC_ALLOW_MODESET)
> > +		DRM_MODE_ATOMIC_ALLOW_MODESET |\
> > +		DRM_MODE_ATOMIC_ASYNC_UPDATE)
> >  
> >  struct drm_mode_atomic {
> >  	__u32 flags;
> 
> 
-- 
Gustavo Padovan
Collabora Ltd.
