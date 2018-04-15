Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeDOUqt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 16:46:49 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:18088 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbeDOUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 16:46:46 -0400
X-IronPort-AV: E=Sophos;i="5.48,456,1517875200";
   d="scan'208";a="674861416"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "jmattson@google.com" <jmattson@google.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v4] X86/KVM: Properly update 'tsc_offset' to represent the
 running guest
Thread-Topic: [PATCH v4] X86/KVM: Properly update 'tsc_offset' to represent
 the running guest
Thread-Index: AQHT0545DniFi8zaVkqhrPhFkI1w9aQCTngA
Date: Sun, 15 Apr 2018 20:46:41 +0000
Message-ID: <1523825200.22952.3.camel@amazon.de>
References: <1523675452-27271-1-git-send-email-karahmed@amazon.de>
In-Reply-To: <1523675452-27271-1-git-send-email-karahmed@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.245]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB2761A4B7D20B4FA79F9EAA4BBBF43B@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3FKksFv011769

On Sat, 2018-04-14 at 05:10 +0200, KarimAllah Ahmed wrote:
> Update 'tsc_offset' on vmentry/vmexit of L2 guests to ensure that it always
> captures the TSC_OFFSET of the running guest whether it is the L1 or L2
> guest.
> 
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> [AMD changes, fix update_ia32_tsc_adjust_msr. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> ---
> v3 -> v4:
> - Restore L01 tsc_offset on enter_vmx_non_root_mode failures.
> - Move tsc_offset update for L02 later in nested_vmx_run.
> 
> v2 -> v3:
> - Add AMD bits as well.
> - Fix update_ia32_tsc_adjust_msr.
> 
> v1 -> v2:
> - Rewrote the patch to always update tsc_offset to represent the current
>   guest (pbonzini@)
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/svm.c              | 17 ++++++++++++++++-
>  arch/x86/kvm/vmx.c              | 29 ++++++++++++++++++++++++-----
>  arch/x86/kvm/x86.c              |  6 ++++--
>  4 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 7a200f6..a40a32e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1016,6 +1016,7 @@ struct kvm_x86_ops {
>  
>  	bool (*has_wbinvd_exit)(void);
>  
> +	u64 (*read_l1_tsc_offset)(struct kvm_vcpu *vcpu);
>  	void (*write_tsc_offset)(struct kvm_vcpu *vcpu, u64 offset);
>  
>  	void (*get_exit_info)(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2);
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index b58787d..1f00c18 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1423,12 +1423,23 @@ static void init_sys_seg(struct vmcb_seg *seg, uint32_t type)
>  	seg->base = 0;
>  }
>  
> +static u64 svm_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	if (is_guest_mode(vcpu))
> +		return svm->nested.hsave->control.tsc_offset;
> +
> +	return vcpu->arch.tsc_offset;
> +}
> +
>  static void svm_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	u64 g_tsc_offset = 0;
>  
>  	if (is_guest_mode(vcpu)) {
> +		/* Write L1's TSC offset.  */
>  		g_tsc_offset = svm->vmcb->control.tsc_offset -
>  			       svm->nested.hsave->control.tsc_offset;
>  		svm->nested.hsave->control.tsc_offset = offset;
> @@ -3322,6 +3333,7 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
>  	/* Restore the original control entries */
>  	copy_vmcb_control_area(vmcb, hsave);
>  
> +	vcpu->arch.tsc_offset = svm->vmcb->control.tsc_offset;

Paolo,

'vcpu' is actually not defined in this context (and in all other 
occurrences below). Would you like me to send a fixed version of this 
bit or can you fix before applying?

>  	kvm_clear_exception_queue(&svm->vcpu);
>  	kvm_clear_interrupt_queue(&svm->vcpu);
>  
> @@ -3482,10 +3494,12 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
>  	/* We don't want to see VMMCALLs from a nested guest */
>  	clr_intercept(svm, INTERCEPT_VMMCALL);
>  
> +	vcpu->arch.tsc_offset += nested_vmcb->control.tsc_offset;
> +	svm->vmcb->control.tsc_offset = vcpu->arch.tsc_offset;
> +
>  	svm->vmcb->control.virt_ext = nested_vmcb->control.virt_ext;
>  	svm->vmcb->control.int_vector = nested_vmcb->control.int_vector;
>  	svm->vmcb->control.int_state = nested_vmcb->control.int_state;
> -	svm->vmcb->control.tsc_offset += nested_vmcb->control.tsc_offset;
>  	svm->vmcb->control.event_inj = nested_vmcb->control.event_inj;
>  	svm->vmcb->control.event_inj_err = nested_vmcb->control.event_inj_err;
>  
> @@ -7102,6 +7116,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
>  
>  	.has_wbinvd_exit = svm_has_wbinvd_exit,
>  
> +	.read_l1_tsc_offset = svm_read_l1_tsc_offset,
>  	.write_tsc_offset = svm_write_tsc_offset,
>  
>  	.set_tdp_cr3 = set_tdp_cr3,
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index b6942de..05ba3c6 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -2885,6 +2885,17 @@ static void setup_msrs(struct vcpu_vmx *vmx)
>  		vmx_update_msr_bitmap(&vmx->vcpu);
>  }
>  
> +static u64 vmx_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
> +{
> +	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> +
> +	if (is_guest_mode(vcpu) &&
> +	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING))
> +		return vcpu->arch.tsc_offset - vmcs12->tsc_offset;
> +
> +	return vcpu->arch.tsc_offset;
> +}
> +
>  /*
>   * reads and returns guest's timestamp counter "register"
>   * guest_tsc = (host_tsc * tsc multiplier) >> 48 + tsc_offset
> @@ -11112,11 +11123,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  		vmcs_write64(GUEST_IA32_PAT, vmx->vcpu.arch.pat);
>  	}
>  
> -	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
> -		vmcs_write64(TSC_OFFSET,
> -			vcpu->arch.tsc_offset + vmcs12->tsc_offset);
> -	else
> -		vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);
> +	vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);
> +
>  	if (kvm_has_tsc_control)
>  		decache_tsc_multiplier(vmx);
>  
> @@ -11366,6 +11374,8 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, bool from_vmentry)
>  	vmx_segment_cache_clear(vmx);
>  
>  	if (prepare_vmcs02(vcpu, vmcs12, from_vmentry, &exit_qual)) {
> +		if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
> +			vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
>  		leave_guest_mode(vcpu);
>  		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
>  		nested_vmx_entry_failure(vcpu, vmcs12,
> @@ -11377,6 +11387,8 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, bool from_vmentry)
>  					    vmcs12->vm_entry_msr_load_addr,
>  					    vmcs12->vm_entry_msr_load_count);
>  	if (msr_entry_idx) {
> +		if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
> +			vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
>  		leave_guest_mode(vcpu);
>  		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
>  		nested_vmx_entry_failure(vcpu, vmcs12,
> @@ -11461,6 +11473,9 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>  		return 1;
>  	}
>  
> +	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
> +		vcpu->arch.tsc_offset += vmcs12->tsc_offset;
> +
>  	/*
>  	 * We're finally done with prerequisite checking, and can start with
>  	 * the nested entry.
> @@ -11964,6 +11979,9 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
>  
>  	leave_guest_mode(vcpu);
>  
> +	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
> +		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
> +
>  	if (likely(!vmx->fail)) {
>  		if (exit_reason == -1)
>  			sync_vmcs12(vcpu, vmcs12);
> @@ -12801,6 +12819,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  
>  	.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
>  
> +	.read_l1_tsc_offset = vmx_read_l1_tsc_offset,
>  	.write_tsc_offset = vmx_write_tsc_offset,
>  
>  	.set_tdp_cr3 = vmx_set_cr3,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7846a8a..2f83cb2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1490,7 +1490,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
>  
>  static void update_ia32_tsc_adjust_msr(struct kvm_vcpu *vcpu, s64 offset)
>  {
> -	u64 curr_offset = vcpu->arch.tsc_offset;
> +	u64 curr_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
>  	vcpu->arch.ia32_tsc_adjust_msr += offset - curr_offset;
>  }
>  
> @@ -1532,7 +1532,9 @@ static u64 kvm_compute_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
>  
>  u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc)
>  {
> -	return vcpu->arch.tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
> +	u64 tsc_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
> +
> +	return tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
>  }
>  EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);
>  
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
