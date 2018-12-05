Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33E9C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980422083F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9x34NV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980422083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeLEOYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:24:30 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44329 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeLEOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:24:29 -0500
Received: by mail-ua1-f68.google.com with SMTP id d19so7140642uaq.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vU+1DymT0hEbhZE+aC5foMQklWH3FSZCCg/zl0KH5/o=;
        b=f9x34NV+1XndHnc3GjC/kpOcNdD147sghGSZiyTkpxwClkvi9brq8hjb+HIQybVc51
         cSBb3w+ooGhaCKYkqsCMXHJ4YD2QsSZyZGijksAht1Vyh518QA2p0YqJ2dkUSh4GlDth
         tLCQKEADc2AlhXfjalidDimT1VP7q2IzwdXJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vU+1DymT0hEbhZE+aC5foMQklWH3FSZCCg/zl0KH5/o=;
        b=LQFFl2VFk4z8C0T4NhMwROarS+uzkfXp1/dDnLyQvjYxJLBau3EY59d4B/YazcTKBh
         bwElmei5+Ml8wF8FfQuVs/XmrgOxK1w1p7owFOjOwDDwHPwLJQysEDW2mWobryhXIZMq
         16a9RZ5wrJDc1E8AgQcJJpmanVnRQerL8hTjUIChY33PQub3XM3J5yNikbTmtnvIj0wB
         UnxbpAT7dl/cwmDry2Mk3I7ZpH5ufu4xO9FguIekbegf1p02sK+p+V9Uafo9yYDQtgId
         fLadtcKStX3Pc/GxnIfIMUZT5sUqKG6acjjTxq8labr5vkWzPoLEg+3eGaoFlMDcxFcI
         1QHg==
X-Gm-Message-State: AA+aEWbK3fjSh7e0HdjAZocS6f17znYyUsYnfnQTUqOeW43JG05jSA4r
        ilYo8wSwjr+79t3BA0zDuHgm+PRl9LPi9YJnCQsLCYhB
X-Google-Smtp-Source: AFSGD/UAcGwOxBo05xwx2+fT13TPm66Iy+FPvgInC1AkScYYfUq8QMqv/baih8Nvh+jjXKVBTnbvQOoYJ+rdYh+vkEk=
X-Received: by 2002:ab0:526:: with SMTP id 35mr11276901uax.25.1544019867917;
 Wed, 05 Dec 2018 06:24:27 -0800 (PST)
MIME-Version: 1.0
References: <1542879319-2196-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542879319-2196-1-git-send-email-hofrat@osadl.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Dec 2018 15:23:52 +0100
Message-ID: <CAPDyKFpWevQkGncmeJjnsusTBWOc6xecUGsP_8oUMeAwwF4D7Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdio: check devm_kasprintf for failure
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 at 10:40, Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignments to  init.name  are not safe if not checked. On error
> meson_mx_mmc_register_clks() returns negative values so -ENOMEM in the
> (unlikely) failure case of devm_kasprintf() should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")

Applied for next, thanks!

Kind regards
Uffe

> ---
>
> Problem located with an experimental coccinelle script
>
> Patch was compile tested with: multi_v7_defconfig (implies ARCH_MESON=y &
> MMC_MESON_MX_SDIO=y)
>
> Patch is against 4.20-rc3 (localversion-next is next-20181122)
>
>  drivers/mmc/host/meson-mx-sdio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index abe253c..ec980bd 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -596,6 +596,9 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
>         init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
>                                    "%s#fixed_factor",
>                                    dev_name(host->controller_dev));
> +       if (!init.name)
> +               return -ENOMEM;
> +
>         init.ops = &clk_fixed_factor_ops;
>         init.flags = 0;
>         init.parent_names = &clk_fixed_factor_parent;
> @@ -612,6 +615,9 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
>         clk_div_parent = __clk_get_name(host->fixed_factor_clk);
>         init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
>                                    "%s#div", dev_name(host->controller_dev));
> +       if (!init.name)
> +               return -ENOMEM;
> +
>         init.ops = &clk_divider_ops;
>         init.flags = CLK_SET_RATE_PARENT;
>         init.parent_names = &clk_div_parent;
> --
> 2.1.4
>
