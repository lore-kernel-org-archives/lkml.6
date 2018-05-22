Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbeEVEn3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 00:43:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33724 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeEVEn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 00:43:28 -0400
X-Google-Smtp-Source: AB8JxZoDsnCrEB6RxR5wTd8E5aYhaF9osAckXAIOAvFg8ogg39UWEumWJjIkWYq889hppOYD30gDvQ==
Date: Mon, 21 May 2018 21:43:27 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 4/4] rcu: Unlock non-start node only after accessing
 its gp_seq_needed
Message-ID: <20180522044327.GF40541@joelaf.mtv.corp.google.com>
References: <20180521044220.123933-1-joel@joelfernandes.org>
 <20180521044220.123933-5-joel@joelfernandes.org>
 <20180521232537.GJ3803@linux.vnet.ibm.com>
 <20180522000734.GD40541@joelaf.mtv.corp.google.com>
 <20180522002823.GP3803@linux.vnet.ibm.com>
 <20180522041651.GA18405@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522041651.GA18405@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 09:16:51PM -0700, Paul E. McKenney wrote:
> On Mon, May 21, 2018 at 05:28:23PM -0700, Paul E. McKenney wrote:
> > On Mon, May 21, 2018 at 05:07:34PM -0700, Joel Fernandes wrote:
> > > On Mon, May 21, 2018 at 04:25:38PM -0700, Paul E. McKenney wrote:
> > > > On Sun, May 20, 2018 at 09:42:20PM -0700, Joel Fernandes wrote:
> > > > > We acquire gp_seq_needed locklessly. To be safe, lets do the unlocking
> > > > > after the access.
> > > > 
> > > > Actually, no, we hold rnp_start's ->lock throughout.  And this CPU (or in
> > > > the case of no-CBs CPUs, this task) is in charge of rdp->gp_seq_needed,
> > > > so nothing else is accessing it.  Or at least that is the intent.  ;-)
> > > 
> > > I was talking about protecting the internal node's rnp->gp_seq_needed, not
> > > the rnp_start's gp_seq_needed.
> > 
> > Ah, good point, I missed the "if" condition.  This can be argued to work,
> > sort of, given that we still hold the leaf rcu_node structure's lock,
> > so that there is a limit to how far grace periods can advance.
> > 
> > But the code would of course be much cleaner with your change.
> > 
> > > We are protecting them in the loop:
> > > 
> > > like this:
> > > for(...)
> > > 	if (rnp != rnp_start)
> > > 		raw_spin_lock_rcu_node(rnp);
> > > 	[...]
> > > 	// access rnp->gp_seq and rnp->gp_seq_needed
> > > 	[...]
> > > 	if (rnp != rnp_start)
> > > 		raw_spin_unlock_rcu_node(rnp);
> > > 
> > > But we don't need to do such protection in unlock_out ? I'm sorry if I'm
> > > missing something, but I'm wondering if rnp->gp_seq_needed of an internal
> > > node can be accessed locklessly, then why can't that be done also in the
> > > funnel locking loop - after all we are holding the rnp_start's lock through
> > > out right?
> > 
> > I was focused on the updates, and missed the rnp->gp_seq_req access in the
> > "if" statement.  The current code does sort of work, but only assuming
> > that the compiler doesn't tear the load, and so your change would help.
> > Could you please resend with your other two updated patches?  It depends
> > on one of the earlier patches, so does not apply cleanly as-is.  I could
> > hand-apply it, but that sounds like a good way to make your updated
> > series fail to apply.  ;-)
> > 
> > But could you also make the commit log explicitly call out the "if"
> > condition as being the offending access?
> 
> Never mind, me being stupid.  I need to apply this change to the original
> commit "rcu: Make rcu_nocb_wait_gp() check if GP already requested", which
> I have done with this attribution:
> 
> [ paulmck: Move lock release past "if" as suggested by Joel Fernandes. ]
> 
> I have rebased my stack on top of the updated commit.

Cool, makes sense. I am assuming this means I don't have to resend this
patch, if I do let me know :)

Either way, once you push your updated tree to kernel.org, I'll double check
to make sure the change is in :)

thanks, good night,

 - Joel
