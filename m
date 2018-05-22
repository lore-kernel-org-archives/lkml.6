Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeEVK0S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:26:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34510 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751160AbeEVK0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:26:14 -0400
Date: Tue, 22 May 2018 11:26:09 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180522102609.GV30654@e110439-lin>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180521105055.GQ30654@e110439-lin>
 <20180521180557.GA40541@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521180557.GA40541@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-May 11:05, Joel Fernandes wrote:
> On Mon, May 21, 2018 at 11:50:55AM +0100, Patrick Bellasi wrote:
> > On 18-May 11:55, Joel Fernandes (Google.) wrote:
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > 
> > > Currently there is a chance of a schedutil cpufreq update request to be
> > > dropped if there is a pending update request. This pending request can
> > > be delayed if there is a scheduling delay of the irq_work and the wake
> > > up of the schedutil governor kthread.
> > > 
> > > A very bad scenario is when a schedutil request was already just made,
> > > such as to reduce the CPU frequency, then a newer request to increase
> > > CPU frequency (even sched deadline urgent frequency increase requests)
> > > can be dropped, even though the rate limits suggest that its Ok to
> > > process a request. This is because of the way the work_in_progress flag
> > > is used.
> > > 
> > > This patch improves the situation by allowing new requests to happen
> > > even though the old one is still being processed. Note that in this
> > > approach, if an irq_work was already issued, we just update next_freq
> > > and don't bother to queue another request so there's no extra work being
> > > done to make this happen.
> > 
> > Maybe I'm missing something but... is not this patch just a partial
> > mitigation of the issue you descrive above?
> > 
> > If a DL freq increase is queued, with this patch we store the request
> > but we don't actually increase the frequency until the next schedutil
> > update, which can be one tick away... isn't it?
> > 
> > If that's the case, maybe something like the following can complete
> > the cure?
> > 
> > ---8<---
> > #define SUGOV_FREQ_NONE 0
> > 
> > static unsigned int sugov_work_update(struct sugov_policy *sg_policy,
> > 				      unsigned int prev_freq)
> > {
> > 	unsigned long irq_flags;
> > 	bool update_freq = true;
> > 	unsigned int next_freq;
> > 
> > 	/*
> > 	 * Hold sg_policy->update_lock shortly to handle the case where:
> > 	 * incase sg_policy->next_freq is read here, and then updated by
> > 	 * sugov_update_shared just before work_in_progress is set to false
> > 	 * here, we may miss queueing the new update.
> > 	 *
> > 	 * Note: If a work was queued after the update_lock is released,
> > 	 * sugov_work will just be called again by kthread_work code; and the
> > 	 * request will be proceed before the sugov thread sleeps.
> > 	 */
> > 	raw_spin_lock_irqsave(&sg_policy->update_lock, irq_flags);
> > 	next_freq = sg_policy->next_freq;
> > 	sg_policy->work_in_progress = false;
> > 	if (prev_freq == next_freq)
> > 		update_freq = false;
> 
> About this patch on top of mine, I believe this check is already being done
> by sugov_update_commit? :

No, that check is different...
> 
> static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> 				unsigned int next_freq)
> {
> 	struct cpufreq_policy *policy = sg_policy->policy;
> 
> 	if (sg_policy->next_freq == next_freq)
> 		return;
> 
> 	sg_policy->next_freq = next_freq;
> 	sg_policy->last_freq_update_time = time;
> ----

... in my snippet the check is required to verify if, once a freq
swich has been completed by the kthread, the sugov_update_commit has
actually committed a new and different frequency wrt the one the
kthread has just configured.

It means we will have two async paths:

1. sugov_update_commit()
   which updates sg_policy->next_freq

2. sugov_work_update()
   which will run in a loop until the last freq it configures matches
   with the current value of sg_policy->next_freq

But again, as we was discussing yesterday, we can have these
additional bits in a following patch on top of your.

-- 
#include <best/regards.h>

Patrick Bellasi
