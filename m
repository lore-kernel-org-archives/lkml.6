Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeDDN2L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:28:11 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34584 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDDN2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:28:10 -0400
X-Google-Smtp-Source: AIpwx4+BDAl/RUCzCMEZZUtgvaEvK7ZaYO1PrRz2G88bJ1hkG13UmfryLt+6CMZqdWWXLNcwhgEah6Wqs+ob4C1/ejM=
MIME-Version: 1.0
X-Originating-IP: [212.51.149.109]
In-Reply-To: <CAF6AEGv2yfBzSbcAdKqZ0wJT5XoF9uqZKKJT297aib10O88=xQ@mail.gmail.com>
References: <20180403224225.26776-1-robdclark@gmail.com> <CAKMK7uEH3Qu_Lkok60bOYkik6kyvDGtrS0kcQ=dFmCLRD-+1HA@mail.gmail.com>
 <307adb15-412a-1fe2-f116-27fe5b4a657d@shipmail.org> <20180404084320.GA3881@phenom.ffwll.local>
 <fa4074c7-5469-a69f-e4aa-bdc84e1a919a@shipmail.org> <20180404095604.GD3881@phenom.ffwll.local>
 <CAF6AEGs4BdOUQQH6N8_ywTA=8uraJNm8FGc1ZL8Pm9tqymy3Nw@mail.gmail.com>
 <20180404121617.GK3881@phenom.ffwll.local> <CAF6AEGv2yfBzSbcAdKqZ0wJT5XoF9uqZKKJT297aib10O88=xQ@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 4 Apr 2018 15:28:08 +0200
X-Google-Sender-Auth: pIcpBzgpusUaBEAMpfDbRaUXAWU
Message-ID: <CAKMK7uHWt3mKxdmsgruk_v4d_Rb=QrzLjVTgL4Z=y+5Xw6Ch4w@mail.gmail.com>
Subject: Re: [RFC] drm/atomic+msm: add helper to implement legacy dirtyfb
To: Rob Clark <robdclark@gmail.com>
Cc: Thomas Hellstrom <thomas@shipmail.org>,
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

On Wed, Apr 4, 2018 at 3:24 PM, Rob Clark <robdclark@gmail.com> wrote:
> On Wed, Apr 4, 2018 at 8:16 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Wed, Apr 04, 2018 at 07:40:32AM -0400, Rob Clark wrote:
>>> On Wed, Apr 4, 2018 at 5:56 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>> > On Wed, Apr 04, 2018 at 11:10:08AM +0200, Thomas Hellstrom wrote:
>>> >> On 04/04/2018 10:43 AM, Daniel Vetter wrote:
>>> >> > On Wed, Apr 04, 2018 at 10:22:21AM +0200, Thomas Hellstrom wrote:
>>> >> > > Hi,
>>> >> > >
>>> >> > > On 04/04/2018 08:58 AM, Daniel Vetter wrote:
>>> >> > > > On Wed, Apr 4, 2018 at 12:42 AM, Rob Clark <robdclark@gmail.com> wrote:
>>> >> > > > > Add an atomic helper to implement dirtyfb support.  This is needed to
>>> >> > > > > support DSI command-mode panels with x11 userspace (ie. when we can't
>>> >> > > > > rely on pageflips to trigger a flush to the panel).
>>> >> > > > >
>>> >> > > > > To signal to the driver that the async atomic update needs to
>>> >> > > > > synchronize with fences, even though the fb didn't change, the
>>> >> > > > > drm_atomic_state::dirty flag is added.
>>> >> > > > >
>>> >> > > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
>>> >> > > > > ---
>>> >> > > > > Background: there are a number of different folks working on getting
>>> >> > > > > upstream kernel working on various different phones/tablets with qcom
>>> >> > > > > SoC's.. many of them have command mode panels, so we kind of need a
>>> >> > > > > way to support the legacy dirtyfb ioctl for x11 support.
>>> >> > > > >
>>> >> > > > > I know there is work on a proprer non-legacy atomic property for
>>> >> > > > > userspace to communicate dirty-rect(s) to the kernel, so this can
>>> >> > > > > be improved from triggering a full-frame flush once that is in
>>> >> > > > > place.  But we kinda needa a stop-gap solution.
>>> >> > > > >
>>> >> > > > > I had considered an in-driver solution for this, but things get a
>>> >> > > > > bit tricky if userspace ands up combining dirtyfb ioctls with page-
>>> >> > > > > flips, because we need to synchronize setting various CTL.FLUSH bits
>>> >> > > > > with setting the CTL.START bit.  (ie. really all we need to do for
>>> >> > > > > cmd mode panels is bang CTL.START, but is this ends up racing with
>>> >> > > > > pageflips setting FLUSH bits, then bad things.)  The easiest soln
>>> >> > > > > is to wrap this up as an atomic commit and rely on the worker to
>>> >> > > > > serialize things.  Hence adding an atomic dirtyfb helper.
>>> >> > > > >
>>> >> > > > > I guess at least the helper, with some small addition to translate
>>> >> > > > > and pass-thru the dirty rect(s) is useful to the final atomic dirty-
>>> >> > > > > rect property solution.  Depending on how far off that is, a stop-
>>> >> > > > > gap solution could be useful.
>>> >> > > > Adding Noralf, who iirc already posted the full dirty helpers already somewhere.
>>> >> > > > -Daniel
>>> >> > > I've asked Deepak to RFC the core changes suggested for the full dirty blob
>>> >> > > on dri-devel. It builds on DisplayLink's suggestion, with a simple helper to
>>> >> > > get to the desired coordinates.
>>> >> > >
>>> >> > > One thing to perhaps discuss is how we would like to fit this with
>>> >> > > front-buffer rendering and the dirty ioctl. In the page-flip context, the
>>> >> > > dirty rects, like egl's swapbuffer_with_damage is a hint to restrict the
>>> >> > > damage region that can be fully ignored by the driver, new content is
>>> >> > > indicated by a new framebuffer.
>>> >> > >
>>> >> > > We could do the same for frontbuffer rendering: Either set a dirty flag like
>>> >> > > you do here, or provide a content_age state member. Since we clear the dirty
>>> >> > > flag on state copies, I guess that would be sufficient. The blob rectangles
>>> >> > > would then become a hint to restrict the damage region.
>>> >> > I'm not entirely following here - I thought for frontbuffer rendering the
>>> >> > dirty rects have always just been a hint, and that the driver was always
>>> >> > free to re-upload the entire buffer to the screen.
>>> >> >
>>> >> > And through a helper like Rob's proposing here (and have floated around in
>>> >> > different versions already) we'd essentially map a frontbuffer dirtyfb
>>> >> > call to a fake flip with dirty rect. Manual upload drivers already need to
>>> >> > upload the entire screen if they get a flip, since some userspace uses
>>> >> > that to flush out frontbuffer rendering (instead of calling dirtyfb).
>>> >> >
>>> >> > So from that pov the new dirty flag is kinda not necessary imo.
>>> >> >
>>> >> > > Another approach would be to have the presence of dirty rects without
>>> >> > > framebuffer change to indicate frontbuffer rendering.
>>> >> > >
>>> >> > > I think I like the first approach best, although it may be tempting for
>>> >> > > user-space apps to just set the dirty bit instead of providing the full
>>> >> > > damage region.
>>> >> > Or I'm not following you here, because I don't quite see the difference
>>> >> > between dirtyfb and a flip.
>>> >> > -Daniel
>>> >>
>>> >> OK, let me rephrase:
>>> >>
>>> >> From the driver's point-of-view, in the atomic world, new content and the
>>> >> need for manual upload is indicated by a change in fb attached to the plane.
>>> >>
>>> >> With Rob's patch here, (correct me if I'm wrong) in addition new content and
>>> >> the need for manual upload is identified by the dirty flag, (since the fb
>>> >> stays the same and the driver thus never identifies a page-flip).
>>> >
>>> > Hm, I'm not entirely sure Rob's approach is correct. Imo a pageflip
>>> > (atomic or not) should result in the entire buffer getting uploaded. The
>>> > dirty flag is kinda redundant, a flip with the same buffer works the same
>>> > way as a dirtyfb with the entire buffer as the dirty rectangle.
>>>
>>> Userspace could do a pageflip, but (with buffer-age extension) only
>>> re-render part of the frame.  So there is a use-case for full frame
>>> pageflip with hints about what region(s) changed since previous frame.
>>>
>>> (Of course userspace could screw that up and get different results on
>>> "command" vs "video" style display.. in that case, it gets to keep
>>> both pieces)
>>
>> I'm not against dirty on flips with the same buffer as an optimization.
>> Disagreement here is around whether a flip to the same buffer means:
>> a) nothing changed, upload nothing
>> b) entire buffer might have changed
>>
>> I'm proposing we standardize on b) (with maybe the exception of legacy
>> cursor ioctls because those are special) and add the dirty rects as an
>> option to optimize this more.
>
> ok, I can agree w/ flip to same buffer, if FB_ID is in the incoming
> property list..  I just want a way to differentiate that from "plane
> got added to new state for unrelated reasons"..  so new_fb != old_fb
> isn't a good test for "should we synchronize", but new plane state
> isn't either.

Why do you add planes for unrelated reasons? Also I'm not clear on how
looking at FB_ID will work for all the legacy ioctls (plane_update,
page_flip, setcrtc can also be used to do a blocking flip, and is
used).

Atomic core doesn't add any unecessary planes. Atomic helpers add only
the planes for all the crtc you're touching anyway, so maybe we need
to add a flag there. Anything else is up to your driver code.
-Daniel

> Keeping the dirty flag (or sequence count or whatever mechanism) to
> indicate that an FB_ID that happened to be the same fb was part of
> what userspace passed in would do the trick.
>
> BR,
> -R
>
>> Either way you'd always have to follow the implicit fence (which is what
>> your msm hunk seems to be doing, but only for dirtyfb).
>> -Daniel
>>
>>>
>>> BR,
>>> -R
>>>
>>>
>>> >> In both these situations, clip rects can provide a hint to restrict the
>>> >> dirty region.
>>> >>
>>> >> Now I was thinking about the preferred way for user-space to communicate
>>> >> front buffer rendering through the atomic ioctl:
>>> >>
>>> >> 1) Expose a dirty (or content_age property)
>>> >> 2) Attach a clip-rect blob property.
>>> >> 3) Fake a page-flip by ping-ponging two frame-buffers pointing to the same
>>> >> underlying buffer object.
>>> >>
>>> >> Are you saying that people are already using 3) and we should keep using
>>> >> that?
>>> >
>>> > I'm saying they're using 3b), flip the same buffer wrapped in the same
>>> > drm_framebuffer, and expect it to work.
>>> >
>>> > The only advantage dirtyfb has is that it allows you to supply the
>>> > optimized upload rectangles, but at the cost of a funny api (it's working
>>> > on the fb, not the plane/crtc you want to upload) and lack of drm_event to
>>> > confirm when exactly you uploaded your stuff. But imo they should be the
>>> > same underlying operation.
>>> >
>>> > Also note that atomic helpers don't optimize out plane flips for same
>>> > buffers. We only optimize out some of the waiting, in a failed attempt at
>>> > making cursors stall less, but that's not fixed with the async plane
>>> > update stuff. And we can obviously optimize out the prepare/cleanup hooks,
>>> > because the buffer should be pinned already.
>>> >
>>> > So imo for a quick fix I think we need:
>>> > 1) Fix drivers (or at least msm) to upload buffers for manual upload on
>>> > all flips (well, all screen updates). Probably should do the fence waiting
>>> > unconditionally too (and handle cursors with the new async stuff).
>>> > 2) Tiny helper that remaps a dirtyfb call into a nonblocking atomic
>>> > commit, which currently means we're throwing the dirty rect optimization
>>> > into the wind. But that could easily be added to the drm_plane_state,
>>> > without exposing it to userspace as a property just yet.
>>> >
>>> > Cheers, Daniel
>>> > --
>>> > Daniel Vetter
>>> > Software Engineer, Intel Corporation
>>> > http://blog.ffwll.ch
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
