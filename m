Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D270EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5AE204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfAOPTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:19:12 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:43856 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730723AbfAOPTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:19:11 -0500
Received: (qmail 2506 invoked by uid 2102); 15 Jan 2019 10:19:10 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jan 2019 10:19:10 -0500
Date:   Tue, 15 Jan 2019 10:19:10 -0500 (EST)
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
        <linux-kernel@vger.kernel.org>
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
In-Reply-To: <20190115142545.GA9255@andrea>
Message-ID: <Pine.LNX.4.44L0.1901151003470.1408-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019, Andrea Parri wrote:

> Unless I'm mis-reading/-applying this definition, this will flag the
> following test (a variation on your "race.litmus") with "data-race":
> 
> C no-race
> 
> {}
> 
> P0(int *x, spinlock_t *s)
> {
> 	spin_lock(s);
>         WRITE_ONCE(*x, 1);	/* A */
> 	spin_unlock(s);	/* B */
> }
> 
> P1(int *x, spinlock_t *s)
> {
>         int r1;
> 
> 	spin_lock(s); /* C */
>         r1 = *x;	/* D */
> 	spin_unlock(s);
> }
> 
> exists (1:r1=1)
> 
> Broadly speaking, this is due to the fact that the modified "happens-
> before" axiom does not forbid the execution with the (MP-) cycle
> 
> 	A ->po-rel B ->rfe C ->acq-po D ->fre A
> 
> and then to the link "D ->race-from-r A" here defined.

Yes, that cycle certainly should be forbidden.  On the other hand, we
don't want to insist that C happens before D, given that D may not
happen at all.

This is a real problem.  Can we solve it by adding a modified
"happens-before" which says essentially that _if_ D is preserved _then_
C happens before D?  But then what about cycles involving more than one
possibly preserved access?  Or maybe a relation which says that D
cannot execute before C (so if D executes at all, it has to come after
C)?

Now you see why this stuff is so difficult...  At the moment, I don't
know how to fix this.

> (In part., similar considerations hold for the following litmus test:
> 
> C MP1
> 
> {}
> 
> P0(int *x, int *y)
> {
> 	*x = 1;
> 	smp_store_release(y, 1);
> }
> 
> P1(int *x, int *y)
> {
> 	int r0;
> 	int r1 = -1;
> 
> 	r0 = smp_load_acquire(y);
> 	if (r0)
> 		r1 = *x;
> }
> 
> exists (1:r0=1 /\ 1:r1=0)
> 
> )
> 
> I wonder whether you actually intended to introduce these "races"...?

No, I did not.

Alan

