Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbeBEMtM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:49:12 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:59925 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbeBEMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:48:58 -0500
Date: Mon, 5 Feb 2018 13:48:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
Message-ID: <20180205124854.GX2269@hirez.programming.kicks-ass.net>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202195943.GR2269@hirez.programming.kicks-ass.net>
 <25d67bd2-cbe7-2c2a-e89a-13a7ca5adc10@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d67bd2-cbe7-2c2a-e89a-13a7ca5adc10@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 04:06:32PM -0500, Steven Sistare wrote:
> On 2/2/2018 2:59 PM, Peter Zijlstra wrote:

> > But then you get that atomic crud to contend on the cluster level, which
> > is even worse than it contending on the core level.
> 
> True, but it can still be a net win if we make better scheduling decisions.
> A saving grace is that the atomic counter is only updated if the cpu
> makes a transition from idle to busy or vice versa.

Which can still be a very high rate for some workloads. I always forget
which, but there are plenty workloads that have very frequenct very
short idle times. Mike, do you remember what comes apart when we take
out the sysctl_sched_migration_cost test in idle_balance()?

> We need data for this type of system, showing improvements for normal
> workloads, and showing little downside for a high context switch rate
> torture test.

So core-wide atomics should, on architectures that can do atomics in L1,
be relatively fast. Once you leave L1, atomic contention goes up a fair
bit. And then there's architectures that simply don't do atomics in L1
(like Power).

Testing on my SKL desktop, atomics contending between SMT siblings is
basically free (weirdly enough my test says its cheaper), atomics
contending on the L3 is 10x as expensive, and this is with only 4 cores.

If I test it on my 10 core IVB, I'm up to 20x, and I can't imagine that
getting any better with bigger core count (my IVB does not show SMT
contention as lower, but not particularly more expensive either).


So while I see the point of tracking these numbers (for SMT>2), I don't
think its worth doing outside of the core, and then we still need some
powerpc (or any other architecture with abysmal atomics) tested.

So what we can do is make this counting crud conditional on SMT>2 and
possibly part of the topology flags such that an architecture can
opt-out.

Then select_idle_core can be augmented to remember the least-loaded core
it encounters in its traversal, and go with that.
