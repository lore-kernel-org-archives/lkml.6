Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032685AbeCAPtI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:49:08 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:36020 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1031899AbeCAPtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:49:06 -0500
Date: Thu, 1 Mar 2018 10:49:05 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Boqun Feng <boqun.feng@gmail.com>
cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 v2 RFC] tools/memory-model: redefine rb in terms of
 rcu-fence
In-Reply-To: <20180301015531.olvuu5g35eta5xhr@tardis>
Message-ID: <Pine.LNX.4.44L0.1803011027120.1394-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018, Boqun Feng wrote:

> > +let rec rcu-fence = gp |
> > +	(gp ; rcu-link ; rscs) |
> > +	(rscs ; rcu-link ; gp) |
> > +	(gp ; rcu-link ; rcu-fence ; rcu-link ; rscs) |
> > +	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp) |
> > +	(rcu-fence ; rcu-link ; rcu-fence)
> > +
> > +(* rb orders instructions just as pb does *)
> > +let rb = prop ; rcu-fence ; hb* ; pb*
> >  
> >  irreflexive rb as rcu
> 
> I wonder whether we can simplify things as:
> 
> 	let rec rcu-fence =
> 	    (gp; rcu-link; rscs) |
> 	    (rscs; rcu-link; gp) |
> 	    (gp; rcu-link; rcu-fence; rcu-link; rscs) |
> 	    (rscs; rcu-link; rcu-fence; rcu-link; gp)
> 	
> 	(* gp and rcu-fence; rcu-link; rcu-fence removed *)
> 	
> 	let rb = prop; rcu-fence; hb*; pb*
> 
> 	acycle rb as rcu
> 
> In this way, "rcu-fence" is defined as "any sequence containing as many
> grace periods as RCU read-side critical sections (joined by rcu-link)."
> Note that "rcu-link" contains "gp", so we don't miss the case where
> there are more grace periods. And since we use "acycle" now, so we don't
> need "rcu-fence; rcu-link; rcu-fence" to build "rcu-fence" recursively.

Would this definition of rcu-fence work for a sequence such as (leaving
out the intermediate rcu-link parts):

	gp gp gp rscs rscs gp rscs rscs

?  I don't think it would.  Yes, if you had a cycle of that form then 
your "rcu" axiom would detect it, but at some point we might want to 
use rcu-fence for some other purpose, one that doesn't involve cycles.

> I prefer this because we already treat "gp" as "strong-fence", which
> already is a "rcu-link".

That's a good point; it had not occurred to me.

>  Also, recurisively extending rcu-fence with
> itself is exactly calculating the transitive closure, which we can avoid
> by using a "acycle" rule. Besides, it looks more consistent with hb and
> pb.

That _had_ occurred to me.  But I couldn't see any way to do it while 
still defining rcu-fence correctly.

Alan
