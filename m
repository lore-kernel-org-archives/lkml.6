Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933401AbeBVQ7Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:59:25 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38610 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933214AbeBVQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:59:21 -0500
X-Google-Smtp-Source: AH8x226Pxi2UacQS6Rvt+A7A+lc/J1SkpJ2BOGOXiE8grCfj8WdhIN+C9lW3eDzZai42BAtwAN+QPw==
Date: Thu, 22 Feb 2018 17:59:16 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel.vetter@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH 1/4] drm/simple_kms_helper: Add {enable|disable}_vblank
 callback support
Message-ID: <20180222165916.GD6419@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel.vetter@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1518425574-32671-1-git-send-email-andr2000@gmail.com>
 <1518425574-32671-2-git-send-email-andr2000@gmail.com>
 <00b01a2d-ad16-e171-f52f-88fba2896386@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b01a2d-ad16-e171-f52f-88fba2896386@gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 11:11:23AM +0200, Oleksandr Andrushchenko wrote:
> ping
> On 02/12/2018 10:52 AM, Oleksandr Andrushchenko wrote:
> > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > 
> > If simple_kms_helper based driver needs to work with vblanks,
> > then it has to provide drm_driver.{enable|disable}_vblank callbacks,
> > because drm_simple_kms_helper.drm_crtc_funcs does not provide any.
> > At the same time drm_driver.{enable|disable}_vblank callbacks
> > are marked as deprecated and shouldn't be used by new drivers.
> > 
> > Fix this by extending drm_simple_kms_helper.drm_crtc_funcs
> > to provide the missing callbacks.
> > 
> > Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

lgtm, all 4 applied, thanks for your patches.
-Daniel

> > ---
> >   drivers/gpu/drm/drm_simple_kms_helper.c | 24 ++++++++++++++++++++++++
> >   include/drm/drm_simple_kms_helper.h     | 18 ++++++++++++++++++
> >   2 files changed, 42 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
> > index 9d3f6b70812c..9ca8a4a59b74 100644
> > --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> > +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> > @@ -77,6 +77,28 @@ static const struct drm_crtc_helper_funcs drm_simple_kms_crtc_helper_funcs = {
> >   	.atomic_disable = drm_simple_kms_crtc_disable,
> >   };
> > +static int drm_simple_kms_crtc_enable_vblank(struct drm_crtc *crtc)
> > +{
> > +	struct drm_simple_display_pipe *pipe;
> > +
> > +	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
> > +	if (!pipe->funcs || !pipe->funcs->enable_vblank)
> > +		return 0;
> > +
> > +	return pipe->funcs->enable_vblank(pipe);
> > +}
> > +
> > +static void drm_simple_kms_crtc_disable_vblank(struct drm_crtc *crtc)
> > +{
> > +	struct drm_simple_display_pipe *pipe;
> > +
> > +	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
> > +	if (!pipe->funcs || !pipe->funcs->disable_vblank)
> > +		return;
> > +
> > +	pipe->funcs->disable_vblank(pipe);
> > +}
> > +
> >   static const struct drm_crtc_funcs drm_simple_kms_crtc_funcs = {
> >   	.reset = drm_atomic_helper_crtc_reset,
> >   	.destroy = drm_crtc_cleanup,
> > @@ -84,6 +106,8 @@ static const struct drm_crtc_funcs drm_simple_kms_crtc_funcs = {
> >   	.page_flip = drm_atomic_helper_page_flip,
> >   	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> >   	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
> > +	.enable_vblank = drm_simple_kms_crtc_enable_vblank,
> > +	.disable_vblank = drm_simple_kms_crtc_disable_vblank,
> >   };
> >   static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
> > diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
> > index 6d9adbb46293..79567826b099 100644
> > --- a/include/drm/drm_simple_kms_helper.h
> > +++ b/include/drm/drm_simple_kms_helper.h
> > @@ -93,6 +93,24 @@ struct drm_simple_display_pipe_funcs {
> >   	 */
> >   	void (*cleanup_fb)(struct drm_simple_display_pipe *pipe,
> >   			   struct drm_plane_state *plane_state);
> > +
> > +	/**
> > +	 * @enable_vblank:
> > +	 *
> > +	 * Optional, called by &drm_crtc_funcs.enable_vblank. Please read
> > +	 * the documentation for the &drm_crtc_funcs.enable_vblank hook for
> > +	 * more details.
> > +	 */
> > +	int (*enable_vblank)(struct drm_simple_display_pipe *pipe);
> > +
> > +	/**
> > +	 * @disable_vblank:
> > +	 *
> > +	 * Optional, called by &drm_crtc_funcs.disable_vblank. Please read
> > +	 * the documentation for the &drm_crtc_funcs.disable_vblank hook for
> > +	 * more details.
> > +	 */
> > +	void (*disable_vblank)(struct drm_simple_display_pipe *pipe);
> >   };
> >   /**
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
