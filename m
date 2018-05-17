Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeEQNHL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:07:11 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45228 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeEQNHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:07:06 -0400
X-Google-Smtp-Source: AB8JxZoEPO4dozeueMH3FbAjrTvqLOElSf2ldkRHZMi6NG7gEl8Qb9XwfK0Zf64tJDQQewmv6nAvHg==
Date: Thu, 17 May 2018 06:07:04 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH RFC] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180517130704.GA139147@joelaf.mtv.corp.google.com>
References: <20180516224518.109891-1-joel@joelfernandes.org>
 <20180517070026.GA22493@localhost.localdomain>
 <20180517102024.s3dxo4uepujh5f65@vireshk-i7>
 <20180517105358.GB22493@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517105358.GB22493@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 12:53:58PM +0200, Juri Lelli wrote:
> On 17/05/18 15:50, Viresh Kumar wrote:
> > On 17-05-18, 09:00, Juri Lelli wrote:
> > > Hi Joel,
> > > 
> > > On 16/05/18 15:45, Joel Fernandes (Google) wrote:
> > > 
> > > [...]
> > > 
> > > > @@ -382,13 +391,24 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
> > > >  static void sugov_work(struct kthread_work *work)
> > > >  {
> > > >  	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> > > > +	unsigned int freq;
> > > > +	unsigned long flags;
> > > > +
> > > > +	/*
> > > > +	 * Hold sg_policy->update_lock shortly to handle the case where:
> > > > +	 * incase sg_policy->next_freq is read here, and then updated by
> > > > +	 * sugov_update_shared just before work_in_progress is set to false
> > > > +	 * here, we may miss queueing the new update.
> > > > +	 */
> > > > +	raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
> > > > +	freq = sg_policy->next_freq;
> > > > +	sg_policy->work_in_progress = false;
> > > > +	raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
> > > 
> > > OK, we queue the new request up, but still we need to let this kthread
> > > activation complete and then wake it up again to service the request
> > > already queued, right? Wasn't what Claudio proposed (service back to
> > > back requests all in the same kthread activation) better from an
> > > overhead pow?

Hmm, from that perspective, yeah. But note that my patch doesn't increase the
overhead from what it already is.. because we don't queue the irq_work again
unless work_in_progress is cleared, which wouldn't be if the kthread didn't
run yet.

> > 
> > We would need more locking stuff in the work handler in that case and
> > I think there maybe a chance of missing the request in that solution
> > if the request happens right at the end of when sugov_work returns.
> 
> Mmm, true. Ideally we might want to use some sort of queue where to
> atomically insert requests and then consume until queue is empty from
> sugov kthread.

IMO we don't really need a queue or anything, we should need the kthread to
process the *latest* request it sees since that's the only one that matters.

> But, I guess that's going to be too much complexity for an (hopefully)
> corner case.

I thought of this corner case too, I'd argue its still an improvement over
not doing anything, but we could tighten this up a bit more if you wanted by
doing something like this on top of my patch. Thoughts?

---8<-----------------------

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a87fc281893d..e45ec24b810b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -394,6 +394,7 @@ static void sugov_work(struct kthread_work *work)
 	unsigned int freq;
 	unsigned long flags;
 
+redo_work:
 	/*
 	 * Hold sg_policy->update_lock shortly to handle the case where:
 	 * incase sg_policy->next_freq is read here, and then updated by
@@ -409,6 +410,9 @@ static void sugov_work(struct kthread_work *work)
 	__cpufreq_driver_target(sg_policy->policy, freq,
 				CPUFREQ_RELATION_L);
 	mutex_unlock(&sg_policy->work_lock);
+
+	if (sg_policy->work_in_progress)
+		goto redo_work;
 }
 
 static void sugov_irq_work(struct irq_work *irq_work)
