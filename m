Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeA3RBn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:01:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56038 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753507AbeA3RBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:01:41 -0500
Subject: Re: [PATCH] irqchip/gic-v3: Fix gic_chip specific flag
To: fangxiang <fangxiang3@huawei.com>, tglx@linutronix.de,
        ljason@lakedaemon.net
Cc: linux-kernel@vger.kernel.org, gengyanping@hisilicon.com
References: <1517281005-18993-1-git-send-email-fangxiang3@huawei.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <e1e4f8de-e59b-0459-cc32-bed7181f8872@arm.com>
Date: Tue, 30 Jan 2018 17:01:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517281005-18993-1-git-send-email-fangxiang3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/18 02:56, fangxiang wrote:
> Both IRQCHIP_SKIP_SET_WAKE and .irq_set_wake() is
> not set in gic_chip V3. This causes
> set_irq_wake_real() return -ENXIO and a
> WARN(Unbalanced IRQ ... wake disable ...) in
> irq_set_irq_wake().
> 
> Signed-off-by: fangxiang <fangxiang3@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index b56c3e2..e8104b8 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -800,7 +800,8 @@ static inline void gic_cpu_pm_init(void) { }
>  	.irq_set_affinity	= gic_set_affinity,
>  	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
>  	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
> -	.flags			= IRQCHIP_SET_TYPE_MASKED,
> +	.flags			= IRQCHIP_SET_TYPE_MASKED |
> +				  IRQCHIP_SKIP_SET_WAKE,
>  };
>  
>  static struct irq_chip gic_eoimode1_chip = {
> 

That's sort of expected (the GIC itself doesn't implement any wake-up
mechanism), *unless* you have have a separate, stacked irqchip
implementing irq_set_wake. From your commit message, I cannot deduce
whether that's the case or not.

Please describe what you are fixing, and to what context this applies to.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
