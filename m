Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeEOSwb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:52:31 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:33670 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeEOSw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:52:29 -0400
X-Google-Smtp-Source: AB8JxZosHfyDQGLGfA7arsT7jqtgHh+6ruO3f0UfVBz0a3vDayEJMNGaGPNo4eaI84smHSAGVQpnWQhPr+sIJhYZWys=
MIME-Version: 1.0
References: <20180505083635.622xmcvb42dw5xxh@gmail.com> <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
 <20180509073327.GE12217@hirez.programming.kicks-ass.net> <20180515083556.GA30420@gmail.com>
 <20180515114144.GX12217@hirez.programming.kicks-ass.net> <20180515154333.bszh4nuowhocozuc@lakrids.cambridge.arm.com>
 <20180515171021.GI12217@hirez.programming.kicks-ass.net> <20180515175307.m4xbkbicdrzo4qhb@lakrids.cambridge.arm.com>
 <20180515181136.GR12217@hirez.programming.kicks-ass.net> <20180515181510.GM12235@hirez.programming.kicks-ass.net>
In-Reply-To: <20180515181510.GM12235@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 May 2018 11:52:17 -0700
Message-ID: <CA+55aFxjU0op8QLLu0n-RjHBs7gQsLvD8jcyedgw6jeZFN7B+Q@mail.gmail.com>
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 11:15 AM Peter Zijlstra <peterz@infradead.org>
wrote:

> Alternatively we could use 'p' for the argument pointer thing.

Probably better than having i/I.

But while people are bikeshedding the important stuff, can I please mention
my personal pet peeve with generated code?

If we go down this "generate header files" path, and ever expand to
actually generating some of the definitions too, can we *please* try to
follow three rules:

  (a) make the generated header file not just say "this is generated", but
say exactly *what* generates it, so that when you look at it, you don't
have to search for the generator?

  (b) if at all possible, please aim to make "git grep" find the stuff that
is generated?

  (c) if b is not possible, then generate '#line' things in the generator so
that debug information points back to the original source?

That (b) in particular can be a major pain, because "git grep" will
obviously only look at the _source_ files (including the script that
generates thing), but not at the generated file at all.

But when you see a stack trace or oops or something that mentions some
function that you're not intimately familiar with, the first thing I do is
basically some variation of

     git grep function_name

or similar. Maybe it's just me, but I actually really like how fast "git
grep" is with threading and everything to just go the extra mile.

And what often happens with generated functions is that you can't actually
find them with git grep, because the generator will generate the function
names in two or more parts (ie in this case, for example, "cmpxchg_relaxed"
would never show up, becuase it's the "relaxed" version of cmpxchg.

So (b) will likely not work out, but at least try very hard to do (a) and
(c) when (b) fails. So that when people do stack traces, if they have the
debug information, at least it will point to the actual implementation in
the generator.

(NOTE! I realize that right now you're just talking about generating the
header file itself, with only declarations, not definitions. So the above
is not an issue. Yet. I'm just waiting for people to generate some of the
code too, and being proactive)_.

Hmm?

                 Linus
