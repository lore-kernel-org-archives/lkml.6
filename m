Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeBWPWH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:22:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751597AbeBWPWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:22:06 -0500
Date: Fri, 23 Feb 2018 09:22:04 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] x86/dumpstack: Cleanups and user opcode bytes Code:
 section
Message-ID: <20180223152204.434g7mrvi6hjmmka@treble>
References: <20180219202826.19797-1-bp@alien8.de>
 <CALCETrXgT0rLLziiOnv51tZioJ2bNKc1eNniu46dDOvW5=PxYQ@mail.gmail.com>
 <20180220192956.si2a6m3ckskexvte@treble>
 <20180220204435.GC24320@pd.tnic>
 <20180221091553.gxnvhbitiewo2mjc@gmail.com>
 <20180221175429.GC9989@pd.tnic>
 <CA+55aFxOcAdN4mnK49F1ObiXoyB2xaREd04JGosgxTd_ufuzpg@mail.gmail.com>
 <20180222092327.GM25201@hirez.programming.kicks-ass.net>
 <CA+55aFxYNT-qPRk82xCApZrkBt6i4m=nOAfxmaLW-O6wgq1LTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxYNT-qPRk82xCApZrkBt6i4m=nOAfxmaLW-O6wgq1LTA@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 10:42:52AM -0800, Linus Torvalds wrote:
> So what we could perhaps do is:
> 
>  - make console_verbose() actually reset things to at least LOGLEVEL_DEBUG
> 
>  - make sure the *default* loglevel  be LOGLEVEL_WARNING
> 
>  - now you can use pr_debug() in the oops code to print messages to
> the log, but they won't be printed to the screen.
> 
> And people who really want everything can still set a loglevel that is
> much higher, because "console_verbose" would only do that "at least"
> thing.
> 
> That would seem like the best of both worlds, no?

Maybe.

Broadly speaking, I think our goal should be, in the worst case, to try
to ensure that the essential data is captured.

But the definitions of "worst case" and "essential data" can vary a lot,
depending on both the user's setup and the nature of the bug.  We're not
going to be able to get it right 100% of the time.

You're assuming the worst case of

  "an 80x25 screen is the only interface to the console".

But there's another worst case of

  "we had unlimited serial port logging, but didn't dump enough data".

With your proposal, the latter might instead become:

  "we had unlimited serial port logging, but didn't dump enough data
   because the default loglevel was too low."

I did a little analysis of panics reported on lkml via .jpg files
(either attached or in a URL).  In the last two years I only found 11
such reports.  (And only two of them were 25x80, the rest were at least
47 rows.)

On the other hand, I found a *ton* of panics which were copy/pasted.  It
was way too many to count, but a rough guess is about one per day.

So ~1.5% of bugs are reported via cell phone camera (with only about
5-10% of *those* on a tiny 25x80 screen, with the rest having at least
47 rows).

It's not very scientific, but it gives a general idea, I think.  The
cell phone camera thing has become a pretty rare way to report bugs, and
with the proliferation of virtualization and automated testing I would
expect that trend to continue.

So my worry with your proposal is that many (or most?) people won't
change their default log level to DEBUG, and then all these nice
additional bits of data we're adding won't ever get printed, making
debug harder for the ~98.5% case of sane serial port logging.

But then again, I don't have any better ideas...

-- 
Josh
