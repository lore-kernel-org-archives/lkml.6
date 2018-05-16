Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeEPXV1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 19:21:27 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36111 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeEPXV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 19:21:26 -0400
X-Google-Smtp-Source: AB8JxZpyWIig2Hxpr+uS9PKZnIDaG24JvMSQF6mbXUbZ51ywb2H8uatA2VVagTYotOmtewm/D6EoPQ==
Date: Wed, 16 May 2018 16:21:24 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 1/8] rcu: Add comment documenting how rcu_seq_snap
 works
Message-ID: <20180516232124.GC221547@joelaf.mtv.corp.google.com>
References: <20180514031541.67247-2-joel@joelfernandes.org>
 <20180514173816.GA26088@linux.vnet.ibm.com>
 <20180515015133.GH209519@joelaf.mtv.corp.google.com>
 <20180515035951.GB26088@linux.vnet.ibm.com>
 <20180515070243.GA55557@joelaf.mtv.corp.google.com>
 <20180515125507.GE26088@linux.vnet.ibm.com>
 <20180515184115.GC169754@joelaf.mtv.corp.google.com>
 <20180515190801.GM26088@linux.vnet.ibm.com>
 <20180515225509.GA7510@joelaf.mtv.corp.google.com>
 <20180516154543.GD3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516154543.GD3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 08:45:43AM -0700, Paul E. McKenney wrote:
[...]
> > > > The code would be correct then, but one issue is it would shout out the
> > > > 'Prestarted' tracepoint for 'c' when that's not really true..
> > > > 
> > > >                rcu_seq_done(&rnp_root->gp_seq, c)
> > > > 
> > > > translates to ULONG_CMP_GE(&rnp_root->gp_seq, c)
> > > > 
> > > > which translates to the fact that c-1 completed.
> > > > 
> > > > So in this case if rcu_seq_done returns true, then saying that c has been
> > > > 'Prestarted' seems a bit off to me. It should be 'Startedleaf' or something
> > > > since what we really are doing is just marking the leaf as you mentioned in
> > > > the unlock_out part for a future start.
> > > 
> > > Indeed, some of the tracing is not all that accurate.  But the trace
> > > message itself contains the information needed to work out why the
> > > loop was exited, so perhaps something like 'EarlyExit'?
> > 
> > I think since you're now using rcu_seq_start to determine if c has started or
> > completed since, the current 'Prestarted' trace will cover it.
> 
> "My work is done!"  ;-)

:-D Its cool how a conversation can turn into a code improvement.

> > > ------------------------------------------------------------------------
> > > 
> > > commit 59a4f38edcffbef1521852fe3b26ed4ed85af16e
> > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Date:   Tue May 15 11:53:41 2018 -0700
> > > 
> > >     rcu: Make rcu_start_this_gp() check for grace period already started
> > >     
> > >     In the old days of ->gpnum and ->completed, the code requesting a new
> > >     grace period checked to see if that grace period had already started,
> > >     bailing early if so.  The new-age ->gp_seq approach instead checks
> > >     whether the grace period has already finished.  A compensating change
> > >     pushed the requested grace period down to the bottom of the tree, thus
> > >     reducing lock contention and even eliminating it in some cases.  But why
> > >     not further reduce contention, especially on large systems, by doing both,
> > >     especially given that the cost of doing both is extremely small?
> > >     
> > >     This commit therefore adds a new rcu_seq_started() function that checks
> > >     whether a specified grace period has already started.  It then uses
> > >     this new function in place of rcu_seq_done() in the rcu_start_this_gp()
> > >     function's funnel locking code.
> > >     
> > >     Reported-by: Joel Fernandes <joel@joelfernandes.org>
> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > 
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index 003671825d62..1c5cbd9d7c97 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -108,6 +108,15 @@ static inline unsigned long rcu_seq_current(unsigned long *sp)
> > >  }
> > >  
> > >  /*
> > > + * Given a snapshot from rcu_seq_snap(), determine whether or not the
> > > + * corresponding update-side operation has started.
> > > + */
> > > +static inline bool rcu_seq_started(unsigned long *sp, unsigned long s)
> > > +{
> > > +	return ULONG_CMP_LT((s - 1) & ~RCU_SEQ_STATE_MASK, READ_ONCE(*sp));
> > > +}
> > > +
> > > +/*
> > >   * Given a snapshot from rcu_seq_snap(), determine whether or not a
> > >   * full update-side operation has occurred.
> > >   */
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 9e900c5926cc..ed69f49b7054 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1580,7 +1580,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> > >  		if (rnp_root != rnp)
> > >  			raw_spin_lock_rcu_node(rnp_root);
> > >  		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, c) ||
> > > -		    rcu_seq_done(&rnp_root->gp_seq, c) ||
> > > +		    rcu_seq_started(&rnp_root->gp_seq, c) ||
> > 
> > Yes, this does exactly what I was wanting, thanks! I think this puts our
> > discussion about this to rest :-)
> > 
> > By the way I was starting to beautify this loop like below last week, with
> > code comments.  I felt it would be easier to parse this loop in the future
> > for whoever was reading it.  Are you interested in such a patch? If not, let
> > me know and I'll drop this and focus on the other changes you requested.
> > 
> > Something like...  (just an example , actual code would be different)
> > 
> >        for (rnp_node = rnp; 1; rnp_node = rnp_node->parent) {
> >                int prestarted = 0;
> > 
> >                /* Acquire lock if non-leaf node */
> >                if (rnp_node != rnp)
> >                        raw_spin_lock_rcu_node(rnp_node);
> > 
> >                /* Has the GP asked been recorded as a future need */
> >                if (ULONG_CMP_GE(rnp_node->gp_seq_needed, gp_seq_start))
> >                        prestarted = 1;
> > 
> >                /* Has the GP requested for already been completed */
> >                if (!prestarted && rcu_seq_completed(&rnp_node->gp_seq, gp_seq_start))
> >                        prestarted = 1;
> > 
> > 		... etc...
> > 	       if (prestarted) {
> >                        trace_rcu_this_gp(rnp_node, rdp, gp_seq_start,
> >                                          TPS("Prestarted"));
> >                        goto unlock_out;
> > 		}
> 
> At the moment, I don't believe that the extra lines of code pay for
> themselves, but I do agree that this loop is a bit more obtuse than I
> would like.

Yeah I was also thinking the same. I'm glad I checked, thanks for the
feedback. I'll focus on the other comments then.

thanks,

- Joel
