Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeBTTzA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:55:00 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36059 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbeBTTy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:54:59 -0500
X-Google-Smtp-Source: AH8x2265xa7sLnkZ1RzowQLGRvwEi1sZUqFrz95JzmAPpwW+ii4qGOxif2Efqih5wuZ4S/PNZZOsN/unCv2oZOVTJC0=
MIME-Version: 1.0
In-Reply-To: <1519126829-7257-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519126829-7257-1-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Tue, 20 Feb 2018 20:54:58 +0100
Message-ID: <CAFkk2KRbErqLGspp9Th9J+nGzJffxpmiZ81b6jqe-dNH9SJ3ig@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Don't leak choice names during parsing
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 12:40 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The named choice is not used in the kernel tree, but if it were used,
> it would not be freed.
>
> The intention of the named choice can be seen in the log of
> commit 5a1aa8a1aff6 ("kconfig: add named choice group").
>
> There is room for argument if this is useful in practice, but anyway
> I am fixing the memory leak.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/kconfig/zconf.y | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
> index 4be9805..4893676 100644
> --- a/scripts/kconfig/zconf.y
> +++ b/scripts/kconfig/zconf.y
> @@ -276,6 +276,7 @@ choice: T_CHOICE word_opt T_EOL
>         sym->flags |= SYMBOL_AUTO;
>         menu_add_entry(sym);
>         menu_add_expr(P_CHOICE, NULL, NULL);
> +       free($2);
>         printd(DEBUG_PARSE, "%s:%d:choice\n", zconf_curname(), zconf_lineno());
>  };
>
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>

Only place I've seen named choices in practice is in the esp-idf
project. Not sure what they're using them for.

They were handy for writing tests too. :P

Cheers,
Ulf
