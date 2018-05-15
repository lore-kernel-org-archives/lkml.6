Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeEOD62 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 23:58:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752084AbeEOD60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 23:58:26 -0400
Date: Mon, 14 May 2018 20:59:52 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515015133.GH209519@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051503-0036-0000-0000-000002F4E1BE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009027; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032472; UDB=6.00527837; IPR=6.00811603;
 MB=3.00021117; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-15 03:58:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051503-0037-0000-0000-00004456853C
Message-Id: <20180515035951.GB26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 06:51:33PM -0700, Joel Fernandes wrote:
> On Mon, May 14, 2018 at 10:38:16AM -0700, Paul E. McKenney wrote:
> > On Sun, May 13, 2018 at 08:15:34PM -0700, Joel Fernandes (Google) wrote:
> > > rcu_seq_snap may be tricky for someone looking at it for the first time.
> > > Lets document how it works with an example to make it easier.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/rcu.h | 24 +++++++++++++++++++++++-
> > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index 003671825d62..fc3170914ac7 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -91,7 +91,29 @@ static inline void rcu_seq_end(unsigned long *sp)
> > >  	WRITE_ONCE(*sp, rcu_seq_endval(sp));
> > >  }
> > > 
> > > -/* Take a snapshot of the update side's sequence number. */
> > > +/*
> > > + * Take a snapshot of the update side's sequence number.
> > > + *
> > > + * This function predicts what the grace period number will be the next
> > > + * time an RCU callback will be executed, given the current grace period's
> > > + * number. This can be gp+1 if RCU is idle, or gp+2 if a grace period is
> > > + * already in progress.
> > 
> > How about something like this?
> > 
> > 	This function returns the earliest value of the grace-period
> > 	sequence number that will indicate that a full grace period has
> > 	elapsed since the current time.  Once the grace-period sequence
> > 	number has reached this value, it will be safe to invoke all
> > 	callbacks that have been registered prior to the current time.
> > 	This value is the current grace-period number plus two to the
> > 	power of the number of low-order bits reserved for state, then
> > 	rounded up to the next value in which the state bits are all zero.
> 
> This makes sense too, but do you disagree with what I said?

In a pedantic sense, definitely.  RCU callbacks are being executed pretty
much all the time on a busy system, so it is only the recently queued
ones that are guaranteed to be deferred that long.  And my experience
indicates that someone really will get confused by that distinction,
so I feel justified in being pedantic in this case.

> I was kind of thinking of snap along the lines of how the previous code
> worked. Where you were calling rcu_cbs_completed() or a function with a
> similar name. Now we call _snap.

You are quite correct that rcu_seq_snap() is the new analog of
rcu_cbs_completed(), though there are differences due to the old ->gpnum
and ->completed now being represented by a single ->gp_seq value.

> So basically I connected these 2 facts together to mean that rcu_seq_snap
> also does that same thing as rcu_cbs_completed - which is basically it gives
> the "next GP" where existing callbacks have already run and new callbacks
> will run at the end of this "next GP".

Ah, but you didn't have the qualifier "new" in your original.  And even
then, the definition of "new" might be different for different readers.

> > > + *
> > > + * We do this with a single addition and masking.
> > 
> > Please either fold this sentence into rest of the paragraph or add a
> > blank line after it.
> > 
> > > + * For example, if RCU_SEQ_STATE_MASK=1 and the least significant bit (LSB) of
> > > + * the seq is used to track if a GP is in progress or not, its sufficient if we
> > > + * add (2+1) and mask with ~1. Let's see why with an example:
> > > + *
> > > + * Say the current seq is 6 which is 0b110 (gp is 3 and state bit is 0).
> > > + * To get the next GP number, we have to at least add 0b10 to this (0x1 << 1)
> > > + * to account for the state bit. However, if the current seq is 7 (gp is 3 and
> > > + * state bit is 1), then it means the current grace period is already in
> > > + * progress so the next time the callback will run is at the end of grace
> > > + * period number gp+2. To account for the extra +1, we just overflow the LSB by
> > > + * adding another 0x1 and masking with ~0x1. In case no GP was in progress (RCU
> > > + * is idle), then the addition of the extra 0x1 and masking will have no
> > > + * effect. This is calculated as below.
> > > + */
> > 
> > Having the explicit numbers is good, but please use RCU_SEQ_STATE_MASK=3,
> > since that is the current value.  One alternative (or perhaps addition)
> > is to have a short table of numbers showing the mapping from *sp to the
> > return value.  (I started from such a table when writing this function,
> > for whatever that is worth.)
> 
> Ok I'll try to give a better example above. thanks,

Sounds good!

> Also just to let you know, thanks so much for elaborately providing an
> example on the other thread where we are discussing the rcu_seq_done check. I
> will take some time to trace this down and see if I can zero in on the same
> understanding as yours.
> 
> I get why we use rcu_seq_snap there in rcu_start_this_gp but the way it its
> used is 'c' is the requested GP obtained from _snap, and we are comparing that with the existing
> rnp->gp_seq in rcu_seq_done.  When that rnp->gp_seq reaches 'c', it only
> means rnp->gp_seq is done, it doesn't tell us if 'c' is done which is what
> we were trying to check in that loop... that's why I felt that check wasn't
> correct - that's my (most likely wrong) take on the matter, and I'll get back
> once I trace this a bit more hopefully today :-P

If your point is that interrupts are disabled throughout, so there isn't
much chance of the grace period completing during that time, you are
mostly right.  The places you might not be right are the idle loop and
offline CPUs.  And yes, call_rcu() doesn't like queuing callbacks onto
offline CPUs, but IIRC it is just fine in the case where callbacks have
been offloaded from that CPU.

And if you instead say that "c" is the requested final ->gp_seq value
obtained from _snap(), the thought process might go more easily.

							Thanx, Paul
