Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F314C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF89B20700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF89B20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbeKFEb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:31:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:51114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387462AbeKFEb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:31:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7FA1B0EC;
        Mon,  5 Nov 2018 19:10:20 +0000 (UTC)
Message-ID: <1541445264.3441.6.camel@suse.cz>
Subject: Re: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor
 for tickless systems
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Mon, 05 Nov 2018 20:14:24 +0100
In-Reply-To: <4168371.zz0pVZtGOY@aspire.rjw.lan>
References: <1899281.leNo2RexrE@aspire.rjw.lan>
         <1541010981.3423.2.camel@suse.cz> <4168371.zz0pVZtGOY@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-04 at 11:06 +0100, Rafael J. Wysocki wrote:
> On Wednesday, October 31, 2018 7:36:21 PM CET Giovanni Gherdovich wrote:
>
> [...]
> You can use the cpu_idle trace point to correlate the selected state index
> with the observed idle duration (that's what Doug did IIUC).

True, that works; although I ended up slapping a tracepoint right at the
beginning of the teo_update() and capturing the variables
cpu_data->last_state, dev->last_residency and dev->cpu.

I should have some plots to share soon. I really wanted to do in-kernel
histograms with systemtap as opposed to collecting data with ftrace and doing
post-processing, because I noticed that the latter approach generates lots of
events and wakeups from idle on the cpu that handles the ftrace data. It's
kind of a workload in itself and spoils the results.

> 
> Then, if the observed idle duration is between the target residency of the
> selected state and the target residency of the next one, the selected state
> is adequate and that's what we care about really.
> 
> If the observed idle duration is below the target residency of the selected
> state, the selected state is too deep and it if is above (or equal to) the
> target residency of the next state, it is too shallow.

Thanks for explaining this.

> 
> > After that it would be nice to somehow know where timers came from; i.e. if
> > I see that residences in a given state are consistently shorter than
> > they're supposed to be, it would be interesting to see who set the timer
> > that causes the wakeup. But... I'm not sure to know how to do that :) Do
> > you have a strategy to track down the origin of timers/interrupts? Is there
> > any script you're using to evaluate teo that you can share?
> 
> I need to think about that TBH.
> 
> The information that we can get readily should give use quite a good idea of
> what happens on average, though, so let's first do that and then try to dig
> deeper if need be.
> 
> I think that the difference between the v1 and v2 of the TEO governor comes
> mostly from the way in which they handle patterns of "early" wakeups.  The
> method used in v1 is very crude (and arguably invalid in general) and it
> will cause shallow states to be selected more often, while the v2 tries to
> be more "intelligent", but it may be overly conservative with that.
> 
> I'm working on a v3 that will try to address the above ATM, but I'd like to run
> it on my systems first (I'm going back home from a conference right now).
>

I've seen v3, I'll send you the test results ASAP.

Giovanni
