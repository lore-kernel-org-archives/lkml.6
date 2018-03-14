Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeCNOxm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:53:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751739AbeCNOxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:53:39 -0400
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
To: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc: x86@kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-8-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2747cc75-b549-61bb-9c1b-0f554a49b536@redhat.com>
Date: Wed, 14 Mar 2018 15:53:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309140249.2840-8-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 15:02, Vitaly Kuznetsov wrote:
> Enlightened VMCS is just a structure in memory, the main benefit
> besides avoiding somewhat slower VMREAD/VMWRITE is using clean field
> mask: we tell the underlying hypervisor which fields were modified
> since VMEXIT so there's no need to inspect them all.
> 
> Tight CPUID loop test shows significant speedup:
> Before: 18890 cycles
> After: 8304 cycles
> 
> Static key is being used to avoid performance penalty for non-Hyper-V
> deployments. Tests show we add around 3 (three) CPU cycles on each
> VMEXIT (1077.5 cycles before, 1080.7 cycles after for the same CPUID
> loop on bare metal). We can probably avoid one test/jmp in vmx_vcpu_run()
> but I don't see a clean way to use static key in assembly.

If you want to live dangerously, you can use text_poke_early to change
the vmwrite to mov.  It's just a single instruction, so it's probably
not too hard.

> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v2:
> - define KVM_EVMCS_VERSION [Radim Krčmář]
> - WARN_ONCE in get_evmcs_offset[,_cf] [Radim Krčmář]
> - add evmcs_sanitize_exec_ctrls() and use it in hardware_setup() and
>   dump_vmcs() [Radim Krčmář]
> ---
>  arch/x86/kvm/vmx.c | 625 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 615 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 051dab74e4e9..44b6efa7d54e 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -53,6 +53,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/microcode.h>
>  #include <asm/nospec-branch.h>
> +#include <asm/mshyperv.h>
>  
>  #include "trace.h"
>  #include "pmu.h"
> @@ -1000,6 +1001,484 @@ static const u32 vmx_msr_index[] = {
>  	MSR_EFER, MSR_TSC_AUX, MSR_STAR,
>  };
>  
> +DEFINE_STATIC_KEY_FALSE(enable_evmcs);
> +
> +#define current_evmcs ((struct hv_enlightened_vmcs *)this_cpu_read(current_vmcs))
> +
> +#if IS_ENABLED(CONFIG_HYPERV)
> +static bool __read_mostly enlightened_vmcs = true;
> +module_param(enlightened_vmcs, bool, 0444);
> +
> +#define KVM_EVMCS_VERSION 1
> +
> +#define EVMCS1_OFFSET(x) offsetof(struct hv_enlightened_vmcs, x)
> +#define EVMCS1_FIELD(number, name, clean_mask)[ROL16(number, 6)] = \
> +		(u32)EVMCS1_OFFSET(name) | ((u32)clean_mask << 16)
> +
> +/*
> + * Lower 16 bits encode offset of the field in struct hv_enlightened_vmcs,
> + * upped 16 bits hold clean field mask.
> + */
> +static const u32 vmcs_field_to_evmcs_1[] = {
> +	/* 64 bit rw */
> +	EVMCS1_FIELD(GUEST_RIP, guest_rip,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),

Maybe we should use a single "#include"d file (like vmx_shadow_fields.h)
and share it between HV-on-KVM and KVM-on-HV.

...

> +	EVMCS1_FIELD(VM_EXIT_MSR_STORE_ADDR, vm_exit_msr_store_addr,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
> +	EVMCS1_FIELD(VM_EXIT_MSR_LOAD_ADDR, vm_exit_msr_load_addr,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
> +	EVMCS1_FIELD(VM_ENTRY_MSR_LOAD_ADDR, vm_entry_msr_load_addr,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
> +	EVMCS1_FIELD(CR3_TARGET_VALUE0, cr3_target_value0,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
> +	EVMCS1_FIELD(CR3_TARGET_VALUE1, cr3_target_value1,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
> +	EVMCS1_FIELD(CR3_TARGET_VALUE2, cr3_target_value2,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
> +	EVMCS1_FIELD(CR3_TARGET_VALUE3, cr3_target_value3,
> +		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),

We shouldn't use these on Hyper-V, should we (that is, shouldn't the
WARN below fire if you try---and so why include them at all)?

> +
> +static inline u16 get_evmcs_offset(unsigned long field)
> +{
> +	unsigned int index = ROL16(field, 6);
> +
> +	if (index >= ARRAY_SIZE(vmcs_field_to_evmcs_1)) {
> +		WARN_ONCE(1, "kvm: reading unsupported EVMCS field %lx\n",
> +			  field);
> +		return 0;
> +	}
> +
> +	return (u16)vmcs_field_to_evmcs_1[index];
> +}
> +
> +static inline u16 get_evmcs_offset_cf(unsigned long field, u16 *clean_field)
> +{
> +	unsigned int index = ROL16(field, 6);
> +	u32 evmcs_field;
> +
> +	if (index >= ARRAY_SIZE(vmcs_field_to_evmcs_1)) {
> +		WARN_ONCE(1, "kvm: writing unsupported EVMCS field %lx\n",
> +			  field);
> +		return 0;
> +	}
> +
> +	evmcs_field = vmcs_field_to_evmcs_1[index];
> +
> +	*clean_field = evmcs_field >> 16;
> +
> +	return (u16)evmcs_field;
> +}

You can mark this __always_inline, and make it

	if (clean_field)
		*clean_field = evmcs_field >> 16;

or alternatively, use a two-element struct and do

	evmcs_field = &vmcs_field_to_evmcs_1[index];
	if (clean_field)
		*clean_field = evmcs_field->clean_field;
	return evmcs_field->offset;

Also, if you return int and make the WARN_ONCE case return -ENOENT, GCC
should be able to optimize out the "if (!offset)" (which becomes "if
(offset < 0)") in the callers.  Nitpicking, but...

> +static void vmcs_load_enlightened(u64 phys_addr)
> +{
> +	struct hv_vp_assist_page *vp_ap =
> +		hv_get_vp_assist_page(smp_processor_id());
> +
> +	vp_ap->current_nested_vmcs = phys_addr;
> +	vp_ap->enlighten_vmentry = 1;
> +}

evmcs_load?

> +static void evmcs_sanitize_exec_ctrls(u32 *cpu_based_2nd_exec_ctrl,
> +				      u32 *pin_based_exec_ctrl)
> +{
> +	*pin_based_exec_ctrl &= ~PIN_BASED_POSTED_INTR;> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_APIC_REGISTER_VIRT;
> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_ENABLE_PML;
> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_ENABLE_VMFUNC;
> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_SHADOW_VMCS;
> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_TSC_SCALING;
> +	*cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_PAUSE_LOOP_EXITING;
> +	*pin_based_exec_ctrl &= ~PIN_BASED_VMX_PREEMPTION_TIMER;

How can these be set?

> @@ -3596,6 +4104,14 @@ static int hardware_enable(void)
>  	if (cr4_read_shadow() & X86_CR4_VMXE)
>  		return -EBUSY;
>  
> +	/*
> +	 * This can happen if we hot-added a CPU but failed to allocate
> +	 * VP assist page for it.
> +	 */
> +	if (static_branch_unlikely(&enable_evmcs) &&
> +	    !hv_get_vp_assist_page(cpu))
> +		return -EFAULT;

-ENODEV?  Maybe add a printk, because this is really rare.

>  	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
>  	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
>  	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
> @@ -3829,7 +4345,12 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
>  	vmcs_conf->size = vmx_msr_high & 0x1fff;
>  	vmcs_conf->order = get_order(vmcs_conf->size);
>  	vmcs_conf->basic_cap = vmx_msr_high & ~0x1fff;
> -	vmcs_conf->revision_id = vmx_msr_low;
> +
> +	/* KVM supports Enlightened VMCS v1 only */
> +	if (static_branch_unlikely(&enable_evmcs))
> +		vmcs_conf->revision_id = KVM_EVMCS_VERSION;
> +	else
> +		vmcs_conf->revision_id = vmx_msr_low;
>  
>  	vmcs_conf->pin_based_exec_ctrl = _pin_based_exec_control;
>  	vmcs_conf->cpu_based_exec_ctrl = _cpu_based_exec_control;
> @@ -6990,6 +7511,17 @@ static __init int hardware_setup(void)
>  		goto out;
>  	}
>  
> +	if (static_branch_unlikely(&enable_evmcs)) {
> +		evmcs_sanitize_exec_ctrls(&vmcs_config.cpu_based_2nd_exec_ctrl,
> +					  &vmcs_config.pin_based_exec_ctrl);

Why not do it in setup_vmcs_config after the vmcs_conf->vmentry_ctrl
assignment (and pass &vmcs_config, which there is "vmcs_conf", directly
to the function)?  And if sanitizing clears the bits in vmentry_ctl and
vmexit_ctl, there's no need to clear cpu_has_load_perf_global_ctrl.

> +		/*
> +		 * Enlightened VMCSv1 doesn't support these:
> +		 *	GUEST_IA32_PERF_GLOBAL_CTRL	= 0x00002808,
> +		 *	HOST_IA32_PERF_GLOBAL_CTRL	= 0x00002c04,
> +		 */
> +		cpu_has_load_perf_global_ctrl = false;> +	}
> +
>  	if (boot_cpu_has(X86_FEATURE_NX))
>  		kvm_enable_efer_bits(EFER_NX);
>  
> @@ -8745,6 +9277,10 @@ static void dump_vmcs(void)
>  	if (cpu_has_secondary_exec_ctrls())
>  		secondary_exec_control = vmcs_read32(SECONDARY_VM_EXEC_CONTROL);
>  
> +	if (static_branch_unlikely(&enable_evmcs))
> +		evmcs_sanitize_exec_ctrls(&secondary_exec_control,
> +					  &pin_based_exec_ctrl);

This is wrong, we're reading the VMCS so the values must already be
sanitized (and if not, that's the bug and we want dump_vmcs to print the
"wrong" values).

>  	pr_err("*** Guest State ***\n");
>  	pr_err("CR0: actual=0x%016lx, shadow=0x%016lx, gh_mask=%016lx\n",
>  	       vmcs_readl(GUEST_CR0), vmcs_readl(CR0_READ_SHADOW),
> @@ -8784,7 +9320,8 @@ static void dump_vmcs(void)
>  	pr_err("DebugCtl = 0x%016llx  DebugExceptions = 0x%016lx\n",
>  	       vmcs_read64(GUEST_IA32_DEBUGCTL),
>  	       vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS));
> -	if (vmentry_ctl & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL)
> +	if (cpu_has_load_perf_global_ctrl &&
> +	    vmentry_ctl & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL)
>  		pr_err("PerfGlobCtl = 0x%016llx\n",
>  		       vmcs_read64(GUEST_IA32_PERF_GLOBAL_CTRL));
>  	if (vmentry_ctl & VM_ENTRY_LOAD_BNDCFGS)
> @@ -8820,7 +9357,8 @@ static void dump_vmcs(void)
>  		pr_err("EFER = 0x%016llx  PAT = 0x%016llx\n",
>  		       vmcs_read64(HOST_IA32_EFER),
>  		       vmcs_read64(HOST_IA32_PAT));
> -	if (vmexit_ctl & VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL)
> +	if (cpu_has_load_perf_global_ctrl &&
> +	    vmexit_ctl & VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL)
>  		pr_err("PerfGlobCtl = 0x%016llx\n",
>  		       vmcs_read64(HOST_IA32_PERF_GLOBAL_CTRL));
>  
> @@ -9397,7 +9935,7 @@ static void vmx_arm_hv_timer(struct kvm_vcpu *vcpu)
>  static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> -	unsigned long cr3, cr4;
> +	unsigned long cr3, cr4, evmcs_rsp;
>  
>  	/* Record the guest's net vcpu time for enforced NMI injections. */
>  	if (unlikely(!enable_vnmi &&
> @@ -9463,6 +10001,10 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
>  
>  	vmx->__launched = vmx->loaded_vmcs->launched;
> +
> +	evmcs_rsp = static_branch_unlikely(&enable_evmcs) ?
> +		(unsigned long)&current_evmcs->host_rsp : 0;

(If you use text_poke_early, you can do this assignment unconditionally,
since it's just a single lea instruction).

> @@ -9604,6 +10152,11 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  	/* Eliminate branch target predictions from guest mode */
>  	vmexit_fill_RSB();
>  
> +	/* All fields are clean at this point */
> +	if (static_branch_unlikely(&enable_evmcs))
> +		current_evmcs->hv_clean_fields |=
> +			HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
> +
>  	/* MSR_IA32_DEBUGCTLMSR is zeroed on vmexit. Restore it if needed */
>  	if (vmx->host_debugctlmsr)
>  		update_debugctlmsr(vmx->host_debugctlmsr);
> @@ -12419,7 +12972,36 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  
>  static int __init vmx_init(void)
>  {
> -	int r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
> +	int r;
> +
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	/*
> +	 * Enlightened VMCS usage should be recommended and the host needs
> +	 * to support eVMCS v1 or above. We can also disable eVMCS support
> +	 * with module parameter.
> +	 */
> +	if (enlightened_vmcs &&
> +	    ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED &&
> +	    (ms_hyperv.nested_features & HV_X64_ENLIGHTENED_VMCS_VERSION) >=
> +	    KVM_EVMCS_VERSION) {
> +		int cpu;
> +
> +		/* Check that we have assist pages on all online CPUs */
> +		for_each_online_cpu(cpu) {
> +			if (!hv_get_vp_assist_page(cpu)) {
> +				enlightened_vmcs = false;
> +				break;
> +			}
> +		}
> +		if (enlightened_vmcs) {
> +			pr_info("KVM: vmx: using Hyper-V Enlightened VMCS\n");
> +			static_branch_enable(&enable_evmcs);
> +		}
> +	}

A bit nicer to clear enlightened_vmcs in the "else" branch?

That's it.  Nice work!

Paolo


> +#endif
> +
> +	r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
>                       __alignof__(struct vcpu_vmx), THIS_MODULE);
>  	if (r)
>  		return r;
> @@ -12440,6 +13022,29 @@ static void __exit vmx_exit(void)
>  #endif
>  
>  	kvm_exit();
> +
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	if (static_branch_unlikely(&enable_evmcs)) {
> +		int cpu;
> +		struct hv_vp_assist_page *vp_ap;
> +		/*
> +		 * Reset everything to support using non-enlightened VMCS
> +		 * access later (e.g. when we reload the module with
> +		 * enlightened_vmcs=0)
> +		 */
> +		for_each_online_cpu(cpu) {
> +			vp_ap =	hv_get_vp_assist_page(cpu);
> +
> +			if (!vp_ap)
> +				continue;
> +
> +			vp_ap->current_nested_vmcs = 0;
> +			vp_ap->enlighten_vmentry = 0;
> +		}
> +
> +		static_branch_disable(&enable_evmcs);
> +	}
> +#endif
>  }
>  
>  module_init(vmx_init)
> 
