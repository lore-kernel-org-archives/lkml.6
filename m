Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932430AbeCEOuq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:50:46 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:56824 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeCEOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:50:43 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w25EoZuF001178
X-Nifty-SrcIP: [209.85.217.172]
X-Google-Smtp-Source: AG47ELubSqvh01ebr+z3NqHhY441tUEXaEGydr/FyLWUvFZ1TvhGMopeZwvjEnjzUKm4ET84Qn0R7bGnp1hmrwyyJaQ=
MIME-Version: 1.0
In-Reply-To: <20180228191805.20094-3-linux@rasmusvillemoes.dk>
References: <CA+55aFz_ww8ohU68Jz34pg_x7gpGpJ+FC-dmS_Rm_VvY01GGpg@mail.gmail.com>
 <20180228191805.20094-1-linux@rasmusvillemoes.dk> <20180228191805.20094-3-linux@rasmusvillemoes.dk>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 5 Mar 2018 23:49:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNtKdRqOkBb6E3_EiVp2kEvWTqDOAN3VXMWWTiTF_rOA@mail.gmail.com>
Message-ID: <CAK7LNASNtKdRqOkBb6E3_EiVp2kEvWTqDOAN3VXMWWTiTF_rOA@mail.gmail.com>
Subject: Re: [PATCH 3/3] fixdep: do not ignore kconfig.h
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 4:17 GMT+09:00 Rasmus Villemoes <linux@rasmusvillemoes.dk>:
> kconfig.h was excluded from consideration by fixdep by
> 6a5be57f0f00 (fixdep: fix extraneous dependencies) to avoid some false
> positive hits
>
> (1) include/config/.h
> (2) include/config/h.h
> (3) include/config/foo.h
>
> (1) occurred because kconfig.h contains the string CONFIG_ in a
> comment. However, since dee81e988674 (fixdep: faster CONFIG_ search), we
> have a check that the part after CONFIG_ is non-empty, so this does not
> happen anymore (and CONFIG_ appears by itself elsewhere, so that check
> is worthwhile).
>
> (2) comes from the include guard, __LINUX_KCONFIG_H. But with the
> previous patch, we no longer match that either.
>
> That leaves (3), which amounts to one [1] false dependency (aka stat() call
> done by make), which I think we can live with:
>
> We've already had one case [2] where the lack of include/linux/kconfig.h in
> the .o.cmd file caused a missing rebuild, and while I originally thought
> we should just put kconfig.h in the dependency list without parsing it
> for the CONFIG_ pattern, we actually do have some real CONFIG_ symbols
> mentioned in it, and one can imagine some translation unit that just
> does '#ifdef __BIG_ENDIAN' but doesn't through some other header
> actually depend on CONFIG_CPU_BIG_ENDIAN - so changing the target
> endianness could end up rebuilding the world, minus that small
> TU. Quoting Linus,
>
>   ... when missing dependencies cause a missed re-compile, the resulting
>   bugs can be _really_ subtle.
>
> [1] well, two, we now also have CONFIG_BOOGER/booger.h - we could change
> that to FOO if we care
>
> [2] https://lkml.org/lkml/2018/2/22/838
>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  scripts/basic/fixdep.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
> index 1b21870d6e7f..449b68c4c90c 100644
> --- a/scripts/basic/fixdep.c
> +++ b/scripts/basic/fixdep.c
> @@ -283,7 +283,6 @@ static int is_ignored_file(const char *s, int len)
>  {
>         return str_ends_with(s, len, "include/generated/autoconf.h") ||
>                str_ends_with(s, len, "include/generated/autoksyms.h") ||
> -              str_ends_with(s, len, "include/linux/kconfig.h") ||
>                str_ends_with(s, len, ".ver");
>  }
>
> --
> 2.15.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


The series, applied to linux-kbuild/fixes.  Thanks!


-- 
Best Regards
Masahiro Yamada
