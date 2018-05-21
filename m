Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbeEUEvw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:51:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50390 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeEUEvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:51:51 -0400
Subject: Re: [PATCH v2 5/5] kconfig: refactor ncurses package checks for
 building nconf
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
 <1526804213-8238-6-git-send-email-yamada.masahiro@socionext.com>
 <7819f81c-2de6-4202-1349-ae4ce01caa26@infradead.org>
 <CAK7LNARzdUZ3=PWwM_SC-t6XEoCgGEBfh4kj_KMv9WUquAHJ0g@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <170f1ce7-c192-96cd-f593-89f534d239bc@infradead.org>
Date: Sun, 20 May 2018 21:51:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARzdUZ3=PWwM_SC-t6XEoCgGEBfh4kj_KMv9WUquAHJ0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20/2018 09:48 PM, Masahiro Yamada wrote:
> 2018-05-21 8:41 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>> On 05/20/2018 01:16 AM, Masahiro Yamada wrote:
>>> Building nconf requires ncurses, but its presence is not checked.
>>> Check and configure necessary packages by a shell script like the
>>> other GUI frontends.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>
>>> diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
>>> new file mode 100644
>>> index 0000000..8eb7948
>>> --- /dev/null
>>> +++ b/scripts/kconfig/nconf-cfg.sh
>>> @@ -0,0 +1,34 @@
>>> +#!/bin/sh
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +PKG="ncursesw menuw panelw"
>>> +PKG2="ncurses menu panel"
>>> +
>>> +if pkg-config --exists $PKG; then
>>> +     echo libs=\"$(pkg-config --libs $PKG)\"
>>> +     exit 0
>>> +fi
>>> +
>>> +if pkg-config --exists $PKG2; then
>>> +     echo libs=\"$(pkg-config --libs $PKG2)\"
>>> +     exit 0
>>> +fi
>>> +
>>
>> I guess this one needs clags, especially -I, like the mconf patch contains...
> 
> 
> 
> I thought so.
> 
> But, the current scripts/kconfig/Makefile
> adds 'pkg-config --libs' to nconf,
> but does nothing about 'pkg-config --cflags' for nconf.
> Therefore, I kept the current behavior just in case.
> 
> 
> The nconfig in the current version is not working for you, right?

That's correct.


Info:

$ make ARCH=x86_64 O=xx64 nconfig
make[1]: Entering directory '/home/rdunlap/lnx/next/linux-next-20180517/xx64'
  GEN     ./Makefile
  UPD     scripts/kconfig/.nconf-cfg
  HOSTCC  scripts/kconfig/nconf.o
In file included from ../scripts/kconfig/nconf.c:15:0:
../scripts/kconfig/nconf.h:19:18: fatal error: menu.h: No such file or directory
 #include <menu.h>
                  ^
compilation terminated.
scripts/Makefile.host:107: recipe for target 'scripts/kconfig/nconf.o' failed
make[2]: *** [scripts/kconfig/nconf.o] Error 1
/home/rdunlap/lnx/next/linux-next-20180517/Makefile:525: recipe for target 'nconfig' failed
make[1]: *** [nconfig] Error 2
make[1]: Leaving directory '/home/rdunlap/lnx/next/linux-next-20180517/xx64'
Makefile:146: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2


xx64/scripts/kconfig/.nconf-cfg contains:
libs="-lncursesw -lmenuw -lpanelw"


>>> +# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
>>> +# by pkg-config.
>>> +if [ -f /usr/include/ncursesw/ncurses.h ]; then
>>> +     echo libs=\"-lncursesw -lmenuw -lpanelw\"
>>> +     exit 0
>>> +fi
>>> +
>>> +if [ -f /usr/include/ncurses.h ]; then
>>> +     echo libs=\"-lncurses -lmenu -lpanel\"
>>> +     exit 0
>>> +fi
>>> +
>>> +echo >&2 "*"
>>> +echo >&2 "* Unable to find the ncurses."
>>
>>                               the ncurses package."
>>
>>> +echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
>>> +echo >&2 "* depending on your distribution)"
>>
>>                                  distribution)."
>>
>>> +echo >&2 "*"
>>> +exit 1
>>>
> 
> 
> 


-- 
~Randy
