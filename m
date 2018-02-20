Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeBTPLI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:11:08 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:58930 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751973AbeBTPLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:11:07 -0500
Date: Tue, 20 Feb 2018 10:11:06 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>,
        <boqun.feng@gmail.com>, <npiggin@gmail.com>, <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep, smp_read_barrier_depends,
 and lockless_dereference
In-Reply-To: <20180220144939.GG3617@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1802201005590.1428-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018, Paul E. McKenney wrote:

> On Mon, Feb 19, 2018 at 09:28:44PM +0100, Peter Zijlstra wrote:
> > On Mon, Feb 19, 2018 at 11:41:23AM -0800, Paul E. McKenney wrote:
> > > On Mon, Feb 19, 2018 at 12:14:45PM -0500, Alan Stern wrote:
> > > > This leaves us with a question: Do we want to change the kernel by
> > > > adding memory barriers after unsuccessful RMW operations on Alpha, or
> > > > do we want to change the model by excluding such operations from
> > > > address dependencies?
> > > 
> > > I vote for adding the barrier on Alpha.  However, I don't know of any
> > > code in the Linux kernel that relies on read-to-read address dependency
> > > ordering headed by a failing RMW operation, so I don't feel all that
> > > strongly about this.
> > 
> > Right, but not knowing doesn't mean doesn't exist, and most certainly
> > doesn't mean will never exist.
> 
> Fair enough, safety first!
> 
> > > > Note that operations like atomic_add_unless() already include memory 
> > > > barriers.
> > > 
> > > And I don't see an atomic_add_unless_relaxed(), so we are good on this
> > > one.  So far, anyway!  ;-)
> > 
> > Not the point, add_unless() is a conditional operation, and therefore
> > doesn't need to imply anything when failing.
> 
> Plus it doesn't return a pointer, so there is no problem with dereferences.
> Unless someone wants to use its return value as an array index and rely
> on dependency ordering to the array, but I would NAK that use case.

You may not get the chance to NAK it.

We need to be consistent.  Array indexing is indeed a form of address
dependency, so either we assert that the dependency is enforced when
the array index is derived from a failed atomic operation, or else we
assert that failed atomic operations do not create address
dependencies.

Alan
