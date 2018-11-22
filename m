Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB5CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA6F20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA6F20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437957AbeKWCgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:36:07 -0500
Received: from foss.arm.com ([217.140.101.70]:52790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437944AbeKWCgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:36:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 495C8168F;
        Thu, 22 Nov 2018 07:56:09 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E28E3F575;
        Thu, 22 Nov 2018 07:56:05 -0800 (PST)
Date:   Thu, 22 Nov 2018 15:56:03 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v9 08/15] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Message-ID: <20181122155601.nf6egzo3aicqv33y@queper01-lin>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-9-quentin.perret@arm.com>
 <20181122140432.GH2113@hirez.programming.kicks-ass.net>
 <CAJZ5v0g0cca+wuZocwwt5y+a7FS6Y8qDDf27KftRQ_1Dy6-7XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g0cca+wuZocwwt5y+a7FS6Y8qDDf27KftRQ_1Dy6-7XQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 Nov 2018 at 16:49:04 (+0100), Rafael J. Wysocki wrote:
> On Thu, Nov 22, 2018 at 3:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 19, 2018 at 02:18:50PM +0000, Quentin Perret wrote:
> > > +                     if (rd->pd)
> > > +                             pr_warn("rd %*pbl: Disabling EAS, schedutil is mandatory\n",
> > > +                                             cpumask_pr_args(cpu_map));
> > > +                     goto free;
> >
> > I would have preferred just not allowing the governor to change at all,
> > but if you want to allow that, this is, I suppose, the best you can do.
> >
> > Rafael, are you otherwise OK with the grubbing inside cpufreq?
> 
> Sort of. :-)
> 
> I would put the sched_cpufreq_governor_change() header (and the static
> inline stub of it) into linux/cpufreq.h (instead of
> linux/sched/cpufreq.h) so that cpufreq.c doesn't have to include
> linux/sched/cpufreq.h which is kind of confusing.

That works for me.

Thanks,
Quentin
