Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeBIKFW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:05:22 -0500
Received: from foss.arm.com ([217.140.101.70]:45006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbeBIKFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:05:21 -0500
Date: Fri, 9 Feb 2018 10:05:16 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 16/20] arm64: Handle shared capability entries
Message-ID: <20180209100512.GB5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-17-suzuki.poulose@arm.com>
 <20180207103934.GG5862@e103592.cambridge.arm.com>
 <831ad839-3c68-fc1e-d578-f951b46ed6ed@arm.com>
 <20180208120114.GX5862@e103592.cambridge.arm.com>
 <c10b7441-4643-4277-c6fc-a205f3687673@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10b7441-4643-4277-c6fc-a205f3687673@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 12:32:56PM +0000, Robin Murphy wrote:
> On 08/02/18 12:01, Dave Martin wrote:
> >On Thu, Feb 08, 2018 at 10:53:52AM +0000, Suzuki K Poulose wrote:
> >>On 07/02/18 10:39, Dave Martin wrote:
> >>>On Wed, Jan 31, 2018 at 06:28:03PM +0000, Suzuki K Poulose wrote:
> >>>>Some capabilities have different criteria for detection and associated
> >>>>actions based on the matching criteria, even though they all share the
> >>>>same capability bit. So far we have used multiple entries with the same
> >>>>capability bit to handle this. This is prone to errors, as the
> >>>>cpu_enable is invoked for each entry, irrespective of whether the
> >>>>detection rule applies to the CPU or not. And also this complicates
> >>>>other helpers, e.g, __this_cpu_has_cap.
> >>>>
> >>>>This patch adds a wrapper entry to cover all the possible variations
> >>>>of a capability and ensures :
> >>>>  1) The capabilitiy is set when at least one of the entry detects
> >>>>  2) Action is only taken for the entries that detects.
> >>>
> >>>I guess this means that where we have a single cpu_enable() method
> >>>but complex match criteria that require multiple entries, then that
> >>>cpu_enable() method might get called multiple times on a given CPU.
> >>
> >>A CPU executes cpu_enable() only for the "matching" entries in the list,
> >>unlike earlier. So as long as there is a single entry "matching" the given
> >>CPU, the cpu_enable() will not be duplicated. May be we *should* mandate
> >>that a CPU cannot be matched by multiple entries.
> >>
> >>>
> >>>Could be worth a comment if cpu_enable() methods must be robust
> >>>against this.
> >
> >Could we say something like:
> >
> >"Where a single capability has multiple entries, mutiple cpu_enable()
> >methods may be called if more than one entry matches.  Where this is
> >not desired, care should be taken to ensure that the entries are
> >mutually exclusive: for example, two entries for a single capability
> >that match on MIDR should be configured to match MIDR ranges that do
> >not overlap."
> >
> >This is more verbose than I would like however.  Maybe there's a simpler
> >way to say it.
> 
> If we're not also talking about a capability having mutually exclusive
> enable methods (it doesn't seem so, but I'm not necessarily 100% clear), how
> about:
> 
> "If a cpu_enable() method is associated with multiple matches for a single
> capability, care should be taken that either the match criteria are mutually
> exclusive, or that the method is robust against being called multiple
> times."

This is one reason why I wondered if we could pull cpu_enable() out of
the match criteria struct so that we don't duplicate it: in that case
there's no chance of multiple incompatible cpu_enable() methods.

But Suzuki is right that this would be a somewhat invasive change at
this point, and I think it's sufficient to warn about the possibility
of incompatible cpu_enable()s in a comment.

Otherwise, your text sounds good.

Cheers
---Dave
