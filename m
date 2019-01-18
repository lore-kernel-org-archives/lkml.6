Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83376C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C082086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfARJQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:16:57 -0500
Received: from foss.arm.com ([217.140.101.70]:53224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfARJQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:16:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34A1EEBD;
        Fri, 18 Jan 2019 01:16:56 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2197B3F5C1;
        Fri, 18 Jan 2019 01:16:53 -0800 (PST)
Date:   Fri, 18 Jan 2019 09:16:52 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     corbet@lwn.net, peterz@infradead.org, rjw@rjwysocki.net,
        mingo@redhat.com, morten.rasmussen@arm.com, qais.yousef@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched: Document Energy Aware Scheduling
Message-ID: <20190118091652.xn6iw52tccwh6vap@queper01-lin>
References: <20190110110546.8101-1-quentin.perret@arm.com>
 <20190110110546.8101-3-quentin.perret@arm.com>
 <20190117155117.GG14385@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117155117.GG14385@localhost.localdomain>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On Thursday 17 Jan 2019 at 16:51:17 (+0100), Juri Lelli wrote:
> On 10/01/19 11:05, Quentin Perret wrote:
[...]
> > +The idea behind introducing an EM is to allow the scheduler to evaluate the
> > +implications of its decisions rather than blindly applying energy-saving
> > +techniques that may have positive effects only on some platforms. At the same
> > +time, the EM must be as simple as possible to minimize the scheduler latency
> > +impact.
> > +
> > +In short, EAS changes the way CFS tasks are assigned to CPUs. When it is time
> 
> Not sure if we want to remark the fact that EAS is looking at CFS tasks
> only ATM.

Oh, what's wrong about mentioning it ? I mean, it is a fact ATM ...

> > +for the scheduler to decide where a task should run (during wake-up), the EM
> > +is used to break the tie between several good CPU candidates and pick the one
> > +that is predicted to yield the best energy consumption without harming the
> > +system's throughput. The predictions made by EAS rely on specific elements of
> > +knowledge about the platform's topology, which include the 'capacity' of CPUs,
> 
> Add a reference to DT bindings docs defining 'capacity' (or define it
> somewhere)?

Right, I can mention this is defined in the next section. But are you
sure about the reference to the DT bindings ? They're arm-specific right ?
Maybe I can give that as an example or something ...

> > +and their respective energy costs.
> > +
> > +
> > +3. Topology information
> > +-----------------------
> > +
> > +EAS (as well as the rest of the scheduler) uses the notion of 'capacity' to
> > +differentiate CPUs with different computing throughput. The 'capacity' of a CPU
> > +represents the amount of work it can absorb when running at its highest
> > +frequency compared to the most capable CPU of the system. Capacity values are
> > +normalized in a 1024 range, and are comparable with the utilization signals of
> > +tasks and CPUs computed by the Per-Entity Load Tracking (PELT) mechanism. Thanks
> > +to capacity and utilization values, EAS is able to estimate how big/busy a
> > +task/CPU is, and to take this into consideration when evaluating performance vs
> > +energy trade-offs. The capacity of CPUs is provided via arch-specific code
> > +through the arch_scale_cpu_capacity() callback.
> 
> Ah, it's here, mmm, maybe still introduce it before (or point here from
> above) and still point to dt bindings doc?

Yep, I'll add a pointer above.


[...]
> > +the most energy efficient CPUs of the system more than the others if that can be
> > +done without harming throughput. So, the load-balancer is disabled to prevent
> 
> Load-balancing being disabled in EAS mode it's quite an important thing
> to notice IMHO. Maybe state it clearly somewhere above?

Right, this needs to be emphasized more. I'll mention it in the
introduction.


[...]
> > +So, in order to use EAS on your platform your architecture must implement the
> 
> Mmm, using 'your' form is a change of 'style', no?

Good point, I will try to unify this section with the rest of the doc.
There are loads of 'your platform' below too.


Thank you very much for the typos as well :-)
Quentin
