Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2850BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E8421570
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XsWeknpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E8421570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeHXGaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:30:14 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38131 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHXGaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:30:14 -0400
Received: by mail-yb0-f196.google.com with SMTP id c1-v6so2990765ybq.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 19:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S1Ln40Qo/8/OYYmu4Bg/icBVUigxwP0yBnsvo4Qnj6E=;
        b=XsWeknpgKicWAVxHmqROS7UdnCIJAZVA+Vh/1RWDCQmfPJePK53dZWkRYCn1osRNOI
         cOGcaeQDMnBU+5GURiSdKx5Hg/ltuo876FsRk0ks5ObDR1niGJYSaHsbSE6JqGXHymUO
         5rIOpe9zS+sU2yZCPISEK7HgOpY67RnRTsFNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S1Ln40Qo/8/OYYmu4Bg/icBVUigxwP0yBnsvo4Qnj6E=;
        b=PjstuqOBjooO51vqwHdc/d3Bat7uWMZ/6TSv24qY+f9/wlhrQeXN5x5epOsulBQX9R
         9272/enJcYlw/uXWR04lFIK+w16U3ATHn7PvY3rXbZzXbU5VTZO9kRfJtZdgkKmF1A5t
         YJdCdF3+vOR/oILyXvNW3N9pgzeTGOt+t0ELosQd7vZ8f6R8bKs8oNM3wOIdMzqin+Gs
         eKjXhb6FNDYMgcL8I8G9nRckkO2B0RdsR4wtUboCGUEcAXubh6pSijS9/ezmyVYjsUJD
         a4GkNagoP4y2/7ZuP/Rv64dmC/3ulnLQwIb8aTTr7WgWHi5y5sRkL1dCeHuctevF7zkf
         pqtQ==
X-Gm-Message-State: AOUpUlGF0nAgzVFDyFEajIIp2wKV9G3Q4jrNkhEpUpY7nUzR+o8h5TE1
        KV0N16dIjl6H3ZIHlkQCyLNXfIlbiDA=
X-Google-Smtp-Source: AA+uWPy0Mq55LBFTFikGNeZTjavSpNZeYHmhROi2cPiqy89KtqpqK5nsKsnGoabD5AkgPd8jor86NA==
X-Received: by 2002:a25:9909:: with SMTP id z9-v6mr12772785ybn.509.1535079458718;
        Thu, 23 Aug 2018 19:57:38 -0700 (PDT)
Received: from mail-yb0-f177.google.com (mail-yb0-f177.google.com. [209.85.213.177])
        by smtp.gmail.com with ESMTPSA id u191-v6sm2911817ywc.0.2018.08.23.19.57.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 19:57:37 -0700 (PDT)
Received: by mail-yb0-f177.google.com with SMTP id f4-v6so2993556ybp.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 19:57:36 -0700 (PDT)
X-Received: by 2002:a25:103:: with SMTP id 3-v6mr34771409ybb.421.1535079456148;
 Thu, 23 Aug 2018 19:57:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 19:57:35
 -0700 (PDT)
In-Reply-To: <20180824010938.GA25581@embeddedor.com>
References: <20180824010938.GA25581@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 19:57:35 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL_p6Z863qq5=K2B+=AW6LuxmBu23bjhQe-1saz4kdeFA@mail.gmail.com>
Message-ID: <CAGXu5jL_p6Z863qq5=K2B+=AW6LuxmBu23bjhQe-1saz4kdeFA@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: atmel: use struct_size() in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 6:09 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>         int stuff;
>         void *entry[];
> };
>
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index a068b21..b17cfd0 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -1586,9 +1586,7 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       nand = devm_kzalloc(nc->dev,
> -                           sizeof(*nand) + (numcs * sizeof(*nand->cs)),
> -                           GFP_KERNEL);
> +       nand = devm_kzalloc(nc->dev, struct_size(nand, cs, numcs), GFP_KERNEL);
>         if (!nand) {
>                 dev_err(nc->dev, "Failed to allocate NAND object\n");
>                 return ERR_PTR(-ENOMEM);
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
