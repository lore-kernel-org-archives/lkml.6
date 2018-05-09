Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934570AbeEIKei (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:34:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46521 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933864AbeEIKeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:34:36 -0400
X-Google-Smtp-Source: AB8JxZqHgC444c7fmUsMqlaL3tVRZKHwVv37YAaZlDcdKYCQZE/AzRbBIHFV77OZer5vqAkkIF3FmQ==
Date: Wed, 9 May 2018 03:34:34 -0700
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
Message-ID: <20180509103434.GF76874@joelaf.mtv.corp.google.com>
References: <1525704215-8683-1-git-send-email-claudio@evidence.eu.com>
 <20180508065435.bcht6dyb3rpp6gk5@vireshk-i7>
 <20180509045425.GA158882@joelaf.mtv.corp.google.com>
 <20180509064530.GA1681@localhost.localdomain>
 <20180509080644.GA76874@joelaf.mtv.corp.google.com>
 <CAJZ5v0iFZ5+6BQCism-o8bnOxD8KveueJ5CT58F9uH_7_pYOXQ@mail.gmail.com>
 <20180509084001.bghnwpv3a3xnuxce@vireshk-i7>
 <20180509090259.GD76874@joelaf.mtv.corp.google.com>
 <20180509092823.sfph4gomnblb7jgr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509092823.sfph4gomnblb7jgr@vireshk-i7>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 02:58:23PM +0530, Viresh Kumar wrote:
> On 09-05-18, 02:02, Joel Fernandes wrote:
> > On Wed, May 09, 2018 at 02:10:01PM +0530, Viresh Kumar wrote:
> > > Right, none of the above changes are required now.
> > 
> > I didn't follow what you mean the changes are not required? I was developing
> > against Linus mainline. Also I replied to Rafael's comment in the other
> > thread.
> 
> At least for the shared policy case the entire sequence of
> sugov_should_update_freq() followed by sugov_update_commit() is
> executed from within spinlock protected region and you are using the
> same lock below. And so either the above two routines or the kthread
> routine below will execute at a given point of time.
> 
> So in case kthread has started doing the update and acquired the lock,
> the util update handler will wait until the time work_in_progress is
> set to false, that's not a problem we are trying to solve here.
> 
> And if kthread hasn't acquired the lock yet and util handler has
> started executing sugov_should_update_freq() ....
> 
> And ^^^ this is where I understood that your earlier change is
> actually required, so that we accumulate the latest updated next_freq
> value.
> 
> And with all that we wouldn't require a while loop in the kthread
> code.

Oh yeah, totally. So I think we are on the same page now about that.

> > > > > @@ -381,13 +381,23 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
> > > > >  static void sugov_work(struct kthread_work *work)
> > > > >  {
> > > > >         struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> > > > > +       unsigned int freq;
> > > > > +
> > > > > +       /*
> > > > > +        * Hold sg_policy->update_lock just enough to handle the case where:
> > > > > +        * if sg_policy->next_freq is updated before work_in_progress is set to
> > > > > +        * false, we may miss queueing the new update request since
> > > > > +        * work_in_progress would appear to be true.
> > > > > +        */
> > > > > +       raw_spin_lock(&sg_policy->update_lock);
> > > > > +       freq = sg_policy->next_freq;
> > > > > +       sg_policy->work_in_progress = false;
> > > > > +       raw_spin_unlock(&sg_policy->update_lock);
> > > 
> > > One problem we still have is that sg_policy->update_lock is only used
> > > in the shared policy case and not in the single CPU per policy case,
> > > so the race isn't solved there yet.
> > 
> > True.. I can make the single CPU case acquire the update_lock very briefly
> > around sugov_update_commit call in sugov_update_single.
> 
> Rafael was very clear from the beginning that he wouldn't allow a spin
> lock in the un-shared policy case :)

That's fair. Probably we can just not do this trickery at all for the single
case for now, incase work_in_progress is set. That way we still get the
benefit for the shared case, and the single case isn't changed from what it is
today.

thanks,

- Joel
