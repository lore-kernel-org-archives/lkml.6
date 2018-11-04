Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69849ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD392081C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD392081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeKDTUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 14:20:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58787 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeKDTUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 14:20:24 -0500
Received: from 95-161-222-119.obit.ru (95.161.222.119) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 04e7387ad7ca2874; Sun, 4 Nov 2018 11:05:58 +0100
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
Subject: Re: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor for tickless systems
Date:   Sun, 04 Nov 2018 11:06:17 +0100
Message-ID: <5001963.Ahc0lEbC1L@aspire.rjw.lan>
In-Reply-To: <000301d472c2$49f28740$ddd795c0$@net>
References: <000301d472c2$49f28740$ddd795c0$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 2, 2018 4:39:42 PM CET Doug Smythies wrote:
> On 2018.10.26 02:12 Rafael J. Wysocki wrote:
> 
> ...[snip]...

Again, thanks a lot for the feedback, it is appreciated very much!

> > The v2 is a re-write of major parts of the original patch.
> >
> > The approach the same in general, but the details have changed significantly
> > with respect to the previous version.  In particular:
> > * The decay of the idle state metrics is implemented differently.
> > * There is a more "clever" pattern detection (sort of along the lines
> >   of what the menu does, but simplified quite a bit and trying to avoid
> >   including timer wakeups).
> > * The "promotion" from the "polling" state is gone.
> > * The "safety net" wakeups are treated as the CPU might have been idle
> >   until the closest timer.
> 
> ...[snip]...
> 
> I have been testing this V2 against a baseline that includes all
> of the pending menu patches. My baseline kernel is somewhere
> after 4.19, at 345671e.
> 
> A side note:
> Recall that with the menu patch set tests, I found that the baseline
> reference performance for the pipe test on one core had changed
> significantly (worse - Kernel 4.19-rc1). Well, now it has changed
> significantly again (better, and even significantly better than it
> was for 4.18). 4.18 ~4.8 uSec/loop; 4.19 ~5.2 uSec/loop; 4.19+
> (345671e) 4.2 uSec/loop.
> 
> This V2 is pretty good.

That's awesome!

> All of the tests that I run gave similar
> performance and power use between the baseline reference and V2.
> I couldn't find any issues with the decay stuff, and I tried.
> (sorry, I didn't do pretty graphs.)
> 
> After reading Giovanni's reply the other day, I tried the
> Phoronix dbench test: 12 clients resulted in similar performance,
> But TEOv2 used a little less processor package power; 256 clients
> had about -7% performance using TEOv2, but (my numbers are not
> exact) also used less processor package power.

Good to know, thank you!

> On 2018.10.31 11:36 Giovanni Gherdovich wrote:
> 
> > Something I'd like to do now is verify that "teo"'s predictions
> > are better than "menu"'s; I'll probably use systemtap to make
> > some histograms of idle times versus what idle state was chosen
> > -- that'd be enough to compare the two.
> 
> I don't know what a "systemtap" is, but I have (crude) tools to
> post process trace data into histograms data. I did 5 minute
> traces during the 12 client Phoronix dbench test and plotted
> the results, [1]. Sometimes, to the right of the autoscaled
> graph is another with fixed scaling. Better grouping of idle
> durations with TEOv2 are clearly visible.
> 
> ... Doug
> 
> [1] http://fast.smythies.com/linux-pm/k419p/histo_compare.htm

Thanks for the graphs.  At least they show the consistent underestimation of
the idle duration in menu if I'm not mistaken.

Cheers,
Rafael

