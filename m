Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeEVAHh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:07:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34369 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbeEVAHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:07:35 -0400
X-Google-Smtp-Source: AB8JxZpVwNWmptsgmPr5zntzyPoU2qC4pz+VKWs5cHT69hKIXJf7bhsXpjcK1Mxwn4mPmVs9NTCnMA==
Date: Mon, 21 May 2018 17:07:34 -0700
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
Message-ID: <20180522000734.GD40541@joelaf.mtv.corp.google.com>
References: <20180521044220.123933-1-joel@joelfernandes.org>
 <20180521044220.123933-5-joel@joelfernandes.org>
 <20180521232537.GJ3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521232537.GJ3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 04:25:38PM -0700, Paul E. McKenney wrote:
> On Sun, May 20, 2018 at 09:42:20PM -0700, Joel Fernandes wrote:
> > We acquire gp_seq_needed locklessly. To be safe, lets do the unlocking
> > after the access.
> 
> Actually, no, we hold rnp_start's ->lock throughout.  And this CPU (or in
> the case of no-CBs CPUs, this task) is in charge of rdp->gp_seq_needed,
> so nothing else is accessing it.  Or at least that is the intent.  ;-)

I was talking about protecting the internal node's rnp->gp_seq_needed, not
the rnp_start's gp_seq_needed.

We are protecting them in the loop:

like this:
for(...)
	if (rnp != rnp_start)
		raw_spin_lock_rcu_node(rnp);
	[...]
	// access rnp->gp_seq and rnp->gp_seq_needed
	[...]
	if (rnp != rnp_start)
		raw_spin_unlock_rcu_node(rnp);

But we don't need to do such protection in unlock_out ? I'm sorry if I'm
missing something, but I'm wondering if rnp->gp_seq_needed of an internal
node can be accessed locklessly, then why can't that be done also in the
funnel locking loop - after all we are holding the rnp_start's lock through
out right?

thanks!

 - Joel
 
