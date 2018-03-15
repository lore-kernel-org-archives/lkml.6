Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeCOFvl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 01:51:41 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:53920 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOFvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 01:51:39 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w2F5pGK0028439
X-Nifty-SrcIP: [209.85.213.51]
X-Google-Smtp-Source: AG47ELu158x4gW0JiGozteNGeyWp++Vppvs6QILOP59Z8154IYsEpsMyTAAwrr+zVSfN5rb06BEtIoFQ5mn9I5XXmaA=
MIME-Version: 1.0
In-Reply-To: <9e9438b0-568a-8dc0-dad6-d29b6e39e53a@infradead.org>
References: <9e9438b0-568a-8dc0-dad6-d29b6e39e53a@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 15 Mar 2018 14:50:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxcVRvhJn6GQVdLLuEq0sJEUcfwkbMpmx9j9nbjscQRg@mail.gmail.com>
Message-ID: <CAK7LNAQxcVRvhJn6GQVdLLuEq0sJEUcfwkbMpmx9j9nbjscQRg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: check for pkg-config on make {menu,n,g,x}config
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-13 11:30 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Each of 'make {menu,n,g,x}config' uses (needs) pkg-config to make sure
> that other required files are present, but none of these check that
> pkg-config itself is present.  Add a check for all 4 of these targets.
>
> Fixes kernel bugzilla #77511:
> https://bugzilla.kernel.org/show_bug.cgi?id=77511
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: use 'command -v' instead of 'which'
>
> I'm also OK with just documenting the pkg-config requirement in
> Documentation/Changes (= Documentation/process/changes.rst).
>
>  scripts/kconfig/Makefile           |   15 ++++++++++++++-
>  scripts/kconfig/check-pkgconfig.sh |   12 ++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> --- lnx-416-rc3.orig/scripts/kconfig/Makefile
> +++ lnx-416-rc3/scripts/kconfig/Makefile
> @@ -160,6 +160,9 @@ help:
>         @echo  '  xenconfig       - Enable additional options for xen dom0 and guest kernel support'
>         @echo  '  tinyconfig      - Configure the tiniest possible kernel'
>
> +# pkg-config check
> +check-pkgconfig  := $(srctree)/$(src)/check-pkgconfig.sh
> +
>  # lxdialog stuff
>  check-lxdialog  := $(srctree)/$(src)/lxdialog/check-lxdialog.sh
>
> @@ -205,7 +208,17 @@ $(addprefix $(obj)/, mconf.o $(lxdialog)
>  $(obj)/dochecklxdialog:
>         $(Q)$(CONFIG_SHELL) $(check-lxdialog) -check $(HOSTCC) $(HOST_EXTRACFLAGS) $(HOSTLOADLIBES_mconf)
>
> -always := dochecklxdialog
> +# Check that we have pkg-config (used by each of menu/n/g/xconfig)
> +PHONY += $(obj)/docheckpkgconfig
> +$(addprefix $(obj)/, mconf.o): $(obj)/docheckpkgconfig
> +$(addprefix $(obj)/, nconf.o): $(obj)/docheckpkgconfig
> +$(addprefix $(obj)/, gconf.o): $(obj)/docheckpkgconfig
> +$(addprefix $(obj)/, qconf.o): $(obj)/docheckpkgconfig
> +
> +$(obj)/docheckpkgconfig:
> +       $(Q)$(CONFIG_SHELL) $(check-pkgconfig)
> +
> +always := docheckpkgconfig dochecklxdialog


I did not test this patch, but does this check work as expected?

Probably we want to run 'docheckpkgconfig'
before 'dochecklxdiag', '.tmp_gtkcheck', '.tmp_qtcheck', etc.
But, I do not see such dependencies.


Also, if we make 'pkg-config' mandatory,
should we entirely drop fall-back logics like follows?

https://github.com/torvalds/linux/blob/v4.16-rc5/scripts/kconfig/lxdialog/check-lxdialog.sh#L10
https://github.com/torvalds/linux/blob/v4.16-rc5/scripts/kconfig/lxdialog/check-lxdialog.sh#L29
https://github.com/torvalds/linux/blob/v4.16-rc5/scripts/kconfig/Makefile#L230


What do you think?


>  # Add environment specific flags
>  HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCC) $(HOSTCFLAGS))
> --- /dev/null
> +++ lnx-416-rc3/scripts/kconfig/check-pkgconfig.sh
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
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
