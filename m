Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5AEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F02621852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfBZSeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:34:44 -0500
Received: from foss.arm.com ([217.140.101.70]:52132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbfBZSen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:34:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E77F80D;
        Tue, 26 Feb 2019 10:34:43 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA4DE3F738;
        Tue, 26 Feb 2019 10:34:40 -0800 (PST)
Subject: Re: [PATCH v6 5/6] arm64/kvm: control accessibility of ptrauth key
 registers
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-6-git-send-email-amit.kachhap@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <fb401da1-63cb-fde1-67e4-e15f58940ae9@arm.com>
Date:   Tue, 26 Feb 2019 18:34:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550568271-5319-6-git-send-email-amit.kachhap@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 19/02/2019 09:24, Amit Daniel Kachhap wrote:
> According to userspace settings, ptrauth key registers are conditionally
> present in guest system register list based on user specified flag
> KVM_ARM_VCPU_PTRAUTH.
> 
> Reset routines still sets these registers to default values but they are
> left like that as they are conditionally accessible (set/get).

What problem is this patch solving?

I think it's that now we have ptrauth support, we have a glut of new registers visible to
user-space. This breaks migration and save/resume if the target machine doesn't have
pointer-auth configured, even if the guest wasn't using it.
Because we've got a VCPU bit, we can be smarter about this, and only expose the registers
if user-space was able to enable ptrauth.


> ---
> This patch needs patch [1] by Dave Martin and adds feature to manage accessibility in a scalable way.
> 
> [1]: https://lore.kernel.org/linux-arm-kernel/1547757219-19439-13-git-send-email-Dave.Martin@arm.com/ 

This is v4. Shortly before you posted this there was a v5 (but the subject changed, easily
missed). V5 has subsequently been reviewed. As we can't have both, could you rebase onto
that v5 so that there is one way of doing this?

(in general if you could re-post the version you develop/tested with then it makes it
clear what is going on)


> diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> index 0529a7d..996e435 100644
> --- a/Documentation/arm64/pointer-authentication.txt
> +++ b/Documentation/arm64/pointer-authentication.txt
> @@ -87,3 +87,7 @@ created by passing a flag (KVM_ARM_VCPU_PTRAUTH) requesting this feature
>  to be enabled. Without this flag, pointer authentication is not enabled
>  in KVM guests and attempted use of the feature will result in an UNDEFINED
>  exception being injected into the guest.
> +
> +Additionally, when KVM_ARM_VCPU_PTRAUTH is not set then KVM will filter
> +out the Pointer Authentication system key registers from KVM_GET/SET_REG_*
> +ioctls.
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index f7bcc60..c2f4974 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1005,8 +1005,13 @@ static bool trap_ptrauth(struct kvm_vcpu *vcpu,
>  	return false;
>  }
>  
> +static bool check_ptrauth(const struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd)
> +{
> +	return kvm_arm_vcpu_ptrauth_allowed(vcpu);
> +}
> +
>  #define __PTRAUTH_KEY(k)						\
> -	{ SYS_DESC(SYS_## k), trap_ptrauth, reset_unknown, k }
> +	{ SYS_DESC(SYS_## k), trap_ptrauth, reset_unknown, k , .check_present = check_ptrauth}


Looks good. I'm pretty sure the changes due to Dave's v5 map neatly.


Thanks,

James
