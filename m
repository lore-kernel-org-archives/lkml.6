Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DFBC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40874214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0/s5jyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40874214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJIXVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIXVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:21:42 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 715C82087D;
        Tue,  9 Oct 2018 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539101044;
        bh=UzXQ6/8VD51eNAXEgCpKhMBwBH9tKxpbgC6c6+hxcYM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S0/s5jyk7uKFbPbNXgRYoKazzsCz4pfrOQO9LewYHv7u82pfYVHreG6exdueEefY5
         CjvcokmuYpi9rKPZ3M/a7H2O+PDYtLQeiid7KNSL4H/jQ2E6P4YMqlGJCrBpvGRMwC
         qpVXYQDKzZEhD/7Ggw9Oe98g61BNqE++0keKmdMM=
Date:   Wed, 10 Oct 2018 01:04:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20181010010400.0aa342ebdf80bbfa835fb6c5@kernel.org>
In-Reply-To: <20181008235534.75d37fd8@gandalf.local.home>
References: <20181006015110.653946300@goodmis.org>
        <20181006015720.634688468@goodmis.org>
        <20181009124401.6005e2a39c760851aa54e600@kernel.org>
        <20181008235534.75d37fd8@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 23:55:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 9 Oct 2018 12:44:01 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Fri, 05 Oct 2018 21:51:11 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > +typedef long dynfunc_t;
> > > +
> > > +struct dynfunc_struct;
> > > +
> > > +#define arch_dynfunc_trampoline(name, def)	\
> > > +	asm volatile (				\
> > > +	".globl dynfunc_" #name "; \n\t"	\
> > > +	"dynfunc_" #name ": \n\t"		\
> > > +	"jmp " #def " \n\t"			\
> > > +	".balign 8 \n \t"			\
> > > +	: : : "memory" )
> > > +  
> > 
> > I have just a question, what is this different from livepatch? :)
> 
> I actually thought about this a bit, but decided against it.
> 
> I didn't want to hook another infrastructure into the fentry nop. It's
> already complex enough with kprobes, live patching and ftrace.
> 
> The ideal solution is what Peter suggested, and that's to patch the
> call sites, and I think that is attainable with objtool modifications.

OK, the ideal solution sounds good to me. 

> 
> > 
> > I think we can replace the first 5 bytes of the default function
> > to jmp instruction (to alternative function) instead of making
> > this trampoline.
> > 
> > IOW, as far as I can see, this is changing
> > 
> > ----
> > call %reg (or retpoline_reg)
> > ----
> > 
> > to 
> > 
> > ----
> > call dynfunc_A
> > 
> > dynfunc_A:
> > jmp func_A or altered_func_A
> > ----
> > 
> > If so, why don't we put the jmp on default func_A directly?
> > ----
> > call func_A
> > 
> > func_A:
> > "jmp altered_func" or "original sequence"
> > ----
> > (this is idealy same as jprobes did)
> > 
> > Of course we have to arbitrate it with ftrace (fentry) but it may
> > not so hard (simplest way is just adding "notrace" on the default
> > function)
> 
> Then we lose the 5 byte nop.

Yeah, but we can remove the trampoline code.

> > BTW, I think "dynamic_function" may not correct name, it may be
> > "alternative_function" or something like that, because this
> > function must be replaced system-wide and this means we can
> > not use this for generic function pointer usage which depends
> > on thread context (like file_operations). But good for something
> > pluggable code (LSM?).
> 
> I don't like the name alternative, as that's usually a one shot deal
> (SMP vs UP).
> 
> It is dynamic, as it's a function that changes dynamically. Yes its
> global, but that's not mutually exclusive to dynamic.

OK, so we may add a note that this is "global" patching :)

> The use case I want this for is for tracing. But it can be useful for
> KVM and power management governors. Basically anything that has a
> global function pointer (hmm, even the idle call can use this).

Indeed.

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
