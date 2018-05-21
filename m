Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeEUGmo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 02:42:44 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:38539 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeEUGml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 02:42:41 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4L6ga8o023636
X-Nifty-SrcIP: [209.85.217.169]
X-Google-Smtp-Source: AB8JxZqThDvUhjMcPPY4a4uDeCdW4Kua8rZA+v18DhZskU+vL8C1w9EzkYDg3/8fPuEtJqpZ+W/2HY3DAEqgqx8AiCk=
MIME-Version: 1.0
In-Reply-To: <20180521061613.GA21232@ravnborg.org>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
 <1526537830-22606-8-git-send-email-yamada.masahiro@socionext.com>
 <20180520145031.GB9826@ravnborg.org> <CAK7LNATM6s++TJ-VrbSwoMmP5FgVOmkUNGCwzZW=Re0WEr5EYQ@mail.gmail.com>
 <20180521061613.GA21232@ravnborg.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 21 May 2018 15:41:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNATw1VRjX9CcJVdAzi7YDhmMFpxmBQqs_PPSKJdMbAD=pg@mail.gmail.com>
Message-ID: <CAK7LNATw1VRjX9CcJVdAzi7YDhmMFpxmBQqs_PPSKJdMbAD=pg@mail.gmail.com>
Subject: Re: [PATCH v4 07/31] kconfig: add built-in function support
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,


2018-05-21 15:16 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:
> Hi Masahiro
>
>> >> +     char *(*func)(int argc, char *argv[], int old_argc, char *old_argv[]);
>> >> +};
>> > If a typedef was provided for the function then ...
>>
>>
>> Yes, I can do this,
>> but I may rather consider to simplify the code.
>
> Simplify is better.
>
>> > Will the following be equal:
>> >
>> >         $(foo,abc,$(x),$(y))
>> >         $(foo, abc, $(x), $(y))
>> >
>> > make is rather annoying as space is significant, but there seems no good reason
>> > for kconfig to inheritate this.
>> > So unless there are good arguments consider alloing the spaces.
>> > If the current implmentation already supports optional spaces then I just missed
>> > it whie reviewing.
>>
>>
>> I have been thinking of trimming the leading whitespaces.
>> (https://patchwork.kernel.org/patch/10405549/)
>>
>> This is trade-off vs "how to pass spaces as arguments?"
>
> Maybe allow strings to be passed enclosed in ""?
> Then it is simple to add whitespace.
>
> But the use of "" should be optional in all other cases.
> And the "" should be stripped.
>

Hmm, your suggestion is more shell-oriented parsing.


In Make, there is no concept of quoting
because it does not touch single-quote, double-quote, whitespaces etc. at all.


$(info "'@@"''  '" ' "' )

will print the message as they are.


This simplifies both the grammar and the parser implementation.

If we expand the quoting by Kconfig,
we need more careful consideration.


[1] In the following, would "hello   world" be expanded by Kconfig or by shell?
$(shell, echo "hello   world")

[2] Is a quoted comma delimiter or not?
$(if,",",$(A))


If remember I first examined shell-oriented expansion,
but I stopped.

Probably, I found it was much more complex,
then I chose Make-like simpler one.



-- 
Best Regards
Masahiro Yamada
