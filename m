Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeDENfs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:35:48 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:40175 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeDENfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:35:45 -0400
X-Google-Smtp-Source: AIpwx49dfx6mPFBuXuGlH/WobvvBCaXsoGm6Ao9DQ+hhCCqpQeAbpWGq/MwIHdKClOSCHWWrgxr2MIL9LMZs5Zrc14I=
MIME-Version: 1.0
X-Originating-IP: [212.51.149.109]
In-Reply-To: <7616bf87-bd2e-5003-af35-bc95f0e2a912@shipmail.org>
References: <20180403224225.26776-1-robdclark@gmail.com> <CAKMK7uEH3Qu_Lkok60bOYkik6kyvDGtrS0kcQ=dFmCLRD-+1HA@mail.gmail.com>
 <307adb15-412a-1fe2-f116-27fe5b4a657d@shipmail.org> <20180404084320.GA3881@phenom.ffwll.local>
 <fa4074c7-5469-a69f-e4aa-bdc84e1a919a@shipmail.org> <20180404095604.GD3881@phenom.ffwll.local>
 <7616bf87-bd2e-5003-af35-bc95f0e2a912@shipmail.org>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 5 Apr 2018 15:35:39 +0200
X-Google-Sender-Auth: cb9a9weuXnIS6iEwQxeNXKWteYU
Message-ID: <CAKMK7uFMj8NFvSxxv3KnGhh1rpfbsci58kUaoBcwPtbKEVOiEA@mail.gmail.com>
Subject: Re: [RFC] drm/atomic+msm: add helper to implement legacy dirtyfb
To: Thomas Hellstrom <thomas@shipmail.org>
Cc: Rob Clark <robdclark@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>,
        Deepak Singh Rawat <drawat@vmware.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 3:30 PM, Thomas Hellstrom <thomas@shipmail.org> wrote:
> On 04/04/2018 11:56 AM, Daniel Vetter wrote:
>>
>> On Wed, Apr 04, 2018 at 11:10:08AM +0200, Thomas Hellstrom wrote:
>>>
>>> On 04/04/2018 10:43 AM, Daniel Vetter wrote:
>>>>
>>>> On Wed, Apr 04, 2018 at 10:22:21AM +0200, Thomas Hellstrom wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 04/04/2018 08:58 AM, Daniel Vetter wrote:
>>>>>>
>>>>>> On Wed, Apr 4, 2018 at 12:42 AM, Rob Clark <robdclark@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> Add an atomic helper to implement dirtyfb support.  This is needed to
>>>>>>> support DSI command-mode panels with x11 userspace (ie. when we can't
>>>>>>> rely on pageflips to trigger a flush to the panel).
>>>>>>>
>>>>>>> To signal to the driver that the async atomic update needs to
>>>>>>> synchronize with fences, even though the fb didn't change, the
>>>>>>> drm_atomic_state::dirty flag is added.
>>>>>>>
>>>>>>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>>>>>>> ---
>>>>>>> Background: there are a number of different folks working on getting
>>>>>>> upstream kernel working on various different phones/tablets with qcom
>>>>>>> SoC's.. many of them have command mode panels, so we kind of need a
>>>>>>> way to support the legacy dirtyfb ioctl for x11 support.
>>>>>>>
>>>>>>> I know there is work on a proprer non-legacy atomic property for
>>>>>>> userspace to communicate dirty-rect(s) to the kernel, so this can
>>>>>>> be improved from triggering a full-frame flush once that is in
>>>>>>> place.  But we kinda needa a stop-gap solution.
>>>>>>>
>>>>>>> I had considered an in-driver solution for this, but things get a
>>>>>>> bit tricky if userspace ands up combining dirtyfb ioctls with page-
>>>>>>> flips, because we need to synchronize setting various CTL.FLUSH bits
>>>>>>> with setting the CTL.START bit.  (ie. really all we need to do for
>>>>>>> cmd mode panels is bang CTL.START, but is this ends up racing with
>>>>>>> pageflips setting FLUSH bits, then bad things.)  The easiest soln
>>>>>>> is to wrap this up as an atomic commit and rely on the worker to
>>>>>>> serialize things.  Hence adding an atomic dirtyfb helper.
>>>>>>>
>>>>>>> I guess at least the helper, with some small addition to translate
>>>>>>> and pass-thru the dirty rect(s) is useful to the final atomic dirty-
>>>>>>> rect property solution.  Depending on how far off that is, a stop-
>>>>>>> gap solution could be useful.
>>>>>>
>>>>>> Adding Noralf, who iirc already posted the full dirty helpers already
>>>>>> somewhere.
>>>>>> -Daniel
>>>>>
>>>>> I've asked Deepak to RFC the core changes suggested for the full dirty
>>>>> blob
>>>>> on dri-devel. It builds on DisplayLink's suggestion, with a simple
>>>>> helper to
>>>>> get to the desired coordinates.
>>>>>
>>>>> One thing to perhaps discuss is how we would like to fit this with
>>>>> front-buffer rendering and the dirty ioctl. In the page-flip context,
>>>>> the
>>>>> dirty rects, like egl's swapbuffer_with_damage is a hint to restrict
>>>>> the
>>>>> damage region that can be fully ignored by the driver, new content is
>>>>> indicated by a new framebuffer.
>>>>>
>>>>> We could do the same for frontbuffer rendering: Either set a dirty flag
>>>>> like
>>>>> you do here, or provide a content_age state member. Since we clear the
>>>>> dirty
>>>>> flag on state copies, I guess that would be sufficient. The blob
>>>>> rectangles
>>>>> would then become a hint to restrict the damage region.
>>>>
>>>> I'm not entirely following here - I thought for frontbuffer rendering
>>>> the
>>>> dirty rects have always just been a hint, and that the driver was always
>>>> free to re-upload the entire buffer to the screen.
>>>>
>>>> And through a helper like Rob's proposing here (and have floated around
>>>> in
>>>> different versions already) we'd essentially map a frontbuffer dirtyfb
>>>> call to a fake flip with dirty rect. Manual upload drivers already need
>>>> to
>>>> upload the entire screen if they get a flip, since some userspace uses
>>>> that to flush out frontbuffer rendering (instead of calling dirtyfb).
>>>>
>>>> So from that pov the new dirty flag is kinda not necessary imo.
>>>>
>>>>> Another approach would be to have the presence of dirty rects without
>>>>> framebuffer change to indicate frontbuffer rendering.
>>>>>
>>>>> I think I like the first approach best, although it may be tempting for
>>>>> user-space apps to just set the dirty bit instead of providing the full
>>>>> damage region.
>>>>
>>>> Or I'm not following you here, because I don't quite see the difference
>>>> between dirtyfb and a flip.
>>>> -Daniel
>>>
>>> OK, let me rephrase:
>>>
>>>  From the driver's point-of-view, in the atomic world, new content and
>>> the
>>> need for manual upload is indicated by a change in fb attached to the
>>> plane.
>>>
>>> With Rob's patch here, (correct me if I'm wrong) in addition new content
>>> and
>>> the need for manual upload is identified by the dirty flag, (since the fb
>>> stays the same and the driver thus never identifies a page-flip).
>>
>> Hm, I'm not entirely sure Rob's approach is correct. Imo a pageflip
>> (atomic or not) should result in the entire buffer getting uploaded. The
>> dirty flag is kinda redundant, a flip with the same buffer works the same
>> way as a dirtyfb with the entire buffer as the dirty rectangle.
>>
>>> In both these situations, clip rects can provide a hint to restrict the
>>> dirty region.
>>>
>>> Now I was thinking about the preferred way for user-space to communicate
>>> front buffer rendering through the atomic ioctl:
>>>
>>> 1) Expose a dirty (or content_age property)
>>> 2) Attach a clip-rect blob property.
>>> 3) Fake a page-flip by ping-ponging two frame-buffers pointing to the
>>> same
>>> underlying buffer object.
>>>
>>> Are you saying that people are already using 3) and we should keep using
>>> that?
>>
>> I'm saying they're using 3b), flip the same buffer wrapped in the same
>> drm_framebuffer, and expect it to work.
>>
>> The only advantage dirtyfb has is that it allows you to supply the
>> optimized upload rectangles, but at the cost of a funny api (it's working
>> on the fb, not the plane/crtc you want to upload) and lack of drm_event to
>> confirm when exactly you uploaded your stuff. But imo they should be the
>> same underlying operation.
>>
>
> FWIW, vmwgfx has always treated a dirtyfb as a pure front-buffer like
> rendering operation without any synchronization,
> We've guaranteed that only the rects that are present are uploaded, but only
> xf86-video-vmware has taken advantage of this to keep
> CPU- and GPU rendered content apart.
> I think we've at some point run into problems with number of cliprects, (Old
> KDE lock screen?) and use multiple dirtyfb for the same
> update...

Ok, if we can hit this in practices then I think it's ok to have the
limit. Just need to make sure userspace actually condenses the
cliprects down to something within the limit, since with atomic flips
you can't just do multiple updates - that would tear badly.

Wrt not syncing: I think general use pretty clearly says lots of
userspace renders into buffers with gpus (not even necessarily your
own) and then expects dirtyfb or a flip to upload all the bits.
Otherwise Rob Clark wouldn't need his patch. Given that I think we
need to make general semantics follow that requirement - I don't
expect it'll harm vmwgfx since it doesn't render into the frontbuffer
anyway?

> IIRC the reason for working with the fb, is that it's much easier for
> user-space, which doesn't have to care where planes are scanning out and
> why.
> "Present my new content on any screen that's affected".

Yeah, dirtyfb makes tons of sense for frontbuffer-rendering X, which
also doesn't do per-scanout pixmaps. But for atomic flips you really
want to flip on the crtc (or well plane), since otherwise with
multiple planes it comes up all teared up. vmwgfx doesn't care I guess
since you only have 1 primary plane, but all the SoC chips very much
do.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
