Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDQOaH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:30:07 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37590 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbeDQOaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:30:05 -0400
X-Google-Smtp-Source: AIpwx4/awtyxP1Sj+G2nhiFwFbZkMCgZwJ95CFByUfEychf5eRI7zskVtRgP9MycH7MEaxRKxMxfLVFG5jyIFTj/hz0=
MIME-Version: 1.0
In-Reply-To: <1523974393-10870-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1523974393-10870-1-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Apr 2018 16:30:03 +0200
X-Google-Sender-Auth: StLabxoYzQauCTcw-EbCEgXHdwA
Message-ID: <CAMuHMdUqGgovaorxXDSCPK3dg2PLQwYoxm1mQdj=Dqi1-sDE7g@mail.gmail.com>
Subject: Re: [PATCH] sh: migor: Set DMA and DMA coherent mask
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

CC Christoph

On Tue, Apr 17, 2018 at 4:13 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> As of commit 205e1b7f51e4 ("dma-mapping: warn when there is no
> coherent_dma_mask") the Migo-R platform devices registered without a DMA
> mask and coherent DMA mask issue the following warning
>
> WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 0x40159e20
>
> Set dma mask and coherent DMA mask for Migo-R platforms devices to 32
> bits as all other SH4a platforms do.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I guess usbf_device.dev.dma_mask should be fixed as well?

BTW, there are plenty of other SH platforms that need similar fixes.

> ---
>  arch/sh/kernel/cpu/sh4a/setup-sh7722.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
> index 6b3a26e..3fe1ea7 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
> @@ -7,6 +7,7 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   */
> +#include <linux/dma-mapping.h>
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/platform_device.h>
> @@ -347,6 +348,8 @@ static struct platform_device vpu_device = {
>         .name           = "uio_pdrv_genirq",
>         .id             = 0,
>         .dev = {
> +               .dma_mask               = &vpu_device.dev.coherent_dma_mask,
> +               .coherent_dma_mask      = DMA_BIT_MASK(32),
>                 .platform_data  = &vpu_platform_data,
>         },
>         .resource       = vpu_resources,
> @@ -375,6 +378,8 @@ static struct platform_device veu_device = {
>         .name           = "uio_pdrv_genirq",
>         .id             = 1,
>         .dev = {
> +               .dma_mask               = &veu_device.dev.coherent_dma_mask,
> +               .coherent_dma_mask      = DMA_BIT_MASK(32),
>                 .platform_data  = &veu_platform_data,
>         },
>         .resource       = veu_resources,
> @@ -403,6 +408,8 @@ static struct platform_device jpu_device = {
>         .name           = "uio_pdrv_genirq",
>         .id             = 2,
>         .dev = {
> +               .dma_mask               = &jpu_device.dev.coherent_dma_mask,
> +               .coherent_dma_mask      = DMA_BIT_MASK(32),
>                 .platform_data  = &jpu_platform_data,
>         },
>         .resource       = jpu_resources,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
