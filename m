Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148ECC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D952320811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D952320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLKI6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:58:20 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41055 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:58:19 -0500
Received: by mail-ua1-f67.google.com with SMTP id z24so4856730ual.8;
        Tue, 11 Dec 2018 00:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlLR2+5M4+FlRP/xS9RpcAPqxTTr0h335z3dCYiY1XM=;
        b=UZa02OgtsD85dkCZ8HWajclEXmHjkBTErM48zzYeA9q0xdfaQ7nJc7SsZ2fd3X6YpQ
         8FQCtbv6rY6fpQBQy3Yl8VmC/OdZ7enUOtuXlqlMDwoNMvH1ko4flZn7vxMwopuGgUqN
         k7h9csqbh2f7I+exCDwXYw6PwVqmC4c7K4g9p25GStWv5ex8r7PHCGpholY78IDfnK7v
         CieVkeKyG0YEXdlHB7oh6/lNiq3SCjWNxT9M3JwIJpRyolX1pXspPgEMRIobo4bHgF5G
         +qdEQ1595Q51v1JVz8lczyLASrfG4wGjKnGF+Tr/xUBeLePm4cWI4d6TJmIGoH+8ezi2
         yXEQ==
X-Gm-Message-State: AA+aEWZyVcp3sQ0JE6vbtVQtEe3UWMi0ztGBgEjw5+Q3i5CpEiOWvtLR
        mrm8vX/4T1TC3gqlcBmS2q3LPTwB7qER39cR8qE=
X-Google-Smtp-Source: AFSGD/U3EWRx19IU7DhQqZRppbSTt8la7iM+uyGk/25l4RPQFKeN+Ih7IcLKPTiMnah0fKqN1UkL59HmaOr3qVYQMcU=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr6506944uad.78.1544518697693;
 Tue, 11 Dec 2018 00:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20181210210033.3276054-1-arnd@arndb.de>
In-Reply-To: <20181210210033.3276054-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Dec 2018 09:58:05 +0100
Message-ID: <CAMuHMdV9Xp6J0oiYxYn+5SxmqnOLX78rTts2E7dmH4xzLe_KTg@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: fix build regressions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Dec 10, 2018 at 10:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
> A number of Kconfig options have become available now to random ARM
> platforms outside of ARCH_MULTIPLATFORM, which now causes Kconfig
> warnings, and other build errors when those select options that
> lack additonal dependencies, e.g.:
>
> WARNING: unmet direct dependencies detected for HAVE_ARM_ARCH_TIMER
>   Depends on [n]: CPU_V7 [=n]
>   Selected by [y]:
>   - ARCH_RCAR_GEN2 [=y] && SOC_RENESAS [=y]
>   - ARCH_R8A73A4 [=y] && SOC_RENESAS [=y] && ARM [=y]
>
> WARNING: unmet direct dependencies detected for SYS_SUPPORTS_EM_STI
>   Depends on [n]: GENERIC_CLOCKEVENTS [=n]
>   Selected by [y]:
>   - ARCH_EMEV2 [=y] && SOC_RENESAS [=y] && ARM [=y]
>
> Put the old dependency on ARCH_RENESAS back for the moment to restore
> the previous behavior.
>
> Fixes: 062887bf5ef7 ("ARM: shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soc/renesas/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 4d8012e1205c..68bfca6f20dd 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -44,7 +44,7 @@ config ARCH_RZN1
>         bool
>         select ARM_AMBA
>
> -if ARM
> +if ARM && ARCH_RENESAS

After a closer look, I think restricting this from ARM to ARCH_MULTI_V7
should work, too (ARCH_MULTI_V7 selects CPU_V7, and ARCH_MULTIPLATFORM
selects GENERIC_CLOCKEVENTS).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
