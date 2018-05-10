Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeEJTkW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:40:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750762AbeEJTkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:40:21 -0400
Date: Thu, 10 May 2018 21:40:17 +0200
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
Subject: Re: [PATCH v3 4/6] KVM: x86: hyperv: simplistic
 HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} implementation
Message-ID: <20180510194016.GB3885@flask>
References: <20180416110806.4896-1-vkuznets@redhat.com>
 <20180416110806.4896-5-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416110806.4896-5-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-16 13:08+0200, Vitaly Kuznetsov:
> Implement HvFlushVirtualAddress{List,Space} hypercalls in a simplistic way:
> do full TLB flush with KVM_REQ_TLB_FLUSH and kick vCPUs which are currently
> IN_GUEST_MODE.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> @@ -1242,6 +1242,65 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
>  		return kvm_hv_get_msr(vcpu, msr, pdata);
>  }
>  
> +static void ack_flush(void *_completed)
> +{
> +}
> +
> +static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
> +			    u16 rep_cnt)
> +{
> +	struct kvm *kvm = current_vcpu->kvm;
> +	struct kvm_vcpu_hv *hv_current = &current_vcpu->arch.hyperv;
> +	struct hv_tlb_flush flush;
> +	struct kvm_vcpu *vcpu;
> +	int i, cpu, me;
> +
> +	if (unlikely(kvm_read_guest(kvm, ingpa, &flush, sizeof(flush))))
> +		return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	trace_kvm_hv_flush_tlb(flush.processor_mask, flush.address_space,
> +			       flush.flags);
> +
> +	cpumask_clear(&hv_current->tlb_lush);
> +
> +	me = get_cpu();
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
> +
> +		if (!(flush.flags & HV_FLUSH_ALL_PROCESSORS) &&

Please add a check to prevent undefined behavior in C:

                    (hv->vp_index >= 64 ||

> +		    !(flush.processor_mask & BIT_ULL(hv->vp_index)))
> +			continue;

It would also fail in the wild as shl only considers the bottom 5 bits.

> +		/*
> +		 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we
> +		 * can't analyze it here, flush TLB regardless of the specified
> +		 * address space.
> +		 */
> +		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
> +
> +		/*
> +		 * It is possible that vCPU will migrate and we will kick wrong
> +		 * CPU but vCPU's TLB will anyway be flushed upon migration as
> +		 * we already made KVM_REQ_TLB_FLUSH request.
> +		 */
> +		cpu = vcpu->cpu;
> +		if (cpu != -1 && cpu != me && cpu_online(cpu) &&
> +		    kvm_arch_vcpu_should_kick(vcpu))
> +			cpumask_set_cpu(cpu, &hv_current->tlb_lush);
> +	}
> +
> +	if (!cpumask_empty(&hv_current->tlb_lush))
> +		smp_call_function_many(&hv_current->tlb_lush, ack_flush,
> +				       NULL, true);

Hm, quite a lot of code duplication with EX hypercall and also
kvm_make_all_cpus_request ... I'm thinking about making something like

  kvm_make_some_cpus_request(struct kvm *kvm, unsigned int req,
                             bool (*predicate)(struct kvm_vcpu *vcpu))

or to implement a vp_index -> vcpu mapping and using

  kvm_vcpu_request_mask(struct kvm *kvm, unsigned int req, long *vcpu_bitmap)

The latter would probably simplify logic of the EX hypercall.

What do you think?
