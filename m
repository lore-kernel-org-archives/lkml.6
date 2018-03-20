Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeCTQyL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:54:11 -0400
Received: from juno.mpi-klsb.mpg.de ([139.19.86.40]:34120 "EHLO
        juno.mpi-klsb.mpg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTQyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:54:08 -0400
Subject: Re: `perf report` about 1000x(!) slower in linux 4.15
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, milian.wolff@kdab.com
References: <c6aa77d0-3d0c-bd03-aaa9-f1c33eff277f@mpi-sws.org>
 <20180320133851.GB3784@kernel.org>
From: Jan-Oliver Kaiser <janno@mpi-sws.org>
Message-ID: <6f59da20-ccdf-b7c7-f323-3d2b6458143e@mpi-sws.org>
Date: Tue, 20 Mar 2018 17:54:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320133851.GB3784@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MPI-Local-Sender: true
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The behavior persists with the most recent head of linux/master 
(1b5f3ba415fe4cf8b8b39c8d104ed44cde330658).

$ ./perf --version
perf version 4.16.rc6.g1b5f3ba4

$ uname -r
4.15.9-towo.1-siduction-amd64

(This is a debian unstable variant.)

$ ./perf report --header-only -i <my_perf.data>
# ========
# captured on: Fri Mar 16 18:14:05 2018
# hostname : blackbox
# os release : 4.15.9-towo.1-siduction-amd64
# perf version : 4.15.4
# arch : x86_64
# nrcpus online : 4
# nrcpus avail : 4
# cpudesc : Intel(R) Core(TM) i7-5500U CPU @ 2.40GHz
# cpuid : GenuineIntel,6,61,4
# total memory : 16343572 kB
# cmdline : /usr/bin/perf_4.15 record -F 99 --call-graph dwarf -- coqc 
-q -I /home/janno/.opam/iris-mtac2/lib/coq//user-contrib/Unicoq -I src 
-Q tests Mtac2Tests -R theories Mtac2 timings/decapp_vs_mmatch.v
# event : name = cycles:uppp, , size = 112, { sample_period, sample_freq 
} = 99, sample_type = 
IP|TID|TIME|ADDR|CALLCHAIN|PERIOD|REGS_USER|STACK_USER|DATA_SRC, 
disabled = 1, inherit = 1, exclude_kernel = 1, mma$
# CPU_TOPOLOGY info available, use -I to display
# NUMA_TOPOLOGY info available, use -I to display
# pmu mappings: intel_pt = 6, uncore_arb = 11, cstate_pkg = 14, 
breakpoint = 5, uncore_cbox_1 = 10, power = 12, cpu = 4, software = 1, 
uncore_imc = 8, uncore_cbox_0 = 9, cstate_core = 13, msr = 7
# CACHE info available, use -I to display
# missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT 
SAMPLE_TIME
# ========
#

Best,
Janno

On 03/20/2018 02:38 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 20, 2018 at 12:57:29PM +0100, Jan-Oliver Kaiser escreveu:
>> After upgrading my system to linux 4.15 (from 4.14), `perf report` became
>> unusably slow. I estimate a decrease in performance by a factor of
>> 100x-1000x. Some 21M perf.data files take about 30 seconds in the
>> "Processing events" step.  `git bisect` points to
>   
>> commit d8a88dd243a170a226aba33e7c53704db2f82aa6 (HEAD, refs/bisect/bad)
>> Author: Milian Wolff <milian.wolff@kdab.com>
>>      perf util: Enable handling of inlined frames by default
>   
>> The slowdown can be worked around with `--no-inline`. If the slowdown is
>> expected, I would suggest reverting the default setting here or maybe
>> printing a warning if a lot of time is spent on this feature.
>   
>> Do you need any additional information about my system or the recorded data
>> I am looking at?
> 
> Can you try with the latest perf tool?
> 
> [acme@jouet perf]$ make perf-tarxz-src-pkg ; ls -la perf-4*
>    TAR
>    PERF_VERSION = 4.16.rc6.gecd380
> -rw-rw-r--. 1 acme acme 1323568 Mar 20 10:30 perf-4.16.0-rc6.tar.xz
> [acme@jouet perf]$
> 
> With a recently checked out kernel sources, or, as a convenience, I'm
> pushing this to:
> 
>    http://vger.kernel.org/~acme/perf/perf-4.16.0-rc6.tar.xz
> 
> You just expand it and then:
> 
> [acme@jouet tmp]$ tar xf perf-4.16.0-rc6.tar.xz
> [acme@jouet tmp]$ cd perf-4.16.0-rc6/
> [acme@jouet perf-4.16.0-rc6]$ make -C tools/perf install-bin
> 
> 
> And check if the problem is present there as well.
> 
> If it is, please tell us what is your distro, the output of:
> 
> perf report --header-only
> 
> Thanks,
> 
> - Arnaldo
> 
