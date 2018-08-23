Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F29C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C59F208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C59F208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeHWTrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:47:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbeHWTrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:47:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE2E987A7F;
        Thu, 23 Aug 2018 16:16:45 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE32BB278A;
        Thu, 23 Aug 2018 16:16:43 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 RESEND 5/5] KVM: x86: hyperv: implement PV IPI send hypercalls
References: <20180822101832.31763-1-vkuznets@redhat.com>
        <20180822101832.31763-6-vkuznets@redhat.com>
        <20180823155623.GA5065@rkaganb.sw.ru>
Date:   Thu, 23 Aug 2018 18:16:42 +0200
In-Reply-To: <20180823155623.GA5065@rkaganb.sw.ru> (Roman Kagan's message of
        "Thu, 23 Aug 2018 18:56:23 +0300")
Message-ID: <87lg8x2h3p.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 23 Aug 2018 16:16:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 23 Aug 2018 16:16:45 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Wed, Aug 22, 2018 at 12:18:32PM +0200, Vitaly Kuznetsov wrote:
>> Using hypercall for sending IPIs is faster because this allows to specify
>> any number of vCPUs (even > 64 with sparse CPU set), the whole procedure
>> will take only one VMEXIT.
>> 
>> Current Hyper-V TLFS (v5.0b) claims that HvCallSendSyntheticClusterIpi
>> hypercall can't be 'fast' (passing parameters through registers) but
>> apparently this is not true, Windows always uses it as 'fast' so we need
>> to support that.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  Documentation/virtual/kvm/api.txt |   8 +++
>>  arch/x86/kvm/hyperv.c             | 109 ++++++++++++++++++++++++++++++++++++++
>>  arch/x86/kvm/trace.h              |  42 +++++++++++++++
>>  arch/x86/kvm/x86.c                |   1 +
>>  include/uapi/linux/kvm.h          |   1 +
>>  5 files changed, 161 insertions(+)
>
> Looks like I forgot to respond to this one, sorry.
>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index 7b83b176c662..832ea72d43c1 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -4690,3 +4690,11 @@ This capability indicates that KVM supports paravirtualized Hyper-V TLB Flush
>>  hypercalls:
>>  HvFlushVirtualAddressSpace, HvFlushVirtualAddressSpaceEx,
>>  HvFlushVirtualAddressList, HvFlushVirtualAddressListEx.
>> +
>> +8.19 KVM_CAP_HYPERV_SEND_IPI
>> +
>> +Architectures: x86
>> +
>> +This capability indicates that KVM supports paravirtualized Hyper-V IPI send
>> +hypercalls:
>> +HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index d1a911132b59..3183cf9bcb63 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -1360,6 +1360,101 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
>>  		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
>>  }
>>  
>> +static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
>> +			   bool ex, bool fast)
>> +{
>> +	struct kvm *kvm = current_vcpu->kvm;
>> +	struct hv_send_ipi_ex send_ipi_ex;
>> +	struct hv_send_ipi send_ipi;
>> +	struct kvm_vcpu *vcpu;
>> +	unsigned long valid_bank_mask;
>> +	u64 sparse_banks[64];
>> +	int sparse_banks_len, bank, i;
>> +	struct kvm_lapic_irq irq = {.delivery_mode = APIC_DM_FIXED};
>> +	bool all_cpus;
>> +
>> +	if (!ex) {
>> +		if (!fast) {
>> +			if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi,
>> +						    sizeof(send_ipi))))
>> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +			sparse_banks[0] = send_ipi.cpu_mask;
>> +			irq.vector = send_ipi.vector;
>> +		} else {
>> +			/* 'reserved' part of hv_send_ipi should be 0 */
>> +			if (unlikely(ingpa >> 32 != 0))
>> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +			sparse_banks[0] = outgpa;
>> +			irq.vector = (u32)ingpa;
>> +		}
>> +		all_cpus = false;
>> +		valid_bank_mask = BIT_ULL(0);
>> +
>> +		trace_kvm_hv_send_ipi(irq.vector, sparse_banks[0]);
>> +	} else {
>> +		if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi_ex,
>> +					    sizeof(send_ipi_ex))))
>> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +
>> +		trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
>> +					 send_ipi_ex.vp_set.format,
>> +					 send_ipi_ex.vp_set.valid_bank_mask);
>> +
>> +		irq.vector = send_ipi_ex.vector;
>> +		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
>> +		sparse_banks_len = bitmap_weight(&valid_bank_mask, 64) *
>> +			sizeof(sparse_banks[0]);
>> +
>> +		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
>> +
>> +		if (!sparse_banks_len)
>> +			goto ret_success;
>> +
>> +		if (!all_cpus &&
>> +		    kvm_read_guest(kvm,
>> +				   ingpa + offsetof(struct hv_send_ipi_ex,
>> +						    vp_set.bank_contents),
>> +				   sparse_banks,
>> +				   sparse_banks_len))
>> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +	}
>> +
>> +	if ((irq.vector < HV_IPI_LOW_VECTOR) ||
>> +	    (irq.vector > HV_IPI_HIGH_VECTOR))
>> +		return HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +
>> +	if (all_cpus) {
>> +		kvm_for_each_vcpu(i, vcpu, kvm) {
>> +			/* We fail only when APIC is disabled */
>> +			if (!kvm_apic_set_irq(vcpu, &irq, NULL))
>> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +		}
>> +		goto ret_success;
>> +	}
>> +
>> +	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask,
>> +			 BITS_PER_LONG) {
>
> I think you need exactly 64 rather than BITS_PER_LONG
>
>> +
>> +		for_each_set_bit(i, (unsigned long *)&sparse_banks[bank],
>> +				 BITS_PER_LONG) {
>
> ditto
>

Sure, will do.

>> +			u32 vp_index = bank * 64 + i;
>> +			struct kvm_vcpu *vcpu =
>> +				get_vcpu_by_vpidx(kvm, vp_index);
>> +
>> +			/* Unknown vCPU specified */
>> +			if (!vcpu)
>> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
>
> You may have already fired some IPIs, so returning error here without
> attempting the remaining vcpus in the request looks inconsistent to me.
>
> I don't see a specified way to report partial success from this
> hypercall.
>
> I'd rather continue here.
>

Basically, we have three choices:
- Just bail (what we do now)
- Ignore and continue returning success
- Ignore and continue returning failure.

but all of them are not perfect.

We could've pre-validated the set but this is kind of expensive and no
sane OS should be using invalid VP indexes.

>> +
>> +			/* We fail only when APIC is disabled */
>> +			if (!kvm_apic_set_irq(vcpu, &irq, NULL))
>> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
>
> Same here.
>

This is even worse as this can't be pre-validated reliably without
pausing all vCPUs first.

OK, let's switch to 'ignore and continue returning success'.

>> +		}
>> +	}
>> +
>> +ret_success:
>> +	return HV_STATUS_SUCCESS;
>> +}
>
> To my personal taste, this would have been easier to read if the -ex and
> non-ex versions were separate functions preparing the arguments (vector
> and mask) and calling into a common helper function to send the ipis.

I would agree but I think it was Radim's suggestion to unify ex- and
non-ex versions of kvm_hv_flush_tlb() and sending IPIs is not any
different.

Radim, please let me know if you think we should split them again, I'll
do it for both functions (either in this series or as a follow-up).

Thanks,

-- 
  Vitaly
