Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5231DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AC62064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AC62064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbeKADbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:31:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730000AbeKADbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:31:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 389E2B184;
        Wed, 31 Oct 2018 18:32:20 +0000 (UTC)
Message-ID: <1541010981.3423.2.camel@suse.cz>
Subject: Re: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor
 for tickless systems
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Wed, 31 Oct 2018 19:36:21 +0100
In-Reply-To: <1899281.leNo2RexrE@aspire.rjw.lan>
References: <1899281.leNo2RexrE@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-26 at 11:12 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> [... cut ...]
> 
> The new governor introduced here, the timer events oriented (TEO)
> governor, uses the same basic strategy as menu: it always tries to
> find the deepest idle state that can be used in the given conditions.
> However, it applies a different approach to that problem.  First, it
> doesn't use "correction factors" for the time till the closest timer,
> but instead it tries to correlate the measured idle duration values
> with the available idle states and use that information to pick up
> the idle state that is most likely to "match" the upcoming CPU idle
> interval.  Second, it doesn't take the number of "I/O waiters" into
> account at all and the pattern detection code in it tries to avoid
> taking timer wakeups into account.  It also only uses idle duration
> values less than the current time till the closest timer (with the
> tick excluded) for that purpose.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> The v2 is a re-write of major parts of the original patch.
> 
> The approach the same in general, but the details have changed significantly
> with respect to the previous version.  In particular:
> * The decay of the idle state metrics is implemented differently.
> * There is a more "clever" pattern detection (sort of along the lines
>   of what the menu does, but simplified quite a bit and trying to avoid
>   including timer wakeups).
> * The "promotion" from the "polling" state is gone.
> * The "safety net" wakeups are treated as the CPU might have been idle
>   until the closest timer.
> 
> I'm running this governor on all of my systems now without any
> visible adverse effects.
> 
> Overall, it selects deeper idle states more often than menu on average, but
> that doesn't seem to make a significant difference in the majority of cases.
> 
> In this preliminary revision it overtakes menu as the default governor
> for tickless systems (due to the higher rating), but that is likely
> to change going forward.  At this point I'm mostly asking for feedback
> and possibly testing with whatever workloads you can throw at it.
> 
> The patch should apply on top of 4.19, although I'm running it on
> top of my linux-next branch.  This version hasn't been run through
> benchmarks yet and that likely will take some time as I will be
> traveling quite a bit during the next few weeks.
> 
> ---
>  drivers/cpuidle/Kconfig            |   11 
>  drivers/cpuidle/governors/Makefile |    1 
>  drivers/cpuidle/governors/teo.c    |  491 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 503 insertions(+)
>  
> [... cut ...]

Hello Rafael,

your new governor has a neutral impact on performance, as you expected. This is
a positive result, since the purpose of "teo" is to give improved
predictions on idle times without regressing on the performance side. There
are swings here and there but nothing looks extremely bad. v2 is largely
equivalent to v1 in my tests, except for sockperf and netperf on the
Haswell machine (v2 slightly worse) and tbench on the Skylake machine
(again v2 slightly worse).

I've tested your patches applying them on v4.18 (plus the backport
necessary for v2 as Doug helpfully noted), just because it was the latest
release when I started preparing this.

I've tested it on three machines, with different generations of Intel CPUs:

* single socket E3-1240 v5 (Skylake 8 cores, which I'll call 8x-SKYLAKE-UMA)
* two sockets E5-2698 v4 (Broadwell 80 cores, 80x-BROADWELL-NUMA from here onwards)
* two sockets E5-2670 v3 (Haswell 48 cores, 48x-HASWELL-NUMA from here onwards)


BENCHMARKS WITH NEUTRAL RESULTS
===============================

These are the workloads where no noticeable difference is measured (on both
v1 and v2, all machines), together with the corresponding MMTests[1]
configuration file name:

* pgbench read-only on xfs, pgbench read/write on xfs
	* global-dhp__db-pgbench-timed-ro-small-xfs
	* global-dhp__db-pgbench-timed-rw-small-xfs
* siege
	* global-dhp__http-siege
* hackbench, pipetest
	* global-dhp__scheduler-unbound
* Linux kernel compilation
	* global-dhp__workload_kerndevel-xfs
* NASA Parallel Benchmarks, C-Class (linear algebra; run both with OpenMP
  and OpenMPI, over xfs)
	* global-dhp__nas-c-class-mpi-full-xfs
	* global-dhp__nas-c-class-omp-full
* FIO (Flexible IO) in several configurations
	* global-dhp__io-fio-randread-async-randwrite-xfs
	* global-dhp__io-fio-randread-async-seqwrite-xfs
	* global-dhp__io-fio-seqread-doublemem-32k-4t-xfs
	* global-dhp__io-fio-seqread-doublemem-4k-4t-xfs
* netperf on loopback over TCP
	* global-dhp__network-netperf-unbound


BENCHMARKS WITH NON-NEUTRAL RESULTS: OVERVIEW
=============================================

These are benchmarks which exhibit a variation in their performance;
you'll see the magnitude of the changes is moderate and it's highly variable
from machine to machine. All percentages refer to the v4.18 baseline. In
more than one case the Haswell machine seems to prefer v1 to v2.

* xfsrepair
	* global-dhp__io-xfsrepair-xfs

					teo-v1		teo-v2
		-------------------------------------------------
		8x-SKYLAKE-UMA		2% worse	2% worse
		80x-BROADWELL-NUMA	1% worse	1% worse
		48x-HASWELL-NUMA	1% worse	1% worse

* sqlite (insert operations on xfs)
	* global-dhp__db-sqlite-insert-medium-xfs

					teo-v1		teo-v2
		-------------------------------------------------
		8x-SKYLAKE-UMA		no change	no change
		80x-BROADWELL-NUMA	2% worse	3% worse
		48x-HASWELL-NUMA	no change	no change

* netperf on loopback over UDP
	* global-dhp__network-netperf-unbound

					teo-v1		teo-v2
		-------------------------------------------------
		8x-SKYLAKE-UMA		no change	6% worse
		80x-BROADWELL-NUMA	1% worse	4% worse
		48x-HASWELL-NUMA	3% better	5% worse

* sockperf on loopback over TCP, mode "under load"
	* global-dhp__network-sockperf-unbound

					teo-v1		teo-v2
		-------------------------------------------------
		8x-SKYLAKE-UMA		6% worse	no change
		80x-BROADWELL-NUMA	7% better	no change
		48x-HASWELL-NUMA	3% better	2% worse

* sockperf on loopback over UDP, mode "throughput"
	* global-dhp__network-sockperf-unbound

					teo-v1		teo-v2
		-------------------------------------------------
		8x-SKYLAKE-UMA		1% worse	1% worse
		80x-BROADWELL-NUMA	3% better	2% better
		48x-HASWELL-NUMA	4% better	12% worse

* sockperf on loopback over UDP, mode "under load"
	* global-dhp__network-sockperf-unbound

					teo-v1		teo-v2
		-------------------------------------------------
		8x-SKYLAKE-UMA		3% worse	1% worse
		80x-BROADWELL-NUMA	10% better	8% better
		48x-HASWELL-NUMA	1% better	no change

* dbench on xfs
        * global-dhp__io-dbench4-async-xfs

					teo-v1		teo-v2
		-------------------------------------------------
		8x-SKYLAKE-UMA		3% better	4% better
		80x-BROADWELL-NUMA	no change	no change
		48x-HASWELL-NUMA	6% worse	16% worse

* tbench on loopback
	* global-dhp__network-tbench

					teo-v1		teo-v2
		-------------------------------------------------
		8x-SKYLAKE-UMA		1% worse	10% worse
		80x-BROADWELL-NUMA	1% worse	1% worse
		48x-HASWELL-NUMA	1% worse	2% worse

* schbench
	* global-dhp__workload_schbench

					teo-v1		teo-v2
		-------------------------------------------------
		8x-SKYLAKE-UMA		1% better	no change
		80x-BROADWELL-NUMA	2% worse	1% worse
		48x-HASWELL-NUMA	2% worse	3% worse

* gitsource on xfs (git unit tests, shell intensive)
	* global-dhp__workload_shellscripts-xfs

					teo-v1		teo-v2
		-------------------------------------------------
		8x-SKYLAKE-UMA		no change	no change
		80x-BROADWELL-NUMA	no change	1% better
		48x-HASWELL-NUMA	no change	1% better


BENCHMARKS WITH NON-NEUTRAL RESULTS: DETAIL
===========================================

Now some more detail. Each benchmark is run in a variety of configurations
(eg. number of threads, number of concurrent connections and so forth) each
of them giving a result. What you see above is the geometric mean of
"sub-results"; below is the detailed view where there was a regression
larger than 5% (either in v1 or v2, on any of the machines). That means
I'll exclude xfsrepar, sqlite, schbench and the git unit tests "gitsource"
that have negligible swings from the baseline.

In all tables asterisks indicate a statement about statistical
significance: the difference with baseline has a p-value smaller than 0.1
(small p-values indicate that the difference is real and not just random
noise).

NETPERF-UDP
===========
NOTES: Test run in mode "stream" over UDP. The varying parameter is the
    message size in bytes. Each measurement is taken 5 times and the
    harmonic mean is reported.
MEASURES: Throughput in MBits/second, both on the sender and on the receiver end.
HIGHER is better

machine: 8x-SKYLAKE-UMA
                                     4.18.0                 4.18.0                 4.18.0
                                    vanilla                 teo-v1        teo-v2+backport
-----------------------------------------------------------------------------------------
Hmean     send-64         362.27 (   0.00%)      362.87 (   0.16%)      318.85 * -11.99%*
Hmean     send-128        723.17 (   0.00%)      723.66 (   0.07%)      660.96 *  -8.60%*
Hmean     send-256       1435.24 (   0.00%)     1427.08 (  -0.57%)     1346.22 *  -6.20%*
Hmean     send-1024      5563.78 (   0.00%)     5529.90 *  -0.61%*     5228.28 *  -6.03%*
Hmean     send-2048     10935.42 (   0.00%)    10809.66 *  -1.15%*    10521.14 *  -3.79%*
Hmean     send-3312     16898.66 (   0.00%)    16539.89 *  -2.12%*    16240.87 *  -3.89%*
Hmean     send-4096     19354.33 (   0.00%)    19185.43 (  -0.87%)    18600.52 *  -3.89%*
Hmean     send-8192     32238.80 (   0.00%)    32275.57 (   0.11%)    29850.62 *  -7.41%*
Hmean     send-16384    48146.75 (   0.00%)    49297.23 *   2.39%*    48295.51 (   0.31%)
Hmean     recv-64         362.16 (   0.00%)      362.87 (   0.19%)      318.82 * -11.97%*
Hmean     recv-128        723.01 (   0.00%)      723.66 (   0.09%)      660.89 *  -8.59%*
Hmean     recv-256       1435.06 (   0.00%)     1426.94 (  -0.57%)     1346.07 *  -6.20%*
Hmean     recv-1024      5562.68 (   0.00%)     5529.90 *  -0.59%*     5228.28 *  -6.01%*
Hmean     recv-2048     10934.36 (   0.00%)    10809.66 *  -1.14%*    10519.89 *  -3.79%*
Hmean     recv-3312     16898.65 (   0.00%)    16538.21 *  -2.13%*    16240.86 *  -3.89%*
Hmean     recv-4096     19351.99 (   0.00%)    19183.17 (  -0.87%)    18598.33 *  -3.89%*
Hmean     recv-8192     32238.74 (   0.00%)    32275.13 (   0.11%)    29850.39 *  -7.41%*
Hmean     recv-16384    48146.59 (   0.00%)    49296.23 *   2.39%*    48295.03 (   0.31%)

SOCKPERF-TCP-UNDER-LOAD
=======================
NOTES: Test run in mode "under load" over TCP. Parameters are message size
    and transmission rate.
MEASURES: Round-trip time in microseconds
LOWER is better

machine: 8x-SKYLAKE-UMA
                                                 4.18.0                 4.18.0                 4.18.0
                                                vanilla                 teo-v1        teo-v2+backport
-----------------------------------------------------------------------------------------------------
Amean        size-14-rate-10000        36.43 (   0.00%)       36.86 (  -1.17%)       20.24 (  44.44%)
Amean        size-14-rate-24000        17.78 (   0.00%)       17.71 (   0.36%)       18.54 (  -4.29%)
Amean        size-14-rate-50000        20.53 (   0.00%)       22.29 (  -8.58%)       16.16 (  21.30%)
Amean        size-100-rate-10000       21.22 (   0.00%)       23.41 ( -10.35%)       33.04 ( -55.73%)
Amean        size-100-rate-24000       17.81 (   0.00%)       21.09 ( -18.40%)       14.39 (  19.18%)
Amean        size-100-rate-50000       12.31 (   0.00%)       19.65 ( -59.64%)       15.11 ( -22.77%)
Amean        size-300-rate-10000       34.21 (   0.00%)       35.30 (  -3.19%)       34.20 (   0.05%)
Amean        size-300-rate-24000       24.52 (   0.00%)       26.00 (  -6.04%)       27.42 ( -11.81%)
Amean        size-300-rate-50000       20.20 (   0.00%)       20.39 (  -0.95%)       17.83 (  11.73%)
Amean        size-500-rate-10000       21.56 (   0.00%)       21.31 (   1.15%)       29.32 ( -35.98%)
Amean        size-500-rate-24000       30.58 (   0.00%)       27.41 (  10.38%)       27.21 (  11.03%)
Amean        size-500-rate-50000       19.46 (   0.00%)       22.48 ( -15.55%)       16.29 (  16.30%)
Amean        size-850-rate-10000       35.89 (   0.00%)       35.56 (   0.91%)       23.84 (  33.57%)
Amean        size-850-rate-24000       29.11 (   0.00%)       28.18 (   3.20%)       17.44 (  40.08%)
Amean        size-850-rate-50000       13.55 (   0.00%)       18.05 ( -33.26%)       21.30 ( -57.20%)

SOCKPERF-UDP-THROUGHPUT
=======================
NOTES: Test run in mode "throughput" over UDP. The varying parameter is the
    message size.
MEASURES: Throughput, in MBits/second
HIGHER is better

machine: 48x-HASWELL-NUMA
                              4.18.0                 4.18.0                 4.18.0
                             vanilla                 teo-v1        teo-v2+backport
----------------------------------------------------------------------------------
Hmean     14        48.16 (   0.00%)       50.94 *   5.77%*       42.50 * -11.77%*
Hmean     100      346.77 (   0.00%)      358.74 *   3.45%*      303.31 * -12.53%*
Hmean     300     1018.06 (   0.00%)     1053.75 *   3.51%*      895.55 * -12.03%*
Hmean     500     1693.07 (   0.00%)     1754.62 *   3.64%*     1489.61 * -12.02%*
Hmean     850     2853.04 (   0.00%)     2948.73 *   3.35%*     2473.50 * -13.30%*

DBENCH4
=======
NOTES: asyncronous IO; varies the number of clients up to NUMCPUS*8.
MEASURES: latency (millisecs)
LOWER is better

machine: 48x-HASWELL-NUMA
                              4.18.0                 4.18.0                 4.18.0
                             vanilla                 teo-v1        teo-v2+backport
----------------------------------------------------------------------------------
Amean      1        37.15 (   0.00%)       50.10 ( -34.86%)       39.02 (  -5.03%)
Amean      2        43.75 (   0.00%)       45.50 (  -4.01%)       44.36 (  -1.39%)
Amean      4        54.42 (   0.00%)       58.85 (  -8.15%)       58.17 (  -6.89%)
Amean      8        75.72 (   0.00%)       74.25 (   1.94%)       82.76 (  -9.30%)
Amean      16      116.56 (   0.00%)      119.88 (  -2.85%)      164.14 ( -40.82%)
Amean      32      570.02 (   0.00%)      561.92 (   1.42%)      681.94 ( -19.63%)
Amean      64     3185.20 (   0.00%)     3291.80 (  -3.35%)     4337.43 ( -36.17%)

TBENCH4
=======
NOTES: networking counterpart of dbench. Varies the number of clients up to NUMCPUS*4
MEASURES: Throughput, MB/sec
HIGHER is better

machine: 8x-SKYLAKE-UMA
                                    4.18.0                 4.18.0                 4.18.0
                                   vanilla                    teo        teo-v2+backport
----------------------------------------------------------------------------------------
Hmean     mb/sec-1       620.52 (   0.00%)      613.98 *  -1.05%*      502.47 * -19.03%*
Hmean     mb/sec-2      1179.05 (   0.00%)     1112.84 *  -5.62%*      820.57 * -30.40%*
Hmean     mb/sec-4      2072.29 (   0.00%)     2040.55 *  -1.53%*     2036.11 *  -1.75%*
Hmean     mb/sec-8      4238.96 (   0.00%)     4205.01 *  -0.80%*     4124.59 *  -2.70%*
Hmean     mb/sec-16     3515.96 (   0.00%)     3536.23 *   0.58%*     3500.02 *  -0.45%*
Hmean     mb/sec-32     3452.92 (   0.00%)     3448.94 *  -0.12%*     3428.08 *  -0.72%*


[1] https://github.com/gormanm/mmtests


Happy to answer any questions on the benchmarks or the methods used to
collect/report data.

Something I'd like to do now is verify that "teo"'s predictions are better
than "menu"'s; I'll probably use systemtap to make some histograms of idle
times versus what idle state was chosen -- that'd be enough to compare the
two.

After that it would be nice to somehow know where timers came from; i.e. if
I see that residences in a given state are consistently shorter than
they're supposed to be, it would be interesting to see who set the timer
that causes the wakeup. But... I'm not sure to know how to do that :) Do
you have a strategy to track down the origin of timers/interrupts? Is there
any script you're using to evaluate teo that you can share?

Thanks,
Giovanni Gherdovich
