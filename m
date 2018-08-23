Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35519C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30872150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30872150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeHXBkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 21:40:36 -0400
Received: from nautica.notk.org ([91.121.71.147]:41787 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbeHXBkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 21:40:36 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 3FCD2C009; Fri, 24 Aug 2018 00:08:49 +0200 (CEST)
Date:   Fri, 24 Aug 2018 00:08:34 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        joe@perches.com, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel@iogearbox.net, hpa@zytor.com
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually
 exclusive
Message-ID: <20180823220834.GA25096@nautica>
References: <20180822233724.110454-1-ndesaulniers@google.com>
 <20180823002508.GA822@nautica>
 <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
 <CAGXu5jKJdNFcH9isnB0q_Eg=fpfp8NT+jxkgnaeXY8viDT+F1Q@mail.gmail.com>
 <CAKwvOdmJoEotNMUm=YkuvfAdihnB4SUhbZrc2PDEBScfdrvOjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmJoEotNMUm=YkuvfAdihnB4SUhbZrc2PDEBScfdrvOjQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers wrote on Thu, Aug 23, 2018:
> > On a side note, I noticed tools/include/linux/compiler.h includes
> > linux/compiler-gcc.h but maybe it should include linux/compiler_types.h?
> > (I'm not sure at who uses that header, so it really is an open question
> > here)
> 
> Without looking into the code, this sounds like compiler.h is wrong.
> Looking at the source, there's references to ancient Android NDK's
> (what?! Let me show this to the NDK maintainers).  This whole thing
> needs to be cleaned up, too, IMO.  Oh, there's two compiler-gcc.h in
> the tree:
> 
> - tools/include/linux/compiler-gcc.h (that's what's being included in
> the case you point out)
> - include/linux/compiler-gcc.h
> 
> Maybe they can be combined?

Ah, I didn't notice there is another compiler-gcc...
Looking closer there seem to be other "reused" headers (almost all of
the headers in tools/include/linux have a counterpart in include/linux),
and some e.g. rbtree.h went from being a copy of the main include's to a
single '#include "../../../../include/linux/rbtree.h"' line to a
slightly simplified copy again to avoid bringing in rcu as dependency...

I think compiler.h could be done with a similar trick with a bit of
massaging, but as things stand linux/compiler.h includes
uapi/linux/types.h, and this complains about using kernel headers from
user space... So this isn't as trivial as just making tools use the
kernel's include at least.



> > If you tried to align these, __always_unused and __alias(symbol) look
> > off
> 
> I have `set tabstop=8` in vim, and it looks correct there, but both
> `git diff` and github's code viewer show it as off.  Maybe I have my
> settings wrong in vim and need to go back to first grade, but
> (personal opinion ahead) you don't have this kind of nonsense
> (ambiguity around how many spaces a tab should be displayed as in
> various code viewers) if you just always use spaces everywhere, for
> everything.  Other large codebases use automatic code formatters (like
> clang-format) and that prevents holy wars and other distractions.
> There's even a cool utility called `git-clang-format` that can check
> just the code you changed, which is useful for not reformatting the
> entire codebase messing up git blame.

Right, this is my mistake - the diff view adds a space so these "inner
tabs" alignments can be messed up.
FWIW I think checkpatch only complains about leading space-based
indentation, the inner filling can be whatever you want, but this is
fine and I was overzealous.


> On Wed, Aug 22, 2018 at 7:43 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > It was previous included by all compilers,
> > but now it is only by _true_ GCC.
> 
> Good catch, and thanks for the report and testing.  I missed that
> because I was testing x86_64 and arm64 (which I guess don't hit that
> in the configs I tested) and not arm32.  Should be a simple fix to
> move it to shared the definition.  Send me a patch, or I'll get to it.
> 
> > Even if I move the __naked definition
> > to <linux/compiler_types.h>,
> > I see a different error.
> 
> Did that regress due to my change?  If so, sorry and I'll look into it
> more soon.

I've looked at that one quickly and that warning looks legitimate to me,
I'm not sure why it would appear only now but clang does document[1] not
allowing the parameters to be used even in extended asm, and gcc
documentation[2] says "While using extended asm or a mixture of basic
asm and C code may appear to work, they cannot be depended upon to work
reliably and are not supported."

[1] http://infocenter.arm.com/help/topic/com.arm.doc.dui0774g/jhg1476893564298.html
[2] https://gcc.gnu.org/onlinedocs/gcc/ARM-Function-Attributes.html

In this case it looks like the arguments are only used for sanity with
__asmeq but in the first place the original commit for trusted
foundations talks about it not respecting the API so naked makes sense
but they're not making the API function naked (and the one which takes
an argument does use its argument) so this all feels a bit weird to me.

It might be worth asking the original authors on this one...

-- 
Dominique Martinet
