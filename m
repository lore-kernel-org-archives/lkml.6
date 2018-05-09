Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935089AbeEIO16 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:27:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35374 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934617AbeEIO14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:27:56 -0400
X-Google-Smtp-Source: AB8JxZq9qOQVMsk9kfNyFyp4OaBd946U+IYDAVE1V0M4wdZKm3sQ/CTvhWTCZqgniR8p77Sd7L0RKg==
Date: Wed, 9 May 2018 15:27:52 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Julien Thierry <julien.thierry@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, marc.zyngier@arm.com, james.morse@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 2/6] arm64: alternative: Apply alternatives early in
 boot process
Message-ID: <20180509142752.redewrpymwvuzgbv@holly.lan>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <1516190084-18978-3-git-send-email-julien.thierry@arm.com>
 <c935a9e6-94a0-03cb-eb64-7e2eef8f8d86@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c935a9e6-94a0-03cb-eb64-7e2eef8f8d86@arm.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 11:06:56AM +0100, Julien Thierry wrote:
> Hi,
> 
> In order to prepare the v3 of this patchset, I'd like people's opinion on
> what this patch does. More below.
> 
> On 17/01/18 11:54, Julien Thierry wrote:
> > From: Daniel Thompson <daniel.thompson@linaro.org>
> > 
> > Currently alternatives are applied very late in the boot process (and
> > a long time after we enable scheduling). Some alternative sequences,
> > such as those that alter the way CPU context is stored, must be applied
> > much earlier in the boot sequence.
> > 
> > Introduce apply_alternatives_early() to allow some alternatives to be
> > applied immediately after we detect the CPU features of the boot CPU.
> > 
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >   arch/arm64/include/asm/alternative.h |  1 +
> >   arch/arm64/kernel/alternative.c      | 39 +++++++++++++++++++++++++++++++++---
> >   arch/arm64/kernel/smp.c              |  6 ++++++
> >   3 files changed, 43 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> > index 4a85c69..1fc1cdb 100644
> > --- a/arch/arm64/include/asm/alternative.h
> > +++ b/arch/arm64/include/asm/alternative.h
> > @@ -20,6 +20,7 @@ struct alt_instr {
> >   	u8  alt_len;		/* size of new instruction(s), <= orig_len */
> >   };
> > 
> > +void __init apply_alternatives_early(void);
> >   void __init apply_alternatives_all(void);
> >   void apply_alternatives(void *start, size_t length);
> > 
> > diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> > index 6dd0a3a3..78051d4 100644
> > --- a/arch/arm64/kernel/alternative.c
> > +++ b/arch/arm64/kernel/alternative.c
> > @@ -28,6 +28,18 @@
> >   #include <asm/sections.h>
> >   #include <linux/stop_machine.h>
> > 
> > +/*
> > + * early-apply features are detected using only the boot CPU and checked on
> > + * secondary CPUs startup, even then,
> > + * These early-apply features should only include features where we must
> > + * patch the kernel very early in the boot process.
> > + *
> > + * Note that the cpufeature logic *must* be made aware of early-apply
> > + * features to ensure they are reported as enabled without waiting
> > + * for other CPUs to boot.
> > + */
> > +#define EARLY_APPLY_FEATURE_MASK BIT(ARM64_HAS_SYSREG_GIC_CPUIF)
> > +
> 
> Following the change in the cpufeature infrastructure,
> ARM64_HAS_SYSREG_GIC_CPUIF will have the scope ARM64_CPUCAP_SCOPE_BOOT_CPU
> in order to be checked early in the boot process.
> 
> Now, regarding the early application of alternative, I am wondering whether
> we can apply all the alternatives associated with SCOPE_BOOT features that
> *do not* have a cpu_enable callback.
> 
> Otherwise we can keep the macro to list individually each feature that is
> patchable at boot time as the current patch does (or put this info in a flag
> within the arm64_cpu_capabilities structure).
> 
> Any thoughts or preferences on this?

If I understand ARM64_CPUCAP_SCOPE_BOOT_CPU correctly it certainly seems
safe to apply the alternatives early (it means that a CPU that 
contradicts a CSCOPE_BOOT_CPU won't be allowed to join the system,
right?).

It also makes the system to apply errata fixes more powerful: maybe a
future errata must be applied before we commence threading.

This I have a preference for striping this out and relying on
SCOPE_BOOT_CPU instead. It's a weak preference though since I haven't
studied exactly what errate fixes this will bring into the scope of
early boot.

I don't think you'll regret changing it. This patch has always been
a *total* PITA to rebase so aligning it better with upstream will make
it easier to nurse the patch set until the if-and-when point it hits
the upstream.


Daniel.




> Thanks,
> 
> >   #define __ALT_PTR(a,f)		((void *)&(a)->f + (a)->f)
> >   #define ALT_ORIG_PTR(a)		__ALT_PTR(a, orig_offset)
> >   #define ALT_REPL_PTR(a)		__ALT_PTR(a, alt_offset)
> > @@ -105,7 +117,8 @@ static u32 get_alt_insn(struct alt_instr *alt, __le32 *insnptr, __le32 *altinsnp
> >   	return insn;
> >   }
> > 
> > -static void __apply_alternatives(void *alt_region, bool use_linear_alias)
> > +static void __apply_alternatives(void *alt_region,  bool use_linear_alias,
> > +				 unsigned long feature_mask)
> >   {
> >   	struct alt_instr *alt;
> >   	struct alt_region *region = alt_region;
> > @@ -115,6 +128,9 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
> >   		u32 insn;
> >   		int i, nr_inst;
> > 
> > +		if ((BIT(alt->cpufeature) & feature_mask) == 0)
> > +			continue;
> > +
> >   		if (!cpus_have_cap(alt->cpufeature))
> >   			continue;
> > 
> > @@ -138,6 +154,21 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
> >   }
> > 
> >   /*
> > + * This is called very early in the boot process (directly after we run
> > + * a feature detect on the boot CPU). No need to worry about other CPUs
> > + * here.
> > + */
> > +void apply_alternatives_early(void)
> > +{
> > +	struct alt_region region = {
> > +		.begin	= (struct alt_instr *)__alt_instructions,
> > +		.end	= (struct alt_instr *)__alt_instructions_end,
> > +	};
> > +
> > +	__apply_alternatives(&region, true, EARLY_APPLY_FEATURE_MASK);
> > +}
> > +
> > +/*
> >    * We might be patching the stop_machine state machine, so implement a
> >    * really simple polling protocol here.
> >    */
> > @@ -156,7 +187,9 @@ static int __apply_alternatives_multi_stop(void *unused)
> >   		isb();
> >   	} else {
> >   		BUG_ON(patched);
> > -		__apply_alternatives(&region, true);
> > +
> > +		__apply_alternatives(&region, true, ~EARLY_APPLY_FEATURE_MASK);
> > +
> >   		/* Barriers provided by the cache flushing */
> >   		WRITE_ONCE(patched, 1);
> >   	}
> > @@ -177,5 +210,5 @@ void apply_alternatives(void *start, size_t length)
> >   		.end	= start + length,
> >   	};
> > 
> > -	__apply_alternatives(&region, false);
> > +	__apply_alternatives(&region, false, -1);
> >   }
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 551eb07..37361b5 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -453,6 +453,12 @@ void __init smp_prepare_boot_cpu(void)
> >   	 * cpuinfo_store_boot_cpu() above.
> >   	 */
> >   	update_cpu_errata_workarounds();
> > +	/*
> > +	 * We now know enough about the boot CPU to apply the
> > +	 * alternatives that cannot wait until interrupt handling
> > +	 * and/or scheduling is enabled.
> > +	 */
> > +	apply_alternatives_early();
> >   }
> > 
> >   static u64 __init of_get_cpu_mpidr(struct device_node *dn)
> > --
> > 1.9.1
> > 
> 
> -- 
> Julien Thierry
