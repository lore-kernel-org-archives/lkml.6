Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754452AbeBLOtr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:49:47 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:18757 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeBLOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:49:44 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1CEnTJw014046
X-Nifty-SrcIP: [209.85.213.51]
X-Google-Smtp-Source: AH8x226/7T3zoUMAQKIdmJOkZD0Q9DvhpGC6vqtZYAZwXyOfR+8mgkQPO3p78fot64tPI+d90DNkO+6l87OjbCHNS58=
MIME-Version: 1.0
In-Reply-To: <fb60e245-86f2-53c6-79d8-bd395ef011dd@cn.fujitsu.com>
References: <fb60e245-86f2-53c6-79d8-bd395ef011dd@cn.fujitsu.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 12 Feb 2018 23:48:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjks+EWiKq4KkHrbQTOAYWzRku_fuj_-8dcThQB=h6PA@mail.gmail.com>
Message-ID: <CAK7LNARjks+EWiKq4KkHrbQTOAYWzRku_fuj_-8dcThQB=h6PA@mail.gmail.com>
Subject: Re: why scripts/link-vmlinux.sh has a final build of init/
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-12 13:22 GMT+09:00 Cao jin <caoj.fnst@cn.fujitsu.com>:
> Hi Masahiro-san,
>
>   As I remember, init/ is already built during recursive make, and I did
> a clean build(make mrproper, make localmodconfig) with all plugins
> included on x86_64 with following patch, the kernel can boot without any
> obvious problem. So, I don't figure out why we need this final build?
>
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index e6818b8e7141..086b2efd4d53 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -247,9 +247,6 @@ else
>         expr 0$(cat .old_version) + 1 >.version;
>  fi;
>
> -# final build of init/
> -${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init
> GCC_PLUGINS_CFLAGS="${GCC_PLUGINS_CFLAGS}"
> -
>  archive_builtin
>
>  #link vmlinux.o
>


link-vmlinux.sh increments '.version'
so it must descend into init/
to update include/generated/compile.h
and re-compile init/version.o

We do not increment '.version'
at the first descend into init/
because we never know whether the kernel
is updated or not before the final link stage.


-- 
Best Regards
Masahiro Yamada
