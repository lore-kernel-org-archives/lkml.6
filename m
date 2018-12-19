Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFD7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740FA20989
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbeLSRbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:31:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:49270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728582AbeLSRbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:31:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D46A8B187;
        Wed, 19 Dec 2018 17:31:15 +0000 (UTC)
From:   Martin Jambor <mjambor@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Andi Kleen <ak@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
In-Reply-To: <20181218140105.ajuiglkpvstt3qxs@treble>
References: <20181217173900.ygifx7khwmzn2gv2@treble> <20181217180434.GS25620@tassilo.jf.intel.com> <20181217181638.dfexg6mkmbfyzfli@treble> <20181217192938.GF2218@hirez.programming.kicks-ass.net> <20181217213126.lsqhyszoulel6uq6@treble> <20181217173644.391c2070@gandalf.local.home> <20181218000618.GA25620@tassilo.jf.intel.com> <20181218024916.vmfnyqzouhfxhyvc@treble> <alpine.LSU.2.21.1812181022570.9644@pobox.suse.cz> <ri6h8fbqbdf.fsf@suse.cz> <20181218140105.ajuiglkpvstt3qxs@treble>
User-Agent: Notmuch/0.26 (https://notmuchmail.org) Emacs/26.1 (x86_64-suse-linux-gnu)
Date:   Wed, 19 Dec 2018 18:31:15 +0100
Message-ID: <ri6y38lo23g.fsf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 18 2018, Josh Poimboeuf wrote:
> On Tue, Dec 18, 2018 at 01:15:40PM +0100, Martin Jambor wrote:
>> I'm afraid I cannot give an opinion what you should do in this case
>> without understanding the problem better.  If you can isolate the case
>> where noclone behaves weirdly into a self-contained testcase, I'd be
>> happy to have a look at it.
>
> I whittled it down to a small test case.  It turns out the problem is
> caused by the "__optimize__("no-tracer")" atribute, which is used by our
> __noclone macro:

Wonderful, thanks a lot.

>
> # if __has_attribute(__optimize__)
> #  define __noclone                     __attribute__((__noclone__, __optimize__("no-tracer")))
> # else
> #  define __noclone                     __attribute__((__noclone__))
> # endif
>
>
> Here's the test case.  Notice it skips the frame pointer setup before
> the call to __sanitizer_cov_trace_pc():
>
>
> $ cat test.c
> __attribute__((__optimize__("no-tracer"))) int test(void)
> {
> 	return 0;
> }
> $ gcc -O2 -fno-omit-frame-pointer -fsanitize-coverage=trace-pc -c -o test.o test.c

Well, it might not be intuitive but the __optimize__ attribute resets to
-O2 optimization defaults and thus drops -fno-omit-frame-pointer on the
floor, so no wonder there is no frame pointer.  This applies to other
optimization options you pass on the command line, for example if you
still compile kernel with -fno-strict-aliasing, you get GCC assuming
strict aliasing in functions marked with your __noclone.
 
> Apparently we are using "no-tracer" because of:
>
>
> commit 95272c29378ee7dc15f43fa2758cb28a5913a06d
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Thu Mar 31 09:38:51 2016 +0200
>
>     compiler-gcc: disable -ftracer for __noclone functions
>
>     -ftracer can duplicate asm blocks causing compilation to fail in
>     noclone functions.  For example, KVM declares a global variable
>     in an asm like
>
>         asm("2: ... \n
>              .pushsection data \n
>              .global vmx_return \n
>              vmx_return: .long 2b");
>
>     and -ftracer causes a double declaration.

There is no way for a user to reliably prevent a duplication of an
inline assembly statement.  The correct fix is to move such statements
to an assembly files.  You have disabled tracer which duplicated it in
your case but other passes might do that too in the future.

The correct fix is to put such assembler snippets into separate assembly
files or, if you for for some reason insist on inline assembly, to use
'%=' inline assembler template format string (it is expanded to a number
that is unique in a compilation unit).

Martin
