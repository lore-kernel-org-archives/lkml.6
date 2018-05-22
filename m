Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeEVVb5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:31:57 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55187 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbeEVVby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:31:54 -0400
X-Google-Smtp-Source: AB8JxZqf9k01onlPJsi69DMwjcanaj7j69vcut65BaE77dulhRHbL0ZpE2nFZmacjT8MGJC51cMCqTy0/i72C3wa8yo=
MIME-Version: 1.0
References: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
 <CA+55aFyGHhPvbqGaA0+tx7fbH+Uc6sbGKk2PLoFYCt-agCOgOw@mail.gmail.com> <20180522211724.GR12217@hirez.programming.kicks-ass.net>
In-Reply-To: <20180522211724.GR12217@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 22 May 2018 14:31:42 -0700
Message-ID: <CA+55aFySqSVh+WsAbpYQcE4r87z7BXm1wuZpobYxVjVWsWULsQ@mail.gmail.com>
Subject: Re: write_lock_irq(&tasklist_lock)
To: Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 2:17 PM Peter Zijlstra <peterz@infradead.org> wrote:

> qrwlock is a fair lock and should not exhibit writer starvation.

We actually have a special rule to make it *not* be fair, in that
interrupts are allowed to take the read lock if there are readers - even if
there are waiting writers.

I'm not sure how much of an fairness effect this has, but it's required
because of our rule that you can take it for reading without disabling
interrupts.

See

      void queued_read_lock_slowpath(struct qrwlock *lock)

in kernel/locking/qrwlock.c.

> You basically want to spin-wait with interrupts enabled, right?

That was the intent of my (untested) pseudo-code. It should work fine. Note
that I used write_trylock() only, so there is no queueing (which also
implies no fairness).

I'm not saying it's a _good_ idea.  I'm saying it might work if all you
worry about is the irq-disabled part.

                 Linus
