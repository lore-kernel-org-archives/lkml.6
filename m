Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431D7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D581C2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kq+iZ6U8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D581C2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeHXBWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 21:22:31 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35632 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeHXBWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 21:22:31 -0400
Received: by mail-yb0-f196.google.com with SMTP id o17-v6so2773603yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VFb6OoLEOQcDG2HrU8ctw0XRRv7XW1+1y1TbsuyGtac=;
        b=kq+iZ6U8zkgXhN73N+UWmvJl6mUGqDnWuSVUqYDUpWnH78QUQPSQ9BT1QwyXjZBhj5
         Gps9kgPjA4yhLd7AbiRYybiyXnpabpPx4nMhqkuh9IQxzj5FTprFslWpFJNkKUokm7Uv
         gwoOF4kDDBmB6aLSOSM4zpJsS6aM61fFzKdAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VFb6OoLEOQcDG2HrU8ctw0XRRv7XW1+1y1TbsuyGtac=;
        b=XCkVmHpi0RSGyud0fdIeAUPlv13+bT8MEvLtd74oOru5BGUAhfD7t2F9YCsmJegg8I
         tjtdZ5LdfzxsbsjhiRzzdAIUGj+H9BM3N6Lpt1Pey6Rt4Cs7Z27c8cojPH/SqmVTYb9+
         fbkSwPcex+Q4wa7oP1hmoUimMOC0fXlYb2EIrHY2zVOouMKzg4W9u/fj9p2KyD0oZ/IU
         cuWmUnRig8hOcHrkZJxHfdEAyNn0LjNkcW9xM3DWwmuLGAGnxmnj/9ylB/JozBbIQzh+
         YeurvEMOAYXuH9Y0Axzd8Z9oQPJONLA/sYptdX/HYOL4SHfbqdn+LJoMusk98XCnoey7
         7z9w==
X-Gm-Message-State: APzg51AU0Y1lQtA9yrShTkya7sxZ8sptUQlwr2gH8+FOJJaU9Vi6ge4J
        Bk8GV/8/CKl/2FReeebIsH95BwBATIw=
X-Google-Smtp-Source: ANB0Vdb+AkTD7TFnSef6js2oNoObAukokgOPJt/dzZqs/jp3R4Oe64JfhhUrs9A5+fw+TLSaBOdTzg==
X-Received: by 2002:a0d:d945:: with SMTP id b66-v6mr3896745ywe.493.1535061051777;
        Thu, 23 Aug 2018 14:50:51 -0700 (PDT)
Received: from mail-yb0-f171.google.com (mail-yb0-f171.google.com. [209.85.213.171])
        by smtp.gmail.com with ESMTPSA id 200-v6sm2576330ywr.102.2018.08.23.14.50.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 14:50:49 -0700 (PDT)
Received: by mail-yb0-f171.google.com with SMTP id v13-v6so2757640ybq.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 14:50:49 -0700 (PDT)
X-Received: by 2002:a81:9fd6:: with SMTP id w205-v6mr4124292ywg.288.1535061049152;
 Thu, 23 Aug 2018 14:50:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 14:50:48
 -0700 (PDT)
In-Reply-To: <20180823193332.GA31602@embeddedor.com>
References: <20180823193332.GA31602@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 14:50:48 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+biznRQt+gi7Nj1GZ0zk-s6JRh1NB5DhOOOMq0sf8ciQ@mail.gmail.com>
Message-ID: <CAGXu5j+biznRQt+gi7Nj1GZ0zk-s6JRh1NB5DhOOOMq0sf8ciQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: jz4780: use struct_size() in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Harvey Hunt <harveyhuntnexus@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 12:33 PM, Gustavo A. R. Silva
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
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mtd/nand/raw/jz4780_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
> index db4fa60..ac62395 100644
> --- a/drivers/mtd/nand/raw/jz4780_nand.c
> +++ b/drivers/mtd/nand/raw/jz4780_nand.c
> @@ -352,7 +352,7 @@ static int jz4780_nand_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>
> -       nfc = devm_kzalloc(dev, sizeof(*nfc) + (sizeof(nfc->cs[0]) * num_banks), GFP_KERNEL);
> +       nfc = devm_kzalloc(dev, struct_size(nfc, cs, num_banks), GFP_KERNEL);
>         if (!nfc)
>                 return -ENOMEM;
>
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
