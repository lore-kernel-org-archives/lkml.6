Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeDCTPP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:15:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeDCTPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:15:13 -0400
Date: Tue, 3 Apr 2018 21:15:08 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] KVM: x86: hyperv: simplistic
 HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} implementation
Message-ID: <20180403191508.GA7386@flask>
References: <20180402161059.8488-1-vkuznets@redhat.com>
 <20180402161059.8488-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402161059.8488-4-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-02 18:10+0200, Vitaly Kuznetsov:
> Implement HvFlushVirtualAddress{List,Space} hypercalls in a simplistic way:
> do full TLB flush with KVM_REQ_TLB_FLUSH and rely on kvm_vcpu_kick()
> kicking only vCPUs which are currently IN_GUEST_MODE.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-------
>  arch/x86/kvm/trace.h  | 24 +++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 3cb3bb68db7e..aa866994366d 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1242,6 +1242,49 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
>  		return kvm_hv_get_msr(vcpu, msr, pdata);
>  }
>  
> +static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
> +			    u16 rep_cnt)
> +{
> +	struct kvm *kvm = current_vcpu->kvm;
> +	struct hv_tlb_flush flush;
> +	struct kvm_vcpu *vcpu;
> +	int i;
> +
> +	if (unlikely(kvm_read_guest(kvm, ingpa, &flush, sizeof(flush))))
> +		return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	trace_kvm_hv_flush_tlb(flush.processor_mask, flush.address_space,
> +			       flush.flags);
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
> +
> +		if (!(flush.flags & HV_FLUSH_ALL_PROCESSORS) &&
> +		    !(flush.processor_mask & BIT_ULL(hv->vp_index)))
> +			continue;
> +
> +		/*
> +		 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we
> +		 * can't analyze it here, flush TLB regardless of the specified
> +		 * address space.
> +		 */
> +		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
> +
> +		/*
> +		 * It is very unlikely but possible that we're doing an extra
> +		 * kick here (e.g. if the vCPU has just entered the guest and
> +		 * has its TLB flushed).
> +		 */
> +		if (vcpu != current_vcpu)
> +			kvm_vcpu_kick(vcpu);

The spec says that

 "This call guarantees that by the time control returns back to the
  caller, the observable effects of all flushes on the specified virtual
  processors have occurred."

Other KVM code doesn't assume that kvm_vcpu_kick() and a delay provides
that guarantee;  kvm_make_all_cpus_request waits for the target CPU to
exit before saying that TLB has been flushed.

I am leaning towards the safer variant here as well.  (Anyway, it's a
good time to figure out if we really need it.)

> +	}
> +
> +	/* We always do full TLB flush, set rep_done = rep_cnt. */
> +	return (u64)HV_STATUS_SUCCESS |
> +		((u64)rep_cnt << HV_HYPERCALL_REP_START_OFFSET) |

Why at bits 48-59?  I don't see this field in the spec.

> +		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
> +}
> +
>  bool kvm_hv_hypercall_enabled(struct kvm *kvm)
>  {
>  	return READ_ONCE(kvm->arch.hyperv.hv_hypercall) & HV_X64_MSR_HYPERCALL_ENABLE;
> @@ -1345,12 +1388,6 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  
>  	trace_kvm_hv_hypercall(code, fast, rep_cnt, rep_idx, ingpa, outgpa);
>  
> -	/* Hypercall continuation is not supported yet */
> -	if (rep_cnt || rep_idx) {
> -		ret = HV_STATUS_INVALID_HYPERCALL_CODE;

Hm, we should have returned HV_STATUS_INVALID_HYPERCALL_INPUT in any
case.  I think it would be good to still fail in case of non-rep
hypercalls,

thanks.
