Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeETJp6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 05:45:58 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:47393 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeETJpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 05:45:55 -0400
Date: Sun, 20 May 2018 11:45:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] kconfig: refactor Qt package checks for building
 qconf
Message-ID: <20180520094547.GA18441@ravnborg.org>
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
 <1526804213-8238-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526804213-8238-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=c-n4J4-pAAAA:8 a=JfrnYn6hAAAA:8
        a=MsZy09slUXBRzWe7ybwA:9 a=CjuIK1q_8ugA:10 a=L0NDqeB7ZLmQzAogN4cw:22
        a=1CNFftbPRP8L7MoqJWF3:22
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro

This commit (and the rest of the series) do wonders for the
readability of the Makefile - nice work.

Some nits below.

On Sun, May 20, 2018 at 05:16:50PM +0900, Masahiro Yamada wrote:
> Currently, the necessary package checks for building qconf is
> surrounded by ifeq ($(MAKECMDGOALS),xconfig) ... endif.
> Then, Make will restart when .tmp_qtcheck is generated.
> 
> To simplify the Makefile, move the scripting to a separate file,
> and use filechk.  The shell script is executed everytime xconfig
> is run, but it is not a costly script.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> 
> Changes in v2: None
> 
>  scripts/kconfig/Makefile     | 73 +++++++++++++++++---------------------------
>  scripts/kconfig/qconf-cfg.sh | 25 +++++++++++++++
>  2 files changed, 53 insertions(+), 45 deletions(-)
>  create mode 100755 scripts/kconfig/qconf-cfg.sh
> 
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 5def877..e9a87bf 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -188,8 +188,6 @@ HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags) \
>  #         Utilizes ncurses
>  # mconf:  Used for the menuconfig target
>  #         Utilizes the lxdialog package
> -# qconf:  Used for the xconfig target
> -#         Based on Qt which needs to be installed to compile it
>  # gconf:  Used for the gconfig target
>  #         Based on GTK+ which needs to be installed to compile it
>  # object files used by all kconfig flavours
> @@ -201,14 +199,12 @@ conf-objs	:= conf.o  zconf.tab.o
>  mconf-objs     := mconf.o zconf.tab.o $(lxdialog)
>  nconf-objs     := nconf.o zconf.tab.o nconf.gui.o
>  kxgettext-objs	:= kxgettext.o zconf.tab.o
> -qconf-cxxobjs	:= qconf.o
> -qconf-objs	:= zconf.tab.o
>  gconf-objs	:= gconf.o zconf.tab.o
>  
> -hostprogs-y := conf nconf mconf kxgettext qconf gconf
> +hostprogs-y := conf nconf mconf kxgettext gconf
>  
>  targets		+= zconf.lex.c
> -clean-files	:= qconf.moc .tmp_qtcheck .tmp_gtkcheck
> +clean-files	:= .tmp_gtkcheck
>  clean-files	+= gconf.glade.h
>  clean-files     += config.pot linux.pot
>  
> @@ -228,9 +224,6 @@ HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTC
>  HOSTCFLAGS_zconf.lex.o	:= -I$(src)
>  HOSTCFLAGS_zconf.tab.o	:= -I$(src)
>  
> -HOSTLOADLIBES_qconf	= $(KC_QT_LIBS)
> -HOSTCXXFLAGS_qconf.o	= $(KC_QT_CFLAGS)
> -
>  HOSTLOADLIBES_gconf	= `pkg-config --libs gtk+-2.0 gmodule-2.0 libglade-2.0`
>  HOSTCFLAGS_gconf.o	= `pkg-config --cflags gtk+-2.0 gmodule-2.0 libglade-2.0` \
>                            -Wno-missing-prototypes
> @@ -241,34 +234,22 @@ HOSTLOADLIBES_nconf	= $(shell \
>  				pkg-config --libs menuw panelw ncursesw 2>/dev/null \
>  				|| pkg-config --libs menu panel ncurses 2>/dev/null \
>  				|| echo "-lmenu -lpanel -lncurses"  )
> -$(obj)/qconf.o: $(obj)/.tmp_qtcheck
> -
> -ifeq ($(MAKECMDGOALS),xconfig)
> -$(obj)/.tmp_qtcheck: $(src)/Makefile
> --include $(obj)/.tmp_qtcheck
> -
> -# Qt needs some extra effort...
> -$(obj)/.tmp_qtcheck:
> -	@set -e; $(kecho) "  CHECK   qt"; \
> -	if pkg-config --exists Qt5Core; then \
> -	    cflags="-std=c++11 -fPIC `pkg-config --cflags Qt5Core Qt5Gui Qt5Widgets`"; \
> -	    libs=`pkg-config --libs Qt5Core Qt5Gui Qt5Widgets`; \
> -	    moc=`pkg-config --variable=host_bins Qt5Core`/moc; \
> -	elif pkg-config --exists QtCore; then \
> -	    cflags=`pkg-config --cflags QtCore QtGui`; \
> -	    libs=`pkg-config --libs QtCore QtGui`; \
> -	    moc=`pkg-config --variable=moc_location QtCore`; \
> -	else \
> -	    echo >&2 "*"; \
> -	    echo >&2 "* Could not find Qt via pkg-config."; \
> -	    echo >&2 "* Please install either Qt 4.8 or 5.x. and make sure it's in PKG_CONFIG_PATH"; \
> -	    echo >&2 "*"; \
> -	    exit 1; \
> -	fi; \
> -	echo "KC_QT_CFLAGS=$$cflags" > $@; \
> -	echo "KC_QT_LIBS=$$libs" >> $@; \
> -	echo "KC_QT_MOC=$$moc" >> $@
> -endif
> +
> +# qconf: Used for the xconfig target based on Qt
> +hostprogs-y	+= qconf
> +qconf-cxxobjs	:= qconf.o
> +qconf-objs	:= zconf.tab.o
> +
> +HOSTLOADLIBES_qconf	= $(shell . $(obj)/.qconf-cfg && echo $$libs)
> +HOSTCXXFLAGS_qconf.o	= $(shell . $(obj)/.qconf-cfg && echo $$cflags)
Nice way to access the variables generated earlier.

> +
> +$(obj)/qconf.o: $(obj)/.qconf-cfg $(obj)/qconf.moc

qconf.moc has a dependency on qconf-cfg so the first
dependency could be dropped here I think.

> +
> +quiet_cmd_moc = MOC     $@
> +      cmd_moc = $(shell . $(obj)/.qconf-cfg && echo $$moc) -i $< -o $@
> +
> +$(obj)/%.moc: $(src)/%.h $(obj)/.qconf-cfg
> +	$(call cmd,moc)
We will in this makefile only support qconf.h => qconf.moc

So it may be simpler to read the makefile if we in the above
uses explicit filenames.

> -
> -quiet_cmd_moc = MOC     $@
> -      cmd_moc = $(KC_QT_MOC) -i $< -o $@
> -
> -$(obj)/%.moc: $(src)/%.h $(obj)/.tmp_qtcheck
> -	$(call cmd,moc)
> -
>  # Extract gconf menu items for i18n support
>  $(obj)/gconf.glade.h: $(obj)/gconf.glade
>  	$(Q)intltool-extract --type=gettext/glade --srcdir=$(srctree) \
>  	$(obj)/gconf.glade

quiet_cmd_intl = INTL    @$
      cmd_intl = $(Q)intltool-extract --type=gettext/glade --srcdir=$(srctree) $<

$(obj)/gconf.glade.h: $(obj)/gconf.glade
	$(cmd,intl)

To make this step visible in normal build

> +# check if necessary packages are available, and configure build flags
> +define filechk_conf_cfg
> +	$(CONFIG_SHELL) $<
> +endef

I cannot remember the particulars, but I think we could use $(shell ...)
in the above. If it has any positive effect is doubtful.


> +
> +$(obj)/.%conf-cfg: $(src)/%conf-cfg.sh FORCE
> +	$(call filechk,conf_cfg)
> +
> +clean-files += .*conf-cfg
> diff --git a/scripts/kconfig/qconf-cfg.sh b/scripts/kconfig/qconf-cfg.sh
> new file mode 100755
> index 0000000..0862e15
> --- /dev/null
> +++ b/scripts/kconfig/qconf-cfg.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +PKG="Qt5Core Qt5Gui Qt5Widgets"
> +PKG2="QtCore QtGui"
> +
> +if pkg-config --exists $PKG; then
> +	echo cflags=\"-std=c++11 -fPIC $(pkg-config --cflags Qt5Core Qt5Gui Qt5Widgets)\"
> +	echo libs=\"$(pkg-config --libs $PKG)\"
> +	echo moc=\"$(pkg-config --variable=host_bins Qt5Core)/moc\"
> +	exit 0
> +fi
> +
> +if pkg-config --exists $PKG2; then
> +	echo cflags=\"$(pkg-config --cflags $PKG2)\"
> +	echo libs=\"$(pkg-config --libs $PKG2)\"
> +	echo moc=\"$(pkg-config --variable=moc_location QtCore)\"
> +	exit 0
> +fi

The old code only checked ionly for Qt5Core / QtCore - so what you do here is
likely an extra improvement.
This change is not included in your changelog.

	Sam
