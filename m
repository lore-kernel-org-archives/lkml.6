Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeERIOB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:14:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51324 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeERIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:13:59 -0400
X-Google-Smtp-Source: AB8JxZpPAY+OWaCLWV4rpJy457bCqkwq6lFiGqMIizvGP/Xi4YPOCCAON19e7fvo7goOmeoEJKINGQ==
Date: Fri, 18 May 2018 10:13:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, nadav.amit@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
Message-ID: <20180518081354.GA11379@gmail.com>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518075853.GD12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, May 17, 2018 at 09:13:58AM -0700, Nadav Amit wrote:
> > +asm(".macro __BUG_FLAGS ins:req file:req line:req flags:req size:req\n"
> > +    "1:\t \\ins\n\t"
> > +    ".pushsection __bug_table,\"aw\"\n"
> > +    "2:\t "__BUG_REL(1b)		"\t# bug_entry::bug_addr\n\t"
> > +    __BUG_REL(\\file)			"\t# bug_entry::file\n\t"
> > +    ".word \\line"			"\t# bug_entry::line\n\t"
> > +    ".word \\flags"			"\t# bug_entry::flags\n\t"
> > +    ".org 2b+\\size\n\t"
> > +    ".popsection\n\t"
> > +    ".endm");
> > +
> > +#define _BUG_FLAGS(ins, flags)                                          \
> >  do {									\
> > +	asm volatile("__BUG_FLAGS \"" ins "\" %c0 %c1 %c2 %c3"		\
> > +		     : : "i" (__FILE__), "i" (__LINE__),                \
> > +			 "i" (flags),                                   \
> >  			 "i" (sizeof(struct bug_entry)));		\
> >  } while (0)
> 
> This is an awesome hack, but is there really nothing we can do to make
> it more readable? Esp, that global asm doing the macro definition is a
> pain to read.
> 
> Also, can we pretty please used named operands in 'new' code?

Yes, that's my main worry too about all these inlining changes:
the very, very marked reduction in the readability of assembly code.

It's bad to an extent that I'm questioning the wisdom of pandering to a compiler 
limitation to begin with?

How about asking GCC for an attribute where we can specify the inlined size of an 
asm() function? Even if we'll just approximate it due to some vagaries of actual 
code generation related to how arguments interact with GCC, an explicit byte value 
will do a heck of a better job of it than some sort of implied, vague 'number of 
newlines' heuristics ...

Thanks,

	Ingo
