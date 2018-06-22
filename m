Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6347AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FA924603
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FA924603
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934412AbeFVTNj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:13:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934096AbeFVTNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:13:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F036244D01;
        Fri, 22 Jun 2018 19:13:36 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5823A2026D6C;
        Fri, 22 Jun 2018 19:13:34 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 22 Jun 2018 21:13:33 +0200
Date:   Fri, 22 Jun 2018 21:13:33 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] KVM: x86: hyperv: implement PV IPI send hypercalls
Message-ID: <20180622191333.GC2377@flask>
References: <20180622145616.5851-1-vkuznets@redhat.com>
 <20180622145616.5851-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622145616.5851-4-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 22 Jun 2018 19:13:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 22 Jun 2018 19:13:37 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-22 16:56+0200, Vitaly Kuznetsov:
> Using hypercall for sending IPIs is faster because this allows to specify
> any number of vCPUs (even > 64 with sparse CPU set), the whole procedure
> will take only one VMEXIT.
> 
> Current Hyper-V TLFS (v5.0b) claims that HvCallSendSyntheticClusterIpi
> hypercall can't be 'fast' (passing parameters through registers) but
> apparently this is not true, Windows always uses it as 'fast' so we need
> to support that.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> @@ -1357,6 +1357,108 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
>  		((u64)rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
>  }
>  
> +static u64 kvm_hv_send_ipi(struct kvm_vcpu *current_vcpu, u64 ingpa, u64 outgpa,
> +			   bool ex, bool fast)
> +{
> +	struct kvm *kvm = current_vcpu->kvm;
> +	struct hv_send_ipi_ex send_ipi_ex;
> +	struct hv_send_ipi send_ipi;
> +	struct kvm_vcpu *vcpu;
> +	unsigned long valid_bank_mask = 0;
> +	u64 sparse_banks[64];
> +	int sparse_banks_len, i;
> +	struct kvm_lapic_irq irq = {0};
> +	bool all_cpus;
> +
> +	if (!ex) {
> +		if (!fast) {
> +			if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi,
> +						    sizeof(send_ipi))))
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +			sparse_banks[0] = send_ipi.cpu_mask;
> +			irq.vector = send_ipi.vector;
> +		} else {
> +			/* 'reserved' part of hv_send_ipi should be 0 */
> +			if (unlikely(ingpa >> 32 != 0))
> +				return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +			sparse_banks[0] = outgpa;
> +			irq.vector = (u32)ingpa;
> +		}
> +		all_cpus = false;
> +
> +		trace_kvm_hv_send_ipi(irq.vector, sparse_banks[0]);
> +	} else {
> +		if (unlikely(kvm_read_guest(kvm, ingpa, &send_ipi_ex,
> +					    sizeof(send_ipi_ex))))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +		trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
> +					 send_ipi_ex.vp_set.format,
> +					 send_ipi_ex.vp_set.valid_bank_mask);
> +
> +		irq.vector = send_ipi_ex.vector;
> +		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
> +		sparse_banks_len = bitmap_weight(&valid_bank_mask, 64) *
> +			sizeof(sparse_banks[0]);
> +		all_cpus = send_ipi_ex.vp_set.format !=
> +			HV_GENERIC_SET_SPARSE_4K;

This would be much better readable as

  send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL

And if Microsoft ever adds more formats, they won't be all VCPUs, so
we're future-proofing as well.

> +
> +		if (!sparse_banks_len)
> +			goto ret_success;
> +
> +		if (!all_cpus &&
> +		    kvm_read_guest(kvm,
> +				   ingpa + offsetof(struct hv_send_ipi_ex,
> +						    vp_set.bank_contents),
> +				   sparse_banks,
> +				   sparse_banks_len))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +	}
> +
> +	if ((irq.vector < HV_IPI_LOW_VECTOR) ||
> +	    (irq.vector > HV_IPI_HIGH_VECTOR))
> +		return HV_STATUS_INVALID_HYPERCALL_INPUT;
> +
> +	irq.delivery_mode = APIC_DM_FIXED;

I'd set this during variable definition.

APIC_DM_FIXED is 0 anyway and the compiler probably won't optimize it
here due to function with side effects since definition.

> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
> +		int bank = hv->vp_index / 64, sbank = 0;
> +
> +		if (!all_cpus) {
> +			/* Banks >64 can't be represented */
> +			if (bank >= 64)
> +				continue;
> +
> +			/* Non-ex hypercalls can only address first 64 vCPUs */
> +			if (!ex && bank)
> +				continue;
> +
> +			if (ex) {
> +				/*
> +				 * Check is the bank of this vCPU is in sparse
> +				 * set and get the sparse bank number.
> +				 */
> +				sbank = get_sparse_bank_no(valid_bank_mask,
> +							   bank);
> +
> +				if (sbank < 0)
> +					continue;
> +			}
> +
> +			if (!(sparse_banks[sbank] & BIT_ULL(hv->vp_index % 64)))
> +				continue;
> +		}
> +
> +		/* We fail only when APIC is disabled */
> +		if (!kvm_apic_set_irq(vcpu, &irq, NULL))
> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;

Does Windows use this even for 1 VCPU IPI?

I'm thinking we could apply the same optimization we do for LAPIC -- RCU
protected array that maps vp_index to vcpu.

Thanks.

> +	}
> +
> +ret_success:
> +	return HV_STATUS_SUCCESS;
> +}
> +
>  bool kvm_hv_hypercall_enabled(struct kvm *kvm)
>  {
>  	return READ_ONCE(kvm->arch.hyperv.hv_hypercall) & HV_X64_MSR_HYPERCALL_ENABLE;
> @@ -1526,6 +1628,20 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  		}
>  		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt, true);
>  		break;
> +	case HVCALL_SEND_IPI:
> +		if (unlikely(rep)) {
> +			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
> +			break;
> +		}
> +		ret = kvm_hv_send_ipi(vcpu, ingpa, outgpa, false, fast);
> +		break;
> +	case HVCALL_SEND_IPI_EX:
> +		if (unlikely(fast || rep)) {

Now I'm getting worried that the ex can be fast as well and we'll be
reading the banks from XMM registers. :)
