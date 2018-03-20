Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeCTL6I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:58:08 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:45773 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeCTL6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:58:06 -0400
X-Google-Smtp-Source: AG47ELugHxpfneK+Xk3K7QhWE/p7OBOY4qRMMyhkASXHfz3KtSlIcoFkaTA+3HHtwa+4YeFIOFodQg==
Subject: Re: [PATCH RESEND v2 1/2] drm/xen-front: Add support for Xen PV
 display frontend
To: Daniel Vetter <daniel@ffwll.ch>
Cc: xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>, Juergen Gross <jgross@suse.com>,
        boris.ostrovsky@oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
References: <1520958066-22875-1-git-send-email-andr2000@gmail.com>
 <1520958066-22875-2-git-send-email-andr2000@gmail.com>
 <20180316082330.GF25297@phenom.ffwll.local>
 <b466004a-821e-60b7-787b-526e10a67505@gmail.com>
 <20180319135141.GK14155@phenom.ffwll.local>
 <0808bf3b-7301-cc28-1cb5-40a4c8aad5cc@gmail.com>
 <CAKMK7uFrCt026VfjyKA1TS6XcP=s4S-RX0hxtLXL53OmdjgHfw@mail.gmail.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <7c4e0f8f-9ec0-e38b-7b37-264241df4ba5@gmail.com>
Date: Tue, 20 Mar 2018 13:58:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFrCt026VfjyKA1TS6XcP=s4S-RX0hxtLXL53OmdjgHfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 05:28 PM, Daniel Vetter wrote:
> On Mon, Mar 19, 2018 at 3:19 PM, Oleksandr Andrushchenko
> <andr2000@gmail.com> wrote:
>> On 03/19/2018 03:51 PM, Daniel Vetter wrote:
>>> On Fri, Mar 16, 2018 at 12:52:09PM +0200, Oleksandr Andrushchenko wrote:
>>>> Hi, Daniel!
>>>> Sorry, if I strip the patch too much below.
>>>>
>>>> On 03/16/2018 10:23 AM, Daniel Vetter wrote:
>>>>> S-o-b line went missing here :-)
>>>> will restore it back ;)
>>>>> I've read through it, 2 actual review comments (around hot-unplug and
>>>>> around the error recovery for failed flips), a few bikesheds, but looks
>>>>> all reasonable to me. And much easier to read as one big patch (it's
>>>>> just
>>>>> 3k).
>>>>>
>>>>> One more thing I'd do as a follow-up (don't rewrite everything, this is
>>>>> close to merge, better to get it in first): You have a lot of
>>>>> indirections
>>>>> and function calls across sources files. That's kinda ok if you have a
>>>>> huge driver with 100+k lines of code where you have to split things up.
>>>>> But for a small driver like yours here it's a bit overkill.
>>>> will review and try to rework after the driver is in
>> I'll probably merge xen_drm_front_drv.c and xen_drm_front.c now as
>> anyway I have to re-work driver unloading, e.g. "fishy" code below.
>>>>> Personally I'd merge at least the xen backend stuff into the
>>>>> corresponding
>>>>> kms code, but that's up to you.
>>>> I prefer to have it in smaller chunks and all related code at
>>>> one place, so it is easier to maintain. That is why I didn't
>>>> plumb frontend <-> backend code right into the KMS code.
>>>>> And as mentioned, if you decide to do
>>>>> that, a follow-up patch (once this has merged) is perfectly fine.
>>>> Ok, after the merge
>>> If you prefer your current layout, then pls keep it. Bikeshed = personal
>>> style nit, feel free to ignore if you like stuff differently. In the end
>>> it's your driver, not mine, and I can easily navigate the current code
>>> (with a few extra jumps).
>> Some of the indirections will be removed by merging
>> xen_drm_front_drv.c and xen_drm_front.c. Are these what you
>> mean or is there anything else?
>>
>>> -Daniel
>>>
>>>>> -Daniel
>>>>>
>>>>>> +int xen_drm_front_dbuf_create_from_sgt(struct xen_drm_front_info
>>>>>> *front_info,
>>>>>> +               uint64_t dbuf_cookie, uint32_t width, uint32_t height,
>>>>>> +               uint32_t bpp, uint64_t size, struct sg_table *sgt)
>>>>>> +{
>>>>>> +       return be_dbuf_create_int(front_info, dbuf_cookie, width,
>>>>>> height,
>>>>>> +                       bpp, size, NULL, sgt);
>>>>>> +}
>>>>>> +
>>>>>> +int xen_drm_front_dbuf_create_from_pages(struct xen_drm_front_info
>>>>>> *front_info,
>>>>>> +               uint64_t dbuf_cookie, uint32_t width, uint32_t height,
>>>>>> +               uint32_t bpp, uint64_t size, struct page **pages)
>>>>>> +{
>>>>>> +       return be_dbuf_create_int(front_info, dbuf_cookie, width,
>>>>>> height,
>>>>>> +                       bpp, size, pages, NULL);
>>>>>> +}
>>>>> The above two wrappers seem a bit much, just to set sgt = NULL or pages
>>>>> =
>>>>> NULL in one of them. I'd drop them, but that's a bikeshed so feel free
>>>>> to
>>>>> ignore.
>>>> I had that the way you say in some of the previous implementations,
>>>> but finally decided to have these dummy wrappers: seems
>>>> to be cleaner this way
>>>>>> +static void displback_disconnect(struct xen_drm_front_info
>>>>>> *front_info)
>>>>>> +{
>>>>>> +       bool removed = true;
>>>>>> +
>>>>>> +       if (front_info->drm_pdev) {
>>>>>> +               if (xen_drm_front_drv_is_used(front_info->drm_pdev)) {
>>>>>> +                       DRM_WARN("DRM driver still in use, deferring
>>>>>> removal\n");
>>>>>> +                       removed = false;
>>>>>> +               } else
>>>>>> +                       xen_drv_remove_internal(front_info);
>>>>> Ok this logic here is fishy, since you're open-coding the drm unplug
>>>>> infrastructure, but slightly differently and slightyl racy. If you have
>>>>> a
>>>>> driver where your underlying "hw" (well it's virtual here, but same
>>>>> idea)
>>>>> can disappear any time while userspace is still using the drm driver,
>>>>> you
>>>>> need to use the drm_dev_unplug() function and related code.
>>>>> drm_dev_unplug() works like drm_dev_unregister, except for the hotplug
>>>>> case.
>>>>>
>>>>> Then you also have to guard all the driver entry points where you do
>>>>> access the backchannel using drm_dev_is_unplugged() (I've seen a few of
>>>>> those already). Then you can rip out all the logic here and the
>>>>> xen_drm_front_drv_is_used() helper.
>>>> Will rework it with drm_dev_unplug, thank you
>>>>> I thought there's some patches from Noralf in-flight that improved the
>>>>> docs on this, I need to check
>> Yes, I will definitely use those as soon as they are available.
>> But at the moment let me clarify a bit on the use-cases for driver
>> unplugging and backend disconnection.
>>
>> The backend, by disconnecting, expects full DRM driver teardown, because,
>> for example, it might need to replace current frontend’s configuration
>> completely or stop supporting para-virtualized display for some reason.
>>
>> This means that once I have displback_disconnected callback (on XenBus state
>> change) I am trying to unregister and remove the DRM driver which seems to
>> be
>> not possible if I have relevant code in DRM callbacks (e.g. I cannot try
>> removing
>> driver from driver's callback).
>>
>> So, even if I add drm_dev_unplug (which anyway seems to be the right thing)
>> I’ll have to have that fishy code for XenBus state handling.
>>
>> These are the unplug/disconnect use-cases we have:
>>
>> 1. Rmmod
>> ========
>> 1.1. If DRM driver is not in use
>> We can call xen_drv_remove_internal immediately and remove both DRM and
>> XenBus drivers
>>
>> 1.2. If DRM driver is in use
>> In this case usage count of the module is non-zero and driver cannot be
>> removed
>>
>> 2. Backend disconnect callback
>> ==============================
>> 2.0. Call drm_dev_unplug as the first step
>>
>> 2.1. If DRM driver is not in use (dev->open_count == 0)
>> (The check of dev->open_count against zero should be safe,
>> as before that we call drm_dev_unplug, so the framework will not allow
>> open_count
>> to be incremented).
>> This is similar to 1.1 and we can call xen_drv_remove_internal immediately
>> and
>> remove both DRM and XenBus drivers
>>
>> 2.2. DRM driver is in use (dev->open_count != 0)
>> This seems to be the only *really fishy place*.
>> In this case drm_dev_unplug will not allow new clients for the DRM driver,
>> but we cannot start removing DRM driver until the last client closes the DRM
>> device.
>>
>> This is the change I am planning to introduce:
>>
>> User-space may hold the DRM device in use for unlimited time, so we cannot
>> hang in XenBus’
>> displback_disconnected callback indefinitely, but have to defer DRM driver
>> deletion:
>> we switch frontend driver’s XenBus state to XenbusStateReconfiguring
>> (telling the backend to
>> wait until we release the DRM driver) and on drm_drv.lastclose callback
>> schedule a deferred
>> work which will check for dev->open_count == 0 to become true, so we can
>> remove DRM driver
>> and change frontend’s XenBus state to XenbusStateInitialising.
>> If at the time of the check dev->open_count != 0 then we reschedule the same
>> work with
>> start up delay, and re-check later. This rescheduling happens until
>> dev->open_count == 0,
>> which is the marker for DRM driver removal.
>>
>> Does the above makes sense?
>> If so, then I’ll have this implemented in v4 of the driver.
> There should be no difference between immediate removal and delayed
> removal of the drm_device from the xenbus pov. The lifetimes of the
> front-end (drm_device) and backend (the xen bus thing) are entirely
> decoupled:
Well, they are not decoupled for simplicity of handling,
please see below
>
> So for case 2 you only have 1 case:
>
> - drm_dev_unplug
> - tear down the entire xenbus backend completely
> - all xenbus access will be caught with drm_dev_entre/exit (well right
> now drm_dev_is_unplugged) checks, including any access to your private
> drm_device data
> - once drm_device->open_count == 0 the core will tear down the
> drm_device instance and call your optional drm_driver->release
> callback.
>
> So past drm_dev_unplug the drm_device is in zombie state and the only
> thing that will happen is a) it rejects all ioctls and anything else
> userspace might ask it to do and b) gets releases once the last
> userspace reference is gone.
I have re-worked the driver with this in mind [1]
So, I now use drm_dev_unplug and destroy the DRM device
on drm_driver.release.
In context of unplug work I also merged xen_drm_front_drv.c and
xen_drm_front.c as these are too coupled together now.

Could you please take a look and tell me if this is what you mean?
>
> If the backend comes up again, you create a _new_ drm_device instance
> (while the other one is still in the process of eventually getting
> released).
We only have a single xenbus instance, so this way I'll need
to handle list of such zombies. For that reason I prefer to
wait until the DRM device is destroyed, telling the backend
to hold on until then (via going into XenbusStateReconfiguring state).

Another drawback of such approach is that I'll have different
minors at run-time, e.g. card0, card1, etc.
For software which has /dev/dri/card0 hardcoded it may be a problem.
But this is minor, IMO
>
> In short, your driver code should never have a need to look at
> drm_device->open_count. I hope this explains it a bit better.
> -Daniel
>
Yes, you are correct: at [1] I am not touching drm_device->open_count
anymore and everything just happens synchronously
>>
>>>>>> +#define XEN_DRM_NUM_VIDEO_MODES                1
>>>>>> +#define XEN_DRM_CRTC_VREFRESH_HZ       60
>>>>>> +
>>>>>> +static int connector_get_modes(struct drm_connector *connector)
>>>>>> +{
>>>>>> +       struct xen_drm_front_drm_pipeline *pipeline =
>>>>>> +                       to_xen_drm_pipeline(connector);
>>>>>> +       struct drm_display_mode *mode;
>>>>>> +       struct videomode videomode;
>>>>>> +       int width, height;
>>>>>> +
>>>>>> +       mode = drm_mode_create(connector->dev);
>>>>>> +       if (!mode)
>>>>>> +               return 0;
>>>>>> +
>>>>>> +       memset(&videomode, 0, sizeof(videomode));
>>>>>> +       videomode.hactive = pipeline->width;
>>>>>> +       videomode.vactive = pipeline->height;
>>>>>> +       width = videomode.hactive + videomode.hfront_porch +
>>>>>> +                       videomode.hback_porch + videomode.hsync_len;
>>>>>> +       height = videomode.vactive + videomode.vfront_porch +
>>>>>> +                       videomode.vback_porch + videomode.vsync_len;
>>>>>> +       videomode.pixelclock = width * height *
>>>>>> XEN_DRM_CRTC_VREFRESH_HZ;
>>>>>> +       mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
>>>>>> +
>>>>>> +       drm_display_mode_from_videomode(&videomode, mode);
>>>>>> +       drm_mode_probed_add(connector, mode);
>>>>>> +       return XEN_DRM_NUM_VIDEO_MODES;
>>>>> Bikeshed: just hardcode this to 1, the #define is imo more confusing.
>>>> ok, will remove #define
>>>>>> +
>>>>>> +       }
>>>>>> +       /*
>>>>>> +        * Send page flip request to the backend *after* we have event
>>>>>> cached
>>>>>> +        * above, so on page flip done event from the backend we can
>>>>>> +        * deliver it and there is no race condition between this code
>>>>>> and
>>>>>> +        * event from the backend.
>>>>>> +        * If this is not a page flip, e.g. no flip done event from the
>>>>>> backend
>>>>>> +        * is expected, then send now.
>>>>>> +        */
>>>>>> +       if (!display_send_page_flip(pipe, old_plane_state))
>>>>>> +               xen_drm_front_kms_send_pending_event(pipeline);
>>>>> The control flow here is a bit confusing. I'd put the call to send out
>>>>> the
>>>>> event right away in case of a failure to communicate with the backend
>>>>> into
>>>>> display_send_page_flip() itself. Then drop the bool return value and
>>>>> make
>>>>> it void, and also push the comment explaining what you do in case of
>>>>> errors into that function.
>>>> The reason for having bool for page flip here is that we
>>>> need to send pending event for display enable/disable, for example.
>>>> So, I decided to make it this way:
>>>> 1. page flip handled - handles pending event internally
>>>> (defers sending until frame done event from the backend)
>>>> 2. page flip failed - handles externally in case of any
>>>> page flip related error, e.g. "not handled" cases, either
>>>> due to backend communication error or whatever else
>>>> 3. all other cases, but page flip
>>>>> That way the error handling and recovery is all neatly tied together in
>>>>> one place instead of spread around.
>>>> Well, I tried to keep it all at one place, but as we decided
>>>> to implement connector hotplug for error delivery it
>>>> became split. Also, I handle frame done event time-outs there.
>>> You can leave things as-is if you prefer, just for me it looked a bit
>>> confusion and unecessarily complex.
>> I'll think more if I can simplify this
>>> -Daniel
>> Thank you,
>> Oleksandr Andrushchenko
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
Thank you very much for your time and comments,
Oleksandr

[1] https://github.com/andr2000/linux/commits/drm_tip_pv_drm_v3
