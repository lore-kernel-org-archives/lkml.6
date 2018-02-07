Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeBGIm7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:42:59 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:39435 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753066AbeBGIm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:42:58 -0500
Date: Wed, 7 Feb 2018 09:42:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
Message-ID: <20180207084254.GI2269@hirez.programming.kicks-ass.net>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202171708.GN2269@hirez.programming.kicks-ass.net>
 <93db4b69-5ec6-732f-558e-5e64d9ba0cf9@oracle.com>
 <20180205121947.GW2269@hirez.programming.kicks-ass.net>
 <930364e4-bbfe-8c8f-d095-0dd4256a5104@oracle.com>
 <20180206091239.GA2269@hirez.programming.kicks-ass.net>
 <97500234-ebbb-4404-d4de-ab10d3ec79e1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97500234-ebbb-4404-d4de-ab10d3ec79e1@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 04:30:03PM -0800, Subhra Mazumdar wrote:

> I meant the SMT balance patch. That does comparison with only one other
> random core and takes the decision in O(1). Any potential scan of all cores
> or cpus is O(n) and doesn't scale and will only get worse in future. That
> applies to both select_idle_core() and select_idle_cpu().

We only do the full scan if we think to know there is indeed an idle
core to be had, and if there are idle cores the machine isn't terribly
busy.

If there are no idle cores, we do not in fact scan everything. We limit
the amount of scanning based on the average idle time with a minimum of
4.

(Except when you switch off things like SIS_PROP, then you scan
unconditionally and reduce tail latency at the cost of throughput --
like said, some people want this).

O(1) sounds nice, but it has horrible worst case latencies.

And like I said, I don't see how a rotor is particularly more random
than the previous cpu the task you happen to be waking ran on.

> Is there any reason this randomized approach is not acceptable even if
> benchmarks show improvement? Are there other benchmarks I should try?

Looking at just one other core has a fairly high chance of not finding
idle. I really cannot remember all the benchmarks, but Mike did
something a little less random but still O(1) a few years back and that
crashed and burned.

> Also your suggestion to keep the SMT utilization but still do a traversal of
> cores
> in select_idle_core() while remembering the least loaded core will still
> have
> the problem of potentially traversing all cores. I can compare this with a
> core
> level only SMT balancing, is that useful to decide? I will also test on
> SPARC
> machines with higher degree of SMT.

Please learn to use your email client, that's near unreadable for
whitespace damage, time is really too precious to try and untangle crap
like that.

> You had also mentioned to do it for only SMT >2, not sure I understand why
> as even for SMT=2 (intel) benchmarks show improvement. This clearly shows
> the scalability problem.

For SMT2 you don't need the occupation counter with atomic crud, a
simple !atomic core-idle works just fine. And your 'patch' had soo many
moving parts it was too hard to say which aspect changed what.

hackbench really isn't _that_ interesting a benchmark and its fairly
easy to make it go faster, but doing so typically wrecks something else.

There's a whole array of netperf benchmarks which you have to run at
different utilization levels, there's the sysbench oltp stuff, which you
can run on MariaDB and PostgreSQL, again at different utilization levels
(both databases behave quite differently). There's ebizzy, tbench,
dbench and others.

There's also NUMA stuff, like NAS benchmarks and specJBB nonsense.

There's the facebook schbench, which is a bit finnicky to set up.

And I'm sure I'm forgetting half, look at the patches and regression
reports for more clues, that's what Google is for. You could have
figured all that out yourself, much of these are listed in the
changelogs and if you'd bothered to find lkml regression reports you
could find more.
