Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE191C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D9521104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0cufINn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D9521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbeK3Bot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:44:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44642 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731958AbeK3Bos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=efwfzocka/SQ2rLUJTghQnLlc3WNnQhU9VAAsokmmQM=; b=0cufINn9PrqR7PE3jOOfCv/90F
        u4c+iGOodISu4yhjeD9gSxoDDX7jVT0Mlo7bnTDKWNZnASDdjFSuFm/FTWcxpAk3CAat78mlEgD1k
        iG6q8Q0bQ6ExjLueSqn2V0zPc0dUGQ0bAI74Zb3vK7acoBTyzm+WBCSlAlyO1q9I9/b+ssWYJ6D11
        EGCB/2qRZMmooLyAWSYJDGTP3h+eyx4J+yYd/R3wjr0CMl3EMendbDIrOlWzM53XvIY4S1EF6bksa
        L9CefqhG+LBB/D4Isxgg6AubmAngud4O2Mww7wY18Lm5+Q53fwi1TqscOw4YdQM5rxQiOHe9ILFaJ
        m6HlmGuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSNSx-0001Pb-VW; Thu, 29 Nov 2018 14:38:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9ECD42029FD58; Thu, 29 Nov 2018 15:38:53 +0100 (CET)
Date:   Thu, 29 Nov 2018 15:38:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129143853.GO2131@hirez.programming.kicks-ass.net>
References: <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble>
 <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net>
 <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net>
 <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net>
 <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 05:37:39AM -0800, Andy Lutomirski wrote:
> 
> 
> > On Nov 29, 2018, at 1:42 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Nov 28, 2018 at 10:05:54PM -0800, Andy Lutomirski wrote:
> > 
> >>>> +static void static_call_bp_handler(struct pt_regs *regs, void *_data)
> >>>> +{
> >>>> +    struct static_call_bp_data *data = _data;
> >>>> +
> >>>> +    /*
> >>>> +     * For inline static calls, push the return address on the stack so the
> >>>> +     * "called" function will return to the location immediately after the
> >>>> +     * call site.
> >>>> +     *
> >>>> +     * NOTE: This code will need to be revisited when kernel CET gets
> >>>> +     *       implemented.
> >>>> +     */
> >>>> +    if (data->ret) {
> >>>> +        regs->sp -= sizeof(long);
> >>>> +        *(unsigned long *)regs->sp = data->ret;
> >>>> +    }
> >> 
> >> You can’t do this.  Depending on the alignment of the old RSP, which
> >> is not guaranteed, this overwrites regs->cs.  IRET goes boom.
> > 
> > I don't get it; can you spell that out?
> > 
> > The way I understand it is that we're at a location where a "E8 - Near
> > CALL" instruction should be, and thus RSP should be the regular kernel
> > stack, and the above simply does "PUSH ret", which is what that CALL
> > would've done too.
> > 
> 
> int3 isn’t IST anymore, so the int3 instruction conditionally
> subtracts 8 from RSP and then pushes SS, etc. So my email was
> obviously wrong wrt “cs”, but you’re still potentially overwriting the
> int3 IRET frame.

ARGH!..

can't we 'fix' that again? The alternative is moving that IRET-frame and
fixing everything up, which is going to be fragile, ugly and such
things more.

Commit d8ba61ba58c8 ("x86/entry/64: Don't use IST entry for #BP stack")
doesn't list any strong reasons for why it should NOT be an IST.


