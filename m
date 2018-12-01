Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FED2C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78D3214C1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78D3214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeLBB0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 20:26:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:51966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbeLBB0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 20:26:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5211AE9D;
        Sat,  1 Dec 2018 14:14:15 +0000 (UTC)
Message-ID: <1543673904.3452.2.camel@suse.cz>
Subject: Re: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor
 for tickless systems
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Sat, 01 Dec 2018 15:18:24 +0100
In-Reply-To: <42865872.dmYH3PmblP@aspire.rjw.lan>
References: <42865872.dmYH3PmblP@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-23 at 11:35 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The venerable menu governor does some thigns that are quite
> questionable in my view.
> 
> First, it includes timer wakeups in the pattern detection data and
> mixes them up with wakeups from other sources which in some cases
> causes it to expect what essentially would be a timer wakeup in a
> time frame in which no timer wakeups are possible (becuase it knows
> the time until the next timer event and that is later than the
> expected wakeup time).
> 
> Second, it uses the extra exit latency limit based on the predicted
> idle duration and depending on the number of tasks waiting on I/O,
> even though those tasks may run on a different CPU when they are
> woken up.  Moreover, the time ranges used by it for the sleep length
> correction factors depend on whether or not there are tasks waiting
> on I/O, which again doesn't imply anything in particular, and they
> are not correlated to the list of available idle states in any way
> whatever.
> 
> Also, the pattern detection code in menu may end up considering
> values that are too large to matter at all, in which cases running
> it is a waste of time.
> 
> A major rework of the menu governor would be required to address
> these issues and the performance of at least some workloads (tuned
> specifically to the current behavior of the menu governor) is likely
> to suffer from that.  It is thus better to introduce an entirely new
> governor without them and let everybody use the governor that works
> better with their actual workloads.
> 
> The new governor introduced here, the timer events oriented (TEO)
> governor, uses the same basic strategy as menu: it always tries to
> find the deepest idle state that can be used in the given conditions.
> However, it applies a different approach to that problem.
> 
> First, it doesn't use "correction factors" for the time till the
> closest timer, but instead it tries to correlate the measured idle
> duration values with the available idle states and use that
> information to pick up the idle state that is most likely to "match"
> the upcoming CPU idle interval.
> 
> Second, it doesn't take the number of "I/O waiters" into account at
> all and the pattern detection code in it avoids taking timer wakeups
> into account.  It also only uses idle duration values less than the
> current time till the closest timer (with the tick excluded) for that
> purpose.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v5 -> v6:
>  * Avoid applying poll_time_limit to non-polling idle states by mistake.
>  * Use idle duration measured by the governor for everything (as it likely is
>    more accurate than the one measured by the core).
>  * Rename SPIKE to PULSE.
>  * Do not run pattern detection upfront.  Instead, use recent idle duration
>    values to refine the state selection after finding a candidate idle state.
>  * Do not use the expected idle duration as an extra latency constraint
>    (exit latency is less than the target residency for all of the idle states
>    known to me anyway, so this doesn't change anything in practice).
> 
> v4 -> v5:
>  * Avoid using shallow idle states when the tick has been stopped already.
> 
> v3 -> v4:
>  * Make the pattern detection avoid returning too early if the minimum
>    sample is too far from the average.
>  * Reformat the changelog (as requested by Peter).
> 
> v2 -> v3:
>  * Simplify the pattern detection code and make it return a value
> 	lower than the time to the closest timer if the majority of recent
> 	idle intervals are below it regardless of their variance (that should
> 	cause it to be slightly more aggressive).
>  * Do not count wakeups from state 0 due to the time limit in poll_idle()
>    as non-timer.
> 
> [snip]

[NOTE: the tables in this message are quite wide. If this doesn't get to you
properly formatted you can read a copy of this message at the URL
https://beta.suse.com/private/ggherdovich/teo-eval/teo-v6-eval.html ]

All performance concerns manifested in v5 are wiped out by v6. Not only v6
improves over v5, but is even better than the baseline (menu) in most
cases. The optimizations in v6 paid off!

The overview of the analysis for v5, from the message
https://lore.kernel.org/lkml/1541877001.17878.5.camel@suse.cz , was:

> The quick summary is:
> 
> ---> sockperf on loopback over UDP, mode "throughput":
>      this had a 12% regression in v2 on 48x-HASWELL-NUMA, which is completely
>      recovered in v3 and v5. Good stuff.
> 
> ---> dbench on xfs:
>      this was down 16% in v2 on 48x-HASWELL-NUMA. On v5 we're at a 10%
>      regression. Slight improvement. What's really hurting here is the single
>      client scenario.
> 
> ---> netperf-udp on loopback:
>      had 6% regression on v2 on 8x-SKYLAKE-UMA, which is the same as what
>      happens in v5.
> 
> ---> tbench on loopback:
>      was down 10% in v2 on 8x-SKYLAKE-UMA, now slightly worse in v5 with a 12%
>      regression. As in dbench, it's at low number of clients that the results
>      are worst. Note that this machine is different from the one that has the
>      dbench regression.

now the situation is overturned:

---> sockperf on loopback over UDP, mode "throughput":
     No new problems from 48x-HASWELL-NUMA, which stays put at the level of
     the baseline. OTOH 80x-BROADWELL-NUMA and 8x-SKYLAKE-UMA improve over the
     baseline of 8% and 10% respectively.

---> dbench on xfs:
     48x-HASWELL-NUMA rebounds from the previous 10% degradation and it's now
     at 0, i.e. the baseline level. The 1-client case, responsible for the
     previous overall degradation (I average results from different number of
     clients), went from -40% to -20% and is compensated in my table by
     improvements with 4, 8, 16 and 32 clients (table below).

---> netperf-udp on loopback:
     8x-SKYLAKE-UMA now shows a 9% improvement over  baseline.
     80x-BROADWELL-NUMA, previously similar to baseline, now improves 7%.

---> tbench on loopback:
     Impressive change of color for 8x-SKYLAKE-UMA, from 12% regression in v5
     to 7% improvement in v6. The problematic 1- and 2-clients cases went from
     -25% and -33% to +13% and +10% respectively.

Details below.

Runs are compared against v4.18 with the Menu governor. I know v4.18 is a
little old now but that's where I measured my baseline. My machine pool didn't
change:

* single socket E3-1240 v5 (Skylake 8 cores, which I'll call 8x-SKYLAKE-UMA)
* two sockets E5-2698 v4 (Broadwell 80 cores, 80x-BROADWELL-NUMA from here onwards)
* two sockets E5-2670 v3 (Haswell 48 cores, 48x-HASWELL-NUMA from here onwards)


BENCHMARKS WITH NEUTRAL RESULTS
===============================

This is the list of neutral benchmarks, identical to the one for v5. What's
interesting is that the benchmarks showing a degradations in v5 and before
seems now repaired in v6 (and improving baseline!), but the list of neutral
benchmarks didn't move. My take on this is that the list below is not affected
by cpuidle at all, be the gorvernor good or bad. OTOH the benchmarks I discuss
in the next sections are really the ones to use when evaluating cpuidle, as
they are very sensitive to it (frequent idling and waking up, hard-to-predict
interrupt patterns etc).

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
* xfsrepair
    * global-dhp__io-xfsrepair-xfs
* sqlite (insert operations on xfs)
    * global-dhp__db-sqlite-insert-medium-xfs
* schbench
    * global-dhp__workload_schbench
* gitsource on xfs (git unit tests, shell intensive)
    * global-dhp__workload_shellscripts-xfs

Note: global-dhp* are configuration file names for MMTests[1]


PREVIOUSLY REGRESSING BENCHMARKS: OVERVIEW
==========================================

* sockperf on loopback over UDP, mode "throughput"
    * global-dhp__network-sockperf-unbound
    48x-HASWELL-NUMA fixed since v2, the others greatly improved in v6.

                        teo-v1      teo-v2      teo-v3      teo-v5      teo-v6
  -------------------------------------------------------------------------------
  8x-SKYLAKE-UMA        1% worse    1% worse    1% worse    1% worse    10% better
  80x-BROADWELL-NUMA    3% better   2% better   5% better   3% worse    8% better
  48x-HASWELL-NUMA      4% better   12% worse   no change   no change   no change

* dbench on xfs
    * global-dhp__io-dbench4-async-xfs
    48x-HASWELL-NUMA is fixed wrt v5 and earlier versions.

                        teo-v1      teo-v2      teo-v3     teo-v5       teo-v6   
  -------------------------------------------------------------------------------
  8x-SKYLAKE-UMA        3% better   4% better   6% better  4% better    5% better
  80x-BROADWELL-NUMA    no change   no change   1% worse   3% worse     2% better
  48x-HASWELL-NUMA      6% worse    16% worse   8% worse   10% worse    no change 

* netperf on loopback over UDP
    * global-dhp__network-netperf-unbound
    8x-SKYLAKE-UMA fixed.

                        teo-v1      teo-v2      teo-v3     teo-v5       teo-v6   
  -------------------------------------------------------------------------------
  8x-SKYLAKE-UMA        no change   6% worse    4% worse   6% worse     9% better
  80x-BROADWELL-NUMA    1% worse    4% worse    no change  no change    7% better
  48x-HASWELL-NUMA      3% better   5% worse    7% worse   5% worse     no change

* tbench on loopback
    * global-dhp__network-tbench
    Measurable improvements across all machines, especially 8x-SKYLAKE-UMA.

                        teo-v1      teo-v2      teo-v3     teo-v5       teo-v6
  -------------------------------------------------------------------------------
  8x-SKYLAKE-UMA        1% worse    10% worse   11% worse  12% worse    7% better
  80x-BROADWELL-NUMA    1% worse    1% worse    no cahnge  1% worse     4% better
  48x-HASWELL-NUMA      1% worse    2% worse    1% worse   1% worse     5% better


PREVIOUSLY REGRESSING BENCHMARKS: DETAIL
========================================

SOCKPERF-UDP-THROUGHPUT
=======================
NOTES: Test run in mode "throughput" over UDP. The varying parameter is the
    message size.
MEASURES: Throughput, in MBits/second
HIGHER is better

machine: 8x-SKYLAKE-UMA

                              4.18.0                 4.18.0                 4.18.0                 4.18.0                 4.18.0                 4.18.0
                             vanilla                    teo        teo-v2+backport        teo-v3+backport        teo-v5+backport        teo-v6+backport
-------------------------------------------------------------------------------------------------------------------------------------------------------
Hmean     14        70.34 (   0.00%)       69.80 *  -0.76%*       69.11 *  -1.75%*       69.49 *  -1.20%*       69.71 *  -0.90%*       77.51 *  10.20%*
Hmean     100      499.24 (   0.00%)      494.26 *  -1.00%*      492.74 *  -1.30%*      494.90 *  -0.87%*      497.43 *  -0.36%*      549.93 *  10.15%*
Hmean     300     1489.13 (   0.00%)     1472.39 *  -1.12%*     1468.45 *  -1.39%*     1477.74 *  -0.76%*     1478.61 *  -0.71%*     1632.63 *   9.64%*
Hmean     500     2469.62 (   0.00%)     2444.41 *  -1.02%*     2434.61 *  -1.42%*     2454.15 *  -0.63%*     2454.76 *  -0.60%*     2698.70 *   9.28%*
Hmean     850     4165.12 (   0.00%)     4123.82 *  -0.99%*     4100.37 *  -1.55%*     4111.82 *  -1.28%*     4120.04 *  -1.08%*     4521.11 *   8.55%*

In the report I sent for v5 on this benchmark, I posted the table for
48x-HASWELL-NUMA; that one is now uninteresting (v5 fixed it and v6 didn't
change that), so the table above shows the detail for the improvement on
8x-SKYLAKE-UMA.

DBENCH4
=======
NOTES: asyncronous IO; varies the number of clients up to NUMCPUS*8.
MEASURES: latency (millisecs)
LOWER is better

machine: 48x-HASWELL-NUMA
                              4.18.0                 4.18.0                 4.18.0                 4.18.0                 4.18.0                 4.18.0
                             vanilla                    teo        teo-v2+backport        teo-v3+backport        teo-v5+backport        teo-v6+backport
-------------------------------------------------------------------------------------------------------------------------------------------------------
Amean      1        37.15 (   0.00%)       50.10 ( -34.86%)       39.02 (  -5.03%)       52.24 ( -40.63%)       51.62 ( -38.96%)       45.24 ( -21.78%)
Amean      2        43.75 (   0.00%)       45.50 (  -4.01%)       44.36 (  -1.39%)       47.25 (  -8.00%)       44.20 (  -1.03%)       44.30 (  -1.26%)
Amean      4        54.42 (   0.00%)       58.85 (  -8.15%)       58.17 (  -6.89%)       55.12 (  -1.29%)       58.07 (  -6.70%)       52.91 (   2.77%)
Amean      8        75.72 (   0.00%)       74.25 (   1.94%)       82.76 (  -9.30%)       78.63 (  -3.84%)       85.33 ( -12.68%)       70.26 (   7.22%)
Amean      16      116.56 (   0.00%)      119.88 (  -2.85%)      164.14 ( -40.82%)      124.87 (  -7.13%)      124.54 (  -6.85%)      110.95 (   4.81%)
Amean      32      570.02 (   0.00%)      561.92 (   1.42%)      681.94 ( -19.63%)      568.93 (   0.19%)      571.23 (  -0.21%)      543.10 (   4.72%)
Amean      64     3185.20 (   0.00%)     3291.80 (  -3.35%)     4337.43 ( -36.17%)     3181.13 (   0.13%)     3382.48 (  -6.19%)     3186.58 (  -0.04%)

The -21% on 1-client may not look exciting but it's leaps and bounds better
than what was on v5, plus most other num-clients improve measurably.

NETPERF-UDP
===========
NOTES: Test run in mode "stream" over UDP. The varying parameter is the
    message size in bytes. Each measurement is taken 5 times and the
    harmonic mean is reported.
MEASURES: Throughput in MBits/second, both on the sender and on the receiver end.
HIGHER is better

machine: 8x-SKYLAKE-UMA
                                     4.18.0                 4.18.0                 4.18.0                 4.18.0                 4.18.0                 4.18.0
                                    vanilla                    teo        teo-v2+backport        teo-v3+backport        teo-v5+backport        teo-v6+backport
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Hmean     send-64         362.27 (   0.00%)      362.87 (   0.16%)      318.85 * -11.99%*      347.08 *  -4.19%*      333.48 *  -7.95%*      402.61 *  11.13%*
Hmean     send-128        723.17 (   0.00%)      723.66 (   0.07%)      660.96 *  -8.60%*      676.46 *  -6.46%*      650.71 * -10.02%*      796.78 *  10.18%*
Hmean     send-256       1435.24 (   0.00%)     1427.08 (  -0.57%)     1346.22 *  -6.20%*     1359.59 *  -5.27%*     1323.83 *  -7.76%*     1590.55 *  10.82%*
Hmean     send-1024      5563.78 (   0.00%)     5529.90 *  -0.61%*     5228.28 *  -6.03%*     5382.04 *  -3.27%*     5271.99 *  -5.24%*     6117.42 *   9.95%*
Hmean     send-2048     10935.42 (   0.00%)    10809.66 *  -1.15%*    10521.14 *  -3.79%*    10610.29 *  -2.97%*    10544.58 *  -3.57%*    11512.14 *   5.27%*
Hmean     send-3312     16898.66 (   0.00%)    16539.89 *  -2.12%*    16240.87 *  -3.89%*    16271.23 *  -3.71%*    15968.89 *  -5.50%*    17600.72 *   4.15%*
Hmean     send-4096     19354.33 (   0.00%)    19185.43 (  -0.87%)    18600.52 *  -3.89%*    18692.16 *  -3.42%*    18408.69 *  -4.89%*    20494.07 *   5.89%*
Hmean     send-8192     32238.80 (   0.00%)    32275.57 (   0.11%)    29850.62 *  -7.41%*    30066.83 *  -6.74%*    29824.62 *  -7.49%*    35225.60 *   9.26%*
Hmean     send-16384    48146.75 (   0.00%)    49297.23 *   2.39%*    48295.51 (   0.31%)    48800.37 *   1.36%*    48247.73 (   0.21%)    53000.20 *  10.08%*
Hmean     recv-64         362.16 (   0.00%)      362.87 (   0.19%)      318.82 * -11.97%*      347.07 *  -4.17%*      333.48 *  -7.92%*      402.60 *  11.17%*
Hmean     recv-128        723.01 (   0.00%)      723.66 (   0.09%)      660.89 *  -8.59%*      676.39 *  -6.45%*      650.63 * -10.01%*      796.70 *  10.19%*
Hmean     recv-256       1435.06 (   0.00%)     1426.94 (  -0.57%)     1346.07 *  -6.20%*     1359.45 *  -5.27%*     1323.81 *  -7.75%*     1590.55 *  10.84%*
Hmean     recv-1024      5562.68 (   0.00%)     5529.90 *  -0.59%*     5228.28 *  -6.01%*     5381.37 *  -3.26%*     5271.45 *  -5.24%*     6117.42 *   9.97%*
Hmean     recv-2048     10934.36 (   0.00%)    10809.66 *  -1.14%*    10519.89 *  -3.79%*    10610.28 *  -2.96%*    10544.58 *  -3.56%*    11512.14 *   5.28%*
Hmean     recv-3312     16898.65 (   0.00%)    16538.21 *  -2.13%*    16240.86 *  -3.89%*    16269.34 *  -3.72%*    15967.13 *  -5.51%*    17598.31 *   4.14%*
Hmean     recv-4096     19351.99 (   0.00%)    19183.17 (  -0.87%)    18598.33 *  -3.89%*    18690.13 *  -3.42%*    18407.45 *  -4.88%*    20489.99 *   5.88%*
Hmean     recv-8192     32238.74 (   0.00%)    32275.13 (   0.11%)    29850.39 *  -7.41%*    30062.78 *  -6.75%*    29824.30 *  -7.49%*    35221.61 *   9.25%*
Hmean     recv-16384    48146.59 (   0.00%)    49296.23 *   2.39%*    48295.03 (   0.31%)    48786.88 *   1.33%*    48246.71 (   0.21%)    52993.72 *  10.07%*

Recovered!

TBENCH4
=======
NOTES: networking counterpart of dbench. Varies the number of clients up to NUMCPUS*4
MEASURES: Throughput, MB/sec
HIGHER is better

machine: 8x-SKYLAKE-UMA
                                    4.18.0                 4.18.0                 4.18.0                 4.18.0                 4.18.0                 4.18.0
                                   vanilla                    teo        teo-v2+backport        teo-v3+backport        teo-v5+backport        teo-v6+backport
-------------------------------------------------------------------------------------------------------------------------------------------------------------
Hmean     mb/sec-1       620.52 (   0.00%)      613.98 *  -1.05%*      502.47 * -19.03%*      492.77 * -20.59%*      464.52 * -25.14%*      705.89 *  13.76%*
Hmean     mb/sec-2      1179.05 (   0.00%)     1112.84 *  -5.62%*      820.57 * -30.40%*      831.23 * -29.50%*      780.97 * -33.76%*     1303.87 *  10.59%*
Hmean     mb/sec-4      2072.29 (   0.00%)     2040.55 *  -1.53%*     2036.11 *  -1.75%*     2016.97 *  -2.67%*     2019.79 *  -2.53%*     2164.66 *   4.46%*
Hmean     mb/sec-8      4238.96 (   0.00%)     4205.01 *  -0.80%*     4124.59 *  -2.70%*     4098.06 *  -3.32%*     4171.64 *  -1.59%*     4354.18 *   2.72%*
Hmean     mb/sec-16     3515.96 (   0.00%)     3536.23 *   0.58%*     3500.02 *  -0.45%*     3438.60 *  -2.20%*     3456.89 *  -1.68%*     3688.76 *   4.91%*
Hmean     mb/sec-32     3452.92 (   0.00%)     3448.94 *  -0.12%*     3428.08 *  -0.72%*     3369.30 *  -2.42%*     3430.09 *  -0.66%*     3574.24 *   3.51%*

This one, too, not only is fixed but adds a solid improvement over the
baseline.


[1] https://github.com/gormanm/mmtests

Giovanni
