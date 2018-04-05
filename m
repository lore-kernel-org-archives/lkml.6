Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeDEHcQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:32:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEHcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:32:15 -0400
Date: Thu, 5 Apr 2018 09:32:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, parri.andrea@gmail.com,
        will.deacon@arm.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com,
        linux-kernel@vger.kernel.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Pasha Tatashin <pasha.tatashin@oracle.com>
Subject: Re: Control dependency between prior load in while condition and
 later store?
Message-ID: <20180405073204.GP4043@hirez.programming.kicks-ass.net>
References: <087a5ca4-e788-60ee-9145-3a078781cf05@oracle.com>
 <Pine.LNX.4.44L0.1804041623530.1401-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1804041623530.1401-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 04:35:32PM -0400, Alan Stern wrote:
> On Wed, 4 Apr 2018, Daniel Jordan wrote:
> 
> > A question for memory-barriers.txt aficionados.
> > 
> > Is there a control dependency between the prior load of 'a' and the 
> > later store of 'c'?:
> > 
> >    while (READ_ONCE(a));
> >    WRITE_ONCE(c, 1);
> 
> I would say that yes, there is.

Indeed.

> Yes, except that a more accurate view of the object code would be
> something like this:
> 
> Loop:	r1 = READ_ONCE(a);
> 	if (r1)
> 		goto Loop;
> 	else
> 		;	// Do nothing
> 	WRITE_ONCE(c, 1);
> 
> Here you can see that one path branches backward, so everything 
> following the "if" is dependent on the READ_ONCE.

Agreed, and I think I even have code that relies on such a pattern
somewhere.. Ah.. yes, see smp_cond_load_acquire().
