Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02349ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 09:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A4D20875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 09:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A4D20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeGVKVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 06:21:25 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33049 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbeGVKVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 06:21:24 -0400
Received: by mail-ua0-f195.google.com with SMTP id i4-v6so9988408uak.0;
        Sun, 22 Jul 2018 02:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AsDdYy7bToY04Pp+kz+hteGQ7EENWhfgLjBgXAW4FeM=;
        b=UPKph+WmRX21VlbHKKWZDV8LIj8ZayepgJSXm0dA6y8wXNIqteA7HCCZfCVOv+wuWM
         PSSUXT/pWWo5EzzczfYULiQ3DetcAkWJzhCDYwCTPr8whKgW6bW2QCiWtWoLSuqXnqiZ
         MALBD6Xk8c4PuKtKRMWWx/cDYJb5pCQh+jvXN7LKtDH7PXqxwKcMSPFMhHcFtV1BrPFf
         iad32dAy8cXHRHB8+PxOWNKdQaR33C0g08a/TTnvw9nl/k7ze+bPZREwmTENKe8Xo2Dl
         EVmkGyxiVaflaOK4X3bAuS/3d+cgARY0wt1S/t3wOqeNsiW7sVgFnSWaBnR1ZYnGSDb/
         AoVg==
X-Gm-Message-State: AOUpUlGytOKiSNi7Ps6T3z/8ZMLwSe9IfhXklX58BaSou38TnzkmsKOw
        o1I+ek3t7Qttn8eNMtM6EoveJvJwXvxjtMu1pMI=
X-Google-Smtp-Source: AAOMgpchODGocRvMYHa3zOaDsgzteXNMkdPazxQayOGhaycw5u7WMW+XfpaIWpCZ2XoMl+q2AeXgY61l4zgcM9rg60w=
X-Received: by 2002:a9f:37c8:: with SMTP id q66-v6mr5776156uaq.180.1532251519755;
 Sun, 22 Jul 2018 02:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <1cdcd8e1-b12c-31cb-1188-c062dae3e461@infradead.org>
In-Reply-To: <1cdcd8e1-b12c-31cb-1188-c062dae3e461@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 22 Jul 2018 11:25:07 +0200
Message-ID: <CAMuHMdVwY0b9S3j2MnuC59vYOuV=LXtQwnhevq227r+mec491Q@mail.gmail.com>
Subject: Re: [PATCH] arch/h8300: modify ffs(), fls() etc. functions to return int
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Richard Kuo <rkuo@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC hexagon

hexagon != H8/300 != SuperH

On Sat, Jul 21, 2018 at 5:28 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
> printk format build warning.  This is due to hexagon's ffs() being
> coded as returning long instead of int.
>
> Fix the printk format warning by changing all of hexagon's ffx() and
> flx() functions to return int instead of long.  The variables that
> they return are already int instead of long.
>
> ../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
> ../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]
>
>
> There are no ffx() or flx() allmodconfig build errors after making this
> change.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/hexagon/include/asm/bitops.h |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> --- linux-next-20180717.orig/arch/hexagon/include/asm/bitops.h
> +++ linux-next-20180717/arch/hexagon/include/asm/bitops.h
> @@ -194,7 +194,7 @@ static inline int __test_bit(int nr, con
>   *
>   * Undefined if no zero exists, so code should check against ~0UL first.
>   */
> -static inline long ffz(int x)
> +static inline int ffz(int x)
>  {
>         int r;
>
> @@ -211,7 +211,7 @@ static inline long ffz(int x)
>   * This is defined the same way as ffs.
>   * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
>   */
> -static inline long fls(int x)
> +static inline int fls(int x)
>  {
>         int r;
>
> @@ -232,7 +232,7 @@ static inline long fls(int x)
>   * the libc and compiler builtin ffs routines, therefore
>   * differs in spirit from the above ffz (man ffs).
>   */
> -static inline long ffs(int x)
> +static inline int ffs(int x)
>  {
>         int r;
>
> @@ -254,7 +254,7 @@ static inline long ffs(int x)
>   * bits_per_long assumed to be 32
>   * numbering starts at 0 I think (instead of 1 like ffs)
>   */
> -static inline unsigned long __ffs(unsigned long word)
> +static inline int __ffs(unsigned long word)

The version in asm-generic deoes use "unsigned long".

See also "m68k/bitops: convert __ffs to match generic declaration"
https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/commit/?h=for-v4.19&id=4b538d3dca3e590cdb0234746011a6d9c245cfa3

>  {
>         int num;
>
> @@ -272,7 +272,7 @@ static inline unsigned long __ffs(unsign
>   * Undefined if no set bit exists, so code should check against 0 first.
>   * bits_per_long assumed to be 32
>   */
> -static inline unsigned long __fls(unsigned long word)
> +static inline int __fls(unsigned long word)

Same here

>  {
>         int num;
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
