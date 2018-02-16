Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbeBPUys (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:54:48 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33300 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeBPUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:54:46 -0500
X-Google-Smtp-Source: AH8x224FD3vMT7ZoNdtrEXDu1n/RgNrVwOI55lAGacqqQyajj0MkcaZngaa0MqLI05obmFqCAMb/oMcrqCdH69Sd45o=
MIME-Version: 1.0
In-Reply-To: <CAFqH_50OxDDfXjGPyNgtyu-qFn3zGqrLYprLtPJyHDYRDEczGQ@mail.gmail.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
 <20180130202913.28724-34-thierry.escande@collabora.com> <1517403243.14302.1.camel@pengutronix.de>
 <CAOw6vbKsG=B7vV5_NcwgeAc-=guRN1Xh-dCxKytkDeOjayatLw@mail.gmail.com>
 <CAD=FV=UB+ovYFSi2aB_qe3igX3K7BxMWaEEoNPx1UMdscKwQtQ@mail.gmail.com> <CAFqH_50OxDDfXjGPyNgtyu-qFn3zGqrLYprLtPJyHDYRDEczGQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 16 Feb 2018 12:54:44 -0800
X-Google-Sender-Auth: PA6DQPsaDCVRdfb1ymI966yVgbQ
Message-ID: <CAD=FV=UqPt5d=Kw4JBFZVgSNwvDZDCNd_ORV66MwWMxMJpW-eQ@mail.gmail.com>
Subject: Re: [PATCH v3 33/43] drm/panel: simple: Change mode for Sharp lq123p1jx31
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Sean Paul <seanpaul@chromium.org>, Haixia Shi <hshi@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>,
        Lin Huang <hl@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yakir Yang <ykk@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Mark Yao <mark.yao@rock-chips.com>, Zain Wang <wzz@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 16, 2018 at 4:34 AM, Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
> Hi,
>
> 2018-01-31 17:52 GMT+01:00 Doug Anderson <dianders@chromium.org>:
>> Hi,
>>
>>
>> On Wed, Jan 31, 2018 at 7:16 AM, Sean Paul <seanpaul@chromium.org> wrote:
>>> On Wed, Jan 31, 2018 at 7:54 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
>>>> Am Dienstag, den 30.01.2018, 21:29 +0100 schrieb Thierry Escande:
>>>>> From: Sean Paul <seanpaul@chromium.org>
>>>>>
>>>>> Change the mode for Sharp lq123p1jx31 panel to something more
>>>>> rockchip-friendly such that we can use the fixed PLLs to
>>>>> generate the pixel clock
>>>>
>>>> This should really switch to a display timing instead of exposing a
>>>> single mode. The display timing has min, typical, max tuples for all
>>>> the timings values, which would allow the attached driver to vary the
>>>> timings inside the allowed bounds if it makes sense.
>>>>
>>>> Trying to hit a specific pixel clock to free up a PLL is exactly one of
>>>> the use cases envisioned for the display timings stuff.
>>>>
>>>
>>> Agreed, I think we had this discussion the first time around. We
>>> should drop this patch.
>>>
>>> Thanks for catching this!
>>
>> Are you sure we should drop this?  In order for things to work
>> properly (not generate noise on the digitizer or other EMI), this
>> needs to run at a very specific pixel clock with very specific
>> blanking times.  I know that earlier we had slightly different
>> blanking times and Samsung came back and said that there was noise on
>> the digitizer.  I could be wrong, but I don't think there's any way
>> currently to be able to specify exactly what timings should be used on
>> a particular board.
>>
>> Don't get be wrong--I think a patch such as this one that claims a
>> single board's timings as the "right" ones for a generic panel is a
>> bit of a hack.  ...but at the same time there are no other users of
>> this panel (that I know of) in mainline and the timings presented here
>> are certainly sane timings for this panel.
>>
>> In any case, previous discussion at: https://patchwork.kernel.org/patch/9614603/
>>
>>
>> ...oh, and looking at the previous discussion reminds me that the
>> timings presented in this here patch are actually not the right ones
>> (they have the right PLL, but the wrong blankings to avoid the noise
>> issues).  See <//chromium-review.googlesource.com/381015>
>>
>
> As Thierry no longer has the hardware to test these patch series, I'll
> take care of these and follow the upstreaming process. I think that
> doesn't make sense send a v4 version of all 43 patches for this
> change. Right now, only this patch received comments so I'll wait a
> bit more for if we can get the other patches reviewed. If the others
> are fine just and I don't need to send a new version just don't apply
> this one and I will send a second version of that specific patch. Or
> even better, is really trivial what needs to be changed, so maybe the
> maintainer can do it? ;)

Just as a heads up, Sean Paul has a series of patches to replace this
patch.  The following are IDs from patchwork.kernel.org:

10207583 New          [v3,1/6] dt-bindings: Clarify timing subnode use
as panel-timing
10207585 New          [v3,2/6] dt-bindings: Add headings to
simple-panel bindings
10207591 New          [v3,3/6] dt-bindings: Add panel-timing subnode
to simple-panel
10207593 New          [v3,4/6] drm/panel: simple: Add ability to
override typical timing
10207595 New          [v3,5/6] drm/panel: simple: Use display_timing
for lq123p1jx31
10207603 New          [v3,6/6] arm64: dts: rockchip: Specify override
mode for kevin panel

-Doug
