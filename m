Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C77C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA63720825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA63720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeKHReB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:34:01 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45403 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeKHReB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:34:01 -0500
Received: from 79.184.254.59.ipv4.supernova.orange.pl (79.184.254.59) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id db0792ec4fd0015b; Thu, 8 Nov 2018 08:59:43 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Giovanni Gherdovich' <ggherdovich@suse.cz>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Frederic Weisbecker' <frederic@kernel.org>,
        'Mel Gorman' <mgorman@suse.de>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>,
        'Linux PM' <linux-pm@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor for tickless systems
Date:   Thu, 08 Nov 2018 09:00:00 +0100
Message-ID: <2005055.MdD5a3VSRr@aspire.rjw.lan>
In-Reply-To: <000001d476bb$ec964520$c5c2cf60$@net>
References: <000001d476bb$ec964520$c5c2cf60$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 7, 2018 6:04:12 PM CET Doug Smythies wrote:
> On 2018.11.04 08:31 Rafael J. Wysocki wrote:
> 
> > v2 -> v3:
> > * Simplify the pattern detection code and make it return a value
> >	lower than the time to the closest timer if the majority of recent
> >	idle intervals are below it regardless of their variance (that should
> >	cause it to be slightly more aggressive).
> > * Do not count wakeups from state 0 due to the time limit in poll_idle()
> >    as non-timer.
> >
> > Note: I will be mostly offline tomorrow, so this goes slightly early.
> > I have tested it only very lightly, but it is not so much different from
> > the previous one.
> > 
> > It requires the same additional patches to apply as the previous one too.
> 
> Even though this v3 has now been superseded by v4, I completed some test
> work in progress for v3 anyhow.

That's useful anyway, thanks for doing that!

> The main reason to complete the work, and write up, was because, and for my
> own interest as much as anything, I wanted to specifically test for the
> influence of running trace on the system under test.
> Reference: https://marc.info/?l=linux-kernel&m=154145580925439&w=2
> 
> The Phoronix dbench test was run under the option to run all
> the tests, instead of just one number of clients. This was done
> with a reference/baseline kernel of 4.20-rc1, and also with this
> TEO version 3 patch. The tests were also repeated with trace
> enabled for 5000 seconds. Idle information and processor
> package power were sampled once per minute in all test runs.
> 
> The results are:
> http://fast.smythies.com/linux-pm/k420/k420-dbench-teo3.htm
> http://fast.smythies.com/linux-pm/k420/histo_compare.htm

Thanks a bunch for these!

> Conclusion: trace has negligible effect, until the system gets
> severely overloaded.
> 
> There are some odd long idle durations with TEOv3 for idle
> states 1, 2, and 3 that I'll watch for with v4 testing.

That unfortunately is a result of bugs in the v4 (and v2 - v3 too).

Namely, it doesn't take the cases when the tick has been stopped already
into account correctly.  IOW, all of the data points beyond the tick boundary
should go into the "final" peak.

I'll send a v5.

> Other information:
> Processor: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz
> The kernels were 1000 Hz.
> Idle latency/residency info:
> STATE: state0   DESC: CPUIDLE CORE POLL IDLE    NAME: POLL      LATENCY: 0      RESIDENCY: 0
> STATE: state1   DESC: MWAIT 0x00        NAME: C1        LATENCY: 2      RESIDENCY: 2
> STATE: state2   DESC: MWAIT 0x01        NAME: C1E       LATENCY: 10     RESIDENCY: 20
> STATE: state3   DESC: MWAIT 0x10        NAME: C3        LATENCY: 80     RESIDENCY: 211
> STATE: state4   DESC: MWAIT 0x20        NAME: C6        LATENCY: 104    RESIDENCY: 345

Thanks,
Rafael

