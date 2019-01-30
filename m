Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C45FC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D064E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Szk2rfrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfA3Hzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:55:46 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46439 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfA3Hzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:55:45 -0500
Received: by mail-ua1-f66.google.com with SMTP id v24so7769274uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 23:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZIvWLr2bMHRAYkCkGLBjoPGhk0MGw5PKfGobTQT1ZQ=;
        b=Szk2rfrF2gujhUb+9JkuNLLUBR7BHzwf/XFuWtKivbr3nb7Z+1Gm8UvfjIpktekj23
         dkoLuGVZehQYf1oSAjlVMQTaJa3IGvvrP5PNk4OHeaEuV900QRq/2sc3i4V+22VXouQT
         zOfBgxWif96Ibh6QBI1nX3oQcrsA/NqaDTawI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZIvWLr2bMHRAYkCkGLBjoPGhk0MGw5PKfGobTQT1ZQ=;
        b=VsY8JdwRCHx4iZp8V9fgtNDl9Wop79cxikcgpOa2g5fNCzfBtfaZncKGLEQjEVzgGY
         0/4qsxKVjZakjVoXCdSoNeEMDd9hXqDiVrAPnc+iHAEPCt0oFdtGM/Xozc/3Nwk4bkKp
         F3qPAsyMu813obVmFDVJw4FVMIfs0WRsaUfZIzaL3bvyE401BqIXfNeU76CdenQrqmHL
         eeH07xSIY4HXdQXA5ECnstuHn+sXaeq1QAAvl0taVzB45TWjLrF5RVtflptUdZgF3bYf
         sPBLO3A6a0/K13WrbEmdxNjtWN3VJZWaB5Tir49CU/zbxnqidL7Ky41bMZ75Hc5pXT4y
         nOww==
X-Gm-Message-State: AJcUukefiYV7rzuDrHvKYdpg8BUH2vJSzxfczcD9VprttjzmMx0IymJK
        2u1SnfTBgKbVkiAurLdp8HQ1Ia998PoQBl9XirnVfA==
X-Google-Smtp-Source: ALg8bN4q+O5UBStmvc5vY8XFWUOvO2/8XYi/PZrtpkxbGUhBFnbCsFCpmQ4TCQWax7jPK3go3FhGDiH4O7OPytidBHs=
X-Received: by 2002:ab0:b83:: with SMTP id c3mr11514419uak.77.1548834943903;
 Tue, 29 Jan 2019 23:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20190114095804.27978-1-hch@lst.de> <20190114095804.27978-8-hch@lst.de>
In-Reply-To: <20190114095804.27978-8-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jan 2019 08:55:07 +0100
Message-ID: <CAPDyKFrtJmaS33=yZz7ubUVVb5UB-Euq5pcaBMSFeQyubDYvGA@mail.gmail.com>
Subject: Re: [PATCH 07/11] mmc: mvsdio: handle highmem pages
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 at 10:58, Christoph Hellwig <hch@lst.de> wrote:
>
> Instead of setting up a kernel pointer to track the current PIO address,
> track the offset in the current page, and do an atomic kmap for the page
> while doing the actual PIO operations.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/mmc/host/mvsdio.c | 48 +++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index e22bbff89c8d..545e370d6dae 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/highmem.h>
>  #include <linux/platform_device.h>
>  #include <linux/mbus.h>
>  #include <linux/delay.h>
> @@ -42,7 +43,8 @@ struct mvsd_host {
>         unsigned int intr_en;
>         unsigned int ctrl;
>         unsigned int pio_size;
> -       void *pio_ptr;
> +       struct scatterlist *pio_sg;
> +       unsigned int pio_offset; /* offset in words into the segment */
>         unsigned int sg_frags;
>         unsigned int ns_per_clk;
>         unsigned int clock;
> @@ -96,9 +98,9 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>         if (tmout_index > MVSD_HOST_CTRL_TMOUT_MAX)
>                 tmout_index = MVSD_HOST_CTRL_TMOUT_MAX;
>
> -       dev_dbg(host->dev, "data %s at 0x%08x: blocks=%d blksz=%d tmout=%u (%d)\n",
> +       dev_dbg(host->dev, "data %s at 0x%08llx: blocks=%d blksz=%d tmout=%u (%d)\n",
>                 (data->flags & MMC_DATA_READ) ? "read" : "write",
> -               (u32)sg_virt(data->sg), data->blocks, data->blksz,
> +               (u64)sg_phys(data->sg), data->blocks, data->blksz,
>                 tmout, tmout_index);
>
>         host->ctrl &= ~MVSD_HOST_CTRL_TMOUT_MASK;
> @@ -118,10 +120,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>                  * boundary.
>                  */
>                 host->pio_size = data->blocks * data->blksz;
> -               host->pio_ptr = sg_virt(data->sg);
> +               host->pio_sg = data->sg;
> +               host->pio_offset = data->sg->offset / 2;
>                 if (!nodma)
> -                       dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
> -                               host->pio_ptr, host->pio_size);
> +                       dev_dbg(host->dev, "fallback to PIO for data at 0x%x size %d\n",
> +                               host->pio_offset, host->pio_size);
>                 return 1;
>         } else {
>                 dma_addr_t phys_addr;
> @@ -291,8 +294,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
>  {
>         void __iomem *iobase = host->base;
>
> -       if (host->pio_ptr) {
> -               host->pio_ptr = NULL;
> +       if (host->pio_sg) {
> +               host->pio_sg = NULL;
> +               host->pio_offset = 0;
>                 host->pio_size = 0;
>         } else {
>                 dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
> @@ -376,11 +380,12 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>         if (host->pio_size &&
>             (intr_status & host->intr_en &
>              (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
> -               u16 *p = host->pio_ptr;
> +               u16 *p = kmap_atomic(sg_page(host->pio_sg));

Seems like a corresponding kunmap_atomic() is missing somewhere.

> +               unsigned int o = host->pio_offset;
>                 int s = host->pio_size;
>                 while (s >= 32 && (intr_status & MVSD_NOR_RX_FIFO_8W)) {
> -                       readsw(iobase + MVSD_FIFO, p, 16);
> -                       p += 16;
> +                       readsw(iobase + MVSD_FIFO, p + o, 16);
> +                       o += 16;
>                         s -= 32;
>                         intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                 }
> @@ -391,8 +396,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                  */
>                 if (s <= 32) {
>                         while (s >= 4 && (intr_status & MVSD_NOR_RX_READY)) {
> -                               put_unaligned(mvsd_read(MVSD_FIFO), p++);
> -                               put_unaligned(mvsd_read(MVSD_FIFO), p++);
> +                               put_unaligned(mvsd_read(MVSD_FIFO), p + o);
> +                               o++;
> +                               put_unaligned(mvsd_read(MVSD_FIFO), p + o);
> +                               o++;
>                                 s -= 4;
>                                 intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                         }
> @@ -400,7 +407,7 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                                 u16 val[2] = {0, 0};
>                                 val[0] = mvsd_read(MVSD_FIFO);
>                                 val[1] = mvsd_read(MVSD_FIFO);
> -                               memcpy(p, ((void *)&val) + 4 - s, s);
> +                               memcpy(p + o, ((void *)&val) + 4 - s, s);
>                                 s = 0;
>                                 intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                         }
> @@ -416,13 +423,14 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                 }
>                 dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
>                         s, intr_status, mvsd_read(MVSD_HW_STATE));
> -               host->pio_ptr = p;
> +               host->pio_offset = o;
>                 host->pio_size = s;
>                 irq_handled = 1;
>         } else if (host->pio_size &&
>                    (intr_status & host->intr_en &
>                     (MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W))) {
> -               u16 *p = host->pio_ptr;
> +               u16 *p = kmap_atomic(sg_page(host->pio_sg));

Ditto.

> +               unsigned int o = host->pio_offset;
>                 int s = host->pio_size;
>                 /*
>                  * The TX_FIFO_8W bit is unreliable. When set, bursting
> @@ -431,8 +439,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                  * TX_FIFO_8W remains set.
>                  */
>                 while (s >= 4 && (intr_status & MVSD_NOR_TX_AVAIL)) {
> -                       mvsd_write(MVSD_FIFO, get_unaligned(p++));
> -                       mvsd_write(MVSD_FIFO, get_unaligned(p++));
> +                       mvsd_write(MVSD_FIFO, get_unaligned(p + o));
> +                       o++;
> +                       mvsd_write(MVSD_FIFO, get_unaligned(p + o));
> +                       o++;
>                         s -= 4;
>                         intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
>                 }
> @@ -453,7 +463,7 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                 }
>                 dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
>                         s, intr_status, mvsd_read(MVSD_HW_STATE));
> -               host->pio_ptr = p;
> +               host->pio_offset = o;
>                 host->pio_size = s;
>                 irq_handled = 1;
>         }
> --
> 2.20.1
>

Kind regards
Uffe
