Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeC0JeS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:34:18 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:44385 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbeC0JeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:34:15 -0400
X-Google-Smtp-Source: AIpwx49AXKMCH1ScZFpaHFu+Om0AMkg+zDuTggu2D2GGm7mCpKLXyYFunoJmS4JgDJISGYFuoFLmgQ==
Subject: Re: [PATCH v3] drm/xen-front: Add support for Xen PV display frontend
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: daniel.vetter@intel.com
References: <1521644293-14612-1-git-send-email-andr2000@gmail.com>
 <1521644293-14612-2-git-send-email-andr2000@gmail.com>
 <20180322075648.GI14155@phenom.ffwll.local>
 <888a2381-3c83-cb23-2854-6add90f2f493@gmail.com>
 <20180326081826.GP14155@phenom.ffwll.local>
 <da530e61-fa3a-3e63-ecaf-0e818b7c0523@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        seanpaul@chromium.org, gustavo@padovan.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Message-ID: <39f6816d-f68b-b82a-1a8e-ff9909d8d01a@gmail.com>
Date: Tue, 27 Mar 2018 12:34:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <da530e61-fa3a-3e63-ecaf-0e818b7c0523@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel!

On 03/26/2018 03:46 PM, Oleksandr Andrushchenko wrote:
> On 03/26/2018 11:18 AM, Daniel Vetter wrote:
>> On Fri, Mar 23, 2018 at 05:54:49PM +0200, Oleksandr Andrushchenko wrote:
>>>> My apologies, but I found a few more things that look strange and 
>>>> should
>>>> be cleaned up. Sorry for this iterative review approach, but I 
>>>> think we're
>>>> slowly getting there.
>>> Thank you for reviewing!
>>>> Cheers, Daniel
>>>>
>>>>> ---
>>>>> +static int xen_drm_drv_dumb_create(struct drm_file *filp,
>>>>> +        struct drm_device *dev, struct drm_mode_create_dumb *args)
>>>>> +{
>>>>> +    struct xen_drm_front_drm_info *drm_info = dev->dev_private;
>>>>> +    struct drm_gem_object *obj;
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = xen_drm_front_gem_dumb_create(filp, dev, args);
>>>>> +    if (ret)
>>>>> +        goto fail;
>>>>> +
>>>>> +    obj = drm_gem_object_lookup(filp, args->handle);
>>>>> +    if (!obj) {
>>>>> +        ret = -ENOENT;
>>>>> +        goto fail_destroy;
>>>>> +    }
>>>>> +
>>>>> +    drm_gem_object_unreference_unlocked(obj);
>>>> You can't drop the reference while you keep using the object, 
>>>> someone else
>>>> might sneak in and destroy your object. The unreference always must be
>>>> last.
>>> Will fix, thank you
>>>>> +
>>>>> +    /*
>>>>> +     * In case of CONFIG_DRM_XEN_FRONTEND_CMA gem_obj is constructed
>>>>> +     * via DRM CMA helpers and doesn't have ->pages allocated
>>>>> +     * (xendrm_gem_get_pages will return NULL), but instead can 
>>>>> provide
>>>>> +     * sg table
>>>>> +     */
>>>>> +    if (xen_drm_front_gem_get_pages(obj))
>>>>> +        ret = xen_drm_front_dbuf_create_from_pages(
>>>>> +                drm_info->front_info,
>>>>> +                xen_drm_front_dbuf_to_cookie(obj),
>>>>> +                args->width, args->height, args->bpp,
>>>>> +                args->size,
>>>>> +                xen_drm_front_gem_get_pages(obj));
>>>>> +    else
>>>>> +        ret = xen_drm_front_dbuf_create_from_sgt(
>>>>> +                drm_info->front_info,
>>>>> +                xen_drm_front_dbuf_to_cookie(obj),
>>>>> +                args->width, args->height, args->bpp,
>>>>> +                args->size,
>>>>> +                xen_drm_front_gem_get_sg_table(obj));
>>>>> +    if (ret)
>>>>> +        goto fail_destroy;
>>>>> +
>>>> The above also has another race: If you construct an object, then 
>>>> it must
>>>> be fully constructed by the time you publish it to the wider world. 
>>>> In gem
>>>> this is done by calling drm_gem_handle_create() - after that 
>>>> userspace can
>>>> get at your object and do nasty things with it in a separate thread,
>>>> forcing your driver to Oops if the object isn't fully constructed yet.
>>>>
>>>> That means you need to redo this code here to make sure that the gem
>>>> object is fully set up (including pages and sg tables) _before_ 
>>>> anything
>>>> calls drm_gem_handle_create().
>>> You are correct, I need to rework this code
>>>> This probably means you also need to open-code the cma side, by first
>>>> calling drm_gem_cma_create(), then doing any additional setup, and 
>>>> finally
>>>> doing the registration to userspace with drm_gem_handle_create as 
>>>> the very
>>>> last thing.
>>> Although I tend to avoid open-coding, but this seems the necessary 
>>> measure
>>> here
>>>> Alternativet is to do the pages/sg setup only when you create an fb 
>>>> (and
>>>> drop the pages again when the fb is destroyed), but that requires some
>>>> refcounting/locking in the driver.
>>> Not sure this will work: nothing prevents you from attaching 
>>> multiple FBs to
>>> a single dumb handle
>>> So, not only ref-counting should be done here, but I also need to 
>>> check if
>>> the dumb buffer,
>>> we are attaching to, has been created already
>> No, you must make sure that no dumb buffer can be seen by anyone else
>> before it's fully created. If you don't register it in the file_priv idr
>> using drm_gem_handle_create, no one else can get at your buffer. 
>> Trying to
>> paper over this race from all the other places breaks the gem core code
>> design, and is also much more fragile.
> Yes, this is what I implement now, e.g. I do not create
> any dumb handle until GEM is fully created. I was just
> saying that alternative way when we do pages/sgt on FB
> attach will not work in my case
>>> So, I will rework with open-coding some stuff from CMA helpers
>>>
>>>> Aside: There's still a lot of indirection and jumping around which 
>>>> makes
>>>> the code a bit hard to follow.
>>> Probably I am not sure of which indirection we are talking about, 
>>> could you
>>> please
>>> specifically mark those annoying you?
>> I think it's the same indirection we talked about last time, it still
>> annoys me. But it's still ok if you prefer this way I think :-)
> Ok, probably this is because I'm looking at the driver
> from an editor, but you are from your mail client ;)
>>>>> +
>>>>> +static void xen_drm_drv_release(struct drm_device *dev)
>>>>> +{
>>>>> +    struct xen_drm_front_drm_info *drm_info = dev->dev_private;
>>>>> +    struct xen_drm_front_info *front_info = drm_info->front_info;
>>>>> +
>>>>> +    drm_atomic_helper_shutdown(dev);
>>>>> +    drm_mode_config_cleanup(dev);
>>>>> +
>>>>> +    xen_drm_front_evtchnl_free_all(front_info);
>>>>> +    dbuf_free_all(&front_info->dbuf_list);
>>>>> +
>>>>> +    drm_dev_fini(dev);
>>>>> +    kfree(dev);
>>>>> +
>>>>> +    /*
>>>>> +     * Free now, as this release could be not due to rmmod, but
>>>>> +     * due to the backend disconnect, making drm_info hang in
>>>>> +     * memory until rmmod
>>>>> +     */
>>>>> +    devm_kfree(&front_info->xb_dev->dev, front_info->drm_info);
>>>>> +    front_info->drm_info = NULL;
>>>>> +
>>>>> +    /* Tell the backend we are ready to (re)initialize */
>>>>> +    xenbus_switch_state(front_info->xb_dev, 
>>>>> XenbusStateInitialising);
>>>> This needs to be in the unplug code. Yes that means you'll have 
>>>> multiple
>>>> drm_devices floating around, but that's how hotplug works. That 
>>>> would also
>>>> mean that you need to drop the front_info pointer from the backend at
>>>> unplug time.
>>>>
I have implemented hotunplug and it works with zombie DRM devices as we 
discussed.
But, there is a use-case which still requires synchronous DRM device 
deletion,
which makes zombie approach not work. This is the use-case when pages 
for GEM
objects are provided by the backend (we have be_alloc flag in XenStore 
for that,
please see the workflow for this use-case at [1]). So, in this use-case
backend expects that frontend frees all the resources before it goes into
XenbusStateInitialising state. But with zombie approach I disconnect 
(unplug)
DRM device immediately with deferred removal in mind and tell the backend
that we are ready for other DRM device immediately.
This makes the backend to start freeing the resources which may still be 
in use
by the zombie device (which the later frees only on drm_driver.release).

At the same time there is a single instance of xenbus_driver, so it is 
not possible
for the frontend to tell the backend for which zombie DRM device XenBus 
state changes,
e.g. there is no instance ID or any other unique value passed to the 
backend,
just state. So, in order to allow synchronous resource deletion in this case
I cannot leave DRM device as zombie, but have to destroy it in sync with 
the backend.

So, it seems I have these use-cases:
- if be_alloc flag is not set I can handle zombie DRM devices
- if be_alloc flag is NOT set I need to delete synchronously

I currently see two possible solutions to solve the above:
1. Re-work the driver with hotplug, but make DRM device removal always 
synchronous
so effectively no zombie devices (almost old behavior)

2. Have "if (be_alloc)" logic in the driver, so if the frontend 
allocates the pages
then we run in async zombie mode as discussed before and if not, then we 
implement
synchronous DRM device deletion

Daniel, do you have any thoughts on this? What would be an acceptable 
solution here?


>>>> destroy the drm_device, but only mark the drm_connector as 
>>>> disconnected
>>>> when the xenbus backend is gone. But this half-half solution here 
>>>> where
>>>> you hotunplug the drm_device but want to keep it around still 
>>>> doesn't work
>>>> from a livetime pov.
>>> I'll try to play with this:
>>>
>>> on backend disconnect I will do the following:
>>>      drm_dev_unplug(dev)
>>>      xen_drm_front_evtchnl_free_all(front_info);
>>>      dbuf_free_all(&front_info->dbuf_list);
>>>      devm_kfree(&front_info->xb_dev->dev, front_info->drm_info);
>>>      front_info->drm_info = NULL;
>>>      xenbus_switch_state(front_info->xb_dev, XenbusStateInitialising);
>>>
>>> on drm_driver.release callback:
>>>
>>>      drm_atomic_helper_shutdown(dev);
>>>      drm_mode_config_cleanup(dev);
>>>
>>>      drm_dev_fini(dev);
>>>      kfree(dev);
>>>
>>> Does the above make sense?
>> I think so, yes.
> Great
>>   One nit: Since you need to call devm_kfree either pick a
>> different struct device that has the correct lifetime, or switch to the
>> normal kmalloc/kfree versions.
> Sure, I just copy-pasted from the existing patch with devm_
> so we can discuss
>>>>> +static struct xenbus_driver xen_driver = {
>>>>> +    .ids = xen_driver_ids,
>>>>> +    .probe = xen_drv_probe,
>>>>> +    .remove = xen_drv_remove,
>>>> I still don't understand why you have both the remove and fini 
>>>> versions of
>>>> this. See other comments, I think the xenbus vs. drm_device 
>>>> lifetime stuff
>>>> still needs to be cleaned up some more. This shouldn't be that hard
>>>> really.
>>>>
>>>> Or maybe I'm just totally misunderstanding this frontend vs. 
>>>> backend split
>>>> in xen, so if you have a nice gentle intro text for why that 
>>>> exists, it
>>>> might help.
>>> Probably misunderstanding comes from the fact that it is possible if 
>>> backend
>>> dies it may still have its XenBus state set to connected, thus
>>> displback_disconnect callback will never be called. For that reason 
>>> on rmmod
>>> I call fini for the DRM driver to destroy it.
>>>
>>>>> +    /*
>>>>> +     * pflip_timeout is set to current jiffies once we send a 
>>>>> page flip and
>>>>> +     * reset to 0 when we receive frame done event from the backed.
>>>>> +     * It is checked during drm_connector_helper_funcs.detect_ctx 
>>>>> to detect
>>>>> +     * time-outs for frame done event, e.g. due to backend errors.
>>>>> +     *
>>>>> +     * This must be protected with front_info->io_lock, so races 
>>>>> between
>>>>> +     * interrupt handler and rest of the code are properly handled.
>>>>> +     */
>>>>> +    unsigned long pflip_timeout;
>>>>> +
>>>>> +    bool conn_connected;
>>>> I'm pretty sure this doesn't work. Especially the check in 
>>>> display_check
>>>> confuses me, if there's ever an error then you'll never ever be 
>>>> able to
>>>> display anything again, except when someone disables the display.
>>> That was the idea to allow dummy user-space to get an error in
>>> display_check and close, going through display_disable.
>>> Yes, compositors will die in this case.
>>>
>>>> If you want to signal errors with the output then this must be done
>>>> through the new link-status property and
>>>> drm_mode_connector_set_link_status_property. Rejecting kms updates in
>>>> display_check with -EINVAL because the hw has a temporary issue is 
>>>> kinda
>>>> not cool (because many compositors just die when this happens). I 
>>>> thought
>>>> we agreed already to remove that, sorry for not spotting that in the
>>>> previous version.
>>> Unfortunatelly, there is little software available which will benefit
>>> from this out of the box. I am specifically interested in embedded
>>> use-cases, e.g. Android (DRM HWC2 - doesn't support hotplug, HWC1.4 
>>> doesn't
>>> support link status), Weston (no device hotplug, but connectors and
>>> outputs).
>>> Other software, like kmscube, modetest will not handle that as well.
>>> So, such software will hang forever until killed.
>> Then you need to fix your userspace. You can't invent new uapi which 
>> will
>> break existing compositors like this.
> I have hotplug in the driver for connectors now, so no new UAPI
>> Also I thought you've fixed the
>> "hangs forever" by sending out the uevent in case the backend disappears
>> or has an error. That's definitely something that should be fixed, 
>> current
>> userspace doesn't expect that events never get delivered.
> I do, I was just saying that modetest/kmscube doesn't
> handle hotplug events, so they can't understand that the
> connector is gone
>>
>>>> Some of the conn_connected checks also look a bit like they should be
>>>> replaced by drm_dev_is_unplugged instead, but I'm not sure.
>>> I believe you are talking about drm_simple_display_pipe_funcs?
>>> Do you mean I have to put drm_dev_is_unplugged in display_enable,
>>> display_disable and display_update callbacks?
>> Yes. Well, as soon as Noralf's work has landed they'll switch to a
>> drm_dev_enter/exit pair, but same idea.
> Good, during the development I am probably seeing same
> races because of this, e.g. I only have drm_dev_is_unplugged
> as my tool which is not enough
>
>>>>> +static int connector_detect(struct drm_connector *connector,
>>>>> +        struct drm_modeset_acquire_ctx *ctx,
>>>>> +        bool force)
>>>>> +{
>>>>> +    struct xen_drm_front_drm_pipeline *pipeline =
>>>>> +            to_xen_drm_pipeline(connector);
>>>>> +    struct xen_drm_front_info *front_info = 
>>>>> pipeline->drm_info->front_info;
>>>>> +    unsigned long flags;
>>>>> +
>>>>> +    /* check if there is a frame done event time-out */
>>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>>> +    if (pipeline->pflip_timeout &&
>>>>> +            time_after_eq(jiffies, pipeline->pflip_timeout)) {
>>>>> +        DRM_ERROR("Frame done event timed-out\n");
>>>>> +
>>>>> +        pipeline->pflip_timeout = 0;
>>>>> +        pipeline->conn_connected = false;
>>>>> +        xen_drm_front_kms_send_pending_event(pipeline);
>>>>> +    }
>>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>> If you want to check for timeouts please use a worker, don't 
>>>> piggy-pack on
>>>> top of the detect callback.
>>> Ok, will have a dedicated work for that. The reasons why I put this 
>>> into the
>>> detect callback were:
>>> - the periodic worker is already there, and I do nothing heavy
>>>    in this callback
>>> - if frame done has timed out it most probably means that
>>>    backend has gone, so 10 sec period of detect timeout is also ok: 
>>> thus I
>>> don't
>>>    need to schedule a work each page flip which could be a bit costly
>>> So, probably I will also need a periodic work (or kthread/timer) for 
>>> frame
>>> done time-outs
>> Yes, please create your own timer/worker for this, stuffing random other
>> things into existing workers makes the locking hierarchy more 
>> complicated
>> for everyone. And it's confusing for core devs trying to understand what
>> your driver does :-)
> Will do
>>
>> Most drivers have piles of timers/workers doing various stuff, they're
>> real cheap.
>>
>>>>> +static int connector_mode_valid(struct drm_connector *connector,
>>>>> +        struct drm_display_mode *mode)
>>>>> +{
>>>>> +    struct xen_drm_front_drm_pipeline *pipeline =
>>>>> +            to_xen_drm_pipeline(connector);
>>>>> +
>>>>> +    if (mode->hdisplay != pipeline->width)
>>>>> +        return MODE_ERROR;
>>>>> +
>>>>> +    if (mode->vdisplay != pipeline->height)
>>>>> +        return MODE_ERROR;
>>>>> +
>>>>> +    return MODE_OK;
>>>>> +}
>>>> mode_valid on the connector only checks probe modes. Since that is
>>>> hardcoded this doesn't do much, which means userspace can give you 
>>>> a wrong
>>>> mode, and you fall over.
>>> Agree, I will remove this callback completely: I have
>>> drm_connector_funcs.fill_modes == 
>>> drm_helper_probe_single_connector_modes,
>>> so it will only pick my single hardcoded mode from
>>> drm_connector_helper_funcs.get_modes
>>> callback (connector_get_modes).
>> No, you still need your mode_valid check. Userspace can ignore your mode
>> list and give you something totally different. But it needs to be 
>> moved to
>> the drm_simple_display_pipe_funcs vtable.
> Just to make sure we are on the same page: I just move 
> connector_mode_valid
> as is to drm_simple_display_pipe_funcs, right?
>>>> You need to use one of the other mode_valid callbacks instead,
>>>> drm_simple_display_pipe_funcs has the one you should use.
>>>>
>>> Not sure I understand why do I need to provide a callback here?
>>> For simple KMS the drm_simple_kms_crtc_mode_valid callback is used,
>>> which always returns MODE_OK if there is no .mode_valid set for the 
>>> pipe.
>>> As per my understanding drm_simple_kms_crtc_mode_valid is only 
>>> called for
>>> modes, which were collected by drm_helper_probe_single_connector_modes,
>>> so I assume each time .validate_mode is called it can only have my 
>>> hardcoded
>>> mode to validate?
>> Please read the kerneldoc again, userspace can give you modes that 
>> are not
>> coming from drm_helper_probe_single_connector_modes. If the kerneldoc
>> isn't clear, then please submit a patch to make it clearer.
> It is all clear
>>>>> +
>>>>> +static int display_check(struct drm_simple_display_pipe *pipe,
>>>>> +        struct drm_plane_state *plane_state,
>>>>> +        struct drm_crtc_state *crtc_state)
>>>>> +{
>>>>> +    struct xen_drm_front_drm_pipeline *pipeline =
>>>>> +            to_xen_drm_pipeline(pipe);
>>>>> +
>>>>> +    return pipeline->conn_connected ? 0 : -EINVAL;
>>>> As mentioned, this -EINVAL here needs to go. Since you already have a
>>>> mode_valid callback you can (should) drop this one here entirely.
>>> Not sure how mode_valid is relevant to this code [1]: This function is
>>> called
>>> in the check phase of an atomic update, specifically when the 
>>> underlying
>>> plane is checked. But, anyways: the reason for this callback and it
>>> returning
>>> -EINVAL is primarialy for a dumb user-space which cannot handle hotplug
>>> events.
>> Fix your userspace. Again, you can't invent new uapi like this which 
>> ends
>> up being inconsistent with other existing userspace.
> In ideal world - yes, we have to fix existing software ;)
>>
>>> But, as you mentioned before, it will make most compositors die, so 
>>> I will
>>> remove this
>> Yup, sounds good.
>>
>> Cheers, Daniel
> Thank you,
> Oleksandr

Thank you,
Oleksandr

[1] 
https://elixir.bootlin.com/linux/v4.16-rc7/source/include/xen/interface/io/displif.h#L471
