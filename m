Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeEDKLk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:11:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:4386 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbeEDKLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:11:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400";
   d="scan'208";a="51476130"
Date: Fri, 4 May 2018 13:11:32 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, joro@8bytes.org, peterz@infradead.org,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v7 11/13] KVM: x86: Implement Intel Processor Trace MSRs
 read/write
Message-ID: <20180504101132.ybh3b7ggpl2ny77v@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-12-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525349323-9938-12-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 08:08:41PM +0800, Luwei Kang wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Implement Intel Processor Trace MSRs read/write.

There needs to be a commit message here.

> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
>  arch/x86/include/asm/intel_pt.h |   8 ++
>  arch/x86/kvm/vmx.c              | 163 ++++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c              |  33 +++++++-
>  3 files changed, 203 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
> index 43ad260..dc0f3f0 100644
> --- a/arch/x86/include/asm/intel_pt.h
> +++ b/arch/x86/include/asm/intel_pt.h
> @@ -5,6 +5,14 @@
>  #define PT_CPUID_LEAVES		2
>  #define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
>  
> +#define MSR_IA32_RTIT_STATUS_MASK (~(RTIT_STATUS_FILTEREN | \
> +		RTIT_STATUS_CONTEXTEN | RTIT_STATUS_TRIGGEREN | \
> +		RTIT_STATUS_ERROR | RTIT_STATUS_STOPPED | \
> +		RTIT_STATUS_BYTECNT))
> +
> +#define MSR_IA32_RTIT_OUTPUT_BASE_MASK \
> +	(~((1UL << cpuid_query_maxphyaddr(vcpu)) - 1) | 0x7f)

How does this macro make sense in the intel_pt.h? It also relies on vcpu
being in the scope.

>  enum pt_mode {
>  	PT_MODE_SYSTEM = 0,
>  	PT_MODE_HOST,
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 3ed02a8..2a29ab9 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -2769,6 +2769,77 @@ static void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
>  		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, interruptibility);
>  }
>  
> +static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
> +{
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	unsigned long value;
> +
> +	/*
> +	 * Any MSR write that attempts to change bits marked reserved will
> +	 * case a #GP fault.
> +	 */
> +	if (data & vmx->pt_desc.ctl_bitmask)
> +		return 1;
> +
> +	/*
> +	 * Any attempt to modify IA32_RTIT_CTL while TraceEn is set will
> +	 * result in a #GP unless the same write also clears TraceEn.
> +	 */
> +	if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
> +		((vmx->pt_desc.guest.ctl ^ data) & ~RTIT_CTL_TRACEEN))
> +		return 1;
> +
> +	/*
> +	 * WRMSR to IA32_RTIT_CTL that sets TraceEn but clears this bit
> +	 * and FabricEn would cause #GP, if
> +	 * CPUID.(EAX=14H, ECX=0):ECX.SNGLRGNOUT[bit 2] = 0
> +	 */
> +	if ((data & RTIT_CTL_TRACEEN) && !(data & RTIT_CTL_TOPA) &&
> +		!(data & RTIT_CTL_FABRIC_EN) &&
> +		!__pt_cap_get(vmx->pt_desc.caps, PT_CAP_single_range_output))

You seem to be doing a lot of __pt_cap_get()s on each wrmsr. Did you consider
decoding the capabilities once and storing the decoded values instead, so
that in functions like these you can access them by

   if (vmx->pt_desc.caps[PT_CAP_single_range_output]) ...

?

Regards,
--
Alex
