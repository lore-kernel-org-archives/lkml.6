Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeFEMAc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:00:32 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28858 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751656AbeFEMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:00:30 -0400
Subject: Re: [PATCH] irqchip/stm32: fix non-SMP build warning
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: Rob Herring <robh@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20180605114347.1347128-1-arnd@arndb.de>
From: Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <1db5308c-7f53-112f-97dc-160ec2747887@st.com>
Date: Tue, 5 Jun 2018 13:59:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605114347.1347128-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/05/2018 01:43 PM, Arnd Bergmann wrote:
> Without CONFIG_SMP, we get a harmless compile-time warning:
> 
> drivers/irqchip/irq-stm32-exti.c:495:12: error: 'stm32_exti_h_set_affinity' defined but not used [-Werror=unused-function]
> 
> The #ifdef is inconsistent here, and it's better to use an IS_ENABLED() check
> that lets the compiler silently drop that function.
> 
> Fixes: 927abfc4461e ("irqchip/stm32: Add stm32mp1 support with hierarchy domain")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/irqchip/irq-stm32-exti.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index 5089c1e2838d..3a7e8905a97e 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -552,9 +552,7 @@ static struct irq_chip stm32_exti_h_chip = {
>   	.irq_set_type		= stm32_exti_h_set_type,
>   	.irq_set_wake		= stm32_exti_h_set_wake,
>   	.flags			= IRQCHIP_MASK_ON_SUSPEND,
> -#ifdef CONFIG_SMP
> -	.irq_set_affinity	= stm32_exti_h_set_affinity,
> -#endif
> +	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : NULL,

thanks Arnd, sorry to forgotten config flag test

Reviewed-by: Ludovic Barre <ludovic.barre@st.com>

>   };
>   
>   static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
> 
