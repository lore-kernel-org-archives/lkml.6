Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeECH0B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:26:01 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41267 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeECHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:25:57 -0400
X-Google-Smtp-Source: AB8JxZqjl8OxLqcsXlJ0U1XRfSS+F9P+Sp2CPRy9oh+xfoR/Xz3/wd3U4iKZOj7P7PmAqVH6pMFyoXomQTZl44HGr7w=
MIME-Version: 1.0
In-Reply-To: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 May 2018 09:25:56 +0200
X-Google-Sender-Auth: wYVP_4XNH2wNi7K_IEGoU-ln_AQ
Message-ID: <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com>
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Thu, May 3, 2018 at 6:23 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Set the device's coherent_dma_mask to avoid a WARNING splat.
> Please see commit 205e1b7f51e4 ("dma-mapping: warn when there is
> no coherent_dma_mask").
>
> Cc: linux-m68k@lists.linux-m68k.org
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks for your patch!

> --- a/drivers/net/ethernet/apple/macmace.c
> +++ b/drivers/net/ethernet/apple/macmace.c
> @@ -203,6 +203,10 @@ static int mace_probe(struct platform_device *pdev)
>         unsigned char checksum = 0;
>         int err;
>
> +       err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +       if (err)
> +               return err;
> +
>         dev = alloc_etherdev(PRIV_BYTES);
>         if (!dev)
>                 return -ENOMEM;

Shouldn't this be handled in the platform code that instantiates the device,
i.e. in arch/m68k/mac/config.c:mac_platform_init()?

Cfr. commit f61e64310b75733d ("m68k: set dma and coherent masks for platform
FEC ethernets").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
