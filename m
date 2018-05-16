Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeEPPof (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:44:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752075AbeEPPod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:44:33 -0400
Date: Wed, 16 May 2018 08:45:43 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 1/8] rcu: Add comment documenting how rcu_seq_snap
 works
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-2-joel@joelfernandes.org>
 <20180514173816.GA26088@linux.vnet.ibm.com>
 <20180515015133.GH209519@joelaf.mtv.corp.google.com>
 <20180515035951.GB26088@linux.vnet.ibm.com>
 <20180515070243.GA55557@joelaf.mtv.corp.google.com>
 <20180515125507.GE26088@linux.vnet.ibm.com>
 <20180515184115.GC169754@joelaf.mtv.corp.google.com>
 <20180515190801.GM26088@linux.vnet.ibm.com>
 <20180515225509.GA7510@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515225509.GA7510@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051615-0024-0000-0000-00000359DF09
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009035; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01033187; UDB=6.00528265; IPR=6.00812318;
 MB=3.00021147; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-16 15:44:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051615-0025-0000-0000-00004808F9BA
Message-Id: <20180516154543.GD3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 03:55:09PM -0700, Joel Fernandes wrote:
> On Tue, May 15, 2018 at 12:08:01PM -0700, Paul E. McKenney wrote:
> > On Tue, May 15, 2018 at 11:41:15AM -0700, Joel Fernandes wrote:
> > > On Tue, May 15, 2018 at 05:55:07AM -0700, Paul E. McKenney wrote:
> > > > On Tue, May 15, 2018 at 12:02:43AM -0700, Joel Fernandes wrote:
> > > > > Hi Paul,
> > > > > Good morning, hope you're having a great Tuesday. I managed to find some
> > > > > evening hours today to dig into this a bit more.
> > > > > 
> > > > > On Mon, May 14, 2018 at 08:59:52PM -0700, Paul E. McKenney wrote:
> > > > > > On Mon, May 14, 2018 at 06:51:33PM -0700, Joel Fernandes wrote:
> > > > > > > On Mon, May 14, 2018 at 10:38:16AM -0700, Paul E. McKenney wrote:
> > > > > > > > On Sun, May 13, 2018 at 08:15:34PM -0700, Joel Fernandes (Google) wrote:
> > > > > > > > > rcu_seq_snap may be tricky for someone looking at it for the first time.
> > > > > > > > > Lets document how it works with an example to make it easier.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > > > ---
> > > > > > > > >  kernel/rcu/rcu.h | 24 +++++++++++++++++++++++-
> > > > > > > > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > > > > > index 003671825d62..fc3170914ac7 100644
> > > > > > > > > --- a/kernel/rcu/rcu.h
> > > > > > > > > +++ b/kernel/rcu/rcu.h
> > > > > > > > > @@ -91,7 +91,29 @@ static inline void rcu_seq_end(unsigned long *sp)
> > > > > > > > >  	WRITE_ONCE(*sp, rcu_seq_endval(sp));
> > > > > > > > >  }
> > > > > > > > > 
> > > > > > > > > -/* Take a snapshot of the update side's sequence number. */
> > > > > > > > > +/*
> > > > > > > > > + * Take a snapshot of the update side's sequence number.
> > > > > > > > > + *
> > > > > > > > > + * This function predicts what the grace period number will be the next
> > > > > > > > > + * time an RCU callback will be executed, given the current grace period's
> > > > > > > > > + * number. This can be gp+1 if RCU is idle, or gp+2 if a grace period is
> > > > > > > > > + * already in progress.
> > > > > > > > 
> > > > > > > > How about something like this?
> > > > > > > > 
> > > > > > > > 	This function returns the earliest value of the grace-period
> > > > > > > > 	sequence number that will indicate that a full grace period has
> > > > > > > > 	elapsed since the current time.  Once the grace-period sequence
> > > > > > > > 	number has reached this value, it will be safe to invoke all
> > > > > > > > 	callbacks that have been registered prior to the current time.
> > > > > > > > 	This value is the current grace-period number plus two to the
> > > > > > > > 	power of the number of low-order bits reserved for state, then
> > > > > > > > 	rounded up to the next value in which the state bits are all zero.
> > > > > > > 
> > > > > > > This makes sense too, but do you disagree with what I said?
> > > > > > 
> > > > > > In a pedantic sense, definitely.  RCU callbacks are being executed pretty
> > > > > > much all the time on a busy system, so it is only the recently queued
> > > > > > ones that are guaranteed to be deferred that long.  And my experience
> > > > > > indicates that someone really will get confused by that distinction,
> > > > > > so I feel justified in being pedantic in this case.
> > > > > 
> > > > > Ok I agree, I'll include your comment above.
> > > > > 
> > > > > > > Also just to let you know, thanks so much for elaborately providing an
> > > > > > > example on the other thread where we are discussing the rcu_seq_done check. I
> > > > > > > will take some time to trace this down and see if I can zero in on the same
> > > > > > > understanding as yours.
> > > > > > > 
> > > > > > > I get why we use rcu_seq_snap there in rcu_start_this_gp but the way it its
> > > > > > > used is 'c' is the requested GP obtained from _snap, and we are comparing that with the existing
> > > > > > > rnp->gp_seq in rcu_seq_done.  When that rnp->gp_seq reaches 'c', it only
> > > > > > > means rnp->gp_seq is done, it doesn't tell us if 'c' is done which is what
> > > > > > > we were trying to check in that loop... that's why I felt that check wasn't
> > > > > > > correct - that's my (most likely wrong) take on the matter, and I'll get back
> > > > > > > once I trace this a bit more hopefully today :-P
> > > > > > 
> > > > > > If your point is that interrupts are disabled throughout, so there isn't
> > > > > > much chance of the grace period completing during that time, you are
> > > > > > mostly right.  The places you might not be right are the idle loop and
> > > > > > offline CPUs.  And yes, call_rcu() doesn't like queuing callbacks onto
> > > > > > offline CPUs, but IIRC it is just fine in the case where callbacks have
> > > > > > been offloaded from that CPU.
> > > > > > 
> > > > > > And if you instead say that "c" is the requested final ->gp_seq value
> > > > > > obtained from _snap(), the thought process might go more easily.
> > > > > 
> > > > > Yes I agree with c being the requested final value which is the GP for which
> > > > > the callbacks will be queued. At the end of the GP c, the callbacks will have
> > > > > executed.
> > > > > 
> > > > > About the rcu_seq_done check and why I believe its not right to use it in
> > > > > that funnel locking loop, if you could allow me to try argument my point from
> > > > > a different angle...
> > > > > 
> > > > > We agreed that the way gp_seq numbers work and are compared with each other
> > > > > to identify if a GP is elapsed or not, is different from the way the previous
> > > > > numbers (gp_num) were compared.
> > > > > 
> > > > > Most notably, before the gp_seq conversions - inorder to start a GP, we were
> > > > > doing gp_num += 1, and completed had to catch up to gp_num + 1 to mark the
> > > > > end.
> > > > > 
> > > > > Now with gp_seq, for a gp to start, we don't do the "+1", we just set the
> > > > > state bits. To mark the end, we clear the state bits and increment the gp_num
> > > > > part of gp_seq.
> > > > > 
> > > > > However, in the below commit 12d6c129fd0a ("rcu: Convert grace-period
> > > > > requests to ->gp_seq"). You did a one-to-one replacement of the ULONG_CMP_GE
> > > > > with rcu_seq_done. You did so even though the gp_seq numbers work differently
> > > > > from previously used numbers (gp_num and completed).
> > > > > 
> > > > > I would then argue that because of the differences above, a one-to-one
> > > > > replacement of the ULONG_CMP_GE with the rcu_seq_done wouldn't make sense.
> > > > > 
> > > > > I argue this because, in previous code - the ULONG_CMP_GE made sense for the gp_num
> > > > > way of things because, if c == gp_num, that means that :
> > > > >  - c started already
> > > > >  - c has finished.
> > > > >  Which worked correctly, because we have nothing to do and we can bail
> > > > >  without setting any flag.
> > > > > 
> > > > >  Where as now, with the gp_seq regime, c == gp_seq means:
> > > > >  - c-1 finished   (I meant -1 subtracted from the gp_num part of c)
> > > > >  This would cause us to bail without setting any flag for starting c.
> > > > > 
> > > > >  I did some tracing and I could never hit the rcu_seq_done check because it
> > > > >  never happens in my tracing that _snap returned something for which
> > > > >  rcu_seq_done returned true, so I'm not sure if this check is needed, but
> > > > >  you're the expert ;)
> > > > > 
> > > > > @@ -1629,16 +1583,16 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> > > > >          * not be released.
> > > > >          */
> > > > >         raw_lockdep_assert_held_rcu_node(rnp);
> > > > > +       WARN_ON_ONCE(c & 0x2); /* Catch any lingering use of ->gpnum. */
> > > > > +       WARN_ON_ONCE(((rnp->completed << RCU_SEQ_CTR_SHIFT) >> RCU_SEQ_CTR_SHIFT) != rcu_seq_ctr(rnp->gp_seq)); /* Catch any ->completed/->gp_seq mismatches. */
> > > > >         trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
> > > > >         for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
> > > > >                 if (rnp_root != rnp)
> > > > >                         raw_spin_lock_rcu_node(rnp_root);
> > > > > -               WARN_ON_ONCE(ULONG_CMP_LT(rnp_root->gpnum +
> > > > > -                                         need_future_gp_mask(), c));
> > > > >                 if (need_future_gp_element(rnp_root, c) ||
> > > > > -                   ULONG_CMP_GE(rnp_root->gpnum, c) ||
> > > > > +                   rcu_seq_done(&rnp_root->gp_seq, c) ||
> > > > > 
> > > > >                      ^^^^
> > > > > 		     A direct replacement of ULONG_CMP_GE is bit weird?  It
> > > > > 		     means we bail out if c-1 completed, and we don't set any
> > > > > 		     flag for starting c. That could result in the clean up
> > > > > 		     never starting c?
> > > > 
> > > > Ah, I see what you are getting at now.
> > > > 
> > > > What I do instead in 334dac2da529 ("rcu: Make rcu_nocb_wait_gp() check
> > > > if GP already requested") is to push the request down to the leaves of
> > > > the tree and to the rcu_data structure.  Once that commit is in place,
> > > > the check for the grace period already being in progress isn't all
> > > > that helpful, though I suppose that it could be added.  One way to
> > > > do that would be to replace "rcu_seq_done(&rnp_root->gp_seq, c)" with
> > > > ULONG_CMP_GE(rnp_root->gpnum, (c - RCU_SEQ_STATE_MASK))", but that seems
> > > > a bit baroque to me.
> > > > 
> > > > The point of the rcu_seq_done() is to catch long delays, but given the
> > > > current implementation, the fact that interrupts are disabled across
> > > > all calls should prevent the rcu_seq_done() from ever returning true.
> > > > (Famous last words!)  So, yes, it could be removed, in theory, at least.
> > > > At least until the real-time guys force me to come up with a way to
> > > > run this code with interrupts enabled (hopefully never!).
> > > > 
> > > > If I were to do that, I would first wrap it with a WARN_ON_ONCE() and
> > > > leave it that way for an extended period of testing.  Yes, I am paranoid.
> > > > Why do you ask?  ;-)
> > > :-D
> > > 
> > > Ah I see what you're doing in that commit where you're moving the furthest
> > > request down to the leaves, so that would protect against the scenario I was
> > > describing and set the gp_seq_needed of the leaf.
> > 
> > But I came up with a less baroque check for a grace period having started,
> > at which point the question becomes "Why not just do both?", especially
> > since a check for a grace period having started is satisfied by that
> > grace period's having completed, which means minimal added overhead.
> > Perhaps no added overhead for some compilers and architectures.
> > 
> > Please see the end of this email for a prototype patch.
> > 
> > > The code would be correct then, but one issue is it would shout out the
> > > 'Prestarted' tracepoint for 'c' when that's not really true..
> > > 
> > >                rcu_seq_done(&rnp_root->gp_seq, c)
> > > 
> > > translates to ULONG_CMP_GE(&rnp_root->gp_seq, c)
> > > 
> > > which translates to the fact that c-1 completed.
> > > 
> > > So in this case if rcu_seq_done returns true, then saying that c has been
> > > 'Prestarted' seems a bit off to me. It should be 'Startedleaf' or something
> > > since what we really are doing is just marking the leaf as you mentioned in
> > > the unlock_out part for a future start.
> > 
> > Indeed, some of the tracing is not all that accurate.  But the trace
> > message itself contains the information needed to work out why the
> > loop was exited, so perhaps something like 'EarlyExit'?
> 
> I think since you're now using rcu_seq_start to determine if c has started or
> completed since, the current 'Prestarted' trace will cover it.

"My work is done!"  ;-)

> > ------------------------------------------------------------------------
> > 
> > commit 59a4f38edcffbef1521852fe3b26ed4ed85af16e
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Tue May 15 11:53:41 2018 -0700
> > 
> >     rcu: Make rcu_start_this_gp() check for grace period already started
> >     
> >     In the old days of ->gpnum and ->completed, the code requesting a new
> >     grace period checked to see if that grace period had already started,
> >     bailing early if so.  The new-age ->gp_seq approach instead checks
> >     whether the grace period has already finished.  A compensating change
> >     pushed the requested grace period down to the bottom of the tree, thus
> >     reducing lock contention and even eliminating it in some cases.  But why
> >     not further reduce contention, especially on large systems, by doing both,
> >     especially given that the cost of doing both is extremely small?
> >     
> >     This commit therefore adds a new rcu_seq_started() function that checks
> >     whether a specified grace period has already started.  It then uses
> >     this new function in place of rcu_seq_done() in the rcu_start_this_gp()
> >     function's funnel locking code.
> >     
> >     Reported-by: Joel Fernandes <joel@joelfernandes.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 003671825d62..1c5cbd9d7c97 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -108,6 +108,15 @@ static inline unsigned long rcu_seq_current(unsigned long *sp)
> >  }
> >  
> >  /*
> > + * Given a snapshot from rcu_seq_snap(), determine whether or not the
> > + * corresponding update-side operation has started.
> > + */
> > +static inline bool rcu_seq_started(unsigned long *sp, unsigned long s)
> > +{
> > +	return ULONG_CMP_LT((s - 1) & ~RCU_SEQ_STATE_MASK, READ_ONCE(*sp));
> > +}
> > +
> > +/*
> >   * Given a snapshot from rcu_seq_snap(), determine whether or not a
> >   * full update-side operation has occurred.
> >   */
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 9e900c5926cc..ed69f49b7054 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1580,7 +1580,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> >  		if (rnp_root != rnp)
> >  			raw_spin_lock_rcu_node(rnp_root);
> >  		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, c) ||
> > -		    rcu_seq_done(&rnp_root->gp_seq, c) ||
> > +		    rcu_seq_started(&rnp_root->gp_seq, c) ||
> 
> Yes, this does exactly what I was wanting, thanks! I think this puts our
> discussion about this to rest :-)
> 
> By the way I was starting to beautify this loop like below last week, with
> code comments.  I felt it would be easier to parse this loop in the future
> for whoever was reading it.  Are you interested in such a patch? If not, let
> me know and I'll drop this and focus on the other changes you requested.
> 
> Something like...  (just an example , actual code would be different)
> 
>        for (rnp_node = rnp; 1; rnp_node = rnp_node->parent) {
>                int prestarted = 0;
> 
>                /* Acquire lock if non-leaf node */
>                if (rnp_node != rnp)
>                        raw_spin_lock_rcu_node(rnp_node);
> 
>                /* Has the GP asked been recorded as a future need */
>                if (ULONG_CMP_GE(rnp_node->gp_seq_needed, gp_seq_start))
>                        prestarted = 1;
> 
>                /* Has the GP requested for already been completed */
>                if (!prestarted && rcu_seq_completed(&rnp_node->gp_seq, gp_seq_start))
>                        prestarted = 1;
> 
> 		... etc...
> 	       if (prestarted) {
>                        trace_rcu_this_gp(rnp_node, rdp, gp_seq_start,
>                                          TPS("Prestarted"));
>                        goto unlock_out;
> 		}

At the moment, I don't believe that the extra lines of code pay for
themselves, but I do agree that this loop is a bit more obtuse than I
would like.

							Thanx, Paul
