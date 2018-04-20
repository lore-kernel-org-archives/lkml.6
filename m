Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754188AbeDTIfe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:35:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47276 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeDTIfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:35:33 -0400
Date: Fri, 20 Apr 2018 10:35:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Stephane Eranian <eranian@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, mingo@elte.hu,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [RFC] perf/core: what is exclude_idle supposed to do
Message-ID: <20180420083521.GF4064@hirez.programming.kicks-ass.net>
References: <CABPqkBS6MuO6Twtq=_+TDV=RNy0_2vRWf=LVCk6wk0tPwNSTog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBS6MuO6Twtq=_+TDV=RNy0_2vRWf=LVCk6wk0tPwNSTog@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 10:04:53PM +0000, Stephane Eranian wrote:
> Hi,
> 
> I am trying to understand what the exclude_idle event attribute is supposed
> to accomplish.
> As per the definition in the header file:
> 
>     exclude_idle   :  1, /* don't count when idle */
> 
> Naively, I thought it would simply stop the event when running in the
> context of the idle task (swapper, pid 0) on any CPU. That would seem to
> match the succinct description.
> 
> However, running a simple:
> 
> $ perf record -a -e cycles:I sleep 5
> perf_event_attr:
>     sample_type                      IP|TID|TIME|CPU|PERIOD
>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID
>    exclude_idle                     1
> 
> on an idle machine, showed me that this is not what is actually happening:
> $ perf  script
>           swapper     0 [000] 1132634.287442:          1 cycles:I:
>   ffffffff8100b1fb __intel_pmu_enable_all.isra.17 ([kernel.kallsyms])
>           swapper     0 [001] 1132634.287498:          1 cycles:I:
>   ffffffff8100b1fb __intel_pmu_enable_all.isra.17 ([kernel.kallsyms])
> 
> 
> After looking at the code, it all made sense, it seems to current
> implementation is only relevant for sw events. I don't understand why.
> 
> I am left wondering what is the goal of exclude_idle?

A "git grep exclude_idle" seems to suggest powerpc/arm have it
immplemented for their PMU. If we then look at commit:

  2743a5b0fa6f ("perfcounters: provide expansion room in the ABI")

It was Paul who introduced the bit.

So I'm thinking that if x86 doesn't implement it, we should at least
error out on it. Of course, so far we've allowed it, so who knows what
all will break if we start asserting that :/
