Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbeEHCcF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:32:05 -0400
Received: from regular1.263xmail.com ([211.150.99.131]:55926 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753692AbeEHCcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:32:01 -0400
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
X-FST-TO: briannorris@chromium.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <cbff0d7d483df8f6ca36a096ea5d3b44>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AF10C10.1070003@rock-chips.com>
Date: Tue, 08 May 2018 10:31:44 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Brian Norris <briannorris@chromium.org>
CC: linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [RESEND PATCH] pinctrl: rockchip: Disable interrupt when changing
 it's capability
References: <20180503065553.7762-1-jeffy.chen@rock-chips.com> <20180507221511.GA6448@rodete-desktop-imager.corp.google.com> <5AF0FF18.1050905@rock-chips.com> <20180508015623.GA61455@rodete-desktop-imager.corp.google.com>
In-Reply-To: <20180508015623.GA61455@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 05/08/2018 09:56 AM, Brian Norris wrote:
> On Tue, May 08, 2018 at 09:36:24AM +0800, Jeffy Chen wrote:
>> On 05/08/2018 06:15 AM, Brian Norris wrote:
>>> On the other hand...this also implies there may be a race condition
>>> there, where we might lose an interrupt if there is an edge between the
>>> re-configuration of the polarity in rockchip_irq_demux() and the
>>> clearing/handling of the interrupt (handle_edge_irq() ->
>>> chip->irq_ack()). If we have an edge between there, then we might ack
>>> it, but leave the polarity such that we aren't ready for the next
>>> (inverted) edge.
>>
>> if let me guess, the unexpected irq we saw is the hardware trying to avoid
>> losing irq? for example, we set a EDGE_RISING, and the hardware saw the gpio
>> is already high, then though it might lost an irq, so fake one for safe?
>
> I won't pretend to know what the IC designers were doing, but I don't
> think that would resolve the problem I'm talking about. The sequence is
> something like:
> 1. EDGE_BOTH IRQ occurs (e.g., low to high)
> 2. reconfigure polarity in rockchip_irq_demux() (polarity=low)
> 3. continue to handle_edge_irq()
> 4. another HW edge occurs (e.g., high to low)
> 5. handle_edge_irq() (from 3) acks (clears) IRQ (before a subsequent
>     rockchip_irq_demux() gets a chance to run and flip the polarity)
> ...
>
> Now the polarity is still low, but the next trigger should be a
> low-to-high edge.

oops, i see the problem.

so what if we do these:
1/ edge irq triggered
2/ read gpio level
3/ handle irq(ack irq)
4/ toggle edge mode(with a while gpio level check)

if the gpio changed in 2/ -> 3/, the 4/ will trigger an irq when writing 
GPIO_INT_POLARITY(which is what we are trying to avoid in the set_type case)

but this would not work if i'm wrong about how the HW fake an irq when 
changing POLARITY...


or maybe we could just check the gpio status again after 
handle_edge_irq, and correct the polarity in this case

>
>> i'll try to confirm it with IC guys.
>
> Brian
>
>
>
