Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE8BECDFB1
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328C72089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328C72089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbeGNCIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 22:08:41 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35965 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729771AbeGNCIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 22:08:41 -0400
Received: (qmail 27370 invoked by uid 500); 13 Jul 2018 21:51:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Jul 2018 21:51:29 -0400
Date:   Fri, 13 Jul 2018 21:51:29 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
In-Reply-To: <20180713190638.GA4269@andrea>
Message-ID: <Pine.LNX.4.44L0.1807132133330.26947-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018, Andrea Parri wrote:

> On Fri, Jul 13, 2018 at 10:16:48AM -0700, Linus Torvalds wrote:
> > On Fri, Jul 13, 2018 at 2:34 AM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > And, since we're stating preferences, I'll reiterate my preference towards:
> > >
> > >         * RCsc unlock/lock
> > >         * RCpc release/acquire
> > 
> > Yes, I think this would be best. We *used* to have pretty heavy-weight
> > locking rules for various reasons, and we relaxed them for reasons
> > that weren't perhaps always the right ones.
> > 
> > Locking is pretty heavy-weight in general, and meant to be the "I
> > don't really have to think about this very much" option. Then not
> > being serializing enough to confuse people when it allows odd behavior
> > (on _some_ architectures) does not sound like a great idea.
> > 
> > In contrast, when you do release/acquire or any of the other "I know
> > what I'm doing" things, I think we want the minimal serialization
> > implied by the very specialized op.
> 
> The changes under discussion are _not_ affecting uses such as:
> 
>   P0:
>   spin_lock(s);
>   UPDATE data_struct
>   spin_unlock(s);
> 
>   P1:
>   spin_lock(s);
>   UPDATE data_struct
>   spin_unlock(s);
> 
>   [...]
> 
> (most common use case for locking?):  these uses work just _fine_ with 
> the current implementations and in LKMM.
> 
> OTOH, these changes are going to affect uses where threads interact by
> "mixing" locking and _other_ synchronization primitives such as in:
> 
>   { x = 0; y = 0; }
> 
>   P0:
>   spin_lock(s);
>   WRITE_ONCE(x, 1);
>   spin_unlock(s);
> 
>   P1:
>   spin_lock(s);
>   r0 = READ_ONCE(x);
>   WRITE_ONCE(y, 1);
>   spin_unlock(s);
> 
>   P2:
>   r1 = smp_load_acquire(&y);
>   r2 = READ_ONCE(x);
> 
>   BUG_ON(r0 == 1 && r1 == 1 && r2 == 0)
> 
> and
> 
>   { x = 0; y = 0; z = 0; }
> 
>   P0:
>   spin_lock(s);
>   WRITE_ONCE(x, 1);
>   r0 = READ_ONCE(y);
>   spin_unlock(s);
> 
>   P1:
>   spin_lock(s);
>   WRITE_ONCE(y, 1);
>   r1 = READ_ONCE(z);
>   spin_unlock(s);
> 
>   P2
>   WRITE_ONCE(z, 1);
>   smp_mb();
>   r2 = READ_ONCE(x);
> 
>   BUG_ON(r0 == 0 && r1 == 0 && r2 == 0)
> 
> (inspired from __two__ uses in kernel/{sched,rcu}).  Even if someone were
> to tell me that locks serialize enough, I'd still be prompted to say "yes,
> but do / can my BUG_ON()s fire?".

The point being that the scenarios under discussion in this thread all 
fall most definitely into the "Non-standard usage; you'd better know 
exactly what you're doing" category.

Which suggests, by Linus's reasoning, that locking should be as
lightweight as possible while still being able to perform its basic job
of defining critical sections.  In other words, RCpc.

And which would still leave smp_mb__after_unlock_lock available for
more esoteric usages.  Although it provides RCsc ordering, I assume the
overhead wouldn't be prohibitive in situations where only RCtso
ordering is needed.

Alan

> Actually, my very first reaction, before starting what does appear to be
> indeed a long and complex conversation, would probably be to run/check the
> above snippets against the (latest) LKMM, by using the associated tool.
> 
> Once "checked" with both people and automated models, I'd probably remain
> suspicious about my "magic" code so that I most likely will be prompted to
> dig into each single arch. implementation / reference manual...
> 
> ... Time's up!
> 
>   Andrea


