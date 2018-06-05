Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeFEGzB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:55:01 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:33009 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeFEGzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:55:00 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w556sdMp030724
X-Nifty-SrcIP: [209.85.217.180]
X-Google-Smtp-Source: ADUXVKJPzv+L8W2qu+LEVsxZp0nmH6gqdeH3d29bPiFVcowW0mc017mCGHTin8NRXC0Yno79IV6Wpsg+/43CYFLfDnM=
MIME-Version: 1.0
In-Reply-To: <f13a8e3c-ebc6-53f7-1bac-965c0f30b110@infradead.org>
References: <f13a8e3c-ebc6-53f7-1bac-965c0f30b110@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 5 Jun 2018 15:53:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASN_L0An5OBwif7S4wt5Lz54yAdSNw_8ODV0UETa+aDjw@mail.gmail.com>
Message-ID: <CAK7LNASN_L0An5OBwif7S4wt5Lz54yAdSNw_8ODV0UETa+aDjw@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: check for pkg-config on make {menu,n,g.x}config
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w556t5Db020685

Hi Randy,


2018-06-04 11:59 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Each of 'make {menu,n,g,x}config' uses (needs) pkg-config to make sure
> that other required files are present and to determine build flags
> settings, but none of these check that pkg-config itself is present.
> Add a check for all 4 of these targets and update
> Documentation/process/changes.rst to mention 'pkg-config'.
>
> Fixes kernel bugzilla #77511:
> https://bugzilla.kernel.org/show_bug.cgi?id=77511
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bjørn Forsman <bjorn.forsman@gmail.com>
> ---
> Strictly speaking, pkg-config is not required if someone is only
> using 'make {menu,n}config' since there are fallbacks for those
> two targets.
>
>  Documentation/process/changes.rst  |    8 ++++++++
>  scripts/kconfig/Makefile           |    6 ++++++
>  scripts/kconfig/check-pkgconfig.sh |   12 ++++++++++++
>  3 files changed, 26 insertions(+)
>
> --- linux-next-20180601.orig/scripts/kconfig/Makefile
> +++ linux-next-20180601/scripts/kconfig/Makefile
> @@ -214,11 +214,17 @@ $(obj)/gconf.o: $(obj)/.gconf-cfg
>  $(obj)/zconf.tab.o: $(obj)/zconf.lex.c
>
>  # check if necessary packages are available, and configure build flags
> +# pkg-config check
> +define check_pkg_config
> +       $(CONFIG_SHELL) $(srctree)/scripts/kconfig/check-pkgconfig.sh FORCE


Passing FORCE to check-pkg-config.sh strange.



How about calling your script from filechk_conf_cfg, like this?


define filechk_conf_cfg
        $(CONFIG_SHELL) $(srctree)/scripts/kconfig/check-pkgconfig.sh; \
        $(CONFIG_SHELL) $<
endef






> +endef
> +
>  define filechk_conf_cfg
>         $(CONFIG_SHELL) $<
>  endef
>
>  $(obj)/.%conf-cfg: $(src)/%conf-cfg.sh FORCE
> +       $(call check_pkg_config)
>         $(call filechk,conf_cfg)
>
>  clean-files += .*conf-cfg
> --- /dev/null
> +++ linux-next-20180601/scripts/kconfig/check-pkgconfig.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Check for pkg-config presence
> +
> +pkgcfg=`command -v pkg-config`
> +
> +if [ "$pkgcfg" = "" ]; then
> +       echo "'make *config' requires 'pkg-config'. Please install it." 1>&2
> +       exit 1          # error
> +fi
> +
> +exit 0


You can remove 'exit 0' at the end.
and move the 'pkgcfg' to the conditional line.

How about something like this?


if [ -z $(command -v pkg-config) ]; then
        echo "'make *config' requires 'pkg-config'. Please install it." 1>&2
        exit 1
fi


Thanks.



> --- linux-next-20180601.orig/Documentation/process/changes.rst
> +++ linux-next-20180601/Documentation/process/changes.rst
> @@ -81,6 +81,14 @@ The build system has, as of 4.13, switch
>  rather than incremental linking (`ld -r`) for built-in.a intermediate steps.
>  This requires binutils 2.20 or newer.
>
> +pkg-config
> +----------
> +
> +The build system, as of 4.18, requires pkg-config to check for installed
> +kconfig tools and to determine flags settings for use in
> +'make {menu,n,g,x}config'.  Previously pkg-config was being used but not
> +verified or documented.
> +
>  Flex
>  ----
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
