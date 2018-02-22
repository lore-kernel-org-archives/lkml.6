Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbeBVQIR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:08:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54900 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932952AbeBVQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:08:15 -0500
Date: Thu, 22 Feb 2018 17:08:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 05/17] lockdep: Extend __bfs() to
 work with multiple kinds of dependencies
Message-ID: <20180222160811.GT25201@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-6-boqun.feng@gmail.com>
 <20180222142614.GR25201@hirez.programming.kicks-ass.net>
 <20180222151210.jwxjchywk4jfecyf@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222151210.jwxjchywk4jfecyf@tardis>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 11:12:10PM +0800, Boqun Feng wrote:
> On Thu, Feb 22, 2018 at 03:26:14PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 22, 2018 at 03:08:52PM +0800, Boqun Feng wrote:
> > > Now we have four kinds of dependencies in the dependency graph, and not
> > > all the pathes carry strong dependencies, for example:
> > > 
> > > 	Given lock A, B, C, if we have:
> > > 
> > > 	CPU1			CPU2
> > > 	=============		==============
> > > 	write_lock(A);		read_lock(B);
> > > 	read_lock(B);		write_lock(C);
> > > 
> > > 	then we have dependencies A--(NR)-->B, and B--(RN)-->C, (NR and
> > > 	RN are to indicate the dependency kind), A actually doesn't have
> > > 	strong dependency to C(IOW, C doesn't depend on A), to see this,
> > > 	let's say we have a third CPU3 doing:
> > > 
> > > 	CPU3:
> > > 	=============
> > > 	write_lock(C);
> > > 	write_lock(A);
> > > 
> > > 	, this is not a deadlock. However if we change the read_lock()
> > > 	on CPU2 to a write_lock(), it's a deadlock then.
> > > 
> > > 	So A --(NR)--> B --(RN)--> C is not a strong dependency path but
> > > 	A --(NR)--> B --(NN)-->C is a strong dependency path.
> > 
> > I'm not really satisfied with the above reasoning. I don't disagree, but
> > if possible it would be nice to have something a little more solid.
> > 
> 
> What do you mean by "solid"? You mean "A --(NR)--> B --(NN)-->C" is too
> abstract, and want something like the below instead:

The above description mostly leaves it as an exercise to the reader to
'proof' ignoring *R -> R* is both safe and complete while that is the
main argument.
