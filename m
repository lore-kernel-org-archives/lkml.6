Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeDEH7f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:59:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36994 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeDEH7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:59:34 -0400
X-Google-Smtp-Source: AIpwx48SD690EVwcTZbgJswvcUFeWUYDUmq349Bw3PRypfxFtWfRQhsNSK/FtCLaHIh+c+cXB2U5Xw==
Date: Thu, 5 Apr 2018 09:59:29 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Deepak Rawat <drawat@vmware.com>
Cc: dri-devel@lists.freedesktop.org, thellstrom@vmware.com,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com, daniel@ffwll.ch,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/3] drm: Add helper to validate damage during modeset_check
Message-ID: <20180405075929.GR3881@phenom.ffwll.local>
Mail-Followup-To: Deepak Rawat <drawat@vmware.com>,
        dri-devel@lists.freedesktop.org, thellstrom@vmware.com,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-4-git-send-email-drawat@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522885748-67122-4-git-send-email-drawat@vmware.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 04:49:08PM -0700, Deepak Rawat wrote:
> This patch adds a helper which should be called by driver which enable
> damage (by calling drm_plane_enable_damage_clips) from atomic_check
> hook. This helper for now set the damage to NULL for the planes on crtc
> which need full modeset.
> 
> The driver also need to check for other crtc properties which can
> affect damage in atomic_check hook, like gamma, ctm, etc. Plane related
> properties which affect damage can be handled in damage iterator.
> 
> Signed-off-by: Deepak Rawat <drawat@vmware.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 47 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_atomic_helper.h     |  2 ++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 355b514..23f44ab 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3987,3 +3987,50 @@ drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
>  	return true;
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
> +
> +/**
> + * drm_atomic_helper_check_damage - validate state object for damage changes
> + * @dev: DRM device
> + * @state: the driver state object
> + *
> + * Check the state object if damage is required or not. In case damage is not
> + * required e.g. need modeset, the damage blob is set to NULL.

Why is that needed?

I can imagine that drivers unconditionally upload everything for a
modeset, and hence don't need special damage tracking. But for that it's
imo better to have a clear_damage() helper.

But even for modesets (e.g. resolution changes) I'd expect that virtual
drivers don't want to upload unecessary amounts of data. Manual upload
hw drivers probably need to upload everything, because the panel will have
forgotten all the old data once power cycled.

And if you think this is really the right thing, then we need to rename
the function to tell what it does, e.g.

drm_damage_helper_clear_damage_on_modeset()

drm_damage_helper because I think we should stuff this all into
drm_damage_helper.c, see previous patch.

But I think a

drm_damage_helper_clear_damage(crtc_state)

which you can use in your crtc->atomic_check function like

crtc_atomic_check(state)
{
	if (drm_atomic_crtc_needs_modeset(state))
		drm_damage_helper_clear_damage(state);
}

is more flexible and useful for drivers. There might be other cases where
clearing damage is the right thing to do. Also, there's the question of
whether no damage clips == full damage or not, so maybe we should call
this helper full_damage() instead.
-Daniel

> + *
> + * NOTE: This helper is not called by core. Those driver which enable damage
> + * using drm_plane_enable_damage_clips should call this from their @atomic_check
> + * hook.
> + */
> +int drm_atomic_helper_check_damage(struct drm_device *dev,
> +				   struct drm_atomic_state *state)
> +{
> +	struct drm_crtc *crtc;
> +	struct drm_plane *plane;
> +	struct drm_crtc_state *crtc_state;
> +	unsigned plane_mask;
> +	int i;
> +
> +	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
> +		if (!drm_atomic_crtc_needs_modeset(crtc_state))
> +			continue;
> +
> +		plane_mask = crtc_state->plane_mask;
> +		plane_mask |= crtc->state->plane_mask;
> +
> +		drm_for_each_plane_mask(plane, dev, plane_mask) {
> +			struct drm_plane_state *plane_state =
> +				drm_atomic_get_plane_state(state, plane);
> +
> +			if (IS_ERR(plane_state))
> +				return PTR_ERR(plane_state);
> +
> +			if (plane_state->damage_clips) {
> +				drm_property_blob_put(plane_state->damage_clips);
> +				plane_state->damage_clips = NULL;
> +				plane_state->num_clips = 0;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_check_damage);
> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> index ebd4b66..b12335c 100644
> --- a/include/drm/drm_atomic_helper.h
> +++ b/include/drm/drm_atomic_helper.h
> @@ -224,6 +224,8 @@ drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
>  bool
>  drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
>  				   struct drm_rect *rect);
> +int drm_atomic_helper_check_damage(struct drm_device *dev,
> +				   struct drm_atomic_state *state);
>  
>  /**
>   * drm_atomic_crtc_for_each_plane - iterate over planes currently attached to CRTC
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
