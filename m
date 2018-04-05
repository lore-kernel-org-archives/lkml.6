Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeDEVnK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 17:43:10 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:53652 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbeDEVnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 17:43:08 -0400
X-Google-Smtp-Source: AIpwx4/ODT8l18zuz1Z9uUzaIt2BsUb7rFO17pM2c/Y4YQwgDJIqXon1wPIwZ8ZUZ6aMkOvj8MCz2A==
Subject: Re: [PATCH 2/1] Kbuild: fix # escaping in .cmd files for future Make
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180325223239.14778-1-linux@rasmusvillemoes.dk>
 <20180325230918.23161-1-linux@rasmusvillemoes.dk>
 <CAK7LNASRP4nmKcTsF0QRvCOrX40MMO=FafOs+xG+UNA-b_61Dw@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1d69b982-ac3b-af0d-ae1f-16387a8be095@rasmusvillemoes.dk>
Date: Thu, 5 Apr 2018 23:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNASRP4nmKcTsF0QRvCOrX40MMO=FafOs+xG+UNA-b_61Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-26 13:48, Masahiro Yamada wrote:
> 2018-03-26 8:09 GMT+09:00 Rasmus Villemoes <linux@rasmusvillemoes.dk>:
>> The latest official Make release is 4.2.1 from mid-2016, but the current
>> git release has this relevant note in the NEWS file:
>>
>>   * WARNING: Backward-incompatibility!
>>     Number signs (#) appearing inside a macro reference or function invocation
>>     no longer introduce comments and should not be escaped with backslashes:
>>     thus a call such as:
>>       foo := $(shell echo '#')
>>     is legal.  Previously the number sign needed to be escaped, for example:
>>       foo := $(shell echo '\#')
>>     Now this latter will resolve to "\#".  If you want to write makefiles
>>     portable to both versions, assign the number sign to a variable:
>>       C := \#
>>       foo := $(shell echo '$C')
>>     This was claimed to be fixed in 3.81, but wasn't, for some reason.
>>     To detect this change search for 'nocomment' in the .FEATURES variable.
>>
>> Prepare for whatever future Make release contains that change by fixing
>> up the .cmd file escaping - without this, make always thinks the command
>> string has changed and hence rebuilds everything.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> So the previous patch made everything build, but building again
>> revealed that this central place very much also needed fixing.
>>
>>  scripts/Kbuild.include | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
>> index 065324a8046f..7a926e4688f4 100644
>> --- a/scripts/Kbuild.include
>> +++ b/scripts/Kbuild.include
>> @@ -10,6 +10,7 @@ space   := $(empty) $(empty)
>>  space_escape := _-_SPACE_-_
>>  right_paren := )
>>  left_paren := (
>> +pound := \#
>>
>>  ###
>>  # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
>> @@ -328,7 +329,7 @@ endif
>>  # (needed for make)
>>  # Replace >'< with >'\''< to be able to enclose the whole string in '...'
>>  # (needed for the shell)
>> -make-cmd = $(call escsq,$(subst \#,\\\#,$(subst $$,$$$$,$(cmd_$(1)))))
>> +make-cmd = $(call escsq,$(subst $(pound),\\$(pound),$(subst $$,$$$$,$(cmd_$(1)))))
>>
> 
> Thanks for the patch, but this changes the behavior.
> With '#' replaced with $(pound), '\\' does not escape anything,
> so it is treated as '\\'.
> 
> 
> The following keeps the current behavior:
> 
> make-cmd = $(call escsq,$(subst $(pound),\$(pound),$(subst
> $$,$$$$,$(cmd_$(1)))))
> 
> 
> 
> But, I think the following is an even better fix:
> 
> make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst
> $$,$$$$,$(cmd_$(1)))))

Makefile quoting has never been my strong suit. I actually thought I
tested my change by looking at some .o.cmd files containing \# before
and after, but I was fooled by tools/ containing and using their own
copy of make-cmd - so tools/build/Build.include will also need fixing.

Yes, writing $(pound) to the .cmd file seems like the safest choice. Do
you want me to respin or can/will you do the patch(es) yourself?

Rasmus
