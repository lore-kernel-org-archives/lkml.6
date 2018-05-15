Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeEOMTd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:19:33 -0400
Received: from foss.arm.com ([217.140.101.70]:59478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752421AbeEOMTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:19:31 -0400
Date: Tue, 15 May 2018 13:19:26 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/18] arm64: move sve_user_{enable, disable} to
 <asm/fpsimd.h>
Message-ID: <20180515121921.GN7753@e103592.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-7-mark.rutland@arm.com>
 <20180514110649.GC7753@e103592.cambridge.arm.com>
 <20180515103936.v5ytofdq3qqtsomn@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515103936.v5ytofdq3qqtsomn@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 11:39:36AM +0100, Mark Rutland wrote:
> On Mon, May 14, 2018 at 12:06:50PM +0100, Dave Martin wrote:
> > On Mon, May 14, 2018 at 10:46:28AM +0100, Mark Rutland wrote:
> > > In subsequent patches, we'll want to make use of sve_user_enable() and
> > > sve_user_disable() outside of kernel/fpsimd.c. Let's move these to
> > > <asm/fpsimd.h> where we can make use of them.
> > > 
> > > To avoid ifdeffery in sequences like:
> > > 
> > > if (system_supports_sve() && some_condition
> > > 	sve_user_disable();
> > > 
> > > ... empty stubs are provided when support for SVE is not enabled.
> > > 
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Dave Martin <dave.martin@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm64/include/asm/fpsimd.h | 17 ++++++++++++++++-
> > >  arch/arm64/kernel/fpsimd.c      | 11 -----------
> > >  2 files changed, 16 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> > > index aa7162ae93e3..7377d7593c06 100644
> > > --- a/arch/arm64/include/asm/fpsimd.h
> > > +++ b/arch/arm64/include/asm/fpsimd.h
> > > @@ -16,11 +16,13 @@
> > >  #ifndef __ASM_FP_H
> > >  #define __ASM_FP_H
> > >  
> > > -#include <asm/ptrace.h>
> > >  #include <asm/errno.h>
> > > +#include <asm/ptrace.h>
> > > +#include <asm/sysreg.h>
> > >  
> > >  #ifndef __ASSEMBLY__
> > >  
> > > +#include <linux/build_bug.h>
> > >  #include <linux/cache.h>
> > >  #include <linux/init.h>
> > >  #include <linux/stddef.h>
> > > @@ -81,6 +83,16 @@ extern int sve_set_vector_length(struct task_struct *task,
> > >  extern int sve_set_current_vl(unsigned long arg);
> > >  extern int sve_get_current_vl(void);
> > >  
> > > +static inline void sve_user_disable(void)
> > > +{
> > > +	sysreg_clear_set(cpacr_el1, CPACR_EL1_ZEN_EL0EN, 0);
> > > +}
> > > +
> > > +static inline void sve_user_enable(void)
> > > +{
> > > +	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
> > > +}
> > > +
> > >  /*
> > >   * Probing and setup functions.
> > >   * Calls to these functions must be serialised with one another.
> > > @@ -107,6 +119,9 @@ static inline int sve_get_current_vl(void)
> > >  	return -EINVAL;
> > >  }
> > >  
> > > +static inline void sve_user_disable(void) { }
> > > +static inline void sve_user_enable(void) { }
> > > +
> > 
> > Alternatively, just move the full definitions outside the #ifdef
> > CONFIG_ARM64_SVE.
> 
> Can do, though I was trying to keep the exsting pattern with empty
> inlines for the !CONFIG_ARM64_SVE case.

There isn't really a pattern.  I tried to avoid dummy versions where
there's no real reason to have them.  I don't _think_ they're really
needed here, unless I missed something.  Did you get build failures
without them?

> > All calls to these should be shadowed by an if
> > (system_supports_sve()) in any case, and setting/clearing ZEN_EL0EN
> > in the CPACR_EL1 ought to be harmless now that the meaning of these
> > bits architecturally committed.
> > 
> > Ideally we would have a BUG_ON(!system_supports_sve()) in those
> > functions, but we won't won't to pay the cost in a production kernel.
> 
> Earlier I'd put BUILD_BUG() in the body for the !CONFIG_ARM64_SVE case,
> to catch that kind of thing -- I could restore that.

IIUC:

	if (0) {
		BUILD_BUG_ON(1);
	}

can still fire, in which case it's futile checking for CONFIG_ARM64_SVE
in most of the SVE support code.

Anyway, CONFIG_ARM64_SVE doesn't capture the whole condition.

> 
> > >  static inline void sve_init_vq_map(void) { }
> > >  static inline void sve_update_vq_map(void) { }
> > >  static inline int sve_verify_vq_map(void) { return 0; }
> > > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > > index 088940387a4d..79a81c7d85c6 100644
> > > --- a/arch/arm64/kernel/fpsimd.c
> > > +++ b/arch/arm64/kernel/fpsimd.c
> > > @@ -159,7 +159,6 @@ static void sve_free(struct task_struct *task)
> > >  	__sve_free(task);
> > >  }
> > >  
> > > -
> > 
> > Hmmm, Ack.  Check for conflicts with the KVM FPSIMD rework [1] (though
> > trivial).
> 
> I'll assume that Ack stands regardless. :)

Actually, I was just commenting on the deleted blank line...  not that
there is any massive issue with this patch, though.

Cheers
---Dave
