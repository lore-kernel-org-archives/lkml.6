Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366AFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE24720823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfBUPxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:53:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46830 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfBUPxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:53:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F2CA78;
        Thu, 21 Feb 2019 07:53:43 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D94673F5C1;
        Thu, 21 Feb 2019 07:53:41 -0800 (PST)
Date:   Thu, 21 Feb 2019 15:53:39 +0000
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
Subject: Re: [PATCH v6 3/6] arm64/kvm: context-switch ptrauth registers
Message-ID: <20190221155339.GX3567@e103592.cambridge.arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-4-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550568271-5319-4-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 02:54:28PM +0530, Amit Daniel Kachhap wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> When pointer authentication is supported, a guest may wish to use it.
> This patch adds the necessary KVM infrastructure for this to work, with
> a semi-lazy context switch of the pointer auth state.
> 
> Pointer authentication feature is only enabled when VHE is built
> in the kernel and present into CPU implementation so only VHE code
> paths are modified.
> 
> When we schedule a vcpu, we disable guest usage of pointer
> authentication instructions and accesses to the keys. While these are
> disabled, we avoid context-switching the keys. When we trap the guest
> trying to use pointer authentication functionality, we change to eagerly
> context-switching the keys, and enable the feature. The next time the
> vcpu is scheduled out/in, we start again. However the host key registers
> are saved in vcpu load stage as they remain constant for each vcpu
> schedule.
> 
> Pointer authentication consists of address authentication and generic
> authentication, and CPUs in a system might have varied support for
> either. Where support for either feature is not uniform, it is hidden
> from guests via ID register emulation, as a result of the cpufeature
> framework in the host.
> 
> Unfortunately, address authentication and generic authentication cannot
> be trapped separately, as the architecture provides a single EL2 trap
> covering both. If we wish to expose one without the other, we cannot
> prevent a (badly-written) guest from intermittently using a feature
> which is not uniformly supported (when scheduled on a physical CPU which
> supports the relevant feature). Hence, this patch expects both type of
> authentication to be present in a cpu.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> [Only VHE, key switch from from assembly, kvm_supports_ptrauth
> checks, save host key in vcpu_load]
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  arch/arm/include/asm/kvm_host.h   |   1 +
>  arch/arm64/include/asm/kvm_host.h |  23 +++++++++
>  arch/arm64/include/asm/kvm_hyp.h  |   7 +++
>  arch/arm64/kernel/traps.c         |   1 +
>  arch/arm64/kvm/handle_exit.c      |  21 +++++---
>  arch/arm64/kvm/hyp/Makefile       |   1 +
>  arch/arm64/kvm/hyp/entry.S        |  17 +++++++
>  arch/arm64/kvm/hyp/ptrauth-sr.c   | 101 ++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kvm/sys_regs.c         |  37 +++++++++++++-
>  virt/kvm/arm/arm.c                |   2 +
>  10 files changed, 201 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm64/kvm/hyp/ptrauth-sr.c

[...]

> diff --git a/arch/arm64/kvm/hyp/ptrauth-sr.c b/arch/arm64/kvm/hyp/ptrauth-sr.c
> new file mode 100644
> index 0000000..528ee6e
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/ptrauth-sr.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * arch/arm64/kvm/hyp/ptrauth-sr.c: Guest/host ptrauth save/restore
> + *
> + * Copyright 2018 Arm Limited
> + * Author: Mark Rutland <mark.rutland@arm.com>
> + *         Amit Daniel Kachhap <amit.kachhap@arm.com>
> + */
> +#include <linux/compiler.h>
> +#include <linux/kvm_host.h>
> +
> +#include <asm/cpucaps.h>
> +#include <asm/cpufeature.h>
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_hyp.h>
> +#include <asm/pointer_auth.h>
> +
> +static __always_inline bool __ptrauth_is_enabled(struct kvm_vcpu *vcpu)
> +{
> +	return IS_ENABLED(CONFIG_ARM64_PTR_AUTH) &&
> +			vcpu->arch.ctxt.hcr_el2 & (HCR_API | HCR_APK);
> +}
> +
> +#define __ptrauth_save_key(regs, key)						\
> +({										\
> +	regs[key ## KEYLO_EL1] = read_sysreg_s(SYS_ ## key ## KEYLO_EL1);	\
> +	regs[key ## KEYHI_EL1] = read_sysreg_s(SYS_ ## key ## KEYHI_EL1);	\
> +})
> +
> +static __always_inline void __ptrauth_save_state(struct kvm_cpu_context *ctxt)

Why __always_inline?

> +{
> +	__ptrauth_save_key(ctxt->sys_regs, APIA);
> +	__ptrauth_save_key(ctxt->sys_regs, APIB);
> +	__ptrauth_save_key(ctxt->sys_regs, APDA);
> +	__ptrauth_save_key(ctxt->sys_regs, APDB);
> +	__ptrauth_save_key(ctxt->sys_regs, APGA);
> +}
> +
> +#define __ptrauth_restore_key(regs, key) 					\
> +({										\
> +	write_sysreg_s(regs[key ## KEYLO_EL1], SYS_ ## key ## KEYLO_EL1);	\
> +	write_sysreg_s(regs[key ## KEYHI_EL1], SYS_ ## key ## KEYHI_EL1);	\
> +})
> +
> +static __always_inline void __ptrauth_restore_state(struct kvm_cpu_context *ctxt)

Same here.  I would hope these just need to be marked with the correct
function attribute to disable ptrauth by the compiler.  I don't see why
it makes a difference whether it's inline or not.

If the compiler semantics are not sufficiently clear, make it a macro.

(Bikeshedding here, so it you feel this has already been discussed to
death I'm happy for this to stay as-is.)

> +{
> +	__ptrauth_restore_key(ctxt->sys_regs, APIA);
> +	__ptrauth_restore_key(ctxt->sys_regs, APIB);
> +	__ptrauth_restore_key(ctxt->sys_regs, APDA);
> +	__ptrauth_restore_key(ctxt->sys_regs, APDB);
> +	__ptrauth_restore_key(ctxt->sys_regs, APGA);
> +}
> +
> +/**
> + * This function changes the key so assign Pointer Authentication safe
> + * GCC attribute if protected by it.
> + */

(I'd have preferred to keep __noptrauth here and define it do nothing for
now.  But I'll defer to others on that, since this has already been
discussed...)

> +void __ptrauth_switch_to_guest(struct kvm_vcpu *vcpu,
> +				  struct kvm_cpu_context *host_ctxt,
> +				  struct kvm_cpu_context *guest_ctxt)
> +{
> +	if (!__ptrauth_is_enabled(vcpu))
> +		return;
> +
> +	__ptrauth_restore_state(guest_ctxt);
> +}
> +
> +/**
> + * This function changes the key so assign Pointer Authentication safe
> + * GCC attribute if protected by it.
> + */
> +void __ptrauth_switch_to_host(struct kvm_vcpu *vcpu,
> +				 struct kvm_cpu_context *guest_ctxt,
> +				 struct kvm_cpu_context *host_ctxt)
> +{
> +	if (!__ptrauth_is_enabled(vcpu))
> +		return;
> +
> +	__ptrauth_save_state(guest_ctxt);
> +	__ptrauth_restore_state(host_ctxt);
> +}
> +
> +/**
> + * kvm_arm_vcpu_ptrauth_reset - resets ptrauth for vcpu schedule
> + *
> + * @vcpu: The VCPU pointer
> + *
> + * This function may be used to disable ptrauth and use it in a lazy context
> + * via traps. However host key registers are saved here as they dont change
> + * during host/guest switch.
> + */
> +void kvm_arm_vcpu_ptrauth_reset(struct kvm_vcpu *vcpu)

I feel this is not a good name.  It sounds too much like it resets the
registers as part of vcpu reset, whereas really it's doing something
completely different.

(Do you reset the regs anywhere btw?  I may have missed it...)

> +{
> +	struct kvm_cpu_context *host_ctxt;
> +
> +	if (kvm_supports_ptrauth()) {
> +		kvm_arm_vcpu_ptrauth_disable(vcpu);
> +		host_ctxt = vcpu->arch.host_cpu_context;
> +		__ptrauth_save_state(host_ctxt);
> +	}
> +}
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index a6c9381..12529df 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -986,6 +986,32 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	{ SYS_DESC(SYS_PMEVTYPERn_EL0(n)),					\
>  	  access_pmu_evtyper, reset_unknown, (PMEVTYPER0_EL0 + n), }
>  
> +
> +void kvm_arm_vcpu_ptrauth_enable(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.ctxt.hcr_el2 |= (HCR_API | HCR_APK);

Pedantic nit: surplus ().

(Although opinions differ, and keeping them looks more symmetric with
kvm_arm_vcpu_ptrauth_disable() -- either way, the code can stay as-is if
you prefer.)

> +}
> +
> +void kvm_arm_vcpu_ptrauth_disable(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->arch.ctxt.hcr_el2 &= ~(HCR_API | HCR_APK);
> +}
> +
> +static bool trap_ptrauth(struct kvm_vcpu *vcpu,
> +			 struct sys_reg_params *p,
> +			 const struct sys_reg_desc *rd)
> +{
> +	kvm_arm_vcpu_ptrauth_trap(vcpu);
> +	return false;

Can we ever get here?  Won't PAC traps always be handled via
handle_exit()?

Or can we also take sysreg access traps when the guest tries to access
the ptrauth key registers?

(I'm now wondering how this works for SVE.)

> +}
> +
> +#define __PTRAUTH_KEY(k)						\
> +	{ SYS_DESC(SYS_## k), trap_ptrauth, reset_unknown, k }
> +
> +#define PTRAUTH_KEY(k)							\
> +	__PTRAUTH_KEY(k ## KEYLO_EL1),					\
> +	__PTRAUTH_KEY(k ## KEYHI_EL1)
> +
>  static bool access_cntp_tval(struct kvm_vcpu *vcpu,
>  		struct sys_reg_params *p,
>  		const struct sys_reg_desc *r)
> @@ -1045,9 +1071,10 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
>  					 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
>  					 (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
>  					 (0xfUL << ID_AA64ISAR1_GPI_SHIFT);
> -		if (val & ptrauth_mask)
> +		if (!kvm_supports_ptrauth()) {

Don't we now always print this when ptrauth is not supported?

Previously we only printed a message in the interesting case, i.e.,
where the host supports ptrauch but we cannot offer it to the guest.

>  			kvm_debug("ptrauth unsupported for guests, suppressing\n");
> -		val &= ~ptrauth_mask;
> +			val &= ~ptrauth_mask;
> +		}
>  	} else if (id == SYS_ID_AA64MMFR1_EL1) {
>  		if (val & (0xfUL << ID_AA64MMFR1_LOR_SHIFT))
>  			kvm_debug("LORegions unsupported for guests, suppressing\n");
> @@ -1316,6 +1343,12 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
>  	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
>  
> +	PTRAUTH_KEY(APIA),
> +	PTRAUTH_KEY(APIB),
> +	PTRAUTH_KEY(APDA),
> +	PTRAUTH_KEY(APDB),
> +	PTRAUTH_KEY(APGA),
> +
>  	{ SYS_DESC(SYS_AFSR0_EL1), access_vm_reg, reset_unknown, AFSR0_EL1 },
>  	{ SYS_DESC(SYS_AFSR1_EL1), access_vm_reg, reset_unknown, AFSR1_EL1 },
>  	{ SYS_DESC(SYS_ESR_EL1), access_vm_reg, reset_unknown, ESR_EL1 },
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 2032a66..d7e003f 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -388,6 +388,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  		vcpu_clear_wfe_traps(vcpu);
>  	else
>  		vcpu_set_wfe_traps(vcpu);
> +
> +	kvm_arm_vcpu_ptrauth_reset(vcpu);
>  }
>  
>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> -- 
> 2.7.4
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
