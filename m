Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeDDLgC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:36:02 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42728 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeDDLf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:35:59 -0400
X-Google-Smtp-Source: AIpwx4+PI14yrzUasEbEAGPAMEkAOIXY3mM5XEuJFmMWeVBRbJ2Ps7fSnHsJQISa6D+zO/nhwuEiXSOHjdokrE8M1Ik=
MIME-Version: 1.0
In-Reply-To: <20180404102108.GF3881@phenom.ffwll.local>
References: <20180403224225.26776-1-robdclark@gmail.com> <20180404100300.GE3881@phenom.ffwll.local>
 <20180404102108.GF3881@phenom.ffwll.local>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 4 Apr 2018 07:35:58 -0400
Message-ID: <CAF6AEGtowtdQmUxNF_F3B3Yow+PDB43Eb0VJ_ZqGKpVw1iZBzA@mail.gmail.com>
Subject: Re: [RFC] drm/atomic+msm: add helper to implement legacy dirtyfb
To: Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thomas Hellstrom <thomas@shipmail.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>,
        Deepak Singh Rawat <drawat@vmware.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 6:21 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Apr 04, 2018 at 12:03:00PM +0200, Daniel Vetter wrote:
>> On Tue, Apr 03, 2018 at 06:42:23PM -0400, Rob Clark wrote:
>> > Add an atomic helper to implement dirtyfb support.  This is needed to
>> > support DSI command-mode panels with x11 userspace (ie. when we can't
>> > rely on pageflips to trigger a flush to the panel).
>> >
>> > To signal to the driver that the async atomic update needs to
>> > synchronize with fences, even though the fb didn't change, the
>> > drm_atomic_state::dirty flag is added.
>> >
>> > Signed-off-by: Rob Clark <robdclark@gmail.com>
>> > ---
>> > Background: there are a number of different folks working on getting
>> > upstream kernel working on various different phones/tablets with qcom
>> > SoC's.. many of them have command mode panels, so we kind of need a
>> > way to support the legacy dirtyfb ioctl for x11 support.
>> >
>> > I know there is work on a proprer non-legacy atomic property for
>> > userspace to communicate dirty-rect(s) to the kernel, so this can
>> > be improved from triggering a full-frame flush once that is in
>> > place.  But we kinda needa a stop-gap solution.
>> >
>> > I had considered an in-driver solution for this, but things get a
>> > bit tricky if userspace ands up combining dirtyfb ioctls with page-
>> > flips, because we need to synchronize setting various CTL.FLUSH bits
>> > with setting the CTL.START bit.  (ie. really all we need to do for
>> > cmd mode panels is bang CTL.START, but is this ends up racing with
>> > pageflips setting FLUSH bits, then bad things.)  The easiest soln
>> > is to wrap this up as an atomic commit and rely on the worker to
>> > serialize things.  Hence adding an atomic dirtyfb helper.
>> >
>> > I guess at least the helper, with some small addition to translate
>> > and pass-thru the dirty rect(s) is useful to the final atomic dirty-
>> > rect property solution.  Depending on how far off that is, a stop-
>> > gap solution could be useful.
>> >
>> >  drivers/gpu/drm/drm_atomic_helper.c | 66 +++++++++++++++++++++++++++++++++++++
>> >  drivers/gpu/drm/msm/msm_atomic.c    |  5 ++-
>> >  drivers/gpu/drm/msm/msm_fb.c        |  1 +
>> >  include/drm/drm_atomic_helper.h     |  4 +++
>> >  include/drm/drm_plane.h             |  9 +++++
>> >  5 files changed, 84 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>> > index c35654591c12..a578dc681b27 100644
>> > --- a/drivers/gpu/drm/drm_atomic_helper.c
>> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
>> > @@ -3504,6 +3504,7 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
>> >     if (state->fb)
>> >             drm_framebuffer_get(state->fb);
>> >
>> > +   state->dirty = false;
>> >     state->fence = NULL;
>> >     state->commit = NULL;
>> >  }
>> > @@ -3847,6 +3848,71 @@ int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
>> >  }
>> >  EXPORT_SYMBOL(drm_atomic_helper_legacy_gamma_set);
>> >
>> > +/**
>> > + * drm_atomic_helper_dirtyfb - helper for dirtyfb
>> > + *
>> > + * A helper to implement drm_framebuffer_funcs::dirty
>> > + */
>> > +int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>> > +                         struct drm_file *file_priv, unsigned flags,
>> > +                         unsigned color, struct drm_clip_rect *clips,
>> > +                         unsigned num_clips)
>> > +{
>> > +   struct drm_modeset_acquire_ctx ctx;
>> > +   struct drm_atomic_state *state;
>> > +   struct drm_plane *plane;
>> > +   int ret = 0;
>> > +
>> > +   /*
>> > +    * When called from ioctl, we are interruptable, but not when
>> > +    * called internally (ie. defio worker)
>> > +    */
>> > +   drm_modeset_acquire_init(&ctx,
>> > +           file_priv ? DRM_MODESET_ACQUIRE_INTERRUPTIBLE : 0);
>> > +
>> > +   state = drm_atomic_state_alloc(fb->dev);
>> > +   if (!state) {
>> > +           ret = -ENOMEM;
>> > +           goto out;
>> > +   }
>> > +   state->acquire_ctx = &ctx;
>> > +
>> > +retry:
>> > +   drm_for_each_plane(plane, fb->dev) {
>> > +           struct drm_plane_state *plane_state;
>> > +
>> > +           if (plane->state->fb != fb)
>> > +                   continue;
>> > +
>> > +           plane_state = drm_atomic_get_plane_state(state, plane);
>> > +           if (IS_ERR(plane_state)) {
>> > +                   ret = PTR_ERR(plane_state);
>> > +                   goto out;
>> > +           }
>> > +
>> > +           plane_state->dirty = true;
>> > +   }
>> > +
>> > +   ret = drm_atomic_nonblocking_commit(state);
>> > +
>> > +out:
>> > +   if (ret == -EDEADLK) {
>> > +           drm_atomic_state_clear(state);
>> > +           ret = drm_modeset_backoff(&ctx);
>> > +           if (!ret)
>> > +                   goto retry;
>> > +   }
>> > +
>> > +   drm_atomic_state_put(state);
>> > +
>> > +   drm_modeset_drop_locks(&ctx);
>> > +   drm_modeset_acquire_fini(&ctx);
>> > +
>> > +   return ret;
>> > +
>> > +}
>> > +EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
>> > +
>> >  /**
>> >   * __drm_atomic_helper_private_duplicate_state - copy atomic private state
>> >   * @obj: CRTC object
>> > diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
>> > index bf5f8c39f34d..bb55a048e98b 100644
>> > --- a/drivers/gpu/drm/msm/msm_atomic.c
>> > +++ b/drivers/gpu/drm/msm/msm_atomic.c
>> > @@ -201,7 +201,10 @@ int msm_atomic_commit(struct drm_device *dev,
>> >      * Figure out what fence to wait for:
>> >      */
>> >     for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
>> > -           if ((new_plane_state->fb != old_plane_state->fb) && new_plane_state->fb) {
>> > +           bool sync_fb = new_plane_state->fb &&
>> > +                   ((new_plane_state->fb != old_plane_state->fb) ||
>> > +                    new_plane_state->dirty);
>>
>> Why do you have this optimization even here? Imo flipping to the same fb
>> should result in the fb getting fully uploaded, whether you're doing a
>> legacy page_flip, and atomic one or just a plane update.
>>
>> Iirc some userspace does use that as essentially a full-plane frontbuffer
>> rendering flush already. IOW I don't think we need your
>> plane_state->dirty, it's implied to always be true - why would userspace
>> do a flip otherwise?
>>
>> The helper itself to map dirtyfb to a nonblocking atomic commit looks
>> reasonable, but misses a bunch of the trickery discussed with Noralf and
>> others I think.
>
> Ok, I've done some history digging:
>
> - i915 and nouveau unconditionally wait for fences, even for same-fb
>   flips.
> - no idea what amdgpu and vmwgfx are doing, they're not using
>   plane_state->fence for implicit fences.
> - most arm-soc drivers do have this "optimization" in their code, and it
>   even managed to get into the new drm_gem_fb_prepare_fb helper (which I
>   reviewed, or well claimed to have ... oops). Afaict it goes back to the
>   original msm atomic code, and was then dutifully copypasted all over the
>   place.
>
> If folks are ok I'll do a patch series to align drivers with i915/nouveau.
> Well, any driver using reservation_object_get_excl_rcu +
> drm_atomic_set_fence_for_plane combo, since amdgpu and vmwgfx don't I have
> no idea what they're doing or whether they might have the same bug.

if you do a patch series, I think do it the other way around and align
to msm ;-)

I think otherwise we could end up stalling while x11 does front buffer
rendering for something unrelated (maybe I was hitting that with
cursor updates?)

BR,
-R

> From looking at at least the various prepare_fb callbacks I don't see any
> other drivers doing funny stuff around implicit fences.
> -Daniel
>
>> > +           if (sync_fb) {
>> >                     struct drm_gem_object *obj = msm_framebuffer_bo(new_plane_state->fb, 0);
>> >                     struct msm_gem_object *msm_obj = to_msm_bo(obj);
>> >                     struct dma_fence *fence = reservation_object_get_excl_rcu(msm_obj->resv);
>> > diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
>> > index 0e0c87252ab0..a5d882a34a33 100644
>> > --- a/drivers/gpu/drm/msm/msm_fb.c
>> > +++ b/drivers/gpu/drm/msm/msm_fb.c
>> > @@ -62,6 +62,7 @@ static void msm_framebuffer_destroy(struct drm_framebuffer *fb)
>> >  static const struct drm_framebuffer_funcs msm_framebuffer_funcs = {
>> >     .create_handle = msm_framebuffer_create_handle,
>> >     .destroy = msm_framebuffer_destroy,
>> > +   .dirty = drm_atomic_helper_dirtyfb,
>> >  };
>> >
>> >  #ifdef CONFIG_DEBUG_FS
>> > diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
>> > index 26aaba58d6ce..9b7a95c2643d 100644
>> > --- a/include/drm/drm_atomic_helper.h
>> > +++ b/include/drm/drm_atomic_helper.h
>> > @@ -183,6 +183,10 @@ int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
>> >                                    u16 *red, u16 *green, u16 *blue,
>> >                                    uint32_t size,
>> >                                    struct drm_modeset_acquire_ctx *ctx);
>> > +int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>> > +                         struct drm_file *file_priv, unsigned flags,
>> > +                         unsigned color, struct drm_clip_rect *clips,
>> > +                         unsigned num_clips);
>> >  void __drm_atomic_helper_private_obj_duplicate_state(struct drm_private_obj *obj,
>> >                                                  struct drm_private_state *state);
>> >
>> > diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
>> > index f7bf4a48b1c3..296fa22bda7a 100644
>> > --- a/include/drm/drm_plane.h
>> > +++ b/include/drm/drm_plane.h
>> > @@ -76,6 +76,15 @@ struct drm_plane_state {
>> >      */
>> >     struct drm_framebuffer *fb;
>> >
>> > +   /**
>> > +    * @dirty:
>> > +    *
>> > +    * Flag that indicates the fb contents have changed even though the
>> > +    * fb has not.  This is mostly a stop-gap solution until we have
>> > +    * atomic dirty-rect(s) property.
>> > +    */
>> > +   bool dirty;
>> > +
>> >     /**
>> >      * @fence:
>> >      *
>> > --
>> > 2.14.3
>> >
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
