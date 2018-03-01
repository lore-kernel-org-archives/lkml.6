Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965699AbeCADkz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 22:40:55 -0500
Received: from regular1.263xmail.com ([211.150.99.131]:37998 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965662AbeCADky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 22:40:54 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: tfiga@chromium.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <010f964ee3883e8c87f6b5547557c0be>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A977638.8010506@rock-chips.com>
Date: Thu, 01 Mar 2018 11:40:40 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Tomasz Figa <tfiga@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Caesar Wang <wxt@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] soc: rockchip: power-domain: remove PM clocks
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com> <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com> <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com> <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com> <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com> <CAMuHMdVVDiuv7bpdC0X95Xy9dSK_TfjW5RvSekVym9Q02798Fg@mail.gmail.com> <CAAFQd5C0GZ9C-pAqAdpuyxaF2xthLPY62a921nmABTbbmYtBmQ@mail.gmail.com>
In-Reply-To: <CAAFQd5C0GZ9C-pAqAdpuyxaF2xthLPY62a921nmABTbbmYtBmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

if i'm reading the code right, the PM clk means:
1/ the clocks which would be enabled while power on
2/ these clocks are optional, it's ok if anything wrong with them
3/ controlled by pm_domain(or USE_PM_CLK_RUNTIME_OPS & pm_clk_add_notifier)

and currently we're adding all clocks of the attached device as PM clk 
in rockchip PM domain driver, which seems wrong. because we might have 
these kinds of clocks:
1/ critical, should block power on if anything wrong with it(failed to 
get/ prepare/ enable)
2/ optional, could ignore it if anything wrong
3/ only required in some special cases, for example register r/w, and 
doesn't need to stay enabled while power on

so maybe we can:
1/ let the device(dts) or driver decide which clock is PM clk, and add 
it using *pm_clk_add* APIs (even of_pm_clk_add_clks() if all clocks are 
pm clk)

2/ add support for critical PM clk, which would return error to the 
driver if anything wrong

3/ make sure PM clk always be controlled(otherwise it might be 
unexpected disabled by other clocks under the same clk parent?):
  a) make sure Runtime PM is always enabled. and as discussed, we can 
select PM in ARCH_ROCKCHIP

  b) make sure the device has a PM domain to control PM clk:
select ROCKCHIP_PM_DOMAINS for ARCH_ROCKCHIP(that would also select 
PM_GENERIC_DOMAINS)

check dev->pm_domain before hand over PM clk, since we only care about 
EPROBE_DEFER when attach PM domain:
         ret = dev_pm_domain_attach(_dev, true);
         if (ret != -EPROBE_DEFER) {
                 if (drv->probe) {
                         ret = drv->probe(dev);

or

  c) make pm_clk_suspend/pm_clk_resume part of the generic PM Runtime 
flow(even without a PM domain)


On 02/28/2018 10:07 PM, Tomasz Figa wrote:
> On Wed, Feb 28, 2018 at 10:11 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Hi Tomasz,
>>
>> On Wed, Feb 28, 2018 at 1:49 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>>> On Wed, Feb 28, 2018 at 9:32 PM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Wed, Feb 28, 2018 at 1:29 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>>>>> Also, how about systems where runtime PM is disabled? I think that's
>>>>> one of the reasons we control the clocks explicitly in the drivers
>>>>> anyway.
>>>>
>>>> On many platforms, Runtime PM is always enabled.
>>>
>>> Can we make such assumption? If so, could we just make an explicit
>>> "select PM_RUNTIME" in Kconfig of the SoC?
>>
>> Note that the PM_RUNTIME symbol was removed in commit 464ed18ebdb6236f
>> ("PM: Eliminate CONFIG_PM_RUNTIME"), in favor of plain PM.
>>
>> The following already select PM unconditionally:
>>    - ARCH_OMAP2PLUS_TYPICAL
>>    - ARCH_RENESAS (except EMEV2)
>>    - ARCH_TEGRA
>>    - ARCH_VEXPRESS
>
> Thanks! Sounds like we might be able to simplify a lot of things with
> doing the same for Rockchip.
>
> Best regards,
> Tomasz
>
>
>
