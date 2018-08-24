Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B9EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116342156E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gj3qcoXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116342156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeHXG3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:29:32 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43051 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHXG3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:29:32 -0400
Received: by mail-yw1-f66.google.com with SMTP id l189-v6so2591236ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KSD8O7mPC0ouu6dNXMrbkqJGuv4dpyA6Mpk/Yfs/a20=;
        b=Gj3qcoXuciGTQMNmy+EMbgi9BVF4Gmy6Z2+MAwVJA/wMWxPbgIRS4tPkVb5MLtbEDb
         DouionMnIEiYKOgx+mLSdW39M5291vbOYIPyhvERR0eA9vruBK+WgjM0TJVGrwAKTDyN
         1/D6V7FZn/nPY656rezh0P+R5WW6gPEf5u20A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KSD8O7mPC0ouu6dNXMrbkqJGuv4dpyA6Mpk/Yfs/a20=;
        b=XHFDDxwkIuzEzA2vZbtFMhZuNl9dEILlzKL/7+xSY36Xnl5ojYgnnx5ZTgJJf/TdJX
         7ZXL0UMHr4IvzPW8B75oSWP3eUvzj6CXUTJbV15ua6volC/diN/tUWLCX3oYVvpqAr9J
         8/ZHgo5JdhU1FdyvrmjSKzr0/aR7XngvFcX8pr1L/shUcPUqbcGRGlVDIV0uNz/Na9xL
         GVDEcN2/b/GEFaTc8Q6I+36bsDY74f7pCRdv4oAl7eMuSHdNT9S3zxmjW5RAbRI7hPuz
         SW5fh7SGafMkUWKaI6Dg1YVYQ6YIKL6n+V4SpZUxoDcHVVkXN2ad7VRId7tUag9p3xNY
         Jpjg==
X-Gm-Message-State: APzg51CSFMIazxuL41XGPXXpINjIvRS00PpGNgq57d9a/PaLwPMFW/nv
        Cuw09cgVar2vk852t3OJCWTf5JhXKJk=
X-Google-Smtp-Source: ANB0VdYQmylxdkJ08LxlEYD4nbr8HvqeqahNHVKZPhaiq+LRTOuNUZ9xdqhc/c0EtMMthEAXFHlS7A==
X-Received: by 2002:a81:d0d:: with SMTP id 13-v6mr4440084ywn.129.1535079417264;
        Thu, 23 Aug 2018 19:56:57 -0700 (PDT)
Received: from mail-yb0-f179.google.com (mail-yb0-f179.google.com. [209.85.213.179])
        by smtp.gmail.com with ESMTPSA id v126-v6sm7901807ywe.45.2018.08.23.19.56.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 19:56:56 -0700 (PDT)
Received: by mail-yb0-f179.google.com with SMTP id c4-v6so2989895ybl.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 19:56:55 -0700 (PDT)
X-Received: by 2002:a25:1345:: with SMTP id 66-v6mr21689161ybt.171.1535079415528;
 Thu, 23 Aug 2018 19:56:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 19:56:55
 -0700 (PDT)
In-Reply-To: <20180824010706.GA25522@embeddedor.com>
References: <20180824010706.GA25522@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 19:56:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJa+ReO9DtsFXbTOWD6tNBFF4EKARULmGFLTUH7+viuaw@mail.gmail.com>
Message-ID: <CAGXu5jJa+ReO9DtsFXbTOWD6tNBFF4EKARULmGFLTUH7+viuaw@mail.gmail.com>
Subject: Re: [PATCH] memory: atmel-ebi: Use struct_size() in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 6:07 PM, Gustavo A. R. Silva
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
>  drivers/memory/atmel-ebi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index b907865..c3748b4 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -327,8 +327,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
>                 return -EINVAL;
>         }
>
> -       ebid = devm_kzalloc(ebi->dev,
> -                           sizeof(*ebid) + (numcs * sizeof(*ebid->configs)),
> +       ebid = devm_kzalloc(ebi->dev, struct_size(ebid, configs, numcs),
>                             GFP_KERNEL);
>         if (!ebid)
>                 return -ENOMEM;
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
