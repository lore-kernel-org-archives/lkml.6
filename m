Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F54ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CEE20673
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CEE20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbeGQUVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:21:21 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46018 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729720AbeGQUVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:21:21 -0400
Received: (qmail 3380 invoked by uid 2102); 17 Jul 2018 15:47:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jul 2018 15:47:12 -0400
Date:   Tue, 17 Jul 2018 15:47:12 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Peter Zijlstra <peterz@infradead.org>
cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
In-Reply-To: <20180717184255.GM2494@hirez.programming.kicks-ass.net>
Message-ID: <Pine.LNX.4.44L0.1807171542010.1344-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, Peter Zijlstra wrote:

> Isn't ISYNC the instruction-sync pipeline flush instruction? That is
> used as an smp_rmb() here to, together with the control dependency from the
> LL/SC, to form a LOAD->{LOAD,STORE} (aka LOAD-ACQUIRE) ordering?

That's right.

> Where LWSYNC provides a TSO like ordering and SYNC provides a full
> transitive barrier aka. smp_mb() (althgouh I think it is strictly
> stronger than smp_mb() since it also implies completion, which smp_mb()
> does not).

What is the difference?  That is, can you give a litmus test for
"completion" in this sense?

> And since both LL/SC-CTRL + ISYNC / LWSYNC are strictly CPU local, they
> cannot be used to create RCsc ordering.

Yes, sort of -- it depends on whether you consider the store buffer to 
be part of the CPU.  But in any case, you are right that none of these 
things can create RCsc ordering.

Alan

