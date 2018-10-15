Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CD3C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9861A2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1QMU++G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9861A2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJOQ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:57:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46431 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeJOQ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:57:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id o21so18176304otb.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=shza/8DutBv9QncV/KKppZfyxKGiicA0igKPJZ3lmVs=;
        b=L1QMU++GhtJG0KtLYuZuxAWSc4SHraygS/1R1jzyIW1WxVrVuaTY3n0H8YrK4WJ+Si
         n7XKmEWa339ycInIkPYKbe2xlMn4rP2hTEOLzo42MW94vDtOtAKC4WqNzA66cIrLKJu2
         0/uLC/PesgA79TrBeXOWvh1p8y1aaTLhNWR+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=shza/8DutBv9QncV/KKppZfyxKGiicA0igKPJZ3lmVs=;
        b=NVdXJqCMIa36o0ujM/cKpY12IXDZWNtHeQFXZ4EvgENeUxWjNMdSd4wyfEvI98NQTv
         mCF+5nn8+Pu/7Ws38I5glFFmKyXOsLiROBplI1aGzFCjy6HFdomYLcWy1EpJ3aBPWmVL
         7xhI0XCLnlisbjtSupWbXtKhYhLzkWWhovDgPOR8gLPvMF3hYwkXAEKGkl00Y49zKT6Q
         Pnk5rR3IDs6EviBa/c2GusX2FSsAiTdROkBT9Y/wosMmoItTTchjhR3H/pCQIhlCiIlM
         8cfZi4K4SkWV92xdkDxans7C91U1Q7ghBEgnl1P1vWJHZg/lezhUCVXYitQCGLopnpeB
         V69g==
X-Gm-Message-State: ABuFfohBuKt/PUMPajuXn0hiKMyYJcSCvph5zhAIFJx2axHd3vRXe8cG
        8kG6M2F26cdgLYVSu+tv4V5o2Z7lRzRruI68Y7PF7Q==
X-Google-Smtp-Source: ACcGV63cHYPuoJ/tLYcR96KHn9yqcsZF11zw0LF93/EHp+gaTGPz1ZXBRvC86vilJfvTytp0/eePkZj7nP9fGfOqZCU=
X-Received: by 2002:a9d:30c6:: with SMTP id r6mr10059571otg.344.1539594771516;
 Mon, 15 Oct 2018 02:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-7-hch@lst.de>
In-Reply-To: <20181013151707.32210-7-hch@lst.de>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 15 Oct 2018 11:12:40 +0200
Message-ID: <CA+M3ks66FL-F8dk+UcG-gR8Gz4N6gz7eYuT_Ht_scw7foPaP0A@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm: sti: don't pass GFP_DMA32 to dma_alloc_wc
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

Le sam. 13 oct. 2018 =C3=A0 17:17, Christoph Hellwig <hch@lst.de> a =C3=A9c=
rit :
>
> The DMA API does its own zone decisions based on the coherent_dma_mask.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

> ---
>  drivers/gpu/drm/sti/sti_gdp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.=
c
> index c32de6cbf061..cdf0a1396e00 100644
> --- a/drivers/gpu/drm/sti/sti_gdp.c
> +++ b/drivers/gpu/drm/sti/sti_gdp.c
> @@ -517,7 +517,7 @@ static void sti_gdp_init(struct sti_gdp *gdp)
>         /* Allocate all the nodes within a single memory page */
>         size =3D sizeof(struct sti_gdp_node) *
>             GDP_NODE_PER_FIELD * GDP_NODE_NB_BANK;
> -       base =3D dma_alloc_wc(gdp->dev, size, &dma_addr, GFP_KERNEL | GFP=
_DMA);
> +       base =3D dma_alloc_wc(gdp->dev, size, &dma_addr, GFP_KERNEL);
>
>         if (!base) {
>                 DRM_ERROR("Failed to allocate memory for GDP node\n");
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
