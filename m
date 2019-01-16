Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4276C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714BB206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U51SY9VY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392763AbfAPL6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:58:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389674AbfAPL6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=twvx+i3VJasHKOAlDd6wUICLAgBYIqXBA5mHOf1vCSg=; b=U51SY9VYxd+xmLQIiTp0xP2WB
        0u5dCgBXZ0eB9V7pJ/BByHQrS8mrQ/AREw9Jip5UIEyXvTq6mEAxoVVOBs1WjloP7WOLAgEqfi4V7
        6ID/7+7gRGBAoj8G2F32N4Q214q0fDUnDlqAVbRGG+rGJpD/vMM4DyvuGYwm9mY7zSwSA9q/DBidt
        C7Doy8BaozfvziuwcMvJgTvJYRzKoVf7L3Ktv8a8KeeXJUPWze99eN9aA+VQnQpUBKd/ubas8DtiJ
        J53vDVD/xa4mwM1T/4qrOfjtQpa9zsJPq4dEGaKdaougpJ0vkYoI40iMSgmRDIYst+gzH86esteFo
        vKNp020DA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjjpT-0006lP-53; Wed, 16 Jan 2019 11:57:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5554F20276AAC; Wed, 16 Jan 2019 12:57:52 +0100 (CET)
Date:   Wed, 16 Jan 2019 12:57:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
Message-ID: <20190116115752.GB10803@hirez.programming.kicks-ass.net>
References: <20190115142545.GA9255@andrea>
 <Pine.LNX.4.44L0.1901151003470.1408-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901151003470.1408-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:19:10AM -0500, Alan Stern wrote:
> On Tue, 15 Jan 2019, Andrea Parri wrote:
> 
> > Unless I'm mis-reading/-applying this definition, this will flag the
> > following test (a variation on your "race.litmus") with "data-race":
> > 
> > C no-race
> > 
> > {}
> > 
> > P0(int *x, spinlock_t *s)
> > {
> > 	spin_lock(s);
> >         WRITE_ONCE(*x, 1);	/* A */
> > 	spin_unlock(s);	/* B */
> > }
> > 
> > P1(int *x, spinlock_t *s)
> > {
> >         int r1;
> > 
> > 	spin_lock(s); /* C */
> >         r1 = *x;	/* D */
> > 	spin_unlock(s);
> > }
> > 
> > exists (1:r1=1)
> > 
> > Broadly speaking, this is due to the fact that the modified "happens-
> > before" axiom does not forbid the execution with the (MP-) cycle
> > 
> > 	A ->po-rel B ->rfe C ->acq-po D ->fre A
> > 
> > and then to the link "D ->race-from-r A" here defined.
> 
> Yes, that cycle certainly should be forbidden.  On the other hand, we
> don't want to insist that C happens before D, given that D may not
> happen at all.
> 
> This is a real problem.  Can we solve it by adding a modified
> "happens-before" which says essentially that _if_ D is preserved _then_
> C happens before D?  But then what about cycles involving more than one
> possibly preserved access?  Or maybe a relation which says that D
> cannot execute before C (so if D executes at all, it has to come after
> C)?

The latter; there is a compiler barrier implied at the end of
spin_lock() such that anything later (in PO) must indeed be later.

> Now you see why this stuff is so difficult...  At the moment, I don't
> know how to fix this.
