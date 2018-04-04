Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeDDSwW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:52:22 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:36190 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeDDSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:52:20 -0400
Subject: Re: [RFC] drm/atomic+msm: add helper to implement legacy dirtyfb
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepak Singh Rawat <drawat@vmware.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
References: <20180403224225.26776-1-robdclark@gmail.com>
 <4dac69b7-b0e6-a014-1c36-1a9934f14120@tronnes.org>
 <CAKMK7uFvjQF-SxPkx_G5Y_o1AHkbms=Dhkie9de3s4JyepyH1g@mail.gmail.com>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <9ea1c3b6-73e2-a132-3ec7-44c20a3dcad0@tronnes.org>
Date: Wed, 4 Apr 2018 20:52:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFvjQF-SxPkx_G5Y_o1AHkbms=Dhkie9de3s4JyepyH1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 04.04.2018 19.56, skrev Daniel Vetter:
> On Wed, Apr 4, 2018 at 7:41 PM, Noralf Trønnes <noralf@tronnes.org> wrote:
>>
>> Den 04.04.2018 00.42, skrev Rob Clark:
>>> Add an atomic helper to implement dirtyfb support.  This is needed to
>>> support DSI command-mode panels with x11 userspace (ie. when we can't
>>> rely on pageflips to trigger a flush to the panel).
>>>
>>> To signal to the driver that the async atomic update needs to
>>> synchronize with fences, even though the fb didn't change, the
>>> drm_atomic_state::dirty flag is added.
>>>
>>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>>> ---
>>> Background: there are a number of different folks working on getting
>>> upstream kernel working on various different phones/tablets with qcom
>>> SoC's.. many of them have command mode panels, so we kind of need a
>>> way to support the legacy dirtyfb ioctl for x11 support.
>>>
>>> I know there is work on a proprer non-legacy atomic property for
>>> userspace to communicate dirty-rect(s) to the kernel, so this can
>>> be improved from triggering a full-frame flush once that is in
>>> place.  But we kinda needa a stop-gap solution.
>>>
>>> I had considered an in-driver solution for this, but things get a
>>> bit tricky if userspace ands up combining dirtyfb ioctls with page-
>>> flips, because we need to synchronize setting various CTL.FLUSH bits
>>> with setting the CTL.START bit.  (ie. really all we need to do for
>>> cmd mode panels is bang CTL.START, but is this ends up racing with
>>> pageflips setting FLUSH bits, then bad things.)  The easiest soln
>>> is to wrap this up as an atomic commit and rely on the worker to
>>> serialize things.  Hence adding an atomic dirtyfb helper.
>>>
>>> I guess at least the helper, with some small addition to translate
>>> and pass-thru the dirty rect(s) is useful to the final atomic dirty-
>>> rect property solution.  Depending on how far off that is, a stop-
>>> gap solution could be useful.
>>
>> I have been waiting for someone to address this since I'm not skilled
>> enough myself to tackle the atomic machinery. It would be be nice to do
>> all flushing during commit since that would mean that the tinydrm drivers
>> could be driven solely through drm_simple_display_pipe_funcs. I wouldn't
>> have to wire through the dirty callback like I do now.
>>
>> I see that you use a nonblocking commit. What happens if a new dirtyfb
>> comes in before the previous is done?
> We could reuse the same trick we're doing in the fbdev code, of
> pushing the commit to a worker and doing it in a blocking fashion. Or
> at least wait for it to finish (can be done with the crtc_state->event
> stuff). That way userspace can pile us up in dirtyfb calls, but we'd
> do at most one per frame. More isn't really useful anyway.
>
>> If we could save the dirty clips, then I could use this in tinydrm.
>> A full flush over SPI takes ~50ms so I need to shave off where I can.
>>
>> This works for me in my tinydrm world:
> One thing I thought you've had around somewhere is some additional
> tracking code, so we don't have to take all the plane mutexes in the
> ->dirtyfb callback. Does that exist, or was that just a figment of my
> imagination?

I haven't looked at this at all since I know way too little about how
atomic works and after the discussion started with damage on page flips,
I knew I just had to wait for someone other than me to do this. And I
hardly know anything about how the multitude of userspace operates.
So I'm sorry, but I can't add much to this discussion, I fall off rather
quickly when the details and corner cases are discussed.
All I can do is state the needs of tinydrm :-)

Noralf.
