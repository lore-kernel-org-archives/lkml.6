Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935835AbeCAKSl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:18:41 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:51517 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935717AbeCAKSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:18:12 -0500
X-Google-Smtp-Source: AG47ELvNlJ09Wh7DhKAfS1CCBlsCwgEA+dovpJocXZiQ2yLBQwJqJ6Iq5QynUHkThxD/h0iXx905v/Ry8yHAjwdqKKQ=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU9PFAXwo+1Z7Baw1fanst9yFKZ3ohoSTiQiMKTaYMVVw@mail.gmail.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
 <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
 <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com>
 <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com>
 <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com>
 <CAMuHMdVVDiuv7bpdC0X95Xy9dSK_TfjW5RvSekVym9Q02798Fg@mail.gmail.com>
 <CAAFQd5C0GZ9C-pAqAdpuyxaF2xthLPY62a921nmABTbbmYtBmQ@mail.gmail.com>
 <5A977638.8010506@rock-chips.com> <CAMuHMdU9PFAXwo+1Z7Baw1fanst9yFKZ3ohoSTiQiMKTaYMVVw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Mar 2018 11:18:10 +0100
Message-ID: <CAPDyKFq_hwao0hZCYmO-VrsW3vDJJboa1RG-TMLRQRgbt+YhpQ@mail.gmail.com>
Subject: Re: [PATCH] soc: rockchip: power-domain: remove PM clocks
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        JeffyChen <jeffy.chen@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

+linux-pm

Geert, Jeffry, Tomasz,

Apologize for side-tracking the discussion. Just wanted to add a few
comments, whatever it's worth to you.

On 1 March 2018 at 09:33, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Jeffy,
>
> On Thu, Mar 1, 2018 at 4:40 AM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
>> if i'm reading the code right, the PM clk means:
>> 1/ the clocks which would be enabled while power on
>> 2/ these clocks are optional, it's ok if anything wrong with them
>> 3/ controlled by pm_domain(or USE_PM_CLK_RUNTIME_OPS & pm_clk_add_notifier)
>>
>> and currently we're adding all clocks of the attached device as PM clk in
>> rockchip PM domain driver, which seems wrong. because we might have these
>> kinds of clocks:
>> 1/ critical, should block power on if anything wrong with it(failed to get/
>> prepare/ enable)
>> 2/ optional, could ignore it if anything wrong
>> 3/ only required in some special cases, for example register r/w, and
>> doesn't need to stay enabled while power on
>>
>> so maybe we can:
>> 1/ let the device(dts) or driver decide which clock is PM clk, and add it
>> using *pm_clk_add* APIs (even of_pm_clk_add_clks() if all clocks are pm clk)

We have already tried adding DT binding for this. Those got correctly
nacked, as this seems like a SW config and not HW config, at least in
my opinion.

>>
>> 2/ add support for critical PM clk, which would return error to the driver
>> if anything wrong
>>
>> 3/ make sure PM clk always be controlled(otherwise it might be unexpected
>> disabled by other clocks under the same clk parent?):
>>  a) make sure Runtime PM is always enabled. and as discussed, we can select
>> PM in ARCH_ROCKCHIP

I am fine enabling PM for ARCH_ROCKCHIP, if needed.

However, what I don't agree with in general, is to make a generic
driver to rely on having CONFIG_PM to be set to be functional. That's
to me, bad practice.

I understand, this approach exists in drivers today. I assume it
works, because those drivers are being used on SoCs which always has
CONFIG_PM set.

>
> On Renesas SoCs, we only add the device's module clock with pm_clk_add().
> Drivers that don't care about properties of the module clock just call
> pm_runtime_*(). That way the same driver works on different SoCs using
> the same device, with and without power and/or clock domains.

I understand your point and I accept your view.

However, I think this is more a mindset of which way one want
implement things. This has been discussed several times in the mailing
list as well.

Surely we can cope with SoC specific constraints in drivers as well,
we already do that.

In principle I think this boils done to comparing a centralized
method, where the PM domain deals with clocks vs a decentralized
method, where the driver deals with clocks. Both works, both have
positive and negative consequences.

In my experience for ARM SoCs, I have found that centralized method
doesn't work well, when one need flexibility. For example, if there
are strict constraints on the order of how to put device's PM
resources (clocks, pinctrl, etc) in low power states. For example, to
avoid clock glitches.

Another problem with the PM clk is, more exactly with
pm_clk_suspend|resume(), that those invokes only clk_enable|disable().
pm_clk_suspend|resume() can't call clk_prepare|unprepare(), because we
don't know if we running in atomic context when those are executed.
Potentially this means leaving the clocks ungated - all the time.

I have though about how to fix the above, several times, but I always
ends up with thinking that's it more easy, to let the driver deal with
the clocks, as then the problem goes away.

>
> Drivers that care about properties of the module clock (mainly frequency)
> can still use the clk_*() API for that. Other (optional) clocks must be
> handled by the device driver itself.

A comment on that;

Before we the PM clk was introduced, we didn't have the clk_bulk_*()
interface. To me, using clk_bulk_*() in drivers could help to simplify
the code in regards to manage clocks (including SoC specific clocks)
during runtime PM.

Perhaps this could be an option to using PM clk, as it provides both
flexibility and could manage SoC specific clocks.

Kind regards
Uffe
