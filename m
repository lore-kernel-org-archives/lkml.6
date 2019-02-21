Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B143C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4595720838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfBUPyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:54:05 -0500
Received: from foss.arm.com ([217.140.101.70]:46872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbfBUPyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:54:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4CE2A78;
        Thu, 21 Feb 2019 07:54:03 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67EC3F5C1;
        Thu, 21 Feb 2019 07:54:01 -0800 (PST)
Date:   Thu, 21 Feb 2019 15:53:59 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] arm64/kvm: control accessibility of ptrauth key
 registers
Message-ID: <20190221155359.GZ3567@e103592.cambridge.arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-6-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550568271-5319-6-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 02:54:30PM +0530, Amit Daniel Kachhap wrote:
> According to userspace settings, ptrauth key registers are conditionally
> present in guest system register list based on user specified flag
> KVM_ARM_VCPU_PTRAUTH.
> 
> Reset routines still sets these registers to default values but they are
> left like that as they are conditionally accessible (set/get).
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
> This patch needs patch [1] by Dave Martin and adds feature to manage accessibility in a scalable way.
> 
> [1]: https://lore.kernel.org/linux-arm-kernel/1547757219-19439-13-git-send-email-Dave.Martin@arm.com/ 

FYI, check_present() has changed a bit in the SVE v5 series [2].

The precise interface is still under discussion, so please take a look
and feel free to comment.

You'll probably need to tweak some things so that the KVM_GET_REG_LIST
output is consistent with the set of regs that do/don't yield -ENOENT in
KVM_GET_ONE_REG/KVM_SET_ONE_REG.

See other patches in the series for examples of how I use the modified
interface.

[...]

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

Cheers
---Dave


[2] [PATCH v5 12/26] KVM: arm64: Support runtime sysreg visibility filtering
https://lists.cs.columbia.edu/pipermail/kvmarm/2019-February/034671.html
