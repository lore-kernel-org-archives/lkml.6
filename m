Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeDDI2B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:28:01 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:43323 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeDDI16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:27:58 -0400
Subject: Re: [RFC] drm/atomic+msm: add helper to implement legacy dirtyfb
To: Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>,
        Deepak Singh Rawat <drawat@vmware.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180403224225.26776-1-robdclark@gmail.com>
 <CAKMK7uEH3Qu_Lkok60bOYkik6kyvDGtrS0kcQ=dFmCLRD-+1HA@mail.gmail.com>
From: Thomas Hellstrom <thomas@shipmail.org>
Message-ID: <307adb15-412a-1fe2-f116-27fe5b4a657d@shipmail.org>
Date: Wed, 4 Apr 2018 10:22:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAKMK7uEH3Qu_Lkok60bOYkik6kyvDGtrS0kcQ=dFmCLRD-+1HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/04/2018 08:58 AM, Daniel Vetter wrote:
> On Wed, Apr 4, 2018 at 12:42 AM, Rob Clark <robdclark@gmail.com> wrote:
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
> Adding Noralf, who iirc already posted the full dirty helpers already somewhere.
> -Daniel

I've asked Deepak to RFC the core changes suggested for the full dirty 
blob on dri-devel. It builds on DisplayLink's suggestion, with a simple 
helper to get to the desired coordinates.

One thing to perhaps discuss is how we would like to fit this with 
front-buffer rendering and the dirty ioctl. In the page-flip context, 
the dirty rects, like egl's swapbuffer_with_damage is a hint to restrict 
the damage region that can be fully ignored by the driver, new content 
is indicated by a new framebuffer.

We could do the same for frontbuffer rendering: Either set a dirty flag 
like you do here, or provide a content_age state member. Since we clear 
the dirty flag on state copies, I guess that would be sufficient. The 
blob rectangles would then become a hint to restrict the damage region.

Another approach would be to have the presence of dirty rects without 
framebuffer change to indicate frontbuffer rendering.

I think I like the first approach best, although it may be tempting for 
user-space apps to just set the dirty bit instead of providing the full 
damage region.

/Thomas
