Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeFDSYc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:24:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:9620 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeFDSYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:24:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="229837937"
Message-ID: <1528136669.83760.11.camel@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH v3 0/4] Intel_pstate: HWP Dynamic performance
 boost
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org,
        mgorman@techsingularity.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org
Date: Mon, 04 Jun 2018 11:24:29 -0700
In-Reply-To: <20180604180156.4uvb6t4xqxmuwayq@linux-h043>
References: <20180531225143.34270-1-srinivas.pandruvada@linux.intel.com>
         <20180604180156.4uvb6t4xqxmuwayq@linux-h043>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-04 at 20:01 +0200, Giovanni Gherdovich wrote:
> On Thu, May 31, 2018 at 03:51:39PM -0700, Srinivas Pandruvada wrote:
> > v3
> > - Removed atomic bit operation as suggested.
> > - Added description of contention with user space.
> > - Removed hwp cache, boost utililty function patch and merged with
> > util callback
> >   patch. This way any value set is used somewhere.
> > 
> > Waiting for test results from Mel Gorman, who is the original
> > reporter.
> > [SNIP]
> 
> Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> 
> This series has an overall positive performance impact on IO both on
> xfs and
> ext4, and I'd be vary happy if it lands in v4.18. You dropped the
> migration
> optimization from v1 to v2 after the reviewers' suggestion; I'm
> looking
> forward to test that part too, so please add me to CC when you'll
> resend it.
Thanks Giovanni. Since 4.17 is already released and 4.18 pulls already
started, we have to wait for 4.19.


> 
> I've tested your series on a single socket Xeon E3-1240 v5 (Skylake,
> 4 cores /
> 8 threads) with SSD storage. The platform is a Dell PowerEdge R230.
> 
> The benchmarks used are a mix of I/O intensive workloads on ext4 and
> xfs
> (dbench4, sqlite, pgbench in read/write and read-only configuration,
> Flexible
> IO aka FIO, etc) and scheduler stressers just to check that
> everything is okay
> in that department too (hackbench, pipetest, schbench, sockperf on
> localhost
> both in "throughput" and "under-load" mode, netperf in localhost,
> etc). There
> is also some HPC with the NAS Parallel Benchmark, as when using
> openMPI as IPC
> mechanism it ends up being write-intensive and that could be a good
> experiment, even if the HPC people aren't exactly the target audience
> for a
> frequency governor.
> 
> The large improvements are in areas you already highlighted in your
> cover
> letter (dbench4, sqlite, and pgbench read/write too, very impressive
> honestly). Minor wins are also observed in sockperf and running the
> git unit
> tests (gitsource below). The scheduler stressers ends up, as
> expected, in the
> "neutral" category where you'll also find FIO (which given other
> results I'd
> have expected to improve a little at least). Marked "neutral" are
> also those
> results where statistical significance wasn't reached (2 standard
> deviations,
> which is roughly like a 0.05 p-value) even if they showed some
> difference in a
> direction or the other. In the "small losses" section I found
> hackbench run
> with processes (not threads) and pipes (not sockets) which I report
> for due
> diligence but looking at the raw numbers it's more of a mixed bag
> than a real
> loss, 
I think so. But I will see why there is even difference.

Thanks,
Srinivas

> and the NAS high-perf computing benchmark when it uses openMP (as
> opposed to openMPI) for IPC -- but again, we often find that
> supercomputers
> people run the machines at full speed all the time.
> 
> At the bottom of this message you'll find some directions if you want
> to run
> some test yourself using the same framework I used, MMTests from
> https://github.com/gormanm/mmtests (we store a fair amount of
> benchmarks
> parametrization up there).
> 
> Large wins:
> 
>     - dbench4:              +20% on ext4,
>                             +14% on xfs (always asynch IO)
>     - sqlite (insert):       +9% on both ext4 and xfs
>     - pgbench (read/write):  +9% on ext4,
>                             +10% on xfs
> 
> Moderate wins:
> 
>     - sockperf (type: under-load, localhost):              +1% with
> TCP,
>                                                            +5% with
> UDP
>     - gisource (git unit tests, shell intensive):          +3% on
> ext4
>     - NAS Parallel Benchmark (HPC, using openMPI, on xfs): +1%
>     - tbench4 (network part of dbench4, localhost):        +1%
> 
> Neutral:
> 
>     - pgbench (read-only) on ext4 and xfs
>     - siege
>     - netperf (streaming and round-robin) with TCP and UDP
>     - hackbench (sockets/process, sockets/thread and pipes/thread)
>     - pipetest
>     - Linux kernel build
>     - schbench
>     - sockperf (type: throughput) with TCP and UDP
>     - git unit tests on xfs
>     - FIO (both random and seq. read, both random and seq. write)
>       on ext4 and xfs, async IO
> 
> Moderate losses:
> 
>     - hackbench (pipes/process):          -10%
>     - NAS Parallel Benchmark with openMP:  -1%
> 
> 
> Each benchmark is run with a variety of configuration parameters (eg:
> number
> of threads, number of clients, etc); to reach a final "score" the
> geometric
> mean is used (with a few exceptions depending on the type of
> benchmark).
> Detailed results follow. Amean, Hmean and Gmean are respectively
> arithmetic,
> harmonic and geometric means.
> 
> For brevity I won't report all tables but only those for "large wins"
> and
> "moderate losses". Note that I'm not overly worried for the
> hackbench-pipes
> situation, as we've studied it in the past and determined that such
> configuration is particularly weak, time is mostly spent on
> contention and the
> scheduler code path isn't exercised. See the comment in the file
> configs/config-global-dhp__scheduler-unbound in MMTests for a brief
> description of the issue.
> 
> DBENCH4
> =======
> 
> NOTES: asyncronous IO; varies the number of clients up to NUMCPUS*8.
> MMTESTS CONFIG: global-dhp__io-dbench4-async-{ext4, xfs}
> MEASURES: latency (millisecs)
> LOWER is better
> 
> EXT4
>                               4.16.0                 4.16.0
>                              vanilla              hwp-boost
> Amean      1        28.49 (   0.00%)       19.68 (  30.92%)
> Amean      2        26.70 (   0.00%)       25.59 (   4.14%)
> Amean      4        54.59 (   0.00%)       43.56 (  20.20%)
> Amean      8        91.19 (   0.00%)       77.56 (  14.96%)
> Amean      64      538.09 (   0.00%)      438.67 (  18.48%)
> Stddev     1         6.70 (   0.00%)        3.24 (  51.66%)
> Stddev     2         4.35 (   0.00%)        3.57 (  17.85%)
> Stddev     4         7.99 (   0.00%)        7.24 (   9.29%)
> Stddev     8        17.51 (   0.00%)       15.80 (   9.78%)
> Stddev     64       49.54 (   0.00%)       46.98 (   5.17%)
> 
> XFS
>                               4.16.0                 4.16.0
>                              vanilla              hwp-boost
> Amean      1        21.88 (   0.00%)       16.03 (  26.75%)
> Amean      2        19.72 (   0.00%)       19.82 (  -0.50%)
> Amean      4        37.55 (   0.00%)       29.52 (  21.38%)
> Amean      8        56.73 (   0.00%)       51.83 (   8.63%)
> Amean      64      808.80 (   0.00%)      698.12 (  13.68%)
> Stddev     1         6.29 (   0.00%)        2.33 (  62.99%)
> Stddev     2         3.12 (   0.00%)        2.26 (  27.73%)
> Stddev     4         7.56 (   0.00%)        5.88 (  22.28%)
> Stddev     8        14.15 (   0.00%)       12.49 (  11.71%)
> Stddev     64      380.54 (   0.00%)      367.88 (   3.33%)
> 
> SQLITE
> ======
> 
> NOTES: SQL insert test on a table that will be 2M in size.
> MMTESTS CONFIG: global-dhp__db-sqlite-insert-medium-{ext4, xfs}
> MEASURES: transactions per second
> HIGHER is better
> 
> EXT4
>                                 4.16.0                 4.16.0
>                                vanilla              hwp-boost
> Hmean     Trans     2098.79 (   0.00%)     2292.16 (   9.21%)
> Stddev    Trans       78.79 (   0.00%)       95.73 ( -21.50%)
> 
> XFS
>                                 4.16.0                 4.16.0
>                                vanilla              hwp-boost
> Hmean     Trans     1890.27 (   0.00%)     2058.62 (   8.91%)
> Stddev    Trans       52.54 (   0.00%)       29.56 (  43.73%)
> 
> PGBENCH-RW
> ==========
> 
> NOTES: packaged with Postgres. Varies the number of thread up to
> NUMCPUS. The
>   workload is scaled so that the approximate size is 80% of of the
> database
>   shared buffer which itself is 20% of RAM. The page cache is not
> flushed
>   after the database is populated for the test and starts cache-hot.
> MMTESTS CONFIG: global-dhp__db-pgbench-timed-rw-small-{ext4, xfs}
> MEASURES: transactions per second
> HIGHER is better
> 
> EXT4
>                             4.16.0                 4.16.0
>                            vanilla              hwp-boost
> Hmean     1     2692.19 (   0.00%)     2660.98 (  -1.16%)
> Hmean     4     5218.93 (   0.00%)     5610.10 (   7.50%)
> Hmean     7     7332.68 (   0.00%)     8378.24 (  14.26%)
> Hmean     8     7462.03 (   0.00%)     8713.36 (  16.77%)
> Stddev    1      231.85 (   0.00%)      257.49 ( -11.06%)
> Stddev    4      681.11 (   0.00%)      312.64 (  54.10%)
> Stddev    7     1072.07 (   0.00%)      730.29 (  31.88%)
> Stddev    8     1472.77 (   0.00%)     1057.34 (  28.21%)
> 
> XFS
>                             4.16.0                 4.16.0
>                            vanilla              hwp-boost
> Hmean     1     2675.02 (   0.00%)     2661.69 (  -0.50%)
> Hmean     4     5049.45 (   0.00%)     5601.45 (  10.93%)
> Hmean     7     7302.18 (   0.00%)     8348.16 (  14.32%)
> Hmean     8     7596.83 (   0.00%)     8693.29 (  14.43%)
> Stddev    1      225.41 (   0.00%)      246.74 (  -9.46%)
> Stddev    4      761.33 (   0.00%)      334.77 (  56.03%)
> Stddev    7     1093.93 (   0.00%)      811.30 (  25.84%)
> Stddev    8     1465.06 (   0.00%)     1118.81 (  23.63%)
> 
> HACKBENCH
> =========
> 
> NOTES: Varies the number of groups between 1 and NUMCPUS*4
> MMTESTS CONFIG: global-dhp__scheduler-unbound
> MEASURES: time (seconds)
> LOWER is better
> 
>                              4.16.0                 4.16.0
>                             vanilla              hwp-boost
> Amean     1       0.8350 (   0.00%)      1.1577 ( -38.64%)
> Amean     3       2.8367 (   0.00%)      3.7457 ( -32.04%)
> Amean     5       6.7503 (   0.00%)      5.7977 (  14.11%)
> Amean     7       7.8290 (   0.00%)      8.0343 (  -2.62%)
> Amean     12     11.0560 (   0.00%)     11.9673 (  -8.24%)
> Amean     18     15.2603 (   0.00%)     15.5247 (  -1.73%)
> Amean     24     17.0283 (   0.00%)     17.9047 (  -5.15%)
> Amean     30     19.9193 (   0.00%)     23.4670 ( -17.81%)
> Amean     32     21.4637 (   0.00%)     23.4097 (  -9.07%)
> Stddev    1       0.0636 (   0.00%)      0.0255 (  59.93%)
> Stddev    3       0.1188 (   0.00%)      0.0235 (  80.22%)
> Stddev    5       0.0755 (   0.00%)      0.1398 ( -85.13%)
> Stddev    7       0.2778 (   0.00%)      0.1634 (  41.17%)
> Stddev    12      0.5785 (   0.00%)      0.1030 (  82.19%)
> Stddev    18      1.2099 (   0.00%)      0.7986 (  33.99%)
> Stddev    24      0.2057 (   0.00%)      0.7030 (-241.72%)
> Stddev    30      1.1303 (   0.00%)      0.7654 (  32.28%)
> Stddev    32      0.2032 (   0.00%)      3.1626 (-1456.69%)
> 
> NAS PARALLEL BENCHMARK, C-CLASS (w/ openMP)
> ===========================================
> 
> NOTES: The various computational kernels are run separately; see
>   https://www.nas.nasa.gov/publications/npb.html for the list of
> tasks (IS =
>   Integer Sort, EP = Embarrassingly Parallel, etc)
> MMTESTS CONFIG: global-dhp__nas-c-class-omp-full
> MEASURES: time (seconds)
> LOWER is better
> 
>                                4.16.0                 4.16.0
>                               vanilla              hwp-boost
> Amean     bt.C      169.82 (   0.00%)      170.54 (  -0.42%)
> Stddev    bt.C        1.07 (   0.00%)        0.97 (   9.34%)
> Amean     cg.C       41.81 (   0.00%)       42.08 (  -0.65%)
> Stddev    cg.C        0.06 (   0.00%)        0.03 (  48.24%)
> Amean     ep.C       26.63 (   0.00%)       26.47 (   0.61%)
> Stddev    ep.C        0.37 (   0.00%)        0.24 (  35.35%)
> Amean     ft.C       38.17 (   0.00%)       38.41 (  -0.64%)
> Stddev    ft.C        0.33 (   0.00%)        0.32 (   3.78%)
> Amean     is.C        1.49 (   0.00%)        1.40 (   6.02%)
> Stddev    is.C        0.20 (   0.00%)        0.16 (  19.40%)
> Amean     lu.C      217.46 (   0.00%)      220.21 (  -1.26%)
> Stddev    lu.C        0.23 (   0.00%)        0.22 (   0.74%)
> Amean     mg.C       18.56 (   0.00%)       18.80 (  -1.31%)
> Stddev    mg.C        0.01 (   0.00%)        0.01 (  22.54%)
> Amean     sp.C      293.25 (   0.00%)      296.73 (  -1.19%)
> Stddev    sp.C        0.10 (   0.00%)        0.06 (  42.67%)
> Amean     ua.C      170.74 (   0.00%)      172.02 (  -0.75%)
> Stddev    ua.C        0.28 (   0.00%)        0.31 ( -12.89%)
> 
> HOW TO REPRODUCE
> ================
> 
> To install MMTests, clone the git repo at
> https://github.com/gormanm/mmtests.git
> 
> To run a config (ie a set of benchmarks, such as
> config-global-dhp__nas-c-class-omp-full), use the command
> ./run-mmtests.sh --config configs/$CONFIG $MNEMONIC-NAME
> from the top-level directory; the benchmark source will be downloaded
> from its
> canonical internet location, compiled and run.
> 
> To compare results from two runs, use
> ./bin/compare-mmtests.pl --directory ./work/log \
>                          --benchmark $BENCHMARK-NAME \
> 			 --names $MNEMONIC-NAME-1,$MNEMONIC-NAME-2
> from the top-level directory.
> 
> 
> 
> Thanks,
> Giovanni Gherdovich
> SUSE Labs
