Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBD1160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C612B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C612B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeG3RTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:19:24 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:43368 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbeG3RTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:19:24 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id E23621C1ECA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 16:43:48 +0100 (IST)
Received: (qmail 7637 invoked from network); 30 Jul 2018 15:43:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.66])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 30 Jul 2018 15:43:48 -0000
Date:   Mon, 30 Jul 2018 16:43:47 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org,
        ggherdovich@suse.cz, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
Message-ID: <20180730154347.wrcrkweckclgbyrp@techsingularity.net>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
 <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
 <87bmarhqk4.fsf@riseup.net>
 <20180728123639.7ckv3ljnei3urn6m@techsingularity.net>
 <87r2jnf6w0.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87r2jnf6w0.fsf@riseup.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 01:21:51PM -0700, Francisco Jerez wrote:
> >> Please revert this series, it led to significant energy usage and
> >> graphics performance regressions [1].  The reasons are roughly the ones
> >> we discussed by e-mail off-list last April: This causes the intel_pstate
> >> driver to decrease the EPP to zero when the workload blocks on IO
> >> frequently enough, which for the regressing benchmarks detailed in [1]
> >> is a symptom of the workload being heavily IO-bound, which means they
> >> won't benefit at all from the EPP boost since they aren't significantly
> >> CPU-bound, and they will suffer a decrease in parallelism due to the
> >> active CPU core using a larger fraction of the TDP in order to achieve
> >> the same work, causing the GPU to have a lower power budget available,
> >> leading to a decrease in system performance.
> >
> > It slices both ways.
> 
> I don't think it's acceptable to land an optimization that trades
> performance of one use-case for another,

The same logic applies to a revert but that aside, I see that there is
at least one patch floating around to disable HWP Boost for desktops and
laptops. Maybe that'll be sufficient for the cases where IGP is a major
component.

> especially since one could make
> both use-cases happy by avoiding the boost in cases where we know
> beforehand that we aren't going to achieve any improvement in
> performance, because an application waiting frequently on an IO device
> which is 100% utilized isn't going to run faster just because we ramp up
> the CPU frequency, since the IO device won't be able to process requests
> from the application faster anyway, so we will only be pessimizing
> energy efficiency (and potentially decreasing performance of the GPU
> *and* of other CPU cores living on the same package for no benefit).
> 

The benchmarks in question are not necessarily utilising IO at 100% or
IO-bound. One pattern is a small fsync which ends up context switching
between the process and a journalling thread (may be dedicated thread, may be
workqueue depending on filesystem) and the process waking again in the very
near future on IO completion. While the workload may be single threaded,
more than one core is in use because of how the short sleeps migrate the
task to other cores.  HWP does not necessarily notice that the task is
quite CPU-intensive due to the migrations and so the performance suffers.

Some effort is made to minimise the number of cores used with this sort
of waker/wakee relationship but it's not necessarily enough for HWP to
boost the frequency.  Minimally, the journalling thread woken up will
not wake on the same CPU as the IO issuer except under extremely heavily
utilisation and this is not likely to change (stacking stacks too often
increases wakeup latency).

> > With the series, there are large boosts to performance on other
> > workloads where a slight increase in power usage is acceptable in
> > exchange for performance. For example,
> >
> > Single socket skylake running sqlite
> >                                  v4.17               41ab43c9
> > Min       Trans     2580.85 (   0.00%)     5401.58 ( 109.29%)
> > Hmean     Trans     2610.38 (   0.00%)     5518.36 ( 111.40%)
> > Stddev    Trans       28.08 (   0.00%)      208.90 (-644.02%)
> > CoeffVar  Trans        1.08 (   0.00%)        3.78 (-251.57%)
> > Max       Trans     2648.02 (   0.00%)     5992.74 ( 126.31%)
> > BHmean-50 Trans     2629.78 (   0.00%)     5643.81 ( 114.61%)
> > BHmean-95 Trans     2620.38 (   0.00%)     5538.32 ( 111.36%)
> > BHmean-99 Trans     2620.38 (   0.00%)     5538.32 ( 111.36%)
> >
> > That's over doubling the transactions per second for that workload.
> >
> > Two-socket skylake running dbench4
> >                                 v4.17               41ab43c9
> > Amean      1         40.85 (   0.00%)       14.97 (  63.36%)
> > Amean      2         42.31 (   0.00%)       17.33 (  59.04%)
> > Amean      4         53.77 (   0.00%)       27.85 (  48.20%)
> > Amean      8         68.86 (   0.00%)       43.78 (  36.42%)
> > Amean      16        82.62 (   0.00%)       56.51 (  31.60%)
> > Amean      32       135.80 (   0.00%)      116.06 (  14.54%)
> > Amean      64       737.51 (   0.00%)      701.00 (   4.95%)
> > Amean      512    14996.60 (   0.00%)    14755.05 (   1.61%)
> >
> > This is reporting the average latency of operations running
> > dbench. The series over halves the latencies. There are many examples
> > of basic workloads that benefit heavily from the series and while I
> > accept it may not be universal, such as the case where the graphics
> > card needs the power and not the CPU, a straight revert is not the
> > answer. Without the series, HWP cripplies the CPU.
> >
> 
> That seems like a huge overstatement.  HWP doesn't "cripple" the CPU
> without this series.  It will certainly set lower clocks than with this
> series for workloads like you show above that utilize the CPU very
> intermittently (i.e. they underutilize it). 

Dbench for example can be quite CPU intensive. When bound to a single
core, it shows up to 80% utilisation of a single core. When unbound,
the usage of individual cores appears low due to the migrations. It may
be intermittent usage as it context switches to worker threads but it's
not low utilisation either.

intel_pstate also had logic for IO-boosting before HWP so the user-visible
impact for some workloads is that upgrading a machine's CPU can result
in regressions due to HWP. Similarly it has been observed prior to the
series that specifying no_hwp often performed better. So one could argue
that HWP isn't "crippled" but it did have surprising behaviour.

-- 
Mel Gorman
SUSE Labs
