Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeBHMIO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:08:14 -0500
Received: from foss.arm.com ([217.140.101.70]:34012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeBHMIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:08:13 -0500
Subject: Re: [PATCH] KVM: arm64: Enable the EL1 physical timer for AArch32
 guests
To: =?UTF-8?B?SsOpcsOpbXkgRmFuZ3XDqGRl?=
        <j.fanguede@virtualopensystems.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc: tech@virtualopensystems.com,
        Alvise Rigo <a.rigo@virtualopensystems.com>
References: <1518091039-17356-1-git-send-email-j.fanguede@virtualopensystems.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <51fa6f87-4d4d-0c14-9fb0-6ce0d2808ce3@arm.com>
Date: Thu, 8 Feb 2018 12:08:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518091039-17356-1-git-send-email-j.fanguede@virtualopensystems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/18 11:57, Jérémy Fanguède wrote:
> Some 32bits guest OS can use the CNTP timer, however KVM does not
> handle the accesses, injecting a fault instead.
> 
> Use the proper handlers to emulate the EL1 Physical Timer (CNTP)
> register accesses of AArch32 guests.
> 
> Signed-off-by: Jérémy Fanguède <j.fanguede@virtualopensystems.com>
> Signed-off-by: Alvise Rigo <a.rigo@virtualopensystems.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 50a43c7..c0ab4f7 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1545,6 +1545,11 @@ static const struct sys_reg_desc cp15_regs[] = {
>  
>  	{ Op1( 0), CRn(13), CRm( 0), Op2( 1), access_vm_reg, NULL, c13_CID },
>  
> +	/* CNTP_TVAL */
> +	{ Op1( 0), CRn(14), CRm( 2), Op2( 0), access_cntp_tval },
> +	/* CNTP_CTL */
> +	{ Op1( 0), CRn(14), CRm( 2), Op2( 1), access_cntp_ctl },
> +
>  	/* PMEVCNTRn */
>  	PMU_PMEVCNTR(0),
>  	PMU_PMEVCNTR(1),
> @@ -1618,6 +1623,7 @@ static const struct sys_reg_desc cp15_64_regs[] = {
>  	{ Op1( 0), CRn( 0), CRm( 9), Op2( 0), access_pmu_evcntr },
>  	{ Op1( 0), CRn( 0), CRm(12), Op2( 0), access_gic_sgi },
>  	{ Op1( 1), CRn( 0), CRm( 2), Op2( 0), access_vm_reg, NULL, c2_TTBR1 },
> +	{ Op1( 2), CRn( 0), CRm(14), Op2( 0), access_cntp_cval },
>  };
>  
>  /* Target specific emulation tables */
> 

Seems OK to me. Can you please update the corresponding 32bit code while
you're at it?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
