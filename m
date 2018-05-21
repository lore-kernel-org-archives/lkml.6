Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbeEUE7N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:59:13 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:23211 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEUE7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:59:10 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4L4x1pw015694
X-Nifty-SrcIP: [209.85.217.171]
X-Google-Smtp-Source: AB8JxZrSMTsu4z3Owx61d41GtTTHTNauLzivG/HCMsBtDzm+8AzGt6UaqwSqpDewEAS3UE2O0k2d3K9gXrOKp+LFNVM=
MIME-Version: 1.0
In-Reply-To: <170f1ce7-c192-96cd-f593-89f534d239bc@infradead.org>
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
 <1526804213-8238-6-git-send-email-yamada.masahiro@socionext.com>
 <7819f81c-2de6-4202-1349-ae4ce01caa26@infradead.org> <CAK7LNARzdUZ3=PWwM_SC-t6XEoCgGEBfh4kj_KMv9WUquAHJ0g@mail.gmail.com>
 <170f1ce7-c192-96cd-f593-89f534d239bc@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 21 May 2018 13:58:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQYpfNn666z8tJUeLB53kyHdfr06HiLaAizihnuZv6cRQ@mail.gmail.com>
Message-ID: <CAK7LNAQYpfNn666z8tJUeLB53kyHdfr06HiLaAizihnuZv6cRQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kconfig: refactor ncurses package checks for
 building nconf
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-21 13:51 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 05/20/2018 09:48 PM, Masahiro Yamada wrote:
>> 2018-05-21 8:41 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>>> On 05/20/2018 01:16 AM, Masahiro Yamada wrote:
>>>> Building nconf requires ncurses, but its presence is not checked.
>>>> Check and configure necessary packages by a shell script like the
>>>> other GUI frontends.
>>>>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> ---
>>>>
>>>
>>>> diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
>>>> new file mode 100644
>>>> index 0000000..8eb7948
>>>> --- /dev/null
>>>> +++ b/scripts/kconfig/nconf-cfg.sh
>>>> @@ -0,0 +1,34 @@
>>>> +#!/bin/sh
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +PKG="ncursesw menuw panelw"
>>>> +PKG2="ncurses menu panel"
>>>> +
>>>> +if pkg-config --exists $PKG; then
>>>> +     echo libs=\"$(pkg-config --libs $PKG)\"
>>>> +     exit 0
>>>> +fi
>>>> +
>>>> +if pkg-config --exists $PKG2; then
>>>> +     echo libs=\"$(pkg-config --libs $PKG2)\"
>>>> +     exit 0
>>>> +fi
>>>> +
>>>
>>> I guess this one needs clags, especially -I, like the mconf patch contains...
>>
>>
>>
>> I thought so.
>>
>> But, the current scripts/kconfig/Makefile
>> adds 'pkg-config --libs' to nconf,
>> but does nothing about 'pkg-config --cflags' for nconf.
>> Therefore, I kept the current behavior just in case.
>>
>>
>> The nconfig in the current version is not working for you, right?
>
> That's correct.
>
>
> Info:
>
> $ make ARCH=x86_64 O=xx64 nconfig
> make[1]: Entering directory '/home/rdunlap/lnx/next/linux-next-20180517/xx64'
>   GEN     ./Makefile
>   UPD     scripts/kconfig/.nconf-cfg
>   HOSTCC  scripts/kconfig/nconf.o
> In file included from ../scripts/kconfig/nconf.c:15:0:
> ../scripts/kconfig/nconf.h:19:18: fatal error: menu.h: No such file or directory
>  #include <menu.h>
>                   ^
> compilation terminated.
> scripts/Makefile.host:107: recipe for target 'scripts/kconfig/nconf.o' failed
> make[2]: *** [scripts/kconfig/nconf.o] Error 1
> /home/rdunlap/lnx/next/linux-next-20180517/Makefile:525: recipe for target 'nconfig' failed
> make[1]: *** [nconfig] Error 2
> make[1]: Leaving directory '/home/rdunlap/lnx/next/linux-next-20180517/xx64'
> Makefile:146: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
>
>
> xx64/scripts/kconfig/.nconf-cfg contains:
> libs="-lncursesw -lmenuw -lpanelw"
>

Sorry, I mean
the nconfig in the Linus tree is not working, right?



-- 
Best Regards
Masahiro Yamada
