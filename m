Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE57C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61586206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TEkKQN84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61586206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeLDQoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:44:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36544 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:44:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so7629488pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=Wobvm2en+iyXsdkhAMMrn87rd51nTH74FUMADOW2eXs=;
        b=TEkKQN84K/e2RBuHzmEGzCA+kqTtXOVFiUrdkoswDb0uf0LClWKcyZocNtGTpN1Kd5
         lARxRmFLPgN0ylahtdl3zUpO54bBbBg8GPotp7B2Lf2/NpwaYENpOKIwDquK7ayy452i
         nVZZknDIQ9BmgZBMmXjnbGnFh9DRZie7FOwgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=Wobvm2en+iyXsdkhAMMrn87rd51nTH74FUMADOW2eXs=;
        b=Akipj/pCy+JEHwHIIZwaKLlBPlCy5CLT1yp1dPagGc3JkR59mhFDi/G++t3Lqy4Bbq
         r1OuOy1KycSjiQetOQ7xF0QQMuCbeMmQ6ObDKVyFDaDyLFYF9PyKyzbVJRxfEPV5wmOA
         cTH0ZfeAT6TXrXw/G4ClaA07DDZz1eJ9F44+R2xr4vR7pLBjrfiGjkzg9bGKtLhN98/z
         0+SQ/Xr6mRaprimqHcQw6DaSXeAL6Cafhflh1DLpBYzT3Bx+N3OrXl/vjlembjKExNnC
         crJ+i1rGTKTO7q76vn4l52+z6fKFveQiTzGv10edu+2ePOuHbn630pROcYC60VsL0EP+
         +Dfg==
X-Gm-Message-State: AA+aEWYLTSUGJbj8BI9avyeI3CQXD9rMb+eSgbJCpUa+x6MlsPmSye7Y
        RR2usEGddeZYSf6PPlQvJ3vlZg==
X-Google-Smtp-Source: AFSGD/UoUO5MxqaI5N5cLH7dC0GKwVIQwD39rItmoGPwfZjoIm2/TmUhRZkxzMda2IxYUHD2j2ZUUQ==
X-Received: by 2002:a62:c302:: with SMTP id v2mr20941684pfg.155.1543941842172;
        Tue, 04 Dec 2018 08:44:02 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 84sm30372241pfk.134.2018.12.04.08.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:44:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181201005254.139908-3-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
References: <20181201005254.139908-1-mka@chromium.org>
 <20181201005254.139908-3-mka@chromium.org>
Message-ID: <154394184065.88331.4558186365546696323@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/8] drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
Date:   Tue, 04 Dec 2018 08:44:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-30 16:52:48)
> Get the ref clock of the PHY from the device tree instead of
> hardcoding its name and rate. Use default values if the ref
> clock is not specified.
> =

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - use default name and rate if the ref clock is not specified
>   in the DT
> - store vco_ref_clk_name instead of vco_ref_clk
> - fixed check for EPROBE_DEFER
> - renamed VCO_REF_CLK_RATE to VCO_REF_CLK_DEFAULT_RATE
> =

> Changes in v2:
> - patch added to the series
> ---
>  .../gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c   | 28 +++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c b/drivers/gp=
u/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
> index 49008451085b8..3af678d3317f6 100644
> --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
> +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
> @@ -47,9 +47,9 @@
>  =

>  #define NUM_PROVIDED_CLKS      2
>  =

> -#define VCO_REF_CLK_RATE       27000000
> -#define VCO_MIN_RATE           600000000
> -#define VCO_MAX_RATE           1200000000
> +#define VCO_REF_CLK_DEFAULT_RATE       27000000
> +#define VCO_MIN_RATE                   600000000
> +#define VCO_MAX_RATE                   1200000000
>  =

>  #define DSI_BYTE_PLL_CLK       0
>  #define DSI_PIXEL_PLL_CLK      1
> @@ -75,6 +75,8 @@ struct dsi_pll_28nm {
>         struct platform_device *pdev;
>         void __iomem *mmio;
>  =

> +       const char *vco_ref_clk_name;

Can this be passed around during clk registration so we don't have to
store it away in the structure?

> +
>         /* custom byte clock divider */
>         struct clk_bytediv *bytediv;
>  =

> @@ -125,7 +127,10 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *=
hw, unsigned long rate,
>         DBG("rate=3D%lu, parent's=3D%lu", rate, parent_rate);
>  =

>         temp =3D rate / 10;
> -       val =3D VCO_REF_CLK_RATE / 10;
> +       if (parent_rate)
> +               val =3D parent_rate / 10;
> +       else
> +               val =3D VCO_REF_CLK_DEFAULT_RATE / 10;

Is the clk not properly hooked up to a parent sometimes so parent_rate
is 0? That sounds odd given the fact that it used to be 'pxo' and that
has always existed on the system as 27 MHz. So I'd remove this and just
use parent_rate all the time.

