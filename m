Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeERFrW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:47:22 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:28608 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERFrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:47:21 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w4I5lDQi028033
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AB8JxZqDGILrsVLDwL1qwOoQtRpYJiBNANu1PaQAhqgBX3W0ZKqOELOfD7iK2g6irOpRbROMVmlZdpf8fW3muKKRlC8=
MIME-Version: 1.0
In-Reply-To: <20180516001311.ng6wyxdjqty5ef5j@gmail.com>
References: <20180516001311.ng6wyxdjqty5ef5j@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 18 May 2018 14:46:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQdF-q0Xtx5wkHsRLSrVAGgU5oeo9BtbPaujDdq08sFfA@mail.gmail.com>
Message-ID: <CAK7LNAQdF-q0Xtx5wkHsRLSrVAGgU5oeo9BtbPaujDdq08sFfA@mail.gmail.com>
Subject: Re: [PATCH] scripts/tags.sh: don't rely on parsing `ls` for
 $ALLSOURCE_ARCHS generation
To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-16 9:13 GMT+09:00 Joey Pabalinas <joeypabalinas@gmail.com>:
> Parsing `ls` is fragile at best and _will_ fail when $tree
> contains spaces. Replace this with a glob-generated string
> and directly assign it to $ALLSOURCE_ARCHS; use a subshell
> so `cd` doesn't affect the current working directory.
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>
>  1 file changed, 1 insertion(+), 4 deletions(-)


Andrew picked it up, but this patch is *bad*

You missed arch/Kconfig.

$(cd "${tree}arch/" && echo *)
contains Kconfig, but it is not arch.





> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 78e546ff689c2d5f40..b84acf8889fe836c60 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -29,14 +29,11 @@ fi
>  ignore="$ignore ( -path ${tree}tools ) -prune -o"
>
>  # Find all available archs
>  find_all_archs()
>  {
> -       ALLSOURCE_ARCHS=""
> -       for arch in `ls ${tree}arch`; do
> -               ALLSOURCE_ARCHS="${ALLSOURCE_ARCHS} "${arch##\/}
> -       done
> +       ALLSOURCE_ARCHS="$( (cd "${tree}arch/" && echo *) )"
>  }
>
>  # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
>  if [ "${ALLSOURCE_ARCHS}" = "" ]; then
>         ALLSOURCE_ARCHS=${SRCARCH}
> --
> 2.17.0.rc1.35.g90bbd502d54fe92035.dirty
>



-- 
Best Regards
Masahiro Yamada
