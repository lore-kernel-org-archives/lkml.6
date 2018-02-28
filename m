Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeB1Mtc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:49:32 -0500
Received: from mail-ua0-f181.google.com ([209.85.217.181]:46336 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbeB1Mtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:49:31 -0500
X-Google-Smtp-Source: AG47ELsULwCON71r5A/gXwmu468JVR6CMQZsJg0g9E8hdKLMMsI/XLqCHpxAaWhQLEKICC6sPL8dKw==
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
 <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
 <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com> <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 28 Feb 2018 21:49:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com>
Message-ID: <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com>
Subject: Re: [PATCH] soc: rockchip: power-domain: remove PM clocks
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Caesar Wang <wxt@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 9:32 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Tomasz,
>
> On Wed, Feb 28, 2018 at 1:29 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>> On Wed, Feb 28, 2018 at 9:17 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Wed, Feb 28, 2018 at 12:11 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>>>> Currently we are adding all of the attached devices' clocks as pm clocks
>>>> and enable them when powering on the power domain.
>>>>
>>>> This seems unnecessary, because those clocks are already controlled in
>>>> the devices' drivers with better error handling.
>>>>
>>>> Tested on my chromebook minnie(rk3288) and chromebook kevin(rk3399).
>>>>
>>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>>
>>> Thanks for your patch!
>>>
>>> Just wondering: so you prefer to handle the clocks explicitly in all drivers,
>>> instead of delegating this task to Runtime PM?
>>
>> Is it already possible to gate clocks immediately when the device
>> idles, but defer turning the power domain off until time long enough
>> to cover the power down and up latency elapses?
>
> I'm not 100% sure.
> Note that clocks are turned off when the device idles, while powering down
> the power domain requires all devices in the domain to be idle.

I remember seeing some ongoing work for multiple power states of PM
domains on LWN, which could possibly solve it. I guess it's not done
yet.

Also, for Rockchip SoC, the typical setup is one device per domain,
+/- some auxiliary devices such as IOMMU, which would have the same
runtime PM state as the master device. (It isn't implemented yet, but
Jeffy posted patches for using device links some time ago.)

>
>> Also, how about systems where runtime PM is disabled? I think that's
>> one of the reasons we control the clocks explicitly in the drivers
>> anyway.
>
> On many platforms, Runtime PM is always enabled.

Can we make such assumption? If so, could we just make an explicit
"select PM_RUNTIME" in Kconfig of the SoC?

Best regards,
Tomasz
