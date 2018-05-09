Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934586AbeEIJDE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:03:04 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40046 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934569AbeEIJDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:03:01 -0400
X-Google-Smtp-Source: AB8JxZpY77scpRJ1zLh9GE7owvHNuVMlGe/2sLFfgrlYj+qNgUFrzNo+waC8Le3RBZe0lPDf2wcqzg==
Date: Wed, 9 May 2018 02:02:59 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Joel Fernandes <joelaf@google.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/cpufreq/schedutil: handling urgent frequency
 requests
Message-ID: <20180509090259.GD76874@joelaf.mtv.corp.google.com>
References: <1525704215-8683-1-git-send-email-claudio@evidence.eu.com>
 <20180508065435.bcht6dyb3rpp6gk5@vireshk-i7>
 <20180509045425.GA158882@joelaf.mtv.corp.google.com>
 <20180509064530.GA1681@localhost.localdomain>
 <20180509080644.GA76874@joelaf.mtv.corp.google.com>
 <CAJZ5v0iFZ5+6BQCism-o8bnOxD8KveueJ5CT58F9uH_7_pYOXQ@mail.gmail.com>
 <20180509084001.bghnwpv3a3xnuxce@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509084001.bghnwpv3a3xnuxce@vireshk-i7>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 02:10:01PM +0530, Viresh Kumar wrote:
> On 09-05-18, 10:30, Rafael J. Wysocki wrote:
> > On Wed, May 9, 2018 at 10:06 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > How about this? Will use the latest request, and also doesn't do unnecessary
> > > irq_work_queue:
> 
> I almost wrote the same stuff before I went for lunch :)

Oh :)

> > > (untested)
> > > -----8<--------
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index d2c6083304b4..6a3e42b01f52 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -38,7 +38,7 @@ struct sugov_policy {
> > >         struct                  mutex work_lock;
> > >         struct                  kthread_worker worker;
> > >         struct task_struct      *thread;
> > > -       bool                    work_in_progress;
> > > +       bool                    work_in_progress; /* Has kthread been kicked */
> > >
> > >         bool                    need_freq_update;
> > >  };
> > > @@ -92,9 +92,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> > >             !cpufreq_can_do_remote_dvfs(sg_policy->policy))
> > >                 return false;
> > >
> > > -       if (sg_policy->work_in_progress)
> > > -               return false;
> > > -
> > 
> > Why this change?
> > 
> > Doing the below is rather pointless if work_in_progress is set, isn't it?
> > 
> > You'll drop the results of it on the floor going forward anyway then AFAICS.
> > 
> > >         if (unlikely(sg_policy->need_freq_update)) {
> > >                 sg_policy->need_freq_update = false;
> > >                 /*
> > > @@ -129,8 +126,11 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> > >                 policy->cur = next_freq;
> > >                 trace_cpu_frequency(next_freq, smp_processor_id());
> > >         } else {
> > > -               sg_policy->work_in_progress = true;
> > > -               irq_work_queue(&sg_policy->irq_work);
> > > +               /* work_in_progress helps us not queue unnecessarily */
> > > +               if (!sg_policy->work_in_progress) {
> > > +                       sg_policy->work_in_progress = true;
> > > +                       irq_work_queue(&sg_policy->irq_work);
> > > +               }
> > >         }
> > >  }
> 
> Right, none of the above changes are required now.

I didn't follow what you mean the changes are not required? I was developing
against Linus mainline. Also I replied to Rafael's comment in the other
thread.

> 
> > > @@ -381,13 +381,23 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
> > >  static void sugov_work(struct kthread_work *work)
> > >  {
> > >         struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> > > +       unsigned int freq;
> > > +
> > > +       /*
> > > +        * Hold sg_policy->update_lock just enough to handle the case where:
> > > +        * if sg_policy->next_freq is updated before work_in_progress is set to
> > > +        * false, we may miss queueing the new update request since
> > > +        * work_in_progress would appear to be true.
> > > +        */
> > > +       raw_spin_lock(&sg_policy->update_lock);
> > > +       freq = sg_policy->next_freq;
> > > +       sg_policy->work_in_progress = false;
> > > +       raw_spin_unlock(&sg_policy->update_lock);
> 
> One problem we still have is that sg_policy->update_lock is only used
> in the shared policy case and not in the single CPU per policy case,
> so the race isn't solved there yet.

True.. I can make the single CPU case acquire the update_lock very briefly
around sugov_update_commit call in sugov_update_single.

Also I think the lock acquiral from sugov_work running in the kthread context should be a raw_spin_lock_irqsave..

thanks,

- Joel
