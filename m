Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968022AbeEYTNA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:13:00 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41733 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967752AbeEYTM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:12:58 -0400
X-Google-Smtp-Source: ADUXVKLCZUXKGXW6kBrnbnj5I4ljl+dxaBsrzY/jiUJm6+ZDuCMvNi1Qj8chFiMfu6qGYasVbIFTTRF6lY3CHYP++jk=
MIME-Version: 1.0
In-Reply-To: <20180525161051.187324-2-arnd@arndb.de>
References: <20180525161051.187324-1-arnd@arndb.de> <20180525161051.187324-2-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 May 2018 21:12:57 +0200
X-Google-Sender-Auth: HJXQhMbx_Onrth1xNEkhKswZp24
Message-ID: <CAMuHMdVsEH31x60p4wfqZsM-b1WNt39=ko8vKtYLfk2db6u5TQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: shmobile: only call secure_cntvoff_init on SMP builds
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, May 25, 2018 at 6:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The secure_cntvoff_init() function is not available without CONFIG_SMP,
> leading to a link error on shmobile:
>
> arch/arm/mach-shmobile/setup-rcar-gen2.o: In function `rcar_gen2_timer_init':
> setup-rcar-gen2.c:(.init.text+0x18): undefined reference to `secure_cntvoff_init'
>
> From the description in commit 3fd45a136ff6 ("ARM: shmobile: rcar-gen2:
> Make sure CNTVOFF is initialized on CA7/15"), I understand that we
> don't need to call it on non-SMP builds because the boot CPU is always
> initialized by common code, so we can simply avoid the reference by
> checking for CONFIG_SMP.
>
> Fixes: cad160ed0a94 ("ARM: shmobile: Convert file to use cntvoff")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> @@ -71,7 +71,8 @@ void __init rcar_gen2_timer_init(void)
>         void __iomem *base;
>         u32 freq;
>
> -       secure_cntvoff_init();
> +       if (IS_ENABLED(CONFIG_SMP))
> +               secure_cntvoff_init();

The call here is for the boot CPU, since commit 9ce3fa6816c2fb59 ("ARM:
shmobile: rcar-gen2: Add CA7 arch_timer initialization for r8a7794"), and
modified and consolidated in commit 3fd45a136ff6 mentioned above.

The call for secondary CPUs is in arch/arm/mach-shmobile/headsmp-apmu.S.

>
>         if (of_machine_is_compatible("renesas,r8a7745") ||
>             of_machine_is_compatible("renesas,r8a77470") ||

So the proper fix is to build arch/arm/common/secure_cntvoff.o
unconditionally.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
