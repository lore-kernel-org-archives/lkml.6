Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754502AbeBGPQM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:16:12 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:20471 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754254AbeBGPQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:16:11 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w17FFsHS010465
X-Nifty-SrcIP: [209.85.217.173]
X-Google-Smtp-Source: AH8x226evHLMjwqi8+oKzERHw7aGSL8onyRqFo+pwNLp2yP9YlkalZdILSfVHcyle0RBfFpCd+2j9ZN8L0nLBUIuXRo=
MIME-Version: 1.0
In-Reply-To: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Feb 2018 00:15:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNATiaN-ELZXJH=nRgMATbbpPoT6+3sfRqhRpO7MoAkNwmg@mail.gmail.com>
Message-ID: <CAK7LNATiaN-ELZXJH=nRgMATbbpPoT6+3sfRqhRpO7MoAkNwmg@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: reduce false positives
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-01 18:48 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> Some files use both a non-devm allocation and a devm_allocation.  Don't
> complain about a free when the same function contains a non-devm
> allocation.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  scripts/coccinelle/free/devm_free.cocci |   55 +++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
> index c990d2c..b2a2cf8b 100644
> --- a/scripts/coccinelle/free/devm_free.cocci
> +++ b/scripts/coccinelle/free/devm_free.cocci
> @@ -56,9 +56,62 @@ expression x;
>   x = devm_ioport_map(...)
>  )
>
> +@safe depends on context || org || report exists@
> +expression x;
> +position p;
> +@@
> +
> +(
> + x = kmalloc(...)
> +|
> + x = kvasprintf(...)
> +|
> + x = kasprintf(...)
> +|
> + x = kzalloc(...)
> +|
> + x = kmalloc_array(...)
> +|
> + x = kcalloc(...)
> +|
> + x = kstrdup(...)
> +|
> + x = kmemdup(...)
> +|
> + x = get_free_pages(...)
> +|
> + x = request_irq(...)
> +|
> + x = ioremap(...)
> +|
> + x = ioremap_nocache(...)
> +|
> + x = ioport_map(...)
> +)
> +...
> +(
> + kfree@p(x)
> +|
> + kzfree@p(x)
> +|
> + __krealloc@p(x, ...)
> +|
> + krealloc@p(x, ...)
> +|
> + free_pages@p(x, ...)
> +|
> + free_page@p(x)
> +|
> + free_irq@p(x)
> +|
> + iounmap@p(x)
> +|
> + ioport_unmap@p(x)
> +)
> +
>  @pb@
>  expression r.x;
> -position p;
> +position p != safe.p;
>  @@
>
>  (
>

Anyway, it looks like
this patch makes the situation better.


Applied to linux-kbuild/kbuild.  Thanks!


-- 
Best Regards
Masahiro Yamada
