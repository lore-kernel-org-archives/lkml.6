Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9358EC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543BD2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ncdcai9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543BD2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJOQ5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:57:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34989 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeJOQ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:57:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id 14so14199575oth.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rRrE5CHurdkeOx8wfUBHmstmIPcG68F2WjhHReGNFM0=;
        b=Ncdcai9djgHQu9REvHqnt1UFU62rDMzZ3QaAKkih5Ca+IM+zf0ysNOs+zH/JzVc81O
         VSoqAvkifEqgsX4JLnFi0pJxkV/G3ntFjgDpN/zZtj8febRoMTJhTIGTN47Qt4PedCwz
         mhijawyXZEzlYq7ERDZ/RjA50S8hg9YhUmwiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rRrE5CHurdkeOx8wfUBHmstmIPcG68F2WjhHReGNFM0=;
        b=FTsuoeTMyyu9yfWFwTdJCkp3tQI/Pwo0dsSkaegJzjwEwlfVbVcieb+uRkSBrjYfsG
         vWALFaR50hhnbahIqweJwK+l+meQ1iYxfiQPxmD1+5NfdSHtkxNWF6yn7oF7y4TKvx76
         V4n2Hufknt8yrJZsmwE8+oYI9CuYZfVcDdnYnmRLwi2xn+gAWN34ZzmSoDn7vcXN/eu2
         XCews6XknokM2vQCHJpTVNGYiYixlptmbRhHOmTSIxbHFRAI5OY9Sf/etuYPIWD4TTqp
         eHYuqfRwwRwv4bM9j4LVesWPT2aLwGyb0mKkF5E3VBqvb9ubKj9921EV2RUjUYzRljN5
         L08A==
X-Gm-Message-State: ABuFfoilPkIuDKAT5hRMJ13pYCOv9TTiK340YdcTszTdgWbwM/BSx201
        qZ/OUsraHvMCEyRPlEtriBX9oK0BjOYQumEjxVuHwA==
X-Google-Smtp-Source: ACcGV610/+zaJi5E12mjjKcotQfH/RQcg67RIg3Puc+vMZPiN6P6LbbSBBQUUmyobwefdEXR1B/t19qmde/iRQ83WiM=
X-Received: by 2002:a9d:cd4:: with SMTP id o20mr10965740otd.207.1539594785847;
 Mon, 15 Oct 2018 02:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-8-hch@lst.de>
In-Reply-To: <20181013151707.32210-8-hch@lst.de>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 15 Oct 2018 11:12:55 +0200
Message-ID: <CA+M3ks5KO-Yr_PEczaENhTfirthFz2gW1uv4bwZe5mjy3-jZyg@mail.gmail.com>
Subject: Re: [PATCH 7/8] media: sti/bdisp: don't pass GFP_DMA32 to dma_alloc_attrs
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-media@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam. 13 oct. 2018 =C3=A0 17:18, Christoph Hellwig <hch@lst.de> a =C3=A9c=
rit :
>
> The DMA API does its own zone decisions based on the coherent_dma_mask.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

> ---
>  drivers/media/platform/sti/bdisp/bdisp-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/sti/bdisp/bdisp-hw.c b/drivers/media/=
platform/sti/bdisp/bdisp-hw.c
> index 26d9fa7aeb5f..4372abbb5950 100644
> --- a/drivers/media/platform/sti/bdisp/bdisp-hw.c
> +++ b/drivers/media/platform/sti/bdisp/bdisp-hw.c
> @@ -510,7 +510,7 @@ int bdisp_hw_alloc_filters(struct device *dev)
>
>         /* Allocate all the filters within a single memory page */
>         size =3D (BDISP_HF_NB * NB_H_FILTER) + (BDISP_VF_NB * NB_V_FILTER=
);
> -       base =3D dma_alloc_attrs(dev, size, &paddr, GFP_KERNEL | GFP_DMA,
> +       base =3D dma_alloc_attrs(dev, size, &paddr, GFP_KERNEL,
>                                DMA_ATTR_WRITE_COMBINE);
>         if (!base)
>                 return -ENOMEM;
> --
> 2.19.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
