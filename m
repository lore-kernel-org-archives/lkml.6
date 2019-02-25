Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CFAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936292083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yT4RM6by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfBYQRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:17:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41480 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfBYQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jZqWHcUi29rXKew2ezGr30NgxKms5+U8KsuUeku8ARY=; b=yT4RM6by3gj0h9ru02ialy7QY
        899ZsXLQ2FcZDe4PjtCbk1phqlDpOiidWsdFR4zLUKm6CKKJSWiWUzDUkB/su9bVEKWXNPzSp0ESx
        qrQXSZpVyWp1/6RZ6lQjQo6wxzqC3b9n6XTZ3MIlT2XNS9C3UJQgb8gZ67rziJowfDGHRNEI85bBy
        mCD/oEDVY+VP+B453mAuBSKybdV9n7fUF0BnQ6NrE0nLv1IZtcHt/U2rXX44LyNlFvnewITmZAJU0
        oa6ofyL2l+tg7qYzyiB/rsnE3bbnLlrt84D2CS+GXtGnlNg4/ZfgKVBwdkvVYn9q5SZr+q1SaAKW5
        oF6r87Spg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyIwV-0007Ro-9m; Mon, 25 Feb 2019 16:17:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15BF72030C217; Mon, 25 Feb 2019 17:17:22 +0100 (CET)
Date:   Mon, 25 Feb 2019 17:17:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] objtool: Replace STACK_FRAME_NON_STANDARD annotation
Message-ID: <20190225161722.GN32477@hirez.programming.kicks-ass.net>
References: <20190225124330.613028745@infradead.org>
 <20190225125232.107098740@infradead.org>
 <20190225161124.cq6c45r3wlwktyuz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225161124.cq6c45r3wlwktyuz@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:11:24AM -0600, Josh Poimboeuf wrote:
> On Mon, Feb 25, 2019 at 01:43:34PM +0100, Peter Zijlstra wrote:
> > Replace the existing STACK_FRAME_NON_STANDARD annotation with a
> > 'better' scheme.
> > 
> > The old annotation works by taking the address of a function; this
> > is visible to the compiler and might affect code generation (the
> > function pointer escapes). The new annotation simply stores the
> > function name and has objtool do a symtab lookup.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/frame.h |   19 +++++++++++++---
> >  tools/objtool/check.c |   58 +++++++++++++++++++++-----------------------------
> >  tools/objtool/check.h |    1 
> >  3 files changed, 41 insertions(+), 37 deletions(-)
> > 
> > --- a/include/linux/frame.h
> > +++ b/include/linux/frame.h
> > @@ -11,9 +11,22 @@
> >   *
> >   * For more information, see tools/objtool/Documentation/stack-validation.txt.
> >   */
> > -#define STACK_FRAME_NON_STANDARD(func) \
> > -	static void __used __section(.discard.func_stack_frame_non_standard) \
> > -		*__func_stack_frame_non_standard_##func = func
> > +#define STACK_FRAME_NON_STANDARD(func)					\
> > +	asm (".pushsection .discard.nonstd_frame_strtab, \"S\", @3\n\t"	\
> > +	     "999: .ascii \"" #func "\"\n\t"				\
> > +	     "     .byte 0\n\t"						\
> > +	     ".popsection\n\t"						\
> > +	     ".pushsection .discard.nonstd_frame\n\t"			\
> > +	     ".long 999b - .\n\t"					\
> > +	     ".popsection\n\t")
> > +
> 
> I don't think this will work in the case where GCC does an IPA
> optimization and renames the function (e.g., renames func to
> func.isra.1234), right?  That might be a deal breaker...

*groan*... indeed :/ So back to the old scheme then? Andy, any other
clever ideas?

> > +/*
> > + * SHT_STRTAB(@3) sections should start with a \0 byte such that the 0 offset
> > + * encodes the NULL string.
> > + */
> > +asm (".pushsection .discard.nonstd_frame_strtab, \"S\", @3\n\t"
> > +     ".byte 0\n\t"
> > +     ".popsection\n\t");
> 
> Including the file creates the section, which is a bit nasty.  Instead
> just change STACK_FRAME_NON_STANDARD to prefix every string with a \0?

That would get us \0\0 between every string, which I suppose is in-spec,
but weird. I figured that since it is a .discard. section, getting it
wasn't a problem.
