Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeETXcL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 19:32:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49488 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeETXcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 19:32:09 -0400
Subject: Re: [PATCH v2 5/5] kconfig: refactor ncurses package checks for
 building nconf
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc: "Luis R . Rodriguez" <mcgrof@suse.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
 <1526804213-8238-6-git-send-email-yamada.masahiro@socionext.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ddb1db4-97e5-44a0-e154-be1140fffa16@infradead.org>
Date: Sun, 20 May 2018 16:31:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526804213-8238-6-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20/2018 01:16 AM, Masahiro Yamada wrote:
> Building nconf requires ncurses, but its presence is not checked.
> Check and configure necessary packages by a shell script like the
> other GUI frontends.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Add fallback code in case distributions cannot find
>     ncurses by pkg-config.
> 

Hi,

Patch 4/5 for mconf works for me, but this one is failing.


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

There are several menu.h files in /usr/include:
$ find . -name menu.h
./ncurses6/ncursesw/menu.h
./ncurses6/ncurses/menu.h
./ncursesw/menu.h
./claws-mail/gtk/menu.h
./ncurses/menu.h


>  scripts/kconfig/Makefile     | 16 ++++++++--------
>  scripts/kconfig/nconf-cfg.sh | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 8 deletions(-)
>  create mode 100644 scripts/kconfig/nconf-cfg.sh
> 
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 25a3d25..b90e801 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -176,15 +176,12 @@ help:
>  # ===========================================================================
>  # Shared Makefile for the various kconfig executables:
>  # conf:	  Used for defconfig, oldconfig and related targets
> -# nconf:  Used for the nconfig target.
> -#         Utilizes ncurses
>  # object files used by all kconfig flavours
>  
>  conf-objs	:= conf.o  zconf.tab.o
> -nconf-objs     := nconf.o zconf.tab.o nconf.gui.o
>  kxgettext-objs	:= kxgettext.o zconf.tab.o
>  
> -hostprogs-y := conf nconf kxgettext
> +hostprogs-y := conf kxgettext
>  
>  targets		+= zconf.lex.c
>  clean-files	+= gconf.glade.h
> @@ -199,10 +196,13 @@ HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTC
>  HOSTCFLAGS_zconf.lex.o	:= -I$(src)
>  HOSTCFLAGS_zconf.tab.o	:= -I$(src)
>  
> -HOSTLOADLIBES_nconf	= $(shell \
> -				pkg-config --libs menuw panelw ncursesw 2>/dev/null \
> -				|| pkg-config --libs menu panel ncurses 2>/dev/null \
> -				|| echo "-lmenu -lpanel -lncurses"  )
> +# nconf: Used for the nconfig target based on ncurses
> +hostprogs-y	+= nconf
> +nconf-objs	:= nconf.o zconf.tab.o nconf.gui.o
> +
> +HOSTLOADLIBES_nconf	= $(shell . $(obj)/.nconf-cfg && echo $$libs)
> +
> +$(obj)/nconf.o: $(obj)/.nconf-cfg
>  
>  # mconf: Used for the menuconfig target based on lxdialog
>  hostprogs-y	+= mconf
> diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
> new file mode 100644
> index 0000000..8eb7948
> --- /dev/null
> +++ b/scripts/kconfig/nconf-cfg.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +PKG="ncursesw menuw panelw"
> +PKG2="ncurses menu panel"
> +
> +if pkg-config --exists $PKG; then
> +	echo libs=\"$(pkg-config --libs $PKG)\"
> +	exit 0
> +fi
> +
> +if pkg-config --exists $PKG2; then
> +	echo libs=\"$(pkg-config --libs $PKG2)\"
> +	exit 0
> +fi
> +
> +# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
> +# by pkg-config.
> +if [ -f /usr/include/ncursesw/ncurses.h ]; then
> +	echo libs=\"-lncursesw -lmenuw -lpanelw\"
> +	exit 0
> +fi
> +
> +if [ -f /usr/include/ncurses.h ]; then
> +	echo libs=\"-lncurses -lmenu -lpanel\"
> +	exit 0
> +fi
> +
> +echo >&2 "*"
> +echo >&2 "* Unable to find the ncurses."
> +echo >&2 "* Install ncurses (ncurses-devel or libncurses-dev"
> +echo >&2 "* depending on your distribution)"
> +echo >&2 "*"
> +exit 1
> 


-- 
~Randy
