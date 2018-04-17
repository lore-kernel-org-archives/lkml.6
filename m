Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeDQPFw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:05:52 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:25694 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeDQPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:05:49 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w3HF5jmG029904
X-Nifty-SrcIP: [209.85.213.43]
X-Google-Smtp-Source: AIpwx48GM8Vumtr8P2K3HfkkZj75awArgVAnT3KjJ+PDBRGle4Zi9INO7TIRMKiJZM0snsWXFzpPlpA7gGA4xi514XM=
MIME-Version: 1.0
In-Reply-To: <9086cd96-bbeb-fa6e-6a62-8869ae8c7ee3@infradead.org>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
 <1523595999-27433-18-git-send-email-yamada.masahiro@socionext.com> <9086cd96-bbeb-fa6e-6a62-8869ae8c7ee3@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 18 Apr 2018 00:05:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNASXyB5ggr34eTOsw1gjEaWB9qxC31MfG4qbBtyFrBGkFg@mail.gmail.com>
Message-ID: <CAK7LNASXyB5ggr34eTOsw1gjEaWB9qxC31MfG4qbBtyFrBGkFg@mail.gmail.com>
Subject: Re: [PATCH 17/30] Documentation: kconfig: document a new Kconfig
 macro language
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-15 8:33 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 04/12/18 22:06, Masahiro Yamada wrote:
>> Add a document for the macro language introduced to Kconfig.
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
>
>                                                                may then be expanded
>
>> +further. To get the value of a variable, enclose the variable name in $( ).
>> +As a special case, single-letter variable names can omit the parentheses and is
>
>                                                                             and are
>
>> +simply referenced like $X. Unlike Make, Kconfig does not support curly braces
>> +as in ${CC}.
>> +
>> +There are two types of variables: simply expanded variables and recursively
>> +expanded variables.
>> +
>> +A simply expanded variable is defined using the := assignment operator. Its
>> +righthand side is expanded immediately upon reading the line from the Kconfig
>> +file.
>> +
>> +A recursively expanded variable is defined using the = assignment operator.
>> +Its righthand side is simply stored as the value of the variable without
>> +expanding it in any way. Instead, the expansion is performed when the variable
>> +is used.
>> +
>> +There is another type of assignment operator; += is used to append text to a
>> +variable. The righthand side of += is expanded immediately if the lefthand
>> +side was originally defined as a simple variable. Otherwise, its evaluation is
>> +deferred.
>> +
>> +
>> +Functions
>> +---------
>> +
>> +Like Make, Kconfig supports both built-in and user-defined functions. A
>> +function invocation looks much like a variable reference, but includes one or
>> +more parameters separated by commas:
>> +
>> +  $(function-name arg1, arg2, arg3)
>> +
>> +Some functions are implemented as a built-in function. Currently, Kconfig
>> +supports the following:
>> +
>> + - $(shell command)
>> +
>> +  The 'shell' function accepts a single argument that is expanded and passed
>> +  to a subshell for execution. The standard output of the command is then read
>> +  and returned as the value of the function. Every newline in the output is
>> +  replaced with a space. Any trailing newlines are deleted. The standard error
>> +  is not returned, nor is any program exit status.
>> +
>> + - $(warning text)
>> +
>> +  The 'warning' function prints its arguments to stderr. The output is prefixed
>> +  with the name of the current Kconfig file, the current line number. It
>
>                                           file and the current line number. It
>
>> +  evaluates to an empty string.
>> +
>> + - $(info text)
>> +
>> +  The 'info' function is similar to 'warning' except that it sends its argument
>> +  to stdout without any Kconfig name or line number.
>
> Are current Kconfig file name and line number available so that someone can
> construct their own $(info message) messages?

Not available for now, but it would be easy to support such special variables
that expand to the current file name, and line number.
For example,  '$(file)' and '$(lineno)' ?


>> +
>> +A user-defined function is defined by using the = operator. The parameters are
>> +referenced within the body definition with $1, $2, etc. (or $(1), $(2), etc.)
>> +In fact, a user-defined function is internally treated as a recursive variable.
>
> so the difference is just whether there are arguments?
> A recursive variable does not have arguments and a function always has at least
> one argument?

At least in my implementation, yes, they are implemented in the same way.
The difference is "what we call it".

I just called it in an intuitive name.

If there is no argument, people generally assume it is a variable.
If it takes arguments, a function.
But, in fact, they are the same.



Probably, similar situation in GNU Make.

For example, you can use $(call ...) to expand a variable

Test Makefile:


A = 1

all:
       @echo $(A)
       @echo $(call A)


Both print the value of A.








>
>> +
>> +A user-defined function is referenced in the same way as a built-in function:
>> +
>> +    $(my_func, arg0, arg1, arg2)
>
> Syntax given above is:
> +  $(function-name arg1, arg2, arg3)
>
> with no comma after the function name.  Which is it?


Sorry, no comma after the function name.

But, I personally think a comma after the function name is more consistent.




>> +
>> +Note 1:
>> +There is a slight difference in the whitespace handling of the function call
>> +between Make and Kconfig. In Make, leading whitespaces are trimmed from the
>> +first argument. So, $(info    FOO) is equivalent to $(info FOO). Kconfig keeps
>> +any leading whitespaces except the one right after the function name, which
>> +works as a separator. So, $(info    FOO) prints "   FOO" to the stdout.
>> +
>> +Note 2:
>> +In Make, a user-defined function is referenced by using a built-in function,
>> +'call', like this:
>> +
>> +    $(call my_func, arg0, arg1, arg2)
>> +
>> +However, Kconfig did not adopt this form just for the purpose of shortening the
>> +syntax.
>> +
>> +
>> +Caveats
>> +-------
>> +
>> +A variable (or function) can not be expanded across tokens. So, you can not use
>
>                             cannot                                     cannot
>
>> +a variable as a shorthand for an expression that consists of multiple tokens.
>> +The following works:
>> +
>> +    RANGE_MIN := 1
>> +    RANGE_MAX := 3
>> +
>> +    config FOO
>> +            int "foo"
>> +            range $(RANGE_MIN) $(RANGE_MAX)
>> +
>> +But, the following does not work:
>> +
>> +    RANGES := 1 3
>> +
>> +    config FOO
>> +            int "foo"
>> +            range $(RANGES)
>> +
>> +A variable can not be expanded to any keyword in Kconfig.  The following does
>
>               cannot
>
>> +not work:
>> +
>> +    MY_TYPE := tristate
>> +
>> +    config FOO
>> +            $(MY_TYPE) "foo"
>> +            default y
>> +
>> +Obviously from the design, $(shell command) is expanded in the textual
>> +substitution phase.  You can not pass symbols to the 'shell' function.
>
>                             cannot
>
>> +The following does not work as expected.
>> +
>> +    config ENDIAN_OPTION
>> +            string
>> +            default "-mbig-endian" if CPU_BIG_ENDIAN
>> +            default "-mlittle-endian" if CPU_LITTLE_ENDIAN
>> +
>> +    config CC_HAS_ENDIAN_OPTION
>> +            def_bool $(shell $(srctree)/scripts/gcc-check-option ENDIAN_OPTION)
>> +
>> +Instead, you can do like follows so that any function call is statically
>> +expanded.
>> +
>> +    config CC_HAS_ENDIAN_OPTION
>> +            bool
>
> fix indentation?

Good catch.  I will fix them all.



>> +         default $(shell $(srctree)/scripts/gcc-check-option -mbig-endian) if CPU_BIG_ENDIAN
>> +         default $(shell $(srctree)/scripts/gcc-check-option -mlittle-endian) if CPU_LITTLE_ENDIAN
>
>
> --
> ~Randy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
