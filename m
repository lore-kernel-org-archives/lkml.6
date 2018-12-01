Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B42EC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0013F2146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HKvyzhXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0013F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeLBCHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:07:35 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:33103 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBCHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:07:34 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wB1Eslaa019283;
        Sat, 1 Dec 2018 23:54:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wB1Eslaa019283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543676088;
        bh=rDf4GZ4z5x6gFEFDgu4snx+tEC7lShygD3dLWuPkZ1k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HKvyzhXhSgcAwcORetovUDkRWeavstuVk3jfZM5zcHTKRItFe5WXl7kD4OJrSuTXC
         3e18EB8ULFFFkORrKKFUArf8DIAevuao3GEcXIep5Lh90pLzSRipjU37km2szTGP8G
         URltTfWhfPKJp+XQqRuU5kYUv8VlMU7Waqclj+5H/Q3R8LXZuMWqdmpxp7sWXfpPyf
         J6FVTrciSNTG9bQfH04PTL+tOtY9K9H5apzYHDWCMKmZwtWULt7opuVtZoVk7eLz89
         rUx9CxuqBua24v0aNDCfC+h5BMAUqDsgI6xuu/a7jbBzGxekkKOBeoCfla27gSsxAF
         uvVkJBvgM8uYA==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id y27so5107536vsi.1;
        Sat, 01 Dec 2018 06:54:48 -0800 (PST)
X-Gm-Message-State: AA+aEWaxYixCJT0ohNAC5oQB/+Ewj0xgPtRuJhSlsdLcS7tk9pdIMk3J
        EJHJSmQeH5+y5LFGyl1J3n9GxViJyGmXERaHzMA=
X-Google-Smtp-Source: AFSGD/U+fxReJzenjYydACTwoDx0qu98E+yJhwICWxUUoScWHsZh3wce/U9+uBgzS6SVKnvc7cnswIL8LBbcGpYRMdc=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr4286320vsb.155.1543676087186;
 Sat, 01 Dec 2018 06:54:47 -0800 (PST)
MIME-Version: 1.0
References: <1542959843-16145-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542959843-16145-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 1 Dec 2018 23:54:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvHtW9S6R7FdM10purUjWFNCFkfxDnYwnr4hB-xcMf7Q@mail.gmail.com>
Message-ID: <CAK7LNARvHtW9S6R7FdM10purUjWFNCFkfxDnYwnr4hB-xcMf7Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] modpost: refactor seen flag clearing in add_depends()
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 5:08 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> You do not need to iterate over all modules for resetting ->seen flag
> because add_depends() is only interested in modules that export symbols
> referenced from the given 'mod'.
>
> This also avoids shadowing the 'modules' parameter of add_depends().
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.



>  scripts/mod/modpost.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index c64066d..39432c2 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2229,15 +2229,15 @@ static int add_versions(struct buffer *b, struct module *mod)
>         return err;
>  }
>
> -static void add_depends(struct buffer *b, struct module *mod,
> -                       struct module *modules)
> +static void add_depends(struct buffer *b, struct module *mod)
>  {
>         struct symbol *s;
> -       struct module *m;
>         int first = 1;
>
> -       for (m = modules; m; m = m->next)
> -               m->seen = is_vmlinux(m->name);
> +       /* Clear ->seen flag of modules that own symbols needed by this. */
> +       for (s = mod->unres; s; s = s->next)
> +               if (s->module)
> +                       s->module->seen = is_vmlinux(s->module->name);
>
>         buf_printf(b, "\n");
>         buf_printf(b, "static const char __module_depends[]\n");
> @@ -2506,7 +2506,7 @@ int main(int argc, char **argv)
>                 add_retpoline(&buf);
>                 add_staging_flag(&buf, mod->name);
>                 err |= add_versions(&buf, mod);
> -               add_depends(&buf, mod, modules);
> +               add_depends(&buf, mod);
>                 add_moddevtable(&buf, mod);
>                 add_srcversion(&buf, mod);
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
