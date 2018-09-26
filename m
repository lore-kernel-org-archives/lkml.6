Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AA9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6843521536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0t0YtRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6843521536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeI0GEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:04:43 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39302 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbeI0GEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:04:42 -0400
Received: by mail-it1-f195.google.com with SMTP id w200-v6so5334795itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CLld1rv8BxinoCypvaa2Sac3jYj/SygRrqYi2yOask8=;
        b=R0t0YtRyajbcQVb9HDutvwb62kQE7LqyWMiz6giMhUKM+aSwQCfTI7cfHM57MstuKd
         xryIe6La4KRkylMr1gq0s4QwOvxRUgUNep0kZ5mj9YEBLgosCNNmO7DwIB/9K4403ylu
         CHpQYOuLwkKSm2Q/+juq6uH69ZJtWHtukrVT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CLld1rv8BxinoCypvaa2Sac3jYj/SygRrqYi2yOask8=;
        b=cz9+hFkImzxq9IdKZfCBbwOvRs56E6tV90g1bWA7pJ6+/LpjzQ9y+5yfUSEVHYLVCU
         dE7gQXk9Ag/6vLx07gLXKNmA7DLTBejmczHSSb3ChvGrDO0FBgNu2X/NgEMJz5yvH2zQ
         hlYGDrvQ4T6L+Q7iC3rWm9alJQgrO4u53GahnnZEgIzQ7xqgCLdbhL4PJ2tHT8KdbjIl
         Jsk/SgIn+A4h4m3IIpRtkFgf10ybb9XDQfbPH7lwysR9MXl/caclhCBYkKDcM7vRoEE4
         VjBupR4zveJAjXWxZ1juspWTVwyekM8EbNRCtyXCVZwhaYwtHoBSNEKpqK5HnpLSirY6
         1Xig==
X-Gm-Message-State: ABuFfogUm8tLqcbOlhh2dwbTxwBpS9TUc36lBEspULDtL1QBJlNTl1bN
        u1/NJxG1PEsvHeordBT8J3bmNvzY/n77Wy7ff2lKNA==
X-Google-Smtp-Source: ACcGV63Lngr4PKQiRH49GdWaCM02nw+U0FZBhtTGnSHrYX8ckZ5wEnmpjRp9Q+q7d1j0aNpXRsqFDOYqRqbsdsY7ekg=
X-Received: by 2002:a24:7383:: with SMTP id y125-v6mr7024740itb.146.1538005758833;
 Wed, 26 Sep 2018 16:49:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 16:48:38
 -0700 (PDT)
In-Reply-To: <20180924085632.448693-1-lkundrak@v3.sk>
References: <20180924085632.448693-1-lkundrak@v3.sk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Sep 2018 01:48:38 +0200
Message-ID: <CAPDyKFqOWu=uQWteB02bG2y3zCyQ2B1zGE+7nKyCn47O-30-hQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Allow building PWRSEQ_SD8787 with LIBERTAS_SDIO
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 September 2018 at 10:56, Lubomir Rintel <lkundrak@v3.sk> wrote:
> The sd8686 "libertas" SDIO adapter's power is controlled with WLAN_RST
> and WLAN_PD pins -- pretty much the same way as sd8787. Allow building
> the power sequencing driver along with the libertas Wi-Fi driver.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index 42e89060cd41..2f38a7ad07e0 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -14,7 +14,7 @@ config PWRSEQ_EMMC
>
>  config PWRSEQ_SD8787
>         tristate "HW reset support for SD8787 BT + Wifi module"
> -       depends on OF && (MWIFIEX || BT_MRVL_SDIO)
> +       depends on OF && (MWIFIEX || BT_MRVL_SDIO || LIBERTAS_SDIO)
>         help
>           This selects hardware reset support for the SD8787 BT + Wifi
>           module. By default this option is set to n.
> --
> 2.19.0
>
