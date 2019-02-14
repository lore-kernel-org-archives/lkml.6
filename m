Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840EBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7EC222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438263AbfBNKQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:16:59 -0500
Received: from foss.arm.com ([217.140.101.70]:40300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbfBNKQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:16:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42128EBD;
        Thu, 14 Feb 2019 02:16:58 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CCC53F575;
        Thu, 14 Feb 2019 02:16:55 -0800 (PST)
Subject: Re: [PATCH v5 3/5] arm64/kvm: context-switch ptrauth register
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-4-git-send-email-amit.kachhap@arm.com>
 <d862316b-5b2e-8187-04e0-c0be350c1624@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <6982dfea-8dad-f293-8193-39eb0ca789c3@arm.com>
Date:   Thu, 14 Feb 2019 15:46:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d862316b-5b2e-8187-04e0-c0be350c1624@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 1/31/19 9:55 PM, James Morse wrote:
> Hi Amit,
> 
> On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
>> When pointer authentication is supported, a guest may wish to use it.
>> This patch adds the necessary KVM infrastructure for this to work, with
>> a semi-lazy context switch of the pointer auth state.
>>
>> Pointer authentication feature is only enabled when VHE is built
>> into the kernel and present into CPU implementation so only VHE code
> 
> ~s/into/in the/?
> 
>> paths are modified.
>>
>> When we schedule a vcpu, we disable guest usage of pointer
>> authentication instructions and accesses to the keys. While these are
>> disabled, we avoid context-switching the keys. When we trap the guest
>> trying to use pointer authentication functionality, we change to eagerly
>> context-switching the keys, and enable the feature. The next time the
>> vcpu is scheduled out/in, we start again.
> 
>> Pointer authentication consists of address authentication and generic
>> authentication, and CPUs in a system might have varied support for
>> either. Where support for either feature is not uniform, it is hidden
>> from guests via ID register emulation, as a result of the cpufeature
>> framework in the host.
> 
> 
>> Unfortunately, address authentication and generic authentication cannot
>> be trapped separately, as the architecture provides a single EL2 trap
>> covering both. If we wish to expose one without the other, we cannot
>> prevent a (badly-written) guest from intermittently using a feature
>> which is not uniformly supported (when scheduled on a physical CPU which
>> supports the relevant feature). When the guest is scheduled on a
>> physical CPU lacking the feature, these attempts will result in an UNDEF
>> being taken by the guest.
> 
> This won't be fun. Can't KVM check that both are supported on all CPUs to avoid
> this? ...
The above message is confusing as both checks actually present. I will 
update.
> 
> 
>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
>> index dfcfba7..e1bf2a5 100644
>> --- a/arch/arm64/include/asm/cpufeature.h
>> +++ b/arch/arm64/include/asm/cpufeature.h
>> @@ -612,6 +612,11 @@ static inline bool system_supports_generic_auth(void)
>>   		 cpus_have_const_cap(ARM64_HAS_GENERIC_AUTH_IMP_DEF));
>>   }
>>   
>> +static inline bool kvm_supports_ptrauth(void)
>> +{
>> +	return system_supports_address_auth() && system_supports_generic_auth();
>> +}
> 
> ... oh you do check. Could you cover this in the commit message? (to avoid an
> UNDEF being taken by the guest we ... )
> 
> cpufeature.h is a strange place to put this, there are no other kvm symbols in
> there. But there are users of system_supports_foo() in kvm_host.h.
ok will check.
> 
> 
>> diff --git a/arch/arm64/kvm/hyp/ptrauth-sr.c b/arch/arm64/kvm/hyp/ptrauth-sr.c
>> new file mode 100644
>> index 0000000..0576c01
>> --- /dev/null
>> +++ b/arch/arm64/kvm/hyp/ptrauth-sr.c
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * arch/arm64/kvm/hyp/ptrauth-sr.c: Guest/host ptrauth save/restore
>> + *
>> + * Copyright 2018 Arm Limited
>> + * Author: Mark Rutland <mark.rutland@arm.com>
>> + *         Amit Daniel Kachhap <amit.kachhap@arm.com>
>> + */
>> +#include <linux/compiler.h>
>> +#include <linux/kvm_host.h>
>> +
>> +#include <asm/cpucaps.h>
>> +#include <asm/cpufeature.h>
>> +#include <asm/kvm_asm.h>
>> +#include <asm/kvm_hyp.h>
>> +#include <asm/pointer_auth.h>
>> +
>> +static __always_inline bool __hyp_text __ptrauth_is_enabled(struct kvm_vcpu *vcpu)
> 
> Why __always_inline? Doesn't the compiler decide for 'static' symbols in C files?
This is to make the function pointer authentication safe. Although it 
placed before key switch so may not be required.
> 
> 
>> +{
>> +	return IS_ENABLED(CONFIG_ARM64_PTR_AUTH) &&
>> +			vcpu->arch.ctxt.hcr_el2 & (HCR_API | HCR_APK);
>> +}
>> +
>> +void __no_ptrauth __hyp_text __ptrauth_switch_to_guest(struct kvm_vcpu *vcpu,
>> +					  struct kvm_cpu_context *host_ctxt,
>> +					  struct kvm_cpu_context *guest_ctxt)
>> +{
>> +	if (!__ptrauth_is_enabled(vcpu))
>> +		return;
>> +
> 
>> +	ptrauth_keys_store((struct ptrauth_keys *) &host_ctxt->sys_regs[APIAKEYLO_EL1]);
> 
> We can't cast part of an array to a structure like this. What happens if the
> compiler inserts padding in struct-ptrauth_keys, or the struct randomization
> thing gets hold of it: https://lwn.net/Articles/722293/
Yes this has got issue.
> 
> If we want to use the helpers that take a struct-ptrauth_keys, we need to keep
> the keys in a struct-ptrauth_keys. To do this we'd need to provide accessors so
> that GET_ONE_REG() of APIAKEYLO_EL1 comes from the struct-ptrauth_keys, instead
> of the sys_reg array.
ok.
> 
> 
> Wouldn't the host keys be available somewhere else? (they must get transfer to
> secondary CPUs somehow). Can we skip the save step when switching from the host?
Yes Host save can be done during vcpu_load and it works fine. However it 
does not work during hypervisor configuration stage(i.e where HCR_EL2 is 
saved/restored now) as keys are different.
> 
>> +	ptrauth_keys_switch((struct ptrauth_keys *) &guest_ctxt->sys_regs[APIAKEYLO_EL1]);
>> +}
> 
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 1f2d237..c798d0c 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -439,6 +451,18 @@ static inline bool kvm_arch_requires_vhe(void)
>>   	return false;
>>   }
>>
>> +void kvm_arm_vcpu_ptrauth_enable(struct kvm_vcpu *vcpu);
>> +void kvm_arm_vcpu_ptrauth_disable(struct kvm_vcpu *vcpu);
>> +
>> +static inline void kvm_arm_vcpu_ptrauth_reset(struct kvm_vcpu *vcpu)
>> +{
>> +	/* Disable ptrauth and use it in a lazy context via traps */
>> +	if (has_vhe() && kvm_supports_ptrauth())
>> +		kvm_arm_vcpu_ptrauth_disable(vcpu);
>> +}
> 
> (Could you move 'has_vhe()' into kvm_supports_ptrauth()? It fits with testing
> the other cpufeatures, and makes this a little more readable when you add
> 'allowed' to it later.)
yes.
> 
> 
>> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
>> index 03b36f1..301d332 100644
>> --- a/arch/arm64/kvm/hyp/switch.c
>> +++ b/arch/arm64/kvm/hyp/switch.c
>> @@ -483,6 +483,8 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>>   	sysreg_restore_guest_state_vhe(guest_ctxt);
>>   	__debug_switch_to_guest(vcpu);
>>   
>> +	__ptrauth_switch_to_guest(vcpu, host_ctxt, guest_ctxt);
>> +
>>   	__set_guest_arch_workaround_state(vcpu);
>>   
>>   	do {
>> @@ -494,6 +496,8 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>>   
>>   	__set_host_arch_workaround_state(vcpu);
>>   
>> +	__ptrauth_switch_to_host(vcpu, host_ctxt, guest_ctxt);
>> +
>>   	sysreg_save_guest_state_vhe(guest_ctxt);
>>   
>>   	__deactivate_traps(vcpu);
> 
> ...This makes me nervous...
> 
> __guest_enter() is a function that (might) change the keys, then we change them
> again here. We can't have any signed return address between these two points. I
> don't trust the compiler not to generate any.
> 
> ~
> 
> I had a chat with some friendly compiler folk... because there are two identical
> sequences in kvm_vcpu_run_vhe() and __kvm_vcpu_run_nvhe(), the compiler could
> move the common code to a function it then calls. Apparently this is called
> 'function outlining'.
> 
> If the compiler does this, and the guest changes the keys, I think we would fail
> the return address check.
> 
> Painting the whole thing with no_prauth would solve this, but this code then
> becomes a target.
> Because the compiler can't anticipate the keys changing, we ought to treat them
> the same way we do the callee saved registers, stack-pointer etc, and
> save/restore them in the __guest_enter() assembly code.
> 
> (we can still keep the save/restore in C, but call it from assembly so we know
> nothing new is going on the stack).
I checked this and it seems easy to put inside guest_enter/guest_exit.

//Amit D
> 
> 
> Thanks,
> 
> James
> 
