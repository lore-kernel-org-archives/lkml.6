Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38242C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1076520883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfARPKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:10:24 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44058 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727608AbfARPKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:10:23 -0500
Received: (qmail 2300 invoked by uid 2102); 18 Jan 2019 10:10:22 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jan 2019 10:10:22 -0500
Date:   Fri, 18 Jan 2019 10:10:22 -0500 (EST)
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
Message-ID: <Pine.LNX.4.44L0.1901181005110.1425-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019, Andrea Parri wrote:

> > Can the compiler (maybe, it does?) transform, at the C or at the "asm"
> > level, LB1's P0 in LB2's P0 (LB1 and LB2 are reported below)?
> > 
> > C LB1
> > 
> > {
> > 	int *x = &a;
> > }
> > 
> > P0(int **x, int *y)
> > {
> > 	int *r0;
> > 
> > 	r0 = rcu_dereference(*x);
> > 	*r0 = 0;
> > 	smp_wmb();
> > 	WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int **x, int *y, int *b)
> > {
> > 	int r0;
> > 
> > 	r0 = READ_ONCE(*y);
> > 	rcu_assign_pointer(*x, b);
> > }
> > 
> > exists (0:r0=b /\ 1:r0=1)
> > 
> > 
> > C LB2
> > 
> > {
> > 	int *x = &a;
> > }
> > 
> > P0(int **x, int *y)
> > {
> > 	int *r0;
> > 
> > 	r0 = rcu_dereference(*x);
> > 	if (*r0)
> > 		*r0 = 0;
> > 	smp_wmb();
> > 	WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int **x, int *y, int *b)
> > {
> > 	int r0;
> > 
> > 	r0 = READ_ONCE(*y);
> > 	rcu_assign_pointer(*x, b);
> > }
> > 
> > exists (0:r0=b /\ 1:r0=1)
> > 
> > LB1 and LB2 are data-race free, according to the patch; LB1's "exists"
> > clause is not satisfiable, while LB2's "exists" clause is satisfiable.

A relatively simple solution to this problem would be to say that 
smp_wmb doesn't order plain writes.

I think the rest of the memory model would then be okay.  However, I am
open to arguments that this approach is too complex and we should
insist on the same kind of strict ordering for race avoidance that the
C11 standard uses (i.e., conflicting accesses separated by full memory
barriers or release & acquire barriers or locking).

Alan

