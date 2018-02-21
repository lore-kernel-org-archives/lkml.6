Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeBUVjz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:39:55 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:33899 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeBUVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:39:54 -0500
X-Google-Smtp-Source: AH8x226yov9F4vnSrvuB6VfhuEd/ZX14okoaR1RkB+5QS7Gc0/tM/6hRly6twarslXgHMJpYckAc5+cF8mTTq21C71I=
MIME-Version: 1.0
In-Reply-To: <20180221175429.GC9989@pd.tnic>
References: <20180219202826.19797-1-bp@alien8.de> <CALCETrXgT0rLLziiOnv51tZioJ2bNKc1eNniu46dDOvW5=PxYQ@mail.gmail.com>
 <20180220192956.si2a6m3ckskexvte@treble> <20180220204435.GC24320@pd.tnic>
 <20180221091553.gxnvhbitiewo2mjc@gmail.com> <20180221175429.GC9989@pd.tnic>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2018 13:39:52 -0800
X-Google-Sender-Auth: MmP30eyoL4QTN_Wu9FFRetwJKZI
Message-ID: <CA+55aFxOcAdN4mnK49F1ObiXoyB2xaREd04JGosgxTd_ufuzpg@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86/dumpstack: Cleanups and user opcode bytes Code: section
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 9:54 AM, Borislav Petkov <bp@alien8.de> wrote:
>
> Ok, lemme run it by Linus too as he probably stares at this part of the
> output a *lot* :-)

Less than I used to, since there are others who are pretty good at
decoding them, but yes...

> Anyway, here's a 64-bit splat. I'm basically dumping opcode bytes
> everytime we dump RIP.

So I think that's probably a good idea, but the way it ends up being
repeated is really confusing. Particularly when you now do it for the
user code too - which might be occasionally useful, but your example
also shows how there are now _three_ code lines due to the duplication
at the end (for "maybe the first one scrolled off the screen" and the
user code).

And the "executive summary" used to be a dense one-liner (to not
scroll the non-summary away), now it's generally four lines on the
screen (you also made the RIP/RSP be now two lines, and the Code line
is usually two lines because it's so long).

So my gut feel is that yes, this is moving in the right direction, but
I also really think that it now makes the normal oops too big to fit
on a screen.

That matters, because we still end up having the "take a picture of
the oops" issue for hard hangs etc that don't survive in the logs.

Do I know what the right answer is? No. But I suspect at the very
least we would want to get rid of the RSP line from show_ip(), and
make that part of the regular regs. That would make the summary one
line less.

Hmm. The Code: line actually ends up being *three* lines on the
default 80x25 screen, so in your 64-bit example, you actually get
something like this:

     ? preempt_count_sub+0xa8/0x100
     vfs_write+0xc0/0x190
     SyS_write+0x64/0xe0
     ? trace_hardirqs_off_thunk+0x1a/0x1c
     do_syscall_64+0x76/0x140
     entry_SYSCALL_64_after_hwframe+0x42/0xb7
    RIP: 0033:0x7ffff74b9620
    RSP: 002b:00007fffffffe7a8 EFLAGS: 00000246
    Code: ff 73 01 c3 48 8b 0d 68 98 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66
    0f 1f 44 00 00 83 3d bd f1 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d
    01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce 8f 01 00 48 89 04
     ORIG_RAX: 0000000000000001
    RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ffff74b9620
    RDX: 0000000000000002 RSI: 0000000000705408 RDI: 0000000000000001
    RBP: 0000000000705408 R08: 000000000000000a R09: 00007ffff7fdb700
    R10: 00007ffff77826a0 R11: 0000000000000246 R12: 00007ffff77842a0
    R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
    RIP: 0010:sysrq_handle_crash+0x17/0x20
    RSP: 0018:ffffc90000c23df0 EFLAGS: 00010246
    Code: eb d1 e8 fd ca b6 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
    44 00 00 e8 f6 de bc ff c7 05 84 0d 1a 01 01 00 00 00 0f ae f8 <c6> 04
    25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 86 df c1 ff fb 66
    CR2: 0000000000000000
    ---[ end trace e17dc9a4aa5cc4d9 ]---
    Kernel panic - not syncing: Fatal exception

showing with a hung kernel. And most of the above is actually
completely useless. Those are the *usermode* registers it shows, not
the kernel registers at the time of the crash (the final rip/rsp/code
lines are for the actual kernel crash, but I'm talking about the
register dump above it).

So notice how most of the *useful* data has actually scrolled off the
screen and is all gone because the machine is hung. Instead, we've
added stuff that doesn't help at all, usually.

It's not just that last patch, obviously. The big hunk o fuser
register dumping is actually from Josh's trace improvements. But the
above really is a great example of how we have made oopses *harder* to
read by trying to add more data. They have gotten messier, but they
have also gotten so verbose that the *good* stuff has all scrolled
away.

So I think we should take a hard look at that "more data is better".
Look at the above 25 lines and tell me - is that actually 25 useful
lines for debugging a crash in sysrq_handle_crash?

No. The only really _useful_ lines above are

    RIP: 0010:sysrq_handle_crash+0x17/0x20
    RSP: 0018:ffffc90000c23df0 EFLAGS: 00010246
    Code: eb d1 e8 fd ca b6 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
    44 00 00 e8 f6 de bc ff c7 05 84 0d 1a 01 01 00 00 00 0f ae f8 <c6> 04
    25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 86 df c1 ff fb 66
    CR2: 0000000000000000

which are actually about the crash. The rest is almost entirely useless.

Do I know what the corrent answer is? No.

              Linus
