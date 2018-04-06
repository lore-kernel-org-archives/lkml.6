Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeDFDyB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 23:54:01 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23815 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbeDFDx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 23:53:59 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w363rfnl029517
X-Nifty-SrcIP: [209.85.217.179]
X-Google-Smtp-Source: AIpwx48NiITB2R5x0kAdzWK1XmXy15ArMIL5IVtm5fENI4Cb8hkQVhnZh2fWtwnMUuVvrBzf3XLI9sOMILBxTv4AqyU=
MIME-Version: 1.0
In-Reply-To: <1d69b982-ac3b-af0d-ae1f-16387a8be095@rasmusvillemoes.dk>
References: <20180325223239.14778-1-linux@rasmusvillemoes.dk>
 <20180325230918.23161-1-linux@rasmusvillemoes.dk> <CAK7LNASRP4nmKcTsF0QRvCOrX40MMO=FafOs+xG+UNA-b_61Dw@mail.gmail.com>
 <1d69b982-ac3b-af0d-ae1f-16387a8be095@rasmusvillemoes.dk>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 6 Apr 2018 12:53:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvTJJR=fa9_NyvwfX9z+f51Ha9XQzLrmVakVWUV4eAQw@mail.gmail.com>
Message-ID: <CAK7LNARvTJJR=fa9_NyvwfX9z+f51Ha9XQzLrmVakVWUV4eAQw@mail.gmail.com>
Subject: Re: [PATCH 2/1] Kbuild: fix # escaping in .cmd files for future Make
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-06 6:43 GMT+09:00 Rasmus Villemoes <linux@rasmusvillemoes.dk>:
> On 2018-03-26 13:48, Masahiro Yamada wrote:
>> 2018-03-26 8:09 GMT+09:00 Rasmus Villemoes <linux@rasmusvillemoes.dk>:
>>> The latest official Make release is 4.2.1 from mid-2016, but the current
>>> git release has this relevant note in the NEWS file:
>>>
>>>   * WARNING: Backward-incompatibility!
>>>     Number signs (#) appearing inside a macro reference or function invocation
>>>     no longer introduce comments and should not be escaped with backslashes:
>>>     thus a call such as:
>>>       foo := $(shell echo '#')
>>>     is legal.  Previously the number sign needed to be escaped, for example:
>>>       foo := $(shell echo '\#')
>>>     Now this latter will resolve to "\#".  If you want to write makefiles
>>>     portable to both versions, assign the number sign to a variable:
>>>       C := \#
>>>       foo := $(shell echo '$C')
>>>     This was claimed to be fixed in 3.81, but wasn't, for some reason.
>>>     To detect this change search for 'nocomment' in the .FEATURES variable.
>>>
>>> Prepare for whatever future Make release contains that change by fixing
>>> up the .cmd file escaping - without this, make always thinks the command
>>> string has changed and hence rebuilds everything.
>>>
>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>> ---
>>> So the previous patch made everything build, but building again
>>> revealed that this central place very much also needed fixing.
>>>
>>>  scripts/Kbuild.include | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
>>> index 065324a8046f..7a926e4688f4 100644
>>> --- a/scripts/Kbuild.include
>>> +++ b/scripts/Kbuild.include
>>> @@ -10,6 +10,7 @@ space   := $(empty) $(empty)
>>>  space_escape := _-_SPACE_-_
>>>  right_paren := )
>>>  left_paren := (
>>> +pound := \#
>>>
>>>  ###
>>>  # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
>>> @@ -328,7 +329,7 @@ endif
>>>  # (needed for make)
>>>  # Replace >'< with >'\''< to be able to enclose the whole string in '...'
>>>  # (needed for the shell)
>>> -make-cmd = $(call escsq,$(subst \#,\\\#,$(subst $$,$$$$,$(cmd_$(1)))))
>>> +make-cmd = $(call escsq,$(subst $(pound),\\$(pound),$(subst $$,$$$$,$(cmd_$(1)))))
>>>
>>
>> Thanks for the patch, but this changes the behavior.
>> With '#' replaced with $(pound), '\\' does not escape anything,
>> so it is treated as '\\'.
>>
>>
>> The following keeps the current behavior:
>>
>> make-cmd = $(call escsq,$(subst $(pound),\$(pound),$(subst
>> $$,$$$$,$(cmd_$(1)))))
>>
>>
>>
>> But, I think the following is an even better fix:
>>
>> make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst
>> $$,$$$$,$(cmd_$(1)))))
>
> Makefile quoting has never been my strong suit. I actually thought I
> tested my change by looking at some .o.cmd files containing \# before
> and after, but I was fooled by tools/ containing and using their own
> copy of make-cmd - so tools/build/Build.include will also need fixing.
>
> Yes, writing $(pound) to the .cmd file seems like the safest choice. Do
> you want me to respin or can/will you do the patch(es) yourself?
>

Can you send v2 please?

I will pick it up shortly.



-- 
Best Regards
Masahiro Yamada
