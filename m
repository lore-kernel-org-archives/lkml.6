Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA7CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7D8214C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7D8214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeHUUnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:43:51 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:50572 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726612AbeHUUnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:43:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D77BF181D340F;
        Tue, 21 Aug 2018 17:22:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rifle85_1841de001f10d
X-Filterd-Recvd-Size: 3491
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 Aug 2018 17:22:46 +0000 (UTC)
Message-ID: <da893e74179ec301ef41d7d240224d2eb824d2a8.camel@perches.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 21 Aug 2018 10:22:45 -0700
In-Reply-To: <CAKwvOdkgtoNJuagT_uoNnDKcxHAjsvfWo9hQMP2OKz9_qpstNQ@mail.gmail.com>
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
         <6b1d5081e2da107537f72125fc595229128b46e6.camel@perches.com>
         <CAKwvOdkgtoNJuagT_uoNnDKcxHAjsvfWo9hQMP2OKz9_qpstNQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 09:57 -0700, Nick Desaulniers wrote:
> On Tue, Aug 21, 2018 at 9:33 AM Joe Perches <joe@perches.com> wrote:
> > 
> > On Tue, 2018-08-21 at 15:48 +0900, Masahiro Yamada wrote:
> > > Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> > > missed the fact that <linux/compiler-gcc.h> is included by Clang
> > > as well as by GCC.
> > > 
> > > Clang actually defines __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__
> > > and it looks like GCC 4.2.1.
> > > 
> > >   $ scripts/gcc-version.sh -p clang
> > >   040201
> > > 
> > > If you try to build the kernel with Clang, you will get the
> > > "Sorry, your compiler is too old - please upgrade it."
> > > followed by a bunch of "unknown attribute" warnings.
> > > 
> > > Add !defined(__clang__) to the minimum version check.
> > > 
> > > Also, revive the version test blocks for versions >= 4.2.1
> > > in order to disable features not supported by Clang.
> > 
> > What is the minimum clang version required to compile the kernel?
> 
> Depends on the architecture and which kernel version/LTS branch you're
> using.  I'm trying to backport fixes to LTS branches, but sometimes a
> compiler upgrade is required.  I know that's not great, but I'm
> actively trying to fix it.

Can you enumerate these dependencies please.

> > What features are not supported by the minimum clang version?

And enumerate this too please.

Uglifying the compiler-gcc file to support
clang features that can be overridden in
compiler-clang.h instead is not a good way
to fix compilation for clang.

But still, whatever features in the various
clang versions that need accommodation also
need listing out in compiler-clang.h, not in
compiler-gcc.h

> $ git describe --contains e501ce9 | sed 's/~.*//'
> v4.17-rc1

Thanks, but I know this.

The question remains, if clang can't compile
v4.17, why does it immediately matter for v4.19?

Why wouldn't overriding the clang __GNUC_<foo>
#defines in compiler-gcc.h work acceptably with
adding whatever is necessary to compiler-clang.h?

I'll experiment with a compiler-clang.h patch.


