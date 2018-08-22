Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC4BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BDE214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BDE214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeHVHkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 03:40:07 -0400
Received: from nautica.notk.org ([91.121.71.147]:43653 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbeHVHkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 03:40:07 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id AED98C009; Wed, 22 Aug 2018 06:17:01 +0200 (CEST)
Date:   Wed, 22 Aug 2018 06:16:46 +0200
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
Message-ID: <20180822041646.GA21716@nautica>
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
 <20180821123832.GA19034@nautica>
 <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
 <acb93bae0086447c7cbe0eec05907335ebae7788.camel@perches.com>
 <CAKwvOdkLGhdQxx3oV=R2kv290NOv_w8qQ_yHWCVpvmofp7+ivQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkLGhdQxx3oV=R2kv290NOv_w8qQ_yHWCVpvmofp7+ivQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers wrote on Tue, Aug 21, 2018:
> On Tue, Aug 21, 2018 at 9:45 AM Joe Perches <joe@perches.com> wrote:
> > > Tested with gcc-7 and clang-8.
> >
> > clang-8? Isn't the latest officlal clang 6.0.1 ?
> [...]
> > So if something other than 6.0.x is required,
> > then some additional check should probably be
> > added to compiler-clang.h as well.
> 
> Sure, but that doesn't need to go in Mashiro's patch today.  That can
> wait for a proper separation between compiler headers where we can
> then implement improved version checks.

I can confirm that the patch here works for me with clang 6.0.1 as far
as bpf programs are concerned (and gcc 8.1.1 for the kernel build itself
on x86 while I was at it); so at least there is nothing on the
compiler*.h headers that put off clang 6.0.1


(also replying to other subthread)
From Joe Perches @ 2018-08-21 17:22 UTC:
> The question remains, if clang can't compile
> v4.17, why does it immediately matter for v4.19?

I haven't had any problem with clang and 4.17 as far as building bpf
programs is concerned, because the CC_HAVE_ASM_GOTO check is done in
makefiles that aren't used in the bpf case and not in compiler-gcc.h
or another header.

So I guess the "immediately matters for v4.19" depends on how much you
would care about bcc-compiled BPF programs.


> Why wouldn't overriding the clang __GNUC_<foo>
> #defines in compiler-gcc.h work acceptably with
> adding whatever is necessary to compiler-clang.h?

I think that could work, but at the point making a separate
compiler-common.h and not including compiler-gcc.h for clang sounds
better to me... More importantly here, either solution sound complex
enough to require more than a few days and proper testing for all archs
etc when compared to the partial revert we have here.

-- 
Dominique Martinet
