Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeENAMz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 20:12:55 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:50546 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeENAMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 20:12:53 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4E0ClPv006894
X-Nifty-SrcIP: [209.85.217.173]
X-Google-Smtp-Source: AB8JxZqG3WIhUPfntDpOzcqYiLRUHsIcljAkkzzVdXXs7ZzoeH5VzYocBKz4yg7rdI5WWtnqZr+YwjXwaSnySb1ae7I=
MIME-Version: 1.0
In-Reply-To: <1525859440-29583-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525859440-29583-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 14 May 2018 09:12:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASbMy20N_FwDwcbakUqNJ9wH6ruar3WrP1RAL46Ne5_9w@mail.gmail.com>
Message-ID: <CAK7LNASbMy20N_FwDwcbakUqNJ9wH6ruar3WrP1RAL46Ne5_9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] modpost: pass struct elf_info pointer to get_modinfo()
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-09 18:50 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> get_(next_)modinfo takes a pointer and length pair of the .modinfo
> section.  Instead, pass struct elf_info pointer to reduce the number
> of function arguments.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Series, applied to linux-kbuild.


>  scripts/mod/modpost.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index bc71925..37a6a0b4 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -724,16 +724,17 @@ static char *next_string(char *string, unsigned long *secsize)
>         return string;
>  }
>
> -static char *get_next_modinfo(void *modinfo, unsigned long modinfo_len,
> -                             const char *tag, char *info)
> +static char *get_next_modinfo(struct elf_info *info, const char *tag,
> +                             char *prev)
>  {
>         char *p;
>         unsigned int taglen = strlen(tag);
> -       unsigned long size = modinfo_len;
> +       char *modinfo = info->modinfo;
> +       unsigned long size = info->modinfo_len;
>
> -       if (info) {
> -               size -= info - (char *)modinfo;
> -               modinfo = next_string(info, &size);
> +       if (prev) {
> +               size -= prev - modinfo;
> +               modinfo = next_string(prev, &size);
>         }
>
>         for (p = modinfo; p; p = next_string(p, &size)) {
> @@ -743,11 +744,10 @@ static char *get_next_modinfo(void *modinfo, unsigned long modinfo_len,
>         return NULL;
>  }
>
> -static char *get_modinfo(void *modinfo, unsigned long modinfo_len,
> -                        const char *tag)
> +static char *get_modinfo(struct elf_info *info, const char *tag)
>
>  {
> -       return get_next_modinfo(modinfo, modinfo_len, tag, NULL);
> +       return get_next_modinfo(info, tag, NULL);
>  }
>
>  /**
> @@ -1951,7 +1951,7 @@ static void read_symbols(char *modname)
>                 mod->skip = 1;
>         }
>
> -       license = get_modinfo(info.modinfo, info.modinfo_len, "license");
> +       license = get_modinfo(&info, "license");
>         if (!license && !is_vmlinux(modname))
>                 warn("modpost: missing MODULE_LICENSE() in %s\n"
>                      "see include/linux/module.h for "
> @@ -1963,8 +1963,7 @@ static void read_symbols(char *modname)
>                         mod->gpl_compatible = 0;
>                         break;
>                 }
> -               license = get_next_modinfo(info.modinfo, info.modinfo_len,
> -                                          "license", license);
> +               license = get_next_modinfo(&info, "license", license);
>         }
>
>         for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
> @@ -1977,7 +1976,7 @@ static void read_symbols(char *modname)
>              (is_vmlinux(modname) && vmlinux_section_warnings))
>                 check_sec_ref(mod, modname, &info);
>
> -       version = get_modinfo(info.modinfo, info.modinfo_len, "version");
> +       version = get_modinfo(&info, "version");
>         if (version)
>                 maybe_frob_rcs_version(modname, version, info.modinfo,
>                                        version - (char *)info.hdr);
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
