Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeDENrh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:47:37 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:54780 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeDENrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:47:36 -0400
X-Google-Smtp-Source: AIpwx4/kBxopX2+yZn3poRWzfw8iXNmQ2GwqPUXo5fIk9pArpVZWpizEIm5QtaMhJPGPoLEmuq4iEA==
Date: Thu, 5 Apr 2018 15:47:31 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Hellstrom <thomas@shipmail.org>
Cc: Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/3] drm: Add DAMAGE_CLIPS property to plane
Message-ID: <20180405134731.GW3881@phenom.ffwll.local>
Mail-Followup-To: Thomas Hellstrom <thomas@shipmail.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-2-git-send-email-drawat@vmware.com>
 <20180405073525.GP3881@phenom.ffwll.local>
 <b87e222a-610e-05de-3ba2-7261831af5ec@vmware.com>
 <20180405100319.GT3881@phenom.ffwll.local>
 <810f02ce-02fa-076e-43ff-4c43455f07bb@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810f02ce-02fa-076e-43ff-4c43455f07bb@shipmail.org>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 01:35:25PM +0200, Thomas Hellstrom wrote:
> On 04/05/2018 12:03 PM, Daniel Vetter wrote:
> > On Thu, Apr 05, 2018 at 11:00:15AM +0200, Thomas Hellstrom wrote:
> > > On 04/05/2018 09:35 AM, Daniel Vetter wrote:
> > > > On Wed, Apr 04, 2018 at 04:49:06PM -0700, Deepak Rawat wrote:
> > > > > From: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
> > > > > 
> > > > > Optional plane property to mark damaged regions on the plane in
> > > > > framebuffer coordinates of the framebuffer attached to the plane.
> > > > > 
> > > > > The layout of blob data is simply an array of drm_mode_rect with maximum
> > > > > array size limited by DRM_MODE_FB_DIRTY_MAX_CLIPS. Unlike plane src
> > > > > coordinates, damage clips are not in 16.16 fixed point.
> > > > > 
> > > > > Damage clips are a hint to kernel as which area of framebuffer has
> > > > > changed since last page-flip. This should be helpful for some drivers
> > > > > especially for virtual devices where each framebuffer change needs to
> > > > > be transmitted over network, usb, etc.
> > > > > 
> > > > > Driver which are interested in enabling DAMAGE_CLIPS property for a
> > > > > plane should enable this property using drm_plane_enable_damage_clips.
> > > > > 
> > > > > Signed-off-by: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
> > > > > Signed-off-by: Deepak Rawat <drawat@vmware.com>
> > > > The property uapi section is missing, see:
> > > > 
> > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__dri.freedesktop.org_docs_drm_gpu_drm-2Dkms.html-23plane-2Dcomposition-2Dproperties&d=DwIBAg&c=uilaK90D4TOVoH58JNXRgQ&r=wnSlgOCqfpNS4d02vP68_E9q2BNMCwfD2OZ_6dCFVQQ&m=J31YNV1uz3IVRaorM-eo48msi9__sQurqRZrig2UE1s&s=vzsuquF1agbOw54HSC_18Kk2k9j83m8RusmDCtPAFWQ&e=
> > > > 
> > > > Plane composition feels like the best place to put this. Please use that
> > > > section to tie all the various bits together, including the helpers you're
> > > > adding in the following patches for drivers to use.
> > > > 
> > > > Bunch of nitpicks below, but overall I'm agreeing now with just going with
> > > > fb coordinate damage rects.
> > > > 
> > > > Like you say, the thing needed here now is userspace + driver actually
> > > > implementing this. I'd also say the compat helper to map the legacy
> > > > fb->dirty to this new atomic way of doing things should be included here
> > > > (gives us a lot more testing for these new paths).
> > > > 
> > > > Icing on the cake would be an igt to make sure kernel rejects invalid clip
> > > > rects correctly.
> > > > 
> > > > > ---
> > > > >    drivers/gpu/drm/drm_atomic.c        | 42 +++++++++++++++++++++++++++++++++++++
> > > > >    drivers/gpu/drm/drm_atomic_helper.c |  4 ++++
> > > > >    drivers/gpu/drm/drm_mode_config.c   |  5 +++++
> > > > >    drivers/gpu/drm/drm_plane.c         | 12 +++++++++++
> > > > >    include/drm/drm_mode_config.h       | 15 +++++++++++++
> > > > >    include/drm/drm_plane.h             | 16 ++++++++++++++
> > > > >    include/uapi/drm/drm_mode.h         | 15 +++++++++++++
> > > > >    7 files changed, 109 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > > > > index 7d25c42..9226d24 100644
> > > > > --- a/drivers/gpu/drm/drm_atomic.c
> > > > > +++ b/drivers/gpu/drm/drm_atomic.c
> > > > > @@ -669,6 +669,40 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
> > > > >    }
> > > > >    /**
> > > > > + * drm_atomic_set_damage_for_plane - sets the damage clips property to plane
> > > > > + * @state: plane state
> > > > > + * @blob: damage clips in framebuffer coordinates
> > > > > + *
> > > > > + * Returns:
> > > > > + *
> > > > > + * Zero on success, error code on failure.
> > > > > + */
> > > > > +static int drm_atomic_set_damage_for_plane(struct drm_plane_state *state,
> > > > > +					   struct drm_property_blob *blob)
> > > > > +{
> > > > > +	if (blob == state->damage_clips)
> > > > > +		return 0;
> > > > > +
> > > > > +	drm_property_blob_put(state->damage_clips);
> > > > > +	state->damage_clips = NULL;
> > > > > +
> > > > > +	if (blob) {
> > > > > +		uint32_t count = blob->length/sizeof(struct drm_rect);
> > > > > +
> > > > > +		if (count > DRM_MODE_FB_DIRTY_MAX_CLIPS)
> > > > > +			return -EINVAL;
> > > > > +
> > > > > +		state->damage_clips = drm_property_blob_get(blob);
> > > > > +		state->num_clips = count;
> > > > > +	} else {
> > > > > +		state->damage_clips = NULL;
> > > > > +		state->num_clips = 0;
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > >     * drm_atomic_get_plane_state - get plane state
> > > > >     * @state: global atomic state object
> > > > >     * @plane: plane to get state object for
> > > > > @@ -793,6 +827,12 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
> > > > >    		state->color_encoding = val;
> > > > >    	} else if (property == plane->color_range_property) {
> > > > >    		state->color_range = val;
> > > > > +	} else if (property == config->prop_damage_clips) {
> > > > > +		struct drm_property_blob *blob =
> > > > > +			drm_property_lookup_blob(dev, val);
> > > > > +		int ret = drm_atomic_set_damage_for_plane(state, blob);
> > > > There's already a helper with size-checking built-in, see
> > > > drm_atomic_replace_property_blob_from_id(). Wrt computing num_clips I'd
> > > > just provide a little inline helper that does the
> > > > blob->length/sizeof(drm_rect) conversion (it's just a shift, so fast).
> > > > 
> > > > > +		drm_property_blob_put(blob);
> > > > > +		return ret;
> > > > >    	} else if (plane->funcs->atomic_set_property) {
> > > > >    		return plane->funcs->atomic_set_property(plane, state,
> > > > >    				property, val);
> > > > > @@ -856,6 +896,8 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
> > > > >    		*val = state->color_encoding;
> > > > >    	} else if (property == plane->color_range_property) {
> > > > >    		*val = state->color_range;
> > > > > +	} else if (property == config->prop_damage_clips) {
> > > > > +		*val = (state->damage_clips) ? state->damage_clips->base.id : 0;
> > > > >    	} else if (plane->funcs->atomic_get_property) {
> > > > >    		return plane->funcs->atomic_get_property(plane, state, property, val);
> > > > >    	} else {
> > > > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > index c356545..55b44e3 100644
> > > > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > @@ -3506,6 +3506,8 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
> > > > >    	state->fence = NULL;
> > > > >    	state->commit = NULL;
> > > > > +	state->damage_clips = NULL;
> > > > > +	state->num_clips = 0;
> > > > >    }
> > > > >    EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
> > > > > @@ -3550,6 +3552,8 @@ void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state)
> > > > >    	if (state->commit)
> > > > >    		drm_crtc_commit_put(state->commit);
> > > > > +
> > > > > +	drm_property_blob_put(state->damage_clips);
> > > > >    }
> > > > >    EXPORT_SYMBOL(__drm_atomic_helper_plane_destroy_state);
> > > > > diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> > > > > index e5c6533..e93b127 100644
> > > > > --- a/drivers/gpu/drm/drm_mode_config.c
> > > > > +++ b/drivers/gpu/drm/drm_mode_config.c
> > > > > @@ -293,6 +293,11 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
> > > > >    		return -ENOMEM;
> > > > >    	dev->mode_config.prop_crtc_id = prop;
> > > > > +	prop = drm_property_create(dev, DRM_MODE_PROP_BLOB, "DAMAGE_CLIPS", 0);
> > > > Bit a bikeshed, but since the coordinates are in fb pixels, not plane
> > > > pixels, I'd call this "FB_DAMAGE_CLIPS".
> > > > 
> > > > > +	if (!prop)
> > > > > +		return -ENOMEM;
> > > > > +	dev->mode_config.prop_damage_clips = prop;
> > > > > +
> > > > >    	prop = drm_property_create_bool(dev, DRM_MODE_PROP_ATOMIC,
> > > > >    			"ACTIVE");
> > > > >    	if (!prop)
> > > > > diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> > > > > index 6d2a6e4..071221b 100644
> > > > > --- a/drivers/gpu/drm/drm_plane.c
> > > > > +++ b/drivers/gpu/drm/drm_plane.c
> > > > > @@ -1101,3 +1101,15 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
> > > > >    	return ret;
> > > > >    }
> > > > > +
> > > > > +/**
> > > > > + * drm_plane_enable_damage_clips - enable damage clips property
> > > > > + * @plane: plane on which this property to enable.
> > > > > + */
> > > > > +void drm_plane_enable_damage_clips(struct drm_plane *plane)
> > > > > +{
> > > > > +	struct drm_device *dev = plane->dev;
> > > > > +	struct drm_mode_config *config = &dev->mode_config;
> > > > > +
> > > > > +	drm_object_attach_property(&plane->base, config->prop_damage_clips, 0);
> > > > > +}
> > > > > diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> > > > > index 7569f22..d8767da 100644
> > > > > --- a/include/drm/drm_mode_config.h
> > > > > +++ b/include/drm/drm_mode_config.h
> > > > > @@ -628,6 +628,21 @@ struct drm_mode_config {
> > > > >    	 */
> > > > >    	struct drm_property *prop_crtc_id;
> > > > >    	/**
> > > > > +	 * @prop_damage_clips: Optional plane property to mark damaged regions
> > > > > +	 * on the plane in framebuffer coordinates of the framebuffer attached
> > > > > +	 * to the plane.
> > > > Why should we make this optional? Looks like just another thing drivers
> > > > might screw up, since we have multiple callbacks and things to set up for
> > > > proper dirty tracking.
> > > > 
> > > > One option I'm seeing is that if this is set, and it's an atomic driver,
> > > > then we just directly call into the default atomic fb->dirty
> > > > implementation. That way there's only 1 thing drivers need to do to set up
> > > > dirty rect tracking, and they'll get all of it.
> > > > 
> > > > > +	 *
> > > > > +	 * The layout of blob data is simply an array of drm_mode_rect with
> > > > > +	 * maximum array size limited by DRM_MODE_FB_DIRTY_MAX_CLIPS. Unlike
> > > > > +	 * plane src coordinates, damage clips are not in 16.16 fixed point.
> > > > I honestly have no idea where this limit is from. Worth keeping? I can
> > > > easily imagine that userspace could trip over this - it's fairly high, but
> > > > not unlimited.
> > > > 
> > > > > +	 *
> > > > > +	 * Damage clips are a hint to kernel as which area of framebuffer has
> > > > > +	 * changed since last page-flip. This should be helpful
> > > > > +	 * for some drivers especially for virtual devices where each
> > > > > +	 * framebuffer change needs to be transmitted over network, usb, etc.
> > > > I'd also clarify that userspace still must render the entire screen, i.e.
> > > > make it more clear that it's really just a hint and not mandatory to only
> > > > scan out the damaged parts.
> > > > 
> > > > > +	 */
> > > > > +	struct drm_property *prop_damage_clips;
> > > > > +	/**
> > > > >    	 * @prop_active: Default atomic CRTC property to control the active
> > > > >    	 * state, which is the simplified implementation for DPMS in atomic
> > > > >    	 * drivers.
> > > > > diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> > > > > index f7bf4a4..9f24548 100644
> > > > > --- a/include/drm/drm_plane.h
> > > > > +++ b/include/drm/drm_plane.h
> > > > > @@ -146,6 +146,21 @@ struct drm_plane_state {
> > > > >    	 */
> > > > >    	struct drm_crtc_commit *commit;
> > > > > +	/*
> > > > > +	 * @damage_clips
> > > > > +	 *
> > > > > +	 * blob property with damage as array of drm_rect in framebuffer
> > > > &drm_rect gives you a nice hyperlink in the generated docs.
> > > > 
> > > > > +	 * coodinates.
> > > > > +	 */
> > > > > +	struct drm_property_blob *damage_clips;
> > > > > +
> > > > > +	/*
> > > > > +	 * @num_clips
> > > > > +	 *
> > > > > +	 * Number of drm_rect in @damage_clips.
> > > > > +	 */
> > > > > +	uint32_t num_clips;
> > > > > +
> > > > >    	struct drm_atomic_state *state;
> > > > >    };
> > > > > @@ -611,6 +626,7 @@ int drm_plane_init(struct drm_device *dev,
> > > > >    		   const uint32_t *formats, unsigned int format_count,
> > > > >    		   bool is_primary);
> > > > >    void drm_plane_cleanup(struct drm_plane *plane);
> > > > > +void drm_plane_enable_damage_clips(struct drm_plane *plane);
> > > > >    /**
> > > > >     * drm_plane_index - find the index of a registered plane
> > > > > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> > > > > index 50bcf42..0ad0d5b 100644
> > > > > --- a/include/uapi/drm/drm_mode.h
> > > > > +++ b/include/uapi/drm/drm_mode.h
> > > > > @@ -873,6 +873,21 @@ struct drm_mode_revoke_lease {
> > > > >    	__u32 lessee_id;
> > > > >    };
> > > > > +/**
> > > > > + * struct drm_mode_rect - two dimensional rectangle drm_rect exported to
> > > > > + * user-space.
> > > > > + * @x1: horizontal starting coordinate (inclusive)
> > > > > + * @y1: vertical starting coordinate (inclusive)
> > > > > + * @x2: horizontal ending coordinate (exclusive)
> > > > > + * @y2: vertical ending coordinate (exclusive)
> > > > > + */
> > > > > +struct drm_mode_rect {
> > > > > +	__s32 x1;
> > > > > +	__s32 y1;
> > > > > +	__s32 x2;
> > > > > +	__s32 y2;
> > > > Why signed? Negative damage rects on an fb don't make sense to me. Also,
> > > > please specify what this is exactly (to avoid confusion with the 16.16
> > > > fixed point src rects), and maybe mention in the commit message why we're
> > > > not using drm_clip_rect (going to proper uapi types and 32bit makes sense
> > > > to me).
> > > IMO, while we don't expect negative damage coordinates,
> > > to avoid yet another drm uapi rect in the future when we actually need
> > > negative numbers signed is a good choice...
> > Makes sense. Another thing I realized: Since src rect are 16.16 fixed
> > point, do we really need s32? drm_clip_rect is a bit meh, but it gives us
> > s16 already. That would avoid having to sprinkle the code with tons of
> > overflow checks for input validation.
> 
> IMHO, sooner or later we're going to run into the s16 limitation, and I
> think we should start
> making user-space APIs > 15 bit coordinate safe. I agree this could lead to
> some validation
> grief in the short run, but less to fix up later.

If all the corner-case validation comes with selftests I'm happy to review
them for completeness. I'm not good enough to figure out whether there's
missing stuff by just looking at the validation code generally.

> How difficult is it to make the kernel-internal 16.16 fixed point 48.16?

Since we range-limit properties it should work out. But that means easy
bitshifting will much more likely overflow, and I kinda don't want to
audit all those places for something we don't yet need. Even 8k is still a
bit off from the limit.

Once we have hw that can scan out 32k buffers we'll probably have to fix
up everything :-/
-Daniel
> 
> /Thomas
> 
> 
> > 
> > On the topic of input validation: Should the kernel check in shared code
> > that all the clip rects are sensible, i.e. within the dimensions of the
> > fb? Relying on drivers for that seems like a bad idea.
> > 
> > That could be done in core code in drm_atomic_plane_check().
> > -Daniel
> > > /Thomas
> > > 
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
