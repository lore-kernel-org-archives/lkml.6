Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1492C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD7C22360
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD7C22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeKONCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:02:25 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49957 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKONCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 08:02:25 -0500
Received: from 64.114.255.114 (64.114.255.114) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 2012e768b2f7a9c1; Thu, 15 Nov 2018 03:56:25 +0100
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
Subject: Re: [RFC/RFT][PATCH v5] cpuidle: New timer events oriented governor for tickless systems
Date:   Thu, 15 Nov 2018 03:56:33 +0100
Message-ID: <9662418.c5ysHFetnm@aspire.rjw.lan>
In-Reply-To: <1541877001.17878.5.camel@suse.cz>
References: <102783770.7hZjAahU8c@aspire.rjw.lan> <1541877001.17878.5.camel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, November 10, 2018 8:10:01 PM CET Giovanni Gherdovich wrote:
> On Thu, 2018-11-08 at 18:25 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] cpuidle: New timer events oriented governor for tickless systems
> > 

[cut]

> [NOTE: the tables in this message are quite wide, ~130 columns. If this
> doesn't get to you properly formatted you can read a copy of this message at
> the URL https://beta.suse.com/private/ggherdovich/teo-eval/teo-eval.html ]
> 
> 
> Hello Rafael,
> 
> I have results for v3 and v5. Regarding v4, I made a mistake and didn't get
> valid data; as I saw v5 coming shortly after, I didn't rerun v4.
> 
> I'm replying to the v5 thread because that's where these results belong, but
> I'm quoting your text from the v2 email at
> https://lore.kernel.org/lkml/4168371.zz0pVZtGOY@aspire.rjw.lan so that's
> easier to follow along.

Thanks for the results, much appreciated!

> The quick summary is:
> 
> ---> sockperf on loopback over UDP, mode "throughput":
>      this had a 12% regression in v2 on 48x-HASWELL-NUMA, which is completely
>      recovered in v3 and v5. Good stuff.

That's good news, thanks!

> ---> dbench on xfs:
>      this was down 16% in v2 on 48x-HASWELL-NUMA. On v5 we're at a 10%
>      regression. Slight improvement. What's really hurting here is the single
>      client scenario.
> 
> ---> netperf-udp on loopback:
>      had 6% regression on v2 on 8x-SKYLAKE-UMA, which is the same as what
>      happens in v5.
> 
> ---> tbench on loopback:
>      was down 10% in v2 on 8x-SKYLAKE-UMA, now slightly worse in v5 with a 12%
>      regression. As in dbench, it's at low number of clients that the results
>      are worst. Note that this machine is different from the one that has the
>      dbench regression.

Clearly, playing with the pattern detection part of the governor alone is not
sufficient to make all of the workloads happy at the same time.

> A more detailed report follows below.
> 
> I maintain my original opinion from v2 that this governor is largely
> performance-neutral and I'm not overly worried about the numbers above:

OK, fair enough.

Cheers,
Rafael

