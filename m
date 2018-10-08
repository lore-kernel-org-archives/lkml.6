Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA621C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB6D2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2SCc0Bxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB6D2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJHOck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:32:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48356 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJHOck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zoATZdqlafS/3eCKuhEuqAYlbGPUieQWmTRfBK1bszU=; b=2SCc0BxtxOQteT9FdVUqkHLTJ
        3v9pMKjF1ywQ5UAIttruDcGJuGiQnoUb6y1dBWwBEo/nHKe84dS7mu4IKBCDZUav7FrLunqHhLqDV
        WAT3OLHk0mnSbauMfMb7WNF1/Fn50y1JPI/3t7Qx86JZx3Z412IqrNdQtUx9JPNu0SfeM0mfNuEub
        ONIEWxE+6BQ93RWKW0ajhbQJnFtQ+2jycuV1TiERvm1NpK/JMd9x0GKUJb2uJidEyL6odP/ieZRv2
        Wfc1oY/y11l/U8KgNpjrnVXnM1zetDJYVQPsJ47/YC4oaw1rLQvqgZNrmTtsB0Q0d+fAwz5kXDcOO
        OX/EZsA+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9PrK-0002Wc-Fo; Mon, 08 Oct 2018 07:21:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51A5520268264; Mon,  8 Oct 2018 09:21:34 +0200 (CEST)
Date:   Mon, 8 Oct 2018 09:21:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        ard.biesheuvel@linaro.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature
 "jump_function"
Message-ID: <20181008072134.GB5663@hirez.programming.kicks-ass.net>
References: <20181006015110.653946300@goodmis.org>
 <20181006015720.634688468@goodmis.org>
 <20181006121211.GA5663@hirez.programming.kicks-ass.net>
 <20181006093905.46276505@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006093905.46276505@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 09:39:05AM -0400, Steven Rostedt wrote:
> On Sat, 6 Oct 2018 14:12:11 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Oct 05, 2018 at 09:51:11PM -0400, Steven Rostedt wrote:
> > > +#define arch_dynfunc_trampoline(name, def)	\
> > > +	asm volatile (				\
> > > +	".globl dynfunc_" #name "; \n\t"	\
> > > +	"dynfunc_" #name ": \n\t"		\
> > > +	"jmp " #def " \n\t"			\
> > > +	".balign 8 \n \t"			\
> > > +	: : : "memory" )  
> > 
> > Bah, what is it with you people and trampolines. Why can't we, just like
> > jump_label, patch the call directly?
> > 
> > The whole call+jmp thing is silly, don't do that. It just wrecks I$ and
> > is slower for no real reason afaict.
> 
> My first attempt was to do just that. But to add a label at the
> call site required handling all the parameters too. See my branch:
>  ftrace/jump_function-v1 for how ugly it got (and it didn't work).

Can't we hijack the relocation records for these functions before they
get thrown out in the (final) link pass or something?
