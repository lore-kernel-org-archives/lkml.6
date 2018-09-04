Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA172C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5742077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSDvyygH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5742077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeIDTAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:00:19 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34501 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeIDTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:00:19 -0400
Received: by mail-io0-f194.google.com with SMTP id c22-v6so3166251iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mAfXPWJj1UTwCM4kFsE7kUy0wMknaAdrxlndYEeLnPk=;
        b=TSDvyygHh+jexW0OmUbbsQt6pgpDvhqjj/UQp8wPwG6vJBWxZBYC8oVsrkaUtQyIDe
         7UIx2y/ad0XHS6Jk8/3+pPx7B9eX3XWa4G5BV5Mks1cJpO/BDnY/TNJ+iRqlQqjq6hdM
         8zUyw7D80c8lZ6Y/6khuesIOSTVAtn6AwQTcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mAfXPWJj1UTwCM4kFsE7kUy0wMknaAdrxlndYEeLnPk=;
        b=BTC7zhgOkF6oatrXgyl02+Vt9nmcilQ6JLkxNacpOAQZRiDK0KzOcT+lRXuih/BLdX
         i8AHXMnlTRNBcEZVckzmh91BcLVwxg5chG3gCR3x2e/iEUZH37WGYRCetTqf0Y4FBCBp
         bZyhhYjO8zvgDjNBYmxsbus+7/rLBFt2k9eFn/03U3unSjdf1rP8akGzmsILZ5TlviAy
         gIe6yTN4HOcjcvqa5BUdBc7cZohHkN4acCO+b2r3v9hpepcA8tiyp81iJkK8/EtHeZzc
         EozdrknCwSXWUv25qVMnS7ZO/DG8D8zUEij/CiKxnGVvFcXDqdtrU90+pM5Ac54TQaFB
         6l/Q==
X-Gm-Message-State: APzg51DqfjucYt+sgzEbwsBZFsuBbydeWgeDKV3fLEJwP3WV0ZwYp5wy
        7oIo6HQfbETPxSE7HVSdb24NyI7WnxxibwVwrMB5mw==
X-Google-Smtp-Source: ANB0VdYXNypffk8EUZUwODbWkg5NsNaPb/hoD2huEof0Vrh3qTIWmgGr4o4co0F28yxy26kg2xKqtNHjoh3wTaMDyj4=
X-Received: by 2002:a6b:3a0b:: with SMTP id h11-v6mr22305117ioa.278.1536071697446;
 Tue, 04 Sep 2018 07:34:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1bd8:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 07:34:56 -0700 (PDT)
In-Reply-To: <20180902073058.17053-1-andreas@kemnade.info>
References: <20180902073058.17053-1-andreas@kemnade.info>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Sep 2018 16:34:56 +0200
Message-ID: <CAPDyKFpHPre_turpYtpB+N+LHR+EMW2p2GJ92J1zu8h6p5W=LQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix wakeirq handling on removal
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Kishon <kishon@ti.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 September 2018 at 09:30, Andreas Kemnade <andreas@kemnade.info> wrote:
> after unbinding mmc I get things like this:
> [  185.294067] mmc1: card 0001 removed
> [  185.305206] omap_hsmmc 480b4000.mmc: wake IRQ with no resume: -13
>
> The wakeirq stays in /proc-interrupts
>
> rebinding shows this:
> [  289.795959] genirq: Flags mismatch irq 112. 0000200a (480b4000.mmc:wakeup) vs. 0000200a (480b4000.mmc:wakeup)
> [  289.808959] omap_hsmmc 480b4000.mmc: Unable to request wake IRQ
> [  289.815338] omap_hsmmc 480b4000.mmc: no SDIO IRQ support, falling back to polling
>
> That bug seems to be introduced by switching from devm_request_irq()
> to generic wakeirq handling.
>
> So let us cleanup at removal.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Fixes: 5b83b2234be6 ("mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq")

Applied for fixes, and added a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/omap_hsmmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 071693ebfe18..68760d4a5d3d 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2177,6 +2177,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
>         dma_release_channel(host->tx_chan);
>         dma_release_channel(host->rx_chan);
>
> +       dev_pm_clear_wake_irq(host->dev);
>         pm_runtime_dont_use_autosuspend(host->dev);
>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
> --
> 2.11.0
>
