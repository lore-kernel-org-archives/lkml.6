Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeBVSmz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:42:55 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:34564 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeBVSmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:42:54 -0500
X-Google-Smtp-Source: AG47ELuGPtvBNO9tl6gyCCxEOD95Z03XOpNQi2dYw6ch3uhSuErsO7J52SelLYtduOP95uhpkm/nmMeqabMy27VRJYQ=
MIME-Version: 1.0
In-Reply-To: <20180222092327.GM25201@hirez.programming.kicks-ass.net>
References: <20180219202826.19797-1-bp@alien8.de> <CALCETrXgT0rLLziiOnv51tZioJ2bNKc1eNniu46dDOvW5=PxYQ@mail.gmail.com>
 <20180220192956.si2a6m3ckskexvte@treble> <20180220204435.GC24320@pd.tnic>
 <20180221091553.gxnvhbitiewo2mjc@gmail.com> <20180221175429.GC9989@pd.tnic>
 <CA+55aFxOcAdN4mnK49F1ObiXoyB2xaREd04JGosgxTd_ufuzpg@mail.gmail.com> <20180222092327.GM25201@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2018 10:42:52 -0800
X-Google-Sender-Auth: Kcg1VoZ3Ty8aWJtoJmxdlCHVyl4
Message-ID: <CA+55aFxYNT-qPRk82xCApZrkBt6i4m=nOAfxmaLW-O6wgq1LTA@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86/dumpstack: Cleanups and user opcode bytes Code: section
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 1:23 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> So being one to only use machines that have a serial line this does not
> really affect me; but it would appear to me that it might make sense to
> try and reverse the entire dump.

In theory yes. But while you mention the buffering problem, the
*bigger* problem is that sometimes things go south half-way through.
We've definitely had cases where we only get the first few lines of
the oops, because the oops machinery itself has issues (ie takes a
fault in the middle because of random corruption issues or the stack
tracing acting up or whatever).

So while "most important last" is good for it not scrolling off the
screen, it's really bad for the "oops itself has problems" case.

I'd rather people try very hard to make the oops messages dense and
relevant, and not have information that isn't really useful in
practice. We already got rid of the stack content dumping for that
reason - it was useful 20+ years ago, but it had become more of a
detriment than a real help.

So I don't want people to think "this _might_ be useful, let's print
it out". It really should be "this is _critically_ useful, it's worth
printing out even if we're limited to a 80x25 screen".

Honestly, I think one option is to just mark parts for "printing" and
other parts for "logging". I think we may raise the loglevel a bit
_too_ much when an oops happens in "console_verbose()".

So what we could perhaps do is:

 - make console_verbose() actually reset things to at least LOGLEVEL_DEBUG

 - make sure the *default* loglevel  be LOGLEVEL_WARNING

 - now you can use pr_debug() in the oops code to print messages to
the log, but they won't be printed to the screen.

And people who really want everything can still set a loglevel that is
much higher, because "console_verbose" would only do that "at least"
thing.

That would seem like the best of both worlds, no?

              Linus
