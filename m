Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933543AbeEICVs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 22:21:48 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:35649 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932579AbeEICVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 22:21:46 -0400
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-IP-DOMAINF: 1
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: dianders@chromium.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <a8af9026733d0f37ac786003f0728949>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AF25B2E.8080901@rock-chips.com>
Date: Wed, 09 May 2018 10:21:34 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
CC: LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH] pinctrl: rockchip: Disable interrupt when changing
 it's capability
References: <20180503065553.7762-1-jeffy.chen@rock-chips.com> <20180507221511.GA6448@rodete-desktop-imager.corp.google.com> <5AF0FF18.1050905@rock-chips.com> <20180508015623.GA61455@rodete-desktop-imager.corp.google.com> <CAD=FV=W_v+aoNT09k-2exVABTFzOp0heY-XWcLi95uPisZhiGQ@mail.gmail.com>
In-Reply-To: <CAD=FV=W_v+aoNT09k-2exVABTFzOp0heY-XWcLi95uPisZhiGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 05/09/2018 03:46 AM, Doug Anderson wrote:
> One note is that in the case Brian points at (where we need to
> simulate EDGE_BOTH by swapping edges) we purposely ignored the TRM and
> we needed to do that to avoid losing interrupts.  For details, see
> commit 53b1bfc76df2 ("pinctrl: rockchip: Avoid losing interrupts when
> supporting both edges").  We did this because:
>
> 1. We believed that the IP block in Rockchip SoCs has nearly the same
> logic as "gpio-dwapb.c" and that's what "gpio-dwapb.c" did.
>

hmm, but i saw the gpio-dwapb.c actually toggle trigger after handle 
irq, which might avoid the race Brian mentioned:
+               generic_handle_irq(gpio_irq);
+               irq_status &= ~BIT(hwirq);
+
+               if ((irq_get_trigger_type(gpio_irq) & IRQ_TYPE_SENSE_MASK)
+                       == IRQ_TYPE_EDGE_BOTH)
+                       dwapb_toggle_trigger(gpio, hwirq);


and i also saw ./qcom/pinctrl-msm.c do the 
toggle(msm_gpio_update_dual_edge_pos) at the end of 
msm_gpio_irq_set_type and msm_gpio_irq_ack, that seems can avoid the 
polarity races too.

> 2. We were actually losing real interrupts and this was the only way
> we could figure out how to fix it.
>
> When I tested that back in the day I was fairly convinced that we
> weren't losing any interrupts in the EDGE_BOTH case after my fix, but
> I certainly could have messed up.
>
>
> For the EDGE_BOTH case it was important not to lose an interrupt
> because, as you guys are talking about, we could end up configured the
> wrong way.  I think in your case where you're just picking one
> polarity losing an interrupt shouldn't matter since it's undefined
> exactly if an edge happens while you're in the middle of executing
> rockchip_irq_set_type().  Is that right?

right, so we now have 2 cases: rockchip_irq_demux/ rockchip_irq_set_type

if i'm right about the spurious irq(only happen when set rising for a 
high gpio, or set falling for a low gpio), then:

1/ rockchip_irq_demux
it's important to not losing irqs in this case, maybe we can

a) ack irq
b) update polarity for edge both irq

we don't need to disable irq in b), since we would not hit the spurious 
irq cases here(always check gpio level to toggle it)


2/ rockchip_irq_set_type
it's important to not having spurious irqs

so we can disable irq during changing polarity only in these case:
((rising && gpio is heigh) || (falling && gpio is low))

i'm still confirming the spurious irq with IC guys.

>
>
> -Doug
>
>
>
