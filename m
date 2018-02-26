Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeBZPm0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:42:26 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15518 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752097AbeBZPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:42:23 -0500
Subject: Re: [PATCH v2 1/2] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
To: =?UTF-8?Q?Rados=c5=82aw_Pietrzyk?= <radoslaw.pietrzyk@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
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
        <linux-gpio@vger.kernel.org>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <a6dca941-c887-3066-9290-be7590ab8f9b@st.com>
 <CAFvLkMTzaFODziZC3fFGYu+F=RuMBx5tFgA1q2UFSk4KyfuU5A@mail.gmail.com>
From: Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <6ad0c9aa-ad22-05f8-8f8c-6a947eb335ae@st.com>
Date: Mon, 26 Feb 2018 16:23:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAFvLkMTzaFODziZC3fFGYu+F=RuMBx5tFgA1q2UFSk4KyfuU5A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Radosław

On 02/23/2018 06:37 PM, Radosław Pietrzyk wrote:
> I don't fully get it to be honest. If interrupt is pending it must
> have been enabled (unmasked) and requires to be handled acked. It will
> be acked by irq_chip.irq_ack handler within the edge handler.
> Therefore this additional acking is meaningless.
> 

Sorry, I did not see modification in pinctrl-stm32.c.
So it's ok for me

Acked-by: Ludovic Barre <ludovic.barre@st.com>
Tested-by: Ludovic Barre <ludovic.barre@st.com>

BR
Ludo
> 2018-02-23 16:46 GMT+01:00 Ludovic BARRE <ludovic.barre@st.com>:
>> hi Radoslaw
>>
>> The gpio-keys tests it's now functional on H7, great.
>> However the gpio-key test only the bank1 (like stm32f429).
>> Like the H7 introduce the multi-bank management,
>> we must perform complementary test.
>>
>> comment below about ack in handler
>>
>>
>> On 02/23/2018 09:31 AM, Radoslaw Pietrzyk wrote:
>>>
>>> - discards setting handle_simple_irq handler for hierarchy interrupts
>>> - removes acking in chained irq handler as this is done by
>>> irq_chip itself inside handle_edge_irq
>>> - removes unneeded irq_domain_ops.xlate callback
>>>
>>> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
>>> ---
>>>    drivers/irqchip/irq-stm32-exti.c | 13 -------------
>>>    1 file changed, 13 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-stm32-exti.c
>>> b/drivers/irqchip/irq-stm32-exti.c
>>> index 36f0fbe..8013a87 100644
>>> --- a/drivers/irqchip/irq-stm32-exti.c
>>> +++ b/drivers/irqchip/irq-stm32-exti.c
>>> @@ -79,13 +79,6 @@ static unsigned long stm32_exti_pending(struct
>>> irq_chip_generic *gc)
>>>          return irq_reg_readl(gc, stm32_bank->pr_ofst);
>>>    }
>>>    -static void stm32_exti_irq_ack(struct irq_chip_generic *gc, u32 mask)
>>> -{
>>> -       const struct stm32_exti_bank *stm32_bank = gc->private;
>>> -
>>> -       irq_reg_writel(gc, mask, stm32_bank->pr_ofst);
>>> -}
>>> -
>>>    static void stm32_irq_handler(struct irq_desc *desc)
>>>    {
>>>          struct irq_domain *domain = irq_desc_get_handler_data(desc);
>>> @@ -106,7 +99,6 @@ static void stm32_irq_handler(struct irq_desc *desc)
>>>                          for_each_set_bit(n, &pending, IRQS_PER_BANK) {
>>>                                  virq = irq_find_mapping(domain, irq_base +
>>> n);
>>>                                  generic_handle_irq(virq);
>>> -                               stm32_exti_irq_ack(gc, BIT(n));
>>
>>
>> the while loop " while ((pending = " has been introduce while original
>> upstream of this driver in V2 to V3
>> https://patchwork.ozlabs.org/patch/604190/
>> https://patchwork.ozlabs.org/patch/665242/
>>
>> the "ack" is needed to acknowledge the irq which are handled and which is
>> not the original irq for which we enter.
>>
>>>                          }
>>>                  }
>>>          }
>>> @@ -176,16 +168,12 @@ static int stm32_irq_set_wake(struct irq_data *data,
>>> unsigned int on)
>>>    static int stm32_exti_alloc(struct irq_domain *d, unsigned int virq,
>>>                              unsigned int nr_irqs, void *data)
>>>    {
>>> -       struct irq_chip_generic *gc;
>>>          struct irq_fwspec *fwspec = data;
>>>          irq_hw_number_t hwirq;
>>>          hwirq = fwspec->param[0];
>>> -       gc = irq_get_domain_generic_chip(d, hwirq);
>>>          irq_map_generic_chip(d, virq, hwirq);
>>> -       irq_domain_set_info(d, virq, hwirq, &gc->chip_types->chip, gc,
>>> -                           handle_simple_irq, NULL, NULL);
>>
>>
>> I see if it is not disturb the multi-bank.
>>
>>>          return 0;
>>>    }
>>> @@ -200,7 +188,6 @@ static void stm32_exti_free(struct irq_domain *d,
>>> unsigned int virq,
>>>      struct irq_domain_ops irq_exti_domain_ops = {
>>>          .map    = irq_map_generic_chip,
>>> -       .xlate  = irq_domain_xlate_onetwocell,
>>>          .alloc  = stm32_exti_alloc,
>>>          .free   = stm32_exti_free,
>>>    };
>>>
>>
>> BR
>> Ludo
