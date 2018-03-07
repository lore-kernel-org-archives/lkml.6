Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeCGR46 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:56:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754544AbeCGR4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:56:55 -0500
Date: Wed, 7 Mar 2018 18:56:11 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
Message-ID: <20180307175611.GF12290@flask>
References: <20180226171121.18974-1-vkuznets@redhat.com>
 <20180226171121.18974-6-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226171121.18974-6-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-26 18:11+0100, Vitaly Kuznetsov:
> Enlightened VMCS is just a structure in memory, the main benefit
> besides avoiding somewhat slower VMREAD/VMWRITE is using clean field
> mask: we tell the underlying hypervisor which fields were modified
> since VMEXIT so there's no need to inspect them all.
> 
> Tight CPUID loop test shows significant speedup:
> Before: 20766 cycles
> After: 8912 cycles
> 
> Static key is being used to avoid performance penalty for non-Hyper-V
> deployments. Tests show we add around 3 (three) CPU cycles on each
> VMEXIT (1077.5 cycles before, 1080.7 cycles after for the same CPUID
> loop on bare metal). We can probably avoid one test/jmp in vmx_vcpu_run()
> but I don't see a clean way to use static key in assembly.

Patching the correct instruction should be simpler than replicating
static_branch (because we have to support assemblers without ASM_GOTO),
but I'd care about that later, if ever.

> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> @@ -999,6 +1000,442 @@ static const u32 vmx_msr_index[] = {
> +/*
> + *  Enlightened VMCSv1 doesn't support these:

I take it that the code assumes that the hypervisor will never enable
these features if we have enlightened VMCS.  I think it would be best to
disable those features when turning on evmcs.

> + *	POSTED_INTR_NV                  = 0x00000002,
> + *	GUEST_INTR_STATUS               = 0x00000810,
> + *	APIC_ACCESS_ADDR		= 0x00002014,
> + *	POSTED_INTR_DESC_ADDR           = 0x00002016,
> + *	EOI_EXIT_BITMAP0                = 0x0000201c,
> + *	EOI_EXIT_BITMAP1                = 0x0000201e,
> + *	EOI_EXIT_BITMAP2                = 0x00002020,
> + *	EOI_EXIT_BITMAP3                = 0x00002022,

enable_apicv, flexpriority_enabled

> + *	GUEST_PML_INDEX			= 0x00000812,
> + *	PML_ADDRESS			= 0x0000200e,

enable_pml

> + *	VM_FUNCTION_CONTROL             = 0x00002018,
> + *	EPTP_LIST_ADDRESS               = 0x00002024,

(only vm controls)

> + *	VMREAD_BITMAP                   = 0x00002026,
> + *	VMWRITE_BITMAP                  = 0x00002028,

enable_shadow_vmcs

> + *	TSC_MULTIPLIER                  = 0x00002032,

(only vm controls)

> + *	GUEST_IA32_PERF_GLOBAL_CTRL	= 0x00002808,
> + *	GUEST_IA32_RTIT_CTL		= 0x00002814,
> + *	HOST_IA32_PERF_GLOBAL_CTRL	= 0x00002c04,

(only vm controls)

> + *	PLE_GAP                         = 0x00004020,
> + *	PLE_WINDOW                      = 0x00004022,

ple_gap

> + *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,

enable_preemption_timer

> + */
> +};
> +
> +static inline u16 get_evmcs_offset(unsigned long field)
> +{
> +	unsigned int index = ROL16(field, 6);
> +
> +	if (index >= ARRAY_SIZE(vmcs_field_to_evmcs_1))
> +		return 0;

Please add a warning when trying to use an EVMCS that doesn't exist,
just like the VMREAD/WRITE does -- it's an internal KVM error.

> +
> +	return (u16)vmcs_field_to_evmcs_1[index];
> +}
> +
> @@ -3828,7 +4302,12 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
>  	vmcs_conf->size = vmx_msr_high & 0x1fff;
>  	vmcs_conf->order = get_order(vmcs_conf->size);
>  	vmcs_conf->basic_cap = vmx_msr_high & ~0x1fff;
> -	vmcs_conf->revision_id = vmx_msr_low;
> +
> +	/* KVM supports Enlightened VMCS v1 only */
> +	if (static_branch_unlikely(&enable_evmcs))
> +		vmcs_conf->revision_id = 1;

I think we have to put the bottom bits from ms_hyperv.nested_features
here. 16.5.1 Enlightened VMCS Versioning:

  Each enlightened VMCS structure contains a version field, which is
  reported by the L0 hypervisor (see 2.4.11)



> +	else
> +		vmcs_conf->revision_id = vmx_msr_low;
>  
>  	vmcs_conf->pin_based_exec_ctrl = _pin_based_exec_control;
>  	vmcs_conf->cpu_based_exec_ctrl = _cpu_based_exec_control;
> @@ -12414,7 +12908,35 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
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
> +	    (ms_hyperv.nested_features & 0xff) >= 1) {

Please add macros like HV_X64_ENLIGHTENED_VMCS_VERSION and
KVM_EVMCS_VERSION for those numbers.
I think we should not proceed with version other than 1 for now -- there
is no mention of backward compatibility in the spec.

Thanks.
