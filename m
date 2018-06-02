Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeFBJix (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 05:38:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60568 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeFBJiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 05:38:52 -0400
Date: Sat, 2 Jun 2018 10:38:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: linux-next-20180601: build error in
 arch/arm64/kvm/hyp/hyp-entry.S
Message-ID: <20180602093846.hgc2zu52hp66ylrz@armageddon.cambridge.arm.com>
References: <457305318.78169.1527883507093@email.1und1.de>
 <20180601212619.6trmvqrgmbczekkt@armageddon.cambridge.arm.com>
 <86h8mla92t.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86h8mla92t.wl-marc.zyngier@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 02, 2018 at 09:25:46AM +0100, Marc Zyngier wrote:
> On Fri, 01 Jun 2018 22:26:19 +0100,
> Catalin Marinas wrote:
> > On Fri, Jun 01, 2018 at 10:05:07PM +0200, Stefan Wahren wrote:
> > > i can't build todays linux-next-20180601 and get the following error message:
> > > 
> > > arch/arm64/kvm/hyp/hyp-entry.S: Assembler messages:
> > > arch/arm64/kvm/hyp/hyp-entry.S:128: Error: constant expression required at operand 3 -- `bfi x0,x1,#VCPU_WORKAROUND_2_FLAG_SHIFT,#1'
> > > 
> > > Related commit:
> > > arm64: KVM: Handle guest's ARCH_WORKAROUND_2 requests
> > > 
> > > Toolchain: gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu
> > > Kernel config: arm64/defconfig
> > 
> > Thanks for reporting this.
> > 
> > I can hit this as well. It looks like an #ifndef __ASSEMBLY__ in the
> > wrong place in arch/arm64/include/asm/kvm_asm.h. I can't tell whether it
> > was caused by a merge conflict resolution or just some unfortunate
> > interaction between the security fixes going via the arm64 tree and the
> > other arm64 KVM patches.
> 
> The merge between 55e3748e8902 in the arm64 tree, and both
> fa89d31c5306 and 46c4a30b0b16 in the kvmarm tree has resulted in a
> slight mis-merge which I didn't spot yesterday. Apologies for not
> realising this myself.
> 
> Stephen, could you please add the following patchlet as a resolution
> of the merge?
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index c5246d80b857..a169f3a88148 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -30,13 +30,13 @@
>  /* The hyp-stub will return this for any kvm_call_hyp() call */
>  #define ARM_EXCEPTION_HYP_GONE	  HVC_STUB_ERR
>  
> +#define	VCPU_WORKAROUND_2_FLAG_SHIFT	0
> +#define	VCPU_WORKAROUND_2_FLAG		(_AC(1, UL) << VCPU_WORKAROUND_2_FLAG_SHIFT)
> +
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/mm.h>
>  
> -#define	VCPU_WORKAROUND_2_FLAG_SHIFT	0
> -#define	VCPU_WORKAROUND_2_FLAG		(_AC(1, UL) << VCPU_WORKAROUND_2_FLAG_SHIFT)
> -
>  /* Translate a kernel address of @sym into its equivalent linear mapping */
>  #define kvm_ksym_ref(sym)						\
>  	({								\
> 
> Catalin: Alternatively, you could add a patch on top of the arm64
> branch, moving these two defines to the top of the file, avoiding the
> conflict altogether.

I'll move them to the top of the file. Thanks for checking this.

-- 
Catalin
