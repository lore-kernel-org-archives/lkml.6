Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A80DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BFC20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbeLQRjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:39:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbeLQRjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:39:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F371C811DC;
        Mon, 17 Dec 2018 17:39:04 +0000 (UTC)
Received: from treble (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4A3B1019630;
        Mon, 17 Dec 2018 17:39:02 +0000 (UTC)
Date:   Mon, 17 Dec 2018 11:39:00 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181217173900.ygifx7khwmzn2gv2@treble>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 17 Dec 2018 17:39:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 07:33:11PM +0100, Arnd Bergmann wrote:
> Hi Josh,
> 
> In randconfig tests with gcc-8.1, I get this warning every
> few hundred builds, tried it on both next/master and 4.19.y-stable:
> 
> kernel/trace/trace_selftest_dynamic.o: warning: objtool:
> trace_selftest_dynamic_test_func()+0x5: call without frame pointer
> save/setup
> kernel/trace/trace_selftest_dynamic.o: warning: objtool:
> trace_selftest_dynamic_test_func2()+0x5: call without frame pointer
> save/setup
> 
> $ objdump -dr build/x86/0x90C84554_defconfig/kernel/trace/trace_selftest_dynamic.o
> 
> build/x86/0x90C84554_defconfig/kernel/trace/trace_selftest_dynamic.o:
>    file format elf64-x86-64
> 
> Disassembly of section .text:
> 
> 0000000000000000 <trace_selftest_dynamic_test_func>:
>    0:    e8 00 00 00 00           callq  5
> <trace_selftest_dynamic_test_func+0x5>
>             1: R_X86_64_PC32    __fentry__-0x4
>    5:    e8 00 00 00 00           callq  a
> <trace_selftest_dynamic_test_func+0xa>
>             6: R_X86_64_PC32    __sanitizer_cov_trace_pc-0x4
>    a:    31 c0                    xor    %eax,%eax
>    c:    c3                       retq
>    d:    0f 1f 00                 nopl   (%rax)
> 
> 0000000000000010 <trace_selftest_dynamic_test_func2>:
>   10:    e8 00 00 00 00           callq  15
> <trace_selftest_dynamic_test_func2+0x5>
>             11: R_X86_64_PC32    __fentry__-0x4
>   15:    e8 00 00 00 00           callq  1a
> <trace_selftest_dynamic_test_func2+0xa>
>             16: R_X86_64_PC32    __sanitizer_cov_trace_pc-0x4
>   1a:    31 c0                    xor    %eax,%eax
>   1c:    c3                       retq
> 
> I found this reported in
> http://kisskb.ellerman.id.au/kisskb/buildresult/13499139/, but could
> not find an existing fix or analysis.

Thanks for reporting this Arnd.

The problem is that, for some reason, __noclone is preventing GCC from
creating frame pointers for these functions.  Miroslav said that
__noclone is not recommended by GCC developers, and that __used can be
used instead for the same purpose:

  https://lkml.kernel.org/r/alpine.LSU.2.21.1812171256390.3087@pobox.suse.cz

Andi,

is __noclone really needed here, since the functions aren't static?  Or
does LTO cause them to be treated like static functions?

Or if it is really needed, would __used be sufficient instead?

noinline __noclone int DYN_FTRACE_TEST_NAME(void)
{
	/* used to call mcount */
	return 0;
}

noinline __noclone int DYN_FTRACE_TEST_NAME2(void)
{
	/* used to call mcount */
	return 0;
}

-- 
Josh
