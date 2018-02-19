Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeBSOaI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:30:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53520 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeBSOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:30:06 -0500
X-Google-Smtp-Source: AH8x224EwDK9R+GnqpUlCz/VrqCWudVnyd5jEoDhvCmzgFE1VPNw8NneBVFDcMyO+HjVVvL6W4B1Lg==
Date: Mon, 19 Feb 2018 15:30:02 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel.vetter@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] drm/simple_kms_helper: Fix NULL pointer dereference with
 no active CRTC
Message-ID: <20180219143002.GC22199@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel.vetter@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1518511456-28257-1-git-send-email-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518511456-28257-1-git-send-email-andr2000@gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:44:16AM +0200, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> It is possible that drm_simple_kms_plane_atomic_check called
> with no CRTC set, e.g. when user-space application sets CRTC_ID/FB_ID
> to 0 before doing any actual drawing. This leads to NULL pointer
> dereference because in this case new CRTC state is NULL and must be
> checked before accessing.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  drivers/gpu/drm/drm_simple_kms_helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
> index 9ca8a4a59b74..a05eca9cec8b 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> @@ -121,8 +121,10 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
>  	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
>  	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
>  						   &pipe->crtc);
> -	if (!crtc_state->enable)
> -		return 0; /* nothing to check when disabling or disabled */
> +
> +	if (!crtc_state || !crtc_state->enable)
> +		/* nothing to check when disabling or disabled or no CRTC set */
> +		return 0;
>  
>  	if (crtc_state->enable)
>  		drm_mode_get_hv_timing(&crtc_state->mode,

Hm, this is a bit annoying, since the can_position = false parameter to
drm_atomic_helper_check_plane_state is supposed to catch all this. Would
moving all the checks after the call to that helper, and gating them on
plane_state->visible also work?

We'd need to add a guarantee to drm_atomic_helper_check_plane_state that
it can cope with crtc_state == NULL, but I think that's a good idea
anyway. Atm it shouldn't end up looking at the crtc_state pointer in that
case.

Otherwise we'll just go with your fix, but it feels all a bit too fragile,
hence why I want to explore more robust options a bit.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
