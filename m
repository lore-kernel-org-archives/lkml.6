Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51380C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E302920883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E302920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388482AbeGKOYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:24:21 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42354 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2387834AbeGKOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:24:20 -0400
Received: (qmail 1695 invoked by uid 2102); 11 Jul 2018 10:19:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jul 2018 10:19:45 -0400
Date:   Wed, 11 Jul 2018 10:19:45 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     Daniel Lustig <dlustig@nvidia.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
In-Reply-To: <20180710233152.GA11825@andrea>
Message-ID: <Pine.LNX.4.44L0.1807111010270.1436-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018, Andrea Parri wrote:

> > > Does something like "po; [UL]; rf; [LKR]; po" fit in with the rest
> > > of the model?  If so, maybe that solves the asymmetry and also
> > > legalizes the approach of putting fence.tso in front?
> > 
> > That would work just as well.  For this version of the patch it 
> > doesn't make any difference, because nothing that comes po-after the 
> > LKR is able to directly read the value stored by the UL.
> 
> Consider:
> 
> C v2-versus-v3
> 
> {}
> 
> P0(spinlock_t *s, int *x)
> {
> 	spin_lock(s);   /* A */
> 	spin_unlock(s);
> 	spin_lock(s);
> 	WRITE_ONCE(*x, 1); /* B */
> 	spin_unlock(s);
> }
> 
> P1(spinlock_t *s, int *x)
> {
> 	int r0;
> 	int r1;
> 
> 	r0 = READ_ONCE(*x); /* C */
> 	smp_rmb();
> 	r1 = spin_is_locked(s); /* D */
> }
> 
> With v3, it's allowed that C reads from B and D reads from (the LKW of) A;
> this is not allowed with v2 (unless I mis-applied/mis-read v2).

Correct.  But it doesn't affect the end result, because both versions
allow C to read from B while D reads from the second spin_lock(), and
there's no way to distinguish that from the case where D reads from A.

If we were talking about arbitrary integers and rmw-acquire updates,
there _would_ be a difference.  But not with spinlocks.

Alan

