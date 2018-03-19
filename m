Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932669AbeCSIaz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:30:55 -0400
Received: from foss.arm.com ([217.140.101.70]:49694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753013AbeCSIaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:30:52 -0400
Subject: Re: [PATCH] irqchip: irq-gic-v4: return real error code
To: Peng Hao <peng.hao2@zte.com.cn>, tglx@linutronix.de,
        jason@lakedaemon.net
Cc: linux-kernel@vger.kernel.org
References: <1521459494-35746-1-git-send-email-peng.hao2@zte.com.cn>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <ca0dabab-e141-8591-d0f8-d7343147574f@arm.com>
Date: Mon, 19 Mar 2018 08:30:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521459494-35746-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/18 11:38, Peng Hao wrote:
> __irq_domain_alloc_irqs will return some different error code, so we
> should return real error code in its_alloc_vcpu_irqs.

What do we gain by doing so? Do we end-up treating the error in a
different way? What does this actually improve? This is the kind of
information I'm looking for in a commit message. Not something that
describes the patch.

> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/irqchip/irq-gic-v4.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
> index dba9d67..ecd170d 100644
> --- a/drivers/irqchip/irq-gic-v4.c
> +++ b/drivers/irqchip/irq-gic-v4.c
> @@ -99,7 +99,7 @@
>  
>  int its_alloc_vcpu_irqs(struct its_vm *vm)
>  {
> -	int vpe_base_irq, i;
> +	int vpe_base_irq, i, ret = -ENOMEM;
>  
>  	vm->fwnode = irq_domain_alloc_named_id_fwnode("GICv4-vpe",
>  						      task_pid_nr(current));
> @@ -120,8 +120,10 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
>  	vpe_base_irq = __irq_domain_alloc_irqs(vm->domain, -1, vm->nr_vpes,
>  					       NUMA_NO_NODE, vm,
>  					       false, NULL);
> -	if (vpe_base_irq <= 0)
> +	if (vpe_base_irq <= 0) {
> +		ret = vpe_base_irq;
>  		goto err;

Given that a return value of zero denotes an actual error, we can now
pretend that everything went smoothly, except that none of the doorbells
are initialized. KVM will then try and request the interrupts, which
will fail (because 0 is not a valid interrupt number).

We thus went from a situation where the error was completely unambiguous
(failed to allocate a bunch of interrupts) to a situation where things
fail in a bizarre way because we cannot request the interrupts that we
just allocated (something that shouldn't really fail).

I cannot call this change a real improvement.

> +	}
>  
>  	for (i = 0; i < vm->nr_vpes; i++)
>  		vm->vpes[i]->irq = vpe_base_irq + i;
> @@ -134,7 +136,7 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
>  	if (vm->fwnode)
>  		irq_domain_free_fwnode(vm->fwnode);
>  
> -	return -ENOMEM;
> +	return ret;
>  }
>  
>  void its_free_vcpu_irqs(struct its_vm *vm)
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
