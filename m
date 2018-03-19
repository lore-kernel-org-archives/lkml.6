Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933361AbeCSLdc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:33:32 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:61343 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933016AbeCSLd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:33:29 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w2JBXBAv013537
X-Nifty-SrcIP: [209.85.217.171]
X-Google-Smtp-Source: AG47ELs8rl0lPrq4oXueZ0wto9tqk4bjB7JZ9LQC/9ZwSIbQ4NBa7PrFmQC3vAk7AVedTOyZLAN1iURNS4b/3ZC4MEc=
MIME-Version: 1.0
In-Reply-To: <1521458773-14224-3-git-send-email-yamada.masahiro@socionext.com>
References: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com> <1521458773-14224-3-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 19 Mar 2018 20:32:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT76N+v=eHz=rEwYLBM7kK0q3bD1dOe7-gc0p-XvyTz_w@mail.gmail.com>
Message-ID: <CAK7LNAT76N+v=eHz=rEwYLBM7kK0q3bD1dOe7-gc0p-XvyTz_w@mail.gmail.com>
Subject: Re: [PATCH 3/7] lib: zstd: clean up Makefile for simpler composite
 object handling
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-19 20:26 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Now, Kbuild nicely handles composite objects to avoid multiple
> definition.
>
> Makefiles can simply add the same objects multiple times across
> composite objects.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> The is clean-up from build system point of view.
>
> I will apply this for the Kbuild tree.
>
>
>  lib/zstd/Makefile | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
> index dd0a359..a1a64cf 100644
> --- a/lib/zstd/Makefile
> +++ b/lib/zstd/Makefile
> @@ -4,15 +4,7 @@ obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
>  ccflags-y += -O3
>
>  # Object files unique to zstd_compress and zstd_decompress

This comment line should be removed as well.



> -zstd_compress-y := fse_compress.o huf_compress.o compress.o
> -zstd_decompress-y := huf_decompress.o decompress.o
> -
> -# These object files are shared between the modules.
> -# Always add them to zstd_compress.
> -# Unless both zstd_compress and zstd_decompress are built in
> -# then also add them to zstd_decompress.
> -zstd_compress-y += entropy_common.o fse_decompress.o zstd_common.o
> -
> -ifneq ($(CONFIG_ZSTD_COMPRESS)$(CONFIG_ZSTD_DECOMPRESS),yy)
> -       zstd_decompress-y += entropy_common.o fse_decompress.o zstd_common.o
> -endif
> +zstd_compress-y := fse_compress.o huf_compress.o compress.o \
> +                  entropy_common.o fse_decompress.o zstd_common.o
> +zstd_decompress-y := huf_decompress.o decompress.o \
> +                    entropy_common.o fse_decompress.o zstd_common.o
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
