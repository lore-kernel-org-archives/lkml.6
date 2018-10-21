Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03925ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DDC20878
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DDC20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeJUXHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 19:07:17 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40111 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727336AbeJUXHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 19:07:17 -0400
Received: (qmail 23920 invoked by uid 500); 21 Oct 2018 10:52:41 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Oct 2018 10:52:41 -0400
Date:   Sun, 21 Oct 2018 10:52:41 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <davidtgoldblatt@gmail.com>, <will.deacon@arm.com>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <akiyks@gmail.com>, <dlustig@nvidia.com>
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
In-Reply-To: <20181020210646.GC2674@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1810211043160.23485-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Oct 2018, Paul E. McKenney wrote:

> On Sat, Oct 20, 2018 at 10:22:29PM +0200, Andrea Parri wrote:
> > [...]
> > 
> > > The second (informal) litmus test has a more interesting Linux-kernel
> > > counterpart:
> > > 
> > > 	void t1_interrupt(void)
> > > 	{
> > > 		r0 = READ_ONCE(y);
> > > 		smp_store_release(&x, 1);
> > > 	}
> > > 
> > > 	void t1(void)
> > > 	{
> > > 		smp_store_release(&y, 1);
> > > 	}
> > > 
> > > 	void t2(void)
> > > 	{
> > > 		r1 = smp_load_acquire(&x);
> > > 		r2 = smp_load_acquire(&y);
> > > 	}
> > > 
> > > On store-reordering architectures that implement smp_store_release()
> > > as a memory-barrier instruction followed by a store, the interrupt could
> > > arrive betweentimes in t1(), so that there would be no ordering between
> > > t1_interrupt()'s store to x and t1()'s store to y.  This could (again,
> > > in paranoid theory) result in the outcome r0==0 && r1==0 && r2==1.
> > 
> > FWIW, I'd rather call "paranoid" the act of excluding such outcome ;-)
> > but I admit that I've only run this test in *my mind*: in an SC world,
> > 
> >   CPU1				CPU2
> > 
> >   t1()
> >     t1_interrupt()
> >       r0 = READ_ONCE(y); // =0
> > 				t2()
> > 				  r1 = smp_load_acquire(&x); // =0
> >       smp_store_release(&x, 1);
> >     smp_store_release(&y, 1);
> > 				  r2 = smp_load_acquire(&y); // =1
> 
> OK, so did I get the outcome messed up again?  :-/

Did you mean to say r0==1?  If so, the litmus test would be a little
clearer if you wrote t1() above t1_interrupt().  That would help to
cement the WRC pattern in the reader's mind.

In any case, perhaps this indicates the kernel should ensure that a
full memory barrier is executed when an interrupt occurs.  (Of course, 
the hardware may already do this for us, depending on the 
architecture.)

Alan

