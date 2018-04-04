Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeDDR4k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:56:40 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:43296 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeDDR4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:56:38 -0400
X-Google-Smtp-Source: AIpwx492dlv5CcSaIkFC8bOteGUrrhElq45vqaeu95GMHUE+fWeCb2A5CR/0Bgs0JJLisWuOp5NdQ9KTvoEVKzU3Q38=
MIME-Version: 1.0
X-Originating-IP: [212.51.149.109]
In-Reply-To: <4dac69b7-b0e6-a014-1c36-1a9934f14120@tronnes.org>
References: <20180403224225.26776-1-robdclark@gmail.com> <4dac69b7-b0e6-a014-1c36-1a9934f14120@tronnes.org>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 4 Apr 2018 19:56:37 +0200
X-Google-Sender-Auth: iPsbfuq25szl-pYFqTYhvhOv9oU
Message-ID: <CAKMK7uFvjQF-SxPkx_G5Y_o1AHkbms=Dhkie9de3s4JyepyH1g@mail.gmail.com>
Subject: Re: [RFC] drm/atomic+msm: add helper to implement legacy dirtyfb
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepak Singh Rawat <drawat@vmware.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34Huk6h016657

On Wed, Apr 4, 2018 at 7:41 PM, Noralf Trønnes <noralf@tronnes.org> wrote:
>
>
> Den 04.04.2018 00.42, skrev Rob Clark:
>>
>> Add an atomic helper to implement dirtyfb support.  This is needed to
>> support DSI command-mode panels with x11 userspace (ie. when we can't
>> rely on pageflips to trigger a flush to the panel).
>>
>> To signal to the driver that the async atomic update needs to
>> synchronize with fences, even though the fb didn't change, the
>> drm_atomic_state::dirty flag is added.
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> ---
>> Background: there are a number of different folks working on getting
>> upstream kernel working on various different phones/tablets with qcom
>> SoC's.. many of them have command mode panels, so we kind of need a
>> way to support the legacy dirtyfb ioctl for x11 support.
>>
>> I know there is work on a proprer non-legacy atomic property for
>> userspace to communicate dirty-rect(s) to the kernel, so this can
>> be improved from triggering a full-frame flush once that is in
>> place.  But we kinda needa a stop-gap solution.
>>
>> I had considered an in-driver solution for this, but things get a
>> bit tricky if userspace ands up combining dirtyfb ioctls with page-
>> flips, because we need to synchronize setting various CTL.FLUSH bits
>> with setting the CTL.START bit.  (ie. really all we need to do for
>> cmd mode panels is bang CTL.START, but is this ends up racing with
>> pageflips setting FLUSH bits, then bad things.)  The easiest soln
>> is to wrap this up as an atomic commit and rely on the worker to
>> serialize things.  Hence adding an atomic dirtyfb helper.
>>
>> I guess at least the helper, with some small addition to translate
>> and pass-thru the dirty rect(s) is useful to the final atomic dirty-
>> rect property solution.  Depending on how far off that is, a stop-
>> gap solution could be useful.
>
>
> I have been waiting for someone to address this since I'm not skilled
> enough myself to tackle the atomic machinery. It would be be nice to do
> all flushing during commit since that would mean that the tinydrm drivers
> could be driven solely through drm_simple_display_pipe_funcs. I wouldn't
> have to wire through the dirty callback like I do now.
>
> I see that you use a nonblocking commit. What happens if a new dirtyfb
> comes in before the previous is done?

We could reuse the same trick we're doing in the fbdev code, of
pushing the commit to a worker and doing it in a blocking fashion. Or
at least wait for it to finish (can be done with the crtc_state->event
stuff). That way userspace can pile us up in dirtyfb calls, but we'd
do at most one per frame. More isn't really useful anyway.

> If we could save the dirty clips, then I could use this in tinydrm.
> A full flush over SPI takes ~50ms so I need to shave off where I can.
>
> This works for me in my tinydrm world:

One thing I thought you've had around somewhere is some additional
tracking code, so we don't have to take all the plane mutexes in the
->dirtyfb callback. Does that exist, or was that just a figment of my
imagination?

> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index c64225274807..218cb36757fa 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -28,6 +28,7 @@
>  #include <drm/drm_mode_object.h>
>  #include <drm/drm_color_mgmt.h>
>
> +struct drm_clip_rect;
>  struct drm_crtc;
>  struct drm_printer;
>  struct drm_modeset_acquire_ctx;
> @@ -85,6 +86,9 @@ struct drm_plane_state {
>          */
>         bool dirty;
>
> +       struct drm_clip_rect *dirty_clips;
> +       unsigned int num_dirty_clips;
> +
>         /**
>          * @fence:
>          *
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> b/drivers/gpu/drm/drm_atomic_helper.c
> index 8066c508ab50..e00b8247b7c5 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3521,6 +3521,8 @@ void __drm_atomic_helper_plane_duplicate_state(struct
> drm_plane *plane,
>                 drm_framebuffer_get(state->fb);
>
>         state->dirty = false;
> +       state->dirty_clips = NULL;
> +       state->num_dirty_clips = 0;
>         state->fence = NULL;
>         state->commit = NULL;
>  }
> @@ -3567,6 +3569,8 @@ void __drm_atomic_helper_plane_destroy_state(struct
> drm_plane_state *state)
>
>         if (state->commit)
>                 drm_crtc_commit_put(state->commit);
> +
> +       kfree(state->dirty_clips);
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_plane_destroy_state);
>
> @@ -3877,8 +3881,20 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer
> *fb,
>         struct drm_modeset_acquire_ctx ctx;
>         struct drm_atomic_state *state;
>         struct drm_plane *plane;
> +       bool fb_found = false;
>         int ret = 0;
>
> +       /* fbdev can flush even when we don't want it to */
> +       drm_for_each_plane(plane, fb->dev) {
> +               if (plane->state->fb == fb) {
> +                       fb_found = true;
> +                       break;
> +               }
> +       }
> +
> +       if (!fb_found)
> +               return 0;
> +
>         /*
>          * When called from ioctl, we are interruptable, but not when
>          * called internally (ie. defio worker)
> @@ -3907,6 +3923,25 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer
> *fb,
>                 }
>
>                 plane_state->dirty = true;
> +               if (clips && num_clips)
> +                       plane_state->dirty_clips = kmemdup(clips, num_clips
> * sizeof(*clips),
> + GFP_KERNEL);
> +               else
> +                       plane_state->dirty_clips = kzalloc(sizeof(*clips),
> GFP_KERNEL);
> +
> +               if (!plane_state->dirty_clips) {
> +                       ret = -ENOMEM;
> +                       goto out;
> +               }
> +
> +               if (clips && num_clips) {
> +                       plane_state->num_dirty_clips = num_clips;
> +               } else {
> +                       /* TODO: Maybe choose better max values */
> +                       plane_state->dirty_clips->x2 = ~0;
> +                       plane_state->dirty_clips->y2 = ~0;
> +                       plane_state->num_dirty_clips = 1;

Either we fill this out for all legacy paths, or we just require that
drivers upload everything when num_clips == 0. The trouble with having
num_clips == 0 imply a full upload is that we can't do a pure pan
without having to set a dummy clip rect of 0 size. Which is also
silly.

So I'm leaning towards going through all the legacy ioctl paths (well,
at least the ones where we agree it should result in a full upload,
cursor probably excluded) and setting up a clip rect with max values
like above for all of them.

And we'd need to remove the ->dirty bit then I think, since it'd be
entirely redundant.

Cheers, Daniel

> +               }
>         }
>
>         ret = drm_atomic_nonblocking_commit(state);
> diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
> b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
> index e68b528ae64d..1a0c72c496f6 100644
> --- a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
> +++ b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
> @@ -121,12 +121,14 @@ void tinydrm_display_pipe_update(struct
> drm_simple_display_pipe *pipe,
>                                  struct drm_plane_state *old_state)
>  {
>         struct tinydrm_device *tdev = pipe_to_tinydrm(pipe);
> -       struct drm_framebuffer *fb = pipe->plane.state->fb;
> +       struct drm_plane_state *new_state = pipe->plane.state;
> +       struct drm_framebuffer *fb = new_state->fb;
>         struct drm_crtc *crtc = &tdev->pipe.crtc;
>
> -       if (fb && (fb != old_state->fb)) {
> +       if (fb && ((fb != old_state->fb) || new_state->dirty_clips)) {
>                 if (tdev->fb_dirty)
> -                       tdev->fb_dirty(fb, NULL, 0, 0, NULL, 0);
> +                       tdev->fb_dirty(fb, NULL, 0, 0,
> new_state->dirty_clips,
> + new_state->num_dirty_clips);
>         }
>
>         if (crtc->state->event) {
> diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c
> b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> index 4d1fb31a781f..49dee24dde60 100644
> --- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
> +++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> @@ -9,6 +9,7 @@
>   * (at your option) any later version.
>   */
>
> +#include <drm/drm_atomic_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/tinydrm/mipi-dbi.h>
>  #include <drm/tinydrm/tinydrm-helpers.h>
> @@ -254,7 +257,7 @@ static int mipi_dbi_fb_dirty(struct drm_framebuffer *fb,
>  static const struct drm_framebuffer_funcs mipi_dbi_fb_funcs = {
>         .destroy        = drm_gem_fb_destroy,
>         .create_handle  = drm_gem_fb_create_handle,
> -       .dirty          = tinydrm_fb_dirty,
> +       .dirty          = drm_atomic_helper_dirtyfb,
>  };
>
>  /**
>
>
> I did some brief testing a few months back with PRIME buffers imported
> from vc4 and it looked like X11 sometimes did a page flip followed by a
> dirtyfb. This kills performance for me since I flush on both. Do you know
> any details on how/where X11 handles this?
>
> Noralf.
>
>
>>   drivers/gpu/drm/drm_atomic_helper.c | 66
>> +++++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/msm_atomic.c    |  5 ++-
>>   drivers/gpu/drm/msm/msm_fb.c        |  1 +
>>   include/drm/drm_atomic_helper.h     |  4 +++
>>   include/drm/drm_plane.h             |  9 +++++
>>   5 files changed, 84 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c
>> b/drivers/gpu/drm/drm_atomic_helper.c
>> index c35654591c12..a578dc681b27 100644
>> --- a/drivers/gpu/drm/drm_atomic_helper.c
>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
>> @@ -3504,6 +3504,7 @@ void
>> __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
>>         if (state->fb)
>>                 drm_framebuffer_get(state->fb);
>>   +     state->dirty = false;
>>         state->fence = NULL;
>>         state->commit = NULL;
>>   }
>> @@ -3847,6 +3848,71 @@ int drm_atomic_helper_legacy_gamma_set(struct
>> drm_crtc *crtc,
>>   }
>>   EXPORT_SYMBOL(drm_atomic_helper_legacy_gamma_set);
>>   +/**
>> + * drm_atomic_helper_dirtyfb - helper for dirtyfb
>> + *
>> + * A helper to implement drm_framebuffer_funcs::dirty
>> + */
>> +int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>> +                             struct drm_file *file_priv, unsigned flags,
>> +                             unsigned color, struct drm_clip_rect *clips,
>> +                             unsigned num_clips)
>> +{
>> +       struct drm_modeset_acquire_ctx ctx;
>> +       struct drm_atomic_state *state;
>> +       struct drm_plane *plane;
>> +       int ret = 0;
>> +
>> +       /*
>> +        * When called from ioctl, we are interruptable, but not when
>> +        * called internally (ie. defio worker)
>> +        */
>> +       drm_modeset_acquire_init(&ctx,
>> +               file_priv ? DRM_MODESET_ACQUIRE_INTERRUPTIBLE : 0);
>> +
>> +       state = drm_atomic_state_alloc(fb->dev);
>> +       if (!state) {
>> +               ret = -ENOMEM;
>> +               goto out;
>> +       }
>> +       state->acquire_ctx = &ctx;
>> +
>> +retry:
>> +       drm_for_each_plane(plane, fb->dev) {
>> +               struct drm_plane_state *plane_state;
>> +
>> +               if (plane->state->fb != fb)
>> +                       continue;
>> +
>> +               plane_state = drm_atomic_get_plane_state(state, plane);
>> +               if (IS_ERR(plane_state)) {
>> +                       ret = PTR_ERR(plane_state);
>> +                       goto out;
>> +               }
>> +
>> +               plane_state->dirty = true;
>> +       }
>> +
>> +       ret = drm_atomic_nonblocking_commit(state);
>> +
>> +out:
>> +       if (ret == -EDEADLK) {
>> +               drm_atomic_state_clear(state);
>> +               ret = drm_modeset_backoff(&ctx);
>> +               if (!ret)
>> +                       goto retry;
>> +       }
>> +
>> +       drm_atomic_state_put(state);
>> +
>> +       drm_modeset_drop_locks(&ctx);
>> +       drm_modeset_acquire_fini(&ctx);
>> +
>> +       return ret;
>> +
>> +}
>> +EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
>> +
>>   /**
>>    * __drm_atomic_helper_private_duplicate_state - copy atomic private
>> state
>>    * @obj: CRTC object
>> diff --git a/drivers/gpu/drm/msm/msm_atomic.c
>> b/drivers/gpu/drm/msm/msm_atomic.c
>> index bf5f8c39f34d..bb55a048e98b 100644
>> --- a/drivers/gpu/drm/msm/msm_atomic.c
>> +++ b/drivers/gpu/drm/msm/msm_atomic.c
>> @@ -201,7 +201,10 @@ int msm_atomic_commit(struct drm_device *dev,
>>          * Figure out what fence to wait for:
>>          */
>>         for_each_oldnew_plane_in_state(state, plane, old_plane_state,
>> new_plane_state, i) {
>> -               if ((new_plane_state->fb != old_plane_state->fb) &&
>> new_plane_state->fb) {
>> +               bool sync_fb = new_plane_state->fb &&
>> +                       ((new_plane_state->fb != old_plane_state->fb) ||
>> +                        new_plane_state->dirty);
>> +               if (sync_fb) {
>>                         struct drm_gem_object *obj =
>> msm_framebuffer_bo(new_plane_state->fb, 0);
>>                         struct msm_gem_object *msm_obj = to_msm_bo(obj);
>>                         struct dma_fence *fence =
>> reservation_object_get_excl_rcu(msm_obj->resv);
>> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
>> index 0e0c87252ab0..a5d882a34a33 100644
>> --- a/drivers/gpu/drm/msm/msm_fb.c
>> +++ b/drivers/gpu/drm/msm/msm_fb.c
>> @@ -62,6 +62,7 @@ static void msm_framebuffer_destroy(struct
>> drm_framebuffer *fb)
>>   static const struct drm_framebuffer_funcs msm_framebuffer_funcs = {
>>         .create_handle = msm_framebuffer_create_handle,
>>         .destroy = msm_framebuffer_destroy,
>> +       .dirty = drm_atomic_helper_dirtyfb,
>>   };
>>     #ifdef CONFIG_DEBUG_FS
>> diff --git a/include/drm/drm_atomic_helper.h
>> b/include/drm/drm_atomic_helper.h
>> index 26aaba58d6ce..9b7a95c2643d 100644
>> --- a/include/drm/drm_atomic_helper.h
>> +++ b/include/drm/drm_atomic_helper.h
>> @@ -183,6 +183,10 @@ int drm_atomic_helper_legacy_gamma_set(struct
>> drm_crtc *crtc,
>>                                        u16 *red, u16 *green, u16 *blue,
>>                                        uint32_t size,
>>                                        struct drm_modeset_acquire_ctx
>> *ctx);
>> +int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>> +                             struct drm_file *file_priv, unsigned flags,
>> +                             unsigned color, struct drm_clip_rect *clips,
>> +                             unsigned num_clips);
>>   void __drm_atomic_helper_private_obj_duplicate_state(struct
>> drm_private_obj *obj,
>>                                                      struct
>> drm_private_state *state);
>>   diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
>> index f7bf4a48b1c3..296fa22bda7a 100644
>> --- a/include/drm/drm_plane.h
>> +++ b/include/drm/drm_plane.h
>> @@ -76,6 +76,15 @@ struct drm_plane_state {
>>          */
>>         struct drm_framebuffer *fb;
>>   +     /**
>> +        * @dirty:
>> +        *
>> +        * Flag that indicates the fb contents have changed even though
>> the
>> +        * fb has not.  This is mostly a stop-gap solution until we have
>> +        * atomic dirty-rect(s) property.
>> +        */
>> +       bool dirty;
>> +
>>         /**
>>          * @fence:
>>          *
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
