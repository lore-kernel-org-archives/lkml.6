Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 742CFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA8A208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA8A208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934235AbeFLOwe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:52:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32912 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933228AbeFLOwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:52:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 62A3546A69A2F;
        Tue, 12 Jun 2018 22:52:22 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.382.0; Tue, 12 Jun 2018
 22:52:18 +0800
Subject: Re: [PATCH RESEND v4 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
To:     James Morse <james.morse@arm.com>
CC:     <rkrcmar@redhat.com>, <corbet@lwn.net>, <christoffer.dall@arm.com>,
        <marc.zyngier@arm.com>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <1528487320-2873-1-git-send-email-gengdongjiu@huawei.com>
 <1528487320-2873-3-git-send-email-gengdongjiu@huawei.com>
 <45e94aae-ed9f-1fb7-f10e-d95c2f969ddd@arm.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <f7f59176-16a1-3b24-5acc-87bf1b4c1490@huawei.com>
Date:   Tue, 12 Jun 2018 22:50:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <45e94aae-ed9f-1fb7-f10e-d95c2f969ddd@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
  thanks for the review.

On 2018/6/11 21:36, James Morse wrote:
> Hi Dongjiu Geng,
> 
> Please only put 'RESEND' in the subject if the patch content is identical.
> This patch is not the same as v4.

Yes, it should

> 
> On 08/06/18 20:48, Dongjiu Geng wrote:
>> For the migrating VMs, user space may need to know the exception
>> state. For example, in the machine A, KVM make an SError pending,
>> when migrate to B, KVM also needs to pend an SError.
>>
>> This new IOCTL exports user-invisible states related to SError.
>> Together with appropriate user space changes, user space can get/set
>> the SError exception state to do migrate/snapshot/suspend.
> 
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index fdac969..8896737 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -835,11 +835,13 @@ struct kvm_clock_data {
>>  
>>  Capability: KVM_CAP_VCPU_EVENTS
>>  Extended by: KVM_CAP_INTR_SHADOW
>> -Architectures: x86
>> +Architectures: x86, arm, arm64
>>  Type: vm ioctl
> 
> Isn't this actually a per-vcpu ioctl? Can we fix the documentation?
  I will modify the original documentation
> 
> 
>>  Parameters: struct kvm_vcpu_event (out)
>>  Returns: 0 on success, -1 on error
>>  
>> +X86:
>> +
>>  Gets currently pending exceptions, interrupts, and NMIs as well as related
>>  states of the vcpu.
>>  
>> @@ -881,15 +883,32 @@ Only two fields are defined in the flags field:
>>  - KVM_VCPUEVENT_VALID_SMM may be set in the flags field to signal that
>>    smi contains a valid state.
>>  
>> +ARM, ARM64:
>> +
>> +Gets currently pending SError exceptions as well as related states of the vcpu.
>> +
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
>> +
>>  4.32 KVM_SET_VCPU_EVENTS
>>  
>> -Capability: KVM_CAP_VCPU_EVENTS
>> +Capebility: KVM_CAP_VCPU_EVENTS
> 
> (please fix this)
   Ok, will fix this
> 
> 
>>  Extended by: KVM_CAP_INTR_SHADOW
>> -Architectures: x86
>> +Architectures: x86, arm, arm64
>>  Type: vm ioctl
> 
> (this is also a vcpu ioctl)
  will fix

> 
> 
>>  Parameters: struct kvm_vcpu_event (in)
>>  Returns: 0 on success, -1 on error
>>  
>> +X86:
>> +
>>  Set pending exceptions, interrupts, and NMIs as well as related states of the
>>  vcpu.
>>  
>> @@ -910,6 +929,12 @@ shall be written into the VCPU.
>>  
>>  KVM_VCPUEVENT_VALID_SMM can only be set if KVM_CAP_X86_SMM is available.
>>  
>> +ARM, ARM64:
>> +
>> +Set pending SError exceptions as well as related states of the vcpu.
> 
> There are some deliberate choices here I think we should document:
> | This API can't be used to clear a pending SError.
> 
> If there already was an SError pending, this API just overwrites it with the new
> one. The architecture has some rules about merging multiple SError. (details in
> 2.5.3 Multiple SError interrupts of [0])
> 
> I don't think KVM needs to enforce these, as they are implementation-defined if
> one of the ESR is implementation-defined... the part that matters is reporting
> the 'most severe' RAS ESR if there are multiple pending. As only user-space ever
> sets these, let's make it user-spaces problem to do.
> 
> I think we should recommend user-space always reads the pending values and
> applies its merging-multiple-SError logic. (I assume your Qemu patches do this).


 I will check whether QEMU can be possible to do such things, anyway this patch
 not need to do such merging.

> Something like:
> | User-space should first use KVM_GET_VCPU_EVENTS in case KVM has made an SError
> | pending as part of its device emulation. When both values are architected RAS
> | SError ESR values, the new ESR should reflect the combined effect of both
> | errors.>
> 
>> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
>> index caae484..c3e6975 100644
>> --- a/arch/arm/include/uapi/asm/kvm.h
>> +++ b/arch/arm/include/uapi/asm/kvm.h
>> @@ -124,6 +124,18 @@ struct kvm_sync_regs {
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
>> +
> 
> You haven't defined __KVM_HAVE_VCPU_EVENTS for 32bit, so presumably this struct
> will never be used. Why is it here?
  if not add it for 32 bits. the 32 arm platform will build Fail, whether you have good
   idea to avoid this Failure if not add this struct for the 32 bit?
> (I agree if we ever provide it on 32bit, the struct layout should be the same.
> Is this only here to force that to happen?)
> 
> [...]
> 
> 
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
> 
> kvm_set_sei_esr() will silently discard the top 40 bits of serror_esr, (which is
> correct, we shouldn't copy them into hardware without know what they do).
> 
> Could we please force user-space to zero these bits, we can advertise extra CAPs
> if new features turn up in that space, instead of user-space passing <something>
> and relying on the kernel to remove it.

  yes, I can zero these bits in the  user-space and not depend on kernel to remove it.

> 
> (Background: VSESR is a 64bit register that holds the value to go in a 32bit
> register. I suspect the top-half could get re-used for control values or
> something we don't want to give user-space)
  do you mean when user-space get the VSESR value through KVM_GET_VCPU_EVENTS it only return the low-half 32 bits?

> 
> 
>> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
>> index d8e7165..a55e91d 100644
>> --- a/arch/arm64/kvm/inject_fault.c
>> +++ b/arch/arm64/kvm/inject_fault.c
>> @@ -164,9 +164,9 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
>>  		inject_undef64(vcpu);
>>  }
>>  
>> -static void pend_guest_serror(struct kvm_vcpu *vcpu, u64 esr)
>> +void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 esr)
>>  {
>> -	vcpu_set_vsesr(vcpu, esr);
>> +	vcpu_set_vsesr(vcpu, esr & ESR_ELx_ISS_MASK);
>>  	*vcpu_hcr(vcpu) |= HCR_VSE;
>>  }
>>  
> 
>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>> index a4c1b76..79ecba9 100644
>> --- a/virt/kvm/arm/arm.c
>> +++ b/virt/kvm/arm/arm.c
>> @@ -1107,6 +1107,25 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> 
>> +	case KVM_SET_VCPU_EVENTS: {
>> +		struct kvm_vcpu_events events;
>> +
>> +		if (copy_from_user(&events, argp, sizeof(events)))
>> +			return -EFAULT;
>> +
>> +		return kvm_arm_vcpu_set_events(vcpu, &events);
>> +	}
> 
> Please check the padding[] and reserved[] are zero, otherwise we can't re-use these.
  Ok, thanks
> 
> 
> Thanks,
> 
> James
> 
> [0]
> https://static.docs.arm.com/ddi0587/a/RAS%20Extension-release%20candidate_march_29.pdf
> 
> .
> 

