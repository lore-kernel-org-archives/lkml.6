Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeBPINc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:13:32 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35163 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753806AbeBPINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:13:30 -0500
X-Google-Smtp-Source: AH8x226MgQhsA9/vK53WuTzM0di6YBSMzh1bXnYrAWsoY3IQggumbx/EMnpsHG7vBSEJgR3FTNov3Q==
Date: Fri, 16 Feb 2018 09:13:27 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
To: =?iso-8859-1?B?Suly6W15IEZhbmd16GRl?=
        <j.fanguede@virtualopensystems.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, tech@virtualopensystems.com
Subject: Re: [PATCH] KVM: arm: Enable emulation of the physical timer
Message-ID: <20180216081327.GA10440@cbox>
References: <1518518476-26645-1-git-send-email-j.fanguede@virtualopensystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518518476-26645-1-git-send-email-j.fanguede@virtualopensystems.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 11:41:16AM +0100, Jérémy Fanguède wrote:
> Set the handlers to emulate read and write operations for CNTP_CTL,
> CNTP_CVAL and CNTP_TVAL registers in such a way that VMs can use the
> physical timer.
> 
> Signed-off-by: Jérémy Fanguède <j.fanguede@virtualopensystems.com>
> ---
> 
> This patch is the equivalent of this one: [1], but for arm 32bits
> instead of ARMv8 aarch32.
> 
> [1] https://patchwork.kernel.org/patch/10207019/
> 

Thanks, both queued.

-Christoffer

> ---
>  arch/arm/kvm/coproc.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
> index 6d1d2e2..3a02e76 100644
> --- a/arch/arm/kvm/coproc.c
> +++ b/arch/arm/kvm/coproc.c
> @@ -270,6 +270,60 @@ static bool access_gic_sre(struct kvm_vcpu *vcpu,
>  	return true;
>  }
>  
> +static bool access_cntp_tval(struct kvm_vcpu *vcpu,
> +			     const struct coproc_params *p,
> +			     const struct coproc_reg *r)
> +{
> +	u64 now = kvm_phys_timer_read();
> +	u64 val;
> +
> +	if (p->is_write) {
> +		val = *vcpu_reg(vcpu, p->Rt1);
> +		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL, val + now);
> +	} else {
> +		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL);
> +		*vcpu_reg(vcpu, p->Rt1) = val - now;
> +	}
> +
> +	return true;
> +}
> +
> +static bool access_cntp_ctl(struct kvm_vcpu *vcpu,
> +			    const struct coproc_params *p,
> +			    const struct coproc_reg *r)
> +{
> +	u32 val;
> +
> +	if (p->is_write) {
> +		val = *vcpu_reg(vcpu, p->Rt1);
> +		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CTL, val);
> +	} else {
> +		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CTL);
> +		*vcpu_reg(vcpu, p->Rt1) = val;
> +	}
> +
> +	return true;
> +}
> +
> +static bool access_cntp_cval(struct kvm_vcpu *vcpu,
> +			     const struct coproc_params *p,
> +			     const struct coproc_reg *r)
> +{
> +	u64 val;
> +
> +	if (p->is_write) {
> +		val = (u64)*vcpu_reg(vcpu, p->Rt2) << 32;
> +		val |= *vcpu_reg(vcpu, p->Rt1);
> +		kvm_arm_timer_set_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL, val);
> +	} else {
> +		val = kvm_arm_timer_get_reg(vcpu, KVM_REG_ARM_PTIMER_CVAL);
> +		*vcpu_reg(vcpu, p->Rt1) = val;
> +		*vcpu_reg(vcpu, p->Rt2) = val >> 32;
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * We could trap ID_DFR0 and tell the guest we don't support performance
>   * monitoring.  Unfortunately the patch to make the kernel check ID_DFR0 was
> @@ -423,10 +477,17 @@ static const struct coproc_reg cp15_regs[] = {
>  	{ CRn(13), CRm( 0), Op1( 0), Op2( 4), is32,
>  			NULL, reset_unknown, c13_TID_PRIV },
>  
> +	/* CNTP */
> +	{ CRm64(14), Op1( 2), is64, access_cntp_cval},
> +
>  	/* CNTKCTL: swapped by interrupt.S. */
>  	{ CRn(14), CRm( 1), Op1( 0), Op2( 0), is32,
>  			NULL, reset_val, c14_CNTKCTL, 0x00000000 },
>  
> +	/* CNTP */
> +	{ CRn(14), CRm( 2), Op1( 0), Op2( 0), is32, access_cntp_tval },
> +	{ CRn(14), CRm( 2), Op1( 0), Op2( 1), is32, access_cntp_ctl },
> +
>  	/* The Configuration Base Address Register. */
>  	{ CRn(15), CRm( 0), Op1( 4), Op2( 0), is32, access_cbar},
>  };
> -- 
> 2.7.4
> 
