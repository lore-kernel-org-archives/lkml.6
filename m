Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9AE4CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E4E20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E4E20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965677AbeFOKez (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:34:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965577AbeFOKey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7976A40122A1;
        Fri, 15 Jun 2018 10:34:53 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E2856353A;
        Fri, 15 Jun 2018 10:34:51 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     <mmorsy@redhat.com>, <rkagan@virtuozzo.com>, <jmattson@google.com>,
        <Michael.H.Kelley@microsoft.com>, <kys@microsoft.com>,
        <rkrcmar@redhat.com>, <cavery@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <sthemmin@microsoft.com>,
        <haiyangz@microsoft.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/5] KVM: nVMX: add KVM_CAP_HYPERV_ENLIGHTENED_VMCS capability
References: <b569a42b-605e-45e0-b292-5aeddfee80ad@default>
Date:   Fri, 15 Jun 2018 12:34:50 +0200
In-Reply-To: <b569a42b-605e-45e0-b292-5aeddfee80ad@default> (Liran Alon's
        message of "Thu, 14 Jun 2018 15:58:40 -0700 (PDT)")
Message-ID: <87d0wsnxrp.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 15 Jun 2018 10:34:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 15 Jun 2018 10:34:53 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

> ----- vkuznets@redhat.com wrote:
>
>> Enlightened VMCS is opt-in. The current version does not contain all
>> fields supported by nested VMX so we must not advertise the
>> corresponding VMX features if enlightened VMCS is enabled.
>> 
>> Userspace is given the enlightened VMCS version supported by KVM as
>> part of enabling KVM_CAP_HYPERV_ENLIGHTENED_VMCS. The version is to
>> be advertised to the nested hypervisor, currently done via a cpuid
>> leaf for Hyper-V.
>> 
>> Suggested-by: Ladi Prosek <lprosek@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h |   3 +
>>  arch/x86/kvm/svm.c              |   9 +++
>>  arch/x86/kvm/vmx.c              | 138
>> ++++++++++++++++++++++------------------
>>  arch/x86/kvm/x86.c              |  15 +++++
>>  include/uapi/linux/kvm.h        |   1 +
>>  5 files changed, 105 insertions(+), 61 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/kvm_host.h
>> b/arch/x86/include/asm/kvm_host.h
>> index 0ebe659f2802..d7e8f7155d79 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -1095,6 +1095,9 @@ struct kvm_x86_ops {
>>  	int (*mem_enc_unreg_region)(struct kvm *kvm, struct kvm_enc_region
>> *argp);
>>  
>>  	int (*get_msr_feature)(struct kvm_msr_entry *entry);
>> +
>> +	int (*nested_enable_evmcs)(struct kvm_vcpu *vcpu,
>> +				   uint16_t *vmcs_version);
>>  };
>>  
>>  struct kvm_arch_async_pf {
>> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>> index d9305f1723f5..6dc42c870565 100644
>> --- a/arch/x86/kvm/svm.c
>> +++ b/arch/x86/kvm/svm.c
>> @@ -7009,6 +7009,13 @@ static int svm_unregister_enc_region(struct kvm
>> *kvm,
>>  	return ret;
>>  }
>>  
>> +static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
>> +				   uint16_t *vmcs_version)
>> +{
>> +	/* Intel-only feature */
>> +	return -ENODEV;
>> +}
>> +
>>  static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
>>  	.cpu_has_kvm_support = has_svm,
>>  	.disabled_by_bios = is_disabled,
>> @@ -7135,6 +7142,8 @@ static struct kvm_x86_ops svm_x86_ops
>> __ro_after_init = {
>>  	.mem_enc_op = svm_mem_enc_op,
>>  	.mem_enc_reg_region = svm_register_enc_region,
>>  	.mem_enc_unreg_region = svm_unregister_enc_region,
>> +
>> +	.nested_enable_evmcs = nested_enable_evmcs,
>>  };
>>  
>>  static int __init svm_init(void)
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 48989f78be60..51749207cef1 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -648,6 +648,13 @@ struct nested_vmx {
>>  
>>  	bool change_vmcs01_virtual_apic_mode;
>>  
>> +	/*
>> +	 * Enlightened VMCS has been enabled. It does not mean that L1 has
>> to
>> +	 * use it. However, VMX features available to L1 will be limited
>> based
>> +	 * on what the enlightened VMCS supports.
>> +	 */
>> +	bool enlightened_vmcs_enabled;
>> +
>>  	/* L2 must run next, and mustn't decide to exit to L1. */
>>  	bool nested_run_pending;
>>  
>> @@ -1186,6 +1193,49 @@ DEFINE_STATIC_KEY_FALSE(enable_evmcs);
>>  
>>  #define KVM_EVMCS_VERSION 1
>>  
>> +/*
>> + * Enlightened VMCSv1 doesn't support these:
>> + *
>> + *	POSTED_INTR_NV                  = 0x00000002,
>> + *	GUEST_INTR_STATUS               = 0x00000810,
>> + *	APIC_ACCESS_ADDR		= 0x00002014,
>> + *	POSTED_INTR_DESC_ADDR           = 0x00002016,
>> + *	EOI_EXIT_BITMAP0                = 0x0000201c,
>> + *	EOI_EXIT_BITMAP1                = 0x0000201e,
>> + *	EOI_EXIT_BITMAP2                = 0x00002020,
>> + *	EOI_EXIT_BITMAP3                = 0x00002022,
>> + *	GUEST_PML_INDEX			= 0x00000812,
>> + *	PML_ADDRESS			= 0x0000200e,
>> + *	VM_FUNCTION_CONTROL             = 0x00002018,
>> + *	EPTP_LIST_ADDRESS               = 0x00002024,
>> + *	VMREAD_BITMAP                   = 0x00002026,
>> + *	VMWRITE_BITMAP                  = 0x00002028,
>> + *
>> + *	TSC_MULTIPLIER                  = 0x00002032,
>> + *	PLE_GAP                         = 0x00004020,
>> + *	PLE_WINDOW                      = 0x00004022,
>> + *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
>> + *      GUEST_IA32_PERF_GLOBAL_CTRL     = 0x00002808,
>> + *      HOST_IA32_PERF_GLOBAL_CTRL      = 0x00002c04,
>> + *
>> + * Currently unsupported in KVM:
>> + *	GUEST_IA32_RTIT_CTL		= 0x00002814,
>> + */
>> +#define EVMCS1_UNSUPPORTED_PINCTRL (PIN_BASED_POSTED_INTR | \
>> +				    PIN_BASED_VMX_PREEMPTION_TIMER)
>> +#define EVMCS1_UNSUPPORTED_2NDEXEC					\
>> +	(SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |				\
>> +	 SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |			\
>> +	 SECONDARY_EXEC_APIC_REGISTER_VIRT |				\
>> +	 SECONDARY_EXEC_ENABLE_PML |					\
>> +	 SECONDARY_EXEC_ENABLE_VMFUNC |					\
>> +	 SECONDARY_EXEC_SHADOW_VMCS |					\
>> +	 SECONDARY_EXEC_TSC_SCALING |					\
>> +	 SECONDARY_EXEC_PAUSE_LOOP_EXITING)
>> +#define EVMCS1_UNSUPPORTED_VMEXIT_CTRL
>> (VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL)
>> +#define EVMCS1_UNSUPPORTED_VMENTRY_CTRL
>> (VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL)
>> +#define EVMCS1_UNSUPPORTED_VMFUNC (VMX_VMFUNC_EPTP_SWITCHING)
>> +
>>  #if IS_ENABLED(CONFIG_HYPERV)
>>  static bool __read_mostly enlightened_vmcs = true;
>>  module_param(enlightened_vmcs, bool, 0444);
>> @@ -1278,69 +1328,12 @@ static void evmcs_load(u64 phys_addr)
>>  
>>  static void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf)
>>  {
>> -	/*
>> -	 * Enlightened VMCSv1 doesn't support these:
>> -	 *
>> -	 *	POSTED_INTR_NV                  = 0x00000002,
>> -	 *	GUEST_INTR_STATUS               = 0x00000810,
>> -	 *	APIC_ACCESS_ADDR		= 0x00002014,
>> -	 *	POSTED_INTR_DESC_ADDR           = 0x00002016,
>> -	 *	EOI_EXIT_BITMAP0                = 0x0000201c,
>> -	 *	EOI_EXIT_BITMAP1                = 0x0000201e,
>> -	 *	EOI_EXIT_BITMAP2                = 0x00002020,
>> -	 *	EOI_EXIT_BITMAP3                = 0x00002022,
>> -	 */
>> -	vmcs_conf->pin_based_exec_ctrl &= ~PIN_BASED_POSTED_INTR;
>> -	vmcs_conf->cpu_based_2nd_exec_ctrl &=
>> -		~SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
>> -	vmcs_conf->cpu_based_2nd_exec_ctrl &=
>> -		~SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
>> -	vmcs_conf->cpu_based_2nd_exec_ctrl &=
>> -		~SECONDARY_EXEC_APIC_REGISTER_VIRT;
>> -
>> -	/*
>> -	 *	GUEST_PML_INDEX			= 0x00000812,
>> -	 *	PML_ADDRESS			= 0x0000200e,
>> -	 */
>> -	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_ENABLE_PML;
>> +	vmcs_conf->pin_based_exec_ctrl &= ~EVMCS1_UNSUPPORTED_PINCTRL;
>> +	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~EVMCS1_UNSUPPORTED_2NDEXEC;
>>  
>> -	/*	VM_FUNCTION_CONTROL             = 0x00002018, */
>> -	vmcs_conf->cpu_based_2nd_exec_ctrl &=
>> ~SECONDARY_EXEC_ENABLE_VMFUNC;
>> +	vmcs_conf->vmexit_ctrl &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
>> +	vmcs_conf->vmentry_ctrl &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
>>  
>> -	/*
>> -	 *	EPTP_LIST_ADDRESS               = 0x00002024,
>> -	 *	VMREAD_BITMAP                   = 0x00002026,
>> -	 *	VMWRITE_BITMAP                  = 0x00002028,
>> -	 */
>> -	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_SHADOW_VMCS;
>> -
>> -	/*
>> -	 *	TSC_MULTIPLIER                  = 0x00002032,
>> -	 */
>> -	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_TSC_SCALING;
>> -
>> -	/*
>> -	 *	PLE_GAP                         = 0x00004020,
>> -	 *	PLE_WINDOW                      = 0x00004022,
>> -	 */
>> -	vmcs_conf->cpu_based_2nd_exec_ctrl &=
>> ~SECONDARY_EXEC_PAUSE_LOOP_EXITING;
>> -
>> -	/*
>> -	 *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
>> -	 */
>> -	vmcs_conf->pin_based_exec_ctrl &= ~PIN_BASED_VMX_PREEMPTION_TIMER;
>> -
>> -	/*
>> -	 *      GUEST_IA32_PERF_GLOBAL_CTRL     = 0x00002808,
>> -	 *      HOST_IA32_PERF_GLOBAL_CTRL      = 0x00002c04,
>> -	 */
>> -	vmcs_conf->vmexit_ctrl &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
>> -	vmcs_conf->vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
>> -
>> -	/*
>> -	 * Currently unsupported in KVM:
>> -	 *	GUEST_IA32_RTIT_CTL		= 0x00002814,
>> -	 */
>
> The creation of the EVMCS1_UNSUPPORTED_* macros and the refactor to evmcs_sanitize_exec_ctrls()
> should be done in a separate patch in this series before this one.
>

Sure, will do!

>>  }
>>  #else /* !IS_ENABLED(CONFIG_HYPERV) */
>>  static inline void evmcs_write64(unsigned long field, u64 value) {}
>> @@ -1354,6 +1347,27 @@ static inline void
>> evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf) {}
>>  static inline void evmcs_touch_msr_bitmap(void) {}
>>  #endif /* IS_ENABLED(CONFIG_HYPERV) */
>>  
>> +static int nested_enable_evmcs(struct kvm_vcpu *vcpu,
>> +			       uint16_t *vmcs_version)
>> +{
>> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
>> +
>> +	/* We don't support disabling the feature for simplicity. */
>> +	if (vmx->nested.enlightened_vmcs_enabled)
>> +		return 0;
>> +
>> +	vmx->nested.enlightened_vmcs_enabled = true;
>> +	*vmcs_version = (KVM_EVMCS_VERSION << 8) | 1;
>
> Please add a comment here explaining the "<< 8) | 1" part.
>

Got it.

>> +
>> +	vmx->nested.msrs.pinbased_ctls_high &= ~EVMCS1_UNSUPPORTED_PINCTRL;
>> +	vmx->nested.msrs.entry_ctls_high &=
>> ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
>> +	vmx->nested.msrs.exit_ctls_high &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
>> +	vmx->nested.msrs.secondary_ctls_high &=
>> ~EVMCS1_UNSUPPORTED_2NDEXEC;
>> +	vmx->nested.msrs.vmfunc_controls &= ~EVMCS1_UNSUPPORTED_VMFUNC;
>> +
>> +	return 0;
>> +}
>> +
>>  static inline bool is_exception_n(u32 intr_info, u8 vector)
>>  {
>>  	return (intr_info & (INTR_INFO_INTR_TYPE_MASK |
>> INTR_INFO_VECTOR_MASK |
>> @@ -13039,6 +13053,8 @@ static struct kvm_x86_ops vmx_x86_ops
>> __ro_after_init = {
>>  	.pre_enter_smm = vmx_pre_enter_smm,
>>  	.pre_leave_smm = vmx_pre_leave_smm,
>>  	.enable_smi_window = enable_smi_window,
>> +
>> +	.nested_enable_evmcs = nested_enable_evmcs,
>>  };
>>  
>>  static int __init vmx_init(void)
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index a57766b940a5..51488019dec2 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -2873,6 +2873,7 @@ int kvm_vm_ioctl_check_extension(struct kvm
>> *kvm, long ext)
>>  	case KVM_CAP_HYPERV_VP_INDEX:
>>  	case KVM_CAP_HYPERV_EVENTFD:
>>  	case KVM_CAP_HYPERV_TLBFLUSH:
>> +	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
>>  	case KVM_CAP_PCI_SEGMENT:
>>  	case KVM_CAP_DEBUGREGS:
>>  	case KVM_CAP_X86_ROBUST_SINGLESTEP:
>> @@ -3650,6 +3651,10 @@ static int kvm_set_guest_paused(struct kvm_vcpu
>> *vcpu)
>>  static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>>  				     struct kvm_enable_cap *cap)
>>  {
>> +	int r;
>> +	uint16_t vmcs_version;
>> +	void __user *user_ptr;
>> +
>>  	if (cap->flags)
>>  		return -EINVAL;
>>  
>> @@ -3662,6 +3667,16 @@ static int kvm_vcpu_ioctl_enable_cap(struct
>> kvm_vcpu *vcpu,
>>  			return -EINVAL;
>>  		return kvm_hv_activate_synic(vcpu, cap->cap ==
>>  					     KVM_CAP_HYPERV_SYNIC2);
>> +	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
>> +		r = kvm_x86_ops->nested_enable_evmcs(vcpu, &vmcs_version);
>> +		if (!r) {
>> +			user_ptr = (void __user *)(uintptr_t)cap->args[0];
>> +			if (copy_to_user(user_ptr, &vmcs_version,
>> +					 sizeof(vmcs_version)))
>> +				r = -EFAULT;
>> +		}
>> +		return r;
>> +
>>  	default:
>>  		return -EINVAL;
>>  	}
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index b6270a3b38e9..5c4b79c1af19 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_GET_MSR_FEATURES 153
>>  #define KVM_CAP_HYPERV_EVENTFD 154
>>  #define KVM_CAP_HYPERV_TLBFLUSH 155
>> +#define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 156
>>  
>>  #ifdef KVM_CAP_IRQ_ROUTING
>>  
>> -- 
>> 2.14.4
>
> Besides above comments,
> Reviewed-By: Liran Alon <liran.alon@oracle.com>

Thank you for reviewing the series!

-- 
  Vitaly
