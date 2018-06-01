Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeFAJRf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:17:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48808 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbeFAJRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:17:30 -0400
Subject: Re: [PATCH v1 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
To: Dongjiu Geng <gengdongjiu@huawei.com>, rkrcmar@redhat.com,
        corbet@lwn.net, christoffer.dall@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <1527772139-19665-1-git-send-email-gengdongjiu@huawei.com>
 <1527772139-19665-3-git-send-email-gengdongjiu@huawei.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <1bf8c082-7442-6963-a960-a89bee550411@arm.com>
Date: Fri, 1 Jun 2018 10:17:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527772139-19665-3-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/18 14:08, Dongjiu Geng wrote:
> For the migrating VMs, user space may need to know the exception
> state. For example, in the machine A, KVM make an SError pending,
> when migrate to B, KVM also needs to pend an SError.
> 
> This new IOCTL exports user-invisible states related to SError.
> Together with appropriate user space changes, user space can get/set
> the SError exception state to do migrate/snapshot/suspend.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> --
> this series patch is separated from https://www.spinics.net/lists/kvm/msg168917.html
> change since V12:
> 1. change (vcpu->arch.hcr_el2 & HCR_VSE) to !!(vcpu->arch.hcr_el2 & HCR_VSE) in kvm_arm_vcpu_get_events()
> 
> Change since V11:
> Address James's comments, thanks James
> 1. Align the struct of kvm_vcpu_events to 64 bytes
> 2. Avoid exposing the stale ESR value in the kvm_arm_vcpu_get_events()
> 3. Change variables 'injected' name to 'serror_pending' in the kvm_arm_vcpu_set_events()
> 4. Change to sizeof(events) from sizeof(struct kvm_vcpu_events) in kvm_arch_vcpu_ioctl()
> 
> Change since V10:
> Address James's comments, thanks James
> 1. Merge the helper function with the user.
> 2. Move the ISS_MASK into pend_guest_serror() to clear top bits
> 3. Make kvm_vcpu_events struct align to 4 bytes
> 4. Add something check in the kvm_arm_vcpu_set_events()
> 5. Check kvm_arm_vcpu_get/set_events()'s return value.
> 6. Initialise kvm_vcpu_events to 0 so that padding transferred to user-space doesn't
>    contain kernel stack.
> ---
>  Documentation/virtual/kvm/api.txt    | 31 ++++++++++++++++++++++++++++---
>  arch/arm/include/asm/kvm_host.h      |  6 ++++++
>  arch/arm/kvm/guest.c                 | 12 ++++++++++++
>  arch/arm64/include/asm/kvm_emulate.h |  5 +++++
>  arch/arm64/include/asm/kvm_host.h    |  7 +++++++
>  arch/arm64/include/uapi/asm/kvm.h    | 13 +++++++++++++
>  arch/arm64/kvm/guest.c               | 36 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/kvm/inject_fault.c        |  7 ++++++-
>  arch/arm64/kvm/reset.c               |  1 +
>  virt/kvm/arm/arm.c                   | 21 +++++++++++++++++++++
>  10 files changed, 135 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index fdac969..8896737 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -835,11 +835,13 @@ struct kvm_clock_data {
>  
>  Capability: KVM_CAP_VCPU_EVENTS
>  Extended by: KVM_CAP_INTR_SHADOW
> -Architectures: x86
> +Architectures: x86, arm, arm64
>  Type: vm ioctl
>  Parameters: struct kvm_vcpu_event (out)
>  Returns: 0 on success, -1 on error
>  
> +X86:
> +
>  Gets currently pending exceptions, interrupts, and NMIs as well as related
>  states of the vcpu.
>  
> @@ -881,15 +883,32 @@ Only two fields are defined in the flags field:
>  - KVM_VCPUEVENT_VALID_SMM may be set in the flags field to signal that
>    smi contains a valid state.
>  
> +ARM, ARM64:
> +
> +Gets currently pending SError exceptions as well as related states of the vcpu.
> +
> +struct kvm_vcpu_events {
> +	struct {
> +		__u8 serror_pending;
> +		__u8 serror_has_esr;
> +		/* Align it to 8 bytes */
> +		__u8 pad[6];
> +		__u64 serror_esr;
> +	} exception;
> +	__u32 reserved[12];
> +};
> +
>  4.32 KVM_SET_VCPU_EVENTS
>  
> -Capability: KVM_CAP_VCPU_EVENTS
> +Capebility: KVM_CAP_VCPU_EVENTS
>  Extended by: KVM_CAP_INTR_SHADOW
> -Architectures: x86
> +Architectures: x86, arm, arm64
>  Type: vm ioctl
>  Parameters: struct kvm_vcpu_event (in)
>  Returns: 0 on success, -1 on error
>  
> +X86:
> +
>  Set pending exceptions, interrupts, and NMIs as well as related states of the
>  vcpu.
>  
> @@ -910,6 +929,12 @@ shall be written into the VCPU.
>  
>  KVM_VCPUEVENT_VALID_SMM can only be set if KVM_CAP_X86_SMM is available.
>  
> +ARM, ARM64:
> +
> +Set pending SError exceptions as well as related states of the vcpu.
> +
> +See KVM_GET_VCPU_EVENTS for the data structure.
> +
>  
>  4.33 KVM_GET_DEBUGREGS
>  
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index c7c28c8..39f9901 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -213,6 +213,12 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
>  int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
>  int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>  int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> +int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events);
> +
> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events);
> +
>  unsigned long kvm_call_hyp(void *hypfn, ...);
>  void force_vm_exit(const cpumask_t *mask);
>  
> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> index a18f33e..c685f0e 100644
> --- a/arch/arm/kvm/guest.c
> +++ b/arch/arm/kvm/guest.c
> @@ -261,6 +261,18 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  	return -EINVAL;
>  }
>  
> +int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events)
> +{
> +	return -EINVAL;
> +}
> +
> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events)
> +{
> +	return -EINVAL;
> +}
> +
>  int __attribute_const__ kvm_target_cpu(void)
>  {
>  	switch (read_cpuid_part()) {
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 1dab3a9..18f61ff 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -81,6 +81,11 @@ static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
>  	return (unsigned long *)&vcpu->arch.hcr_el2;
>  }
>  
> +static inline unsigned long vcpu_get_vsesr(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.vsesr_el2;
> +}
> +
>  static inline void vcpu_set_vsesr(struct kvm_vcpu *vcpu, u64 vsesr)
>  {
>  	vcpu->arch.vsesr_el2 = vsesr;
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 469de8a..357304a 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -335,6 +335,11 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
>  int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
>  int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>  int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> +int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events);
> +
> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events);
>  
>  #define KVM_ARCH_WANT_MMU_NOTIFIER
>  int kvm_unmap_hva(struct kvm *kvm, unsigned long hva);
> @@ -363,6 +368,8 @@ void handle_exit_early(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  int kvm_perf_init(void);
>  int kvm_perf_teardown(void);
>  
> +void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
> +
>  struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
>  
>  void __kvm_set_tpidr_el2(u64 tpidr_el2);
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 04b3256..df4faee 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -39,6 +39,7 @@
>  #define __KVM_HAVE_GUEST_DEBUG
>  #define __KVM_HAVE_IRQ_LINE
>  #define __KVM_HAVE_READONLY_MEM
> +#define __KVM_HAVE_VCPU_EVENTS
>  
>  #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
>  
> @@ -153,6 +154,18 @@ struct kvm_sync_regs {
>  struct kvm_arch_memory_slot {
>  };
>  
> +/* for KVM_GET/SET_VCPU_EVENTS */
> +struct kvm_vcpu_events {
> +	struct {
> +		__u8 serror_pending;
> +		__u8 serror_has_esr;
> +		/* Align it to 8 bytes */
> +		__u8 pad[6];
> +		__u64 serror_esr;
> +	} exception;
> +	__u32 reserved[12];
> +};
> +
>  /* If you need to interpret the index values, here is the key: */
>  #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
>  #define KVM_REG_ARM_COPROC_SHIFT	16
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 56a0260..71d3841 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -289,6 +289,42 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  	return -EINVAL;
>  }
>  
> +int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events)
> +{
> +	events->exception.serror_pending = !!(vcpu->arch.hcr_el2 & HCR_VSE);
> +	events->exception.serror_has_esr =
> +			cpus_have_const_cap(ARM64_HAS_RAS_EXTN) &&
> +					(!!vcpu_get_vsesr(vcpu));

This is odd. Isn't VSESR==0 a valid value? And isn't
serror_has_esr always true when ARM64_HAS_RAS_EXTN is set?

> +
> +	if (events->exception.serror_pending &&
> +		events->exception.serror_has_esr)
> +		events->exception.serror_esr = vcpu_get_vsesr(vcpu);
> +	else
> +		events->exception.serror_esr = 0;
> +
> +	return 0;
> +}
> +
> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events)
> +{
> +	bool serror_pending = events->exception.serror_pending;
> +	bool has_esr = events->exception.serror_has_esr;
> +
> +	if (serror_pending && has_esr) {
> +		if (!cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
> +			return -EINVAL;
> +
> +		kvm_set_sei_esr(vcpu, events->exception.serror_esr);
> +

Spurious blank line

> +	} else if (serror_pending) {
> +		kvm_inject_vabt(vcpu);
> +	}
> +
> +	return 0;
> +}
> +
>  int __attribute_const__ kvm_target_cpu(void)
>  {
>  	unsigned long implementor = read_cpuid_implementor();
> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index d8e7165..9e0ca56 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -166,7 +166,7 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
>  
>  static void pend_guest_serror(struct kvm_vcpu *vcpu, u64 esr)
>  {
> -	vcpu_set_vsesr(vcpu, esr);
> +	vcpu_set_vsesr(vcpu, esr & ESR_ELx_ISS_MASK);
>  	*vcpu_hcr(vcpu) |= HCR_VSE;
>  }
>  
> @@ -186,3 +186,8 @@ void kvm_inject_vabt(struct kvm_vcpu *vcpu)
>  {
>  	pend_guest_serror(vcpu, ESR_ELx_ISV);
>  }
> +
> +void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome)
> +{
> +	pend_guest_serror(vcpu, syndrome);
> +}

I think it'd make more sense to rename pend_guest_serror to
kvm_set_sei_esr and be done with it.

> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 38c8a64..20e919a 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -82,6 +82,7 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
>  		break;
>  	case KVM_CAP_SET_GUEST_DEBUG:
>  	case KVM_CAP_VCPU_ATTRIBUTES:
> +	case KVM_CAP_VCPU_EVENTS:
>  		r = 1;
>  		break;
>  	default:
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index a4c1b76..8b43968 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1107,6 +1107,27 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = kvm_arm_vcpu_has_attr(vcpu, &attr);
>  		break;
>  	}
> +	case KVM_GET_VCPU_EVENTS: {
> +		struct kvm_vcpu_events events;
> +
> +		memset(&events, 0, sizeof(events));

You could write this as

		struct kvm_cpu_events events = { };

but it'd make more sense if kvm_arm_vcpu_get_events() did all the work
rather than having this split responsibility.

> +		if (kvm_arm_vcpu_get_events(vcpu, &events))
> +			return -EINVAL;
> +
> +		if (copy_to_user(argp, &events, sizeof(events)))
> +			return -EFAULT;
> +
> +		return 0;
> +	}
> +	case KVM_SET_VCPU_EVENTS: {
> +		struct kvm_vcpu_events events;
> +
> +		if (copy_from_user(&events, argp,
> +				sizeof(struct kvm_vcpu_events)))

Prefer using sizeof(events) instead.

> +			return -EFAULT;
> +
> +		return kvm_arm_vcpu_set_events(vcpu, &events);
> +	}
>  	default:
>  		r = -EINVAL;
>  	}
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
