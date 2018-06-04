Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeFDJTh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:19:37 -0400
Received: from foss.arm.com ([217.140.101.70]:40588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbeFDJTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:19:36 -0400
Date: Mon, 4 Jun 2018 10:19:31 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spectre mitigation doesn't seem to work at all?!
Message-ID: <20180604091931.sziimdeei54jgwzn@salmiak>
References: <141672d1-8dcb-9a84-7f8f-60c7a2c58b07@01019freenet.de>
 <20180604081502.GE12258@hirez.programming.kicks-ass.net>
 <d8fbee2d-305a-9fc0-356e-b8d4cbd59dbd@maya.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8fbee2d-305a-9fc0-356e-b8d4cbd59dbd@maya.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 10:50:07AM +0200, Andreas Hartmann wrote:
> Hello Peter,
> 
> thanks for your answer! I appreciate it!
> 
> On 06/04/2018 at 10:15 AM Peter Zijlstra wrote:
> > On Fri, Jun 01, 2018 at 02:19:38PM +0200, Andreas Hartmann wrote:
> > 
> >> I tested the spectre mitigation of different machines and kernels with
> >> https://github.com/crozone/SpectrePoC
> >>
> >> You can see the results below.
> > 
> >> My question: Did I miss something?
> > 
> > Yes.
> > 
> >> Build: ... INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED
> >> Build: ... INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED
> >> Build: ... INTEL_MITIGATION_DISABLED LINUX_KERNEL_MITIGATION_DISABLED
> > 
> >                               ^^^^^^^^                         ^^^^^^^^
> > 
> > The POC is a v1 on itself. V1 needs to be fixed for every individual
> > executable (worse, for every individual location in the code, and we're
> > still finding them). The kernel mitigation status for v1 only indicates
> > the kernel itself has mitigations (for some locations).
> > 
> > The POC is meant to test effectiveness of these mitigations, either the
> > original LFENCE or the dependent instruction thing, but you have to
> > enable one or the other.
> 
> Ok, this means every program running on the machine has to care itself
> to be spectre v1 - safe.

Correct. Primiarily this matters for things like JITs, where untrusted code may
be run in the same address space as sensitive data.

> A malicious program most probably won't care about that. Therefore, my
> next question is: which memory regions can be exploited by a malicious
> program? The complete physical memory or only the memory provided to the
> malicious program? Should be the latter if this approach should have any
> impact.

Assuming you have a CPU which is not vulnerable to meltdown / variant-3, or you
have mitigated this, (e.g. with KPTI), a malicious program can only access data
within its own address space.

Spectre variant-1 alone only gives access to memory in the address space of the
program itself.

Thanks,
Mark.
