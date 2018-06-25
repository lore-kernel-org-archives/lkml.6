Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60F4C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9910925670
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9910925670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754847AbeFYJKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:10:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754449AbeFYJKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:10:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77EBC4040076;
        Mon, 25 Jun 2018 09:10:32 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A536A2026D5B;
        Mon, 25 Jun 2018 09:10:30 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] KVM: x86: hyperv: implement PV IPI send hypercalls
References: <20180622145616.5851-1-vkuznets@redhat.com>
        <20180622145616.5851-4-vkuznets@redhat.com>
        <20180622191333.GC2377@flask>
Date:   Mon, 25 Jun 2018 11:10:29 +0200
In-Reply-To: <20180622191333.GC2377@flask> ("Radim \=\?utf-8\?B\?S3LEjW3DocWZ\?\=
 \=\?utf-8\?B\?Iidz\?\= message of "Fri,
        22 Jun 2018 21:13:33 +0200")
Message-ID: <87r2kvgrju.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 25 Jun 2018 09:10:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 25 Jun 2018 09:10:32 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radim Krčmář <rkrcmar@redhat.com> writes:

> 2018-06-22 16:56+0200, Vitaly Kuznetsov:
>> +
>> +		/* We fail only when APIC is disabled */
>> +		if (!kvm_apic_set_irq(vcpu, &irq, NULL))
>> +			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>
> Does Windows use this even for 1 VCPU IPI?
>

It seems that it does.

> I'm thinking we could apply the same optimization we do for LAPIC -- RCU
> protected array that maps vp_index to vcpu.

Sure, both this and PV TLB flush will benefit.

>
> Thanks.
>
>> +	}
>> +
>> +ret_success:
>> +	return HV_STATUS_SUCCESS;
>> +}
>> +
>>  bool kvm_hv_hypercall_enabled(struct kvm *kvm)
>>  {
>>  	return READ_ONCE(kvm->arch.hyperv.hv_hypercall) & HV_X64_MSR_HYPERCALL_ENABLE;
>> @@ -1526,6 +1628,20 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>>  		}
>>  		ret = kvm_hv_flush_tlb(vcpu, ingpa, rep_cnt, true);
>>  		break;
>> +	case HVCALL_SEND_IPI:
>> +		if (unlikely(rep)) {
>> +			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>> +			break;
>> +		}
>> +		ret = kvm_hv_send_ipi(vcpu, ingpa, outgpa, false, fast);
>> +		break;
>> +	case HVCALL_SEND_IPI_EX:
>> +		if (unlikely(fast || rep)) {
>
> Now I'm getting worried that the ex can be fast as well and we'll be
> reading the banks from XMM registers. :)

Maybe but currently we don't announce 'parameters through XMM registers'
support in KVM (and neither do we support these for Linux-on-Hyper-V as
we don't usually use FPU in kernel).

-- 
  Vitaly
