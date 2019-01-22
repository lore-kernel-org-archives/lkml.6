Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7E3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B7920870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfAVQTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:19:14 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:35222 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728669AbfAVQTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:19:14 -0500
Received: (qmail 4260 invoked by uid 2102); 22 Jan 2019 11:19:13 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jan 2019 11:19:13 -0500
Date:   Tue, 22 Jan 2019 11:19:13 -0500 (EST)
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
In-Reply-To: <20190122154745.GA13659@andrea>
Message-ID: <Pine.LNX.4.44L0.1901221114010.1504-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019, Andrea Parri wrote:

> > @@ -131,7 +159,7 @@ let rec rcu-fence = rcu-gp | srcu-gp |
> >  	(rcu-fence ; rcu-link ; rcu-fence)
> >  
> >  (* rb orders instructions just as pb does *)
> > -let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb*
> > +let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb* ; [marked]
> 
> Testing has revealed some subtle semantics changes for some RCU tests
> _without_ unmarked memory accesses; an example is reported at the end
> of this email.  I suspect that the improvements you mentioned in this
> thread can restore the original semantics but I'm reporting this here
> for further reference.
> 
> With the above definition of 'rb', we're losing links which originate
> or target RCU fences, so that this definition is in fact a relaxation
> w.r.t. the current semantics (even when limiting to marked accesses).
> The test below, for example, is currently forbidden by the LKMM, but
> it becomes allowed with this patch.
> 
> FWIW, I checked that including the RCU fences in 'marked' can restore
> the original semantics of these tests; I'm still not sure whether this
> change can make sense though....
> 
> Thoughts?

Ah, a very good discovery.  I think changing marked to ~plain in a few
places would be a better solution.  Or maybe allowing plain accesses in
those places will also be okay -- it's hard to judge at this point.

> Oh, one last (and unrelated) nit before I forget: IIUC, we used to
> upper-case set names, so I'd also suggest s/marked/Marked, s/plain/Plain
> and similarly for the other sets to be introduced.

Okay, I'll follow that convention.

Alan

