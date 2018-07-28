Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85C5C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 12:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768FB20873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 12:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768FB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeG1ODF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 10:03:05 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:41396 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728115AbeG1ODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 10:03:05 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 22F8E1C1D32
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 13:36:40 +0100 (IST)
Received: (qmail 16350 invoked from network); 28 Jul 2018 12:36:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.66])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 28 Jul 2018 12:36:39 -0000
Date:   Sat, 28 Jul 2018 13:36:39 +0100
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
Message-ID: <20180728123639.7ckv3ljnei3urn6m@techsingularity.net>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
 <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
 <87bmarhqk4.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87bmarhqk4.fsf@riseup.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:34:03PM -0700, Francisco Jerez wrote:
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
> 
> > Enable HWP boost on Skylake server and workstations.
> >
> 
> Please revert this series, it led to significant energy usage and
> graphics performance regressions [1].  The reasons are roughly the ones
> we discussed by e-mail off-list last April: This causes the intel_pstate
> driver to decrease the EPP to zero when the workload blocks on IO
> frequently enough, which for the regressing benchmarks detailed in [1]
> is a symptom of the workload being heavily IO-bound, which means they
> won't benefit at all from the EPP boost since they aren't significantly
> CPU-bound, and they will suffer a decrease in parallelism due to the
> active CPU core using a larger fraction of the TDP in order to achieve
> the same work, causing the GPU to have a lower power budget available,
> leading to a decrease in system performance.

It slices both ways. With the series, there are large boosts to
performance on other workloads where a slight increase in power usage is
acceptable in exchange for performance. For example,

Single socket skylake running sqlite
                                 v4.17               41ab43c9
Min       Trans     2580.85 (   0.00%)     5401.58 ( 109.29%)
Hmean     Trans     2610.38 (   0.00%)     5518.36 ( 111.40%)
Stddev    Trans       28.08 (   0.00%)      208.90 (-644.02%)
CoeffVar  Trans        1.08 (   0.00%)        3.78 (-251.57%)
Max       Trans     2648.02 (   0.00%)     5992.74 ( 126.31%)
BHmean-50 Trans     2629.78 (   0.00%)     5643.81 ( 114.61%)
BHmean-95 Trans     2620.38 (   0.00%)     5538.32 ( 111.36%)
BHmean-99 Trans     2620.38 (   0.00%)     5538.32 ( 111.36%)

That's over doubling the transactions per second for that workload.

Two-socket skylake running dbench4
                                v4.17               41ab43c9
Amean      1         40.85 (   0.00%)       14.97 (  63.36%)
Amean      2         42.31 (   0.00%)       17.33 (  59.04%)
Amean      4         53.77 (   0.00%)       27.85 (  48.20%)
Amean      8         68.86 (   0.00%)       43.78 (  36.42%)
Amean      16        82.62 (   0.00%)       56.51 (  31.60%)
Amean      32       135.80 (   0.00%)      116.06 (  14.54%)
Amean      64       737.51 (   0.00%)      701.00 (   4.95%)
Amean      512    14996.60 (   0.00%)    14755.05 (   1.61%)

This is reporting the average latency of operations running dbench. The
series over halves the latencies. There are many examples of basic
workloads that benefit heavily from the series and while I accept it may
not be universal, such as the case where the graphics card needs the power
and not the CPU, a straight revert is not the answer. Without the series,
HWP cripplies the CPU.

-- 
Mel Gorman
SUSE Labs
