Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MHE7KO56HlvgQQAAmS7hNA
	; Mon, 11 Jun 2018 13:36:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 977366074D; Mon, 11 Jun 2018 13:36:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D492A60541;
	Mon, 11 Jun 2018 13:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D492A60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeFKNgo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:36:44 -0400
Received: from foss.arm.com ([217.140.101.70]:51656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751886AbeFKNgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:36:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 391901529;
        Mon, 11 Jun 2018 06:36:42 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26D273F318;
        Mon, 11 Jun 2018 06:36:40 -0700 (PDT)
Subject: Re: [PATCH RESEND v4 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
To: Dongjiu Geng <gengdongjiu@huawei.com>
References: <1528487320-2873-1-git-send-email-gengdongjiu@huawei.com>
 <1528487320-2873-3-git-send-email-gengdongjiu@huawei.com>
From: James Morse <james.morse@arm.com>
Cc: rkrcmar@redhat.com, corbet@lwn.net, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Message-ID: <45e94aae-ed9f-1fb7-f10e-d95c2f969ddd@arm.com>
Date: Mon, 11 Jun 2018 14:36:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528487320-2873-3-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu Geng,

Please only put 'RESEND' in the subject if the patch content is identical.
This patch is not the same as v4.

On 08/06/18 20:48, Dongjiu Geng wrote:
> For the migrating VMs, user space may need to know the exception
> state. For example, in the machine A, KVM make an SError pending,
> when migrate to B, KVM also needs to pend an SError.
> 
> This new IOCTL exports user-invisible states related to SError.
> Together with appropriate user space changes, user space can get/set
> the SError exception state to do migrate/snapshot/suspend.

> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index fdac969..8896737 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -835,11 +835,13 @@ struct kvm_clock_data {
>  
>  Capability: KVM_CAP_VCPU_EVENTS
>  Extended by: KVM_CAP_INTR_SHADOW
> -Architectures: x86
> +Architectures: x86, arm, arm64
>  Type: vm ioctl

Isn't this actually a per-vcpu ioctl? Can we fix the documentation?


>  Parameters: struct kvm_vcpu_event (out)
>  Returns: 0 on success, -1 on error
>  
> +X86:
> +
>  Gets currently pending exceptions, interrupts, and NMIs as well as related
>  states of the vcpu.
>  
> @@ -881,15 +883,32 @@ Only two fields are defined in the flags field:
>  - KVM_VCPUEVENT_VALID_SMM may be set in the flags field to signal that
>    smi contains a valid state.
>  
> +ARM, ARM64:
> +
> +Gets currently pending SError exceptions as well as related states of the vcpu.
> +
> +struct kvm_vcpu_events {
> +	struct {
> +		__u8 serror_pending;
> +		__u8 serror_has_esr;
> +		/* Align it to 8 bytes */
> +		__u8 pad[6];
> +		__u64 serror_esr;
> +	} exception;
> +	__u32 reserved[12];
> +};
> +
>  4.32 KVM_SET_VCPU_EVENTS
>  
> -Capability: KVM_CAP_VCPU_EVENTS
> +Capebility: KVM_CAP_VCPU_EVENTS

(please fix this)


>  Extended by: KVM_CAP_INTR_SHADOW
> -Architectures: x86
> +Architectures: x86, arm, arm64
>  Type: vm ioctl

(this is also a vcpu ioctl)


>  Parameters: struct kvm_vcpu_event (in)
>  Returns: 0 on success, -1 on error
>  
> +X86:
> +
>  Set pending exceptions, interrupts, and NMIs as well as related states of the
>  vcpu.
>  
> @@ -910,6 +929,12 @@ shall be written into the VCPU.
>  
>  KVM_VCPUEVENT_VALID_SMM can only be set if KVM_CAP_X86_SMM is available.
>  
> +ARM, ARM64:
> +
> +Set pending SError exceptions as well as related states of the vcpu.

There are some deliberate choices here I think we should document:
| This API can't be used to clear a pending SError.

If there already was an SError pending, this API just overwrites it with the new
one. The architecture has some rules about merging multiple SError. (details in
2.5.3 Multiple SError interrupts of [0])

I don't think KVM needs to enforce these, as they are implementation-defined if
one of the ESR is implementation-defined... the part that matters is reporting
the 'most severe' RAS ESR if there are multiple pending. As only user-space ever
sets these, let's make it user-spaces problem to do.

I think we should recommend user-space always reads the pending values and
applies its merging-multiple-SError logic. (I assume your Qemu patches do this).

Something like:
| User-space should first use KVM_GET_VCPU_EVENTS in case KVM has made an SError
| pending as part of its device emulation. When both values are architected RAS
| SError ESR values, the new ESR should reflect the combined effect of both
| errors.


> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index caae484..c3e6975 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -124,6 +124,18 @@ struct kvm_sync_regs {
>  struct kvm_arch_memory_slot {
>  };
>  
> +/* for KVM_GET/SET_VCPU_EVENTS */
> +struct kvm_vcpu_events {
> +	struct {
> +		__u8 serror_pending;
> +		__u8 serror_has_esr;
> +		/* Align it to 8 bytes */
> +		__u8 pad[6];
> +		__u64 serror_esr;
> +	} exception;
> +	__u32 reserved[12];
> +};
> +

You haven't defined __KVM_HAVE_VCPU_EVENTS for 32bit, so presumably this struct
will never be used. Why is it here?

(I agree if we ever provide it on 32bit, the struct layout should be the same.
Is this only here to force that to happen?)

[...]


> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events)
> +{
> +	bool serror_pending = events->exception.serror_pending;
> +	bool has_esr = events->exception.serror_has_esr;
> +
> +	if (serror_pending && has_esr) {
> +		if (!cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
> +			return -EINVAL;
> +
> +		kvm_set_sei_esr(vcpu, events->exception.serror_esr);

kvm_set_sei_esr() will silently discard the top 40 bits of serror_esr, (which is
correct, we shouldn't copy them into hardware without know what they do).

Could we please force user-space to zero these bits, we can advertise extra CAPs
if new features turn up in that space, instead of user-space passing <something>
and relying on the kernel to remove it.

(Background: VSESR is a 64bit register that holds the value to go in a 32bit
register. I suspect the top-half could get re-used for control values or
something we don't want to give user-space)


> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index d8e7165..a55e91d 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -164,9 +164,9 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
>  		inject_undef64(vcpu);
>  }
>  
> -static void pend_guest_serror(struct kvm_vcpu *vcpu, u64 esr)
> +void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 esr)
>  {
> -	vcpu_set_vsesr(vcpu, esr);
> +	vcpu_set_vsesr(vcpu, esr & ESR_ELx_ISS_MASK);
>  	*vcpu_hcr(vcpu) |= HCR_VSE;
>  }
>  

> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index a4c1b76..79ecba9 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1107,6 +1107,25 @@ long kvm_arch_vcpu_ioctl(struct file *filp,

> +	case KVM_SET_VCPU_EVENTS: {
> +		struct kvm_vcpu_events events;
> +
> +		if (copy_from_user(&events, argp, sizeof(events)))
> +			return -EFAULT;
> +
> +		return kvm_arm_vcpu_set_events(vcpu, &events);
> +	}

Please check the padding[] and reserved[] are zero, otherwise we can't re-use these.


Thanks,

James

[0]
https://static.docs.arm.com/ddi0587/a/RAS%20Extension-release%20candidate_march_29.pdf
