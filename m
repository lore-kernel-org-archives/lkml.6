Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbeBLIZ7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:25:59 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45940 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932561AbeBLIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:25:57 -0500
X-Google-Smtp-Source: AH8x226+I9V7XpkfxjUiDpaD7mviQ7WCxXH02StdLT78gHZv1AK6OmK6GX4Qg63PoGWyePRngO22wtzBmv3+w+46Vdc=
MIME-Version: 1.0
In-Reply-To: <2ce948e1e6c0ef2476f57600b429b24355871eb8.1518397634.git.fthain@telegraphics.com.au>
References: <cover.1518397634.git.fthain@telegraphics.com.au> <2ce948e1e6c0ef2476f57600b429b24355871eb8.1518397634.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2018 09:25:56 +0100
X-Google-Sender-Auth: jtEV-5ZpaW9DyozKmwUr-tAd7eo
Message-ID: <CAMuHMdWEcTipfQNFgMmcRQL+eavdc26-SqLrqscOy=K1+YW98g@mail.gmail.com>
Subject: Re: [PATCH net v4 06/13] net/mac89x0: Convert to platform_driver
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 4:08 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Apparently these Dayna cards don't have a pseudoslot declaration ROM
> which means they can't be probed like NuBus cards.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  arch/m68k/mac/config.c                |  4 ++
>  drivers/net/Space.c                   |  3 --
>  drivers/net/ethernet/cirrus/mac89x0.c | 69 ++++++++++++++++-------------------
>  include/net/Space.h                   |  1 -
>  4 files changed, 35 insertions(+), 42 deletions(-)

For the m68k part:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/net/ethernet/cirrus/mac89x0.c
> +++ b/drivers/net/ethernet/cirrus/mac89x0.c

> @@ -167,10 +172,9 @@ static const struct net_device_ops mac89x0_netdev_ops = {
>
>  /* Probe for the CS8900 card in slot E.  We won't bother looking
>     anywhere else until we have a really good reason to do so. */
> -struct net_device * __init mac89x0_probe(int unit)
> +static int mac89x0_device_probe(struct platform_device *pdev)
>  {
>         struct net_device *dev;
> -       static int once_is_enough;
>         struct net_local *lp;
>         static unsigned version_printed;
>         int i, slot;
> @@ -181,20 +185,13 @@ struct net_device * __init mac89x0_probe(int unit)
>         struct nubus_rsrc *fres;
>
>         if (!MACH_IS_MAC)
> -               return ERR_PTR(-ENODEV);
> +               return -ENODEV;

I think this check can be removed completely, as the platform device will
exist on suitable Macs only.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
