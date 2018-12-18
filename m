Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0B4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A48D21872
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeLROBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:01:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeLROBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:01:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5502A8BF5;
        Tue, 18 Dec 2018 14:01:08 +0000 (UTC)
Received: from treble (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0FEF5D9D6;
        Tue, 18 Dec 2018 14:01:07 +0000 (UTC)
Date:   Tue, 18 Dec 2018 08:01:05 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Martin Jambor <mjambor@suse.cz>
Cc:     Miroslav Benes <mbenes@suse.cz>, Andi Kleen <ak@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218140105.ajuiglkpvstt3qxs@treble>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ri6h8fbqbdf.fsf@suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 18 Dec 2018 14:01:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 01:15:40PM +0100, Martin Jambor wrote:
> OK, I have read through it and with the caveats that I don't quite
> understand what the failure is, that also believe attribute noclone
> should not affect frame pointer generation, and that I don't quite get
> how LTO comes into play, my comments are the following:
> 
> I am the developer who introduced attribute noclone to GCC and also the
> one who advises against using it :-) ...at least without also using the
> noinline attribute, the combination means "I want only one or zero
> copies of this function in the compiled assembly" which you might need
> if you do fancy stuff in inline assembly, for example.
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
> 
> I'm afraid I cannot give an opinion what you should do in this case
> without understanding the problem better.  If you can isolate the case
> where noclone behaves weirdly into a self-contained testcase, I'd be
> happy to have a look at it.

I whittled it down to a small test case.  It turns out the problem is
caused by the "__optimize__("no-tracer")" atribute, which is used by our
__noclone macro:


# if __has_attribute(__optimize__)
#  define __noclone                     __attribute__((__noclone__, __optimize__("no-tracer")))
# else
#  define __noclone                     __attribute__((__noclone__))
# endif


Here's the test case.  Notice it skips the frame pointer setup before
the call to __sanitizer_cov_trace_pc():


$ cat test.c
__attribute__((__optimize__("no-tracer"))) int test(void)
{
	return 0;
}
$ gcc -O2 -fno-omit-frame-pointer -fsanitize-coverage=trace-pc -c -o test.o test.c
$ objdump -dr test.o

test.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <test>:
   0:	48 83 ec 08          	sub    $0x8,%rsp
   4:	e8 00 00 00 00       	callq  9 <test+0x9>
			5: R_X86_64_PC32	__sanitizer_cov_trace_pc-0x4
   9:	31 c0                	xor    %eax,%eax
   b:	48 83 c4 08          	add    $0x8,%rsp
   f:	c3                   	retq   



It works if you remove the function attribute:

0000000000000000 <test>:
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	e8 00 00 00 00       	callq  9 <test+0x9>
			5: R_X86_64_PC32	__sanitizer_cov_trace_pc-0x4
   9:	31 c0                	xor    %eax,%eax
   b:	5d                   	pop    %rbp
   c:	c3                   	retq




Apparently we are using "no-tracer" because of:


commit 95272c29378ee7dc15f43fa2758cb28a5913a06d
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu Mar 31 09:38:51 2016 +0200

    compiler-gcc: disable -ftracer for __noclone functions

    -ftracer can duplicate asm blocks causing compilation to fail in
    noclone functions.  For example, KVM declares a global variable
    in an asm like

        asm("2: ... \n
             .pushsection data \n
             .global vmx_return \n
             vmx_return: .long 2b");

    and -ftracer causes a double declaration.

    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Michal Marek <mmarek@suse.cz>
    Cc: stable@vger.kernel.org
    Cc: kvm@vger.kernel.org
    Reported-by: Linda Walsh <lkml@tlinx.org>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>


-- 
Josh
