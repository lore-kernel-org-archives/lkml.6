Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E291720661
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E291720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeHXAun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:50:43 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:43275 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727153AbeHXAun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:50:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0078C18225AF8;
        Thu, 23 Aug 2018 21:19:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blood61_15724effc0d4a
X-Filterd-Recvd-Size: 2984
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 23 Aug 2018 21:19:07 +0000 (UTC)
Message-ID: <e5d579d8ef832fbc133e96746ceb6edbd0870cc2.camel@perches.com>
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually
 exclusive
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, asmadeus@codewreck.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        dwmw@amazon.co.uk, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel@iogearbox.net, hpa@zytor.com
Date:   Thu, 23 Aug 2018 14:19:06 -0700
In-Reply-To: <CAKwvOdmJoEotNMUm=YkuvfAdihnB4SUhbZrc2PDEBScfdrvOjQ@mail.gmail.com>
References: <20180822233724.110454-1-ndesaulniers@google.com>
         <20180823002508.GA822@nautica>
         <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
         <CAGXu5jKJdNFcH9isnB0q_Eg=fpfp8NT+jxkgnaeXY8viDT+F1Q@mail.gmail.com>
         <CAKwvOdmJoEotNMUm=YkuvfAdihnB4SUhbZrc2PDEBScfdrvOjQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 14:03 -0700, Nick Desaulniers wrote:
> One reply for a bunch of the various threads, to keep the number of emails down:
> 
> On Wed, Aug 22, 2018 at 5:20 PM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2018-08-22 at 16:37 -0700, Nick Desaulniers wrote:
> > > +/* Compiler specific macros. */
> > >  #ifdef __clang__
> > >  #include <linux/compiler-clang.h>
> > 
> > probably better as
> > 
> > #if defined(__clang)
> > 
> > to match the style of the #elif defined()s below it
> 
> Hi Joe,
> Thanks for the feedback. I always appreciate it.  If you have some
> cleanups, want to send them to me, and I'll bundle them up for a PR?
> I'm ok with that change.
> 
> > > +#ifdef __GNUC_STDC_INLINE__
> > > +# define __gnu_inline        __attribute__((gnu_inline))
> > > +#else
> > > +# define __gnu_inline
> > > +#endif
> > 
> > Perhaps __gnu_inline should be in compiler-gcc and this
> > should use
> > 
> > #ifndef __gnu_inline
> > #define __gnu_inline
> > #endif
> 
> Not this case; it's how we get gnu89 semantics for `extern inline` is
> not compiler specific (therefor should not go in a compiler specific
> header).

It's not possible to know that compilers support what
__attribute__((<foo>)) and at what version that support
exists unless it is specified somewhere.

As far as I can tell,  gnu_inline is not recognized by clang.

https://clang.llvm.org/docs/AttributeReference.html

