Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeDON3W (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 09:29:22 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:30872 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeDON3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 09:29:20 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w3FDT3Pp025443
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AIpwx4/e6vmx3gnbM9veS+LJLSpE94j2nsTKO/hBTSD7KJc5wsunboP/XyZrn+vqx4S/L+QjG6Jzd6mVKuV71TI71t8=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyM1uxzvU4SH3c1VYRXBRfGuqKZ4OR-O_pMoxPs7XTFug@mail.gmail.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
 <1523595999-27433-22-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5jLt4xoxXTw83-npD4WmumPzSC9WnbOkkDoR=VYa5R4rYw@mail.gmail.com> <CA+55aFyM1uxzvU4SH3c1VYRXBRfGuqKZ4OR-O_pMoxPs7XTFug@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 15 Apr 2018 22:28:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqmdABvUEtqtOWuw_5YTUaY+0P8GXnzDx+ycSavNtukA@mail.gmail.com>
Message-ID: <CAK7LNAQqmdABvUEtqtOWuw_5YTUaY+0P8GXnzDx+ycSavNtukA@mail.gmail.com>
Subject: Re: [PATCH 21/30] stack-protector: test compiler capability in
 Kconfig and drop AUTO mode
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-14 3:11 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Fri, Apr 13, 2018 at 9:41 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> How about something like this instead:
>
> I'd rather avoid the ifdef's in the Makefile if at all possible.
>
> I'd rather expose this as a Kconfig rule, and in the Kconfig just have
> an entry something like this
>
>     config STACKPROTECTOR_FLAGS
>         string
>         default "-fstack-protector-strong" if CC_STACKPROTECTOR_STRONG
>         default "-fstack-protector" if CC_STACKPROTECTOR
>         default "-fno-stack-protector" if CC_HAS_STACKPROTECTOR_NONE
>         default ""
>
> which is really simple and straightforward. In the presense of
> multiple defaults, the first is picked, so this _automatically_ does
> that whole priority ordering.
>
> And then the Makefile can just have
>
>         KBUILD_CFLAGS += $(CONFIG_STACKPROTECTOR_FLAGS)
>
> which seems much simpler.

This has a minor problem.

A string type symbol encloses a value with "..." like
CONFIG_STACKPROTECTOR_FLAGS="-fstack-protector-strong"


I think the least ugliest notation to rip off "..."
is to do like follows:

KBUILD_CFLAGS += $(CONFIG_STACKPROTECTOR_FLAGS:"%"=%)



> It also makes more complex conditionals easier (ie different compilers
> with different flags, since clang sometimes does the same thing with
> another flag name), so I'd rather see this pattern in general.
>
> I'd also *much* rather do as much as possible at Kconfig time compared
> to build time. Maybe it's just shifting the costs around, but the less
> "clever" things we ask "make" to do, the better.
>
> I find our Makefiles an odd combination of really clean and simply
> (the ones that just have "obj-$(CONFIG_X) += xyz.o" are just lovely)
> and completely incomprehensible (all of our infrastructure support for
> the simple stuff).
>
> I'd rather have more of the simple stuff in Makefiles, less of the
> complex conditionals.
>
>                   Linus


You showed a preference of the following,

CONFIG_XYZ
        bool "Enable xyz"
        depends on $(cc-option -fxyz)

CONFIG_XYZ_FLAGS
        string "-fxyz" if XYZ

Then, in Makefile

KBUILD_CFLAGS += $(CONFIG_XYZ_FLAGS:"%"=%)


Users usually say y/n to a question "do you want to use xyz?"
So, if you make this a general pattern,
it would require one additional symbol
to convert a bool symbol to a string.




I think the following was your original idea.

CONFIG_XYZ
        bool "xyz"
        depends on $(cc-option -fxyz)

Then, in Makefile

KBUILD_CFLAGS-$(CONFIG_XYZ) += -fxyz



Both notations have pros/cons, but
I slightly prefer the latter at the moment of time.




There are some complicated cases such as stack protector flags.


Your idea,

config STACKPROTECTOR_FLAGS
        string
        default "-fstack-protector-strong" if CC_STACKPROTECTOR_STRONG
        default "-fstack-protector" if CC_STACKPROTECTOR
        default "-fno-stack-protector" if CC_HAS_STACKPROTECTOR_NONE
        default ""

works fine since the first visible default is picked.




In my Makefile ...

stackp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
stackp-flags-$(CONFIG_CC_STACKPROTECTOR)          := -fstack-protector
stackp-flags-$(CONFIG_CC_STACKPROTECTOR_STRONG)   := -fstack-protector-strong

KBUILD_CFLAGS += $(stackp-flags-y)



the last one is picked.


IMHO, they are tied in terms of "cleanness".



Perhaps I may miss something, but we will have more time
to consider which approach is better.


-- 
Best Regards
Masahiro Yamada
