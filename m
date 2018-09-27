Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3662C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6509321582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6509321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeI0Qkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:40:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbeI0Qkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:40:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80CF07A9;
        Thu, 27 Sep 2018 03:23:05 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77FCD3F5B7;
        Thu, 27 Sep 2018 03:23:02 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:23:00 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 06/16] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Message-ID: <20180927102258.gxhte2k4li2uktm5@queper01-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-7-patrick.bellasi@arm.com>
 <20180914093240.GB24082@hirez.programming.kicks-ass.net>
 <20180914131919.GO1413@e110439-lin>
 <20180914133654.GL24124@hirez.programming.kicks-ass.net>
 <20180914135712.GQ1413@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914135712.GQ1413@e110439-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 Sep 2018 at 14:57:12 (+0100), Patrick Bellasi wrote:
> On 14-Sep 15:36, Peter Zijlstra wrote:
> > On Fri, Sep 14, 2018 at 02:19:19PM +0100, Patrick Bellasi wrote:
> > > On 14-Sep 11:32, Peter Zijlstra wrote:
> > 
> > > > Should that not be:
> > > > 
> > > > 	util = clamp_util(rq, cpu_util_cfs(rq));
> > > > 
> > > > Because if !util might we not still want to enforce the min clamp?
> > > 
> > > If !util CFS tasks should have been gone since a long time
> > > (proportional to their estimated utilization) and thus it probably
> > > makes sense to not affect further energy efficiency for tasks of other
> > > classes.
> > 
> > I don't remember what we do for util for new tasks; but weren't we
> > talking about setting that to 0 recently? IIRC the problem was that if
> > we start at 1 with util we'll always run new tasks on big cores, or
> > something along those lines.

I guess you're referring to that discussion ?

https://lore.kernel.org/lkml/CAKfTPtDcoySXK0fBkDNy4wp1vsRxmiuAGT3CDZBh6Vnwyep2BA@mail.gmail.com/

If yes, then the outcome was that we'll see later what we do with new
tasks :-)

Setting the util of new tasks to 0 surely can help power, but that can
also harm performance pretty badly, I think. You'd be stuck at min freq
for a while w/ sugov in case of a fork bomb for example.

> Mmm.. could have been in a recent discussion with Quentin, but I
> think I've missed it. I know we have something similar on Android for
> similar reasons.

I don't think PELT is different in Android (we still set the initial
util of new tasks as half of the spare cap of the CPU), but there are
other tweaks that influence the first task placement, though. And WALT
sets the util of new tasks to 0 IIRC (but I'm not sure it's relevant
since its signal ramps up a lot faster than PELT's).

Thanks,
Quentin
