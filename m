Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeC0L75 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:59:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:15047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbeC0L74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:59:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,367,1517904000";
   d="scan'208";a="215055331"
Date: Tue, 27 Mar 2018 04:59:37 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf stat: avoid 10ms limit for printing event counts
Message-ID: <20180327115937.GR13724@tassilo.jf.intel.com>
References: <8f27e33e-355a-e6f3-30d9-c0fc3ff46c4d@linux.intel.com>
 <20180327090642.GP13724@tassilo.jf.intel.com>
 <39ed9fc9-d14d-5c0e-defc-60b54df1ae12@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ed9fc9-d14d-5c0e-defc-60b54df1ae12@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 02:40:29PM +0300, Alexey Budankov wrote:
> On 27.03.2018 12:06, Andi Kleen wrote:
> >> When running perf stat -I for monitoring e.g. PCIe uncore counters and 
> >> at the same time profiling some I/O workload by perf record e.g. for 
> >> cpu-cycles and context switches, it is then possible to build and 
> >> observe good-enough consolidated CPU/OS/IO(Uncore) performance picture 
> >> for that workload.
> > 
> > At some point I still hope we can make uncore measurements in 
> > perf record work. Kan tried at some point to allow multiple
> > PMUs in a group, but was not successfull. But perhaps we
> > can sample them from a software event instead.
> > 
> >>
> >> The warning on possible runtime overhead is still preserved, however 
> >> it is only visible when specifying -v option.
> > 
> > I would print it unconditionally. Very few people use -v.
> > 
> > BTW better of course would be to occasionally measure the perf stat 
> > cpu time and only print the warning if it's above some percentage
> > of a CPU. But that would be much more work.
> 
> Would you please elaborate more on that?

getrusage() can give you the system+user time of the current process.
If you compare that to wall time you know the percentage.

Could measure those occasionally (not every interval, but perhaps
once per second or so). If the overhead reaches a reasonable percentage (5%
perhaps?) print the warning once.

One problem is th the measurement doesn't inlude time in the remote
IPIs for reading performance counters on other CPUs.  So if the system
is very large it may be less and less accurate. But maybe it's a good
enough proxy.

Or in theory could fix the kernel to charge this somehow to the process
that triggered the IPIs, but that would be another project.

Another problem is that it doesn't account for burstiness. Maybe
the problem is not the smoothed average of CPU time, but bursts
competing with the original workload. There's probably no easy
solution for that.

Also if the CPU perf stat runs on is idle it of course doesn't matter.
Getting that would require reading /proc, which would be much more 
expensive so probably not a good idea. As a proxy you could check
the involuntary context switches (also reported by getrusage),
and if they don't cross some threshold then don't warn)

-Andi
