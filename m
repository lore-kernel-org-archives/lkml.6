Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8D4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E0B20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E0B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeGaIpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:45:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727241AbeGaIpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:45:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9746DAFCD;
        Tue, 31 Jul 2018 07:06:26 +0000 (UTC)
Message-ID: <1533021001.3300.2.camel@suse.cz>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Francisco Jerez <currojerez@riseup.net>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, viresh.kumar@linaro.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Date:   Tue, 31 Jul 2018 09:10:01 +0200
In-Reply-To: <87lg9sefrb.fsf@riseup.net>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
         <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
         <87bmarhqk4.fsf@riseup.net>
         <20180728123639.7ckv3ljnei3urn6m@techsingularity.net>
         <87r2jnf6w0.fsf@riseup.net>
         <20180730154347.wrcrkweckclgbyrp@techsingularity.net>
         <87lg9sefrb.fsf@riseup.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 11:32 -0700, Francisco Jerez wrote:
> Mel Gorman <mgorman@techsingularity.net> writes:
> 
> > On Sat, Jul 28, 2018 at 01:21:51PM -0700, Francisco Jerez wrote:
> > > > > Please revert this series, it led to significant energy usage and
> > > > > graphics performance regressions [1].  The reasons are roughly the ones
> > > > > we discussed by e-mail off-list last April: This causes the intel_pstate
> > > > > driver to decrease the EPP to zero when the workload blocks on IO
> > > > > frequently enough, which for the regressing benchmarks detailed in [1]
> > > > > is a symptom of the workload being heavily IO-bound, which means they
> > > > > won't benefit at all from the EPP boost since they aren't significantly
> > > > > CPU-bound, and they will suffer a decrease in parallelism due to the
> > > > > active CPU core using a larger fraction of the TDP in order to achieve
> > > > > the same work, causing the GPU to have a lower power budget available,
> > > > > leading to a decrease in system performance.
> > > > 
> > > > It slices both ways.
> > > 
> > > I don't think it's acceptable to land an optimization that trades
> > > performance of one use-case for another,
> > 
> > The same logic applies to a revert
> 
> No, it doesn't, the responsibility of addressing the fallout from a
> change that happens to hurt performance even though it was supposed to
> improve it lies on the author of the change, not on the reporter of the
> regression.

The server and desktop worlds have different characteristics and needs, which
in this particular case appear to be conflicting. Luckily we can can
differentiate the two scenarios (as in the bugfix patch by Srinivas a few
hours ago).

> The task scheduler does go through the effort of attempting to re-use
> the most frequently active CPU when a task wakes up, at least last time
> I checked.

Unfortunately that doesn't happen in practice; the load balancer in the
scheduler is in a constant tension between spreading tasks evenly across all
cores (necessary when the machine is under heavy load) and packing on just a
few (which makes more sense when only a few threads are working and the box is
almost idle otherwise). Recent evolutions favour spreading. We often observe
tasks helplessly bounce from core to core losing all their accrued utilisation
score, and intel_pstate (with or without HWP) penalizes that.

On Mon, 2018-07-30 at 11:32 -0700, Francisco Jerez wrote:
> Mel Gorman <mgorman@techsingularity.net> writes:
>
> [...]
> > One pattern is a small fsync which ends up context switching between
> > the process and a journalling thread (may be dedicated thread, may be
> > workqueue depending on filesystem) and the process waking again in the
> > very near future on IO completion. While the workload may be single
> > threaded, more than one core is in use because of how the short sleeps
> > migrate the task to other cores.  HWP does not necessarily notice that
> > the task is quite CPU-intensive due to the migrations and so the
> > performance suffers.
> > 
> > Some effort is made to minimise the number of cores used with this sort
> > of waker/wakee relationship but it's not necessarily enough for HWP to
> > boost the frequency.  Minimally, the journalling thread woken up will
> > not wake on the same CPU as the IO issuer except under extremely heavily
> > utilisation and this is not likely to change (stacking stacks too often
> > increases wakeup latency).
> > 
> 
> The task scheduler does go through the effort of attempting to re-use
> the most frequently active CPU when a task wakes up, at least last time
> I checked.  But yes some migration patterns can exacerbate the downward
> bias of the response of the HWP to an intermittent workload, primarily
> in cases where the application is unable to take advantage of the
> parallelism between CPU and the IO device involved, like you're
> describing above.

Unfortunately that doesn't happen in practice; the load balancer in the
scheduler is in a constant tension between spreading tasks evenly across all
cores (necessary when the machine is under heavy load) and packing on just a
few (which makes more sense when only a few threads are working and the box is
idle otherwise). Recent evolutions favour spreading. We often observe tasks
helplessly bounce from core to core losing all their accrued utilization
score, and intel_pstate (with or without HWP) penalizes that.

That's why in our distro SLES-15 (which is based on 4.12.14) we're sporting a
patch like this:
https://kernel.opensuse.org/cgit/kernel/commit/?h=SLE15&id=3a287868cb7a9 which
boosts tasks that have been placed on a previously idle CPU. We haven't even
proposed this patch upstream as we hope to solve those problems at a more
fundamental level, but when you're supporting power management (freq scaling)
in the server world you get compared to the performance governor, so your
policy needs to be aggressive.

> 
> > > > With the series, there are large boosts to performance on other
> > > > workloads where a slight increase in power usage is acceptable in
> > > > exchange for performance. For example,
> > > > 
> > > > Single socket skylake running sqlite
> > > >                                  v4.17               41ab43c9
> > > > Min       Trans     2580.85 (   0.00%)     5401.58 ( 109.29%)
> > > > Hmean     Trans     2610.38 (   0.00%)     5518.36 ( 111.40%)
> > > > Stddev    Trans       28.08 (   0.00%)      208.90 (-644.02%)
> > > > CoeffVar  Trans        1.08 (   0.00%)        3.78 (-251.57%)
> > > > Max       Trans     2648.02 (   0.00%)     5992.74 ( 126.31%)
> > > > BHmean-50 Trans     2629.78 (   0.00%)     5643.81 ( 114.61%)
> > > > BHmean-95 Trans     2620.38 (   0.00%)     5538.32 ( 111.36%)
> > > > BHmean-99 Trans     2620.38 (   0.00%)     5538.32 ( 111.36%)
> > > > 
> > > > That's over doubling the transactions per second for that workload.
> > > > 
> > > > Two-socket skylake running dbench4
> > > >                                 v4.17               41ab43c9
> > > > Amean      1         40.85 (   0.00%)       14.97 (  63.36%)
> > > > Amean      2         42.31 (   0.00%)       17.33 (  59.04%)
> > > > Amean      4         53.77 (   0.00%)       27.85 (  48.20%)
> > > > Amean      8         68.86 (   0.00%)       43.78 (  36.42%)
> > > > Amean      16        82.62 (   0.00%)       56.51 (  31.60%)
> > > > Amean      32       135.80 (   0.00%)      116.06 (  14.54%)
> > > > Amean      64       737.51 (   0.00%)      701.00 (   4.95%)
> > > > Amean      512    14996.60 (   0.00%)    14755.05 (   1.61%)
> > > > 
> > > > This is reporting the average latency of operations running
> > > > dbench. The series over halves the latencies. There are many examples
> > > > of basic workloads that benefit heavily from the series and while I
> > > > accept it may not be universal, such as the case where the graphics
> > > > card needs the power and not the CPU, a straight revert is not the
> > > > answer. Without the series, HWP cripplies the CPU.
> > > > 
> > > 
> > > That seems like a huge overstatement.  HWP doesn't "cripple" the CPU
> > > without this series.  It will certainly set lower clocks than with this
> > > series for workloads like you show above that utilize the CPU very
> > > intermittently (i.e. they underutilize it). 
> > 
> > Dbench for example can be quite CPU intensive. When bound to a single
> > core, it shows up to 80% utilisation of a single core.
> 
> So even with an oracle cpufreq governor able to guess that the
> application relies on the CPU being locked to the maximum frequency
> despite it utilizing less than 80% of the CPU cycles, the application
> will still perform 20% worse than an alternative application handling
> its IO work asynchronously.

It's a matter of being pragmatic. You're saying that a given application is
badly designed and should be rewritten to leverage parallelism between CPU and
IO. But in the field you *have* applications that behave that way, and the OS
is in a position to do something to mitigate the damage.

> 
> > When unbound, the usage of individual cores appears low due to the
> > migrations. It may be intermittent usage as it context switches to
> > worker threads but it's not low utilisation either.
> > 
> > intel_pstate also had logic for IO-boosting before HWP 
> 
> The IO-boosting logic of the intel_pstate governor has the same flaw as
> this unfortunately.
>

Again it's a matter of pragmatism. You'll find that another governor uses
IO-boosting: schedutil. And while intel_pstate needs it because it gets
otherwise killed by migrating tasks, schedutil is based on the PELT
utilization signal and doesn't have that problem at all. The principle there
is plain and simple: if I've been "wasting time" waiting on "slow" IO (disk),
that probably means I'm getting late and there is soon some compute to do:
better catch up on the lost time and speed up. IO-wait boosting on schedutil
was discussed at
https://lore.kernel.org/lkml/3752826.3sXAQIvcIA@vostro.rjw.lan/


Giovanni Gherdovich
SUSE Labs
