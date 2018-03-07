Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754350AbeCGKNa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:13:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53306 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbeCGKN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:13:27 -0500
Date: Wed, 7 Mar 2018 11:13:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Message-ID: <20180307101314.GC23662@pd.tnic>
References: <20180306094920.16917-1-bp@alien8.de>
 <20180306094920.16917-6-bp@alien8.de>
 <CA+55aFxwdftN1KcA=Q26oN_GYWyeuyjmMPs-whxZcmz=-ARPFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxwdftN1KcA=Q26oN_GYWyeuyjmMPs-whxZcmz=-ARPFg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 10:47:56AM -0800, Linus Torvalds wrote:
> Are these always serialized? For oopses, I think we end up serializing
> with die_lock, but is that always the case?

Hmm, good question.

> Maybe at least a comment about why a static allocation is ok?

Well, I'm afraid it is not ok but let me show what I'm seeing - maybe
I'm wrong somewhere:

Normally, when something calls die() we do this:

die
|-> oops_begin
|-> arch_spin_lock(&die_lock)		<-- grab die_lock
|-> __die
|-> show_regs
|-> __show_regs
|-> show_iret_regs
|-> show_ip
|-> show_opcodes

and we dump fine here.

But, if, for example, a #PF happens while we die(), we could do this:

do_page_fault
|-> __do_page_fault
|-> bad_area_nosemaphore
|-> __bad_area_nosemaphore
|-> show_signal_msg
|-> show_opcodes

that's the catch-all case in:

        if (unlikely(fault_in_kernel_space(address))) {

and that doesn't sync with the die_lock, AFAICT, and we're walking all
over the opcodes buffer.

Unless I'm missing something, that is.

If I'm not, then I guess I need to think about a better way to solve
this. Because I like the improvement of not having to probe_kernel_read()
byte-by-byte but read it all at once.

And that is fine if I do a 64-byte default, on-stack buffer but that
code_bytes= thing can be 2 pages max which is yuck. No way I'm doing
on-stack buffers then.

Hmm, I need to think about it.

Thanks!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
