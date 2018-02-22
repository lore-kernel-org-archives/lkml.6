Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeBVJXk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:23:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48622 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbeBVJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:23:39 -0500
Date: Thu, 22 Feb 2018 10:23:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] x86/dumpstack: Cleanups and user opcode bytes Code:
 section
Message-ID: <20180222092327.GM25201@hirez.programming.kicks-ass.net>
References: <20180219202826.19797-1-bp@alien8.de>
 <CALCETrXgT0rLLziiOnv51tZioJ2bNKc1eNniu46dDOvW5=PxYQ@mail.gmail.com>
 <20180220192956.si2a6m3ckskexvte@treble>
 <20180220204435.GC24320@pd.tnic>
 <20180221091553.gxnvhbitiewo2mjc@gmail.com>
 <20180221175429.GC9989@pd.tnic>
 <CA+55aFxOcAdN4mnK49F1ObiXoyB2xaREd04JGosgxTd_ufuzpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxOcAdN4mnK49F1ObiXoyB2xaREd04JGosgxTd_ufuzpg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 01:39:52PM -0800, Linus Torvalds wrote:
> showing with a hung kernel. And most of the above is actually
> completely useless. Those are the *usermode* registers it shows, not
> the kernel registers at the time of the crash (the final rip/rsp/code
> lines are for the actual kernel crash, but I'm talking about the
> register dump above it).
> 
> So notice how most of the *useful* data has actually scrolled off the
> screen and is all gone because the machine is hung. Instead, we've
> added stuff that doesn't help at all, usually.
> 
> It's not just that last patch, obviously. The big hunk o fuser
> register dumping is actually from Josh's trace improvements. But the
> above really is a great example of how we have made oopses *harder* to
> read by trying to add more data. They have gotten messier, but they
> have also gotten so verbose that the *good* stuff has all scrolled
> away.
> 
> So I think we should take a hard look at that "more data is better".
> Look at the above 25 lines and tell me - is that actually 25 useful
> lines for debugging a crash in sysrq_handle_crash?

So being one to only use machines that have a serial line this does not
really affect me; but it would appear to me that it might make sense to
try and reverse the entire dump.

That is 'obviously' going to be rather tricky, because we'll have to
print in the direct reverse direction we discover the data and the only
way to do that is with extra buffers, which adds extra complexity to
something we want absolutely robust.

But a simply line based reverse of the output would get us the most
useful data last, just what we want.
