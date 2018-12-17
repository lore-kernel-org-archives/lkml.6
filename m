Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11776C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C1B20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbeLQSEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:04:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:16541 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbeLQSEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:04:35 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 10:04:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,366,1539673200"; 
   d="scan'208";a="101364555"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2018 10:04:34 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id BD80C300B49; Mon, 17 Dec 2018 10:04:34 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:04:34 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181217180434.GS25620@tassilo.jf.intel.com>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
 <20181217173900.ygifx7khwmzn2gv2@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217173900.ygifx7khwmzn2gv2@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:39:00AM -0600, Josh Poimboeuf wrote:
> On Sun, Dec 16, 2018 at 07:33:11PM +0100, Arnd Bergmann wrote:
> > Hi Josh,
> > 
> > In randconfig tests with gcc-8.1, I get this warning every
> > few hundred builds, tried it on both next/master and 4.19.y-stable:
> > 
> > kernel/trace/trace_selftest_dynamic.o: warning: objtool:
> > trace_selftest_dynamic_test_func()+0x5: call without frame pointer
> > save/setup
> > kernel/trace/trace_selftest_dynamic.o: warning: objtool:
> > trace_selftest_dynamic_test_func2()+0x5: call without frame pointer
> > save/setup
> > 
> > $ objdump -dr build/x86/0x90C84554_defconfig/kernel/trace/trace_selftest_dynamic.o
> > 
> > build/x86/0x90C84554_defconfig/kernel/trace/trace_selftest_dynamic.o:
> >    file format elf64-x86-64
> > 
> > Disassembly of section .text:
> > 
> > 0000000000000000 <trace_selftest_dynamic_test_func>:
> >    0:    e8 00 00 00 00           callq  5
> > <trace_selftest_dynamic_test_func+0x5>
> >             1: R_X86_64_PC32    __fentry__-0x4
> >    5:    e8 00 00 00 00           callq  a
> > <trace_selftest_dynamic_test_func+0xa>
> >             6: R_X86_64_PC32    __sanitizer_cov_trace_pc-0x4
> >    a:    31 c0                    xor    %eax,%eax
> >    c:    c3                       retq
> >    d:    0f 1f 00                 nopl   (%rax)
> > 
> > 0000000000000010 <trace_selftest_dynamic_test_func2>:
> >   10:    e8 00 00 00 00           callq  15
> > <trace_selftest_dynamic_test_func2+0x5>
> >             11: R_X86_64_PC32    __fentry__-0x4
> >   15:    e8 00 00 00 00           callq  1a
> > <trace_selftest_dynamic_test_func2+0xa>
> >             16: R_X86_64_PC32    __sanitizer_cov_trace_pc-0x4
> >   1a:    31 c0                    xor    %eax,%eax
> >   1c:    c3                       retq
> > 
> > I found this reported in
> > http://kisskb.ellerman.id.au/kisskb/buildresult/13499139/, but could
> > not find an existing fix or analysis.
> 
> Thanks for reporting this Arnd.
> 
> The problem is that, for some reason, __noclone is preventing GCC from
> creating frame pointers for these functions.  Miroslav said that

That seems weird. 

Are you sure it's not just because they are empty? AFAIK
gcc doesn't necessarily generate frame pointers for empty functions.

> __noclone is not recommended by GCC developers, and that __used can be
> used instead for the same purpose:
> 
>   https://lkml.kernel.org/r/alpine.LSU.2.21.1812171256390.3087@pobox.suse.cz
> 
> Andi,
> 
> is __noclone really needed here, since the functions aren't static?  Or
> does LTO cause them to be treated like static functions?

Yes LTO causes the to be treated like static functions.

I guess noclone is unlikely to be really needed here because these
functions are unlikely to be cloned.

So as a workaround it could be removed.

But note we have other noclone functions in the tree (like in KVM)
which actually need it.


-Andi

