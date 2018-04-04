Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeDDM2U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:28:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:56492 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeDDM2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:28:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,406,1517904000";
   d="scan'208";a="31455653"
Subject: Re: [RFC] drm/atomic+msm: add helper to implement legacy dirtyfb
To: Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>
Cc: David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Deepak Singh Rawat <drawat@vmware.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
References: <20180403224225.26776-1-robdclark@gmail.com>
 <20180404100300.GE3881@phenom.ffwll.local>
 <20180404102108.GF3881@phenom.ffwll.local>
 <4976c166-32b2-75ef-ee78-7e7893dd4121@linux.intel.com>
 <CAF6AEGvozzCDtkRjCjMsZ5HtdHXbFiiVM52jZaz=VfshONzqTA@mail.gmail.com>
 <4386c0a5-e8e4-34d7-a977-4136e1dec44f@linux.intel.com>
 <CAF6AEGtzFJwzgrH5TZn6QGLjkkOP7=XV4B1at6xxNvKrabNFww@mail.gmail.com>
 <CAKMK7uEMsUOFDWishv6L0519Z7eiz+7LcHMpQAZu1bO7i2dVDA@mail.gmail.com>
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <d1be391c-ef8e-4f81-710c-8a21ff41b8c0@linux.intel.com>
Date: Wed, 4 Apr 2018 14:28:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uEMsUOFDWishv6L0519Z7eiz+7LcHMpQAZu1bO7i2dVDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 04-04-18 om 14:26 schreef Daniel Vetter:
> On Wed, Apr 4, 2018 at 2:05 PM, Rob Clark <robdclark@gmail.com> wrote:
>> On Wed, Apr 4, 2018 at 7:49 AM, Maarten Lankhorst
>> <maarten.lankhorst@linux.intel.com> wrote:
>>> Op 04-04-18 om 13:37 schreef Rob Clark:
>>>> On Wed, Apr 4, 2018 at 6:36 AM, Maarten Lankhorst
>>>> <maarten.lankhorst@linux.intel.com> wrote:
>>>>> Op 04-04-18 om 12:21 schreef Daniel Vetter:
>>>>>> On Wed, Apr 04, 2018 at 12:03:00PM +0200, Daniel Vetter wrote:
>>>>>>> On Tue, Apr 03, 2018 at 06:42:23PM -0400, Rob Clark wrote:
>>>>>>>> Add an atomic helper to implement dirtyfb support.  This is needed to
>>>>>>>> support DSI command-mode panels with x11 userspace (ie. when we can't
>>>>>>>> rely on pageflips to trigger a flush to the panel).
>>>>>>>>
>>>>>>>> To signal to the driver that the async atomic update needs to
>>>>>>>> synchronize with fences, even though the fb didn't change, the
>>>>>>>> drm_atomic_state::dirty flag is added.
>>>>>>>>
>>>>>>>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>>>>>>>> ---
>>>>>>>> Background: there are a number of different folks working on getting
>>>>>>>> upstream kernel working on various different phones/tablets with qcom
>>>>>>>> SoC's.. many of them have command mode panels, so we kind of need a
>>>>>>>> way to support the legacy dirtyfb ioctl for x11 support.
>>>>>>>>
>>>>>>>> I know there is work on a proprer non-legacy atomic property for
>>>>>>>> userspace to communicate dirty-rect(s) to the kernel, so this can
>>>>>>>> be improved from triggering a full-frame flush once that is in
>>>>>>>> place.  But we kinda needa a stop-gap solution.
>>>>>>>>
>>>>>>>> I had considered an in-driver solution for this, but things get a
>>>>>>>> bit tricky if userspace ands up combining dirtyfb ioctls with page-
>>>>>>>> flips, because we need to synchronize setting various CTL.FLUSH bits
>>>>>>>> with setting the CTL.START bit.  (ie. really all we need to do for
>>>>>>>> cmd mode panels is bang CTL.START, but is this ends up racing with
>>>>>>>> pageflips setting FLUSH bits, then bad things.)  The easiest soln
>>>>>>>> is to wrap this up as an atomic commit and rely on the worker to
>>>>>>>> serialize things.  Hence adding an atomic dirtyfb helper.
>>>>>>>>
>>>>>>>> I guess at least the helper, with some small addition to translate
>>>>>>>> and pass-thru the dirty rect(s) is useful to the final atomic dirty-
>>>>>>>> rect property solution.  Depending on how far off that is, a stop-
>>>>>>>> gap solution could be useful.
>>>>>>>>
>>>>>>>>  drivers/gpu/drm/drm_atomic_helper.c | 66 +++++++++++++++++++++++++++++++++++++
>>>>>>>>  drivers/gpu/drm/msm/msm_atomic.c    |  5 ++-
>>>>>>>>  drivers/gpu/drm/msm/msm_fb.c        |  1 +
>>>>>>>>  include/drm/drm_atomic_helper.h     |  4 +++
>>>>>>>>  include/drm/drm_plane.h             |  9 +++++
>>>>>>>>  5 files changed, 84 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>>>>>>>> index c35654591c12..a578dc681b27 100644
>>>>>>>> --- a/drivers/gpu/drm/drm_atomic_helper.c
>>>>>>>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
>>>>>>>> @@ -3504,6 +3504,7 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
>>>>>>>>     if (state->fb)
>>>>>>>>             drm_framebuffer_get(state->fb);
>>>>>>>>
>>>>>>>> +   state->dirty = false;
>>>>>>>>     state->fence = NULL;
>>>>>>>>     state->commit = NULL;
>>>>>>>>  }
>>>>>>>> @@ -3847,6 +3848,71 @@ int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
>>>>>>>>  }
>>>>>>>>  EXPORT_SYMBOL(drm_atomic_helper_legacy_gamma_set);
>>>>>>>>
>>>>>>>> +/**
>>>>>>>> + * drm_atomic_helper_dirtyfb - helper for dirtyfb
>>>>>>>> + *
>>>>>>>> + * A helper to implement drm_framebuffer_funcs::dirty
>>>>>>>> + */
>>>>>>>> +int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>>>>>>>> +                         struct drm_file *file_priv, unsigned flags,
>>>>>>>> +                         unsigned color, struct drm_clip_rect *clips,
>>>>>>>> +                         unsigned num_clips)
>>>>>>>> +{
>>>>>>>> +   struct drm_modeset_acquire_ctx ctx;
>>>>>>>> +   struct drm_atomic_state *state;
>>>>>>>> +   struct drm_plane *plane;
>>>>>>>> +   int ret = 0;
>>>>>>>> +
>>>>>>>> +   /*
>>>>>>>> +    * When called from ioctl, we are interruptable, but not when
>>>>>>>> +    * called internally (ie. defio worker)
>>>>>>>> +    */
>>>>>>>> +   drm_modeset_acquire_init(&ctx,
>>>>>>>> +           file_priv ? DRM_MODESET_ACQUIRE_INTERRUPTIBLE : 0);
>>>>>>>> +
>>>>>>>> +   state = drm_atomic_state_alloc(fb->dev);
>>>>>>>> +   if (!state) {
>>>>>>>> +           ret = -ENOMEM;
>>>>>>>> +           goto out;
>>>>>>>> +   }
>>>>>>>> +   state->acquire_ctx = &ctx;
>>>>>>>> +
>>>>>>>> +retry:
>>>>>>>> +   drm_for_each_plane(plane, fb->dev) {
>>>>>>>> +           struct drm_plane_state *plane_state;
>>>>>>>> +
>>>>>>>> +           if (plane->state->fb != fb)
>>>>>>>> +                   continue;
>>>>>>>> +
>>>>>>>> +           plane_state = drm_atomic_get_plane_state(state, plane);
>>>>>>>> +           if (IS_ERR(plane_state)) {
>>>>>>>> +                   ret = PTR_ERR(plane_state);
>>>>>>>> +                   goto out;
>>>>>>>> +           }
>>>>>>>> +
>>>>>>>> +           plane_state->dirty = true;
>>>>>>>> +   }
>>>>>>>> +
>>>>>>>> +   ret = drm_atomic_nonblocking_commit(state);
>>>>>>>> +
>>>>>>>> +out:
>>>>>>>> +   if (ret == -EDEADLK) {
>>>>>>>> +           drm_atomic_state_clear(state);
>>>>>>>> +           ret = drm_modeset_backoff(&ctx);
>>>>>>>> +           if (!ret)
>>>>>>>> +                   goto retry;
>>>>>>>> +   }
>>>>>>>> +
>>>>>>>> +   drm_atomic_state_put(state);
>>>>>>>> +
>>>>>>>> +   drm_modeset_drop_locks(&ctx);
>>>>>>>> +   drm_modeset_acquire_fini(&ctx);
>>>>>>>> +
>>>>>>>> +   return ret;
>>>>>>>> +
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
>>>>>>>> +
>>>>>>>>  /**
>>>>>>>>   * __drm_atomic_helper_private_duplicate_state - copy atomic private state
>>>>>>>>   * @obj: CRTC object
>>>>>>>> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
>>>>>>>> index bf5f8c39f34d..bb55a048e98b 100644
>>>>>>>> --- a/drivers/gpu/drm/msm/msm_atomic.c
>>>>>>>> +++ b/drivers/gpu/drm/msm/msm_atomic.c
>>>>>>>> @@ -201,7 +201,10 @@ int msm_atomic_commit(struct drm_device *dev,
>>>>>>>>      * Figure out what fence to wait for:
>>>>>>>>      */
>>>>>>>>     for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
>>>>>>>> -           if ((new_plane_state->fb != old_plane_state->fb) && new_plane_state->fb) {
>>>>>>>> +           bool sync_fb = new_plane_state->fb &&
>>>>>>>> +                   ((new_plane_state->fb != old_plane_state->fb) ||
>>>>>>>> +                    new_plane_state->dirty);
>>>>>>> Why do you have this optimization even here? Imo flipping to the same fb
>>>>>>> should result in the fb getting fully uploaded, whether you're doing a
>>>>>>> legacy page_flip, and atomic one or just a plane update.
>>>>>>>
>>>>>>> Iirc some userspace does use that as essentially a full-plane frontbuffer
>>>>>>> rendering flush already. IOW I don't think we need your
>>>>>>> plane_state->dirty, it's implied to always be true - why would userspace
>>>>>>> do a flip otherwise?
>>>>>>>
>>>>>>> The helper itself to map dirtyfb to a nonblocking atomic commit looks
>>>>>>> reasonable, but misses a bunch of the trickery discussed with Noralf and
>>>>>>> others I think.
>>>>>> Ok, I've done some history digging:
>>>>>>
>>>>>> - i915 and nouveau unconditionally wait for fences, even for same-fb
>>>>>>   flips.
>>>>>> - no idea what amdgpu and vmwgfx are doing, they're not using
>>>>>>   plane_state->fence for implicit fences.
>>>>> I thought plane_state->fence was used for explicit fences, so its use by drivers
>>>>> would interfere with it? I don't think fencing would work on msm or vc4..
>>>> for implicit fencing we fish out the implicit fence and stuff it in
>>>> plane_state->fence..
>>> What happens when userspace passes a fence fd to in_fence_fd?
>> mixing implicit sync and explicit sync is undefined
> It's very well-defined, explicit sync wins. See the kerneldoc for
> drm_atomic_set_fence_for_plane. Since a pile of drivers don't use that
> the reality might be undefined though :-)
Ah right, missed that part.

~Maarten
