Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D52C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0878421852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLRMbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:31:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbeLRMbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:31:47 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CECC20874;
        Tue, 18 Dec 2018 12:31:46 +0000 (UTC)
Date:   Tue, 18 Dec 2018 07:31:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Martin Jambor <mjambor@suse.cz>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218073143.1536e8e9@vmware.local.home>
In-Reply-To: <ri6h8fbqbdf.fsf@suse.cz>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
        <20181217173900.ygifx7khwmzn2gv2@treble>
        <20181217180434.GS25620@tassilo.jf.intel.com>
        <20181217181638.dfexg6mkmbfyzfli@treble>
        <20181217192938.GF2218@hirez.programming.kicks-ass.net>
        <20181217213126.lsqhyszoulel6uq6@treble>
        <20181217173644.391c2070@gandalf.local.home>
        <20181218000618.GA25620@tassilo.jf.intel.com>
        <20181218024916.vmfnyqzouhfxhyvc@treble>
        <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz>
        <ri6h8fbqbdf.fsf@suse.cz>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 13:15:40 +0100
Martin Jambor <mjambor@suse.cz> wrote:

> I am the developer who introduced attribute noclone to GCC and also the
> one who advises against using it :-) ...at least without also using the
> noinline attribute, the combination means "I want only one or zero
> copies of this function in the compiled assembly" which you might need
> if you do fancy stuff in inline assembly, for example.

Sounds to me that we should not be using noclone in this instance.

> 
> I believe that when people use noclone on its own, in 99 out 100 cases
> they actually want something else.  Usually there is something that
> references the function from code (such as assembly) or a tool that the
> compiler does know about and then they should use the "used" attribute.
> That is what I understood to be the use case here and therefore I
> recommended it.  In other cases people want all inter-procedural (IPA)
> analyses to stay away from a function and then they should use attribute
> noipa (or in older GCCs, the combination of noinline and noclone).
> 
> The attribute was introduced because it is useful in GCC testsuite, and
> although I think occasions when it is useful on its own elsewhere are
> very rare and quite obscure, they can happen.  But it really only means
> you want only one or zero *non-inlined* copies of the function.  For
> example if you have an asm in it that must appear in the compiled
> assembly only once but you are confident it will be optimized out in
> inlined instances.  Or if you play games with __builtin_return_address()
> and somehow have a very clear idea what the return values should be.

With this explanation, I really believe the answer is s/noclone/used/.

Here's the problem that the "noinline noclone" is trying to solve. When
someone compiles with LTO (which links much more and can remove unused
functions, or inline them better) the ftrace dynamic self test
functions can be inlined. If that happens, they lose the
"mcount/fentry" from gcc -pg. Which was the reason they were made, and
placed in a separate file to begin with. Then when the self tests try
to enable function tracing on these functions, they can't and the boot
up tests fail, disabling ftrace.

The "noinline noclone" was added to prevent this case. And from your
description, it sounds like "noinline used" is what we actually want.

-- Steve
