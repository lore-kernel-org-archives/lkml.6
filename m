Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DB0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752C2218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeLRV5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbeLRV5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:57:17 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FECA21852;
        Tue, 18 Dec 2018 21:57:15 +0000 (UTC)
Date:   Tue, 18 Dec 2018 16:57:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Martin Jambor <mjambor@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218165713.4309797a@gandalf.local.home>
In-Reply-To: <20181218211501.GD25620@tassilo.jf.intel.com>
References: <20181217173900.ygifx7khwmzn2gv2@treble>
        <20181217180434.GS25620@tassilo.jf.intel.com>
        <20181217181638.dfexg6mkmbfyzfli@treble>
        <20181217192938.GF2218@hirez.programming.kicks-ass.net>
        <20181217213126.lsqhyszoulel6uq6@treble>
        <20181217173644.391c2070@gandalf.local.home>
        <20181218000618.GA25620@tassilo.jf.intel.com>
        <20181218024916.vmfnyqzouhfxhyvc@treble>
        <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz>
        <ri6h8fbqbdf.fsf@suse.cz>
        <20181218211501.GD25620@tassilo.jf.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 13:15:01 -0800
Andi Kleen <ak@linux.intel.com> wrote:

> 
> > 
> > I am the developer who introduced attribute noclone to GCC and also the
> > one who advises against using it :-) ...at least without also using the
> > noinline attribute, the combination means "  
> 
> The function in question uses noinline too.

And that's all I care about.

> 
> > I want only one or zero
> > copies of this function in the compiled assembly" which you might need
> > if you do fancy stuff in inline assembly, for example.  
> 
> For this case we only want one non inlined copy because it is used as a
> test case for a function tracer.

The function tracer selftest should work just fine if there's more than
one copy. Because the test will enable all copies.

> 
> LTO comes into play because it originally relied on being in a separate
> file, so it would not be inlined, but with LTO that doesn't work.

The reason for it being in a separate file is because the entire
directory is marked "notrace". That file, and that file alone in that
directory, gets compiled with the -pg flags. As long as the functions
in that file don't get inlined (which will make them notrace as well)
all is good.

Thus, if used and/or noinline prevents the functions from being
inlined, and thus have their profiling removed, we should be good.

Hmm, how does that work? When does LTO do its linker magic? Because the
fentry/mcounts are added when the object is created. Are they removed
if the compiler sees that it can be inlined? Or does LTO just compile
everything in one go?

> 
> > 
> > I believe that when people use noclone on its own, in 99 out 100 cases
> > they actually want something else.  Usually there is something that  
> 
> AFAIK there is no noclone without noinline in the kernel tree.
> 
> 
> > references the function from code (such as assembly) or a tool that the
> > compiler does know about and then they should use the "used" attribute.  
> 
> Neither in the ftrace case, nor in the KVM case (another user which
> has fancy inline assembly that cannot be duplicated) that's the case.
> It's just about having exactly one out of line instance.

Again, that's not the ftrace case. It doesn't care about more than one
out of line instance. Thus, for this particular use, "used" should be
good enough.

-- Steve
