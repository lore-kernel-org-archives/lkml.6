Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67784C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A9720859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfAQUVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:21:18 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55876 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729150AbfAQUVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:21:18 -0500
Received: (qmail 2671 invoked by uid 2102); 17 Jan 2019 15:21:17 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jan 2019 15:21:17 -0500
Date:   Thu, 17 Jan 2019 15:21:17 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
In-Reply-To: <20190117150336.GA10381@andrea>
Message-ID: <Pine.LNX.4.44L0.1901171444230.1207-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019, Andrea Parri wrote:

> > > 		There is a special case (data;rfi) that doesn't
> > > 		provide ordering in itself but can contribute to other
> > > 		orderings.  A data;rfi link corresponds to situations
> > > 		where a value is stored in a temporary shared variable
> > > 		and then loaded back again.  Since the compiler might
> > > 		choose to eliminate the temporary, its accesses can't
> > > 		be said to be ordered -- but the accesses around it
> > > 		might be.  As a simple example, consider:
> > > 
> > > 			r1 = READ_ONCE(ptr);
> > > 			tmp = r1;
> > > 			r2 = tmp;
> > > 			WRITE_ONCE(*r2, 5);
> > > 
> > > 		The plain accesses involving tmp don't have any
> > > 		particular ordering requirements, but we do know that
> > > 		the READ_ONCE must be ordered before the WRITE_ONCE.
> > > 		The chain of relations is:
> > > 
> > > 			[marked] ; data ; rfi ; addr ; [marked]
> > > 
> > > 		showing that a data;rfi has been inserted into an
> > > 		address dependency from a marked read to a marked
> > > 		write.  In general, any number of data;rfi links can
> > > 		be inserted in each of the other kinds of dependencies.
> 
> As a more general comment (disclaimer), I'm not sure we want to/can add
> all the constraints above.  On one hand, for some of them, I ignore the
> existence of current use cases in the source (and I don't quite see my-
> self encouraging their adoption...); on the other hand, these certainly
> do not make the model "simpler" or easier to maintain (in a sound way).
> 
> Moreover, I doubt that runtime checkers a la KTSan will ever be able to
> assist the developer by supporting these "dependency orderings". [1]
> 
> Maybe we could start by adding those orderings that we know are "widely"
> relied upon _and_ used by the developers, and later add more/strengthen
> the model as needed (where feasible).
> 
> Thoughts?

Right now I'm inclined to give up on all dependency orderings other
than address dependency from a marked read.  But this would mean
missing things like

	MR ->addr PR ->data MW

which ought to be a valid ordering (MR stands for "marked read", "PR"
for "plain read", and "MW" for "marked write").  Is that going to be 
okay?  Or should I also include data and control dependencies from 
plain reads to marked writes?

Also, should this still include "[marked] ; (data ; rfi)* ; addr"?  
Without it, we wouldn't be able to tell that the following test does
not race:


C non-race4

{
int *x = a;
}

P0(int **x, int *b)
{
	*b = 1;
	smp_wmb();
	rcu_assign_pointer(*x, b);
}

P1(int **x, int **tmp)
{
	int *r1;
	int *r2;
	int r3;

	r1 = rcu_dereference(*x);
	tmp = r1;
	r2 = tmp;
	r3 = *r2;
}

exists (1:r1=b /\ 1:r3=0)


And it seems reasonable that this pattern could be used in the kernel.  
Although, I admit, in this scenario it's much more likely that tmp
would be a non-shared variable.

Alan

