Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeCNMYL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:24:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40068 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbeCNMYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:24:10 -0400
X-Google-Smtp-Source: AG47ELs870pl57emwMHVUiHpp9BfRaXuS9W1V3PuuK+nWdJz6zAo0TSlwkAqopAvd4t9p9p8cg8BDA==
Date: Wed, 14 Mar 2018 13:24:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Whitcroft <apw@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/speculation, objtool: Annotate indirect
 calls/jumps for objtool on 32bit
Message-ID: <20180314122405.g5mxuzr5wd4p4xr3@gmail.com>
References: <20180314112427.22351-1-apw@canonical.com>
 <20180314115125.GS4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314115125.GS4043@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Mar 14, 2018 at 11:24:27AM +0000, Andy Whitcroft wrote:
> > In 9e0e3c5130e9 ("x86/speculation, objtool: Annotate indirect calls/jumps
> > for objtool") we added annotations for CALL_NOSPEC/JMP_NOSPEC on x86 64bit.
> > We did not annotate the 32bit path.  Annotate it similarly.
> > 
> > Signed-off-by: Andy Whitcroft <apw@canonical.com>
> > ---
> >  arch/x86/include/asm/nospec-branch.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> >     While reviewing indirect calls in our builds I noted that the
> >     i386 retpoline CALL_NOSPEC is not annotated safe even though
> >     its amd64 equivalent is.  I cannot see any reason this is not
> >     also inherantly safe.  Peter was there a reason that you did
> >     not annotate this one too?  Anyhow, on the assumption this was
> >     just missed, this patch annotates it.
> 
> Yeah, just an oversight aided by the fact that I (obviously) never build
> 32bit kernels.
> 
> > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > index d0dabeae0505..07886162bdf8 100644
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -183,7 +183,10 @@
> >   * otherwise we'll run out of registers. We don't care about CET
> >   * here, anyway.
> >   */
> > -# define CALL_NOSPEC ALTERNATIVE("call *%[thunk_target]\n",	\
> > +# define CALL_NOSPEC 						\
> > +	ALTERNATIVE(						\
> > +	ANNOTATE_RETPOLINE_SAFE					\
> > +	"call *%[thunk_target]\n",				\
> >  	"       jmp    904f;\n"					\
> >  	"       .align 16\n"					\
> >  	"901:	call   903f;\n"					\
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Applied, thanks guys!

	Ingo
