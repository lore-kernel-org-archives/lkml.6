Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rj7LLpx6HlvVPwAAmS7hNA
	; Mon, 11 Jun 2018 13:36:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7CE1D607BB; Mon, 11 Jun 2018 13:36:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 01E0460541;
	Mon, 11 Jun 2018 13:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01E0460541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeFKNgu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:36:50 -0400
Received: from foss.arm.com ([217.140.101.70]:51680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754238AbeFKNgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:36:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D22141596;
        Mon, 11 Jun 2018 06:36:45 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF6B53F318;
        Mon, 11 Jun 2018 06:36:43 -0700 (PDT)
Subject: Re: [PATCH RESEND v4 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
To: Marc Zyngier <marc.zyngier@arm.com>,
        Dongjiu Geng <gengdongjiu@huawei.com>
Cc: rkrcmar@redhat.com, corbet@lwn.net, christoffer.dall@arm.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <1528487320-2873-1-git-send-email-gengdongjiu@huawei.com>
 <1528487320-2873-3-git-send-email-gengdongjiu@huawei.com>
 <86zi04875t.wl-marc.zyngier@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <af93e4b1-80d5-33be-d5ed-312c3ea1d715@arm.com>
Date: Mon, 11 Jun 2018 14:36:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86zi04875t.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu Geng,

On 09/06/18 13:40, Marc Zyngier wrote:
> On Fri, 08 Jun 2018 20:48:40 +0100, Dongjiu Geng wrote:
>> For the migrating VMs, user space may need to know the exception
>> state. For example, in the machine A, KVM make an SError pending,
>> when migrate to B, KVM also needs to pend an SError.
>>
>> This new IOCTL exports user-invisible states related to SError.
>> Together with appropriate user space changes, user space can get/set
>> the SError exception state to do migrate/snapshot/suspend.

>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> index 04b3256..df4faee 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -153,6 +154,18 @@ struct kvm_sync_regs {
>>  struct kvm_arch_memory_slot {
>>  };
>>  
>> +/* for KVM_GET/SET_VCPU_EVENTS */
>> +struct kvm_vcpu_events {
>> +	struct {
>> +		__u8 serror_pending;
>> +		__u8 serror_has_esr;
>> +		/* Align it to 8 bytes */
>> +		__u8 pad[6];
>> +		__u64 serror_esr;
>> +	} exception;
>> +	__u32 reserved[12];
>> +};

>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index 56a0260..4426915 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c

>> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>> +			struct kvm_vcpu_events *events)
>> +{
>> +	bool serror_pending = events->exception.serror_pending;
>> +	bool has_esr = events->exception.serror_has_esr;
>> +
>> +	if (serror_pending && has_esr) {
>> +		if (!cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
>> +			return -EINVAL;
>> +
>> +		kvm_set_sei_esr(vcpu, events->exception.serror_esr);
>> +	} else if (serror_pending) {
>> +		kvm_inject_vabt(vcpu);
>> +	}
>> +
>> +	return 0;
> 
> There was an earlier request to check that all the padding is set to
> zero. I still think this makes sense.

I agree, not just the exception.padding[], but reserved[] too.


Thanks,

James
