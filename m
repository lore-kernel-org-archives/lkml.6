Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeDQPIl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:08:41 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:18108 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeDQPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:08:39 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w3HF8Ipt006008
X-Nifty-SrcIP: [209.85.217.182]
X-Google-Smtp-Source: AIpwx4+IFSj47MHIS9afgQCtQ6F2oXO2+p9mp6/wuvaMbVciFn0FUDITXkNraQS+xcrYUY+7nuq5uHST7UANaa5Nyoc=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KQu-GUcocDpRO=VZrjSXaZe8Bo-1feJwABX5PXhsYu+XA@mail.gmail.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
 <1523595999-27433-18-git-send-email-yamada.masahiro@socionext.com> <CAFkk2KQu-GUcocDpRO=VZrjSXaZe8Bo-1feJwABX5PXhsYu+XA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 18 Apr 2018 00:07:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxxNddpr2PiOR=izKuH5tQhFKP91XFzdY8i6HJ_H3Fgw@mail.gmail.com>
Message-ID: <CAK7LNAQxxNddpr2PiOR=izKuH5tQhFKP91XFzdY8i6HJ_H3Fgw@mail.gmail.com>
Subject: Re: [PATCH 17/30] Documentation: kconfig: document a new Kconfig
 macro language
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>,
        Kees Cook <keescook@chromium.org>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-15 17:08 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Fri, Apr 13, 2018 at 7:06 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Add a document for the macro language introduced to Kconfig.
>>
>> The motivation of this work is to move the compiler option tests to
>> Kconfig from Makefile.  A number of kernel features require the
>> compiler support.  Enabling such features blindly in Kconfig ends up
>> with a lot of nasty build-time testing in Makefiles.  If a chosen
>> feature turns out unsupported by the compiler, what the build system
>> can do is either to disable it (silently!) or to forcibly break the
>> build, despite Kconfig has let the user to enable it.
>>
>> This change was strongly prompted by Linus Torvalds.  You can find
>> his suggestions [1] [2] in ML.  The original idea was to add a new
>> 'option', but I found generalized text expansion would make Kconfig
>> more powerful and lovely.  While polishing up the implementation, I
>> noticed sort of similarity between Make and Kconfig.  This might be
>> too immature to be called 'language', but anyway here it is.  All
>> ideas are from Make (you can even say it is addicted), so people
>> will easily understand how it works.
>>
>> [1]: https://lkml.org/lkml/2016/12/9/577
>> [2]: https://lkml.org/lkml/2018/2/7/527
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>  Documentation/kbuild/kconfig-macro-language.txt | 179 ++++++++++++++++++++++++
>>  MAINTAINERS                                     |   2 +-
>>  2 files changed, 180 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/kbuild/kconfig-macro-language.txt
>>
>> diff --git a/Documentation/kbuild/kconfig-macro-language.txt b/Documentation/kbuild/kconfig-macro-language.txt
>> new file mode 100644
>> index 0000000..1f6281b
>> --- /dev/null
>> +++ b/Documentation/kbuild/kconfig-macro-language.txt
>> @@ -0,0 +1,179 @@
>> +Concept
>> +-------
>> +
>> +The basic idea was inspired by Make. When we look at Make, we notice sort of
>> +two languages in one. One language describes dependency graphs consisting of
>> +targets and prerequisites. The other is a macro language for performing textual
>> +substitution.
>> +
>> +There is clear distinction between the two language stages. For example, you
>> +can write a makefile like follows:
>> +
>> +    APP := foo
>> +    SRC := foo.c
>> +    CC := gcc
>> +
>> +    $(APP): $(SRC)
>> +            $(CC) -o $(APP) $(SRC)
>> +
>> +The macro language replaces the variable references with their expanded form,
>> +and handles as if the source file were input like follows:
>> +
>> +    foo: foo.c
>> +            gcc -o foo foo.c
>> +
>> +Then, Make analyzes the dependency graph and determines the targets to be
>> +updated.
>> +
>> +The idea is quite similar in Kconfig - it is possible to describe a Kconfig
>> +file like this:
>> +
>> +    CC := gcc
>> +
>> +    config CC_HAS_FOO
>> +            def_bool $(shell $(srctree)/scripts/gcc-check-foo.sh $(CC))
>> +
>> +The macro language in Kconfig processes the source file into the following
>> +intermediate:
>> +
>> +    config CC_HAS_FOO
>> +            def_bool y
>> +
>> +Then, Kconfig moves onto the evaluation stage to resolve inter-symbol
>> +dependency, which is explained in kconfig-language.txt.
>> +
>> +
>> +Variables
>> +---------
>> +
>> +Like in Make, a variable in Kconfig works as a macro variable.  A macro
>> +variable is expanded "in place" to yield a text string that may then expanded
>> +further. To get the value of a variable, enclose the variable name in $( ).
>> +As a special case, single-letter variable names can omit the parentheses and is
>> +simply referenced like $X. Unlike Make, Kconfig does not support curly braces
>> +as in ${CC}.
>
> Do we need single-letter variable names for anything? It looks like
> we're deviating
> a bit from Make behavior already.
>
> I suspect they're just a side effect of Make having automatic variables like $@.
> The Make manual discourages them otherwise:
>
> "A dollar sign followed by a character other than a dollar sign,
> open-parenthesis or
> open-brace treats that single character as the variable name. Thus, you could
> reference the variable x with `$x'. However, this practice is strongly
> discouraged,
> except in the case of the automatic variables (see section Automatic
> Variables)."
>

OK.  We do not need two ways to do the same thing.

I will consider it
although supporting single-letter variable is not costly.



-- 
Best Regards
Masahiro Yamada
