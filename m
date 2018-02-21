Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938209AbeBUPUI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:20:08 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:42012 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937764AbeBUPUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:20:05 -0500
X-Google-Smtp-Source: AH8x226CQI5mFsKxiyw5xNvAkvBg+tg5XT+YgAJL939cwNb9/JodAKq1Ytzxti4k64OhYrIrTeLVj4JJdMfdPTmCUgM=
MIME-Version: 1.0
In-Reply-To: <20180221150727.GO5453@intel.com>
References: <20180221143730.30285-1-robdclark@gmail.com> <20180221143730.30285-2-robdclark@gmail.com>
 <20180221144919.GN5453@intel.com> <CAF6AEGuYmLRphz1FusqaOqyz=mGtbvn7oOsxNYKg3MEMOvYO1A@mail.gmail.com>
 <20180221150727.GO5453@intel.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 21 Feb 2018 10:20:03 -0500
Message-ID: <CAF6AEGucNXQZjKaL4KYXSnax=kFiurmsgxKHP9t5ycy_tbmj7g@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/atomic: integrate modeset lock with private objects
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LFKHuK020182

On Wed, Feb 21, 2018 at 10:07 AM, Ville Syrjälä
<ville.syrjala@linux.intel.com> wrote:
> On Wed, Feb 21, 2018 at 09:54:49AM -0500, Rob Clark wrote:
>> On Wed, Feb 21, 2018 at 9:49 AM, Ville Syrjälä
>> <ville.syrjala@linux.intel.com> wrote:
>> > On Wed, Feb 21, 2018 at 09:37:21AM -0500, Rob Clark wrote:
>> >> Follow the same pattern of locking as with other state objects.  This
>> >> avoids boilerplate in the driver.
>> >
>> > I'm not sure we really want to do this. What if the driver wants a
>> > custom locking scheme for this state?
>>
>> That seems like something we want to discourage, ie. all the more
>> reason for this patch.
>>
>> There is no reason drivers could not split their global state into
>> multiple private objs's, each with their own lock, for more fine
>> grained locking.  That is basically the only valid reason I can think
>> of for "custom locking".
>
> In i915 we have at least one case that would want something close to an
> rwlock. Any crtc lock is enough for read, need all of them for write.
> Though if we wanted to use private objs for that we might need to
> actually make the states refcounted as well, otherwise I can imagine
> we might land in some use-after-free issues once again.
>
> Maybe we could duplicate the state into per-crtc and global copies, but
> then we have to keep all of those in sync somehow which doesn't sound
> particularly pleasant.

Or just keep your own driver lock for read, and use that plus the core
modeset lock for write?

BR,
-R

>
>>
>> (And ofc drivers could add there own locks in addition to what is done
>> by core, but I'd rather look at that on a case by case basis, rather
>> than it being part of the boilerplate in each driver.)
>>
>> BR,
>> -R
>>
>> >>
>> >> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> >> ---
>> >>  drivers/gpu/drm/drm_atomic.c | 9 ++++++++-
>> >>  include/drm/drm_atomic.h     | 5 +++++
>> >>  2 files changed, 13 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>> >> index fc8c4da409ff..004e621ab307 100644
>> >> --- a/drivers/gpu/drm/drm_atomic.c
>> >> +++ b/drivers/gpu/drm/drm_atomic.c
>> >> @@ -1078,6 +1078,8 @@ drm_atomic_private_obj_init(struct drm_private_obj *obj,
>> >>  {
>> >>       memset(obj, 0, sizeof(*obj));
>> >>
>> >> +     drm_modeset_lock_init(&obj->lock);
>> >> +
>> >>       obj->state = state;
>> >>       obj->funcs = funcs;
>> >>  }
>> >> @@ -1093,6 +1095,7 @@ void
>> >>  drm_atomic_private_obj_fini(struct drm_private_obj *obj)
>> >>  {
>> >>       obj->funcs->atomic_destroy_state(obj, obj->state);
>> >> +     drm_modeset_lock_fini(&obj->lock);
>> >>  }
>> >>  EXPORT_SYMBOL(drm_atomic_private_obj_fini);
>> >>
>> >> @@ -1113,7 +1116,7 @@ struct drm_private_state *
>> >>  drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
>> >>                                struct drm_private_obj *obj)
>> >>  {
>> >> -     int index, num_objs, i;
>> >> +     int index, num_objs, i, ret;
>> >>       size_t size;
>> >>       struct __drm_private_objs_state *arr;
>> >>       struct drm_private_state *obj_state;
>> >> @@ -1122,6 +1125,10 @@ drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
>> >>               if (obj == state->private_objs[i].ptr)
>> >>                       return state->private_objs[i].state;
>> >>
>> >> +     ret = drm_modeset_lock(&obj->lock, state->acquire_ctx);
>> >> +     if (ret)
>> >> +             return ERR_PTR(ret);
>> >> +
>> >>       num_objs = state->num_private_objs + 1;
>> >>       size = sizeof(*state->private_objs) * num_objs;
>> >>       arr = krealloc(state->private_objs, size, GFP_KERNEL);
>> >> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
>> >> index 09076a625637..9ae53b73c9d2 100644
>> >> --- a/include/drm/drm_atomic.h
>> >> +++ b/include/drm/drm_atomic.h
>> >> @@ -218,6 +218,11 @@ struct drm_private_state_funcs {
>> >>   * &drm_modeset_lock is required to duplicate and update this object's state.
>> >>   */
>> >>  struct drm_private_obj {
>> >> +     /**
>> >> +      * @lock: Modeset lock to protect the state object.
>> >> +      */
>> >> +     struct drm_modeset_lock lock;
>> >> +
>> >>       /**
>> >>        * @state: Current atomic state for this driver private object.
>> >>        */
>> >> --
>> >> 2.14.3
>> >>
>> >> _______________________________________________
>> >> dri-devel mailing list
>> >> dri-devel@lists.freedesktop.org
>> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> >
>> > --
>> > Ville Syrjälä
>> > Intel OTC
>
> --
> Ville Syrjälä
> Intel OTC
