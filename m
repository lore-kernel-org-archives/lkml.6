Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1722BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1537214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="PPYgGdB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1537214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbeHBNWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:22:19 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49288 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbeHBNWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:22:19 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id BF8C45C08AE;
        Thu,  2 Aug 2018 13:31:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533209492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZSBUeD+CS+p5XaryCa+J//p6fEF2SQJ9s4ukuXLGQw=;
        b=PPYgGdB/NVttiZ2DNbqFQE8Wf0owU6z/VuONKBoKhr6/SpWL5WMKKUZ1KZZNnWQryxjNRS
        dZhH51lROdeOMugOqQ7RMilwcTMz3YZV47BT4b6s5pVtbR3N823ilNCeADUiocfeWl4N+v
        UcqvQp0j7W0swlYCjekOLURHpcmXY6g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Aug 2018 13:31:32 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] pinctrl: tegra: Move drivers registration to
 arch_init level
In-Reply-To: <20180802111144.12512-1-digetx@gmail.com>
References: <20180802111144.12512-1-digetx@gmail.com>
Message-ID: <20a52a0461e32e776e526171c250551a@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.2018 13:11, Dmitry Osipenko wrote:
> There is a bug in regards to deferred probing within the drivers core
> that causes GPIO-driver to suspend after its users. The bug appears if
> GPIO-driver probe is getting deferred, which happens after introducing
> dependency on PINCTRL-driver for the GPIO-driver by defining "gpio-ranges"
> property in device-tree. The bug in the drivers core is old (more than 4
> years now) and is well known, unfortunately there is no easy fix for it.
> The good news is that we can workaround the deferred probe issue by
> changing GPIO / PINCTRL drivers registration order and hence by moving
> PINCTRL driver registration to the arch_init level and GPIO to the
> subsys_init.

A while back at least using those init lists were not well received even
for GPIO/pinctrl drivers:

https://lore.kernel.org/lkml/CACRpkdYk0zW12qNXgOstTLmdVDYacu0Un+8quTN+J_azOic7AA@mail.gmail.com/T/#mf0596982324a6489b5537b0531ac5aed60a316ba

I still think we should make an exception for GPIO/pinctrl and use
earlier initcalls. Platform GPIO/pinctrl drivers provide basic
infrastructure often used by many other drivers, we want to have them
loaded early. It avoids unnecessary EPROBE_DEFER and hence probably even
boots faster.

And in this case it even resolves real world issues.

This should definitely go in, at least as a stop gap solution.

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan


> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra114.c | 7 ++++++-
>  drivers/pinctrl/tegra/pinctrl-tegra124.c | 7 ++++++-
>  drivers/pinctrl/tegra/pinctrl-tegra20.c  | 7 ++++++-
>  drivers/pinctrl/tegra/pinctrl-tegra210.c | 7 ++++++-
>  drivers/pinctrl/tegra/pinctrl-tegra30.c  | 7 ++++++-
>  5 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra114.c
> b/drivers/pinctrl/tegra/pinctrl-tegra114.c
> index 511a8774fd8d..d43c209e9c30 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra114.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra114.c
> @@ -1868,4 +1868,9 @@ static struct platform_driver tegra114_pinctrl_driver = {
>  	},
>  	.probe = tegra114_pinctrl_probe,
>  };
> -builtin_platform_driver(tegra114_pinctrl_driver);
> +
> +static int __init tegra114_pinctrl_init(void)
> +{
> +	return platform_driver_register(&tegra114_pinctrl_driver);
> +}
> +arch_initcall(tegra114_pinctrl_init);
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra124.c
> b/drivers/pinctrl/tegra/pinctrl-tegra124.c
> index 57e3cdcf4503..5b07a5834d15 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra124.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra124.c
> @@ -2080,4 +2080,9 @@ static struct platform_driver tegra124_pinctrl_driver = {
>  	},
>  	.probe = tegra124_pinctrl_probe,
>  };
> -builtin_platform_driver(tegra124_pinctrl_driver);
> +
> +static int __init tegra124_pinctrl_init(void)
> +{
> +	return platform_driver_register(&tegra124_pinctrl_driver);
> +}
> +arch_initcall(tegra124_pinctrl_init);
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c
> b/drivers/pinctrl/tegra/pinctrl-tegra20.c
> index 624889ed3a9d..1fc82a9576e0 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
> @@ -2277,4 +2277,9 @@ static struct platform_driver tegra20_pinctrl_driver = {
>  	},
>  	.probe = tegra20_pinctrl_probe,
>  };
> -builtin_platform_driver(tegra20_pinctrl_driver);
> +
> +static int __init tegra20_pinctrl_init(void)
> +{
> +	return platform_driver_register(&tegra20_pinctrl_driver);
> +}
> +arch_initcall(tegra20_pinctrl_init);
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra210.c
> b/drivers/pinctrl/tegra/pinctrl-tegra210.c
> index 0956a1c73391..3e77f5474dd8 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra210.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra210.c
> @@ -1582,4 +1582,9 @@ static struct platform_driver tegra210_pinctrl_driver = {
>  	},
>  	.probe = tegra210_pinctrl_probe,
>  };
> -builtin_platform_driver(tegra210_pinctrl_driver);
> +
> +static int __init tegra210_pinctrl_init(void)
> +{
> +	return platform_driver_register(&tegra210_pinctrl_driver);
> +}
> +arch_initcall(tegra210_pinctrl_init);
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra30.c
> b/drivers/pinctrl/tegra/pinctrl-tegra30.c
> index c923ad58af84..10e617003e9c 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra30.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra30.c
> @@ -2503,4 +2503,9 @@ static struct platform_driver tegra30_pinctrl_driver = {
>  	},
>  	.probe = tegra30_pinctrl_probe,
>  };
> -builtin_platform_driver(tegra30_pinctrl_driver);
> +
> +static int __init tegra30_pinctrl_init(void)
> +{
> +	return platform_driver_register(&tegra30_pinctrl_driver);
> +}
> +arch_initcall(tegra30_pinctrl_init);
