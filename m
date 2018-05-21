Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753477AbeEURmH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:42:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54424 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753324AbeEURlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:41:47 -0400
Date: Mon, 21 May 2018 18:41:42 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Joel Fernandes (Google.)" <joelaf@google.com>,
        linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180521174142.GU30654@e110439-lin>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180521105055.GQ30654@e110439-lin>
 <20180521154957.GA14065@joelaf.mtv.corp.google.com>
 <20180521170050.GT30654@e110439-lin>
 <20180521172001.GA21678@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521172001.GA21678@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-May 10:20, Joel Fernandes wrote:
> Hi Patrick,
> 
> On Mon, May 21, 2018 at 06:00:50PM +0100, Patrick Bellasi wrote:
> > On 21-May 08:49, Joel Fernandes wrote:
> > > On Mon, May 21, 2018 at 11:50:55AM +0100, Patrick Bellasi wrote:
> > > > On 18-May 11:55, Joel Fernandes (Google.) wrote:
> > > > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > > 
> > > > > Currently there is a chance of a schedutil cpufreq update request to be
> > > > > dropped if there is a pending update request. This pending request can
> > > > > be delayed if there is a scheduling delay of the irq_work and the wake
> > > > > up of the schedutil governor kthread.
> > > > > 
> > > > > A very bad scenario is when a schedutil request was already just made,
> > > > > such as to reduce the CPU frequency, then a newer request to increase
> > > > > CPU frequency (even sched deadline urgent frequency increase requests)
> > > > > can be dropped, even though the rate limits suggest that its Ok to
> > > > > process a request. This is because of the way the work_in_progress flag
> > > > > is used.
> > > > > 
> > > > > This patch improves the situation by allowing new requests to happen
> > > > > even though the old one is still being processed. Note that in this
> > > > > approach, if an irq_work was already issued, we just update next_freq
> > > > > and don't bother to queue another request so there's no extra work being
> > > > > done to make this happen.
> > > > 
> > > > Maybe I'm missing something but... is not this patch just a partial
> > > > mitigation of the issue you descrive above?
> > > > 
> > > > If a DL freq increase is queued, with this patch we store the request
> > > > but we don't actually increase the frequency until the next schedutil
> > > > update, which can be one tick away... isn't it?
> > > > 
> > > > If that's the case, maybe something like the following can complete
> > > > the cure?
> > > 
> > > We already discussed this and thought of this case, I think you missed a
> > > previous thread [1]. The outer loop in the kthread_work subsystem will take
> > > care of calling sugov_work again incase another request was queued which we
> > > happen to miss.
> > 
> > Ok, I missed that thread... my bad.
> 
> Sure no problem, sorry I was just pointing out the thread, not blaming you
> for not reading it ;)

Sure, np here too ;)

> > However, [1] made me noticing that your solution works under the
> > assumption that we keep queuing a new kworker job for each request we
> > get, isn't it?
> 
> Not at each request, but each request after work_in_progress was cleared by the
> sugov_work. Any requests that happen between work_in_progress is set and
> cleared only result in updating of the next_freq.

I see, so we enqueue for the time of:

   mutex_lock(&sg_policy->work_lock);
   __cpufreq_driver_target(sg_policy->policy, freq, CPUFREQ_RELATION_L);
   mutex_unlock(&sg_policy->work_lock);

> > If that's the case, this means that if, for example, during a
> > frequency switch you get a request to reduce the frequency (e.g.
> > deadline task passing the 0-lag time) and right after a request to
> > increase the frequency (e.g. the current FAIR task tick)... you will
> > enqueue a freq drop followed by a freq increase and actually do two
> > frequency hops?
> 
> Yes possibly,

Not sure about the time window above, I can try to get some
measurements tomorrow.

> I see your point but I'm not sure if the tight loop around that
> is worth the complexity, or atleast is within the scope of my patch.
> Perhaps the problem you describe can be looked at as a future enhancement?

Sure, I already have it as a patch on top of your.  I can post it
afterwards and we can discuss whether it makes sense or not.

Still have to better check, but I think that maybe we can skip
the queueing altogether if some work is already pending... in case we
wanna go for a dedicated inner loop like the one I was proposing.

Apart that, I think that your patch is already fixing 90% of the
issue we have now.

> thanks,
> 
>  - Joel

-- 
#include <best/regards.h>

Patrick Bellasi
