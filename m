Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeEDKYG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:24:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:44141 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEDKYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:24:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400";
   d="scan'208";a="221592089"
Date: Fri, 4 May 2018 13:23:58 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, joro@8bytes.org, peterz@infradead.org,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v7 13/13] KVM: x86: Disable Intel Processor Trace when
 VMXON in L1 guest
Message-ID: <20180504102358.eojiggqrnhxng2ru@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-14-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525349323-9938-14-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 08:08:43PM +0800, Luwei Kang wrote:
> Currently, Intel Processor Trace do not support tracing in L1 guest
> VMX operation(IA32_VMX_MISC[bit 14] is 0). As mentioned in SDM,

I don't understand this patch. You mention VMX_MISC[14] here, but I
can't see anything related to it in the code.

Also, the description should probably say "...does not support tracing
in VMX *if* IA32_VMX_MISC[bit 14] is 0."

> on these type of processors, execution of the VMXON instruction will
> clears IA32_RTIT_CTL.TraceEn and any attempt to write IA32_RTIT_CTL
> causes a general-protection exception (#GP).
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index c125fb1..1e800d0 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -3952,7 +3952,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		break;
>  	case MSR_IA32_RTIT_CTL:
>  		if ((pt_mode != PT_MODE_HOST_GUEST) ||
> -			vmx_rtit_ctl_check(vcpu, data))
> +			vmx_rtit_ctl_check(vcpu, data) ||
> +			vmx->nested.vmxon)
>  			return 1;
>  		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
>  		pt_set_intercept_for_msr(vmx, !(data & RTIT_CTL_TRACEEN));
> @@ -8029,6 +8030,12 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
>  	if (ret)
>  		return ret;
>  
> +	if (pt_mode == PT_MODE_HOST_GUEST) {
> +		vmx->pt_desc.guest.ctl = 0;
> +		vmcs_write64(GUEST_IA32_RTIT_CTL, 0);
> +		pt_set_intercept_for_msr(vmx, 1);
> +	}
> +
>  	nested_vmx_succeed(vcpu);
>  	return kvm_skip_emulated_instruction(vcpu);
>  }
> -- 
> 1.8.3.1
> 
