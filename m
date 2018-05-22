Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeEVFi6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 01:38:58 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:29573 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeEVFiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 01:38:55 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w4M5ccXh028010
X-Nifty-SrcIP: [209.85.213.43]
X-Google-Smtp-Source: AB8JxZrDlNBWwuh6dB13/+ergLju28VxlzsyGaqmbGscV96VuaVk6a/YrtvBqkjcPDKmMDYpcM0NND2zki89X2IXyxw=
MIME-Version: 1.0
In-Reply-To: <CAK7LNARZaQK6xojz7GHEb1+-aHckJnR=tA=HJXiQaJ3AwypM-g@mail.gmail.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
 <20180517175156.4c4246f6@roar.ozlabs.ibm.com> <CAK7LNARZaQK6xojz7GHEb1+-aHckJnR=tA=HJXiQaJ3AwypM-g@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 22 May 2018 14:37:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQNboP7=31eJWSndNdwJH6+u62PoCCdMN3jAjgRQnaMA@mail.gmail.com>
Message-ID: <CAK7LNATQNboP7=31eJWSndNdwJH6+u62PoCCdMN3jAjgRQnaMA@mail.gmail.com>
Subject: Re: [PATCH v4 00/31] kconfig: move compiler capability tests to Kconfig
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi reviewers,


2018-05-17 23:22 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2018-05-17 16:51 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
>> On Thu, 17 May 2018 15:16:39 +0900
>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>>
>>> [Introduction]
>>>
>>> The motivation of this work is to move the compiler option tests to
>>> Kconfig from Makefile.  A number of kernel features require the
>>> compiler support.  Enabling such features blindly in Kconfig ends up
>>> with a lot of nasty build-time testing in Makefiles.  If a chosen
>>> feature turns out unsupported by the compiler, what the build system
>>> can do is either to disable it (silently!) or to forcibly break the
>>> build, despite Kconfig has let the user to enable it.  By moving the
>>> compiler capability tests to Kconfig, Kconfig entries will be visible
>>> only when they are available.
>>>
>>> [Major Changes in V4]
>>
>> Do you have a git tree for v4? I can test it with the powerpc patches.
>>
>> The new scripting capability in kconfig has allowed us to already
>> improve the config process on powerpc:
>>
>> https://marc.info/?l=linuxppc-embedded&m=152648110727868&w=2
>>
>> I'm sure there's more clever things we can do with it but I haven't
>> had time to think about it yet. One thing that comes to mind is that
>> It might be nice to show the option as disabled, then the user could
>> upgrade their compiler to get the options they want.
>>
>> Anyway v3 worked fine for me, the documentation is really nice, I
>> could implement the above patch without any problem despite being a
>> kbuild dummy. Thanks for the series, ack from me.
>
>
> For easier review and test,
> I pushed v4 to the following branch:
>
>
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> kconfig-shell-v4
>



Planned change for v5
---------------------

I am thinking of more simplification for v5.
This is my thought.


V4 supported the _lazy_ expansion and 'if' function.


If you have ever looked into GNU Make source code,
you may know some functions lazily expand arguments.

https://git.savannah.gnu.org/cgit/make.git/tree/src/function.c#n2339


"foreach", "if", "or", "and" are specified with "EXP? = 0".

Those 4 functions expand arguments as-needed.

For example,

$(if $(cond),$(yes-case),$(no-case))


The 'if' function receive arguments before expansion,
then expands $(cond) first.

$(yes-case) is expanded only when $(cond)
turns out to be a non-empty string.
In this case, $(no-case) is not evaluated at all.


$(error msg), if it is evaluated,
immediately terminates Makefile parsing



That's why $(error ) in Makefile are generally used
in the either of the following forms:

ifeq ...
  $(error blah blah)
endif

  OR

$(if $(cond),$(error blah blah))





This does not work in user-defined functions.

$(call my-func,$(cond),$(error blah blah))


This always terminates parsing regardless of $(cond).

Because the 'call' function is specified with "EXP? = 1",
arguments are expanded (i.e. evaluated)
before they are passed to the 'call' function.


Let's say, you implemented your helper macros based on the
'if' built-in function, like follows:

# return $(2) or $(3), depending on the gcc version.
gcc-ifversion = $(if $(shell test $(gcc-version) -ge $(1) && echo y),$(2),$(3))


In this case, both $(2) and $(3) are evaluated
before the condition part is checked.
So, we end up with unneeded calculation
where we know $(2) and $(3) are exclusively used.


We can exploit the laziness
only when we use the 'if' function in raw form.
This use cases are limited.

We use helper macros anyway,
and the advantage of the lazy expansion disappear
in user-defined functions.


After consideration, I am reluctant to implement the lazy expansion
(at least until we find it is necessary).

To keep the source code simple,
I do not want to implement what we may or may not need.
At this moment, I am not so sure whether it is useful.


So, here is a planned change in v5:

Kconfig expands arguments before passing them to a function.

This means,
$(error blah blah) would never be useful.


I will remove "error" and "warning" built-in functions.

Instead, I will add "error-on" and "warning-on" built-in functions.

 -  $(error-on,<cond>,<message>)

   If <cond> contains any character,
   it terminates file parsing, showing <message> to stderr.

 -  $(warning-on,<cond>,<message>)

   If <cond> contains any character,
   show <message> to stderr.


I will remove 'if' function too.
If we give up its laziness, we can implement it as
a user-defined function.




-- 
Best Regards
Masahiro Yamada
