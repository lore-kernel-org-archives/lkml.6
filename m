Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753819AbeENNWZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:22:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751402AbeENNWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:22:22 -0400
Date: Mon, 14 May 2018 06:23:46 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel.opensrc@gmail.com, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: Re: [tip/core/rcu,16/21] rcu: Add funnel locking to
 rcu_start_this_gp()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180512060325.GA53808@joelaf.mtv.corp.google.com>
 <20180512144002.GI26088@linux.vnet.ibm.com>
 <20180512144438.GA12826@linux.vnet.ibm.com>
 <20180512235301.GD192642@joelaf.mtv.corp.google.com>
 <20180513153842.GK26088@linux.vnet.ibm.com>
 <20180513164953.GA8358@joelaf.mtv.corp.google.com>
 <20180513190906.GL26088@linux.vnet.ibm.com>
 <20180513195120.GA15962@joelaf.mtv.corp.google.com>
 <20180514022206.GM26088@linux.vnet.ibm.com>
 <20180514050009.GA80415@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514050009.GA80415@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051413-0008-0000-0000-000003073B34
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009024; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032180; UDB=6.00527662; IPR=6.00811311;
 MB=3.00021105; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 13:22:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051413-0009-0000-0000-0000393EC023
Message-Id: <20180514132346.GR26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140137
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 10:00:09PM -0700, Joel Fernandes wrote:
> On Sun, May 13, 2018 at 07:22:06PM -0700, Paul E. McKenney wrote:
> [..]
> > > > > > > If you don't mind going through the if conditions in the funnel locking loop
> > > > > > > with me, it would be quite helpful so that I don't mess the code up and would
> > > > > > > also help me add tracing correctly.
> > > > > > > 
> > > > > > > The if condition for prestarted is this:
> > > > > > > 
> > > > > > >                if (need_future_gp_element(rnp_root, c) ||
> > > > > > >                    ULONG_CMP_GE(rnp_root->gpnum, c) ||
> > > > > > >                    (rnp != rnp_root &&
> > > > > > >                     rnp_root->gpnum != rnp_root->completed)) {
> > > > > > >                        trace_rcu_this_gp(rnp_root, rdp, c, TPS("Prestarted"));
> > > > > > >                        goto unlock_out;
> > > > > > > 		need_future_gp_element(rnp_root, c) = true;
> > > > > > > 
> > > > > > > As of 16/21, the heart of the loop is the above (excluding the locking bits)
> > > > > > > 
> > > > > > > In this what confuses me is the second and the third condition for
> > > > > > > pre-started.
> > > > > > > 
> > > > > > > The second condition is:  ULONG_CMP_GE(rnp_root->gpnum, c). 
> > > > > > > AIUI the goal of this condition is to check whether the requested grace
> > > > > > > period has already started. I believe then the above check is insufficient. 
> > > > > > > The reason I think its insufficient is I believe we should also check the
> > > > > > > state of the grace period to augment this check.
> > > > > > > IMO the condition should really be:
> > > > > > > (ULONG_CMP_GT(rnp_root->gpnum, c) ||
> > > > > > 
> > > > > > The above asks whether the -next- grace period -after- the requested
> > > > > > one had started.
> > > > > > 
> > > > > > >   (rnp_root->gpnum == c && rnp_root->gpnum != rnp_root->completed))
> > > > > > 
> > > > > > This asks that the requested grace period not have completed.
> > > > > > 
> > > > > > What about the case where the requested grace period has completed,
> > > > > > but the one after has not yet started?  If you add that in, I bet you
> > > > > > will have something that simplifies to my original.
> > > > > > 
> > > > > > > In a later patch you replaced this with rseq_done(&rnp_root->gp_seq, c) which
> > > > > > > kind of accounts for the state, except that rseq_done uses ULONG_CMP_GE,
> > > > > > > whereas to fix this, rseq_done IMO should be using ULONG_CMP_GT to be equivalent
> > > > > > > to the above check. Do you agree?
> > > > > > 
> > > > > > I do not believe that I do.  The ULONG_CMP_GE() allows for the missing case
> > > > > > where the requested grace period completed, but the following grace period
> > > > > > has not yet started.
> > > > > 
> > > > > Ok thanks that clears it up. For some reason I was thinking if
> > > > > rnp_root->gpnum == c, that could means 'c' has not yet started, unless we
> > > > > also checked the state. Obviously, now I realize gpnum == c can only mean 2
> > > > > things:
> > > > >  - c has started but not yet completed
> > > > >  - c has completed
> > > > > 
> > > > > Both of these cases should cause a bail out so I agree now with your
> > > > > condition ULONG_CMP_GE, thanks.
> > > > > 
> > > > > > 
> > > > > > > The third condition for pre-started is:
> > > > > > >                    (rnp != rnp_root && rnp_root->gpnum != rnp_root->completed))
> > > > > > > This as I followed from your commit message is if an intermediate node thinks
> > > > > > > RCU is non-idle, then its not necessary to mark the tree and we can bail out
> > > > > > > since the clean up will scan the whole tree anyway. That makes sense to me
> > > > > > > but I think I will like to squash the diff in your previous email into this
> > > > > > > condition as well to handle both conditions together.
> > > > > > 
> > > > > > Please keep in mind that it is necessary to actually record the request
> > > > > > in the leaf case.  Or are you advocating use of ?: or similar to make this
> > > > > > happen?
> > > > > 
> > > > > Yes, I realized yesterday you wanted to record it for the leaf that's why
> > > > > you're doing things this way. I'll let you know if I find any other ways of
> > > > > simplifying it once I look at your latest tree.
> > > > > 
> > > > > Btw, I checked your git tree and couldn't see the update that you mentioned
> > > > > you queued above. Could you push those changes?
> > > > 
> > > > Good point, pushed now.  And the patch that I forgot to include in the
> > > > last email is below.
> > > 
> > > Cool, thanks. Also one thing I wanted to discuss, I am a bit unclear about
> > > the if (rcu_seq_done..) condition in the loop which decides if the GP
> > > requested is pre-started.
> > 
> > Actually, rcu_seq_done() instead determines whether or not the GP has
> > -completed-.
> > 
> > > Say c is 8 (0b1000) - i.e. gp requested is 2.
> > > I drew some tables with some examples, the result column is what the
> > > current code will do.
> > > 
> > > Say gp_seq is 12 and its not progress (0b1100),
> > > 
> > > gp_seq	gp_num	state	analysis of gp_seq  result
> > > 12		3	0	gp 3 not started    pre-started
> > > 				(gp 2 completed)
> > > 
> > > For this, the "greater than" check in rcu_seq_done will work because 2 already
> > > completed (The check essentially does 12 >= 8 which implies prestarted).
> > 
> > Agreed.
> > 
> > > Say gp_seq is 9 and it is in progress (0b1001)
> > > gp_seq	gp_num	state	state of gp_seq    result
> > > 9		2	1	gp 2 in progress   pre-started
> > > 				(gp 1 completed)
> > > 
> > > Here also the "greater than" check is correct (9 >= 8 which implies prestarted).
> > 
> > Yes, ->gp_seq of 9 implies that _snap() of 8 is done and gone.
> 
> According to the above table, I was trying to indicate that gp_seq = 9
> implies, gp_num of 2 is in progress, not done. So in my view, whatever the
> _snap returned is in progress now (state bit is set).

Yes, ->gp_seq of 9 implies that a grace period is in progress.  But given
that rcu_seq_snap() returned 8 some time in the past, the required grace
period has in fact completed.  Similarly, a ->gp_seq of 3248324301 would
also indicate a grace period in progress, but would still indicate that
the grace period indicated by a return value of 8 from rcu_seq_snap()
had already completed.

> > > However, say gp_seq is 8
> > > gp_seq	gp_num	state	state of gp_seq    result
> > > 8		2	0	gp 2 not started   pre-started
> > > 				(gp 1 completed)
> > > 
> > > In this case, rcu_seq_done will incorrectly say that its pre-started when 2
> > > has not yet started. For this reason, I feel the equal-to check in
> > > rcu_seq_done will incorrectly predict prestarted.
> > 
> > If _snap() said 8, then it meant that when ->gp_seq reached 8, the needed
> > grace periods had elapsed.  So ULONG_CMP_GE() really is what we want.
> 
> I kind of don't agree still according to the below (but I'm pretty sure I'm
> missing something so I probably need to go through some more examples, do
> some more tracing etc.)
> 
> Forgetting about _snap for a second, can we not look at gp_seq independently
> and determine what the grace period is currently doing? In my view, if gp_seq
> reaches 8 (gp_num is 2) - that means that gp_num of 1 was just done.  It
> doesn't mean 2 completed.. 2 could have either started or not yet started, we
> can't tell without look at the state bits... this is the part I didn't get.
> 
> rcu_seq_start only sets the state bit. rcu_seq_end increments the gp_num
> value.
> 
> I thought when rcu_seq_end sets the value part of gp_seq to gp_num, I thought
> that means that gp_num - 1 just completed. Is that not true?

If we are comparing a ->gp_seq value to a return value from rcu_seq_snap(),
it does not make much sense to forget about rcu_seq_snap().  But let me
suspend disbelief and instead tell you how I think about the ->gp_seq
values.

A value of 8 says that grace period #2 has not yet started.  It also says
that grace period #1 has completed.  In addition, it says that any grace
period whose number is larger than 2 has not yet started, and further that
any grace period whose number is smaller than 1 has already completed.
Given a modular definition accounting for wrap, of course -- which is
why ->gpwrap should be consulted when looking at rdp->gp_seq.

A value of 9 says that grace period #2 has started, but it also implies
that #1 and earlier have completed (as with 8) and that #3 and later
have not yet started.

So rcu_seq_snap() is given a value of ->gp_seq, and must return a later
value that will indicate that a full grace period has passed.  We can
make a table:

	->gp_seq	rcu_seq_snap() return value
	0		 4
	1		 8
	4		 8
	5		12
	8		12

And so on.  The point of returning 4 when ->gp_seq is zero has nothing
to do with grace period #1 having completed and everything to do with
grace period #0 having completed.

The values 2 and 3 cannot happen for RCU, though the value of 2 can happen
for SRCU.  So SRCU is why we have two state bits rather than just one.


As you say, rcu_seq_start() just increments.  It also verifies that
the state bits of the result are exactly 1, which means that it will
complain if invoked with non-zero state bits.

Then rcu_seq_end() rounds up to the next grace period, but with the
state bits all zero, indicating that this grace period has not yet
started.

All of this allows rcu_seq_done() to simply do a modular comparison
of the snapshot from rcu_seq_snap() to the current ->gp_seq.

Make sense?

> > > I think to fix this, the rseq_done condition could be replaced with:
> > > 	if (ULONG_CMP_GT(rnp_root->gpseq, c)) {
> > > 		// pre-started
> > > 	}
> > > 
> > > I believe the difference arises because one of the patches during the
> > > conversion to use gp_seq in the tree replaced rcu_seq_done with ULONG_CMP_GE,
> > > where as such a replacement doesn't work in the gp_seq regime because of
> > > difference in the way a gp's starte/end is accounted (vs the old way).
> > > 
> > > Does it make sense or was I way off about something :D ?
> > 
> > I believe that you need to start with where the value passed via "c"
> > to rcu_start_this_gp() came from.  I suggest starting with the call
> > from the rcu_seq_snap() in rcu_nocb_wait_gp(), whose return value is
> > then passed to rcu_start_this_gp(), the reason being that it doesn't
> > drag you through the callback lists.
> 
> Ok I'll try to do some more tracing / analysis and think some more following
> your suggestions about starting from rcu_nocb_wait_gp. Most likely I am
> wrong, but I am yet to convince myself about it :-(

But of course!

							Thanx, Paul

> thanks so much!
> 
> - Joel
> 
