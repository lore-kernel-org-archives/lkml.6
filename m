Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AF2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E311D21486
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E311D21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeHOSzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:55:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18672 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbeHOSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:55:25 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b744e900000>; Wed, 15 Aug 2018 09:02:24 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Aug 2018 09:02:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 Aug 2018 09:02:32 -0700
Received: from [10.2.166.219] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 15 Aug
 2018 16:02:40 +0000
Subject: Re: [PATCH v2] ASoC: tegra: probe deferral error reporting
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>
CC:     Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20180814140145.12212-1-marcel@ziswiler.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <930b05df-c502-192e-3cb9-9e1874701cce@nvidia.com>
Date:   Wed, 15 Aug 2018 17:02:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814140145.12212-1-marcel@ziswiler.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/08/18 15:01, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Actually report the error codes from of_get_named_gpio() resp.
> devm_gpio_request_one() upon trying to get the codec reset resp. sync
> GPIOs unless it is just a probe deferral.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Silence probe deferral as suggested by Stefan.
> - Fix line over 80 characters as reported by checkpatch.
> 
>  sound/soc/tegra/tegra20_ac97.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
> index 682ef33afb5f..2ac6b2d73980 100644
> --- a/sound/soc/tegra/tegra20_ac97.c
> +++ b/sound/soc/tegra/tegra20_ac97.c
> @@ -351,18 +351,31 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
>  		ret = devm_gpio_request_one(&pdev->dev, ac97->reset_gpio,
>  					    GPIOF_OUT_INIT_HIGH, "codec-reset");
>  		if (ret) {
> -			dev_err(&pdev->dev, "could not get codec-reset GPIO\n");
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(&pdev->dev,
> +					"could not get codec-reset GPIO: %d\n",
> +					ret);
> +
>  			goto err_clk_put;
>  		}
>  	} else {
> -		dev_err(&pdev->dev, "no codec-reset GPIO supplied\n");
> +		ret = ac97->reset_gpio;
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev,
> +				"no codec-reset GPIO supplied: %d\n",
> +				ret);
> +
>  		goto err_clk_put;
>  	}
>  
>  	ac97->sync_gpio = of_get_named_gpio(pdev->dev.of_node,
>  					    "nvidia,codec-sync-gpio", 0);
>  	if (!gpio_is_valid(ac97->sync_gpio)) {
> -		dev_err(&pdev->dev, "no codec-sync GPIO supplied\n");
> +		ret = ac97->sync_gpio;
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "no codec-sync GPIO supplied: %d\n",
> +				ret);
> +
>  		goto err_clk_put;
>  	}

Thanks, looks good to me. However, I wonder why we don't request the
'sync_gpio' in the probe like we do for the reset? Otherwise ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
