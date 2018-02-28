Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933844AbeB1RQy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:16:54 -0500
Received: from foss.arm.com ([217.140.101.70]:54520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932916AbeB1RQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:16:52 -0500
Date: Wed, 28 Feb 2018 17:16:48 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Grzegorz Jaszczyk <jaz@semihalf.com>, marc.zyngier@arm.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        takahiro.akashi@linaro.org, hoeun.ryu@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nadavh@marvell.com, mw@semihalf.com
Subject: Re: [PATCH] arm64: kdump: fix interrupt handling done during
 machine_crash_shutdown
Message-ID: <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding MarcZ]

On Wed, Feb 28, 2018 at 06:01:00PM +0100, Grzegorz Jaszczyk wrote:
> Hitherto during machine_kexec_mask_interrupts there was an attempt to
> remove active state using irq_set_irqchip_state() routine and only if it
> failed, the attempt to EOI the interrupt was made. Nevertheless relaying
> on return value from irq_set_irqchip_state inside
> machine_kexec_mask_interrupts is incorrect - it only returns the status
> of the routine but doesn't provide information if the interrupt was
> deactivated correctly or not. 

This doesn't sound right. The return value of irq_set_irqchip_state() is
certainly supposed to indicate that it did what it was asked to (i.e.
correctly (de)activated the interrupt).

IIUC, you're saying that there's a problem whereby:

(a) irq_set_irqchip_state() returns succesfully, but:

(b) irq_set_irqchip_state() does not alter the interrupt state to that
    requested.

... which sounds like a bug. 

When does this happen, exactly?

Thanks,
Mark.

> Therefore the irq_eoi wasn't call even if the interrupt remained
> active.
> 
> To determine the sate correctly the irq_get_irqchip_state() could be
> used but according to the ARM Generic Interrupt Controller Architecture
> Spec, non-secure reading from GICD_ISACTIVERn/GICD_ICACTIVERn can be not
> permitted (depending on NS_access setting of Non-secure Access Control
> Registers, a.k.a. GICD_NSACRn). What is more interesting GICD_NSACRn
> is optional Secure register.
> 
> Moreover de-activating the interrupt via GICD_ISACTIVERn register
> (regardless of the possibility of checking status or not) seems to not
> do the job, when the GIC Distributor is configured to forward the
> interrupts to the CPU interfaces.
> 
> Because of all above the attempt to deactivate interrupts via
> irq_set_irqchip_state() is removed in this patch. Instead the irq_eoi is
> called whenever the interrupt is in progress(irqd_irq_inprogress).
> 
> Before this patch the kdump triggered from interrupt context worked
> correctly by accident when the GIC was configured with
> GIC_CPU_CTRL_EOImodeNS == 1 (supports_deactivate == true). In mentioned
> mode GIC_CPU_EOI has priority drop functionality only and
> GIC_CPU_DEACTIVATE is used for interrupt deactivation. Also the
> gic_handle_irq behaviour is a bit different in mentioned mode and
> performs write to the GIC_CPU_EOI which causes the priority drop to the
> idle priority. So even if the irq_eoi wasn't called during
> machine_kexec_mask_interrupts, the interrupts of the crashdump kernel
> was handled due to interrupt preemption (since the priority of still
> active interrupt was dropped to idle priority).
> 
> Nevertheless when the kdump was triggered from interrupt context while
> the GIC was configured to work in GIC_CPU_CTRL_EOImodeNS == 0, the
> crashdump kernel hang in early stage due to lack of timer interrupt
> arrival.
> 
> After this fix the kdump behaves correctly when triggered from interrupt
> context independently of GIC_CPU_CTRL_EOImodeNS configuration.
> 
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
>  arch/arm64/kernel/machine_kexec.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index f76ea92..30ad183 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -220,20 +220,12 @@ static void machine_kexec_mask_interrupts(void)
>  
>  	for_each_irq_desc(i, desc) {
>  		struct irq_chip *chip;
> -		int ret;
>  
>  		chip = irq_desc_get_chip(desc);
>  		if (!chip)
>  			continue;
>  
> -		/*
> -		 * First try to remove the active state. If this
> -		 * fails, try to EOI the interrupt.
> -		 */
> -		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
> -
> -		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
> -		    chip->irq_eoi)
> +		if (irqd_irq_inprogress(&desc->irq_data) && chip->irq_eoi)
>  			chip->irq_eoi(&desc->irq_data);
>  
>  		if (chip->irq_mask)
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
