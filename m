Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EBAECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD262214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rXzS6psd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD262214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeJQSxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:53:11 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4544 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeJQSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:53:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc715b50000>; Wed, 17 Oct 2018 03:57:57 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 17 Oct 2018 03:58:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 17 Oct 2018 03:58:00 -0700
Received: from [10.26.11.110] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 10:57:56 +0000
Subject: Re: [PATCH v2 8/9] ASoC: tegra_sgtl5000: fix device_node refcounting
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        <alsa-devel@alsa-project.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
 <20181016104730.4598-9-marcel@ziswiler.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <af707410-9954-b1a1-6d9b-5ad085604446@nvidia.com>
Date:   Wed, 17 Oct 2018 11:57:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181016104730.4598-9-marcel@ziswiler.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539773877; bh=hQuU0Wyvxg2PFTdqbUFfXN9F1upsQ8uRJKdrH8lH9Rw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rXzS6psd0nPOAX9JvziYTgEw9Z/gJXXEleyVpTxJ3WSzbjnnkUg0p4B49BU+u9Ctg
         AAZIi3RMW3GpY93Q9JbGASK+CkzsO1v6SwC82f6XEWikzUOgxHcVVPZ3D/SsuWzzlt
         NT8EcFxtpfWi5xza8S/aoO+kbiBuPVsg/h+VphM99M/n7X1RDS2WH5an9BOw1mvrR6
         2Ix1hqFkmMGoyyJstvGn/iBURsI918HSGr8c04b5ZRgjej4rwywt2SA6Vi5Fr58y2X
         q6b81MNyTZFb6nrTL04v1Dm4IylFy01ax8THHlNlVgOl9Qb4SCbVH0vgxMqDxVQtHL
         8oDTQQ93NLm1g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/10/2018 11:47, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Similar to the following:
> 
> commit 4321723648b0 ("ASoC: tegra_alc5632: fix device_node refcounting")
> 
> commit 7c5dfd549617 ("ASoC: tegra: fix device_node refcounting")
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2: New patch
> 
>  sound/soc/tegra/tegra_sgtl5000.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra_sgtl5000.c b/sound/soc/tegra/tegra_sgtl5000.c
> index 45a4aa9d2a47..901457da25ec 100644
> --- a/sound/soc/tegra/tegra_sgtl5000.c
> +++ b/sound/soc/tegra/tegra_sgtl5000.c
> @@ -149,14 +149,14 @@ static int tegra_sgtl5000_driver_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev,
>  			"Property 'nvidia,i2s-controller' missing/invalid\n");
>  		ret = -EINVAL;
> -		goto err;
> +		goto err_put_codec_of_node;
>  	}
>  
>  	tegra_sgtl5000_dai.platform_of_node = tegra_sgtl5000_dai.cpu_of_node;
>  
>  	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
>  	if (ret)
> -		goto err;
> +		goto err_put_cpu_of_node;
>  
>  	ret = snd_soc_register_card(card);
>  	if (ret) {
> @@ -169,6 +169,13 @@ static int tegra_sgtl5000_driver_probe(struct platform_device *pdev)
>  
>  err_fini_utils:
>  	tegra_asoc_utils_fini(&machine->util_data);
> +err_put_cpu_of_node:
> +	of_node_put(tegra_sgtl5000_dai.cpu_of_node);
> +	tegra_sgtl5000_dai.cpu_of_node = NULL;
> +	tegra_sgtl5000_dai.platform_of_node = NULL;
> +err_put_codec_of_node:
> +	of_node_put(tegra_sgtl5000_dai.codec_of_node);
> +	tegra_sgtl5000_dai.codec_of_node = NULL;
>  err:
>  	return ret;
>  }
> @@ -183,6 +190,12 @@ static int tegra_sgtl5000_driver_remove(struct platform_device *pdev)
>  
>  	tegra_asoc_utils_fini(&machine->util_data);
>  
> +	of_node_put(tegra_sgtl5000_dai.cpu_of_node);
> +	tegra_sgtl5000_dai.cpu_of_node = NULL;
> +	tegra_sgtl5000_dai.platform_of_node = NULL;
> +	of_node_put(tegra_sgtl5000_dai.codec_of_node);
> +	tegra_sgtl5000_dai.codec_of_node = NULL;
> +
>  	return ret;
>  }
>  

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
