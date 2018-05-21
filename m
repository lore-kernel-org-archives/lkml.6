Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeEUEt6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:49:58 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:26919 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeEUEtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:49:46 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w4L4nejt017896
X-Nifty-SrcIP: [209.85.217.180]
X-Google-Smtp-Source: AB8JxZpyNhQZRdTTX91B1Xj2AH5eIzIZp7IPY0RtoUvwjbZzLxj8od6tdN2UmICBQ8VQvafejLJQZD3LqdPrLq0gEzo=
MIME-Version: 1.0
In-Reply-To: <7819f81c-2de6-4202-1349-ae4ce01caa26@infradead.org>
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
 <1526804213-8238-6-git-send-email-yamada.masahiro@socionext.com> <7819f81c-2de6-4202-1349-ae4ce01caa26@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 21 May 2018 13:48:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARzdUZ3=PWwM_SC-t6XEoCgGEBfh4kj_KMv9WUquAHJ0g@mail.gmail.com>
Message-ID: <CAK7LNARzdUZ3=PWwM_SC-t6XEoCgGEBfh4kj_KMv9WUquAHJ0g@mail.gmail.com>
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

2018-05-21 8:41 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 05/20/2018 01:16 AM, Masahiro Yamada wrote:
>> Building nconf requires ncurses, but its presence is not checked.
>> Check and configure necessary packages by a shell script like the
>> other GUI frontends.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>
>> diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
>> new file mode 100644
>> index 0000000..8eb7948
>> --- /dev/null
>> +++ b/scripts/kconfig/nconf-cfg.sh
>> @@ -0,0 +1,34 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +PKG="ncursesw menuw panelw"
>> +PKG2="ncurses menu panel"
>> +
>> +if pkg-config --exists $PKG; then
>> +     echo libs=\"$(pkg-config --libs $PKG)\"
>> +     exit 0
>> +fi
>> +
>> +if pkg-config --exists $PKG2; then
>> +     echo libs=\"$(pkg-config --libs $PKG2)\"
>> +     exit 0
>> +fi
>> +
>
> I guess this one needs clags, especially -I, like the mconf patch contains...



I thought so.

But, the current scripts/kconfig/Makefile
adds 'pkg-config --libs' to nconf,
but does nothing about 'pkg-config --cflags' for nconf.
Therefore, I kept the current behavior just in case.


The nconfig in the current version is not working for you, right?




>
>> +# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
>> +# by pkg-config.
>> +if [ -f /usr/include/ncursesw/ncurses.h ]; then
>> +     echo libs=\"-lncursesw -lmenuw -lpanelw\"
>> +     exit 0
>> +fi
>> +
>> +if [ -f /usr/include/ncurses.h ]; then
>> +     echo libs=\"-lncurses -lmenu -lpanel\"
>> +     exit 0
>> +fi
>> +
>> +echo >&2 "*"
>> +echo >&2 "* Unable to find the ncurses."
>
>                               the ncurses package."
>
>> +echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
>> +echo >&2 "* depending on your distribution)"
>
>                                  distribution)."
>
>> +echo >&2 "*"
>> +exit 1
>>



-- 
Best Regards
Masahiro Yamada
