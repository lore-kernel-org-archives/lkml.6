Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeERMJG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:09:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55422 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeERMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:09:04 -0400
Date: Fri, 18 May 2018 14:08:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, yuyang.du@intel.com, pjt@google.com,
        bsegall@google.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] sched/fair: update scale invariance of PELT
Message-ID: <20180518120851.GM12198@hirez.programming.kicks-ass.net>
References: <1493389435-2525-1-git-send-email-vincent.guittot@linaro.org>
 <20180518093638.GL12198@hirez.programming.kicks-ass.net>
 <20180518101738.GM30654@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518101738.GM30654@e110439-lin>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 11:17:38AM +0100, Patrick Bellasi wrote:
> On 18-May 11:36, Peter Zijlstra wrote:
> > 
> > Replying to the latest version available; given the current interest I
> > figure I'd re-read some of the old threads and look at this stuff again.
> > 
> > On Fri, Apr 28, 2017 at 04:23:55PM +0200, Vincent Guittot wrote:
> > 
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 0978fb7..f8dde36 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -313,6 +313,7 @@ struct load_weight {
> > >   */
> > >  struct sched_avg {
> > >  	u64				last_update_time;
> > > +	u64				stolen_idle_time;
> > >  	u64				load_sum;
> > >  	u32				util_sum;
> > >  	u32				period_contrib;
> > 
> > Right, so sadly Patrick stole that space with the util_est bits.
> 
> Sorry :(
> 
> However, I remember we already talked about the idea to
> update load_avg and runnable_load_avg to use u32:
> 
>    https://marc.info/?l=linux-kernel&m=151334269426419&w=2
> 

Sadly not I fear, (runnable_)load for entities is obviously limited in
range, but we use the same struct sched_avg for the cfs_rq aggregates,
and there is no real limit on the total weight of a cfs_rq.

However, I think we can shrink util_avg unconditionally, which would
give us exactly the 4 byte hole we need.

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 959a8588e365..670b53b10a68 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -402,7 +402,8 @@ struct sched_avg {
 	u32				period_contrib;
 	unsigned long			load_avg;
 	unsigned long			runnable_load_avg;
-	unsigned long			util_avg;
+	u32				util_avg;
+	u32				stolen_idle_time;
 	struct util_est			util_est;
 } ____cacheline_aligned;
 
