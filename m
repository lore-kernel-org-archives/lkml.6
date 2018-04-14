Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeDNP4N (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 11:56:13 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:27594 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbeDNP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 11:56:10 -0400
X-IronPort-AV: E=Sophos;i="5.48,449,1517875200";
   d="scan'208";a="726165918"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "jmattson@google.com" <jmattson@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] kvm: nVMX: Introduce KVM_CAP_STATE
Thread-Topic: [PATCH 2/2] kvm: nVMX: Introduce KVM_CAP_STATE
Thread-Index: AQHT0nC6+MLPx/lKCUKGTnSUimWtFqQAbUeA
Date: Sat, 14 Apr 2018 15:56:00 +0000
Message-ID: <1523721359.32594.71.camel@amazon.de>
References: <1523545958-28059-1-git-send-email-karahmed@amazon.de>
         <1523545958-28059-2-git-send-email-karahmed@amazon.de>
In-Reply-To: <1523545958-28059-2-git-send-email-karahmed@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.76]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF25C020E9CFD84292CE8EC9E2FF064F@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3EFuI0U022135

On Thu, 2018-04-12 at 17:12 +0200, KarimAllah Ahmed wrote:
> From: Jim Mattson <jmattson@google.com>
> 
> For nested virtualization L0 KVM is managing a bit of state for L2 guests,
> this state can not be captured through the currently available IOCTLs. In
> fact the state captured through all of these IOCTLs is usually a mix of L1
> and L2 state. It is also dependent on whether the L2 guest was running at
> the moment when the process was interrupted to save its state.
> 
> With this capability, there are two new vcpu ioctls: KVM_GET_VMX_STATE and
> KVM_SET_VMX_STATE. These can be used for saving and restoring a VM that is
> in VMX operation.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jim Mattson <jmattson@google.com>
> [karahmed@ - rename structs and functions and make them ready for AMD and
>              address previous comments.
>            - rebase & a bit of refactoring.
>            - Merge 7/8 and 8/8 into one patch.
>            - Force a VMExit from L2 after reading the kvm_state to avoid
>              mixed state between L1 and L2 on resurrecting the instance. ]
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
> v2 -> v3:
> - Remove the forced VMExit from L2 after reading the kvm_state. The actual
>   problem is solved.
> - Rebase again!
> - Set nested_run_pending during restore (not sure if it makes sense yet or
>   not).
> - Reduce KVM_REQUEST_ARCH_BASE to 7 instead of 8 (the other alternative is
>   to switch everything to u64)
> 
> v1 -> v2:
> - Rename structs and functions and make them ready for AMD and address
>   previous comments.
> - Rebase & a bit of refactoring.
> - Merge 7/8 and 8/8 into one patch.
> - Force a VMExit from L2 after reading the kvm_state to avoid mixed state
>   between L1 and L2 on resurrecting the instance.
> ---
>  Documentation/virtual/kvm/api.txt |  47 ++++++++++
>  arch/x86/include/asm/kvm_host.h   |   7 ++
>  arch/x86/include/uapi/asm/kvm.h   |  38 ++++++++
>  arch/x86/kvm/vmx.c                | 177 +++++++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/x86.c                |  21 +++++
>  include/linux/kvm_host.h          |   2 +-
>  include/uapi/linux/kvm.h          |   5 ++
>  7 files changed, 292 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 1c7958b..c51d5d3 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -3548,6 +3548,53 @@ Returns: 0 on success,
>  	-ENOENT on deassign if the conn_id isn't registered
>  	-EEXIST on assign if the conn_id is already registered
>  
> +4.114 KVM_GET_STATE
> +
> +Capability: KVM_CAP_STATE
> +Architectures: x86
> +Type: vcpu ioctl
> +Parameters: struct kvm_state (in/out)
> +Returns: 0 on success, -1 on error
> +Errors:
> +  E2BIG:     the data size exceeds the value of 'size' specified by
> +             the user (the size required will be written into size).
> +
> +struct kvm_state {
> +	__u16 flags;
> +	__u16 format;
> +	__u32 size;
> +	union {
> +		struct kvm_vmx_state vmx;
> +		struct kvm_svm_state svm;
> +		__u8 pad[120];
> +	};
> +	__u8 data[0];
> +};
> +
> +This ioctl copies the vcpu's kvm_state struct from the kernel to userspace.
> +
> +4.115 KVM_SET_STATE
> +
> +Capability: KVM_CAP_STATE
> +Architectures: x86
> +Type: vcpu ioctl
> +Parameters: struct kvm_state (in)
> +Returns: 0 on success, -1 on error
> +
> +struct kvm_state {
> +	__u16 flags;
> +	__u16 format;
> +	__u32 size;
> +	union {
> +		struct kvm_vmx_state vmx;
> +		struct kvm_svm_state svm;
> +		__u8 pad[120];
> +	};
> +	__u8 data[0];
> +};
> +
> +This copies the vcpu's kvm_state struct from userspace to the kernel.
> +>>>>>>> 13a7c9e... kvm: nVMX: Introduce KVM_CAP_STATE
>  
>  5. The kvm_run structure
>  ------------------------
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 9fa4f57..ad2116a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -75,6 +75,7 @@
>  #define KVM_REQ_HV_EXIT			KVM_ARCH_REQ(21)
>  #define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
>  #define KVM_REQ_LOAD_EOI_EXITMAP	KVM_ARCH_REQ(23)
> +#define KVM_REQ_GET_VMCS12_PAGES	KVM_ARCH_REQ(24)
>  
>  #define CR0_RESERVED_BITS                                               \
>  	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
> @@ -1084,6 +1085,12 @@ struct kvm_x86_ops {
>  
>  	void (*setup_mce)(struct kvm_vcpu *vcpu);
>  
> +	int (*get_state)(struct kvm_vcpu *vcpu,
> +			 struct kvm_state __user *user_kvm_state);
> +	int (*set_state)(struct kvm_vcpu *vcpu,
> +			 struct kvm_state __user *user_kvm_state);
> +	void (*get_vmcs12_pages)(struct kvm_vcpu *vcpu);
> +
>  	int (*smi_allowed)(struct kvm_vcpu *vcpu);
>  	int (*pre_enter_smm)(struct kvm_vcpu *vcpu, char *smstate);
>  	int (*pre_leave_smm)(struct kvm_vcpu *vcpu, u64 smbase);
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index c535c2f..d2c860a 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -378,4 +378,42 @@ struct kvm_sync_regs {
>  #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
>  #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
>  
> +#define KVM_STATE_GUEST_MODE	0x00000001
> +#define KVM_STATE_RUN_PENDING	0x00000002
> +#define KVM_STATE_GIF		0x00000004
> +
> +struct kvm_vmx_state {
> +	__u64 vmxon_pa;
> +	__u64 vmcs_pa;
> +};
> +
> +struct kvm_svm_state {
> +	__u64 hsave_pa;
> +	__u64 vmcb_pa;
> +};
> +
> +/* for KVM_CAP_STATE */
> +struct kvm_state {
> +	/* KVM_STATE_* flags */
> +	__u16 flags;
> +
> +	/* 0 for VMX, 1 for SVM.  */
> +	__u16 format;
> +
> +	/* 128 for SVM, 128 + VMCS size for VMX.  */
> +	__u32 size;
> +
> +	union {
> +		/* VMXON, VMCS */
> +		struct kvm_vmx_state vmx;
> +		/* HSAVE_PA, VMCB */
> +		struct kvm_svm_state svm;
> +
> +		/* Pad the union to 120 bytes.  */
> +		__u8 pad[120];
> +	};
> +
> +	__u8 data[0];
> +};
> +
>  #endif /* _ASM_X86_KVM_H */
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 2f57571..c2b436b 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10359,10 +10359,10 @@ static void vmx_inject_page_fault_nested(struct kvm_vcpu *vcpu,
>  static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>  						 struct vmcs12 *vmcs12);
>  
> -static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
> -					struct vmcs12 *vmcs12)
> +static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>  
>  	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
>  		if (vmcs12->apic_access_addr != vmx->nested.apic_access_mapping.gfn << PAGE_SHIFT) {
> @@ -11430,8 +11430,6 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, bool from_vmentry)
>  		return 1;
>  	}
>  
> -	nested_get_vmcs12_pages(vcpu, vmcs12);
> -
>  	msr_entry_idx = nested_vmx_load_msr(vcpu,
>  					    vmcs12->vm_entry_msr_load_addr,
>  					    vmcs12->vm_entry_msr_load_count);
> @@ -11529,6 +11527,8 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>  	if (ret)
>  		return ret;
>  
> +	nested_get_vmcs12_pages(vcpu);
> +
>  	/*
>  	 * If we're entering a halted L2 vcpu and the L2 vcpu won't be woken
>  	 * by event injection, halt vcpu.
> @@ -12595,6 +12595,171 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> +static int get_vmcs_cache(struct kvm_vcpu *vcpu,
> +			  struct kvm_state __user *user_kvm_state)
> +{
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> +
> +	/*
> +	 * When running L2, the authoritative vmcs12 state is in the
> +	 * vmcs02. When running L1, the authoritative vmcs12 state is
> +	 * in the shadow vmcs linked to vmcs01, unless
> +	 * sync_shadow_vmcs is set, in which case, the authoritative
> +	 * vmcs12 state is in the vmcs12 already.
> +	 */
> +	if (is_guest_mode(vcpu))
> +		sync_vmcs12(vcpu, vmcs12);
> +	else if (enable_shadow_vmcs && !vmx->nested.sync_shadow_vmcs)
> +		copy_shadow_to_vmcs12(vmx);
> +
> +	if (copy_to_user(user_kvm_state->data, vmcs12, sizeof(*vmcs12)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int get_vmx_state(struct kvm_vcpu *vcpu,
> +			 struct kvm_state __user *user_kvm_state)
> +{
> +	u32 user_data_size;
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	struct kvm_state kvm_state = {
> +		.flags = 0,
> +		.format = 0,
> +		.size = sizeof(kvm_state),
> +		.vmx.vmxon_pa = -1ull,
> +		.vmx.vmcs_pa = -1ull,
> +	};
> +
> +	if (copy_from_user(&user_data_size, &user_kvm_state->size,
> +			   sizeof(user_data_size)))
> +		return -EFAULT;
> +
> +	if (nested_vmx_allowed(vcpu) && vmx->nested.vmxon) {
> +		kvm_state.vmx.vmxon_pa = vmx->nested.vmxon_ptr;
> +		kvm_state.vmx.vmcs_pa = vmx->nested.current_vmptr;
> +
> +		if (vmx->nested.current_vmptr != -1ull)
> +			kvm_state.size += VMCS12_SIZE;
> +
> +		if (is_guest_mode(vcpu)) {
> +			kvm_state.flags |= KVM_STATE_GUEST_MODE;
> +
> +			if (vmx->nested.nested_run_pending)
> +				kvm_state.flags |= KVM_STATE_RUN_PENDING;
> +		}
> +	}
> +
> +	if (user_data_size < kvm_state.size) {
> +		if (copy_to_user(&user_kvm_state->size, &kvm_state.size,
> +				 sizeof(kvm_state.size)))
> +			return -EFAULT;
> +		return -E2BIG;
> +	}
> +
> +	if (copy_to_user(user_kvm_state, &kvm_state, sizeof(kvm_state)))
> +		return -EFAULT;
> +
> +	if (vmx->nested.current_vmptr == -1ull)
> +		return 0;
> +
> +	return get_vmcs_cache(vcpu, user_kvm_state);
> +}
> +
> +static int set_vmcs_cache(struct kvm_vcpu *vcpu,
> +			  struct kvm_state __user *user_kvm_state,
> +			  struct kvm_state *kvm_state)
> +
> +{
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> +	u32 exit_qual;
> +	int ret;
> +
> +	if ((kvm_state->size < (sizeof(*vmcs12) + sizeof(*kvm_state))) ||
> +	    kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
> +	    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
> +		return -EINVAL;
> +
> +	if (copy_from_user(vmcs12, user_kvm_state->data, sizeof(*vmcs12)))
> +		return -EFAULT;
> +
> +	if (vmcs12->revision_id != VMCS12_REVISION)
> +		return -EINVAL;
> +
> +	set_current_vmptr(vmx, kvm_state->vmx.vmcs_pa);
> +
> +	if (!(kvm_state->flags & KVM_STATE_GUEST_MODE))
> +		return 0;
> +
> +	if (kvm_state->flags & KVM_STATE_RUN_PENDING)
> +		vmx->nested.nested_run_pending = 1;
> +
> +	if (check_vmentry_prereqs(vcpu, vmcs12) ||
> +	    check_vmentry_postreqs(vcpu, vmcs12, &exit_qual))
> +		return -EINVAL;
> +
> +	ret = enter_vmx_non_root_mode(vcpu, true);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * This request will result in a call to
> +	 * nested_get_vmcs12_pages before the next VM-entry.
> +	 */
> +	kvm_make_request(KVM_REQ_GET_VMCS12_PAGES, vcpu);
> +
> +	vmx->nested.nested_run_pending = 1;
> +
> +	return 0;
> +}
> +
> +static int set_vmx_state(struct kvm_vcpu *vcpu,
> +			 struct kvm_state __user *user_kvm_state)
> +{
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	struct kvm_state kvm_state;
> +	int ret;
> +
> +	if (copy_from_user(&kvm_state, user_kvm_state, sizeof(kvm_state)))
> +		return -EFAULT;
> +
> +	if (kvm_state.size < sizeof(kvm_state))
> +		return -EINVAL;
> +
> +	if (kvm_state.format != 0)
> +		return -EINVAL;
> +
> +	if (kvm_state.flags &
> +	    ~(KVM_STATE_RUN_PENDING | KVM_STATE_GUEST_MODE))
> +		return -EINVAL;
> +
> +	if (!nested_vmx_allowed(vcpu))
> +		return kvm_state.vmx.vmxon_pa == -1ull ? 0 : -EINVAL;
> +
> +	vmx_leave_nested(vcpu);
> +
> +	vmx->nested.nested_run_pending =
> +		!!(kvm_state.flags & KVM_STATE_RUN_PENDING);
> +
> +	if (kvm_state.vmx.vmxon_pa == -1ull)
> +		return 0;
> +
> +	if (!page_address_valid(vcpu, kvm_state.vmx.vmxon_pa))
> +		return -EINVAL;
> +
> +	vmx->nested.vmxon_ptr = kvm_state.vmx.vmxon_pa;
> +	ret = enter_vmx_operation(vcpu);
> +	if (ret)
> +		return ret;
> +
> +	if (kvm_state.vmx.vmcs_pa == -1ull)
> +		return 0;
> +
> +	return set_vmcs_cache(vcpu, user_kvm_state, &kvm_state);
> +}
> +
>  static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  	.cpu_has_kvm_support = cpu_has_kvm_support,
>  	.disabled_by_bios = vmx_disabled_by_bios,
> @@ -12728,6 +12893,10 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  
>  	.setup_mce = vmx_setup_mce,
>  
> +	.get_state = get_vmx_state,
> +	.set_state = set_vmx_state,
> +	.get_vmcs12_pages = nested_get_vmcs12_pages,
> +
>  	.smi_allowed = vmx_smi_allowed,
>  	.pre_enter_smm = vmx_pre_enter_smm,
>  	.pre_leave_smm = vmx_pre_leave_smm,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1a2ed92..565e1de 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2923,6 +2923,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_X2APIC_API:
>  		r = KVM_X2APIC_API_VALID_FLAGS;
>  		break;
> +	case KVM_CAP_STATE:
> +		r = !!kvm_x86_ops->get_state;
> +		break;
>  	default:
>  		break;
>  	}
> @@ -3941,6 +3944,22 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
>  		break;
>  	}
> +	case KVM_GET_STATE: {
> +		struct kvm_state __user *user_kvm_state = argp;
> +
> +		r = -EINVAL;
> +		if (kvm_x86_ops->get_state)
> +			r = kvm_x86_ops->get_state(vcpu, user_kvm_state);
> +		break;
> +	}
> +	case KVM_SET_STATE: {
> +		struct kvm_state __user *user_kvm_state = argp;
> +
> +		r = -EINVAL;
> +		if (kvm_x86_ops->set_state)
> +			r = kvm_x86_ops->set_state(vcpu, user_kvm_state);
> +		break;
> +	}
>  	default:
>  		r = -EINVAL;
>  	}
> @@ -7214,6 +7233,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	bool req_immediate_exit = false;
>  
>  	if (kvm_request_pending(vcpu)) {
> +		if (kvm_check_request(KVM_REQ_GET_VMCS12_PAGES, vcpu))
> +			kvm_x86_ops->get_vmcs12_pages(vcpu);
>  		if (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu))
>  			kvm_mmu_unload(vcpu);
>  		if (kvm_check_request(KVM_REQ_MIGRATE_TIMER, vcpu))
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 7a2889a..001b122 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -126,7 +126,7 @@ static inline bool is_error_page(struct page *page)
>  #define KVM_REQ_MMU_RELOAD        (1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_PENDING_TIMER     2
>  #define KVM_REQ_UNHALT            3
> -#define KVM_REQUEST_ARCH_BASE     8
> +#define KVM_REQUEST_ARCH_BASE     7

Paolo/Jim,

Is this bit acceptable for you or should I just go ahead and update
"requests" to be 64 bit instead?

We ran out of architecture specific bits :)

>  
>  #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
>  	BUILD_BUG_ON((unsigned)(nr) >= 32 - KVM_REQUEST_ARCH_BASE); \
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 077d16f..69e6791 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -961,6 +961,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_BPB 152
>  #define KVM_CAP_GET_MSR_FEATURES 153
>  #define KVM_CAP_HYPERV_EVENTFD 154
> +#define KVM_CAP_STATE 155
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> @@ -1392,6 +1393,10 @@ struct kvm_s390_ucas_mapping {
>  /* Memory Encryption Commands */
>  #define KVM_MEMORY_ENCRYPT_OP      _IOWR(KVMIO, 0xba, unsigned long)
>  
> +/* Available with KVM_CAP_STATE */
> +#define KVM_GET_STATE         _IOWR(KVMIO, 0xbb, struct kvm_vmx_state)
> +#define KVM_SET_STATE         _IOW(KVMIO,  0xbc, struct kvm_vmx_state)
> +
>  struct kvm_enc_region {
>  	__u64 addr;
>  	__u64 size;
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
