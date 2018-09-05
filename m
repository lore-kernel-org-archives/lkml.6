Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E704AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9918820658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9918820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeIEK2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:28:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:49646 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbeIEK2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:28:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 22:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,332,1531810800"; 
   d="scan'208";a="78071019"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.97.104])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2018 22:59:18 -0700
Message-ID: <8c56f28c2cc11de37fa3517348559eb040894702.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Francisco Jerez <currojerez@riseup.net>,
        Eero Tamminen <eero.t.tamminen@intel.com>, lenb@kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     mgorman@techsingularity.net, ggherdovich@suse.cz,
        peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Sep 2018 22:59:12 -0700
In-Reply-To: <8736uobu7w.fsf@riseup.net>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com>
         <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com>
         <8736upda8s.fsf@riseup.net>
         <b48340f59011bc3d7402b6a811bce4fa861fab7b.camel@linux.intel.com>
         <8736uobu7w.fsf@riseup.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

> > > 
> > > This patch causes a number of statistically significant
> > > regressions
> > > (with significance of 1%) on the two systems I've tested it
> > > on.  On
> > > my
> > 
> > Sure. These patches are targeted to Atom clients where some of
> > these
> > server like workload may have some minor regression on few watts
> > TDP
> > parts.
> 
> Neither the 36% regression of fs-mark, the 21% regression of sqlite,
> nor
> the 10% regression of warsaw qualify as small.  And most of the test
> cases on the list of regressions aren't exclusively server-like, if
> at
> all.  Warsaw, gtkperf, jxrendermark and lightsmark are all graphics
> benchmarks -- Latency is as important if not more for interactive
> workloads than it is for server workloads.  In the case of a conflict
> like the one we're dealing with right now between optimizing for
> throughput (e.g. for the maximum number of requests per second) and
> optimizing for latency (e.g. for the minimum request duration), you
> are
> more likely to be concerned about the former than about the latter in
> a
> server setup.

Eero,
Please add your test results here.

No matter which algorithm you do, there will be variations. So you have
to look at the platforms which you are targeting. For this platform 
number one item is use of less turbo and hope you know why?
On this platform GFX patch caused this issue as it was submitted after
io boost patchset. So rather that should be reverted first before
optimizing anything.


> 
> > But weighing against reduced TURBO usage (which is enough trigger)
> > and
> > improvement in tests done by Eero (which was primary complaint to
> > us).
> > 
> > It is trivial patch. Yes, the patch is not perfect and doesn't
> > close
> > doors for any improvements.
> > 
> 
> It's sort of self-contained because it's awfully incomplete.Don't
> agtr

> 
> > I see your idea, but how to implement in acceptable way is a
> > challenge.
> 
> Main challenge was getting the code to work without regressions in
> latency-sensitive workloads, which I did, because you told me that it
> wasn't acceptable for it to cause any regressions on the Phoronix
> daily-system-tracker, whether latency-bound or not.
Yes, because your intention was to have a global change not a low power
Atom specific,

>   What is left in
> order to address Peter's concerns is for the most part plumbing,
> that's
> guaranteed not to have any functional impact on the heuristic.  The
> fact
> that we don't expect it to change the performance of the system makes
> it
> substantially less time-consuming to validate than altering the
> performance trade-offs of the heuristic dynamically in order to avoid
> regressions (which is what has kept my systems busy most of the time
> lately).  Seems like my series, even in its current state without the
> changes requested by Peter is closer to being ready for production
> than
> this patch is.

Sorry, Not at all. We call such patches as experimental series.
You caused 100% regression to idle power. There is no version 2 after
that, even if you fixed locally even to look.

Thanks,
Srinivas

