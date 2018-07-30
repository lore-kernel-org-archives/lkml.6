Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC8AFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B48620870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B48620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeG3J5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:57:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16499 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeG3J5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:57:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5ecae90000>; Mon, 30 Jul 2018 01:23:05 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Jul 2018 01:23:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Jul 2018 01:23:17 -0700
Received: from [10.21.132.122] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 30 Jul
 2018 08:23:15 +0000
Subject: Re: [PATCH] ASoC: tegra_alc5632: fix device_node refcounting
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ldv-project@linuxtesting.org>
References: <1532725619-8775-1-git-send-email-khoroshilov@ispras.ru>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8a58db40-13c8-eaf1-85a0-bf6da8224997@nvidia.com>
Date:   Mon, 30 Jul 2018 09:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532725619-8775-1-git-send-email-khoroshilov@ispras.ru>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/07/18 22:06, Alexey Khoroshilov wrote:
> tegra_alc5632_probe() increments reference count of device nodes
> with of_parse_phandle(), but there is no code decrementing them
> in the driver.
> 
> The patch adds of_node_put() to tegra_alc5632_remove() and
> to error handling paths in the probe.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  sound/soc/tegra/tegra_alc5632.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
> index 5197d6b18cb6..98d87801d57a 100644
> --- a/sound/soc/tegra/tegra_alc5632.c
> +++ b/sound/soc/tegra/tegra_alc5632.c
> @@ -190,14 +190,14 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev,
>  			"Property 'nvidia,i2s-controller' missing or invalid\n");
>  		ret = -EINVAL;
> -		goto err;
> +		goto err_put_codec_of_node;
>  	}
>  
>  	tegra_alc5632_dai.platform_of_node = tegra_alc5632_dai.cpu_of_node;
>  
>  	ret = tegra_asoc_utils_init(&alc5632->util_data, &pdev->dev);
>  	if (ret)
> -		goto err;
> +		goto err_put_cpu_of_node;
>  
>  	ret = snd_soc_register_card(card);
>  	if (ret) {
> @@ -210,6 +210,13 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
>  
>  err_fini_utils:
>  	tegra_asoc_utils_fini(&alc5632->util_data);
> +err_put_cpu_of_node:
> +	of_node_put(tegra_alc5632_dai.cpu_of_node);
> +	tegra_alc5632_dai.cpu_of_node = NULL;
> +	tegra_alc5632_dai.platform_of_node = NULL;
> +err_put_codec_of_node:
> +	of_node_put(tegra_alc5632_dai.codec_of_node);
> +	tegra_alc5632_dai.codec_of_node = NULL;
>  err:
>  	return ret;
>  }
> @@ -223,6 +230,12 @@ static int tegra_alc5632_remove(struct platform_device *pdev)
>  
>  	tegra_asoc_utils_fini(&machine->util_data);
>  
> +	of_node_put(tegra_alc5632_dai.cpu_of_node);
> +	tegra_alc5632_dai.cpu_of_node = NULL;
> +	tegra_alc5632_dai.platform_of_node = NULL;
> +	of_node_put(tegra_alc5632_dai.codec_of_node);
> +	tegra_alc5632_dai.codec_of_node = NULL;
> +
>  	return 0;
>  }

Thanks!

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
