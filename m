Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754537AbeBBT75 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:59:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37188 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754491AbeBBT7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:59:49 -0500
Date: Fri, 2 Feb 2018 20:59:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
Message-ID: <20180202195943.GR2269@hirez.programming.kicks-ass.net>
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
> On 2/1/2018 7:33 AM, Peter Zijlstra wrote:
> > On Mon, Jan 29, 2018 at 03:31:02PM -0800, subhra mazumdar wrote:
> >> +	rcu_read_lock();
> >> +	sd = rcu_dereference(per_cpu(sd_llc, this_cpu));
> >> +	if (util) {
> >> +		for_each_lower_domain(sd) {
> >> +			if (sd->level == 0)
> >> +				break;
> > 
> > afaict you really only need this for the core, and here you're assuming
> > everything below the LLC is cores. Would it not be much clearer if you
> > introduce sd_core.
> > 
> > As is, for_each_lower_domain includes the starting domain, sd->group
> > then is the first core group for this cpu. But then you continue to the
> > smt domain (on Intel, on other architectures there could be a cluster
> > domain in between) and then you bail using that sd->level == 0 hack
> > because otherwise things would go *bang*.
> 
> Hi Peter,
> 
> The code here and in smt_balance intentionally visits each level between
> the llc and smt, including core-cluster on architectures that define it.
> smt_balance thus has the chance to randomly pick a better cluster,
> and then within that cluster randomly pick a better core.  It makes sense,
> as resources are shared within a cluster, and choosing a less loaded cluster
> should give better performance.  As you suggest in a few other places,
> it would be nice to see performance results for this case.  We have
> SPARC processors with core clusters.
> 

But then you get that atomic crud to contend on the cluster level, which
is even worse than it contending on the core level.
