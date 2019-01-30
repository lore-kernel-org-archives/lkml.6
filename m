Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F958C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5923E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NG8SNScv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfA3H6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:58:24 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46993 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfA3H6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:58:24 -0500
Received: by mail-vk1-f193.google.com with SMTP id j23so5140371vke.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 23:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41MuKyrwn7veWgy22wgbZKTsiLLBQLoVXZfnrZfE764=;
        b=NG8SNScvuLRifqYAZ6cp2jznp2+9QoQoHZTpg38Ikqk+nEojwzV7DBrd81ZqrFFA9T
         yBiA/Bf21TaLAzwMslRTu7GNtbNtxg3LpaJwUcX0Mv38VPGbwjIxwWrDgiPBmZnzHnNb
         LZqFK2WwfnEffF7VOMauLWu1H/dHMSNKFJHT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41MuKyrwn7veWgy22wgbZKTsiLLBQLoVXZfnrZfE764=;
        b=G1caGSLoFUD74fL/ti6PRv76JIzPm8GWjMz1WrziJ8oyL+2iohLZroNntmLYyg2wkA
         k+4bUn6eoUYGk31xaDJTCPZqUIi/8UoaONhXvsnoVlrdVg9pRYHrZ46Uf5ZsO9Ehbxek
         j7WbglflaDevGN1ca11fHm+xriQchMv7pTCAmMXdzsVDy6SZdi2p+Yx3kb0JhIw3Drjf
         rarACXtfL4CSBwFYFg5rSBXYogN7tATDLXoCuRJH7Y7SiETbdQA2YrkFAhWpcnjQf5KZ
         Z/RBfz881MHflqhFGL4y+MjG5sTAymV+CYSyR8WOYpIOGRclLnbxLlPLEAtGEBLwfgts
         dU/w==
X-Gm-Message-State: AJcUukfc+rJJmCnj2xFg4soqqKmlj28Oc5pa57AW8e/nFGR82PbjGGNY
        yl83Jo0fP7cGpTzHNr5pSt/rJ/bJbTc7kRZvhc4Kjg==
X-Google-Smtp-Source: ALg8bN4zeoJdNSancnSSoihtHyYsuJwF/DVGcb40jwf6gjxQokiQ+hgT4+xOo7hekXB6MkhfLNH3Ww8bO9AM8dyiHjU=
X-Received: by 2002:a1f:298e:: with SMTP id p136mr12190154vkp.40.1548835102933;
 Tue, 29 Jan 2019 23:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20190114095804.27978-1-hch@lst.de> <20190114095804.27978-6-hch@lst.de>
In-Reply-To: <20190114095804.27978-6-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jan 2019 08:57:47 +0100
Message-ID: <CAPDyKFpcHv7KwuVpWcKjxj--n4YOFADWD5WzOCJ6Dca_JjqnAw@mail.gmail.com>
Subject: Re: [PATCH 05/11] mmc: s3cmci: handle highmem pages
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

Nitpick: This one have some trailing whitespace errors, which git
complains about when I apply it.

No need to re-spin due to this, I can fix it  up.

Kind regards
Uffe

> ---
>  drivers/mmc/host/s3cmci.c | 107 +++++++++++++++++++-------------------
>  drivers/mmc/host/s3cmci.h |   3 +-
>  2 files changed, 55 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index 10f5219b3b40..1be84426c817 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -15,6 +15,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/clk.h>
> +#include <linux/highmem.h>
>  #include <linux/mmc/host.h>
>  #include <linux/platform_device.h>
>  #include <linux/cpufreq.h>
> @@ -317,26 +318,17 @@ static void s3cmci_check_sdio_irq(struct s3cmci_host *host)
>         }
>  }
>
> -static inline int get_data_buffer(struct s3cmci_host *host,
> -                                 u32 *bytes, u32 **pointer)
> +static inline int get_data_buffer(struct s3cmci_host *host)
>  {
> -       struct scatterlist *sg;
> -
> -       if (host->pio_active == XFER_NONE)
> -               return -EINVAL;
> -
> -       if ((!host->mrq) || (!host->mrq->data))
> -               return -EINVAL;
> -
>         if (host->pio_sgptr >= host->mrq->data->sg_len) {
>                 dbg(host, dbg_debug, "no more buffers (%i/%i)\n",
>                       host->pio_sgptr, host->mrq->data->sg_len);
>                 return -EBUSY;
>         }
> -       sg = &host->mrq->data->sg[host->pio_sgptr];
> +       host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
>
> -       *bytes = sg->length;
> -       *pointer = sg_virt(sg);
> +       host->pio_bytes = host->cur_sg->length;
> +       host->pio_offset = host->cur_sg->offset;
>
>         host->pio_sgptr++;
>
> @@ -422,11 +414,16 @@ static void s3cmci_disable_irq(struct s3cmci_host *host, bool transfer)
>
>  static void do_pio_read(struct s3cmci_host *host)
>  {
> -       int res;
>         u32 fifo;
>         u32 *ptr;
>         u32 fifo_words;
>         void __iomem *from_ptr;
> +       void *buf;
> +
> +       if (host->pio_active == XFER_NONE)
> +               goto done;
> +       if (!host->mrq || !host->mrq->data)
> +               goto done;
>
>         /* write real prescaler to host, it might be set slow to fix */
>         writel(host->prescaler, host->base + S3C2410_SDIPRE);
> @@ -435,20 +432,12 @@ static void do_pio_read(struct s3cmci_host *host)
>
>         while ((fifo = fifo_count(host))) {
>                 if (!host->pio_bytes) {
> -                       res = get_data_buffer(host, &host->pio_bytes,
> -                                             &host->pio_ptr);
> -                       if (res) {
> -                               host->pio_active = XFER_NONE;
> -                               host->complete_what = COMPLETION_FINALIZE;
> -
> -                               dbg(host, dbg_pio, "pio_read(): "
> -                                   "complete (no more data).\n");
> -                               return;
> -                       }
> +                       if (get_data_buffer(host) < 0)
> +                               goto done;
>
>                         dbg(host, dbg_pio,
> -                           "pio_read(): new target: [%i]@[%p]\n",
> -                           host->pio_bytes, host->pio_ptr);
> +                           "pio_read(): new target: [%i]@[%zu]\n",
> +                           host->pio_bytes, host->pio_offset);
>                 }
>
>                 dbg(host, dbg_pio,
> @@ -470,63 +459,65 @@ static void do_pio_read(struct s3cmci_host *host)
>                 host->pio_count += fifo;
>
>                 fifo_words = fifo >> 2;
> -               ptr = host->pio_ptr;
> -               while (fifo_words--)
> +
> +               buf = (kmap_atomic(sg_page(host->cur_sg)) + host->pio_offset);
> +               ptr = buf;
> +               while (fifo_words--) {
>                         *ptr++ = readl(from_ptr);
> -               host->pio_ptr = ptr;
> +                       host->pio_offset += 4;
> +               }
>
>                 if (fifo & 3) {
>                         u32 n = fifo & 3;
>                         u32 data = readl(from_ptr);
> -                       u8 *p = (u8 *)host->pio_ptr;
> +                       u8 *p = (u8 *)ptr;
>
>                         while (n--) {
>                                 *p++ = data;
>                                 data >>= 8;
> +                               host->pio_offset++;
>                         }
>                 }
> +               kunmap_atomic(buf);
>         }
>
>         if (!host->pio_bytes) {
> -               res = get_data_buffer(host, &host->pio_bytes, &host->pio_ptr);
> -               if (res) {
> -                       dbg(host, dbg_pio,
> -                           "pio_read(): complete (no more buffers).\n");
> -                       host->pio_active = XFER_NONE;
> -                       host->complete_what = COMPLETION_FINALIZE;
> -
> -                       return;
> -               }
> +               if (get_data_buffer(host) < 0)
> +                       goto done;
>         }
>
>         enable_imask(host,
>                      S3C2410_SDIIMSK_RXFIFOHALF | S3C2410_SDIIMSK_RXFIFOLAST);
> +       return;
> +
> +done:
> +       host->pio_active = XFER_NONE;
> +       host->complete_what = COMPLETION_FINALIZE;
> +       dbg(host, dbg_pio, "pio_read(): complete (no more data).\n");
>  }
>
>  static void do_pio_write(struct s3cmci_host *host)
>  {
>         void __iomem *to_ptr;
> -       int res;
> +       void *buf;
>         u32 fifo;
>         u32 *ptr;
>
> +       if (host->pio_active == XFER_NONE)
> +               goto done;
> +       if (!host->mrq || !host->mrq->data)
> +               goto done;
> +
>         to_ptr = host->base + host->sdidata;
>
>         while ((fifo = fifo_free(host)) > 3) {
>                 if (!host->pio_bytes) {
> -                       res = get_data_buffer(host, &host->pio_bytes,
> -                                                       &host->pio_ptr);
> -                       if (res) {
> -                               dbg(host, dbg_pio,
> -                                   "pio_write(): complete (no more data).\n");
> -                               host->pio_active = XFER_NONE;
> -
> -                               return;
> -                       }
> +                       if (get_data_buffer(host) < 0)
> +                               goto done;
>
>                         dbg(host, dbg_pio,
> -                           "pio_write(): new source: [%i]@[%p]\n",
> -                           host->pio_bytes, host->pio_ptr);
> +                           "pio_write(): new source: [%i]@[%zd]\n",
> +                           host->pio_bytes, host->pio_offset);
>
>                 }
>
> @@ -543,13 +534,20 @@ static void do_pio_write(struct s3cmci_host *host)
>                 host->pio_count += fifo;
>
>                 fifo = (fifo + 3) >> 2;
> -               ptr = host->pio_ptr;
> -               while (fifo--)
> +               buf = (kmap_atomic(sg_page(host->cur_sg)) + host->pio_offset);
> +               ptr = buf;
> +               while (fifo--) {
>                         writel(*ptr++, to_ptr);
> -               host->pio_ptr = ptr;
> +                       host->pio_offset += 4;
> +               }
> +               kunmap_atomic(buf);
>         }
>
>         enable_imask(host, S3C2410_SDIIMSK_TXFIFOHALF);
> +       return;
> +done:
> +       dbg(host, dbg_pio, "pio_write(): complete (no more data).\n");
> +       host->pio_active = XFER_NONE;
>  }
>
>  static void pio_tasklet(unsigned long data)
> @@ -1055,6 +1053,7 @@ static int s3cmci_prepare_pio(struct s3cmci_host *host, struct mmc_data *data)
>         BUG_ON((data->flags & BOTH_DIR) == BOTH_DIR);
>
>         host->pio_sgptr = 0;
> +       host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
>         host->pio_bytes = 0;
>         host->pio_count = 0;
>         host->pio_active = rw ? XFER_WRITE : XFER_READ;
> diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
> index 30c2c0dd1bc8..4320f7d832dc 100644
> --- a/drivers/mmc/host/s3cmci.h
> +++ b/drivers/mmc/host/s3cmci.h
> @@ -50,10 +50,11 @@ struct s3cmci_host {
>
>         int                     dma_complete;
>
> +       struct scatterlist      *cur_sg;
>         u32                     pio_sgptr;
>         u32                     pio_bytes;
>         u32                     pio_count;
> -       u32                     *pio_ptr;
> +       u32                     pio_offset;
>  #define XFER_NONE 0
>  #define XFER_READ 1
>  #define XFER_WRITE 2
> --
> 2.20.1
>
