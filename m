Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeERHJl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:09:41 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:63004 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:09:40 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w4I79PMS016924
X-Nifty-SrcIP: [209.85.217.175]
X-Google-Smtp-Source: AB8JxZq6yDlLnogKyjwgkBN+HhlRn2iqAd2K+4vckUly1MB1lqVaz983NxHAIUTCIYkQ+CT+tqELVtG+kmdBlJRMhu0=
MIME-Version: 1.0
In-Reply-To: <20180518062553.kodjjrlrosrg7vfq@gmail.com>
References: <20180518062553.kodjjrlrosrg7vfq@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 18 May 2018 16:08:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQaR6bLCL8cu4qbqB=oonr7kD_8XuLdG_ntRr_W_rfKUg@mail.gmail.com>
Message-ID: <CAK7LNAQaR6bLCL8cu4qbqB=oonr7kD_8XuLdG_ntRr_W_rfKUg@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/tags.sh: don't parse `ls` for $ALLSOURCE_ARCHS generation
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-18 15:25 GMT+09:00 Joey Pabalinas <joeypabalinas@gmail.com>:
> Parsing `ls` is fragile at best and _will_ fail when $tree
> contains spaces. Replace this with a glob-generated string
> and directly assign it to $ALLSOURCE_ARCHS (Kconfig is
> removed as it isn't an architecture); a subshell is implied
> by $(), so `cd` doesn't affect the current working directory.
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 78e546ff689c2d5f40..e4aba2983f6272fc44 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -29,14 +29,12 @@ fi
>  ignore="$ignore ( -path ${tree}tools ) -prune -o"
>
>  # Find all available archs
>  find_all_archs()
>  {
> -       ALLSOURCE_ARCHS=""
> -       for arch in `ls ${tree}arch`; do
> -               ALLSOURCE_ARCHS="${ALLSOURCE_ARCHS} "${arch##\/}
> -       done
> +       ALLSOURCE_ARCHS="$(cd "${tree}arch/" && echo *)"
> +       ALLSOURCE_ARCHS="${ALLSOURCE_ARCHS/Kconfig}"
>  }
>
>  # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
>  if [ "${ALLSOURCE_ARCHS}" = "" ]; then
>         ALLSOURCE_ARCHS=${SRCARCH}
> --
> 2.17.0.rc1.35.g90bbd502d54fe92035.dirty
>


I do not like hard-coding the file(s) in arch/.

Don't you have an idea to list only directories?
'find -type d' or 'ls -F' or something?


For example, the following worked for me, I wonder
if there is a cleverer way...


# Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
if [ "${ALLSOURCE_ARCHS}" = "" ]; then
        ALLSOURCE_ARCHS=${SRCARCH}
elif [ "${ALLSOURCE_ARCHS}" = "all" ]; then
        ALLSOURCE_ARCHS="$(cd "${tree}arch" && ls -1 -F | sed -n 's:/$::p')"
fi







-- 
Best Regards
Masahiro Yamada
