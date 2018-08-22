Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFC4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFD8208D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFD8208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeHWDYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 23:24:36 -0400
Received: from nautica.notk.org ([91.121.71.147]:33552 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbeHWDYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 23:24:35 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id D5276C009; Thu, 23 Aug 2018 01:57:37 +0200 (CEST)
Date:   Thu, 23 Aug 2018 01:57:22 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     joe@perches.com, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
Message-ID: <20180822235722.GA27485@nautica>
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
 <20180821123832.GA19034@nautica>
 <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
 <acb93bae0086447c7cbe0eec05907335ebae7788.camel@perches.com>
 <CAKwvOdkLGhdQxx3oV=R2kv290NOv_w8qQ_yHWCVpvmofp7+ivQ@mail.gmail.com>
 <20180822041646.GA21716@nautica>
 <78396ba82562326f4b3a395a63e3e8dc38d608b2.camel@perches.com>
 <20180822043230.GA26654@nautica>
 <CAKwvOdm+BwvDxAw-A_1v5xO2EjDff1axAttHVz5QnBSxSbKo=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdm+BwvDxAw-A_1v5xO2EjDff1axAttHVz5QnBSxSbKo=g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers wrote on Wed, Aug 22, 2018:
> I'm currently testing a fix in
> https://github.com/ClangBuiltLinux/linux/commit/1f89ae7622c26b8131f42f3a362d6ef41b88a595,
> can you please share with me your steps to test/verify that the patch
> fixes the issue for eBPF?  I'll go talk to a co-worker who know more
> about eBPF, but I've not yet done anything with it.

Thanks for the link.

The simplest way to test with bcc for me would probably be to fetch the
example from their repo itself[1], whether you install bcc through your
distro or compile it yourself.

There are dozens of example programs in the tools/ directory of which
you can just run any, if will try to compile the program embedded wihtin
the example at runtime with clang.

[1] https://github.com/iovisor/bcc

(I just noticed fedora provides a bcc-tools package which provides these
tools directly, so if you're lucky you can just install that and run
examples in /usr/share/bcc/tools)



In particular I get a couple of errors with your patch, I think it boils
down to this one:
-----
In file included from <built-in>:3:
In file included from /virtual/include/bcc/helpers.h:23:
In file included from /lib/modules/4.18.0+/build/include/linux/log2.h:16:
In file included from /lib/modules/4.18.0+/build/include/linux/bitops.h:18:
In file included from /lib/modules/4.18.0+/build/arch/x86/include/asm/bitops.h:16:
/lib/modules/4.18.0+/build/include/linux/compiler.h:217:3: error:
expected expression
                barrier();
                ^
/lib/modules/4.18.0+/build/include/linux/compiler-clang.h:43:20: note:
expanded from macro 'barrier'
#define barrier() (__asm__ __volatile__("" : : : "memory"))
                   ^
-----

And removing the parenthesis around the expression seems to work, they
weren't here in the compiler-gcc.h file in the previous version?

There might be other defines the simple examples I ran do not use but
from a quick glance it doesn't look like it, thank you for the split
work!

-- 
Dominique Martinet
