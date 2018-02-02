Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbeBBRgT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:36:19 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:40185 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753667AbeBBRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:17:14 -0500
Date: Fri, 2 Feb 2018 18:17:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
Message-ID: <20180202171708.GN2269@hirez.programming.kicks-ass.net>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 11:53:40AM -0500, Steven Sistare wrote:
> >> +static int select_idle_smt(struct task_struct *p, struct sched_group *sg)
> >>  {
> >> +	int i, rand_index, rand_cpu;
> >> +	int this_cpu = smp_processor_id();
> >>  
> >> +	rand_index = CPU_PSEUDO_RANDOM(this_cpu) % sg->group_weight;
> >> +	rand_cpu = sg->cp_array[rand_index];
> > 
> > Right, so yuck.. I know why you need that, but that extra array and
> > dereference is the reason I never went there.
> > 
> > How much difference does it really make vs the 'normal' wrapping search
> > from last CPU ?
> > 
> > This really should be a separate patch with separate performance numbers
> > on.
> 
> For the benefit of other readers, if we always search and choose starting from
> the first CPU in a core, then later searches will often need to traverse the first
> N busy CPU's to find the first idle CPU.  Choosing a random starting point avoids
> such bias.  It is probably a win for processors with 4 to 8 CPUs per core, and
> a slight but hopefully negligible loss for 2 CPUs per core, and I agree we need
> to see performance data for this as a separate patch to decide.  We have SPARC
> systems with 8 CPUs per core.

Which is why the current code already doesn't start from the first cpu
in the mask. We start at whatever CPU the task ran last on, which is
effectively 'random' if the system is busy.

So how is a per-cpu rotor better than that?
