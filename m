Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E254C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598B720870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfAWOTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:19:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41780 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbfAWOTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:19:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB0BCA78;
        Wed, 23 Jan 2019 06:19:29 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E65DF3F6A8;
        Wed, 23 Jan 2019 06:19:26 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:19:24 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 07/16] sched/core: uclamp: Add system default clamps
Message-ID: <20190123141924.x36iqxh42lkssrxl@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-8-patrick.bellasi@arm.com>
 <20190122135644.GP27931@hirez.programming.kicks-ass.net>
 <20190122144329.ziimv6fejwvky7yb@e110439-lin>
 <20190122151317.GH13777@hirez.programming.kicks-ass.net>
 <20190122154129.mxnpgaoxnccbjbch@e110439-lin>
 <20190123092210.GU27931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123092210.GU27931@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Jan 10:22, Peter Zijlstra wrote:
> On Tue, Jan 22, 2019 at 03:41:29PM +0000, Patrick Bellasi wrote:
> > On 22-Jan 16:13, Peter Zijlstra wrote:
> > > On Tue, Jan 22, 2019 at 02:43:29PM +0000, Patrick Bellasi wrote:
> 
> > > > Do you think that could be acceptable?
> > > 
> > > Think so, it's a sysctl poke, 'nobody' ever does that.
> > 
> > Cool, so... I'll keep lazy update for system default.
> 
> Ah, I think I misunderstood. I meant to say that since nobody ever pokes
> at sysctl's it doesn't matter if its a little more expensive and iterate
> everything.

Here I was more worried about the code complexity/overhead... for
something actually not very used/useful.

> Also; if you always keep everything up-to-date, you can avoid doing that
> duplicate accounting.

To update everything we will have to walk all the CPUs and update all
the RUNNABLE tasks currently enqueued, which are either RT or CFS.

That's way more expensive both in code and time then what we do for
cgroups, where at least we have a limited scope since the cgroup
already provides a (usually limited) list of tasks to consider.

Do you think it's really worth to have ?

Perhaps we can add it in a second step, once we have the core bits in
and we really see a need for a specific use-case.


-- 
#include <best/regards.h>

Patrick Bellasi
