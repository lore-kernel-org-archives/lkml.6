Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E8EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A76E20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A76E20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeJ3Vvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:51:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbeJ3Vvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:51:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9UCrgbx117733
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:58:10 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nep1sd107-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:58:10 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 30 Oct 2018 08:58:08 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Oct 2018 08:58:02 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9UCw14i35848362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Oct 2018 12:58:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E605EB2068;
        Tue, 30 Oct 2018 12:58:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9002EB206C;
        Tue, 30 Oct 2018 12:58:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.194.11])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Oct 2018 12:58:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AF65A16C312D; Tue, 30 Oct 2018 05:58:00 -0700 (PDT)
Date:   Tue, 30 Oct 2018 05:58:00 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ran Rozenstein <ranro@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "dipankar@in.ibm.com" <dipankar@in.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Reply-To: paulmck@linux.ibm.com
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-2-paulmck@linux.vnet.ibm.com>
 <AM4PR0501MB27691ECD1B0ECB0531B16F20C5F30@AM4PR0501MB2769.eurprd05.prod.outlook.com>
 <20181029142735.GZ4170@linux.ibm.com>
 <20181030034452.GA224709@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030034452.GA224709@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18103012-2213-0000-0000-0000030D0DC1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009953; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01110138; UDB=6.00575198; IPR=6.00890230;
 MB=3.00023963; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-30 12:58:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103012-2214-0000-0000-00005C131859
Message-Id: <20181030125800.GE4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810300113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 08:44:52PM -0700, Joel Fernandes wrote:
> On Mon, Oct 29, 2018 at 07:27:35AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 29, 2018 at 11:24:42AM +0000, Ran Rozenstein wrote:
> > > Hi Paul and all,
> > > 
> > > > -----Original Message-----
> > > > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > > > owner@vger.kernel.org] On Behalf Of Paul E. McKenney
> > > > Sent: Thursday, August 30, 2018 01:21
> > > > To: linux-kernel@vger.kernel.org
> > > > Cc: mingo@kernel.org; jiangshanlai@gmail.com; dipankar@in.ibm.com;
> > > > akpm@linux-foundation.org; mathieu.desnoyers@efficios.com;
> > > > josh@joshtriplett.org; tglx@linutronix.de; peterz@infradead.org;
> > > > rostedt@goodmis.org; dhowells@redhat.com; edumazet@google.com;
> > > > fweisbec@gmail.com; oleg@redhat.com; joel@joelfernandes.org; Paul E.
> > > > McKenney <paulmck@linux.vnet.ibm.com>
> > > > Subject: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt
> > > > quiescent states when disabled
> > > > 
> > > > This commit defers reporting of RCU-preempt quiescent states at
> > > > rcu_read_unlock_special() time when any of interrupts, softirq, or
> > > > preemption are disabled.  These deferred quiescent states are reported at a
> > > > later RCU_SOFTIRQ, context switch, idle entry, or CPU-hotplug offline
> > > > operation.  Of course, if another RCU read-side critical section has started in
> > > > the meantime, the reporting of the quiescent state will be further deferred.
> > > > 
> > > > This also means that disabling preemption, interrupts, and/or softirqs will act
> > > > as an RCU-preempt read-side critical section.
> > > > This is enforced by checking preempt_count() as needed.
> > > > 
> > > > Some special cases must be handled on an ad-hoc basis, for example,
> > > > context switch is a quiescent state even though both the scheduler and
> > > > do_exit() disable preemption.  In these cases, additional calls to
> > > > rcu_preempt_deferred_qs() override the preemption disabling.  Similar logic
> > > > overrides disabled interrupts in rcu_preempt_check_callbacks() because in
> > > > this case the quiescent state happened just before the corresponding
> > > > scheduling-clock interrupt.
> > > > 
> > > > In theory, this change lifts a long-standing restriction that required that if
> > > > interrupts were disabled across a call to rcu_read_unlock() that the matching
> > > > rcu_read_lock() also be contained within that interrupts-disabled region of
> > > > code.  Because the reporting of the corresponding RCU-preempt quiescent
> > > > state is now deferred until after interrupts have been enabled, it is no longer
> > > > possible for this situation to result in deadlocks involving the scheduler's
> > > > runqueue and priority-inheritance locks.  This may allow some code
> > > > simplification that might reduce interrupt latency a bit.  Unfortunately, in
> > > > practice this would also defer deboosting a low-priority task that had been
> > > > subjected to RCU priority boosting, so real-time-response considerations
> > > > might well force this restriction to remain in place.
> > > > 
> > > > Because RCU-preempt grace periods are now blocked not only by RCU read-
> > > > side critical sections, but also by disabling of interrupts, preemption, and
> > > > softirqs, it will be possible to eliminate RCU-bh and RCU-sched in favor of
> > > > RCU-preempt in CONFIG_PREEMPT=y kernels.  This may require some
> > > > additional plumbing to provide the network denial-of-service guarantees
> > > > that have been traditionally provided by RCU-bh.  Once these are in place,
> > > > CONFIG_PREEMPT=n kernels will be able to fold RCU-bh into RCU-sched.
> > > > This would mean that all kernels would have but one flavor of RCU, which
> > > > would open the door to significant code cleanup.
> > > > 
> > > > Moving to a single flavor of RCU would also have the beneficial effect of
> > > > reducing the NOCB kthreads by at least a factor of two.
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com> [ paulmck:
> > > > Apply rcu_read_unlock_special() preempt_count() feedback
> > > >   from Joel Fernandes. ]
> > > > [ paulmck: Adjust rcu_eqs_enter() call to rcu_preempt_deferred_qs() in
> > > >   response to bug reports from kbuild test robot. ] [ paulmck: Fix bug located
> > > > by kbuild test robot involving recursion
> > > >   via rcu_preempt_deferred_qs(). ]
> > > > ---
> > > >  .../RCU/Design/Requirements/Requirements.html |  50 +++---
> > > >  include/linux/rcutiny.h                       |   5 +
> > > >  kernel/rcu/tree.c                             |   9 ++
> > > >  kernel/rcu/tree.h                             |   3 +
> > > >  kernel/rcu/tree_exp.h                         |  71 +++++++--
> > > >  kernel/rcu/tree_plugin.h                      | 144 +++++++++++++-----
> > > >  6 files changed, 205 insertions(+), 77 deletions(-)
> > > > 
> > > 
> > > We started seeing the trace below in our regression system, after I bisected I found this is the offending commit.
> > > This appears immediately on boot. 
> > > Please let me know if you need any additional details.
> > 
> > Interesting.  Here is the offending function:
> > 
> > 	static void rcu_preempt_deferred_qs(struct task_struct *t)
> > 	{
> > 		unsigned long flags;
> > 		bool couldrecurse = t->rcu_read_lock_nesting >= 0;
> > 
> > 		if (!rcu_preempt_need_deferred_qs(t))
> > 			return;
> > 		if (couldrecurse)
> > 			t->rcu_read_lock_nesting -= INT_MIN;
> > 		local_irq_save(flags);
> > 		rcu_preempt_deferred_qs_irqrestore(t, flags);
> > 		if (couldrecurse)
> > 			t->rcu_read_lock_nesting += INT_MIN;
> > 	}
> > 
> > Using twos-complement arithmetic (which the kernel build gcc arguments
> > enforce, last I checked) this does work.  But as UBSAN says, subtracting
> > INT_MIN is unconditionally undefined behavior according to the C standard.
> > 
> > Good catch!!!
> > 
> > So how do I make the above code not simply function, but rather meet
> > the C standard?
> > 
> > One approach to add INT_MIN going in, then add INT_MAX and then add 1
> > coming out.
> > 
> > Another approach is to sacrifice the INT_MAX value (should be plenty
> > safe), thus subtract INT_MAX going in and add INT_MAX coming out.
> > For consistency, I suppose that I should change the INT_MIN in
> > __rcu_read_unlock() to -INT_MAX.
> > 
> > I could also leave __rcu_read_unlock() alone and XOR the top
> > bit of t->rcu_read_lock_nesting on entry and exit to/from
> > rcu_preempt_deferred_qs().
> > 
> > Sacrificing the INT_MIN value seems most maintainable, as in the following
> > patch.  Thoughts?
> 
> The INT_MAX naming could be very confusing for nesting levels, could we not
> instead just define something like:
> #define RCU_NESTING_MIN (INT_MIN - 1)
> #define RCU_NESTING_MAX (INT_MAX)
> 
> and just use that? also one more comment below:

Hmmm...  There is currently no use for RCU_NESTING_MAX, but if the check
at the end of __rcu_read_unlock() were to be extended to check for
too-deep positive nesting, it would need to check for something like
INT_MAX/2.  You could of course argue that the current check against
INT_MIN/2 should instead be against -INT_MAX/2, but there really isn't
much difference between the two.

Another approach would be to convert to unsigned in order to avoid the
overflow problem completely.

For the moment, anyway, I am inclined to leave it as is.

> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index bd8186d0f4a7..f1b40c6d36e4 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -424,7 +424,7 @@ void __rcu_read_unlock(void)
> >  		--t->rcu_read_lock_nesting;
> >  	} else {
> >  		barrier();  /* critical section before exit code. */
> > -		t->rcu_read_lock_nesting = INT_MIN;
> > +		t->rcu_read_lock_nesting = -INT_MAX;
> >  		barrier();  /* assign before ->rcu_read_unlock_special load */
> >  		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
> >  			rcu_read_unlock_special(t);
> > @@ -617,11 +617,11 @@ static void rcu_preempt_deferred_qs(struct task_struct *t)
> >  	if (!rcu_preempt_need_deferred_qs(t))
> >  		return;
> >  	if (couldrecurse)
> > -		t->rcu_read_lock_nesting -= INT_MIN;
> > +		t->rcu_read_lock_nesting -= INT_MAX;
> 
> Shouldn't this be:  t->rcu_read_lock_nesting -= -INT_MAX; ?

Suppose t->rcu_read_lock_nesting is zero.  Then you change would leave the
value a large positive number (INT_MAX, to be precise), which would then
result in signed integer overflow if there was a nested rcu_read_lock().
Worse yet, if t->rcu_read_lock_nesting is any positive number, subtracting
-INT_MAX would immediately result in signed integer overflow.  Please
note that the whole point of this patch in the first place is to avoid
signed integer overflow.

Note that the check at the beginnning of this function never sets
couldrecurse if ->rcu_read_lock_nesting is negative, which avoids the
possibility of overflow given the current code.  Unless you have two
billion nested rcu_read_lock() calls, in which case you broke it, so
you get to buy it.  ;-)

> >  	local_irq_save(flags);
> >  	rcu_preempt_deferred_qs_irqrestore(t, flags);
> >  	if (couldrecurse)
> > -		t->rcu_read_lock_nesting += INT_MIN;
> > +		t->rcu_read_lock_nesting += INT_MAX;
> 
> And t->rcu_read_lock_nesting += -INT_MAX; ?

And this would have similar problems for ->rcu_read_lock_nesting
not equal to zero on entry to this function.

> But apologies if I missed something, thanks,

No need to apologies, especially if it turns out that I am the one
who is confused.  Either way, thank you for looking this over!

							Thanx, Paul

