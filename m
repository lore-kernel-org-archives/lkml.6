Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756507AbeDFOTg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932261AbeDFOTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:19:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EA620B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Fri, 6 Apr 2018 16:19:16 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
Subject: Re: [PATCH v9 05/10] cpuidle: Return nohz hint from cpuidle_select()
Message-ID: <20180406141915.GC4400@lerouge>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
 <5818594.T4StF86Hkt@aspire.rjw.lan>
 <20180406024413.GB4400@lerouge>
 <1694033.ykrRIB27yN@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694033.ykrRIB27yN@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 09:24:42AM +0200, Rafael J. Wysocki wrote:
> On Friday, April 6, 2018 4:44:14 AM CEST Frederic Weisbecker wrote:
> > On Wed, Apr 04, 2018 at 10:39:50AM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Index: linux-pm/kernel/time/tick-sched.c
> > > ===================================================================
> > > --- linux-pm.orig/kernel/time/tick-sched.c
> > > +++ linux-pm/kernel/time/tick-sched.c
> > > @@ -991,6 +991,20 @@ void tick_nohz_irq_exit(void)
> > >  }
> > >  
> > >  /**
> > > + * tick_nohz_idle_got_tick - Check whether or not the tick handler has run
> > > + */
> > > +bool tick_nohz_idle_got_tick(void)
> > > +{
> > > +	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> > > +
> > > +	if (ts->inidle > 1) {
> > > +		ts->inidle = 1;
> > > +		return true;
> > > +	}
> > > +	return false;
> > > +}
> > > +
> > > +/**
> > >   * tick_nohz_get_sleep_length - return the length of the current sleep
> > >   *
> > >   * Called from power state control code with interrupts disabled
> > > @@ -1101,6 +1115,9 @@ static void tick_nohz_handler(struct clo
> > >  	struct pt_regs *regs = get_irq_regs();
> > >  	ktime_t now = ktime_get();
> > >  
> > > +	if (ts->inidle)
> > > +		ts->inidle = 2;
> > > +
> > 
> > You can move that to tick_sched_do_timer() to avoid code duplication.
> 
> Right.
> 
> > Also these constants are very opaque. And even with proper symbols it wouldn't look
> > right to extend ts->inidle that way.
> 
> Well, this was a Peter's idea. :-)
> 
> > Perhaps you should add a field such as ts->got_idle_tick under the boolean fields
> > after the below patch:
> 
> OK, but at this point I'd prefer to make such changes on top of the existing
> set, because that's got quite some testing coverage already and honestly this
> is cosmetics in my view (albeit important).

Sure!

Thanks.
