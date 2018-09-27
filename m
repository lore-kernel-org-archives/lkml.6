Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AFDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523642152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523642152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeI0PfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:35:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbeI0PfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:35:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C395B85541;
        Thu, 27 Sep 2018 09:18:03 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A14B2A2C7;
        Thu, 27 Sep 2018 09:18:01 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] KVM: x86: hyperv: keep track of mismatched VP indexes
In-Reply-To: <20180927075911.GB4186@rkaganb.sw.ru>
References: <20180926170259.29796-1-vkuznets@redhat.com> <20180926170259.29796-5-vkuznets@redhat.com> <20180927075911.GB4186@rkaganb.sw.ru>
Date:   Thu, 27 Sep 2018 11:17:59 +0200
Message-ID: <87sh1vfge0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 27 Sep 2018 09:18:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Wed, Sep 26, 2018 at 07:02:56PM +0200, Vitaly Kuznetsov wrote:
>> In most common cases VP index of a vcpu matches its vcpu index. Userspace
>> is, however, free to set any mapping it wishes and we need to account for
>> that when we need to find a vCPU with a particular VP index. To keep search
>> algorithms optimal in both cases introduce 'num_mismatched_vp_indexes'
>> counter showing how many vCPUs with mismatching VP index we have. In case
>> the counter is zero we can assume vp_index == vcpu_idx.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h |  3 +++
>>  arch/x86/kvm/hyperv.c           | 26 +++++++++++++++++++++++---
>>  2 files changed, 26 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 09b2e3e2cf1b..711f79f1b5e6 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -781,6 +781,9 @@ struct kvm_hv {
>>  	u64 hv_reenlightenment_control;
>>  	u64 hv_tsc_emulation_control;
>>  	u64 hv_tsc_emulation_status;
>> +
>> +	/* How many vCPUs have VP index != vCPU index */
>> +	atomic_t num_mismatched_vp_indexes;
>>  };
>>  
>>  enum kvm_irqchip_mode {
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index c8764faf783b..6a19c8e3c432 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -1045,11 +1045,31 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
>>  	struct kvm_vcpu_hv *hv_vcpu = &vcpu->arch.hyperv;
>>  
>>  	switch (msr) {
>> -	case HV_X64_MSR_VP_INDEX:
>> -		if (!host || (u32)data >= KVM_MAX_VCPUS)
>> +	case HV_X64_MSR_VP_INDEX: {
>> +		struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
>> +		int vcpu_idx = kvm_vcpu_get_idx(vcpu);
>> +		u32 new_vp_index = (u32)data;
>> +
>> +		if (!host || new_vp_index >= KVM_MAX_VCPUS)
>>  			return 1;
>> -		hv_vcpu->vp_index = (u32)data;
>> +
>> +		if (new_vp_index == hv_vcpu->vp_index)
>> +			return 0;
>> +
>> +		/*
>> +		 * VP index is changing, increment num_mismatched_vp_indexes in
>> +		 * case it was equal to vcpu_idx before; on the other hand, if
>> +		 * the new VP index matches vcpu_idx num_mismatched_vp_indexes
>> +		 * needs to be decremented.
>
> It may be worth mentioning that the initial balance is provided by
> kvm_hv_vcpu_postcreate setting vp_index = vcpu_idx.
>

Of course, yes, will update the comment in case I'll be re-submitting.

>> +		 */
>> +		if (hv_vcpu->vp_index == vcpu_idx)
>> +			atomic_inc(&hv->num_mismatched_vp_indexes);
>> +		else if (new_vp_index == vcpu_idx)
>> +			atomic_dec(&hv->num_mismatched_vp_indexes);
>
>> +
>> +		hv_vcpu->vp_index = new_vp_index;
>>  		break;
>> +	}
>>  	case HV_X64_MSR_VP_ASSIST_PAGE: {
>>  		u64 gfn;
>>  		unsigned long addr;
>
> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>

Thanks!

-- 
Vitaly
