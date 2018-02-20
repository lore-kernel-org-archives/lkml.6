Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeBTLRx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:17:53 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38644 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeBTLRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:17:52 -0500
X-Google-Smtp-Source: AH8x224p9vJjlxM99icsI7Gk9JwKWEZW3K1T155VfIPCxNEDkVwYuJZ0rjv2LswVr3gCGta3+s5xSg==
Date: Tue, 20 Feb 2018 12:17:48 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Cc: Oleksandr Andrushchenko <andr2000@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel.vetter@intel.com
Subject: Re: [PATCH] drm/simple_kms_helper: Fix NULL pointer dereference with
 no active CRTC
Message-ID: <20180220111748.GJ22199@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel.vetter@intel.com
References: <1518511456-28257-1-git-send-email-andr2000@gmail.com>
 <20180219143002.GC22199@phenom.ffwll.local>
 <d676eef9-55b2-a7fd-be9b-4d53d59610a9@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d676eef9-55b2-a7fd-be9b-4d53d59610a9@epam.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 04:58:43PM +0200, Oleksandr Andrushchenko wrote:
> On 02/19/2018 04:30 PM, Daniel Vetter wrote:
> > On Tue, Feb 13, 2018 at 10:44:16AM +0200, Oleksandr Andrushchenko wrote:
> > > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > 
> > > It is possible that drm_simple_kms_plane_atomic_check called
> > > with no CRTC set, e.g. when user-space application sets CRTC_ID/FB_ID
> > > to 0 before doing any actual drawing. This leads to NULL pointer
> > > dereference because in this case new CRTC state is NULL and must be
> > > checked before accessing.
> > > 
> > > Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > ---
> > >   drivers/gpu/drm/drm_simple_kms_helper.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
> > > index 9ca8a4a59b74..a05eca9cec8b 100644
> > > --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> > > +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> > > @@ -121,8 +121,10 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
> > >   	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
> > >   	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
> > >   						   &pipe->crtc);
> > > -	if (!crtc_state->enable)
> > > -		return 0; /* nothing to check when disabling or disabled */
> > > +
> > > +	if (!crtc_state || !crtc_state->enable)
> > > +		/* nothing to check when disabling or disabled or no CRTC set */
> > > +		return 0;
> > >   	if (crtc_state->enable)
> > >   		drm_mode_get_hv_timing(&crtc_state->mode,
> > Hm, this is a bit annoying, since the can_position = false parameter to
> > drm_atomic_helper_check_plane_state is supposed to catch all this. Would
> > moving all the checks after the call to that helper, and gating them on
> > plane_state->visible also work?
> Yes, it does work if this is what you mean:

I wasn't sure, thanks for figuring this out!

> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c
> b/drivers/gpu/drm/drm_simple_kms_helper.c
> index a05eca9cec8b..c48858bb2823 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> @@ -122,14 +122,6 @@ static int drm_simple_kms_plane_atomic_check(struct
> drm_plane *plane,
>         crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
> &pipe->crtc);
> 
> -       if (!crtc_state || !crtc_state->enable)
> -               /* nothing to check when disabling or disabled or no CRTC
> set */
> -               return 0;
> -
> -       if (crtc_state->enable)
> -               drm_mode_get_hv_timing(&crtc_state->mode,
> -                                      &clip.x2, &clip.y2);
> -
>         ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
>                                                   &clip,
> DRM_PLANE_HELPER_NO_SCALING,
> @@ -138,6 +130,13 @@ static int drm_simple_kms_plane_atomic_check(struct
> drm_plane *plane,
>         if (ret)
>                 return ret;
> 
> +       if (!plane_state->visible || !crtc_state->enable)
> +               return 0; /* nothing to check when disabling or disabled */

if (!plane_state->visible) {
	WARN_ON(crtc_state->enabled);
	return 0;
}

The helper call above should guarantee this.
> +
> +       if (plane_state->visible && crtc_state->enable)

Similar here.

> +               drm_mode_get_hv_timing(&crtc_state->mode,
> +                                      &clip.x2, &clip.y2);
> +
>         if (!plane_state->visible)
>                 return -EINVAL;

This can now be removed, the plane helper takes care of checking for
plane_state->visible != crtc_state->enable. Please also remove.

> > We'd need to add a guarantee to drm_atomic_helper_check_plane_state that
> > it can cope with crtc_state == NULL, but I think that's a good idea
> > anyway. Atm it shouldn't end up looking at the crtc_state pointer in that
> > case.
> It doesn't look at it at the moment
> > Otherwise we'll just go with your fix, but it feels all a bit too fragile,
> > hence why I want to explore more robust options a bit.
> At list with the change above it passes my test which failed
> before. Although I cannot confirm it works for others, but it
> certainly does for me.
> > -Daniel
> Do you want me to send v1 with the code above?

Yes please, with my above cleanup suggestions.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
