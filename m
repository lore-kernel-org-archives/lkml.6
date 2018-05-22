Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeEVKjA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:39:00 -0400
Received: from foss.arm.com ([217.140.101.70]:34618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEVKi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:38:57 -0400
Date: Tue, 22 May 2018 11:38:52 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
        "Joel Fernandes (Google.)" <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180522103851.GW30654@e110439-lin>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180521105055.GQ30654@e110439-lin>
 <20180521154957.GA14065@joelaf.mtv.corp.google.com>
 <20180521170050.GT30654@e110439-lin>
 <20180521172001.GA21678@joelaf.mtv.corp.google.com>
 <20180522102305.uxph4u4o2zrvu4tx@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522102305.uxph4u4o2zrvu4tx@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,
thanks for clarifying...

On 22-May 15:53, Viresh Kumar wrote:
> On 21-05-18, 10:20, Joel Fernandes wrote:
> > On Mon, May 21, 2018 at 06:00:50PM +0100, Patrick Bellasi wrote:
> > > If that's the case, this means that if, for example, during a
> > > frequency switch you get a request to reduce the frequency (e.g.
> > > deadline task passing the 0-lag time) and right after a request to
> > > increase the frequency (e.g. the current FAIR task tick)... you will
> > > enqueue a freq drop followed by a freq increase and actually do two
> > > frequency hops?
> 
> I don't think so.
> 
> Consider the kthread as running currently and has just cleared the
> work_in_progress flag. Sched update comes at that time and we decide
> to reduce the frequency, we queue another work and update next_freq.
> Now if another sched update comes before the kthread finishes its
> previous loop, we will simply update next_freq and return. So when the
> next time kthread runs, it will pick the most recent update.

Mmm... right... looking better at the two execution contexts:

   // A) Frequency update requests
   sugov_update_commit() {
      sg_policy->next_freq = next_freq;
      if (!sg_policy->work_in_progress) {
         sg_policy->work_in_progress = true;
         irq_work_queue(&sg_policy->irq_work);
      }
   }

   // B) Actual frequency updates
   sugov_work() {
      freq = sg_policy->next_freq;
      sg_policy->work_in_progress = false;

      __cpufreq_driver_target(sg_policy->policy, freq, CPUFREQ_RELATION_L);
   }


It's true that A will enqueue only one B at the first next_freq update
and then it will keep just updating the next_freq.
Thus, we should be ensure to have always just one kwork pending in the
queue.
 
> Where is the problem both of you see ?

Perhaps the confusion comes just from the naming of
"work_in_progress", which is confusing since we use it now to
represent that we enqueued a frequency change and we wait for the
kwork to pick it up.

Maybe it can help to rename it to something like kwork_queued or
update_pending, update_queued... ?


-- 
#include <best/regards.h>

Patrick Bellasi
