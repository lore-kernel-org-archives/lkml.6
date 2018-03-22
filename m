Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754934AbeCVPVF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:21:05 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:46912 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753456AbeCVPUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:20:40 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w2MFKLlx020415
X-Nifty-SrcIP: [209.85.217.176]
X-Google-Smtp-Source: AG47ELtOB26GNfIYHNytMl2ByiMWHiH37SI8qHKCJZo9EkuypGWMFP8KXKEX1IeWZ1Z+cYdTRp9qxQFl1+CeGI5JwAM=
MIME-Version: 1.0
In-Reply-To: <20180216202255.25307-4-ulfalizer@gmail.com>
References: <20180216202255.25307-1-ulfalizer@gmail.com> <20180216202255.25307-4-ulfalizer@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Mar 2018 00:19:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvuFG2jqqH4w53W3oXCHhQR5gZ1E+2MEemgzKfc8XmEQ@mail.gmail.com>
Message-ID: <CAK7LNATvuFG2jqqH4w53W3oXCHhQR5gZ1E+2MEemgzKfc8XmEQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] checkpatch: kconfig: prefer 'help' over '---help---'
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Robo Bot <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-17 5:22 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> IMO, we should discourage '---help---' for new help texts, even in cases
> where it would be consistent with other help texts in the file. This
> will help if we ever want to get rid of '---help---' in the future.
>
> Also simplify the code to only check for exactly '---help---'. Since
> commit c2264564df3d ("kconfig: warn of unhandled characters in Kconfig
> commands"), '---help---' is a proper keyword and can only appear in that
> form. Prior to that commit, '---help---' working was more of a syntactic
> quirk.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  scripts/checkpatch.pl | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 54b782fab4fd..2784f6ab309f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2817,7 +2817,11 @@ sub process {
>
>                                 if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
>                                         $is_start = 1;
> -                               } elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
> +                               } elsif ($lines[$ln - 1] =~ /^\+\s*(?:help|---help---)\s*$/) {
> +                                       if ($lines[$ln - 1] =~ "---help---") {
> +                                               WARN("CONFIG_DESCRIPTION",
> +                                                    "prefer 'help' over '---help---' for new help texts\n" . $herecurr);
> +                                       }
>                                         $length = -1;
>                                 }
>


I applied this, but perhaps the line number for the offending part
could be improved.

The warning looks like this.


WARNING: prefer 'help' over '---help---' for new help texts
#1109: FILE: init/Kconfig:1109:
+config SGETMASK_SYSCALL


The #1109 points to the line of the symbol start.
IMHO, it is even better to point to the '---help---' line.




-- 
Best Regards
Masahiro Yamada
