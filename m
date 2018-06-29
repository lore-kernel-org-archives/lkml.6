Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4EAC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFAF24EAD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFAF24EAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966767AbeF2P7N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:59:13 -0400
Received: from foss.arm.com ([217.140.101.70]:36492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966678AbeF2P7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:59:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 533FE18A;
        Fri, 29 Jun 2018 08:59:11 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D4CE3F5C0;
        Fri, 29 Jun 2018 08:59:08 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
To:     Dongjiu Geng <gengdongjiu@huawei.com>
References: <1529960309-2513-1-git-send-email-gengdongjiu@huawei.com>
 <1529960309-2513-2-git-send-email-gengdongjiu@huawei.com>
From:   James Morse <james.morse@arm.com>
Cc:     rkrcmar@redhat.com, corbet@lwn.net, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Message-ID: <ec201845-fd1e-fd0a-7dfe-bacf23bb44a2@arm.com>
Date:   Fri, 29 Jun 2018 16:59:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529960309-2513-2-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu Geng,

On 25/06/18 21:58, Dongjiu Geng wrote:
> For the migrating VMs, user space may need to know the exception
> state. For example, in the machine A, KVM make an SError pending,
> when migrate to B, KVM also needs to pend an SError.
> 
> This new IOCTL exports user-invisible states related to SError.
> Together with appropriate user space changes, user space can get/set
> the SError exception state to do migrate/snapshot/suspend.


> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 469de8a..357304a 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -335,6 +335,11 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
>  int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
>  int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>  int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> +int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events);
> +
> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events);
>  

(Nit: funny indentation)


> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 56a0260..8be14cc 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -289,6 +289,49 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,

> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
> +			struct kvm_vcpu_events *events)
> +{
> +	int i;
> +	bool serror_pending = events->exception.serror_pending;
> +	bool has_esr = events->exception.serror_has_esr;
> +
> +	/* check whether the reserved field is zero */
> +	for (i = 0; i < ARRAY_SIZE(events->reserved); i++)
> +		if (events->reserved[i])
> +			return -EINVAL;
> +
> +	/* check whether the pad field is zero */
> +	for (i = 0; i < ARRAY_SIZE(events->exception.pad); i++)
> +		if (events->exception.pad[i])
> +			return -EINVAL;
> +
> +	if (serror_pending && has_esr) {
> +		if (!cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
> +			return -EINVAL;
> +

> +		kvm_set_sei_esr(vcpu, events->exception.serror_esr);

This silently discards all but the bottom 24 bits of serror_esr.

It makes sense that this field is 64 bit, because the register is 64 bit, and it
would let us use this API to migrate any new state that appears in the higher
bits... But those bits will come with an ID/feature field, we shouldn't accept
an attempt to restore them on a CPU that doesn't support the feature. If that
happens here, it silently succeeds, but the kernel just threw the extra bits away.

You added documentation that only the bottom 24bits can be set, can we add
checks to enforce this, so the bits can be used later.


> +	} else if (serror_pending) {
> +		kvm_inject_vabt(vcpu);
> +	}
> +
> +	return 0;
> +}

> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index a4c1b76..4e6f366 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1107,6 +1107,27 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = kvm_arm_vcpu_has_attr(vcpu, &attr);
>  		break;
>  	}
> +#ifdef __KVM_HAVE_VCPU_EVENTS

So its this #ifdef, or a uapi struct for a feature 32bit doesn't support.
I think the right thing to do is wire this up for 32bit, it also calls
kvm_inject_vabt() in handle_exit.c, so must have the same migration problems.

I'll post a patch to do this as I've got something I can test it on.


> +	case KVM_GET_VCPU_EVENTS: {
> +		struct kvm_vcpu_events events;
> +
> +		if (kvm_arm_vcpu_get_events(vcpu, &events))
> +			return -EINVAL;
> +
> +		if (copy_to_user(argp, &events, sizeof(events)))
> +			return -EFAULT;
> +
> +		return 0;
> +	}
> +	case KVM_SET_VCPU_EVENTS: {
> +		struct kvm_vcpu_events events;
> +
> +		if (copy_from_user(&events, argp, sizeof(events)))
> +			return -EFAULT;
> +
> +		return kvm_arm_vcpu_set_events(vcpu, &events);
> +	}
> +#endif

(It bugs me that the architecture has some rules about merging multiple
architected ESR values, that we neither enforce, nor document as user-space's
problem. It doesn't matter for RAS, but might for any future ESR encodings. But
I guess user-space wouldn't be aware of them anyway, and it can already put
bogus values in SPSR/ESR/ELR etc.)


With a check against the top bits of ESR:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
