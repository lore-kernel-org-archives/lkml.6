Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C344C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C7F206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FV322OaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C7F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeLDQpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:45:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39396 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:45:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so7617201pgl.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=vq3QyhMMROyMw/XIZ/dmYybFRT7bHgY7aRxp7kO301c=;
        b=FV322OaJ+YcV7yz1kYXD6TNQTsFu33haxOdZVvKI2p66+FqbFaI3AsrhUMuPomQp9o
         5DwW4zur2c+hGnmQmJDkRwzZC2zWD1dz+oYYtpPFW6SQ50w6jvbnXI82BCdmwKq4WYui
         tUa0BETUdq2mNZNovS7hvcrZUDYt7YEHKYJdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=vq3QyhMMROyMw/XIZ/dmYybFRT7bHgY7aRxp7kO301c=;
        b=nOmrpJNOK3Nu9DVzHLICYTEQazD6mSNWFe71lFL7DEKu6Gd0zviQjdolFsmi2iDxXv
         0TZjBanZICmXiHsWzo1ulTWHF6ynqM/K74ai4HKH0MF9z+S9KwLRNIHzXPxwb0cyJCOc
         Me7IJ4qxRVe8KnPlakEwlAf8+vb6136cl6pLn0cyX635sNajrfRL8VYkhK4fWh9um83L
         cNYzf8Ko93Nc1DnzeypxnDI0qEgWA4/eRT7Omgjpv1bVSQ3DxGttuAyfMbGQexWVrJwe
         xTwQXRPW+Mv3rDR4I7wTLWeGUQpFmSojQTrSpQvi62Uuius77482+9AYmlN10dDTlnkl
         jiWg==
X-Gm-Message-State: AA+aEWbNsXBT7/EJaD3sy30K5+FHts7BX0Lu9oglF1ugMb2vKiJtSupC
        8tKc+WQe0T7P2WiTSx6X3RZTAQ==
X-Google-Smtp-Source: AFSGD/X7Bznh3Vicc2Q+qLcE2v5h7QotNBniPTtmkBOsQ74wD87z8OYIoCbdWj2Fkx5ewufEF9QOXw==
X-Received: by 2002:a62:62c5:: with SMTP id w188mr20940229pfb.160.1543941945533;
        Tue, 04 Dec 2018 08:45:45 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 64sm21537487pff.101.2018.12.04.08.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:45:45 -0800 (PST)
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
In-Reply-To: <20181201005254.139908-4-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
References: <20181201005254.139908-1-mka@chromium.org>
 <20181201005254.139908-4-mka@chromium.org>
Message-ID: <154394194432.88331.17922799670031357358@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/8] drm/msm/dsi: 28nm PHY: Get ref clock from the DT
Date:   Tue, 04 Dec 2018 08:45:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-30 16:52:49)
> diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c b/drivers/gpu/drm=
/msm/dsi/pll/dsi_pll_28nm.c
> index 26e3a01a99c2b..4a84c69ca0b2b 100644
> --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
> +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
> @@ -81,6 +81,7 @@ struct dsi_pll_28nm {
>         struct platform_device *pdev;
>         void __iomem *mmio;
>  =

> +       const char *vco_ref_clk_name;
>         int vco_delay;
>  =

>         /* private clocks: */
> @@ -265,7 +268,8 @@ static unsigned long dsi_pll_28nm_clk_recalc_rate(str=
uct clk_hw *hw,
>         void __iomem *base =3D pll_28nm->mmio;
>         u32 sdm0, doubler, sdm_byp_div;
>         u32 sdm_dc_off, sdm_freq_seed, sdm2, sdm3;
> -       u32 ref_clk =3D VCO_REF_CLK_RATE;
> +       u32 ref_clk =3D parent_rate ?
> +               parent_rate : VCO_REF_CLK_DEFAULT_RATE;

Same comments apply here.

>         unsigned long vco_rate;
>  =

>         VERB("parent_rate=3D%lu", parent_rate);
