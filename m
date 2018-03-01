Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELt24497MROQKqBK+9siAjR3qbQjP7jcFQwbeZC3BYQ7/1CRIy+p+QxQuZnqCURQWFSvewY/
ARC-Seal: i=1; a=rsa-sha256; t=1519916789; cv=none;
        d=google.com; s=arc-20160816;
        b=y8eZy0w+pP1Du8qYldgcxdubC9USfUTik6hT6Tk7LXgptad77ngsDHdXyZVTSzPWl8
         CuUIsRfsXgILzmr8JtloOwE6y+ujYVeedTlbgemYuhxWgGKtAOGjStrGrw7e6Bdq3iYw
         Kl5rF5jEDibFW6qtXvO0KU4fOBQeeBYsgdqzdHo9MME+pQfWjlQRGDhnVUhjcWE+wmTn
         1OjMAeJ32hTvzoB1aXJXwCpq71GWAkZWk8zeLahqusC5oG4EDcLI1r2DTTmSeahRj5Ik
         +P4+tOkqtsGSUj+trP5I9fQRSoXxz57XnhMStvf3Jkirv9/Kz+4j3sxppiKf+4M00rF2
         9oTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=wu+vftJ4QL/tker6DPa8XnNyBdA2YhdWyn+pK3YvYC4=;
        b=IUxyPuGXCtVYngZDoaDlVOL5dGYx2hPP/l3qdDx9Ixe5A7oOF6AeOd9KLsGmGPYOnV
         ygu6/C16j7fqGC5VUELBPFSNa7ty6BxHibSrZmxKyx7I/0xuRk8HxEaXlniDbmlwPOrI
         O2iBZNC8GHQG2FY/q9UpLsK94E7+Aa4tOhBq/LAJUHvloLTwR2+7j+jAABN6lOgi7a7g
         L56+7WAbp7ngBS3ltW3yUfYEUonLAFBMcuOvUmz0tNaOf/OSEQWCIvWeinXcgZKH7uw+
         7BONynQKZe0pdwdM0bus7TkbXArzkKVKrytmynx0HpWKzr3hEphRvGMBwLyrJwxpaeLm
         +5HA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=XR9vPiTi;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=XR9vPiTi;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w21F5x9n031077
X-Nifty-SrcIP: [209.85.217.172]
MIME-Version: 1.0
In-Reply-To: <1518806331-7101-5-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com> <1518806331-7101-5-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 2 Mar 2018 00:05:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjgqCbTO7x_8kzzfCdU6HWNyFLNZzwfU2hYRZmWHT_kw@mail.gmail.com>
Message-ID: <CAK7LNARjgqCbTO7x_8kzzfCdU6HWNyFLNZzwfU2hYRZmWHT_kw@mail.gmail.com>
Subject: Re: [PATCH 04/23] kconfig: set SYMBOL_AUTO to the symbol marked with defconfig_list
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583925561685060?=
X-GMAIL-MSGID: =?utf-8?q?1593748267649389880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-17 3:38 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The 'defconfig_list' is a weird attribute.  If the '.config' is
> missing, conf_read_simple() iterates over all visible defaults,
> then it uses the first one for which fopen() succeeds.
>
> config DEFCONFIG_LIST
>         string
>         depends on !UML
>         option defconfig_list
>         default "/lib/modules/$UNAME_RELEASE/.config"
>         default "/etc/kernel-config"
>         default "/boot/config-$UNAME_RELEASE"
>         default "$ARCH_DEFCONFIG"
>         default "arch/$ARCH/defconfig"
>
> However, like other symbols, the first visible default is always
> written out to the .config file.  This might be different from what
> has been actually used.
>
> For example, on my machine, the third one "/boot/config-$UNAME_RELEASE"
> is opened, like follows:
>
>   $ rm .config
>   $ make oldconfig 2>/dev/null
>   scripts/kconfig/conf  --oldconfig Kconfig
>   #
>   # using defaults found in /boot/config-4.4.0-112-generic
>   #
>   *
>   * Restart config...
>   *
>   *
>   * IRQ subsystem
>   *
>   Expose irq internals in debugfs (GENERIC_IRQ_DEBUGFS) [N/y/?] (NEW)
>
> However, the resulted .config file contains the first one since it is
> visible:
>
>   $ grep CONFIG_DEFCONFIG_LIST .config
>   CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
>
> In order to stop confusing people, prevent this CONFIG option from
> being written to the .config file.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


This one is almost trivial, so I will pick it up now.

Ulf, do you have any comment about this one?




> I'd like to fix the root case of this weirdness later.
> (and other 'option' attributes as well)
>
> But, this series is focusing a more important work in a bigger picture.
>
> For now, I decided to just hide CONFIG_DEFCONFIG_LIST
> from the .config file.
>
>
>  scripts/kconfig/menu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> index 9922285..36cd3e1 100644
> --- a/scripts/kconfig/menu.c
> +++ b/scripts/kconfig/menu.c
> @@ -212,6 +212,7 @@ void menu_add_option(int token, char *arg)
>                         sym_defconfig_list = current_entry->sym;
>                 else if (sym_defconfig_list != current_entry->sym)
>                         zconf_error("trying to redefine defconfig symbol");
> +               sym_defconfig_list->flags |= SYMBOL_AUTO;
>                 break;
>         case T_OPT_ENV:
>                 prop_add_env(arg);
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
