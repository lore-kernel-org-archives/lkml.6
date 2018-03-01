Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967331AbeCAKhF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:37:05 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:47045 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965992AbeCAKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:37:02 -0500
X-Google-Smtp-Source: AG47ELuJerH6BdB8Bk9+Acs9cxwXK+i0Hi4mqxVhsNbo5Zgxn62UK3kW8nVpPqEphyCgKAf3ASFSzYPDCg/DVU6eQUI=
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq_hwao0hZCYmO-VrsW3vDJJboa1RG-TMLRQRgbt+YhpQ@mail.gmail.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
 <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
 <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com>
 <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com>
 <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com>
 <CAMuHMdVVDiuv7bpdC0X95Xy9dSK_TfjW5RvSekVym9Q02798Fg@mail.gmail.com>
 <CAAFQd5C0GZ9C-pAqAdpuyxaF2xthLPY62a921nmABTbbmYtBmQ@mail.gmail.com>
 <5A977638.8010506@rock-chips.com> <CAMuHMdU9PFAXwo+1Z7Baw1fanst9yFKZ3ohoSTiQiMKTaYMVVw@mail.gmail.com>
 <CAPDyKFq_hwao0hZCYmO-VrsW3vDJJboa1RG-TMLRQRgbt+YhpQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Mar 2018 11:37:00 +0100
X-Google-Sender-Auth: C7aLrygR7iDLOO-OTtexzXke_kE
Message-ID: <CAMuHMdWg1y3Ragb9nYY12whZhUn8w0a4aOOR31LSNXa37NbfXg@mail.gmail.com>
Subject: Re: [PATCH] soc: rockchip: power-domain: remove PM clocks
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: JeffyChen <jeffy.chen@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Caesar Wang <wxt@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Thu, Mar 1, 2018 at 11:18 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 1 March 2018 at 09:33, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, Mar 1, 2018 at 4:40 AM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
>>> 3/ make sure PM clk always be controlled(otherwise it might be unexpected
>>> disabled by other clocks under the same clk parent?):
>>>  a) make sure Runtime PM is always enabled. and as discussed, we can select
>>> PM in ARCH_ROCKCHIP
>
> I am fine enabling PM for ARCH_ROCKCHIP, if needed.
>
> However, what I don't agree with in general, is to make a generic
> driver to rely on having CONFIG_PM to be set to be functional. That's
> to me, bad practice.
>
> I understand, this approach exists in drivers today. I assume it
> works, because those drivers are being used on SoCs which always has
> CONFIG_PM set.

I agree. This is mostly useful for drivers that are used on multiple SoCs,
where the driver doesn't care about the clock (doesn't care about its
properties), and where the clock is optional (i.e. either tied to an
always-running bus clock, or to a controllable module clock, depending on SoC).
The latter needs CONFIG_PM=y, but that's a platform property, controlled
by selecting support for that specific SoC.

>> On Renesas SoCs, we only add the device's module clock with pm_clk_add().
>> Drivers that don't care about properties of the module clock just call
>> pm_runtime_*(). That way the same driver works on different SoCs using
>> the same device, with and without power and/or clock domains.
>
> I understand your point and I accept your view.
>
> However, I think this is more a mindset of which way one want
> implement things. This has been discussed several times in the mailing
> list as well.
>
> Surely we can cope with SoC specific constraints in drivers as well,
> we already do that.
>
> In principle I think this boils done to comparing a centralized
> method, where the PM domain deals with clocks vs a decentralized
> method, where the driver deals with clocks. Both works, both have
> positive and negative consequences.

Is the clock (are the clocks) used purely for power management of the device,
or does it/do they serve another (independent) purpose?

Note that unlike clocks, power areas cannot be controlled explicitly by the
driver. That always has to be done through the Runtime PM API.

> In my experience for ARM SoCs, I have found that centralized method
> doesn't work well, when one need flexibility. For example, if there
> are strict constraints on the order of how to put device's PM
> resources (clocks, pinctrl, etc) in low power states. For example, to
> avoid clock glitches.

With multiple clocks used by a device, there's sometimes also a lack of
understanding of the real clock hierarchy. If these multiple clocks need
to be enabled/disabled in a specific order, perhaps they are not
independent, and modelling the hierarchy correctly, and describing in DT
the device as being connected to the leaf clock may solve the ordering issue.

> Another problem with the PM clk is, more exactly with
> pm_clk_suspend|resume(), that those invokes only clk_enable|disable().
> pm_clk_suspend|resume() can't call clk_prepare|unprepare(), because we
> don't know if we running in atomic context when those are executed.
> Potentially this means leaving the clocks ungated - all the time.
>
> I have though about how to fix the above, several times, but I always
> ends up with thinking that's it more easy, to let the driver deal with
> the clocks, as then the problem goes away.

There's a similar issue with powering on/off power areas.
How do device start/stop differ from power domain on/off?

>> Drivers that care about properties of the module clock (mainly frequency)
>> can still use the clk_*() API for that. Other (optional) clocks must be
>> handled by the device driver itself.
>
> A comment on that;
>
> Before we the PM clk was introduced, we didn't have the clk_bulk_*()
> interface. To me, using clk_bulk_*() in drivers could help to simplify
> the code in regards to manage clocks (including SoC specific clocks)
> during runtime PM.
>
> Perhaps this could be an option to using PM clk, as it provides both
> flexibility and could manage SoC specific clocks.

See my comment about multiple clocks above...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
