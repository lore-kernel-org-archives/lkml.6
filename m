Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeECLcf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:32:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:62460 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbeECLca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:32:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="52874479"
Date: Thu, 3 May 2018 14:32:23 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, joro@8bytes.org, peterz@infradead.org,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v7 06/13] KVM: x86: Add Intel Processor Trace
 virtualization mode
Message-ID: <20180503113223.x2ykby6wglppgdwf@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-7-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525349323-9938-7-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 08:08:36PM +0800, Luwei Kang wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Intel PT virtualization can be work in one of 3 possible modes:
> a. system-wide: trace both host/guest and output to host buffer;
> b. host-only: only trace host and output to host buffer;
> c. host-guest: trace host/guest simultaneous and output to their
>    respective buffer.

You also need to explain what this patch is doing, how and why. I think
I figured it out from reading the rest of the patch, but it should really
be mentioned in the description.

> @@ -5,6 +5,12 @@
>  #define PT_CPUID_LEAVES		2
>  #define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
>  
> +enum pt_mode {
> +	PT_MODE_SYSTEM = 0,
> +	PT_MODE_HOST,
> +	PT_MODE_HOST_GUEST,
> +};
> +
>  enum pt_capabilities {
>  	PT_CAP_max_subleaf = 0,
>  	PT_CAP_cr3_filtering,
> @@ -187,6 +188,10 @@
>  static unsigned int ple_window_max        = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
>  module_param(ple_window_max, uint, 0444);
>  
> +/* Default is SYSTEM mode. */
> +static int __read_mostly pt_mode = PT_MODE_SYSTEM;
> +module_param(pt_mode, int, S_IRUGO);

So, it's an explicit module parameter? One apparent problem with this
is that one would need to reload kvm module(s) to be able to use PT,
which is not ideal.

> +
>  extern const ulong vmx_return;
>  
>  struct kvm_vmx {
> @@ -1488,6 +1493,19 @@ static inline bool cpu_has_vmx_vmfunc(void)
>  		SECONDARY_EXEC_ENABLE_VMFUNC;
>  }
>  
> +static inline bool cpu_has_vmx_intel_pt(void)
> +{
> +	u64 vmx_msr;
> +
> +	rdmsrl(MSR_IA32_VMX_MISC, vmx_msr);
> +	return vmx_msr & MSR_IA32_VMX_MISC_INTEL_PT;

This is an implicit cast. return !!(...) would clarify your intention.

Also, does it make sense to write an accessor to pt_pmu.vmx instead?

> +}
> +
> +static inline bool cpu_has_vmx_pt_use_gpa(void)
> +{
> +	return vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_PT_USE_GPA;
> +}

I can deduce the meaning of the previous one, but not this one, and there's
no explanation.

> @@ -5780,6 +5810,28 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
>  	return exec_control;
>  }
>  
> +static u32 vmx_vmexit_control(struct vcpu_vmx *vmx)
> +{
> +	u32 vmexit_control = vmcs_config.vmexit_ctrl;
> +
> +	if (pt_mode == PT_MODE_SYSTEM)
> +		vmexit_control &= ~(VM_EXIT_CLEAR_IA32_RTIT_CTL |
> +				    VM_EXIT_PT_CONCEAL_PIP);

Ok, so what we really want to know is: is there an encompassing PT
event on this cpu when we go into VMLAUNCH/VMRESTORE, right?
We can find this out from the pt_ctx and avoid the pt_mode entirely.
IOW, instead of having the 3 modes that you describe at the top, you
can use something like the following:

1. Do we have an event in pt_ctx?
 * No -> Set up the context for VMX.
 * Yes -> 2. Is attr.exclude_guest set?
             * No -> Guest trace goes to the host's buffer, do nothing.
	     * Yes -> Set up/switch the context for VMX.

Regards,
--
Alex
