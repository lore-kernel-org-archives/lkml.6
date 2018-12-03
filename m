Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F96C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9AD20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9AD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbeLCXiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:38:12 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58648 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeLCXiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:38:12 -0500
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id ccbf22903c850045; Tue, 4 Dec 2018 00:38:09 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor for tickless systems
Date:   Tue, 04 Dec 2018 00:37:59 +0100
Message-ID: <11789360.4ZIsHu7b6a@aspire.rjw.lan>
In-Reply-To: <1543673904.3452.2.camel@suse.cz>
References: <42865872.dmYH3PmblP@aspire.rjw.lan> <1543673904.3452.2.camel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, December 1, 2018 3:18:24 PM CET Giovanni Gherdovich wrote:
> On Fri, 2018-11-23 at 11:35 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 

[cut]

> > 
> > [snip]
> 
> [NOTE: the tables in this message are quite wide. If this doesn't get to you
> properly formatted you can read a copy of this message at the URL
> https://beta.suse.com/private/ggherdovich/teo-eval/teo-v6-eval.html ]
> 
> All performance concerns manifested in v5 are wiped out by v6. Not only v6
> improves over v5, but is even better than the baseline (menu) in most
> cases. The optimizations in v6 paid off!

This is very encouraging, thank you!

> The overview of the analysis for v5, from the message
> https://lore.kernel.org/lkml/1541877001.17878.5.camel@suse.cz , was:
> 
> > The quick summary is:
> > 
> > ---> sockperf on loopback over UDP, mode "throughput":
> >      this had a 12% regression in v2 on 48x-HASWELL-NUMA, which is completely
> >      recovered in v3 and v5. Good stuff.
> > 
> > ---> dbench on xfs:
> >      this was down 16% in v2 on 48x-HASWELL-NUMA. On v5 we're at a 10%
> >      regression. Slight improvement. What's really hurting here is the single
> >      client scenario.
> > 
> > ---> netperf-udp on loopback:
> >      had 6% regression on v2 on 8x-SKYLAKE-UMA, which is the same as what
> >      happens in v5.
> > 
> > ---> tbench on loopback:
> >      was down 10% in v2 on 8x-SKYLAKE-UMA, now slightly worse in v5 with a 12%
> >      regression. As in dbench, it's at low number of clients that the results
> >      are worst. Note that this machine is different from the one that has the
> >      dbench regression.
> 
> now the situation is overturned:
> 
> ---> sockperf on loopback over UDP, mode "throughput":
>      No new problems from 48x-HASWELL-NUMA, which stays put at the level of
>      the baseline. OTOH 80x-BROADWELL-NUMA and 8x-SKYLAKE-UMA improve over the
>      baseline of 8% and 10% respectively.

Good.

> ---> dbench on xfs:
>      48x-HASWELL-NUMA rebounds from the previous 10% degradation and it's now
>      at 0, i.e. the baseline level. The 1-client case, responsible for the
>      previous overall degradation (I average results from different number of
>      clients), went from -40% to -20% and is compensated in my table by
>      improvements with 4, 8, 16 and 32 clients (table below).
> 
> ---> netperf-udp on loopback:
>      8x-SKYLAKE-UMA now shows a 9% improvement over  baseline.
>      80x-BROADWELL-NUMA, previously similar to baseline, now improves 7%.

Good.

> ---> tbench on loopback:
>      Impressive change of color for 8x-SKYLAKE-UMA, from 12% regression in v5
>      to 7% improvement in v6. The problematic 1- and 2-clients cases went from
>      -25% and -33% to +13% and +10% respectively.

Awesome. :-)

> Details below.
> 
> Runs are compared against v4.18 with the Menu governor. I know v4.18 is a
> little old now but that's where I measured my baseline. My machine pool didn't
> change:
> 
> * single socket E3-1240 v5 (Skylake 8 cores, which I'll call 8x-SKYLAKE-UMA)
> * two sockets E5-2698 v4 (Broadwell 80 cores, 80x-BROADWELL-NUMA from here onwards)
> * two sockets E5-2670 v3 (Haswell 48 cores, 48x-HASWELL-NUMA from here onwards)
> 

[cut]

> 
> 
> PREVIOUSLY REGRESSING BENCHMARKS: OVERVIEW
> ==========================================
> 
> * sockperf on loopback over UDP, mode "throughput"
>     * global-dhp__network-sockperf-unbound
>     48x-HASWELL-NUMA fixed since v2, the others greatly improved in v6.
> 
>                         teo-v1      teo-v2      teo-v3      teo-v5      teo-v6
>   -------------------------------------------------------------------------------
>   8x-SKYLAKE-UMA        1% worse    1% worse    1% worse    1% worse    10% better
>   80x-BROADWELL-NUMA    3% better   2% better   5% better   3% worse    8% better
>   48x-HASWELL-NUMA      4% better   12% worse   no change   no change   no change
> 
> * dbench on xfs
>     * global-dhp__io-dbench4-async-xfs
>     48x-HASWELL-NUMA is fixed wrt v5 and earlier versions.
> 
>                         teo-v1      teo-v2      teo-v3     teo-v5       teo-v6   
>   -------------------------------------------------------------------------------
>   8x-SKYLAKE-UMA        3% better   4% better   6% better  4% better    5% better
>   80x-BROADWELL-NUMA    no change   no change   1% worse   3% worse     2% better
>   48x-HASWELL-NUMA      6% worse    16% worse   8% worse   10% worse    no change 
> 
> * netperf on loopback over UDP
>     * global-dhp__network-netperf-unbound
>     8x-SKYLAKE-UMA fixed.
> 
>                         teo-v1      teo-v2      teo-v3     teo-v5       teo-v6   
>   -------------------------------------------------------------------------------
>   8x-SKYLAKE-UMA        no change   6% worse    4% worse   6% worse     9% better
>   80x-BROADWELL-NUMA    1% worse    4% worse    no change  no change    7% better
>   48x-HASWELL-NUMA      3% better   5% worse    7% worse   5% worse     no change
> 
> * tbench on loopback
>     * global-dhp__network-tbench
>     Measurable improvements across all machines, especially 8x-SKYLAKE-UMA.
> 
>                         teo-v1      teo-v2      teo-v3     teo-v5       teo-v6
>   -------------------------------------------------------------------------------
>   8x-SKYLAKE-UMA        1% worse    10% worse   11% worse  12% worse    7% better
>   80x-BROADWELL-NUMA    1% worse    1% worse    no cahnge  1% worse     4% better
>   48x-HASWELL-NUMA      1% worse    2% worse    1% worse   1% worse     5% better

So I'm really happy with this, but I'm afraid that the v6 may be a little too
agressive.  Also my testing (with the "low" and "high" counters introduced by
https://patchwork.kernel.org/patch/10709463/) shows that it generally is
a bit worse than menu with respect to matching the observed idle duration
as it tends to prefer shallower states.  This appears to be in agreement with
the Doug's results too.

For this reason, I'm going to send a v7 with a few changes relative to v6 to
make it somewhat more energy-efficient.  If it turns out to be much worse than
the v6 performance-wise, though, the v6 may be a winner. :-)

Thanks,
Rafael



