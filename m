Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B69ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DB1208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMUPOWg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DB1208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbeGPKiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:07 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34212 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbeGPKiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:06 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so37281354ioj.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IjNNlyuma/ODdInN8NdA/DfopR03FbEjTSacH9rTx4Q=;
        b=XMUPOWg+Xm/8whsLtGQMpTabUbv11+uIQ21dncke2Eh2SoEh5G9cRgT5nurWup09e/
         qnbXEOQUMgw+50eOCHg81wyp6yBG2wB2LMTFxRTeZ1zktgEAoB+ZDPLumoNl3vlpSw4H
         f2gygv20jQvzk5+LQ4k3S43tW/TYqMcB75O8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IjNNlyuma/ODdInN8NdA/DfopR03FbEjTSacH9rTx4Q=;
        b=AkkVkEmAo9FkaZ4/UTjbiAe36iAuYJEYMQcQUbVdhXRAcaRGR0ZraCVZl86F8tsr3E
         R5DNTctR+0I4Idx0I5iR6kGs/kF0eQi8N0HY/27dP4EWY8cXoLigfzCA+kDDptXBQEyp
         bZoRr5g7jL+Hn00ESnMU4VESwUBIT0ABWRYu5kXM30eiGxrNmul86cjxncXxhx8+iorB
         dvnyc2wL3He1eg6g/dTjcFaC4dwEPPDR4+mopOsgJ9jLZ0dlvx5QArYp4b8gxgX0u9kq
         euaM4vAzRyrbnU7Pb4bv6P5qW9YJ06CWTTe6xErHHlbvlRRUYqzRmFxgyZW653aWvJNX
         wOCg==
X-Gm-Message-State: AOUpUlFMy1CfMJQuLYxKp1DBbyKSOCCobeSNfEVJzeA6l7SGSG16kzXt
        GjwfQXcY2mjEPP7MFIkBaANcAahGpVPpimVn/lICvQ==
X-Google-Smtp-Source: AAOMgpc0gtjlegnDSV0bHijLD741yXX9VEE8aHbkjEigFXIybiE4FofhouGFJL84nWPUge0iQ07w31JVstLwji9b/Mg=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr40392578iof.266.1531735885275;
 Mon, 16 Jul 2018 03:11:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:11:24
 -0700 (PDT)
In-Reply-To: <20180712080725.14250-2-stefan@agner.ch>
References: <20180712080725.14250-1-stefan@agner.ch> <20180712080725.14250-2-stefan@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jul 2018 12:11:24 +0200
Message-ID: <CAPDyKFqyQ_6NQmaw2rTGEO6eR5GfFAf2aTqsJZVbU5MW49WN0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-esdhc-imx: fix indent
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 July 2018 at 10:07, Stefan Agner <stefan@agner.ch> wrote:
> Fix indent. This also makes disable/enable clock blocks look
> alike.
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
> index acacd8481473..aa48f4b2541a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -761,7 +761,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>         if (esdhc_is_usdhc(imx_data)) {
>                 val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>                 writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -               host->ioaddr + ESDHC_VENDOR_SPEC);
> +                       host->ioaddr + ESDHC_VENDOR_SPEC);
>         }
>
>         mdelay(1);
> --
> 2.18.0
>
