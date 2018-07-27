Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232FBC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7AE20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7AE20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbeG0J3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:29:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38666 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbeG0J3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:29:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9552580D;
        Fri, 27 Jul 2018 01:09:08 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2C633F2EA;
        Fri, 27 Jul 2018 01:09:05 -0700 (PDT)
Date:   Fri, 27 Jul 2018 09:09:04 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Message-ID: <20180727080827.u7tseookdhsckrec@queper01-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
 <20180723153040.GG1934745@devbig577.frc2.facebook.com>
 <20180723172215.GG2683@e110439-lin>
 <20180724132902.GI1934745@devbig577.frc2.facebook.com>
 <20180727003919.GA22416@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727003919.GA22416@joelaf.mtv.corp.google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 Jul 2018 at 17:39:19 (-0700), Joel Fernandes wrote:
> On Tue, Jul 24, 2018 at 06:29:02AM -0700, Tejun Heo wrote:
> > Hello, Patrick.
> > 
> > On Mon, Jul 23, 2018 at 06:22:15PM +0100, Patrick Bellasi wrote:
> > > However, the "best effort" bandwidth control we have for CFS and RT
> > > can be further improved if, instead of just looking at time spent on
> > > CPUs, we provide some more hints to the scheduler to know at which
> > > min/max "MIPS" we want to consume the (best effort) time we have been
> > > allocated on a CPU.
> > > 
> > > Such a simple extension is still quite useful to satisfy many use-case
> > > we have, mainly on mobile systems, like the ones I've described in the
> > >    "Newcomer's Short Abstract (Updated)"
> > > section of the cover letter:
> > >    https://lore.kernel.org/lkml/20180716082906.6061-1-patrick.bellasi@arm.com/T/#u
> > 
> > So, that's all completely fine but then let's please not give it a
> > name which doesn't quite match what it does.  We can just call it
> > e.g. cpufreq range control.
> 
> But then what name can one give it if it does more than one thing, like
> task-placement and CPU frequency control?
> 
> It doesn't make sense to name it cpufreq IMHO. Its a clamp on the utilization
> of the task which can be used for many purposes.

Indeed, the scheduler could use clamped utilization values in several
places. The capacity-awareness bits (mostly useful for big.LITTLE
platforms) could already use that today I guess.

And on the longer term, depending on where the EAS patches [1] end up,
utilization clamping might actually become very useful to bias task
placement decisions. EAS basically decides where to place tasks based on
their utilization, so util_clamp would make a lot of sense there IMO.

Thanks,
Quentin

[1] https://lkml.org/lkml/2018/7/24/420
