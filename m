Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935832AbeBUQ02 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:26:28 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932447AbeBUQ01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:26:27 -0500
Date: Wed, 21 Feb 2018 16:26:22 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: cpufeature: Trim feature reporting and include
 PAN emulation
Message-ID: <20180221162622.GC32331@e103592.cambridge.arm.com>
References: <20180220224624.GA28218@beast>
 <20180221111823.GB32331@e103592.cambridge.arm.com>
 <20180221143954.zlwau63wx75ixslv@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221143954.zlwau63wx75ixslv@salmiak>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 02:39:55PM +0000, Mark Rutland wrote:
> On Wed, Feb 21, 2018 at 11:18:27AM +0000, Dave Martin wrote:
> > On Tue, Feb 20, 2018 at 02:46:24PM -0800, Kees Cook wrote:
> > > The PAN emulation notification was only happening for non-boot CPUs
> > > if CPU capabilities had already been configured. This seems to be the
> > > wrong place, as it's system-wide and isn't attached to capabilities,
> > > so its reporting didn't normally happen. Instead, report it once from
> > > the boot CPU. Additionally removes the redundant "feature" word from the
> > > "CPU features:" line.
> > > 
> > > Before (redundant "feature", and missing PAN emulation report):
> > > 
> > >  SMP: Total of 4 processors activated.
> > >  CPU features: detected feature: 32-bit EL0 Support
> > >  CPU features: detected feature: Kernel page table isolation (KPTI)
> > >  CPU: All CPU(s) started at EL2
> > > 
> > > After:
> > > 
> > >  SMP: Total of 4 processors activated.
> > >  CPU features: detected: 32-bit EL0 Support
> > >  CPU features: detected: Kernel page table isolation (KPTI)
> > >  CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
> > >  CPU: All CPU(s) started at EL2
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  arch/arm64/kernel/cpufeature.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 29b1f873e337..6c799ca58b53 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -1333,9 +1333,6 @@ static void verify_local_cpu_capabilities(void)
> > >  
> > >  	if (system_supports_sve())
> > >  		verify_sve_features();
> > > -
> > > -	if (system_uses_ttbr0_pan())
> > > -		pr_info("Emulating Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
> > >  }
> > >  
> > >  void check_local_cpu_capabilities(void)
> > > @@ -1360,7 +1357,7 @@ void check_local_cpu_capabilities(void)
> > >  
> > >  static void __init setup_feature_capabilities(void)
> > >  {
> > > -	update_cpu_capabilities(arm64_features, "detected feature:");
> > > +	update_cpu_capabilities(arm64_features, "detected:");
> > 
> > Although I get what you're saying about redundant use of the word
> > "features", this feels like cosmetic churn that is unrelated to the
> > problem this patch is addressing.
> 
> Given it seems sensible, shall we just split that into a separate patch? 

Can do, though I still think it's a bit dubious.  The original message
as it stands isn't wrong.  I won't lose sleep over it though.

[...]

Cheers
---Dave
