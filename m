Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeEJUIc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:08:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750876AbeEJUIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:08:31 -0400
Date: Thu, 10 May 2018 22:08:27 +0200
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
Subject: Re: [PATCH v3 5/6] KVM: x86: hyperv: simplistic
 HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE}_EX implementation
Message-ID: <20180510200826.GC3885@flask>
References: <20180416110806.4896-1-vkuznets@redhat.com>
 <20180416110806.4896-6-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416110806.4896-6-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-16 13:08+0200, Vitaly Kuznetsov:
> Implement HvFlushVirtualAddress{List,Space}Ex hypercalls in a simplistic
> way: do full TLB flush with KVM_REQ_TLB_FLUSH and kick vCPUs which are
> currently IN_GUEST_MODE.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> @@ -1301,6 +1301,108 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
>  		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
>  }
>  
> +static __always_inline int get_sparse_bank_no(u64 valid_bank_mask, int bank_no)
> +{
> +	int i = 0, j;
> +
> +	if (!(valid_bank_mask & BIT_ULL(bank_no)))
> +		return -1;
> +
> +	for (j = 0; j < bank_no; j++)
> +		if (valid_bank_mask & BIT_ULL(j))
> +			i++;
> +
> +	return i;
> +}
> +
> +static __always_inline int load_bank_guest(struct kvm *kvm, u64 ingpa,
> +				  int sparse_bank, u64 *bank_contents)
> +{
> +	int offset;
> +
> +	offset = offsetof(struct hv_tlb_flush_ex, hv_vp_set.bank_contents) +
> +		sizeof(u64) * sparse_bank;
> +
> +	if (unlikely(kvm_read_guest(kvm, ingpa + offset,
> +				    bank_contents, sizeof(u64))))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int kvm_hv_flush_tlb_ex(struct kvm_vcpu *current_vcpu, u64 ingpa,
> +			       u16 rep_cnt)
> +{
> +	struct kvm *kvm = current_vcpu->kvm;
> +	struct kvm_vcpu_hv *hv_current = &current_vcpu->arch.hyperv;
> +	struct hv_tlb_flush_ex flush;
> +	struct kvm_vcpu *vcpu;
> +	u64 bank_contents, valid_bank_mask;
> +	int i, cpu, me, current_sparse_bank = -1;
> +	u64 ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	if (unlikely(kvm_read_guest(kvm, ingpa, &flush, sizeof(flush))))
> +		return ret;
> +
> +	valid_bank_mask = flush.hv_vp_set.valid_bank_mask;
> +
> +	trace_kvm_hv_flush_tlb_ex(valid_bank_mask, flush.hv_vp_set.format,
> +				  flush.address_space, flush.flags);
> +
> +	cpumask_clear(&hv_current->tlb_lush);
> +
> +	me = get_cpu();
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
> +		int bank = hv->vp_index / 64, sparse_bank;
> +
> +		if (flush.hv_vp_set.format == HV_GENERIC_SET_SPARCE_4K) {
                                                                 ^
                                              typo in the define

> +			/* Check is the bank of this vCPU is in sparse set */
> +			sparse_bank = get_sparse_bank_no(valid_bank_mask, bank);
> +			if (sparse_bank < 0)
> +				continue;
> +
> +			/*
> +			 * Assume hv->vp_index is in ascending order and we can
> +			 * optimize by not reloading bank contents for every
> +			 * vCPU.
> +			 */

Since sparse_bank is packed, we could compute how many bank_contents do
we need to load and do it with one kvm_read_guest() into a local array;
it would be faster even if hv->vp_index were in ascending order and
wouldn't take that much memory (up to 512 B).

> +			if (sparse_bank != current_sparse_bank) {
> +				if (load_bank_guest(kvm, ingpa, sparse_bank,
> +						    &bank_contents))
> +					return ret;
> +				current_sparse_bank = sparse_bank;
> +			}
