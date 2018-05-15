Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeEOBvg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 21:51:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42770 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeEOBve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 21:51:34 -0400
X-Google-Smtp-Source: AB8JxZpJm2WF0zaLx8bXzsCXlTgL2Kzr4f/+austMWrGpMEWlCRi1TSgu5xChnwzGgGx1S942jxmNw==
Date: Mon, 14 May 2018 18:51:33 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 1/8] rcu: Add comment documenting how rcu_seq_snap
 works
Message-ID: <20180515015133.GH209519@joelaf.mtv.corp.google.com>
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-2-joel@joelfernandes.org>
 <20180514173816.GA26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514173816.GA26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:38:16AM -0700, Paul E. McKenney wrote:
> On Sun, May 13, 2018 at 08:15:34PM -0700, Joel Fernandes (Google) wrote:
> > rcu_seq_snap may be tricky for someone looking at it for the first time.
> > Lets document how it works with an example to make it easier.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/rcu.h | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 003671825d62..fc3170914ac7 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -91,7 +91,29 @@ static inline void rcu_seq_end(unsigned long *sp)
> >  	WRITE_ONCE(*sp, rcu_seq_endval(sp));
> >  }
> > 
> > -/* Take a snapshot of the update side's sequence number. */
> > +/*
> > + * Take a snapshot of the update side's sequence number.
> > + *
> > + * This function predicts what the grace period number will be the next
> > + * time an RCU callback will be executed, given the current grace period's
> > + * number. This can be gp+1 if RCU is idle, or gp+2 if a grace period is
> > + * already in progress.
> 
> How about something like this?
> 
> 	This function returns the earliest value of the grace-period
> 	sequence number that will indicate that a full grace period has
> 	elapsed since the current time.  Once the grace-period sequence
> 	number has reached this value, it will be safe to invoke all
> 	callbacks that have been registered prior to the current time.
> 	This value is the current grace-period number plus two to the
> 	power of the number of low-order bits reserved for state, then
> 	rounded up to the next value in which the state bits are all zero.

This makes sense too, but do you disagree with what I said?

I was kind of thinking of snap along the lines of how the previous code
worked. Where you were calling rcu_cbs_completed() or a function with a
similar name. Now we call _snap.

So basically I connected these 2 facts together to mean that rcu_seq_snap
also does that same thing as rcu_cbs_completed - which is basically it gives
the "next GP" where existing callbacks have already run and new callbacks
will run at the end of this "next GP".

> > + *
> > + * We do this with a single addition and masking.
> 
> Please either fold this sentence into rest of the paragraph or add a
> blank line after it.
> 
> > + * For example, if RCU_SEQ_STATE_MASK=1 and the least significant bit (LSB) of
> > + * the seq is used to track if a GP is in progress or not, its sufficient if we
> > + * add (2+1) and mask with ~1. Let's see why with an example:
> > + *
> > + * Say the current seq is 6 which is 0b110 (gp is 3 and state bit is 0).
> > + * To get the next GP number, we have to at least add 0b10 to this (0x1 << 1)
> > + * to account for the state bit. However, if the current seq is 7 (gp is 3 and
> > + * state bit is 1), then it means the current grace period is already in
> > + * progress so the next time the callback will run is at the end of grace
> > + * period number gp+2. To account for the extra +1, we just overflow the LSB by
> > + * adding another 0x1 and masking with ~0x1. In case no GP was in progress (RCU
> > + * is idle), then the addition of the extra 0x1 and masking will have no
> > + * effect. This is calculated as below.
> > + */
> 
> Having the explicit numbers is good, but please use RCU_SEQ_STATE_MASK=3,
> since that is the current value.  One alternative (or perhaps addition)
> is to have a short table of numbers showing the mapping from *sp to the
> return value.  (I started from such a table when writing this function,
> for whatever that is worth.)

Ok I'll try to give a better example above. thanks,

Also just to let you know, thanks so much for elaborately providing an
example on the other thread where we are discussing the rcu_seq_done check. I
will take some time to trace this down and see if I can zero in on the same
understanding as yours.

I get why we use rcu_seq_snap there in rcu_start_this_gp but the way it its
used is 'c' is the requested GP obtained from _snap, and we are comparing that with the existing
rnp->gp_seq in rcu_seq_done.  When that rnp->gp_seq reaches 'c', it only
means rnp->gp_seq is done, it doesn't tell us if 'c' is done which is what
we were trying to check in that loop... that's why I felt that check wasn't
correct - that's my (most likely wrong) take on the matter, and I'll get back
once I trace this a bit more hopefully today :-P

thanks!

- Joel
 
