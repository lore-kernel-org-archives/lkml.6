Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeBBMdN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:33:13 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54518 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeBBMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:33:07 -0500
X-Google-Smtp-Source: AH8x224+NP0T/mxsleFedb7mtl1/EWiPpu+n74bhX0PYtughhqs9+BG1JjbwhAes85BMJTJV9BjX2A==
Date: Fri, 2 Feb 2018 13:33:03 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Jones <drjones@redhat.com>, Hanjun Guo <guohanjun@huawei.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jon Masters <jcm@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 03/18] arm64: KVM: Increment PC after handling an SMC
 trap
Message-ID: <20180202123303.GF21802@cbox>
References: <20180201114657.7323-1-marc.zyngier@arm.com>
 <20180201114657.7323-4-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201114657.7323-4-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 11:46:42AM +0000, Marc Zyngier wrote:
> When handling an SMC trap, the "preferred return address" is set
> to that of the SMC, and not the next PC (which is a departure from
> the behaviour of an SMC that isn't trapped).
> 
> Increment PC in the handler, as the guest is otherwise forever
> stuck...
> 

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

> Cc: stable@vger.kernel.org
> Fixes: acfb3b883f6d ("arm64: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/handle_exit.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 520b0dad3c62..5493bbefbd0d 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -62,7 +62,16 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  
>  static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> +	/*
> +	 * "If an SMC instruction executed at Non-secure EL1 is
> +	 * trapped to EL2 because HCR_EL2.TSC is 1, the exception is a
> +	 * Trap exception, not a Secure Monitor Call exception [...]"
> +	 *
> +	 * We need to advance the PC after the trap, as it would
> +	 * otherwise return to the same address...
> +	 */
>  	vcpu_set_reg(vcpu, 0, ~0UL);
> +	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
>  	return 1;
>  }
>  
> -- 
> 2.14.2
> 
