Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933464AbeEWPfo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:35:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57282 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932578AbeEWPfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:35:40 -0400
Date: Wed, 23 May 2018 16:36:07 +0100
From: Will Deacon <will.deacon@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: psodagud@codeaurora.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, sherryy@android.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        boqun.feng@gmail.com
Subject: Re: write_lock_irq(&tasklist_lock)
Message-ID: <20180523153607.GD2983@arm.com>
References: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
 <20180523130547.GF26965@arm.com>
 <CA+55aFwKLBKdf3gdWkJSdewQYYXYYfN29SPT+etPqpopxA0CMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwKLBKdf3gdWkJSdewQYYXYYfN29SPT+etPqpopxA0CMQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Boqun]

On Wed, May 23, 2018 at 08:25:06AM -0700, Linus Torvalds wrote:
> On Wed, May 23, 2018 at 6:05 AM Will Deacon <will.deacon@arm.com> wrote:
> 
> > Please use a newer kernel. We've addressed this in mainline by moving
> > arm64 over to the qrwlock implementation which (after some other changes)
> > guarantees forward progress for well-behaved readers and writers.
> 
> Oh, I didn't even realize that this wasn't x86, and that there was still
> the very unfair rwlock issue on 4.14 on arm.
> 
> Yeah, the queuing rwlocks shouldn't show the really pathological problems
> we used to have long ago.

Yup, although they do reveal new issues that Boqun has been running into
recently with his lockdep improvements. The general pattern is if you
have:

P0:			P1:			P2:

spin_lock(&slock)	read_lock(&rwlock)	write_lock(&rwlock)
read_lock(&rwlock)	spin_lock(&slock)

then the CPUs can be queued on the rwlock such that P1 has the lock, then
P2 is queued and then P0. If P0 has taken the spinlock, we have a deadlock
which wouldn't arise with the non-queued version.

In other words, qrwlock requires consistent locking order wrt spinlocks.

Will
