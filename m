Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeDEKKN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:10:13 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:52096 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeDEKKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:10:11 -0400
X-Google-Smtp-Source: AIpwx49ICyGhWd2dlmydNJIhEWeeAVY9dZbsrszb7VHMFyK0o5HH635tzN15i7UeG/0jPSL9BgwnMg==
Date: Thu, 5 Apr 2018 12:10:07 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/3] drm: Add helper iterator functions to iterate over
 plane damage.
Message-ID: <20180405101007.GU3881@phenom.ffwll.local>
Mail-Followup-To: Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-3-git-send-email-drawat@vmware.com>
 <20180405075205.GQ3881@phenom.ffwll.local>
 <0edfe662-6463-a143-e00a-d3d4bc06a229@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0edfe662-6463-a143-e00a-d3d4bc06a229@vmware.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 10:49:09AM +0200, Thomas Hellstrom wrote:
> On 04/05/2018 09:52 AM, Daniel Vetter wrote:
> > On Wed, Apr 04, 2018 at 04:49:07PM -0700, Deepak Rawat wrote:
> > > With damage property in drm_plane_state, this patch adds helper iterator
> > > to traverse the damage clips. Iterator will return the damage rectangles
> > > in framebuffer, plane or crtc coordinates as need by driver
> > > implementation.
> > > 
> > > Signed-off-by: Deepak Rawat <drawat@vmware.com>
> > I'd really like selftest/unittests for this stuff. There's an awful lot of
> > cornercases in this here (for any of the transformed iterators at least),
> > and unit tests is the best way to make sure we handle them all correctly.
> > 
> > Bonus points if you integrate the new selftests into igt so intel CI can
> > run them, seel igt/tests/drm_mm.c for an example. drm_mm selftest is also
> > the framework I'd copy for this stuff.
> > 
> > > ---
> > >   drivers/gpu/drm/drm_atomic_helper.c | 122 ++++++++++++++++++++++++++++++++++++
> > >   include/drm/drm_atomic_helper.h     |  39 ++++++++++++
> > >   2 files changed, 161 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > > index 55b44e3..355b514 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -3865,3 +3865,125 @@ void __drm_atomic_helper_private_obj_duplicate_state(struct drm_private_obj *obj
> > >   	memcpy(state, obj->state, sizeof(*state));
> > >   }
> > >   EXPORT_SYMBOL(__drm_atomic_helper_private_obj_duplicate_state);
> > > +
> > > +/**
> > > + * drm_atomic_helper_damage_iter_init - initialize the damage iterator
> > > + * @iter: The iterator to initialize.
> > > + * @type: Coordinate type caller is interested in.
> > > + * @state: plane_state from which to iterate the damage clips.
> > > + * @hdisplay: Width of crtc on which plane is scanned out.
> > > + * @vdisplay: Height of crtc on which plane is scanned out.
> > > + *
> > > + * Initialize an iterator that is used to translate and clip a set of damage
> > > + * rectangles in framebuffer coordinates to plane and crtc coordinates. The type
> > > + * argument specify which type of coordinate to iterate in.
> > > + *
> > > + * Returns: 0 on success and negative error code on error. If an error code is
> > > + * returned then it means the plane state should not update.
> > > + */
> > > +int
> > > +drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
> > > +				   enum drm_atomic_helper_damage_clip_type type,
> > > +				   const struct drm_plane_state *state,
> > > +				   uint32_t hdisplay, uint32_t vdisplay)
> > > +{
> > > +	if (!state || !state->crtc || !state->fb)
> > > +		return -EINVAL;
> > > +
> > > +	memset(iter, 0, sizeof(*iter));
> > > +	iter->clips = (struct drm_rect *)state->damage_clips->data;
> > > +	iter->num_clips = state->num_clips;
> > > +	iter->type = type;
> > > +
> > > +	/*
> > > +	 * Full update in case of scaling or rotation. In future support for
> > > +	 * scaling/rotating damage clips can be added
> > > +	 */
> > > +	if (state->crtc_w != (state->src_w >> 16) ||
> > > +	    state->crtc_h != state->src_h >> 16 || state->rotation != 0) {
> > > +		iter->curr_clip = iter->num_clips;
> > > +		return 0;
> > Given there's no user of this I have no idea how this manages to provoke a
> > full clip rect. selftest code would be perfect for stuff like this.
> > 
> > Also, I think we should provide a full clip for the case of num_clips ==
> > 0, so that driver code can simply iterate over all clips and doesn't ever
> > have to handle the "no clip rects provided" case as a special case itself.
> > 
> > > +	}
> > > +
> > > +	iter->fb_src.x1 = 0;
> > > +	iter->fb_src.y1 = 0;
> > > +	iter->fb_src.x2 = state->fb->width;
> > > +	iter->fb_src.y2 = state->fb->height;
> > > +
> > > +	iter->plane_src.x1 = state->src_x >> 16;
> > > +	iter->plane_src.y1 = state->src_y >> 16;
> > > +	iter->plane_src.x2 = iter->plane_src.x1 + (state->src_w >> 16);
> > > +	iter->plane_src.y2 = iter->plane_src.y1 + (state->src_h >> 16);
> > > +	iter->translate_plane_x = -iter->plane_src.x1;
> > > +	iter->translate_plane_y = -iter->plane_src.y1;
> > > +
> > > +	/* Clip plane src rect to fb dimensions */
> > > +	drm_rect_intersect(&iter->plane_src, &iter->fb_src);
> > This smells like driver bug. Also, see Ville's recent efforts to improve
> > the atomic plane clipping, I think drm_plane_state already has all the
> > clip rects you want.
> > 
> > > +
> > > +	iter->crtc_src.x1 = 0;
> > > +	iter->crtc_src.y1 = 0;
> > > +	iter->crtc_src.x2 = hdisplay;
> > > +	iter->crtc_src.y2 = vdisplay;
> > > +	iter->translate_crtc_x = -(iter->plane_src.x1 - state->crtc_x);
> > > +	iter->translate_crtc_x = -(iter->plane_src.y1 - state->crtc_y);
> > > +
> > > +	/* Clip crtc src rect to plane dimensions */
> > > +	drm_rect_translate(&iter->crtc_src, -iter->translate_crtc_x,
> > > +			   -iter->translate_crtc_x);
> > We can also scale.
> 
> I suggest we leave out scaling for now until someone actually needs it.

In that case we need to WARN_ON and bail out if there's scaling going on.
I'm totally fine with not solving the world here, but please no trapdoors
for following driver's use-cases.

> 
> > 
> > > +	drm_rect_intersect(&iter->crtc_src, &iter->plane_src);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(drm_atomic_helper_damage_iter_init);
> > > +
> > > +/**
> > > + * drm_atomic_helper_damage_iter_next - advance the damage iterator
> > > + * @iter: The iterator to advance.
> > > + * @rect: Return a rectangle in coordinate specified during iterator init.
> > > + *
> > > + * Returns:  true if the output is valid, false if we've reached the end of the
> > > + * rectangle list. If the first call return false, means need full update.
> > > + */
> > > +bool
> > > +drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
> > > +				   struct drm_rect *rect)
> > > +{
> > > +	const struct drm_rect *curr_clip;
> > > +
> > > +next_clip:
> > > +	if (iter->curr_clip >= iter->num_clips)
> > > +		return false;
> > > +
> > > +	curr_clip = &iter->clips[iter->curr_clip];
> > > +	iter->curr_clip++;
> > > +
> > > +	rect->x1 = curr_clip->x1;
> > > +	rect->x2 = curr_clip->x2;
> > > +	rect->y1 = curr_clip->y1;
> > > +	rect->y2 = curr_clip->y2;
> > > +
> > > +	/* Clip damage rect within fb limit */
> > > +	if (!drm_rect_intersect(rect, &iter->fb_src))
> > > +		goto next_clip;
> > > +	else if (iter->type & DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_FB)
> > > +		return true;
> > > +
> > > +	/* Clip damage rect within plane limit */
> > > +	if (!drm_rect_intersect(rect, &iter->plane_src))
> > > +		goto next_clip;
> > > +	else if (iter->type & DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_PLANE) {
> > > +		drm_rect_translate(rect, iter->translate_plane_x,
> > > +				   iter->translate_plane_y);
> > > +		return true;
> > > +	}
> > > +
> > > +	/* Clip damage rect within crtc limit */
> > > +	if (!drm_rect_intersect(rect, &iter->crtc_src))
> > > +		goto next_clip;
> > > +
> > > +	drm_rect_translate(rect, iter->translate_crtc_x,
> > > +			   iter->translate_crtc_y);
> > > +
> > > +	return true;
> > > +}
> > > +EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
> > > diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> > > index 26aaba5..ebd4b66 100644
> > > --- a/include/drm/drm_atomic_helper.h
> > > +++ b/include/drm/drm_atomic_helper.h
> > > @@ -36,6 +36,37 @@ struct drm_atomic_state;
> > >   struct drm_private_obj;
> > >   struct drm_private_state;
> > > +/**
> > > + * enum drm_atomic_helper_damage_clip_type - type of clips to iterator over
> > > + *
> > > + * While using drm_atomic_helper_damage_iter the type of clip coordinates caller
> > > + * is interested in.
> > > + */
> > > +enum drm_atomic_helper_damage_clip_type {
> > > +	DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_FB       = 0x0,
> > > +	DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_PLANE    = 0x1,
> > > +	DRM_ATOMIC_HELPER_DAMAGE_CLIP_TYPE_CRTC     = 0x2,
> > I'm confused with what exactly these different types of iterators are
> > supposed to achieve. TYPE_FB makes sense, that's what vmwgfx and other
> > virtual drivers need to figure out which parts of a buffer to upload to
> > the host.
> > 
> > TYPE_PLANE I have no idea who needs that. I suggest we just drop it.
> > 
> > TYPE_CRTC is what I'd want to use for manual upload hw, were instead of
> > compositing the entire screen we can limit the uploaded area to 1 or 2
> > rectangles (depending upon how the hw works). But those drivers want all
> > the crtc clip rects for _all_ the planes combined, not for each plane
> > individually.
> > 
> > My suggestion is to drop TYPE_CRTC until someone needs it for a driver.
> > And most likely the only iterator we want for TYPE_CRTC is one that gives
> > you the overall damage area, including alpha/ctm/gamma/everything else,
> > coalesced into just 1 clip rect. So probably an entirely different
> > function.
> 
> Actually for vmwgfx, the display part of the hardware comes in different
> versions and we'd typically expect both the FB coordinates and the CRTC
> coordinates. In the latest version the surface backing the screen needs to
> exactly fit the CRTC scanout area, and if the FB doesn't do that, we need to
> create a surface that does and copy in the kernel driver. After that, as a
> second step, we need to notify the display system of the damaged area in
> CRTC coordinates.

Hm, that's an unexpected use-case. I'm leaning towards just having a fb
coordination iterator and adjusting the static offset in vmwgfx code. Your
use-case is rather different from manual upload screens I think, so having
a CRTC damage iterator which doesn't actually do what most other drivers
want will be confusing.

And since it's just a static drm_rect_translate for you it'll be only 1
additional line in vmwgfx. Imo that's worth the safer/cleaner semantics
for the core helpers.

Manual upload hw driver use case here means:
- Multiple planes, positioned all over the screen.
- Definitely scaling involved.
- Alpha, gamma, blending all matter (since it's only the final composited
  pixel value we decide to upload or not upload), and the hw with psr/dsi
  panels tend to all have rather fancy hw composition engines.
- Just 1 or 2 rectangles in CRTC coordinates.

Your CRTC coordination use case otoh is simply fallout from your
requirement that you can't position the framebuffer anywhere else than at
0,0, with size exactly matching the screen, plus the reasonable decision
to handle that impendence mismatch in your driver (since userspace will be
unhappy about this, at least generic one).

I think even as far as virtual hardware guess, that's fairly special, and
probably not the case we should optimize helpers for.

Thoughts?

Thanks, Daniel

> > Summarizing all this, I'd simplify the iterator to:
> > 
> > drm_atomic_helper_damage_iter_init(iter, plane_state);
> > 
> > And leave the other 2 use-cases to the next patch series. For crtc damage
> > we probably want:
> > 
> > drm_atomic_helper_crtc_damage(drm_atomic_state, rect)
> > 
> > Which internally loops over all planes and also takes all the other state
> > changes into account. That way you also don't have to fix the scaling
> > issue, since your current code only handles translation.
> > 
> > Another bit: drm_atomic_helper.c is huge, I'd vote to put all this stuff
> > into a new drm_damage_helper.[hc], including new section in drm-kms.rst
> > and all that. Splitting up drm_atomic_helper.[hc] is somewhere on my todo
> > ...
> > 
> > Cheers, Daniel
> 
> /Thomas
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
