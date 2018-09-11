Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B75C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFC920833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFC920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeIKQWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:22:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56594 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeIKQWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:22:49 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.123)
 id 3fcb82902d0195dd; Tue, 11 Sep 2018 13:23:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>, lenb@kernel.org,
        viresh.kumar@linaro.org, mgorman@techsingularity.net,
        ggherdovich@suse.cz, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
Date:   Tue, 11 Sep 2018 13:21:17 +0200
Message-ID: <23293649.J1qzPCXian@aspire.rjw.lan>
In-Reply-To: <87in3j9s07.fsf@riseup.net>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com> <8c56f28c2cc11de37fa3517348559eb040894702.camel@linux.intel.com> <87in3j9s07.fsf@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 6, 2018 6:20:08 AM CEST Francisco Jerez wrote:
> 
> --==-=-=
> Content-Type: multipart/mixed; boundary="=-=-="
> 
> --=-=-=
> Content-Type: text/plain; charset=utf-8
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
> 
> > [...]
> >
> >> > >=20
> >> > > This patch causes a number of statistically significant
> >> > > regressions
> >> > > (with significance of 1%) on the two systems I've tested it
> >> > > on.  On
> >> > > my
> >> >=20
> >> > Sure. These patches are targeted to Atom clients where some of
> >> > these
> >> > server like workload may have some minor regression on few watts
> >> > TDP
> >> > parts.
> >>=20
> >> Neither the 36% regression of fs-mark, the 21% regression of sqlite,
> >> nor
> >> the 10% regression of warsaw qualify as small.  And most of the test
> >> cases on the list of regressions aren't exclusively server-like, if
> >> at
> >> all.  Warsaw, gtkperf, jxrendermark and lightsmark are all graphics
> >> benchmarks -- Latency is as important if not more for interactive
> >> workloads than it is for server workloads.  In the case of a conflict
> >> like the one we're dealing with right now between optimizing for
> >> throughput (e.g. for the maximum number of requests per second) and
> >> optimizing for latency (e.g. for the minimum request duration), you
> >> are
> >> more likely to be concerned about the former than about the latter in
> >> a
> >> server setup.
> >
> > Eero,
> > Please add your test results here.
> >
> > No matter which algorithm you do, there will be variations. So you have
> > to look at the platforms which you are targeting. For this platform=20
> > number one item is use of less turbo and hope you know why?
> 
> Unfortunately the current controller uses turbo frequently on Atoms for
> TDP-limited graphics workloads regardless of IOWAIT boosting.  IOWAIT
> boosting simply exacerbated the pre-existing energy efficiency problem.

My current understanding of the issue at hand is that using IOWAIT boosting
on Atoms is a regression relative to the previous behavior.  That is what
Srinivas is trying to address here AFAICS.

Now, you seem to be saying that the overall behavior is suboptimal and the
IOWAIT boosting doesn't matter that much, so some deeper changes are needed
anyway.  That may be the case, but if there is a meaningful regression, we
should first get back to the point where it is not present and then to take
care of the more general problems.

So, I'd like to understand how much of a problem the IOWAIT boosting really is
in the first place.  If it is significant enough, let's address it first, this
way or another, and move on to the other problems subsequently.

Thanks,
Rafael

