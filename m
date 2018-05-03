Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeECLjS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:39:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:53562 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeECLjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:39:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="52875427"
Date: Thu, 3 May 2018 14:39:09 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, joro@8bytes.org, peterz@infradead.org,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v7 08/13] KVM: x86: Add Intel processor trace context for
 each vcpu
Message-ID: <20180503113909.52osvumzlueetsn4@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-9-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525349323-9938-9-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 08:08:38PM +0800, Luwei Kang wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Add a data structure to save Intel Processor Trace context.
> It mainly include the value of Intel PT host/guest MSRs
> and guest CPUID information.

I'd say that code and data should be in the same patch.

> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 27cf417..9a5c26d 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -597,6 +597,23 @@ static inline int pi_test_sn(struct pi_desc *pi_desc)
>  			(unsigned long *)&pi_desc->control);
>  }
>  
> +struct pt_ctx {
> +	u64 ctl;
> +	u64 status;
> +	u64 output_base;
> +	u64 output_mask;
> +	u64 cr3_match;
> +	u64 addrs[MSR_IA32_RTIT_ADDR_COUNT];
> +};
> +
> +struct pt_desc {
> +	u64 ctl_bitmask;
> +	u32 range_cnt;
> +	u32 caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
> +	struct pt_ctx host;
> +	struct pt_ctx guest;
> +};
> +
>  struct vcpu_vmx {
>  	struct kvm_vcpu       vcpu;
>  	unsigned long         host_rsp;
> @@ -693,6 +710,8 @@ struct vcpu_vmx {
>  	 */
>  	u64 msr_ia32_feature_control;
>  	u64 msr_ia32_feature_control_valid_bits;
> +
> +	struct pt_desc pt_desc;
>  };
>  
>  enum segment_cache_field {
> -- 
> 1.8.3.1
> 
