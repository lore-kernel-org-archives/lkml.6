Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA69C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E87920841
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WKzrJQTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E87920841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbeICE4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 00:56:12 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:42989 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeICE4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 00:56:11 -0400
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com [209.85.213.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w830cCLx013268;
        Mon, 3 Sep 2018 09:38:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w830cCLx013268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535935093;
        bh=UuEUtaGF2n8Is/biPI+g3R2SjlZ0EFQFeDUb8ZXx1Lw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WKzrJQTcGPDBYWHi5OVeY2agH3vZ3VFxGJ4uh24i25OYnoS7mgiVY8j1UZhEWUXLe
         mZMbDbXaofartSatHra/ZYf6z9xW98QpV0X0fPvmdqtu9o7UeeQvF1bjxGkupSNKdg
         tUc95Yp1yS2jlRLevWhuGnad8pm6FNyVr6VX7YxoBi7F6dBQpkRm4OECQH6tcjcgTP
         K2iqg9+9Fb3E9IwfY8wBSYD7QmTrbkT0ZVcCnUzcTY1W+5gX0FEgy2MqMaEs/Jkq6f
         IUVlobQ7U6nSkpfxWB+FamoJvIZsot5Ri6UloZcMTQw8XYob84fTzialpy/xi0Fs2k
         UOMizgrfZKw4A==
X-Nifty-SrcIP: [209.85.213.52]
Received: by mail-vk0-f52.google.com with SMTP id 125-v6so7201779vke.11;
        Sun, 02 Sep 2018 17:38:13 -0700 (PDT)
X-Gm-Message-State: APzg51A5jTqP6SqR8OsWxH3ld7sLLX8/QXqlZxwjstiE1OXu8HlB1gO9
        rOsWl8OHsWuDpRXj0nByDDnGyvCkbHoFvYJv08k=
X-Google-Smtp-Source: ANB0VdaQ97yiACfFeMhbxqSa0t9otMULDL2xQwcc4jYyZX1h50HNuNaptuuanQMWyPcQClo87FETUdjmeojeSL5R8xM=
X-Received: by 2002:a1f:3e47:: with SMTP id l68-v6mr14115810vka.42.1535935092014;
 Sun, 02 Sep 2018 17:38:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7103:0:0:0:0:0 with HTTP; Sun, 2 Sep 2018 17:37:31 -0700 (PDT)
In-Reply-To: <1535708095-15847-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535708095-15847-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 3 Sep 2018 09:37:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR=uLF62SmFOrY31+MKRReOUwJ2J=iK8yf=woHa5h-HYg@mail.gmail.com>
Message-ID: <CAK7LNAR=uLF62SmFOrY31+MKRReOUwJ2J=iK8yf=woHa5h-HYg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: do not require pkg-config on make {menu,n}config
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Meelis Roos <mroos@linux.ee>, Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-31 18:34 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Meelis Roos reported a {menu,n}config regression:
>
>  "I have libncurses devel package installed in the default system
>   location (as do 99%+ on actual developers probably) and in this
>   case, pkg-config is useless.  pkg-config is needed only when
>   libraries and headers are installed in non-default locations but
>   it is bad to require installation of pkg-config on all the machines
>   where make menuconfig would be possibly run."
>
> For {menu,n}config, do not use pkg-config if it is not installed.
> For {g,x}config, keep checking pkg-config since we really rely on it
> for finding the installation paths of the required packages.
>
> Fixes: 4ab3b80159d4 ("kconfig: check for pkg-config on make {menu,n,g,x}config")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---



Applied to linux-kbuild/fixes.


>  Documentation/process/changes.rst  |  2 +-
>  scripts/kconfig/Makefile           |  1 -
>  scripts/kconfig/check-pkgconfig.sh |  8 --------
>  scripts/kconfig/gconf-cfg.sh       |  7 +++++++
>  scripts/kconfig/mconf-cfg.sh       | 25 ++++++++++++++-----------
>  scripts/kconfig/nconf-cfg.sh       | 25 ++++++++++++++-----------
>  scripts/kconfig/qconf-cfg.sh       |  7 +++++++
>  7 files changed, 43 insertions(+), 32 deletions(-)
>  delete mode 100644 scripts/kconfig/check-pkgconfig.sh
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 61f918b..d1bf143 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -86,7 +86,7 @@ pkg-config
>
>  The build system, as of 4.18, requires pkg-config to check for installed
>  kconfig tools and to determine flags settings for use in
> -'make {menu,n,g,x}config'.  Previously pkg-config was being used but not
> +'make {g,x}config'.  Previously pkg-config was being used but not
>  verified or documented.
>
>  Flex
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 4a7bd21..67ed9f6 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -221,7 +221,6 @@ $(obj)/zconf.tab.o: $(obj)/zconf.lex.c
>
>  # check if necessary packages are available, and configure build flags
>  define filechk_conf_cfg
> -       $(CONFIG_SHELL) $(srctree)/scripts/kconfig/check-pkgconfig.sh; \
>         $(CONFIG_SHELL) $<
>  endef
>
> diff --git a/scripts/kconfig/check-pkgconfig.sh b/scripts/kconfig/check-pkgconfig.sh
> deleted file mode 100644
> index 7a1c40b..0000000
> --- a/scripts/kconfig/check-pkgconfig.sh
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -# Check for pkg-config presence
> -
> -if [ -z $(command -v pkg-config) ]; then
> -       echo "'make *config' requires 'pkg-config'. Please install it." 1>&2
> -       exit 1
> -fi
> diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
> index 533b3d8..480ecd8 100755
> --- a/scripts/kconfig/gconf-cfg.sh
> +++ b/scripts/kconfig/gconf-cfg.sh
> @@ -3,6 +3,13 @@
>
>  PKG="gtk+-2.0 gmodule-2.0 libglade-2.0"
>
> +if [ -z "$(command -v pkg-config)" ]; then
> +       echo >&2 "*"
> +       echo >&2 "* 'make gconfig' requires 'pkg-config'. Please install it."
> +       echo >&2 "*"
> +       exit 1
> +fi
> +
>  if ! pkg-config --exists $PKG; then
>         echo >&2 "*"
>         echo >&2 "* Unable to find the GTK+ installation. Please make sure that"
> diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
> index e6f9fac..c812872d 100755
> --- a/scripts/kconfig/mconf-cfg.sh
> +++ b/scripts/kconfig/mconf-cfg.sh
> @@ -4,20 +4,23 @@
>  PKG="ncursesw"
>  PKG2="ncurses"
>
> -if pkg-config --exists $PKG; then
> -       echo cflags=\"$(pkg-config --cflags $PKG)\"
> -       echo libs=\"$(pkg-config --libs $PKG)\"
> -       exit 0
> -fi
> +if [ -n "$(command -v pkg-config)" ]; then
> +       if pkg-config --exists $PKG; then
> +               echo cflags=\"$(pkg-config --cflags $PKG)\"
> +               echo libs=\"$(pkg-config --libs $PKG)\"
> +               exit 0
> +       fi
>
> -if pkg-config --exists $PKG2; then
> -       echo cflags=\"$(pkg-config --cflags $PKG2)\"
> -       echo libs=\"$(pkg-config --libs $PKG2)\"
> -       exit 0
> +       if pkg-config --exists $PKG2; then
> +               echo cflags=\"$(pkg-config --cflags $PKG2)\"
> +               echo libs=\"$(pkg-config --libs $PKG2)\"
> +               exit 0
> +       fi
>  fi
>
> -# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
> -# by pkg-config.
> +# Check the default paths in case pkg-config is not installed.
> +# (Even if it is installed, some distributions such as openSUSE cannot
> +# find ncurses by pkg-config.)
>  if [ -f /usr/include/ncursesw/ncurses.h ]; then
>         echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
>         echo libs=\"-lncursesw\"
> diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
> index 42f5ac7..001559e 100644
> --- a/scripts/kconfig/nconf-cfg.sh
> +++ b/scripts/kconfig/nconf-cfg.sh
> @@ -4,20 +4,23 @@
>  PKG="ncursesw menuw panelw"
>  PKG2="ncurses menu panel"
>
> -if pkg-config --exists $PKG; then
> -       echo cflags=\"$(pkg-config --cflags $PKG)\"
> -       echo libs=\"$(pkg-config --libs $PKG)\"
> -       exit 0
> -fi
> +if [ -n "$(command -v pkg-config)" ]; then
> +       if pkg-config --exists $PKG; then
> +               echo cflags=\"$(pkg-config --cflags $PKG)\"
> +               echo libs=\"$(pkg-config --libs $PKG)\"
> +               exit 0
> +       fi
>
> -if pkg-config --exists $PKG2; then
> -       echo cflags=\"$(pkg-config --cflags $PKG2)\"
> -       echo libs=\"$(pkg-config --libs $PKG2)\"
> -       exit 0
> +       if pkg-config --exists $PKG2; then
> +               echo cflags=\"$(pkg-config --cflags $PKG2)\"
> +               echo libs=\"$(pkg-config --libs $PKG2)\"
> +               exit 0
> +       fi
>  fi
>
> -# Unfortunately, some distributions (e.g. openSUSE) cannot find ncurses
> -# by pkg-config.
> +# Check the default paths in case pkg-config is not installed.
> +# (Even if it is installed, some distributions such as openSUSE cannot
> +# find ncurses by pkg-config.)
>  if [ -f /usr/include/ncursesw/ncurses.h ]; then
>         echo cflags=\"-D_GNU_SOURCE -I/usr/include/ncursesw\"
>         echo libs=\"-lncursesw -lmenuw -lpanelw\"
> diff --git a/scripts/kconfig/qconf-cfg.sh b/scripts/kconfig/qconf-cfg.sh
> index 0862e15..02ccc0a 100755
> --- a/scripts/kconfig/qconf-cfg.sh
> +++ b/scripts/kconfig/qconf-cfg.sh
> @@ -4,6 +4,13 @@
>  PKG="Qt5Core Qt5Gui Qt5Widgets"
>  PKG2="QtCore QtGui"
>
> +if [ -z "$(command -v pkg-config)" ]; then
> +       echo >&2 "*"
> +       echo >&2 "* 'make xconfig' requires 'pkg-config'. Please install it."
> +       echo >&2 "*"
> +       exit 1
> +fi
> +
>  if pkg-config --exists $PKG; then
>         echo cflags=\"-std=c++11 -fPIC $(pkg-config --cflags Qt5Core Qt5Gui Qt5Widgets)\"
>         echo libs=\"$(pkg-config --libs $PKG)\"
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
