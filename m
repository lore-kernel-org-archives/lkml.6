Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC20C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16886216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16886216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeJUEaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 00:30:15 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51441 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725746AbeJUEaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 00:30:15 -0400
Received: (qmail 29885 invoked by uid 500); 20 Oct 2018 16:18:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Oct 2018 16:18:37 -0400
Date:   Sat, 20 Oct 2018 16:18:37 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     linux-kernel@vger.kernel.org, <linux-arch@vger.kernel.org>,
        <davidtgoldblatt@gmail.com>, <andrea.parri@amarulasolutions.com>,
        <will.deacon@arm.com>, <peterz@infradead.org>,
        <boqun.feng@gmail.com>, <npiggin@gmail.com>, <dhowells@redhat.com>,
        <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>, <akiyks@gmail.com>,
        <dlustig@nvidia.com>
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
In-Reply-To: <20181020161049.GA13756@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1810201612530.28059-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Oct 2018, Paul E. McKenney wrote:

> The second (informal) litmus test has a more interesting Linux-kernel
> counterpart:
> 
> 	void t1_interrupt(void)
> 	{
> 		r0 = READ_ONCE(y);
> 		smp_store_release(&x, 1);
> 	}
> 
> 	void t1(void)
> 	{
> 		smp_store_release(&y, 1);
> 	}
> 
> 	void t2(void)
> 	{
> 		r1 = smp_load_acquire(&x);
> 		r2 = smp_load_acquire(&y);
> 	}
> 
> On store-reordering architectures that implement smp_store_release()
> as a memory-barrier instruction followed by a store, the interrupt could
> arrive betweentimes in t1(), so that there would be no ordering between
> t1_interrupt()'s store to x and t1()'s store to y.  This could (again,
> in paranoid theory) result in the outcome r0==0 && r1==0 && r2==1.

This is disconcerting only if we assume that t1_interrupt() has to be
executed by the same CPU as t1().  If the interrupt could be fielded by
a different CPU then the paranoid outcome is perfectly understandable,
even in an SC context.

So the question really should be limited to situations where a handler 
is forced to execute in the context of a particular thread.  While 
POSIX does allow such restrictions for user programs, I'm not aware of 
any similar mechanism in the kernel.

Alan

