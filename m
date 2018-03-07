Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeCGLrS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:47:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49232 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932362AbeCGLrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:47:16 -0500
Date: Wed, 7 Mar 2018 11:47:11 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v5 1/4] sched/fair: add util_est on top of PELT
Message-ID: <20180307114711.GB2211@e110439-lin>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-2-patrick.bellasi@arm.com>
 <20180306190241.GH25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306190241.GH25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Mar 20:02, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 05:01:50PM +0000, Patrick Bellasi wrote:
> > +struct util_est {
> > +	unsigned int			enqueued;
> > +	unsigned int			ewma;
> > +#define UTIL_EST_WEIGHT_SHIFT		2
> > +};
> 
> > +	ue = READ_ONCE(p->se.avg.util_est);
> 
> > +	WRITE_ONCE(p->se.avg.util_est, ue);
> 
> That is actually quite dodgy... and relies on the fact that we have the
> 8 byte case in __write_once_size() and __read_once_size()
> unconditionally. It then further relies on the compiler DTRT for 32bit
> platforms, which is generating 2 32bit loads/stores.
>
> The advantage is of course that it will use single u64 loads/stores
> where available.

Yes, that's mainly an "optimization" for 64bit targets... but perhaps
the benefits are negligible.

Do you prefer to keep more "under control" the generated code by using
two {READ,WRITE}_ONCEs?

IMO here we can also go with just the WRITE_ONCEs. I don't see a case
for the compiler to mangle load/store. While the WRITE_ONCE are still
required to sync with non rq-lock serialized code.
But... maybe I'm missing something... ?

-- 
#include <best/regards.h>

Patrick Bellasi
