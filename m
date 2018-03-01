Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966714AbeCAJJw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:09:52 -0500
Received: from regular1.263xmail.com ([211.150.99.141]:36483 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966648AbeCAJJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:09:46 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: geert@linux-m68k.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <d2b80ee611b310787c7f2a2ab79f0279>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A97C345.3060205@rock-chips.com>
Date: Thu, 01 Mar 2018 17:09:25 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Caesar Wang <wxt@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] soc: rockchip: power-domain: remove PM clocks
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com> <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com> <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com> <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com> <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com> <CAMuHMdVVDiuv7bpdC0X95Xy9dSK_TfjW5RvSekVym9Q02798Fg@mail.gmail.com> <CAAFQd5C0GZ9C-pAqAdpuyxaF2xthLPY62a921nmABTbbmYtBmQ@mail.gmail.com> <5A977638.8010506@rock-chips.com> <CAMuHMdU9PFAXwo+1Z7Baw1fanst9yFKZ3ohoSTiQiMKTaYMVVw@mail.gmail.com>
In-Reply-To: <CAMuHMdU9PFAXwo+1Z7Baw1fanst9yFKZ3ohoSTiQiMKTaYMVVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your reply.

On 03/01/2018 04:33 PM, Geert Uytterhoeven wrote:
>> >so maybe we can:
>> >1/ let the device(dts) or driver decide which clock is PM clk, and add it
>> >using*pm_clk_add*  APIs (even of_pm_clk_add_clks() if all clocks are pm clk)
>> >
>> >2/ add support for critical PM clk, which would return error to the driver
>> >if anything wrong
>> >
>> >3/ make sure PM clk always be controlled(otherwise it might be unexpected
>> >disabled by other clocks under the same clk parent?):
>> >  a) make sure Runtime PM is always enabled. and as discussed, we can select
>> >PM in ARCH_ROCKCHIP
> On Renesas SoCs, we only add the device's module clock with pm_clk_add().
> Drivers that don't care about properties of the module clock just call
> pm_runtime_*(). That way the same driver works on different SoCs using
> the same device, with and without power and/or clock domains.

well, i think we may need to check:
1/ so the driver might not know is the clock really enabled(currently):

static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
{
     if (!ce->clk)
         ce->clk = clk_get(dev, ce->con_id);
     if (IS_ERR(ce->clk)) {
         ce->status = PCE_STATUS_ERROR;

static inline void __pm_clk_enable(struct device *dev, struct 
pm_clock_entry *ce)
{
     int ret;

     if (ce->status < PCE_STATUS_ERROR) {
         ret = clk_enable(ce->clk);
         if (!ret)
             ce->status = PCE_STATUS_ENABLED;

it seems the status is private.

2/ the pm_clk_resume/suspend seems only be called in the domain's 
suspend/resume ops(or USE_PM_CLK_RUNTIME_OPS, or called directly in the 
drivers for example tegra-aconnect):

# cgrep pm_clk_resume -w
./include/linux/pm_clock.h:50:extern int pm_clk_resume(struct device *dev);
./include/linux/pm_clock.h:83:#define pm_clk_resume     NULL
./drivers/bus/tegra-aconnect.c:62:      return pm_clk_resume(dev);
./drivers/dma/tegra210-adma.c:649:      ret = pm_clk_resume(dev);
./drivers/base/power/clock_ops.c:421: * pm_clk_resume - Enable clocks in 
a device's PM clock list.
./drivers/base/power/clock_ops.c:424:int pm_clk_resume(struct device *dev)
./drivers/base/power/clock_ops.c:444:EXPORT_SYMBOL_GPL(pm_clk_resume);
./drivers/base/power/clock_ops.c:533:   ret = pm_clk_resume(dev);
./drivers/base/power/domain.c:1685:             genpd->dev_ops.start = 
pm_clk_resume;
./drivers/irqchip/irq-gic-pm.c:36:      ret = pm_clk_resume(dev);

so if the device doesn't have a power domain, the PM clks could be 
unmanaged right?

by the way, the tegra drivers(tegra-aconnect/tegra210-adma) seems like 
good examples of using current PM clks...


but anyway, force adding all clocks as PM clks in the rockchip power 
domain driver seems wrong...

>
> Drivers that care about properties of the module clock (mainly frequency)
> can still use the clk_*() API for that. Other (optional) clocks must be
> handled by the device driver itself.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
>
>
