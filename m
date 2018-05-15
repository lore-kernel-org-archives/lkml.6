Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbeEOQd6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:33:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750810AbeEOQd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:33:57 -0400
Date: Tue, 15 May 2018 17:33:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/18] arm64: move sve_user_{enable, disable} to
 <asm/fpsimd.h>
Message-ID: <20180515163352.sl7sfaswv4hsktl7@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-7-mark.rutland@arm.com>
 <20180514110649.GC7753@e103592.cambridge.arm.com>
 <20180515103936.v5ytofdq3qqtsomn@lakrids.cambridge.arm.com>
 <20180515121921.GN7753@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515121921.GN7753@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 01:19:26PM +0100, Dave Martin wrote:
> On Tue, May 15, 2018 at 11:39:36AM +0100, Mark Rutland wrote:
> > On Mon, May 14, 2018 at 12:06:50PM +0100, Dave Martin wrote:
> > > On Mon, May 14, 2018 at 10:46:28AM +0100, Mark Rutland wrote:
> > > > +static inline void sve_user_disable(void)
> > > > +{
> > > > +	sysreg_clear_set(cpacr_el1, CPACR_EL1_ZEN_EL0EN, 0);
> > > > +}
> > > > +
> > > > +static inline void sve_user_enable(void)
> > > > +{
> > > > +	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Probing and setup functions.
> > > >   * Calls to these functions must be serialised with one another.
> > > > @@ -107,6 +119,9 @@ static inline int sve_get_current_vl(void)
> > > >  	return -EINVAL;
> > > >  }
> > > >  
> > > > +static inline void sve_user_disable(void) { }
> > > > +static inline void sve_user_enable(void) { }
> > > > +
> > > 
> > > Alternatively, just move the full definitions outside the #ifdef
> > > CONFIG_ARM64_SVE.
> > 
> > Can do, though I was trying to keep the exsting pattern with empty
> > inlines for the !CONFIG_ARM64_SVE case.
> 
> There isn't really a pattern.  I tried to avoid dummy versions where
> there's no real reason to have them.  I don't _think_ they're really
> needed here, unless I missed something.  Did you get build failures
> without them?

I need *some* definition so that sve_user_reset() in the syscall path
can compile without ifdeferry. 

In sve_user_reset() I first check system_supports_sve(), which checks
IS_ENABLED(CONFIG_ARM64_SVE), so the call should be optimised away when
!CONFIG_ARM64_SVE, but I need a prototype regardless.

> > > All calls to these should be shadowed by an if
> > > (system_supports_sve()) in any case, and setting/clearing ZEN_EL0EN
> > > in the CPACR_EL1 ought to be harmless now that the meaning of these
> > > bits architecturally committed.
> > > 
> > > Ideally we would have a BUG_ON(!system_supports_sve()) in those
> > > functions, but we won't won't to pay the cost in a production kernel.
> > 
> > Earlier I'd put BUILD_BUG() in the body for the !CONFIG_ARM64_SVE case,
> > to catch that kind of thing -- I could restore that.
> 
> IIUC:
> 
> 	if (0) {
> 		BUILD_BUG_ON(1);
> 	}
> 
> can still fire, in which case it's futile checking for CONFIG_ARM64_SVE
> in most of the SVE support code.

We already rely on BUILD_BUG() not firing in paths that can be trivially
optimized away. e.g. in the cmpxchg code.
 
> > > >  static inline void sve_init_vq_map(void) { }
> > > >  static inline void sve_update_vq_map(void) { }
> > > >  static inline int sve_verify_vq_map(void) { return 0; }
> > > > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > > > index 088940387a4d..79a81c7d85c6 100644
> > > > --- a/arch/arm64/kernel/fpsimd.c
> > > > +++ b/arch/arm64/kernel/fpsimd.c
> > > > @@ -159,7 +159,6 @@ static void sve_free(struct task_struct *task)
> > > >  	__sve_free(task);
> > > >  }
> > > >  
> > > > -
> > > 
> > > Hmmm, Ack.  Check for conflicts with the KVM FPSIMD rework [1] (though
> > > trivial).
> > 
> > I'll assume that Ack stands regardless. :)
> 
> Actually, I was just commenting on the deleted blank line... 

Ah. I've restored that now.

Thanks,
Mark.
