Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbeDQNkR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:40:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753813AbeDQNkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:40:12 -0400
Date: Tue, 17 Apr 2018 10:40:08 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Stephane Eranian <eranian@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org
Subject: Re: [RFC] perf/core: what is exclude_idle supposed to do
Message-ID: <20180417134008.GA2350@redhat.com>
References: <CABPqkBS6MuO6Twtq=_+TDV=RNy0_2vRWf=LVCk6wk0tPwNSTog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBS6MuO6Twtq=_+TDV=RNy0_2vRWf=LVCk6wk0tPwNSTog@mail.gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 16, 2018 at 10:04:53PM +0000, Stephane Eranian escreveu:
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

To do something it is not doing, i.e. to do what you expected it to do.

There were messages exchanged recently where PeterZ said that this is
just that needs fixing.

- Arnaldo
