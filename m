Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB66ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4096B20673
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4096B20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeGQUL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:11:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:45946 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729704AbeGQUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:11:56 -0400
Received: (qmail 3318 invoked by uid 2102); 17 Jul 2018 15:37:50 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jul 2018 15:37:50 -0400
Date:   Tue, 17 Jul 2018 15:37:50 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <CA+55aFwA=TmJJkKvskX3wL9Rs1j8xZJDJVghv=G0spYufK9kYg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1807171528530.1344-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, Linus Torvalds wrote:

> On Tue, Jul 17, 2018 at 11:31 AM Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > The isync provides ordering roughly similar to lwsync, but nowhere near
> > as strong as sync, and it is sync that would be needed to cause lock
> > acquisition to provide full ordering.
> 
> That's only true when looking at isync in isolation.
> 
> Read the part I quoted. The AIX documentation implies that the
> *sequence* of load-compare-conditional branch-isync is a memory
> barrier, even if isync on its own is now.

I'm not a huge expert on the PowerPC architecture, but I do have a
pretty good understanding of the widely accepted memory model published
by the Peter Sewell's group at Cambridge (PPCMEM).  According to that
model, load-compare-conditional branch-isync is _not_ a full memory
barrier.

> So I'm just saying that
> 
>  (a) isync-on-lock is supposed to be much cheaper than sync-on-lock
> 
>  (b) the AIX documentation at least implies that isync-on-lock (when
> used together the the whole locking sequence) is actually a memory
> barrier
> 
> Now, admittedly the powerpc barrier instructions are unfathomable
> crazy stuff, so who knows. But:
> 
>  (a) lwsync is a memory barrier for all the "easy" cases (ie
> load->store, load->load, and store->load).
> 
>  (b) lwsync is *not* a memory barrier for the store->load case.
> 
>  (c) isync *is* (when in that *sequence*) a memory barrier for a
> store->load case (and has to be: loads inside a spinlocked region MUST
> NOT be done earlier than stores outside of it!).

Why not?  Instructions are allowed to migrate _into_ critical sections,
just not _out_ of them.  So a store preceding the start of a spinlocked
region can migrate in and be executed after a load that is inside the
region.

Alan Stern

> So a unlock/lock sequence where the unlock is using lwsync, and the
> lock is using isync, should in fact be a full memory barrier (which is
> the semantics we're looking for).
> 
> So doing performance testing on sync/lwsync (for lock/unlock
> respectively) seems the wrong thing to do.  Please test the
> isync/lwsync case instead.
> 
> Hmm? What am I missing?

