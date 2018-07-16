Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E99AECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DE7208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDxQNZJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DE7208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbeGPKiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34239 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731292AbeGPKiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:25 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so37282207ioj.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3E4IEqiA8AC59YBk2YxsVK6XczwOI0hkUk4+3CDUEa0=;
        b=ZDxQNZJn8cvaa0ss0KxhBBMMfZGWIfzDxq+mzPj0Y5Z23MLDEl7nkGCO7Vx0CGn07c
         p5yASIe6jjweexcrhPMPZOU+t+a19JTbVRvHTzha5bvQtj59Q9o1lQOsRoKMom1a9uT4
         M4dAxIt7aa7c9nvHJQEvialrey6gUzu9sLkFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3E4IEqiA8AC59YBk2YxsVK6XczwOI0hkUk4+3CDUEa0=;
        b=NlpjgmicyKc+iUDDWM19LwMYGdjDwZzizwZP8yFwz27zGwgYRYK/QN0AOw3mVtFjpA
         LG7+5RmR1qk5kUaVh1njsGsZ9nNSCjQGZXZ6zPeEOmByd+YHuen3N+i3G4LoyRi1B0OH
         3KWzsOrlsvFDk8O+p2iJMckRhwP1RqN22D19HQqIuloGanzUCdkZYWT7NcjmrxdSuoIn
         5gKlFcCsm2/bQBY7uvoxEcOEuYZFOxF6PB+5YT0uh37CxwsVs5vMIhCfcBdxyjunBSjn
         1QX51u/J3DWPnDtmLSGyxOFPL4EDjaQ8SZj08s7AfPOiPGShzk9nztOKu2JKWcIJFiMj
         sMAQ==
X-Gm-Message-State: APt69E1sgOCV65uag7XhsujGsGVW+vdplU9m1cyVn8XlqoYGQNZ+EqMO
        IlAOyGnBByZokK6IWa1oBDAMxbRhwm+RAemAWhg/dg==
X-Google-Smtp-Source: AAOMgpdHzQL8jMm5cUyfui2Id/do5KhKRiWZxrv1zL7PCc7N7MbhWdcDj4311d1DKOK1FIxepfcUV5/Mbe/fetOLRU0=
X-Received: by 2002:a6b:e403:: with SMTP id u3-v6mr37731083iog.131.1531735904331;
 Mon, 16 Jul 2018 03:11:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:11:43
 -0700 (PDT)
In-Reply-To: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
References: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jul 2018 12:11:43 +0200
Message-ID: <CAPDyKFqY31RSebKxUtiPsXFZD35aJFxerakHgjyq7gqrRCHmBA@mail.gmail.com>
Subject: Re: [PATCH] mmc: tegra: Add and use tegra_sdhci_get_max_clock()
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Stefan

On 13 July 2018 at 15:17, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Implement and use tegra_sdhci_get_max_clock() which returns the true
> maximum host clock rate. The issue with tegra_sdhci_get_max_clock() is
> that it returns the current clock rate of the host instead of the
> maximum one, which can lead to unnecessarily small clock rates.
>
> This differs from the previous implementation of
> tegra_sdhci_get_max_clock() in that it doesn't divide the result by two.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

Thanks, applied for next!

I realize there are some discussions and tests going on in regards to
the changes for tegra driver. However, I decided to apply all pending
patches from Stefan and you, to get them tested in next for a while to
see how it plays.

Please tell if you want me to drop some changes - or if you prefer to
send patches on top to fix further related issues.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 28b98e2..ddf00166 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -235,6 +235,13 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>         sdhci_set_uhs_signaling(host, timing);
>  }
>
> +static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       return clk_round_rate(pltfm_host->clk, UINT_MAX);
> +}
> +
>  static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
>  {
>         u32 reg;
> @@ -299,7 +306,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
>         .platform_execute_tuning = tegra_sdhci_execute_tuning,
>         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>         .voltage_switch = tegra_sdhci_voltage_switch,
> -       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +       .get_max_clock = tegra_sdhci_get_max_clock,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
> @@ -356,7 +363,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
>         .platform_execute_tuning = tegra_sdhci_execute_tuning,
>         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>         .voltage_switch = tegra_sdhci_voltage_switch,
> -       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +       .get_max_clock = tegra_sdhci_get_max_clock,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
> --
> 2.7.4
>
