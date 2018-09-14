Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D50ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFCA20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFCA20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeINOOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:14:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57896 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeINOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:14:46 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 75e89f42b2dab708; Fri, 14 Sep 2018 11:01:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>, lenb@kernel.org,
        viresh.kumar@linaro.org, mgorman@techsingularity.net,
        ggherdovich@suse.cz, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
Date:   Fri, 14 Sep 2018 10:58:31 +0200
Message-ID: <2646540.WJ9HbOajLd@aspire.rjw.lan>
In-Reply-To: <87in3c7x9o.fsf@riseup.net>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com> <23293649.J1qzPCXian@aspire.rjw.lan> <87in3c7x9o.fsf@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 11, 2018 7:35:15 PM CEST Francisco Jerez wrote:
>
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> > On Thursday, September 6, 2018 6:20:08 AM CEST Francisco Jerez wrote:
> >
> >> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
> >>=20
> >> > [...]
> >> >
> >> >> > >=3D20
> >> >> > > This patch causes a number of statistically significant
> >> >> > > regressions
> >> >> > > (with significance of 1%) on the two systems I've tested it
> >> >> > > on.  On
> >> >> > > my
> >> >> >=3D20
> >> >> > Sure. These patches are targeted to Atom clients where some of
> >> >> > these
> >> >> > server like workload may have some minor regression on few watts
> >> >> > TDP
> >> >> > parts.
> >> >>=3D20
> >> >> Neither the 36% regression of fs-mark, the 21% regression of sqlite,
> >> >> nor
> >> >> the 10% regression of warsaw qualify as small.  And most of the test
> >> >> cases on the list of regressions aren't exclusively server-like, if
> >> >> at
> >> >> all.  Warsaw, gtkperf, jxrendermark and lightsmark are all graphics
> >> >> benchmarks -- Latency is as important if not more for interactive
> >> >> workloads than it is for server workloads.  In the case of a conflict
> >> >> like the one we're dealing with right now between optimizing for
> >> >> throughput (e.g. for the maximum number of requests per second) and
> >> >> optimizing for latency (e.g. for the minimum request duration), you
> >> >> are
> >> >> more likely to be concerned about the former than about the latter in
> >> >> a
> >> >> server setup.
> >> >
> >> > Eero,
> >> > Please add your test results here.
> >> >
> >> > No matter which algorithm you do, there will be variations. So you have
> >> > to look at the platforms which you are targeting. For this platform=3D=
> 20
> >> > number one item is use of less turbo and hope you know why?
> >>=20
> >> Unfortunately the current controller uses turbo frequently on Atoms for
> >> TDP-limited graphics workloads regardless of IOWAIT boosting.  IOWAIT
> >> boosting simply exacerbated the pre-existing energy efficiency problem.
> >
> > My current understanding of the issue at hand is that using IOWAIT boosti=
> ng
> > on Atoms is a regression relative to the previous behavior.
> 
> Not universally.  IOWAIT boosting helps under roughly the same
> conditions on Atom as it does on big core, so applying this patch will
> necessarily cause regressions too (see my reply from Sep. 3 for some
> numbers), and won't completely restore the previous behavior since it
> simply decreases the degree of IOWAIT boosting applied without being
> able to avoid it (c.f. the series I'm working on that does something
> similar to IOWAIT boosting when it's able to determine it's actually
> CPU-bound, which prevents energy inefficient behavior for non-CPU-bound
> workloads that don't benefit from a higher CPU clock frequency anyway).

Well, OK.  That doesn't seem to be a clear-cut regression situation, then,
since getting back is not desirable, apparently.

Or would it restore the previous behavior if we didn't do any IOWAIT
boosting on Atoms at all?

> > That is what Srinivas is trying to address here AFAICS.
> >
> > Now, you seem to be saying that the overall behavior is suboptimal and the
> > IOWAIT boosting doesn't matter that much,
> 
> I was just saying that IOWAIT boosting is less than half of the energy
> efficiency problem, and this patch only partially addresses that half of
> the problem.

Well, fair enough, but there are two things to consider here, the general
energy-efficiency problem and the difference made by IOWAIT boosting.

If the general energy-efficiency problem had existed for a relatively long
time, but it has got worse recently due to the IOWAIT boosting, it still
may be desirable to get the IOWAIT boosting out of the picture first
and then get to the general problem.

I'm not sure if that is the case as my experience with Atoms is limited
anyway, so please advise.

Thanks,
Rafael

