Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BE6C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5155520881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIQguRNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5155520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbeLBPt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 10:49:58 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35840 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeLBPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 10:49:58 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so5115966itj.1;
        Sun, 02 Dec 2018 07:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rW/CX2F6coLsUk6/BA+631RE3X9/MTAK2tzYk97aag=;
        b=iIQguRNVkewPIZvTnCRss2Qwp2LTmuSuhV+qMGvRkbYSiAgN7hFbZ16kx4tyEjW40A
         eAqIffpBbw/RmlbOj6Fe/0eWKll+4nDNdO9fzXki0dHFAzE27t1/2vKPlgwtfk3FnwEH
         fRuDB+pWHZ3mr6nW0VrB4JfMWvQ7G69YM4T0iWSdOMCPncrvQ5CVIoecB1VhwEIO0yLP
         hwHO4xHR56pQUiRlFUFV947VQlkCvYtJseiAP7PK3e/RDoiwDetQs77dWrJ/NCbkSl+p
         bAWVEchOdtrM9VzGl5v+ww2Q7iwWTVvfbBteWA3On3JoeH3rV39qO+pyvzqNfmbozbun
         iz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rW/CX2F6coLsUk6/BA+631RE3X9/MTAK2tzYk97aag=;
        b=Tiew+vR4idp6Kb22MjTdi78/6GP8xdcwfZ81dTQpOt9okbNfpPhzMoLvxf2GyBIk6d
         GQZkit5Z6Lk3VggHpGvP1IDSSzm27y+ZMqNynp0jqevvy937anIMvHv5JVhQ4CphZQcR
         phe7071LfWXnv0wkLnhKKDp2TfqjW1Csfie+jch8Ef4esgbYbxZ9a2Wu1FkaaazGz6d9
         7acZtmMArC8IFU12xt3en+6ILZt0kAyuVefYdaivWH/fZvRgLYZy2jD3JASS9Vb4QFJ8
         eUDjpzAD+mkRoAgWS2MYuW8ih8uWkgHzTaW8L8OprG5QDcwdEkCCFVM6LAnTiYIyffPs
         ZRrw==
X-Gm-Message-State: AA+aEWZFuMzWeVkuJAcFekRYFpzYx7tCWkNweM3urnMRSaxSYcdthENi
        MoOx89tstwBDlTZbwC5UOOphg3GBGZ/fnTb0Pw0=
X-Google-Smtp-Source: AFSGD/WsgQnstPLV3k52HjXCsOXaghQZi+PlmMaz6lZf0COE6RcBUD9UqIr3a+kSy2Qxa4VFPiWF6Mz4yn8/VpWWmlk=
X-Received: by 2002:a24:d84:: with SMTP id 126-v6mr5411950itx.163.1543765796263;
 Sun, 02 Dec 2018 07:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20181122015237.14534-1-jonathan@marek.ca> <20181122015237.14534-3-jonathan@marek.ca>
In-Reply-To: <20181122015237.14534-3-jonathan@marek.ca>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 2 Dec 2018 10:49:44 -0500
Message-ID: <CAF6AEGujMhgArNPq9SXwGhu3KT_fW770qBKyXBD2=oA6pghJyA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] drm/msm/mdp4: add lcdc-align-lsb flag to control
 lane alignment
To:     Jonathan <jonathan@marek.ca>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        Chris Healy <Chris.Healy@zii.aero>,
        Fabio Estevam <festevam@gmail.com>,
        David Airlie <airlied@linux.ie>, boris.brezillon@bootlin.com,
        Thierry Reding <treding@nvidia.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 8:55 PM Jonathan Marek <jonathan@marek.ca> wrote:
>
> Controls which of the 8 lanes are used for 6 bit color.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> index e19ab2ab63f7..7d8d11c8150a 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
> @@ -377,20 +377,26 @@ static void mdp4_lcdc_encoder_enable(struct drm_encoder *encoder)
>         unsigned long pc = mdp4_lcdc_encoder->pixclock;
>         struct mdp4_kms *mdp4_kms = get_kms(encoder);
>         struct drm_panel *panel;
> +       uint32_t config;
>         int i, ret;
>
>         if (WARN_ON(mdp4_lcdc_encoder->enabled))
>                 return;
>
>         /* TODO: hard-coded for 18bpp: */
> -       mdp4_crtc_set_config(encoder->crtc,
> -                       MDP4_DMA_CONFIG_R_BPC(BPC6) |
> -                       MDP4_DMA_CONFIG_G_BPC(BPC6) |
> -                       MDP4_DMA_CONFIG_B_BPC(BPC6) |
> -                       MDP4_DMA_CONFIG_PACK_ALIGN_MSB |
> -                       MDP4_DMA_CONFIG_PACK(0x21) |
> -                       MDP4_DMA_CONFIG_DEFLKR_EN |
> -                       MDP4_DMA_CONFIG_DITHER_EN);
> +       config =
> +               MDP4_DMA_CONFIG_R_BPC(BPC6) |
> +               MDP4_DMA_CONFIG_G_BPC(BPC6) |
> +               MDP4_DMA_CONFIG_B_BPC(BPC6) |
> +               MDP4_DMA_CONFIG_PACK(0x21) |
> +               MDP4_DMA_CONFIG_DEFLKR_EN |
> +               MDP4_DMA_CONFIG_DITHER_EN;
> +
> +       if (!of_find_property(dev->dev->of_node, "lcdc-align-lsb", NULL))
> +               config |= MDP4_DMA_CONFIG_PACK_ALIGN_MSB;
> +
> +

looks reasonable, except extra newline (minor nit) and more
importantly the new dt property needs to be documented (and cc'd to
devicetree list)

BR,
-R

> +       mdp4_crtc_set_config(encoder->crtc, config);
>         mdp4_crtc_set_intf(encoder->crtc, INTF_LCDC_DTV, 0);
>
>         bs_set(mdp4_lcdc_encoder, 1);
> --
> 2.17.1
>
