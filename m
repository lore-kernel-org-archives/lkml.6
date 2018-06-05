Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbeFEIQT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:16:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58218 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeFEIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:16:17 -0400
Date: Tue, 5 Jun 2018 10:16:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 13/19] mm/migrate: Use xchg instead of spinlock
Message-ID: <20180605081606.GE12217@hirez.programming.kicks-ass.net>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-14-git-send-email-srikar@linux.vnet.ibm.com>
 <20180604192821.GB12217@hirez.programming.kicks-ass.net>
 <20180605072439.GE30328@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605072439.GE30328@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 12:24:39AM -0700, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2018-06-04 21:28:21]:
> 
> > >  	if (time_after(jiffies, pgdat->numabalancing_migrate_next_window)) {
> > > -		spin_lock(&pgdat->numabalancing_migrate_lock);
> > > -		pgdat->numabalancing_migrate_nr_pages = 0;
> > > -		pgdat->numabalancing_migrate_next_window = jiffies +
> > > -			msecs_to_jiffies(migrate_interval_millisecs);
> > > -		spin_unlock(&pgdat->numabalancing_migrate_lock);
> > > +		if (xchg(&pgdat->numabalancing_migrate_nr_pages, 0))
> > > +			pgdat->numabalancing_migrate_next_window = jiffies +
> > > +				msecs_to_jiffies(migrate_interval_millisecs);
> >
> > Note that both are in fact wrong. That wants to be something like:
> >
> > 	pgdat->numabalancing_migrate_next_window += interval;
> >
> > Otherwise you stretch every interval by 'jiffies - numabalancing_migrate_next_window'.
> 
> Okay, I get your point.

Note that in practise it probably doesn't matter, but it just upsets my
OCD ;-)

> > Also, that all wants READ_ONCE/WRITE_ONCE, irrespective of the
> > spinlock/xchg.

> unsigned long interval = READ_ONCE(pgdat->numabalancing_migrate_next_window);
> 
> if (time_after(jiffies, interval)) {
> 	interval += msecs_to_jiffies(migrate_interval_millisecs));
> 	if (xchg(&pgdat->numabalancing_migrate_nr_pages, 0))
> 		WRITE_ONCE(pgdat->numabalancing_migrate_next_window, interval);
> }
> 
> Something like this?

Almost, you forgot about the case where 'jiffies -
numabalancing_migrate_next_window > interval'.

That wants to be something like:

  unsigned long timo = READ_ONCE(stupid_long_name);

  if (time_after(jiffies, timo) && xchg(&other_long_name, 0)) {
	  do {
		  timo += msec_to_jiffies(..);
	  } while (unlikely(time_after(jiffies, timo);

	  WRITE_ONCE(stupid_long_name, timo);
  }
