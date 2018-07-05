Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA932C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523A224137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMaS8AL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523A224137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754774AbeGENKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:10:10 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38993 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754076AbeGENKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:10:03 -0400
Received: by mail-it0-f65.google.com with SMTP id p185-v6so12232414itp.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qLRaTtD+L6bvRxHv/4//r5dqxO0LKO0+erwkt/nsdVc=;
        b=LMaS8AL7M2/OMGh+OzXRjG2EPwT2OcjwE9eaZavsyjuCyiy8euspwqbJIJQli+BVP8
         5qOh95ukmqYHhXHScubDg6CMZTYurJEIig8sHvrd5jYPaYbNqSDlD7fuyPiJc3235tvS
         XDC0L2bqh7YaYV9y5CaQYGWEIubBbuixVISVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qLRaTtD+L6bvRxHv/4//r5dqxO0LKO0+erwkt/nsdVc=;
        b=ZVbSDaW2eMSiauAcyPbiBaBvkNimuv6DaFr09UhqyUSKQA7kHj1/ODM5I31RgBxRuN
         OZCpJ313/j33HAdOKm0p7LCmhqvk6kQni618LDaGZmbfOemVKP4ibNcmHO6y0DKIeQwV
         d7kF2hqsKi2GjQkMaA9oIlfEZnVKj8JugBaCoUDoA01T1uNpUKkJTe5rQm5K1Ja8zP4+
         KNKrkuwyM3IAWL/gqbLrrLINyEo21E6VtyBtfMZVKTc0r7hQjP8vrNy9geBef6LQTzMc
         ALoLNw126CvIujHU1o5I0o1zjqX5PVwfhyfLpgW3T+veqxLe/YQEHp21XAa50lHnHV1f
         MosQ==
X-Gm-Message-State: APt69E3zJ16aLOsbzstWkyhG0MYnPurdhdj5tx3jpEwcLHWjaBf3OIk9
        l1YExBtPxDC/HPIovCtqTaObHRH8XUFbsyARx9iI1A==
X-Google-Smtp-Source: AAOMgpeOwNgr7evkTLm4tngXIybEoX+vwQQpGlYPN6QuXOH2HnCEVQNeF1vR0lBX6tQc7GUOgYdJFkYn5kBkMnwXwIk=
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr4799543jad.107.1530796202740;
 Thu, 05 Jul 2018 06:10:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:10:02 -0700 (PDT)
In-Reply-To: <20180704150745.21003-1-stefan@agner.ch>
References: <20180704150745.21003-1-stefan@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 15:10:02 +0200
Message-ID: <CAPDyKFou773HgPzE29Ynr2MVFcaOhb=+uXBrjL+1H8iWx4jdQw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 July 2018 at 17:07, Stefan Agner <stefan@agner.ch> wrote:
> If pinctrl nodes for 100/200MHz are missing, the controller should
> not select any mode which need signal frequencies 100MHz or higher.
> To prevent such speed modes the driver currently uses the quirk flag
> SDHCI_QUIRK2_NO_1_8_V. This works nicely for SD cards since 1.8V
> signaling is required for all faster modes and slower modes use 3.3V
> signaling only.
>
> However, there are eMMC modes which use 1.8V signaling and run below
> 100MHz, e.g. DDR52 at 1.8V. With using SDHCI_QUIRK2_NO_1_8_V this
> mode is prevented. When using a fixed 1.8V regulator as vqmmc-supply
> the stack has no valid mode to use. In this tenuous situation the
> kernel continuously prints voltage switching errors:
>   mmc1: Switching to 3.3V signalling voltage failed
>
> Avoid using SDHCI_QUIRK2_NO_1_8_V and prevent faster modes by
> altering the SDHCI capability register. With that the stack is able
> to select 1.8V modes even if no faster pinctrl states are available:
>   # cat /sys/kernel/debug/mmc1/ios
>   ...
>   timing spec:    8 (mmc DDR52)
>   signal voltage: 1 (1.80 V)
>   ...
>
> Link: http://lkml.kernel.org/r/20180628081331.13051-1-stefan@agner.ch
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied for next! Let's see if this turns out okay, then let's
make it a fix and add a stable tag.

BTW, would you mind looking up the commit it fixes? Or if there is a
certain stable release we should target.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 20a420b765b3..e96d969ab2c3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -312,6 +312,15 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>
>                         if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
>                                 val |= SDHCI_SUPPORT_HS400;
> +
> +                       /*
> +                        * Do not advertise faster UHS modes if there are no
> +                        * pinctrl states for 100MHz/200MHz.
> +                        */
> +                       if (IS_ERR_OR_NULL(imx_data->pins_100mhz) ||
> +                           IS_ERR_OR_NULL(imx_data->pins_200mhz))
> +                               val &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50
> +                                        | SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_HS400);
>                 }
>         }
>
> @@ -1157,18 +1166,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>                                                 ESDHC_PINCTRL_STATE_100MHZ);
>                 imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
>                                                 ESDHC_PINCTRL_STATE_200MHZ);
> -               if (IS_ERR(imx_data->pins_100mhz) ||
> -                               IS_ERR(imx_data->pins_200mhz)) {
> -                       dev_warn(mmc_dev(host->mmc),
> -                               "could not get ultra high speed state, work on normal mode\n");
> -                       /*
> -                        * fall back to not supporting uhs by specifying no
> -                        * 1.8v quirk
> -                        */
> -                       host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> -               }
> -       } else {
> -               host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>         }
>
>         /* call to generic mmc_of_parse to support additional capabilities */
> --
> 2.18.0
>
