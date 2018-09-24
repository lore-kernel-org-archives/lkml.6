Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0954ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE750208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE750208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbeIXXWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:22:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39070 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbeIXXWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:22:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E16680D;
        Mon, 24 Sep 2018 10:19:22 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF6683F5BD;
        Mon, 24 Sep 2018 10:19:19 -0700 (PDT)
Date:   Mon, 24 Sep 2018 18:19:17 +0100
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
Message-ID: <20180924171917.GU1413@e110439-lin>
References: <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
 <20180921091308.GD24082@hirez.programming.kicks-ass.net>
 <20180924151400.GT1413@e110439-lin>
 <20180924162640.GB7060@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924162640.GB7060@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-Sep 18:26, Peter Zijlstra wrote:
> On Mon, Sep 24, 2018 at 04:14:00PM +0100, Patrick Bellasi wrote:
> 
> > ... still it's difficult to give a precise definition of knee point,
> > unless you know about platforms which have a sharp change in energy
> > efficiency.
> > 
> > The only cases we know about are those where:
> > 
> > A) multiple frequencies uses the same voltage, e.g.
> > 

On a side note, the following plots represents ee^-1, or eventually,
the P on the y axise... my bad.... but you got the meaning anyway ;)

> > 
> >      ^                                     *
> >      | Energy                              O
> >      | efficiency                         O+
> >      |                                   O |
> >      |                                 O*  |
> >      |                              O**    |
> >      |   O**                    O***       |
> >      |   +  O**            O****           |
> >      |   |     O**   O*****                |
> >      |   |        O**                      |
> >      |   |          +                      |
> >      |   |  Same V  |   Increasing V       |
> >      +---+----------+----------------------+----------->
> >          |          |                      | Frequency
> >          L          M                      H
> > 
> > B) there is a big frequency gap between low frequency OPPs and high
> >    frequency OPPs, e.g.
> > 
> >                                        O
> >     ^                                **+
> >     | Energy                       **  |
> >     | efficiency                 **    |
> >     |                          **      |
> >     |                        **        |
> >     |                      **          |
> >     |                    **            |
> >     |                  **              |
> >     |               O**                |
> >     |        O******+                  |
> >     |O*******       |                  |
> >     |               |                  |
> >     ++--------------+------------------+------>
> >      |              |                  |  Frequency
> >      L              M                  H
> > 
> > 
> > In case A, all the OPPs left of M are dominated by M in terms
> > of energy efficiency and normally they should be never used.
> > Unless you are under thermal constraints and you still want to keep
> > your code running even if at a lower rate and energy efficiency.
> > At this point, however, you already invalidated all the OPPs right of
> > M and, on the remaining, you still struggle do define the knee point.
> > 
> > In case B... I'm wondering it such a conf even makes sense ;)
> > Is there really some platform out there with such a "non homogeneously
> > distributed" set of available frequencies ?
> 
> Well, the curve is a second or third order polynomial (when V~f -> fV^2
> -> f^3), so it shoots up at some point. There's not really anything you
> can do about that. But if you're willing to put in active cooling and
> lots of energy, you can make it go fast :-)

Sure... until you don't melt the silicon you can push the frequency.

However, if you are going for such aggressive active cooling, perhaps
your interest for energy efficiency it's already a very low priority
goal.

> Therefore I was thinking:
> 
> > Maybe we can define a threshold
> > for a "EE derivative ratio", but it will still be quite arbitrary.
> 
> Because up until de/df=.5 we gain more performance than we loose ee.

You mean up until de < df ?

IOW... the threshold should be de == df => 45deg tangent ?

> But I might not have appreciated the fact that when we work with
> imaginary cost units that skews the .5.

The main skew IMO comes from the fact the energy efficiency
"tipping point" is very much application / user specific...
and it can also change depending on the usage scenario for the
same user and platform.

-- 
#include <best/regards.h>

Patrick Bellasi
