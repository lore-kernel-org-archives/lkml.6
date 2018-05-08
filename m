Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbeEHBgu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:36:50 -0400
Received: from regular1.263xmail.com ([211.150.99.134]:59802 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbeEHBgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:36:33 -0400
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
X-UNIQUE-TAG: <9214384948890b49698780a307ec475f>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AF0FF18.1050905@rock-chips.com>
Date: Tue, 08 May 2018 09:36:24 +0800
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
References: <20180503065553.7762-1-jeffy.chen@rock-chips.com> <20180507221511.GA6448@rodete-desktop-imager.corp.google.com>
In-Reply-To: <20180507221511.GA6448@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 05/08/2018 06:15 AM, Brian Norris wrote:
> + Doug
>
> Hi Jeffy,
>
> On Thu, May 03, 2018 at 02:55:53PM +0800, Jeffy Chen wrote:
>> We saw spurious irq when changing irq's trigger type, for example
>> setting gpio-keys's wakeup irq trigger type.
>>
>> And according to the TRM:
>> "Programming the GPIO registers for interrupt capability, edge-sensitive
>> or level-sensitive interrupts, and interrupt polarity should be
>> completed prior to enabling the interrupts on Port A in order to prevent
>> spurious glitches on the interrupt lines to the interrupt controller."
>>
>> Reported-by: Brian Norris <briannorris@google.com>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>>   drivers/pinctrl/pinctrl-rockchip.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
>> index 3924779f55785..7ff45ec8330d1 100644
>> --- a/drivers/pinctrl/pinctrl-rockchip.c
>> +++ b/drivers/pinctrl/pinctrl-rockchip.c
>> @@ -2727,9 +2727,19 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
>>   		return -EINVAL;
>>   	}
>>
>> +	/**
>
> The typical multiline comment style is to use only 1 asterisk -- 2
> asterisks usually denote something more formal, like kerneldoc.

ok, will fix it.

>
>> +	 * According to the TRM, we should keep irq disabled during programming
>> +	 * interrupt capability to prevent spurious glitches on the interrupt
>> +	 * lines to the interrupt controller.
>> +	 */
>
> It's also worth noting that this case may come up in
> rockchip_irq_demux() for EDGE_BOTH triggers:
>
> 		/*
> 		 * Triggering IRQ on both rising and falling edge
> 		 * needs manual intervention.
> 		 */
> 		if (bank->toggle_edge_mode & BIT(irq)) {
> ...
> 				polarity = readl_relaxed(bank->reg_base +
> 							 GPIO_INT_POLARITY);
> 				if (data & BIT(irq))
> 					polarity &= ~BIT(irq);
> 				else
> 					polarity |= BIT(irq);
> 				writel(polarity,
> 				       bank->reg_base + GPIO_INT_POLARITY);
>
> AIUI, this case is not actually a problem, because this polarity
> reconfiguration happens before we call generic_handle_irq(), so the
> extra spurious interrupt is handled and cleared after this point. But it
> seems like this should be noted somewhere in either the commit message,
> the code comments, or both.

just from my testing, the spurious irq only happen when set EDGE_RISING 
to a gpio which is already high level, or set EDGE_FALLING to a gpio 
which is already low level.so the demux / EDGE_BOTH seem ok.

but adding comments as your suggested is a good idea, will do that.

>
> On the other hand...this also implies there may be a race condition
> there, where we might lose an interrupt if there is an edge between the
> re-configuration of the polarity in rockchip_irq_demux() and the
> clearing/handling of the interrupt (handle_edge_irq() ->
> chip->irq_ack()). If we have an edge between there, then we might ack
> it, but leave the polarity such that we aren't ready for the next
> (inverted) edge.

if let me guess, the unexpected irq we saw is the hardware trying to 
avoid losing irq? for example, we set a EDGE_RISING, and the hardware 
saw the gpio is already high, then though it might lost an irq, so fake 
one for safe?

i'll try to confirm it with IC guys.

>
> I'm not 100% sure about the above, so it might be good to verify it. But
> I also expect this means there's really no way to 100% reliably
> implement both-edge trigger types on hardware like this that doesn't
> directly implement it. So I'm not sure what we'd do with that knowledge.
>
>> +	data = readl(bank->reg_base + GPIO_INTEN);
>> +	writel_relaxed(data & ~mask, gc->reg_base + GPIO_INTEN);
>
> Not sure if this is a needless optimization: but couldn't you only
> disable the interrupt (and make the level and polarity changes) only if
> the level or polarity are actually changing? For example, it's possible
> to end up here when changing from EDGE_BOTH to EDGE_RISING, but we might
> not actually program a new value.

right, i noticed that too, will add a patch for that in v2.
>
> Brian
>
>> +
>>   	writel_relaxed(level, gc->reg_base + GPIO_INTTYPE_LEVEL);
>>   	writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);
>>
>> +	writel_relaxed(data, gc->reg_base + GPIO_INTEN);
>> +
>>   	irq_gc_unlock(gc);
>>   	raw_spin_unlock_irqrestore(&bank->slock, flags);
>>   	clk_disable(bank->clk);
>> --
>> 2.11.0
>>
>>
>
>
>
