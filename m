Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933717AbeCHRLi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:11:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932100AbeCHRLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:11:36 -0500
Date: Thu, 8 Mar 2018 17:11:40 +0000
From: Will Deacon <will.deacon@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, james.morse@arm.com
Subject: Re: [PATCH v2 1/2] arm64: Relax constraints on ID feature bits
Message-ID: <20180308171140.GA14918@arm.com>
References: <20180207142106.10716-1-suzuki.poulose@arm.com>
 <20180226180517.GG26147@arm.com>
 <1a293722-60ff-0e6f-0c57-b257a2880741@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a293722-60ff-0e6f-0c57-b257a2880741@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 03:11:31PM +0000, Suzuki K Poulose wrote:
> On 26/02/18 18:05, Will Deacon wrote:
> >On Wed, Feb 07, 2018 at 02:21:05PM +0000, Suzuki K Poulose wrote:
> >>We treat most of the feature bits in the ID registers as STRICT,
> >>implying that all CPUs should match it the boot CPU state. However,
> >>for most of the features, we can handle if there are any mismatches
> >>by using the safe value. e.g, HWCAPs and other features used by the
> >>kernel. Relax the constraint on the feature bits whose mismatch can
> >>be handled by the kernel.
> >>
> >>For VHE, if there is a mismatch we don't care if the kernel is
> >>not using it. If the kernel is indeed running in EL2 mode, then
> >>the mismatches results in a panic. Similarly for ASID bits we
> >>take care of conflicts.
> >>
> >>For other features like, PAN, UAO we only enable it only if we
> >>have it on all the CPUs. For IESB, we set the SCTLR bit unconditionally
> >>anyways.
> >>
> >>For features that aren't currently used by kernel
> >>  (e.g ID_AA64MFMR1:{LOR,HPD}, ID_AA64MMFR2:LSM) make them NONSTRICT.
> >>
> >>Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>Cc: Mark Rutland <mark.rutland@arm.com>
> >>Cc: Marc Zyngier <marc.zyngier@arm.com>
> >>Cc: Will Deacon <will.deacon@arm.com>
> >>Cc: James Morse <james.morse@arm.com>
> >>Cc: Dave Martin <dave.martin@arm.com>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>Changes since v1:
> >>  - Make ID_AA64MMFR1_EL1:LOR/HPD, ID_AA64MMFR1_EL1:LSM non-strict
> >>    as they aren't used by the kernel.
> >>  - Added comments around different fields.
> >>  - Make ID_AA64MMFR2:CNP non-strict, as we could decide to use it
> >>    only when it is available on all the CPUs.
> >
> >This does mean we need to be careful when adding support for a new feature
> >because the cpufeature code is no longer guaranteeing homogeneity. I can't
> >see how we can detect this, so I suppose we'll just need to be careful to
> >pick this up during review.
> >
> >It's also a bit nasty that older kernels won't shout about mismatched
> >features but a new kernel might.
> 
> That is not correct. It is the opposite. The new kernel won't shout about
> mismatched features, where the old kernel complains.

What I mean is, with your patches applied, it's likely that the kernel won't
shout about mismatched features. If we ever change something in future that
results in us requiring STRICT matching (perhaps supporting a new version of
a feature), then we're introducing a taint which wasn't there before. Maybe
not a big deal, but I'm not sold on the rationale for this patch.

> I have a slight concern that this means
> >integration problems might slip through the cracks when a design is
> >validating against an older kernel.
> >
> >Finally, there's still the problem that some features cannot be
> >enabled/disabled by the kernel and we can end up in a position where a
> >user application might SIGILL only on some CPUs if it's using an instruction
> >that isn't supported across the whole system. I think that sort of
> >configuration *does* warrant the current sanity check message/taint; afaict
> >we still go ahead and use the safe value, clobbering things like the hwcap,
> >but we should draw attention to the fact that userspace might crash if it's
> >trying to probe for these instructions using traps.
> 
> The FTR_STRICT only affects whether we should issue a WARNING and TAINT the kernel
> if there is a mismatch. It doesn't affect the "safe" value calculation. So,
> I don't understand how the above situation can be triggered by this change.

I'm saying that I think the taint is justified.

Will
