Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7FDC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B47245F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IhqJskFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B47245F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeGBOgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:36:33 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35534 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeGBOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:36:31 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so14924811iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j0MvGVmH8g7SVn2QQ2UMIsO5tidvuO+Kxdeo2xFn1mM=;
        b=IhqJskFYqBNoNQFWu75mikiO6/KZoJYyQQtRXEo3X60sn3EEX6DDkTxds0SEpaUTl0
         dEG20OrQw7WOu1w5RF/PGyTMnWQ0GJJxjCfSN/vDHhr/dWso+21gfgsaOWph2pkQ664h
         q1Wqb1O9tPQfk7j0etzscMUp7/bWEyrsQa1/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j0MvGVmH8g7SVn2QQ2UMIsO5tidvuO+Kxdeo2xFn1mM=;
        b=Ekya5gg7GrHARmuF4N1OyGJQAz61Uu4A9zVaFev1u5UW421NWLXesx0JylOai+b51R
         3F3+mTpZBXZOUI4Qy+Mb/383gxmms2q43PNOwUhiCWKQNDA156/gh88Ncrnz9s5oSIFF
         zI2pMsBSfULS1BsrZfStVWfo4uT/L86m5ET5dFz0JsWL2Qx4SiE6r61yOQvKEuQ3hbLg
         KLhCUX60gHA5KtQliez6ofDXyhXU+QBI47HRum3ZOXaAeR6wCNYmqPXDQZe51FcRmwA6
         8wXdSoxaCAFZmxFPCZFkaR0EyUtdZGotp+fgUWhRKxdupJsRQ0hAZXMXi/11qzdUE8iG
         smtw==
X-Gm-Message-State: APt69E38bZnI6VpVcK3dp/pfb7HQYNZwpwuc606LRTRspWDT+Zl1vJgJ
        AcKma28G2BQoqLvBTjCWFpl26KKbOdEV157thBwUvw==
X-Google-Smtp-Source: AAOMgpcfqMtQsaLbmHh3M7YGk534SJS5gp+5b1LU9MO1tSA/vCG+OeNBkeECMYwDfyGnT1xtsZd4HoUZeDZgqP5w82Q=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr15008584iof.266.1530542191315;
 Mon, 02 Jul 2018 07:36:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 07:36:30 -0700 (PDT)
In-Reply-To: <20180628073136.21748-1-stefan@agner.ch>
References: <20180628073136.21748-1-stefan@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jul 2018 16:36:30 +0200
Message-ID: <CAPDyKFqpyuknaYsxCw-pTNJ4XoJ+qptDerGnxBYNVnj-+s=nhw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: support eMMC DDR mode when running
 at 3.3V
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 June 2018 at 09:31, Stefan Agner <stefan@agner.ch> wrote:
> The uSDHC supports DDR modes for eMMC devices running at 3.3V. This
> allows to run eMMC with 3.3V signaling voltage at DDR52 mode:
>
>   # cat /sys/kernel/debug/mmc1/ios
>   clock:          52000000 Hz
>   vdd:            21 (3.3 ~ 3.4 V)
>   bus mode:       2 (push-pull)
>   chip select:    0 (don't care)
>   power mode:     2 (on)
>   bus width:      3 (8 bits)
>   timing spec:    8 (mmc DDR52)
>   signal voltage: 0 (3.30 V)
>   driver type:    0 (driver type B)
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index b716b933f00a..6f444731754d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1324,7 +1324,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>
>         if (esdhc_is_usdhc(imx_data)) {
>                 host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> -               host->mmc->caps |= MMC_CAP_1_8V_DDR;
> +               host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
>                 if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
>                         host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>
> --
> 2.18.0
>
