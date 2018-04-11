Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeDKPjL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:39:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41483 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeDKPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:39:09 -0400
X-Google-Smtp-Source: AIpwx49xjh/h3/uwYTY6/uIv7h9IeFrjmSPCyZmS6FDmaH2vLKdxZkO0p6TTe3WdtWOjrGW4F7uzog==
Date: Wed, 11 Apr 2018 17:39:01 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/10] kernel/locking: qspinlock improvements
Message-ID: <20180411153901.GA14205@andrea>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <20180406132249.GA7071@andrea>
 <20180411102003.rjfrcmc4fjukehst@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411102003.rjfrcmc4fjukehst@armageddon.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 11:20:04AM +0100, Catalin Marinas wrote:
> On Fri, Apr 06, 2018 at 03:22:49PM +0200, Andrea Parri wrote:
> > On Thu, Apr 05, 2018 at 05:58:57PM +0100, Will Deacon wrote:
> > > I've been kicking the tyres further on qspinlock and with this set of patches
> > > I'm happy with the performance and fairness properties. In particular, the
> > > locking algorithm now guarantees forward progress whereas the implementation
> > > in mainline can starve threads indefinitely in cmpxchg loops.
> > > 
> > > Catalin has also implemented a model of this using TLA to prove that the
> > > lock is fair, although this doesn't take the memory model into account:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/commit/
> > 
> > Nice!  I'll dig into this formalization, but my guess is that our model
> > (and axiomatic models "a-la-herd", in general) are not well-suited when
> > it comes to study properties such as fairness, liveness...
> 
> Maybe someone with a background in formal methods could give a better
> answer. How TLA+ works is closer to rmem [1] (operational model,
> exhaustive memoised state search) than herd. Liveness verification
> requires checking that, under certain fairness properties, some state is
> eventually reached. IOW, it tries to show that either all state change
> graphs lead to (go through) such state or that there are cycles in the
> graph and the state is never reached. I don't know whether herd could be
> modified to check liveness. I'm not sure it can handle infinite loops
> either (the above model checks an infinite lock/unlock loop on each
> CPU and that's easier to implement in a tool with memoised states).
> 
> The TLA+ model above assumes sequential consistency, so no memory
> ordering taken into account. One could build an operational model in
> TLA+ that's equivalent to the axiomatic one (e.g. following the Flat
> model equivalence as in [2]), however, liveness checking (at least with
> TLA+) is orders of magnitude slower than safety. Any small variation has
> an exponential impact on the state space, so likely to be impractical.
> For specific parts of the algorithm, you may be able to use a poor man's
> ordering by e.g. writing two accesses in two different orders so the
> model checks both combinations.
> 
> There are papers (e.g. [3]) on how to convert liveness checking to
> safety checking but I haven't dug further. I think it's easier/faster if
> you do liveness checking with a simplified model and separately check
> the safety with respect to memory ordering on tools like herd.

Indeed.  A fundamental problem, AFAICT, is to formalize that concept of
'[it] will _eventually_ happen'.  Consider a simple example:

	{ x = 0}

	P0	|   P1
		|
	x = 1	|   while (!x)
		|  	 ;

herd 'knows' that:

	- on the 1st iteration of the 'while' loop, the load from x
	  can return the value 0 or 1 (only);

	- on the 2nd iteration of the 'while' loop, the load from x
	  can return the value 0 or 1;

	- [ ... and 'so on'! ]

but this is pretty much all herd knows about this snippet by now ... ;)

Thanks,
  Andrea


> 
> [1] http://www.cl.cam.ac.uk/~sf502/regressions/rmem/
> [2] http://www.cl.cam.ac.uk/~pes20/armv8-mca/armv8-mca-draft.pdf
> [3] https://www.sciencedirect.com/science/article/pii/S1571066104804109
> 
> -- 
> Catalin
