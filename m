Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeEVGBy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:01:54 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:39198 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeEVGBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:01:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4M61mAs001651
X-Nifty-SrcIP: [209.85.213.49]
X-Google-Smtp-Source: AB8JxZof+lIjcRbm2MSWcKdHt1Fe7+NIv7QFWy0BOlgbpnJNWFDK0F047lfeAWfQrAw4dDjy+qZQs+uMsvQj9qjQbz8=
MIME-Version: 1.0
In-Reply-To: <20180518115619.jqb4hqdym7fmrs2p@gmail.com>
References: <20180518115619.jqb4hqdym7fmrs2p@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 22 May 2018 15:01:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNASuhoJsaBz6RjumbQnqhtyLJGLjkhGSs5-bvDz1TOuGww@mail.gmail.com>
Message-ID: <CAK7LNASuhoJsaBz6RjumbQnqhtyLJGLjkhGSs5-bvDz1TOuGww@mail.gmail.com>
Subject: Re: [PATCH v4] scripts/tags.sh: use `find` for $ALLSOURCE_ARCHS generation
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


The commit log is wrong.


2018-05-18 20:56 GMT+09:00 Joey Pabalinas <joeypabalinas@gmail.com>:
> Parsing `ls` is fragile at best and _will_ fail when $tree
> contains spaces.

This statement is wrong.

The cause of the problem is not using whatever command you use,
but missing quoting.
The following would work even  if $tree contains spaces:

    for arch in `ls "${tree}arch"`; do


BTW, what was your motivation of this patch?

Does ${tree} contain spaces?


If the file path contains spaces, the top Makefile terminates it earlier.

Makefile:128: *** main directory cannot contain spaces nor colons.  Stop.




> Replace this with a find-generated string
> and directly assign it to $ALLSOURCE_ARCHS; a subshell is
> implied by $(), so `cd` doesn't affect the current working
> directory.


This patch no longer uses `cd`



> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 78e546ff689c2d5f40..c08347fdeef12a7621 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -26,24 +26,15 @@ else
>  fi
>
>  # ignore userspace tools
>  ignore="$ignore ( -path ${tree}tools ) -prune -o"
>
> -# Find all available archs
> -find_all_archs()
> -{
> -       ALLSOURCE_ARCHS=""
> -       for arch in `ls ${tree}arch`; do
> -               ALLSOURCE_ARCHS="${ALLSOURCE_ARCHS} "${arch##\/}
> -       done
> -}
> -
>  # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
>  if [ "${ALLSOURCE_ARCHS}" = "" ]; then
>         ALLSOURCE_ARCHS=${SRCARCH}
>  elif [ "${ALLSOURCE_ARCHS}" = "all" ]; then
> -       find_all_archs
> +       ALLSOURCE_ARCHS="$(find "${tree}arch/" -mindepth 1 -maxdepth 1 -type d -printf ' %f')"
>  fi
>
>  # find sources in arch/$ARCH
>  find_arch_sources()
>  {
> --
> 2.17.0.rc1.35.g90bbd502d54fe92035.dirty
>



-- 
Best Regards
Masahiro Yamada
