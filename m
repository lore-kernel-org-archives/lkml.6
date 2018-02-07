Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbeBGCdF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 21:33:05 -0500
Received: from h2.hallyn.com ([78.46.35.8]:39256 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753081AbeBGCdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 21:33:04 -0500
Date: Tue, 6 Feb 2018 20:33:03 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: Can RCU stall lead to hard lockups?
Message-ID: <20180207023303.GA10583@mail.hallyn.com>
References: <20180109035207.GD3668920@devbig577.frc2.facebook.com>
 <20180109042425.GS9671@linux.vnet.ibm.com>
 <20180109141114.GF3668920@devbig577.frc2.facebook.com>
 <20180109152234.GU9671@linux.vnet.ibm.com>
 <20180202234430.GA25611@mail.hallyn.com>
 <20180203205032.GN3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180203205032.GN3617@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 12:50:32PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 02, 2018 at 05:44:30PM -0600, Serge E. Hallyn wrote:
> > Quoting Paul E. McKenney (paulmck@linux.vnet.ibm.com):
> > > On Tue, Jan 09, 2018 at 06:11:14AM -0800, Tejun Heo wrote:
> > > > Hello, Paul.
> > > > 
> > > > On Mon, Jan 08, 2018 at 08:24:25PM -0800, Paul E. McKenney wrote:
> > > > > > I don't know the RCU code at all but it *looks* like the first CPU is
> > > > > > taking a sweet while flushing printk buffer while holding a lock (the
> > > > > > console is IPMI serial console, which faithfully emulates 115200 baud
> > > > > > rate), and everyone else seems stuck waiting for that spinlock in
> > > > > > rcu_check_callbacks().
> > > > > > 
> > > > > > Does this sound possible?
> > > > > 
> > > > > 115200 baud?  Ouch!!!  That -will- result in trouble from console
> > > > > printing, and often also in RCU CPU stall warnings.
> > > > 
> > > > It could even be slower than 115200, and we occassionally see RCU
> > > > stall warnings caused by printk storms, for example, while the kernel
> > > > is trying to dump a lot of info after an OOM.  That's an issue we
> > > > probably want to improve from printk side; however, they don't usually
> > > > lead to NMI hard lockup detector kicking in and crashing the machine,
> > > > which is the peculiarity here.
> > > > 
> > > > Hmmm... show_state_filter(), the function which dumps all task
> > > > backtraces, share a similar problem and it avoids it by explicitly
> > > > calling touch_nmi_watchdog().  Maybe we can do something like the
> > > > following from RCU too?
> > > 
> > > If this fixes things for you, I would welcome such a patch.
> > 
> > Hi - would this also be relevant to 4.9-stable and 4.4-stable, or
> > has something elsewhere changed after 4.9 that actually triggers this?
> 
> As far as I can tell, slow console lines have been prone to RCU CPU stall
> warnings for a very long time.
> 
> 							Thanx, Paul

Ok, thanks Paul.

Tejun were you going to push this?

> > thanks,
> > -serge
> > 
> > > 							Thanx, Paul
> > > 
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index db85ca3..3c4c4d3 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -561,8 +561,14 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
> > > >  	}
> > > >  	t = list_entry(rnp->gp_tasks->prev,
> > > >  		       struct task_struct, rcu_node_entry);
> > > > -	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry)
> > > > +	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
> > > > +		touch_nmi_watchdog();
> > > > +		/*
> > > > +		 * We could be printing a lot of these messages while
> > > > +		 * holding a spinlock.  Avoid triggering hard lockup.
> > > > +		 */
> > > >  		sched_show_task(t);
> > > > +	}
> > > >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > >  }
> > > > 
> > > > @@ -1678,6 +1684,12 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
> > > >  	char *ticks_title;
> > > >  	unsigned long ticks_value;
> > > > 
> > > > +	/*
> > > > +	 * We could be printing a lot of these messages while holding a
> > > > +	 * spinlock.  Avoid triggering hard lockup.
> > > > +	 */
> > > > +	touch_nmi_watchdog();
> > > > +
> > > >  	if (rsp->gpnum == rdp->gpnum) {
> > > >  		ticks_title = "ticks this GP";
> > > >  		ticks_value = rdp->ticks_this_gp;
> > > > 
> > 
