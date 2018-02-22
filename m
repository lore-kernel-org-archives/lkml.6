Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeBVK4Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:56:25 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54207 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753346AbeBVK4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:56:24 -0500
Subject: Re: [1/2] ARM: irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
To: radek <radoslaw.pietrzyk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>
References: <1519221027-4028-2-git-send-email-radoslaw.pietrzyk@gmail.com>
From: Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <d007f880-0509-e30c-4c28-94117d2f8037@st.com>
Date: Thu, 22 Feb 2018 11:55:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1519221027-4028-2-git-send-email-radoslaw.pietrzyk@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Radek

I've tested your change on stm32h743i-eval.dts board
and gpio-keys tests are not functional.
No interrupt occurs when we push or release button
(cat /proc/interrupt).

Board: stm32h743i-eval.dts
Test description: gpio-keys (gpioc 13 => exti 13), with gpio or 
interrupt property.

comment below

On 02/21/2018 02:50 PM, radek wrote:
> - allocates generic chip with handle_simple_irq
> 	which simplifies irq_domain_ops.alloc callback
> 	- removes ack register from generic chip which is not used for
> 	handle_simple_irq as acking is done in a chained handler
> 	- removes unneeded irq_domain_ops.xlate callback
> 
> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
> ---
>   drivers/irqchip/irq-stm32-exti.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index 36f0fbe..42e74e3 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -176,16 +176,12 @@ static int stm32_irq_set_wake(struct irq_data *data, unsigned int on)
>   static int stm32_exti_alloc(struct irq_domain *d, unsigned int virq,
>   			    unsigned int nr_irqs, void *data)
>   {
> -	struct irq_chip_generic *gc;
>   	struct irq_fwspec *fwspec = data;
>   	irq_hw_number_t hwirq;
>   
>   	hwirq = fwspec->param[0];
> -	gc = irq_get_domain_generic_chip(d, hwirq);
>   
>   	irq_map_generic_chip(d, virq, hwirq);
> -	irq_domain_set_info(d, virq, hwirq, &gc->chip_types->chip, gc,
> -			    handle_simple_irq, NULL, NULL);
>   
>   	return 0;
>   }
> @@ -200,7 +196,6 @@ static void stm32_exti_free(struct irq_domain *d, unsigned int virq,
>   
>   struct irq_domain_ops irq_exti_domain_ops = {
>   	.map	= irq_map_generic_chip,
> -	.xlate	= irq_domain_xlate_onetwocell,
>   	.alloc  = stm32_exti_alloc,
>   	.free	= stm32_exti_free,
>   };
> @@ -231,7 +226,7 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
>   	}
>   
>   	ret = irq_alloc_domain_generic_chips(domain, IRQS_PER_BANK, 1, "exti",
> -					     handle_edge_irq, clr, 0, 0);
> +					     handle_simple_irq, clr, 0, 0);

EXTI hardware block is trigged on pulse event rising or failing edge.
Why do you change to handle_simple_irq ?

>   	if (ret) {
>   		pr_err("%pOF: Could not allocate generic interrupt chip.\n",
>   			node);
> @@ -246,13 +241,10 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
>   
>   		gc->reg_base = base;
>   		gc->chip_types->type = IRQ_TYPE_EDGE_BOTH;
> -		gc->chip_types->chip.irq_ack = irq_gc_ack_set_bit;
>   		gc->chip_types->chip.irq_mask = irq_gc_mask_clr_bit;
>   		gc->chip_types->chip.irq_unmask = irq_gc_mask_set_bit;
>   		gc->chip_types->chip.irq_set_type = stm32_irq_set_type;
>   		gc->chip_types->chip.irq_set_wake = stm32_irq_set_wake;
> -		gc->chip_types->regs.ack = stm32_bank->pr_ofst;
> -		gc->chip_types->regs.mask = stm32_bank->imr_ofst;
>   		gc->private = (void *)stm32_bank;
>   
>   		/* Determine number of irqs supported */
> 

BR
Ludo
