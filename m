Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeEVU1a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:27:30 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:53328 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeEVU13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:27:29 -0400
X-Google-Smtp-Source: AB8JxZrGGTwGvGaLhrBCx8bRtI99AdrwKpV4DKVSt5TTB2wlk2ydUEl7UhAZ+936OUmSVxSPTllTF7HrFe1UX+igb+k=
MIME-Version: 1.0
References: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
In-Reply-To: <0879f797135033e05e8e9166a3c85628@codeaurora.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 22 May 2018 13:27:17 -0700
Message-ID: <CA+55aFyGHhPvbqGaA0+tx7fbH+Uc6sbGKk2PLoFYCt-agCOgOw@mail.gmail.com>
Subject: Re: write_lock_irq(&tasklist_lock)
To: psodagud@codeaurora.org
Cc: Kees Cook <keescook@chromium.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 12:40 PM Sodagudi Prasad <psodagud@codeaurora.org>
wrote:

> Have you observed this type of issues with tasklist_lock ?

tasklist_lock remains pretty painful. It covers too much, but trying to
split it up has never worked well.

It's usually not a huge problem because there are so few writers, but what
you're seeing is the writer starvation issue because readers can be
plentiful.

> Do we need write_lock_irq(&tasklist_lock) in below portion of code ? Can
> I use write_unlock instead of write_lock_irq in portion of code?

You absolutely need write_lock_irq(), because taking the tasklist_lock
without disabling interrupts will deadlock very quickly due to an interrupt
taking the tasklist_lock for reading.

That said, the write_lock_irq(&tasklist_lock) could possibly be replaced
with something like

   static void tasklist_write_lock(void)
   {
         unsigned long flags;
         local_irq_save(flags);
         while (!write_trylock(&tasklist_lock)) {
                 local_irq_restore(flags);
                 do { cpu_relax(); } while (write_islocked(&tasklist_lock));
                 local_irq_disable();
         }
   }

but we don't have that "write_islocked()" function.

So the above would need more work, and is entirely untested anyway,
obviously.

                 Linus
