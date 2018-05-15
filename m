Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeEOSlT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:41:19 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37144 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeEOSlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:41:17 -0400
X-Google-Smtp-Source: AB8JxZrefspWLJxOkfE1BJ04E45cu0LG9Cgw0+C2MIMXFbs8xqA0JYreDlCBt5EyofVIb7X5f5Na4Q==
Date: Tue, 15 May 2018 11:41:15 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 1/8] rcu: Add comment documenting how rcu_seq_snap
 works
Message-ID: <20180515184115.GC169754@joelaf.mtv.corp.google.com>
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-2-joel@joelfernandes.org>
 <20180514173816.GA26088@linux.vnet.ibm.com>
 <20180515015133.GH209519@joelaf.mtv.corp.google.com>
 <20180515035951.GB26088@linux.vnet.ibm.com>
 <20180515070243.GA55557@joelaf.mtv.corp.google.com>
 <20180515125507.GE26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515125507.GE26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 05:55:07AM -0700, Paul E. McKenney wrote:
> On Tue, May 15, 2018 at 12:02:43AM -0700, Joel Fernandes wrote:
> > Hi Paul,
> > Good morning, hope you're having a great Tuesday. I managed to find some
> > evening hours today to dig into this a bit more.
> > 
> > On Mon, May 14, 2018 at 08:59:52PM -0700, Paul E. McKenney wrote:
> > > On Mon, May 14, 2018 at 06:51:33PM -0700, Joel Fernandes wrote:
> > > > On Mon, May 14, 2018 at 10:38:16AM -0700, Paul E. McKenney wrote:
> > > > > On Sun, May 13, 2018 at 08:15:34PM -0700, Joel Fernandes (Google) wrote:
> > > > > > rcu_seq_snap may be tricky for someone looking at it for the first time.
> > > > > > Lets document how it works with an example to make it easier.
> > > > > > 
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > ---
> > > > > >  kernel/rcu/rcu.h | 24 +++++++++++++++++++++++-
> > > > > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > > index 003671825d62..fc3170914ac7 100644
> > > > > > --- a/kernel/rcu/rcu.h
> > > > > > +++ b/kernel/rcu/rcu.h
> > > > > > @@ -91,7 +91,29 @@ static inline void rcu_seq_end(unsigned long *sp)
> > > > > >  	WRITE_ONCE(*sp, rcu_seq_endval(sp));
> > > > > >  }
> > > > > > 
> > > > > > -/* Take a snapshot of the update side's sequence number. */
> > > > > > +/*
> > > > > > + * Take a snapshot of the update side's sequence number.
> > > > > > + *
> > > > > > + * This function predicts what the grace period number will be the next
> > > > > > + * time an RCU callback will be executed, given the current grace period's
> > > > > > + * number. This can be gp+1 if RCU is idle, or gp+2 if a grace period is
> > > > > > + * already in progress.
> > > > > 
> > > > > How about something like this?
> > > > > 
> > > > > 	This function returns the earliest value of the grace-period
> > > > > 	sequence number that will indicate that a full grace period has
> > > > > 	elapsed since the current time.  Once the grace-period sequence
> > > > > 	number has reached this value, it will be safe to invoke all
> > > > > 	callbacks that have been registered prior to the current time.
> > > > > 	This value is the current grace-period number plus two to the
> > > > > 	power of the number of low-order bits reserved for state, then
> > > > > 	rounded up to the next value in which the state bits are all zero.
> > > > 
> > > > This makes sense too, but do you disagree with what I said?
> > > 
> > > In a pedantic sense, definitely.  RCU callbacks are being executed pretty
> > > much all the time on a busy system, so it is only the recently queued
> > > ones that are guaranteed to be deferred that long.  And my experience
> > > indicates that someone really will get confused by that distinction,
> > > so I feel justified in being pedantic in this case.
> > 
> > Ok I agree, I'll include your comment above.
> > 
> > > > Also just to let you know, thanks so much for elaborately providing an
> > > > example on the other thread where we are discussing the rcu_seq_done check. I
> > > > will take some time to trace this down and see if I can zero in on the same
> > > > understanding as yours.
> > > > 
> > > > I get why we use rcu_seq_snap there in rcu_start_this_gp but the way it its
> > > > used is 'c' is the requested GP obtained from _snap, and we are comparing that with the existing
> > > > rnp->gp_seq in rcu_seq_done.  When that rnp->gp_seq reaches 'c', it only
> > > > means rnp->gp_seq is done, it doesn't tell us if 'c' is done which is what
> > > > we were trying to check in that loop... that's why I felt that check wasn't
> > > > correct - that's my (most likely wrong) take on the matter, and I'll get back
> > > > once I trace this a bit more hopefully today :-P
> > > 
> > > If your point is that interrupts are disabled throughout, so there isn't
> > > much chance of the grace period completing during that time, you are
> > > mostly right.  The places you might not be right are the idle loop and
> > > offline CPUs.  And yes, call_rcu() doesn't like queuing callbacks onto
> > > offline CPUs, but IIRC it is just fine in the case where callbacks have
> > > been offloaded from that CPU.
> > > 
> > > And if you instead say that "c" is the requested final ->gp_seq value
> > > obtained from _snap(), the thought process might go more easily.
> > 
> > Yes I agree with c being the requested final value which is the GP for which
> > the callbacks will be queued. At the end of the GP c, the callbacks will have
> > executed.
> > 
> > About the rcu_seq_done check and why I believe its not right to use it in
> > that funnel locking loop, if you could allow me to try argument my point from
> > a different angle...
> > 
> > We agreed that the way gp_seq numbers work and are compared with each other
> > to identify if a GP is elapsed or not, is different from the way the previous
> > numbers (gp_num) were compared.
> > 
> > Most notably, before the gp_seq conversions - inorder to start a GP, we were
> > doing gp_num += 1, and completed had to catch up to gp_num + 1 to mark the
> > end.
> > 
> > Now with gp_seq, for a gp to start, we don't do the "+1", we just set the
> > state bits. To mark the end, we clear the state bits and increment the gp_num
> > part of gp_seq.
> > 
> > However, in the below commit 12d6c129fd0a ("rcu: Convert grace-period
> > requests to ->gp_seq"). You did a one-to-one replacement of the ULONG_CMP_GE
> > with rcu_seq_done. You did so even though the gp_seq numbers work differently
> > from previously used numbers (gp_num and completed).
> > 
> > I would then argue that because of the differences above, a one-to-one
> > replacement of the ULONG_CMP_GE with the rcu_seq_done wouldn't make sense.
> > 
> > I argue this because, in previous code - the ULONG_CMP_GE made sense for the gp_num
> > way of things because, if c == gp_num, that means that :
> >  - c started already
> >  - c has finished.
> >  Which worked correctly, because we have nothing to do and we can bail
> >  without setting any flag.
> > 
> >  Where as now, with the gp_seq regime, c == gp_seq means:
> >  - c-1 finished   (I meant -1 subtracted from the gp_num part of c)
> >  This would cause us to bail without setting any flag for starting c.
> > 
> >  I did some tracing and I could never hit the rcu_seq_done check because it
> >  never happens in my tracing that _snap returned something for which
> >  rcu_seq_done returned true, so I'm not sure if this check is needed, but
> >  you're the expert ;)
> > 
> > @@ -1629,16 +1583,16 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> >          * not be released.
> >          */
> >         raw_lockdep_assert_held_rcu_node(rnp);
> > +       WARN_ON_ONCE(c & 0x2); /* Catch any lingering use of ->gpnum. */
> > +       WARN_ON_ONCE(((rnp->completed << RCU_SEQ_CTR_SHIFT) >> RCU_SEQ_CTR_SHIFT) != rcu_seq_ctr(rnp->gp_seq)); /* Catch any ->completed/->gp_seq mismatches. */
> >         trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
> >         for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
> >                 if (rnp_root != rnp)
> >                         raw_spin_lock_rcu_node(rnp_root);
> > -               WARN_ON_ONCE(ULONG_CMP_LT(rnp_root->gpnum +
> > -                                         need_future_gp_mask(), c));
> >                 if (need_future_gp_element(rnp_root, c) ||
> > -                   ULONG_CMP_GE(rnp_root->gpnum, c) ||
> > +                   rcu_seq_done(&rnp_root->gp_seq, c) ||
> > 
> >                      ^^^^
> > 		     A direct replacement of ULONG_CMP_GE is bit weird?  It
> > 		     means we bail out if c-1 completed, and we don't set any
> > 		     flag for starting c. That could result in the clean up
> > 		     never starting c?
> 
> Ah, I see what you are getting at now.
> 
> What I do instead in 334dac2da529 ("rcu: Make rcu_nocb_wait_gp() check
> if GP already requested") is to push the request down to the leaves of
> the tree and to the rcu_data structure.  Once that commit is in place,
> the check for the grace period already being in progress isn't all
> that helpful, though I suppose that it could be added.  One way to
> do that would be to replace "rcu_seq_done(&rnp_root->gp_seq, c)" with
> ULONG_CMP_GE(rnp_root->gpnum, (c - RCU_SEQ_STATE_MASK))", but that seems
> a bit baroque to me.
> 
> The point of the rcu_seq_done() is to catch long delays, but given the
> current implementation, the fact that interrupts are disabled across
> all calls should prevent the rcu_seq_done() from ever returning true.
> (Famous last words!)  So, yes, it could be removed, in theory, at least.
> At least until the real-time guys force me to come up with a way to
> run this code with interrupts enabled (hopefully never!).
> 
> If I were to do that, I would first wrap it with a WARN_ON_ONCE() and
> leave it that way for an extended period of testing.  Yes, I am paranoid.
> Why do you ask?  ;-)
:-D

Ah I see what you're doing in that commit where you're moving the furthest
request down to the leaves, so that would protect against the scenario I was
describing and set the gp_seq_needed of the leaf.

The code would be correct then, but one issue is it would shout out the
'Prestarted' tracepoint for 'c' when that's not really true..

               rcu_seq_done(&rnp_root->gp_seq, c)

translates to ULONG_CMP_GE(&rnp_root->gp_seq, c)

which translates to the fact that c-1 completed.

So in this case if rcu_seq_done returns true, then saying that c has been
'Prestarted' seems a bit off to me. It should be 'Startedleaf' or something
since what we really are doing is just marking the leaf as you mentioned in
the unlock_out part for a future start.

thanks!

- Joel
