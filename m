Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22E2C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDB9214C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDB9214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeJILK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 07:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeJILK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 07:10:29 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0266A2085B;
        Tue,  9 Oct 2018 03:55:35 +0000 (UTC)
Date:   Mon, 8 Oct 2018 23:55:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature
 "jump_function"
Message-ID: <20181008235534.75d37fd8@gandalf.local.home>
In-Reply-To: <20181009124401.6005e2a39c760851aa54e600@kernel.org>
References: <20181006015110.653946300@goodmis.org>
        <20181006015720.634688468@goodmis.org>
        <20181009124401.6005e2a39c760851aa54e600@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 12:44:01 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 05 Oct 2018 21:51:11 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > +typedef long dynfunc_t;
> > +
> > +struct dynfunc_struct;
> > +
> > +#define arch_dynfunc_trampoline(name, def)	\
> > +	asm volatile (				\
> > +	".globl dynfunc_" #name "; \n\t"	\
> > +	"dynfunc_" #name ": \n\t"		\
> > +	"jmp " #def " \n\t"			\
> > +	".balign 8 \n \t"			\
> > +	: : : "memory" )
> > +  
> 
> I have just a question, what is this different from livepatch? :)

I actually thought about this a bit, but decided against it.

I didn't want to hook another infrastructure into the fentry nop. It's
already complex enough with kprobes, live patching and ftrace.

The ideal solution is what Peter suggested, and that's to patch the
call sites, and I think that is attainable with objtool modifications.

> 
> I think we can replace the first 5 bytes of the default function
> to jmp instruction (to alternative function) instead of making
> this trampoline.
> 
> IOW, as far as I can see, this is changing
> 
> ----
> call %reg (or retpoline_reg)
> ----
> 
> to 
> 
> ----
> call dynfunc_A
> 
> dynfunc_A:
> jmp func_A or altered_func_A
> ----
> 
> If so, why don't we put the jmp on default func_A directly?
> ----
> call func_A
> 
> func_A:
> "jmp altered_func" or "original sequence"
> ----
> (this is idealy same as jprobes did)
> 
> Of course we have to arbitrate it with ftrace (fentry) but it may
> not so hard (simplest way is just adding "notrace" on the default
> function)

Then we lose the 5 byte nop.

> 
> BTW, I think "dynamic_function" may not correct name, it may be
> "alternative_function" or something like that, because this
> function must be replaced system-wide and this means we can
> not use this for generic function pointer usage which depends
> on thread context (like file_operations). But good for something
> pluggable code (LSM?).

I don't like the name alternative, as that's usually a one shot deal
(SMP vs UP).

It is dynamic, as it's a function that changes dynamically. Yes its
global, but that's not mutually exclusive to dynamic.

The use case I want this for is for tracing. But it can be useful for
KVM and power management governors. Basically anything that has a
global function pointer (hmm, even the idle call can use this).

-- Steve
