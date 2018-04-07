Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeDGCkU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 22:40:20 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:23847 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeDGCkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 22:40:19 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w372eFwT022761
X-Nifty-SrcIP: [209.85.217.182]
X-Google-Smtp-Source: AIpwx4+7oS9Ql5Yw6LgNKqr0zdhW25xNVgkAcTkCU3kTMJPbyFIiUHcZ6OCV1JFIlDrV367lg7NvGIYFnNwj7DQ8OCs=
MIME-Version: 1.0
In-Reply-To: <20180406130030.745-1-anders.roxell@linaro.org>
References: <20180406130030.745-1-anders.roxell@linaro.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 7 Apr 2018 11:39:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQajRy=w3y_dRJN-oZoniwwfQRiGP0j0PN3Z7RzN35RdQ@mail.gmail.com>
Message-ID: <CAK7LNAQajRy=w3y_dRJN-oZoniwwfQRiGP0j0PN3Z7RzN35RdQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/memory: can't open emif-asm-offsets.s for writing
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, d-gerlach@ti.com,
        santosh shilimkar <santosh.shilimkar@oracle.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w372ePip019392

2018-04-06 22:00 GMT+09:00 Anders Roxell <anders.roxell@linaro.org>:
> Build failes due to that the directory isn't created before we execute
> the build rule.
> cc1: fatal error: can’t open ‘drivers/memory/emif-asm-offsets.s’ for
>   writing: No such file or directory compilation terminated.
> drivers/memory/Makefile.asm-offsets:2: recipe for target 'drivers/memory/emif-asm-offsets.s' failed
> make[2]: *** [drivers/memory/emif-asm-offsets.s] Error 1
> Makefile:1060: recipe for target
> 'arch/arm/mach-omap2' failed
> make[1]: *** [arch/arm/mach-omap2] Error 2
> make[1]: *** Waiting for unfinished jobs....
>
> Current code adds a file check before checking the dependency, in
> filechk it does mkdir -p $(dir $@).
>
> Fixes: 41d9d44d7258 ("ARM: OMAP2+: pm33xx-core: Add platform code needed for PM")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/memory/Makefile.asm-offsets | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/memory/Makefile.asm-offsets b/drivers/memory/Makefile.asm-offsets
> index 843ff60ccb5a..70d44a9ed32a 100644
> --- a/drivers/memory/Makefile.asm-offsets
> +++ b/drivers/memory/Makefile.asm-offsets
> @@ -1,4 +1,5 @@
>  drivers/memory/emif-asm-offsets.s: drivers/memory/emif-asm-offsets.c
> +       $(call filechk,$@)
>         $(call if_changed_dep,cc_s_c)
>
>  include/generated/ti-emif-asm-offsets.h: drivers/memory/emif-asm-offsets.s FORCE
> --
> 2.16.3


Why filechk just for creating a directory?


$(Q)mkdir $(dir $@)

is enough, but still this is a bad fix.


Generating the same object from different directories
is fragile in parallel building.




-- 
Best Regards
Masahiro Yamada
