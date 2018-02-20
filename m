Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeBTPSE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:18:04 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34661 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeBTPSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:18:00 -0500
X-Google-Smtp-Source: AH8x2264gupE+Y+gDWr6lho9pY3WyvhxG7IBaf3QutHRMPw/LGPU2Gh1ReiUCRJDmy+bSPwAaUJo3A==
Date: Tue, 20 Feb 2018 16:17:52 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
Message-ID: <20180220151752.GA1900@andrea>
References: <20180217151413.GA3785@andrea>
 <Pine.LNX.4.44L0.1802191158320.1361-100000@iolanthe.rowland.org>
 <20180219174413.GV25201@hirez.programming.kicks-ass.net>
 <20180220144813.GF3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220144813.GF3617@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 06:48:13AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 19, 2018 at 06:44:13PM +0100, Peter Zijlstra wrote:
> > On Mon, Feb 19, 2018 at 12:14:45PM -0500, Alan Stern wrote:
> > > Note that operations like atomic_add_unless() already include memory 
> > > barriers.
> > 
> > It is valid for atomic_add_unless() to not imply any barriers when the
> > addition doesn't happen.
> 
> Agreed, given that atomic_add_unless() just returns 0 or 1, not the
> pointer being added.  Of course, the __atomic_add_unless() function
> that it calls is another story, as it does return the old value.  Sigh.
> And __atomic_add_unless() is called directly from some code.  All of
> which looks to be counters rather than pointers, thankfully.
> 
> So, do we want to rely on atomic_add_unless() always being
> invoked on counters rather than pointers, or does it need an
> smp_read_barrier_depends()?

alpha's implementation of __atomic_add_unless() has an unconditional smp_mb()
before returning so, as far as dependencies are concerned, these seem fine.

  Andrea


> 
> 							Thanx, Paul
> 
