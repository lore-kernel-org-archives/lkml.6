Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFAAC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53071218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfADR56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:57:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47852 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfADR55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:57:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A81EBD;
        Fri,  4 Jan 2019 09:57:57 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A8363F5D4;
        Fri,  4 Jan 2019 09:57:55 -0800 (PST)
Subject: Re: [PATCH v4 3/6] arm64/kvm: add a userspace option to enable
 pointer authentication
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
 <1545119810-12182-4-git-send-email-amit.kachhap@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <49474d5f-6f4e-b57d-4b45-94c16d85136c@arm.com>
Date:   Fri, 4 Jan 2019 17:57:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1545119810-12182-4-git-send-email-amit.kachhap@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 18/12/2018 07:56, Amit Daniel Kachhap wrote:
> This feature will allow the KVM guest to allow the handling of
> pointer authentication instructions or to treat them as undefined
> if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
> supply this parameter instead of creating a new API.
> 
> A new register is not created to pass this parameter via
> SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
> supplied is enough to select this feature.

What is the motivation for doing this? Doesn't ptrauth 'just' need turning on?
It doesn't need additional setup to be useable, or rely on some qemu support to
work properly. There isn't any hidden state that can't be migrated in the usual way.
Is it just because we don't want to commit to the ABI?


> diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> index 5baca42..8c0f338 100644
> --- a/Documentation/arm64/pointer-authentication.txt
> +++ b/Documentation/arm64/pointer-authentication.txt
> @@ -87,7 +87,8 @@ used to get and set the keys for a thread.
>  Virtualization
>  --------------
>  
> -Pointer authentication is not currently supported in KVM guests. KVM
> -will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
> -the feature will result in an UNDEFINED exception being injected into
> -the guest.
> +Pointer authentication is enabled in KVM guest when virtual machine is
> +created by passing a flag (KVM_ARM_VCPU_PTRAUTH) requesting this feature
> +to be enabled. Without this flag, pointer authentication is not enabled
> +in KVM guests and attempted use of the feature will result in an UNDEFINED
> +exception being injected into the guest.

> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index cd209f7..e20583a 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2634,6 +2634,10 @@ Possible features:
>  	  Depends on KVM_CAP_ARM_PSCI_0_2.
>  	- KVM_ARM_VCPU_PMU_V3: Emulate PMUv3 for the CPU.
>  	  Depends on KVM_CAP_ARM_PMU_V3.
> +	- KVM_ARM_VCPU_PTRAUTH: Emulate Pointer authentication for the CPU.
> +	  Depends on KVM_CAP_ARM_PTRAUTH and only on arm64 architecture. If
> +	  set, then the KVM guest allows the execution of pointer authentication
> +	  instructions or treats them as undefined if not set.

> diff --git a/arch/arm64/kvm/hyp/ptrauth-sr.c b/arch/arm64/kvm/hyp/ptrauth-sr.c
> index 1bfaf74..03999bb 100644
> --- a/arch/arm64/kvm/hyp/ptrauth-sr.c
> +++ b/arch/arm64/kvm/hyp/ptrauth-sr.c
> @@ -71,3 +71,19 @@ void __hyp_text __ptrauth_switch_to_host(struct kvm_vcpu *vcpu,
>  	__ptrauth_save_state(guest_ctxt);
>  	__ptrauth_restore_state(host_ctxt);
>  }
> +
> +/**
> + * kvm_arm_vcpu_ptrauth_allowed - checks if ptrauth feature is present in vcpu
> + *
> + * @vcpu: The VCPU pointer
> + *
> + * This function will be used to enable/disable ptrauth in guest as configured
> + * by the KVM userspace API.
> + */
> +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
> +{
> +	if (test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features))
> +		return true;
> +	else
> +		return false;
> +}

Can't you return the result of test_bit() directly?


Thanks,

James
