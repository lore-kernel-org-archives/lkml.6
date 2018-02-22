Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbeBVLB3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:01:29 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40170 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753627AbeBVLBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:01:25 -0500
X-Google-Smtp-Source: AH8x227nongGTL4xNN1zkLn/c/a++4TH2BNqvaQ3sR7xowTr4n3rMiU63MKa0Ey7Ip0e1oz+i63yE6gMgtiR9Pd+D30=
MIME-Version: 1.0
In-Reply-To: <d007f880-0509-e30c-4c28-94117d2f8037@st.com>
References: <1519221027-4028-2-git-send-email-radoslaw.pietrzyk@gmail.com> <d007f880-0509-e30c-4c28-94117d2f8037@st.com>
From: =?UTF-8?Q?Rados=C5=82aw_Pietrzyk?= <radoslaw.pietrzyk@gmail.com>
Date: Thu, 22 Feb 2018 12:01:22 +0100
Message-ID: <CAFvLkMSa5rQUS7xboNFZO_0x0unPmd6JKyROCjv4L-KgXbXzWg@mail.gmail.com>
Subject: Re: [1/2] ARM: irqchip: stm32: Optimizes and cleans up stm32-exti irq_domain
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ludovic,
I have tested on stm32f429-disco and it works without a problem.
handle_edge_irq is not used in current implementation because it is
substituted by handle_simple_irq in an alloc callback either way which
causes that irq_ack callback is not invoked as well (acking is done in
chained handler).

2018-02-22 11:55 GMT+01:00 Ludovic BARRE <ludovic.barre@st.com>:
> Hi Radek
>
> I've tested your change on stm32h743i-eval.dts board
> and gpio-keys tests are not functional.
> No interrupt occurs when we push or release button
> (cat /proc/interrupt).
>
> Board: stm32h743i-eval.dts
> Test description: gpio-keys (gpioc 13 => exti 13), with gpio or interrupt
> property.
>
> comment below
>
>
> On 02/21/2018 02:50 PM, radek wrote:
>>
>> - allocates generic chip with handle_simple_irq
>>         which simplifies irq_domain_ops.alloc callback
>>         - removes ack register from generic chip which is not used for
>>         handle_simple_irq as acking is done in a chained handler
>>         - removes unneeded irq_domain_ops.xlate callback
>>
>> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
>> ---
>>   drivers/irqchip/irq-stm32-exti.c | 10 +---------
>>   1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-stm32-exti.c
>> b/drivers/irqchip/irq-stm32-exti.c
>> index 36f0fbe..42e74e3 100644
>> --- a/drivers/irqchip/irq-stm32-exti.c
>> +++ b/drivers/irqchip/irq-stm32-exti.c
>> @@ -176,16 +176,12 @@ static int stm32_irq_set_wake(struct irq_data *data,
>> unsigned int on)
>>   static int stm32_exti_alloc(struct irq_domain *d, unsigned int virq,
>>                             unsigned int nr_irqs, void *data)
>>   {
>> -       struct irq_chip_generic *gc;
>>         struct irq_fwspec *fwspec = data;
>>         irq_hw_number_t hwirq;
>>         hwirq = fwspec->param[0];
>> -       gc = irq_get_domain_generic_chip(d, hwirq);
>>         irq_map_generic_chip(d, virq, hwirq);
>> -       irq_domain_set_info(d, virq, hwirq, &gc->chip_types->chip, gc,
>> -                           handle_simple_irq, NULL, NULL);
>>         return 0;
>>   }
>> @@ -200,7 +196,6 @@ static void stm32_exti_free(struct irq_domain *d,
>> unsigned int virq,
>>     struct irq_domain_ops irq_exti_domain_ops = {
>>         .map    = irq_map_generic_chip,
>> -       .xlate  = irq_domain_xlate_onetwocell,
>>         .alloc  = stm32_exti_alloc,
>>         .free   = stm32_exti_free,
>>   };
>> @@ -231,7 +226,7 @@ __init stm32_exti_init(const struct stm32_exti_bank
>> **stm32_exti_banks,
>>         }
>>         ret = irq_alloc_domain_generic_chips(domain, IRQS_PER_BANK, 1,
>> "exti",
>> -                                            handle_edge_irq, clr, 0, 0);
>> +                                            handle_simple_irq, clr, 0,
>> 0);
>
>
> EXTI hardware block is trigged on pulse event rising or failing edge.
> Why do you change to handle_simple_irq ?
>
>>         if (ret) {
>>                 pr_err("%pOF: Could not allocate generic interrupt
>> chip.\n",
>>                         node);
>> @@ -246,13 +241,10 @@ __init stm32_exti_init(const struct stm32_exti_bank
>> **stm32_exti_banks,
>>                 gc->reg_base = base;
>>                 gc->chip_types->type = IRQ_TYPE_EDGE_BOTH;
>> -               gc->chip_types->chip.irq_ack = irq_gc_ack_set_bit;
>>                 gc->chip_types->chip.irq_mask = irq_gc_mask_clr_bit;
>>                 gc->chip_types->chip.irq_unmask = irq_gc_mask_set_bit;
>>                 gc->chip_types->chip.irq_set_type = stm32_irq_set_type;
>>                 gc->chip_types->chip.irq_set_wake = stm32_irq_set_wake;
>> -               gc->chip_types->regs.ack = stm32_bank->pr_ofst;
>> -               gc->chip_types->regs.mask = stm32_bank->imr_ofst;
>>                 gc->private = (void *)stm32_bank;
>>                 /* Determine number of irqs supported */
>>
>
> BR
> Ludo
