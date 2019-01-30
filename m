Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A9BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572A520855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfA3O6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:58:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbfA3O6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:58:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B695DEBD;
        Wed, 30 Jan 2019 06:58:29 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78C223F589;
        Wed, 30 Jan 2019 06:58:27 -0800 (PST)
Subject: Re: [PATCH v9 10/26] arm64: kvm: Unmask PMR before entering guest
To:     Christoffer Dall <christoffer.dall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, james.morse@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com,
        kvmarm@lists.cs.columbia.edu
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-11-git-send-email-julien.thierry@arm.com>
 <20190130120739.GH13482@e113682-lin.lund.arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <efdfde7a-38da-314d-67bd-eb3e9e47a34a@arm.com>
Date:   Wed, 30 Jan 2019 14:58:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190130120739.GH13482@e113682-lin.lund.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/2019 12:07, Christoffer Dall wrote:
> On Mon, Jan 21, 2019 at 03:33:29PM +0000, Julien Thierry wrote:
>> Interrupts masked by ICC_PMR_EL1 will not be signaled to the CPU. This
>> means that hypervisor will not receive masked interrupts while running a
>> guest.
>>
> 
> You could add to the commit description how this works overall,
> something along the lines of:
> 
> We need to make sure that all maskable interrupts are masked from the
> time we call local_irq_disable() in the main run loop, and remain so
> until we call local_irq_enable() after returning from the guest, and we
> need to ensure that we see no interrupts at all (including pseudo-NMIs)
> in the middle of the VM world-switch, while at the same time we need to
> ensure we exit the guest when there are interrupts for the host.
> 
> We can accomplish this with pseudo-NMIs enabled by:
>   (1) local_irq_disable: set the priority mask
>   (2) enter guest: set PSTATE.I
>   (3)              clear the priority mask
>   (4) eret to guest
>   (5) exit guest:  set the priotiy mask
>                    clear PSTATE.I (and restore other host PSTATE bits)
>   (6) local_irq_enable: clear the priority mask.
> 

Thanks for the suggestion. I'll add it to the commit.

> Also, took me a while to realize that when we come back from the guest,
> we call local_daif_restore with DAIF_PROCCTX_NOIRQ, which actually does
> both of the things in (5).
> 

Yes, I can imagine this being no that obvious. I'll add a comment above
the call to local_daif_restore() in kvm_arm_vhe_guest_exit().

>> Avoid this by making sure ICC_PMR_EL1 is unmasked when we enter a guest.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: kvmarm@lists.cs.columbia.edu
>> ---
>>  arch/arm64/include/asm/kvm_host.h | 12 ++++++++++++
>>  arch/arm64/kvm/hyp/switch.c       | 16 ++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 7732d0b..a1f9f55 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -24,6 +24,7 @@
>>  
>>  #include <linux/types.h>
>>  #include <linux/kvm_types.h>
>> +#include <asm/arch_gicv3.h>
>>  #include <asm/cpufeature.h>
>>  #include <asm/daifflags.h>
>>  #include <asm/fpsimd.h>
>> @@ -474,6 +475,17 @@ static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
>>  static inline void kvm_arm_vhe_guest_enter(void)
>>  {
>>  	local_daif_mask();
>> +
>> +	/*
>> +	 * Having IRQs masked via PMR when entering the guest means the GIC
>> +	 * will not signal the CPU of interrupts of lower priority, and the
>> +	 * only way to get out will be via guest exceptions.
>> +	 * Naturally, we want to avoid this.
>> +	 */
>> +	if (system_uses_irq_prio_masking()) {
>> +		gic_write_pmr(GIC_PRIO_IRQON);
>> +		dsb(sy);
>> +	}
>>  }
>>  
>>  static inline void kvm_arm_vhe_guest_exit(void)
>> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
>> index b0b1478..6a4c2d6 100644
>> --- a/arch/arm64/kvm/hyp/switch.c
>> +++ b/arch/arm64/kvm/hyp/switch.c
>> @@ -22,6 +22,7 @@
>>  
>>  #include <kvm/arm_psci.h>
>>  
>> +#include <asm/arch_gicv3.h>
>>  #include <asm/cpufeature.h>
>>  #include <asm/kvm_asm.h>
>>  #include <asm/kvm_emulate.h>
>> @@ -521,6 +522,17 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
>>  	struct kvm_cpu_context *guest_ctxt;
>>  	u64 exit_code;
>>  
>> +	/*
>> +	 * Having IRQs masked via PMR when entering the guest means the GIC
>> +	 * will not signal the CPU of interrupts of lower priority, and the
>> +	 * only way to get out will be via guest exceptions.
>> +	 * Naturally, we want to avoid this.
>> +	 */
>> +	if (system_uses_irq_prio_masking()) {
>> +		gic_write_pmr(GIC_PRIO_IRQON);
>> +		dsb(sy);
>> +	}
>> +
>>  	vcpu = kern_hyp_va(vcpu);
>>  
>>  	host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
>> @@ -573,6 +585,10 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
>>  	 */
>>  	__debug_switch_to_host(vcpu);
>>  
>> +	/* Returning to host will clear PSR.I, remask PMR if needed */
>> +	if (system_uses_irq_prio_masking())
>> +		gic_write_pmr(GIC_PRIO_IRQOFF);
>> +
>>  	return exit_code;
>>  }
>>  
> 
> nit: you could consider moving the non-vhe part into a new
> kvm_arm_nvhe_guest_enter, for symmetry with the vhe part.
> 

The idea is tempting, however on the one hand for VHE we do the guest
enter/exit around the VHE vcpu run call, but in the non-VHE the guest
enter/exit would be called from within the vcpu run call since we rely
on the hvc happening to mask daif before unmasking PMR.

So, I'm not sure we would gain that much symmetry with the VHE side.
Unless we move the kvm_arm_vhe_guest_enter()/exit() to VHE vcpu run call
(they are empty for arch/arm and only called in one site anyway...).

> Otherwise looks good to me:
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
> 

Thanks,

-- 
Julien Thierry
