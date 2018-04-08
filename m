Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeDHIUZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 04:20:25 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43428 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeDHIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 04:20:24 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v9 07/10] time: hrtimer: Introduce hrtimer_next_event_without()
Date: Sun, 08 Apr 2018 10:20:30 +0200
Message-ID: <3441609.rVjWXosy3s@aspire.rjw.lan>
In-Reply-To: <20180407144637.GC16600@lerouge>
References: <1736751.LdhZHb50jq@aspire.rjw.lan> <101528364.6nGUqP0EsC@aspire.rjw.lan> <20180407144637.GC16600@lerouge>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 7, 2018 4:46:38 PM CEST Frederic Weisbecker wrote:
> On Wed, Apr 04, 2018 at 10:45:39AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The next set of changes will need to compute the time to the next
> > hrtimer event over all hrtimers except for the scheduler tick one.
> > 
> > To that end introduce a new helper function,
> > hrtimer_next_event_without(), for computing the time until the next
> > hrtimer event over all timers except for one and modify the underlying
> > code in __hrtimer_next_event_base() to prepare it for being called by
> > that new function.
> > 
> > No intentional changes in functionality.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > v8 -> v9:
> >  * Make fewer changes to the existing code.
> >  * Add a new helper function for the handling of the use case at hand.
> > 
> > ---
> >  include/linux/hrtimer.h |    1 
> >  kernel/time/hrtimer.c   |   55 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 54 insertions(+), 2 deletions(-)
> > 
> > Index: linux-pm/include/linux/hrtimer.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/hrtimer.h
> > +++ linux-pm/include/linux/hrtimer.h
> > @@ -426,6 +426,7 @@ static inline ktime_t hrtimer_get_remain
> >  }
> >  
> >  extern u64 hrtimer_get_next_event(void);
> > +extern u64 hrtimer_next_event_without(const struct hrtimer *exclude);
> >  
> >  extern bool hrtimer_active(const struct hrtimer *timer);
> >  
> > Index: linux-pm/kernel/time/hrtimer.c
> > ===================================================================
> > --- linux-pm.orig/kernel/time/hrtimer.c
> > +++ linux-pm/kernel/time/hrtimer.c
> > @@ -490,6 +490,7 @@ __next_base(struct hrtimer_cpu_base *cpu
> >  	while ((base = __next_base((cpu_base), &(active))))
> >  
> >  static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
> > +					 const struct hrtimer *exclude,
> >  					 unsigned int active,
> >  					 ktime_t expires_next)
> >  {
> > @@ -502,9 +503,24 @@ static ktime_t __hrtimer_next_event_base
> >  
> >  		next = timerqueue_getnext(&base->active);
> >  		timer = container_of(next, struct hrtimer, node);
> > +		if (timer == exclude) {
> > +			/* Get to the next timer in the queue. */
> > +			struct rb_node *rbn = rb_next(&next->node);
> > +
> > +			next = rb_entry_safe(rbn, struct timerqueue_node, node);
> > +			if (!next)
> > +				continue;
> 
> Minor cosmectic detail again, timerqueue_iterate_next() would do the job and
> avoid browsing timerqueue details.

And below is a patch to make this change on top of the original.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] time: hrtimer: Use timerqueue_iterate_next() to get to the next timer

Use timerqueue_iterate_next() to get to the next timer in
__hrtimer_next_event_base() without browsing the timerqueue
details diredctly.

No intentional changes in functionality.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/hrtimer.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-pm/kernel/time/hrtimer.c
===================================================================
--- linux-pm.orig/kernel/time/hrtimer.c
+++ linux-pm/kernel/time/hrtimer.c
@@ -505,9 +505,7 @@ static ktime_t __hrtimer_next_event_base
 		timer = container_of(next, struct hrtimer, node);
 		if (timer == exclude) {
 			/* Get to the next timer in the queue. */
-			struct rb_node *rbn = rb_next(&next->node);
-
-			next = rb_entry_safe(rbn, struct timerqueue_node, node);
+			next = timerqueue_iterate_next(next);
 			if (!next)
 				continue;
 
