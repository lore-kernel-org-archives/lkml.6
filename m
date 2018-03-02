Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425933AbeCBJor (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:44:47 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35731 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424862AbeCBJnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:43:39 -0500
X-Google-Smtp-Source: AG47ELvNSytNj5TqoYTJGp7YqS5Opye0z/uFlZvY0jcnuiBNu6YGpTtFFa20oj+dZxNIl0uDs8axhkNOniwc0U+I24I=
MIME-Version: 1.0
In-Reply-To: <1519974312-20477-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519974312-20477-1-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Fri, 2 Mar 2018 10:43:38 +0100
Message-ID: <CAFkk2KSR20LBL6ZpWh9pBfRr9ueEL4FsL=YAPhO607xXRVGNXw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix line number in recursive inclusion error message
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 8:05 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> When recursive inclusion is detected, the line number of the last
> 'included from:' is wrong.
>
> [Test Case]
>
> Kconfig:
>   -------->8--------
>   source "Kconfig2"
>   -------->8--------
>
> Kconfig2:
>   -------->8--------
>   source "Kconfig3"
>   -------->8--------
>
> Kconfig3:
>   -------->8--------
>   source "Kconfig"
>   -------->8--------
>
> [Result]
>
>   $ make allyesconfig
>   scripts/kconfig/conf  --allyesconfig Kconfig
>   Kconfig:1: recursive inclusion detected. Inclusion path:
>     current file : 'Kconfig'
>     included from: 'Kconfig3:1'
>     included from: 'Kconfig2:1'
>     included from: 'Kconfig:3'
>   scripts/kconfig/Makefile:89: recipe for target 'allyesconfig' failed
>   make[1]: *** [allyesconfig] Error 1
>   Makefile:512: recipe for target 'allyesconfig' failed
>   make: *** [allyesconfig] Error 2
>
> where we expect
>
>     current file : 'Kconfig'
>     included from: 'Kconfig3:1'
>     included from: 'Kconfig2:1'
>     included from: 'Kconfig:1'
>
> The 'iter->lineno+1' in the second fpinrtf() should be 'iter->lineno-1'.
> I refactored the code to merge two fprintf().
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/kconfig/zconf.l | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
> index 02de6fe..88b650e 100644
> --- a/scripts/kconfig/zconf.l
> +++ b/scripts/kconfig/zconf.l
> @@ -332,16 +332,12 @@ void zconf_nextfile(const char *name)
>                                 "Inclusion path:\n  current file : '%s'\n",
>                                 zconf_curname(), zconf_lineno(),
>                                 zconf_curname());
> -                       iter = current_file->parent;
> -                       while (iter && \
> -                              strcmp(iter->name,current_file->name)) {
> -                               fprintf(stderr, "  included from: '%s:%d'\n",
> -                                       iter->name, iter->lineno-1);
> +                       iter = current_file;
> +                       do {
>                                 iter = iter->parent;
> -                       }
> -                       if (iter)
>                                 fprintf(stderr, "  included from: '%s:%d'\n",
> -                                       iter->name, iter->lineno+1);
> +                                       iter->name, iter->lineno - 1);
> +                       } while (strcmp(iter->name, current_file->name));
>                         exit(1);
>                 }
>         }
> --
> 2.7.4
>

Much neater.

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>

Cheers,
Ulf
