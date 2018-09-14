Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35650ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E067E20671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E067E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeINTWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:22:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33976 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbeINTWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:22:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F21B18A;
        Fri, 14 Sep 2018 07:07:38 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 710C03F575;
        Fri, 14 Sep 2018 07:07:35 -0700 (PDT)
Date:   Fri, 14 Sep 2018 15:07:32 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Message-ID: <20180914140732.GR1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914111003.GC24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-Sep 13:10, Peter Zijlstra wrote:
> On Thu, Sep 06, 2018 at 03:40:53PM +0100, Patrick Bellasi wrote:
> > 1) _I think_ we don't want to depend on capable(CAP_SYS_NICE) but
> >    instead on capable(CAP_SYS_ADMIN)
> > 
> >    Does that make sense ?
> 
> Neither of them really makes sense to me.
> 
> The max clamp makes a task 'consume' less and you should always be able
> to reduce yourself.
> 
> The min clamp doesn't avoid while(1); and is therefore also not a
> problem.
> 
> So I think setting clamps on a task should not be subject to additional
> capabilities.
> 
> Now, of course, there is a problem of clamp resources, which are
> limited. Consuming those _is_ a problem.

Right, that problem could be solved if we convince ourself that the
quantization approach proposed in:

   [PATCH v4 15/16] sched/core: uclamp: add clamp group discretization support
   https://lore.kernel.org/lkml/20180828135324.21976-16-patrick.bellasi@arm.com/

could make sense and specifically, the other limitation it imposes
(i.e. the quantizaiton) is within reasonable rounding control errors/

> I think the problem here is that the two are conflated in the very same
> interface.
> 
> Would it make sense to move the available clamp values out to some sysfs
> interface like thing and guard that with a capability, while keeping the
> task interface unprivilidged?

You mean something like:

   $ cat /proc/sys/kernel/sched_uclamp_min_utils
   0 10 20 ... 100

to notify users about the set of clamp values which are available ?

> Another thing that has me 'worried' about this interface is the direct
> tie to CPU capacity (not that I have a better suggestion). But it does
> raise the point of how userspace is going to discover the relevant
> values of the platform.

This point worries me too, and that's what I think is addressed in a
sane way in:

   [PATCH v4 13/16] sched/core: uclamp: use percentage clamp values
   https://lore.kernel.org/lkml/20180828135324.21976-14-patrick.bellasi@arm.com/

IMHO percentages are a reasonably safe and generic API to expose to
user-space. Don't you think this should address your concern above ?

-- 
#include <best/regards.h>

Patrick Bellasi
