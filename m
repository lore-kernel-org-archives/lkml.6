Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBHRcf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:32:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37952 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752020AbeBHRce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:32:34 -0500
Date: Thu, 8 Feb 2018 17:32:30 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: capabilities: Allow flexibility in scope
Message-ID: <20180208173229.GA5862@e103592.cambridge.arm.com>
References: <86f23003-72bc-5bfc-af40-a92cc68def45@arm.com>
 <20180208121238.18792-1-suzuki.poulose@arm.com>
 <20180208161015.GZ5862@e103592.cambridge.arm.com>
 <08474a1a-3abd-9b89-ce75-d01e4b6fa659@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08474a1a-3abd-9b89-ce75-d01e4b6fa659@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 04:31:47PM +0000, Suzuki K Poulose wrote:
> On 08/02/18 16:10, Dave Martin wrote:
> >On Thu, Feb 08, 2018 at 12:12:37PM +0000, Suzuki K Poulose wrote:
> >>So far we have restricted the scopes for the capabilities
> >>as follows :
> >>  1) Errata workaround check are run all CPUs (i.e, always
> >>     SCOPE_LOCAL_CPU)
> >>  2) Arm64 features are run only once after the sanitised
> >>     feature registers are available using the SCOPE_SYSTEM.
> >>
> >>This prevents detecting cpu features that can be detected
> >>on one or more CPUs with SCOPE_LOCAL_CPU (e.g KPTI). Similarly
> >>for errata workaround with SCOPE_SYSTEM.
> >>
> >>This patch makes sure that we allow flexibility of having
> >>any scope for a capability. So, we now run through both
> >>arm64_features and arm64_errata in two phases for detection:
> >>
> >>  a) with SCOPE_LOCAL_CPU filter on each boot time enabled
> >>     CPUs.
> >>  b) with SCOPE_SYSTEM filter only once after all boot time
> >>     enabled CPUs are active.
> >>
> 
> 
> >>  static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
> >>@@ -1387,13 +1389,15 @@ static void verify_local_cpu_errata_workarounds(void)
> >>  static void update_cpu_errata_workarounds(void)
> >>  {
> >>  	update_cpu_capabilities(arm64_errata,
> >>-				ARM64_CPUCAP_SCOPE_ALL,
> >>+				ARM64_CPUCAP_SCOPE_LOCAL_CPU,
> >
> >In isolation, this looks strange because it seems to handle only a
> >subset of arm64_errata now.
> >
> >I think I understand the change as follows:
> >
> >  * all previously-existing errata workarounds SCOPE_LOCAL_CPU
> >    anyway, so the behavior here doesn't change for any existing
> >    caps;
> >
> >  * the non SCOPE_SYSTEM workarounds (which this patch prepares for)
> "the SCOPE_SYSTEM" workarounds..."
> 
> >    are handled by the new setup_errata_workaround() path.
> 
> >
> >Similarly, the features handling is split into two: one mirroring
> >the current behaviour (for SCOPE_SYSTEM this time) and one handling> the rest, for supporting SCOPE_CPU_LOCAL features in subsequent
> >patches.
> 
> Right. The changes here are :
> 
> New behavior:
>   - Run SCOPE_LOCAL_CPU filter on arm64_features on all CPUs (newly added with
>     this patch) via (newly added)update_cpu_local_features().
> 
> Split of existing behavior:
>   - Run SCOPE_LOCAL_CPU(instead of the earlier SCOPE_ALL) on all CPUs in
>     update_cpu_errata_workarounds()
>   - Run SCOPE_SYSTEM filter on arm64_errata, once, via setup_errata_workarounds()

OK, thanks for confirming.

[...]

> >I'm not sure we need extra comments or documentation; I just want
> >to check that I've understood the patch correctly.
> 
> So, would you prefer this split to the original patch ?

I think splitting out this patch (1/2) makes sense.


For the second part (2/2) of the split, I still find that hard to
review.  The commit message suggests trivially obvious refactoring
only, but I think there are three things going on:

 1) moving functions around (with the intention of merging them)
 2) merging functions together
 3) other miscellaneous bits of refactoring, and cleanups that become
    "obvious" after steps (1) and (2).

The refactoring is likely straightfoward, but the resulting diff is
not (at least, I struggle to read it).

Could you split the second part along the lines if (1)..(3) above?
I think that would make for much easier review.  (Sorry to be a pain!)

Also, the second patch leaves at least one function that does nothing
except call a second function that has no other caller.  It may do
no harm to remove and inline any such function.  (Falls under (3),
I guess.)

Cheers
---Dave
