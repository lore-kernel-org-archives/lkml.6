Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeEWIUG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:20:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33444 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754153AbeEWIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:20:01 -0400
Date: Wed, 23 May 2018 10:19:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: psodagud@codeaurora.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Eric Biggers <ebiggers@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, sherryy@android.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: write_lock_irq(&tasklist_lock)
Message-ID: <20180523081934.GT12217@hirez.programming.kicks-ass.net>
References: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
 <CA+55aFyGHhPvbqGaA0+tx7fbH+Uc6sbGKk2PLoFYCt-agCOgOw@mail.gmail.com>
 <20180522211724.GR12217@hirez.programming.kicks-ass.net>
 <CA+55aFySqSVh+WsAbpYQcE4r87z7BXm1wuZpobYxVjVWsWULsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFySqSVh+WsAbpYQcE4r87z7BXm1wuZpobYxVjVWsWULsQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 02:31:42PM -0700, Linus Torvalds wrote:
> On Tue, May 22, 2018 at 2:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > qrwlock is a fair lock and should not exhibit writer starvation.
> 
> We actually have a special rule to make it *not* be fair, in that
> interrupts are allowed to take the read lock if there are readers - even if
> there are waiting writers.

Urgh, right.. would be interesting to know how much of that is happening
in that workload. I assumed the readers were mostly due to the syscalls
the reporter talked about, and those should not trigger that case.

> > You basically want to spin-wait with interrupts enabled, right?
> 
> That was the intent of my (untested) pseudo-code. It should work fine. Note
> that I used write_trylock() only, so there is no queueing (which also
> implies no fairness).
> 
> I'm not saying it's a _good_ idea.  I'm saying it might work if all you
> worry about is the irq-disabled part.

Right, if you make it unfair and utterly prone to starvation then yes,
you can make it 'work'.
